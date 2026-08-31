"""Host-independent Bendy arc sampling with stable transported frames."""

from __future__ import annotations

from dataclasses import dataclass
from dataclasses import field
import hashlib
import json
import math
from typing import Iterable, Sequence, Tuple


Vector3 = Tuple[float, float, float]


@dataclass(frozen=True)
class BendyArcSample:
    arc_fraction: float
    curve_parameter: float
    position: Vector3
    tangent: Vector3
    normal: Vector3
    binormal: Vector3
    volume_scale: float


@dataclass(frozen=True)
class BendyArc:
    control_points: Tuple[Vector3, Vector3, Vector3, Vector3]
    chord_length: float
    arc_length: float
    stretch_ratio: float
    samples: Tuple[BendyArcSample, ...]


@dataclass(frozen=True)
class BendySculptIssue:
    code: str
    message: str
    subject_id: str = ""


@dataclass(frozen=True)
class BendySculptPlan:
    graph_id: str
    behavior_id: str
    frame: float
    previous_controls: Tuple[Vector3, Vector3]
    target_controls: Tuple[Vector3, Vector3]
    previous_volume: float
    target_volume: float
    source_positions: Tuple[Vector3, Vector3]
    observed_fingerprint: str
    target_arc: BendyArc | None = None
    blockers: Tuple[BendySculptIssue, ...] = field(default_factory=tuple)

    @property
    def can_apply(self) -> bool:
        changed = self.previous_controls != self.target_controls or abs(
            self.previous_volume - self.target_volume
        ) > 1e-9
        return changed and not self.blockers and self.target_arc is not None


@dataclass(frozen=True)
class BendySculptReceipt:
    graph_id: str
    behavior_id: str
    frame: float
    verified: bool
    maximum_control_error: float
    maximum_joint_error: float
    previous_fingerprint: str
    previous_controls: Tuple[Vector3, Vector3]
    target_controls: Tuple[Vector3, Vector3]
    previous_volume: float
    target_volume: float
    message: str


def _vector(value: Iterable[float], label: str) -> Vector3:
    result = tuple(float(item) for item in value)
    if len(result) != 3 or not all(math.isfinite(item) for item in result):
        raise ValueError(f"{label}必须包含三个有限数值")
    return result


def _add(left: Vector3, right: Vector3) -> Vector3:
    return tuple(left[index] + right[index] for index in range(3))


def _subtract(left: Vector3, right: Vector3) -> Vector3:
    return tuple(left[index] - right[index] for index in range(3))


def _multiply(vector: Vector3, scale: float) -> Vector3:
    return tuple(item * scale for item in vector)


def _dot(left: Vector3, right: Vector3) -> float:
    return sum(left[index] * right[index] for index in range(3))


def _cross(left: Vector3, right: Vector3) -> Vector3:
    return (
        left[1] * right[2] - left[2] * right[1],
        left[2] * right[0] - left[0] * right[2],
        left[0] * right[1] - left[1] * right[0],
    )


def _length(vector: Vector3) -> float:
    return math.sqrt(_dot(vector, vector))


def _normalize(vector: Vector3, label: str) -> Vector3:
    length = _length(vector)
    if length <= 1e-10:
        raise ValueError(f"{label}长度接近零")
    return _multiply(vector, 1.0 / length)


def _bezier(control_points: Sequence[Vector3], parameter: float) -> Vector3:
    one_minus = 1.0 - parameter
    weights = (
        one_minus ** 3,
        3.0 * one_minus * one_minus * parameter,
        3.0 * one_minus * parameter * parameter,
        parameter ** 3,
    )
    return tuple(sum(control_points[index][axis] * weights[index] for index in range(4))
                 for axis in range(3))


def _bezier_tangent(control_points: Sequence[Vector3], parameter: float) -> Vector3:
    one_minus = 1.0 - parameter
    terms = (
        _multiply(_subtract(control_points[1], control_points[0]), 3.0 * one_minus * one_minus),
        _multiply(_subtract(control_points[2], control_points[1]), 6.0 * one_minus * parameter),
        _multiply(_subtract(control_points[3], control_points[2]), 3.0 * parameter * parameter),
    )
    return _normalize(_add(_add(terms[0], terms[1]), terms[2]), "曲线切线")


def _fallback_normal(tangent: Vector3) -> Vector3:
    axis = min(((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0)),
               key=lambda item: abs(_dot(tangent, item)))
    return _normalize(_subtract(axis, _multiply(tangent, _dot(axis, tangent))), "局部参考轴")


def _initial_normal(tangent: Vector3, up_hint: Vector3) -> Vector3:
    projected = _subtract(up_hint, _multiply(tangent, _dot(up_hint, tangent)))
    return _fallback_normal(tangent) if _length(projected) <= 1e-8 else _normalize(projected, "上方向")


def _transport_normal(previous_tangent: Vector3, tangent: Vector3, normal: Vector3) -> Vector3:
    axis = _cross(previous_tangent, tangent)
    axis_length = _length(axis)
    cosine = max(-1.0, min(1.0, _dot(previous_tangent, tangent)))
    if axis_length > 1e-8:
        axis = _multiply(axis, 1.0 / axis_length)
        angle = math.atan2(axis_length, cosine)
        rotated = _add(
            _add(_multiply(normal, math.cos(angle)),
                 _multiply(_cross(axis, normal), math.sin(angle))),
            _multiply(axis, _dot(axis, normal) * (1.0 - math.cos(angle))),
        )
    elif cosine < 0.0:
        rotated = _multiply(normal, -1.0)
    else:
        rotated = normal
    projected = _subtract(rotated, _multiply(tangent, _dot(rotated, tangent)))
    return _fallback_normal(tangent) if _length(projected) <= 1e-8 else _normalize(projected, "传递法线")


def sample_bendy_arc(
    control_points: Iterable[Iterable[float]],
    sample_count: int = 7,
    up_hint: Iterable[float] = (0.0, 1.0, 0.0),
    volume_preservation: float = 0.65,
    lookup_steps: int = 160,
) -> BendyArc:
    """Sample a cubic arc at equal distances and build parallel-transport frames."""
    points = tuple(_vector(item, "控制点") for item in control_points)
    if len(points) != 4:
        raise ValueError("Bendy 曲线必须包含四个控制点")
    if not isinstance(sample_count, int) or not 2 <= sample_count <= 64:
        raise ValueError("Bendy 采样数量必须在 2–64 之间")
    if not isinstance(lookup_steps, int) or not 32 <= lookup_steps <= 4096:
        raise ValueError("弧长查找精度必须在 32–4096 之间")
    preservation = float(volume_preservation)
    if not math.isfinite(preservation) or not 0.0 <= preservation <= 1.0:
        raise ValueError("体积保持必须在 0–1 之间")
    up = _vector(up_hint, "上方向")
    if _length(up) <= 1e-10:
        raise ValueError("上方向长度接近零")
    chord = _length(_subtract(points[3], points[0]))
    if chord <= 1e-8:
        raise ValueError("Bendy 骨段起点与终点距离接近零")

    table = [(0.0, 0.0, points[0])]
    previous = points[0]
    total = 0.0
    for index in range(1, lookup_steps + 1):
        parameter = index / float(lookup_steps)
        position = _bezier(points, parameter)
        total += _length(_subtract(position, previous))
        table.append((parameter, total, position))
        previous = position
    if total <= 1e-8:
        raise ValueError("Bendy 曲线弧长接近零")

    parameters = []
    table_index = 1
    for index in range(sample_count):
        fraction = index / float(sample_count - 1)
        target = total * fraction
        while table_index < len(table) - 1 and table[table_index][1] < target:
            table_index += 1
        before, after = table[table_index - 1], table[table_index]
        span = after[1] - before[1]
        blend = 0.0 if span <= 1e-12 else (target - before[1]) / span
        parameters.append(before[0] + (after[0] - before[0]) * blend)

    stretch_ratio = total / chord
    cross_section_scale = stretch_ratio ** (-0.5 * preservation)
    samples = []
    previous_tangent = None
    normal = None
    for index, parameter in enumerate(parameters):
        tangent = _bezier_tangent(points, parameter)
        if previous_tangent is None:
            normal = _initial_normal(tangent, up)
        else:
            normal = _transport_normal(previous_tangent, tangent, normal)
        binormal = _normalize(_cross(tangent, normal), "Bendy 副轴")
        normal = _normalize(_cross(binormal, tangent), "Bendy 法线")
        samples.append(BendyArcSample(
            arc_fraction=index / float(sample_count - 1),
            curve_parameter=parameter,
            position=_bezier(points, parameter),
            tangent=tangent,
            normal=normal,
            binormal=binormal,
            volume_scale=cross_section_scale,
        ))
        previous_tangent = tangent
    return BendyArc(points, chord, total, stretch_ratio, tuple(samples))


def map_bendy_intent(
    start: Iterable[float],
    end: Iterable[float],
    local_controls: Iterable[Iterable[float]],
    up_hint: Iterable[float] = (0.0, 1.0, 0.0),
) -> Tuple[Vector3, Vector3]:
    """Map two normalized arc controls into a stable world-space bend plane."""
    start_point, end_point = _vector(start, "骨段起点"), _vector(end, "骨段终点")
    controls = tuple(_vector(item, "形变控制点") for item in local_controls)
    if len(controls) != 2:
        raise ValueError("形变意图必须包含两枚切线控制点")
    delta = _subtract(end_point, start_point)
    length = _length(delta)
    if length <= 1e-8:
        raise ValueError("Bendy 骨段起点与终点距离接近零")
    tangent = _multiply(delta, 1.0 / length)
    up = _vector(up_hint, "弯曲平面参考")
    projected = _subtract(up, _multiply(tangent, _dot(up, tangent)))
    normal = _fallback_normal(tangent) if _length(projected) <= 1e-8 else _normalize(projected, "弯曲平面参考")
    result = []
    for control in controls:
        if not 0.0 <= control[0] <= 10.0:
            raise ValueError("切线控制点必须位于骨段起止范围内")
        result.append(_add(
            _add(start_point, _multiply(tangent, control[0] / 10.0 * length)),
            _multiply(normal, control[1] / 10.0 * length),
        ))
    return tuple(result)


def bendy_sculpt_fingerprint(
    behavior_id: str,
    frame: float,
    source_positions: Iterable[Iterable[float]],
    controls: Iterable[Iterable[float]],
    volume: float,
) -> str:
    payload = {
        "behavior": str(behavior_id),
        "frame": round(float(frame), 9),
        "sources": [[round(float(value), 9) for value in item] for item in source_positions],
        "controls": [[round(float(value), 9) for value in item] for item in controls],
        "volume": round(float(volume), 9),
    }
    return hashlib.sha256(json.dumps(
        payload, sort_keys=True, separators=(",", ":"), allow_nan=False,
    ).encode("utf-8")).hexdigest()


__all__ = [
    "BendyArc", "BendyArcSample", "BendySculptIssue", "BendySculptPlan",
    "BendySculptReceipt", "bendy_sculpt_fingerprint", "map_bendy_intent",
    "sample_bendy_arc",
]
