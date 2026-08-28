"""Host-independent quaternion twist analysis and artistic distribution plans."""

from __future__ import annotations

from dataclasses import dataclass, field
import hashlib
import json
import math
from typing import Iterable, Tuple


Quaternion = Tuple[float, float, float, float]
Vector3 = Tuple[float, float, float]


@dataclass(frozen=True)
class TwistSculptIssue:
    code: str
    message: str
    subject_id: str = ""


@dataclass(frozen=True)
class TwistProfilePlan:
    graph_id: str
    module_id: str
    frame: float
    bias: float
    ease: float
    intensity: float
    previous_weights: Tuple[float, ...]
    target_weights: Tuple[float, ...]
    observed_fingerprint: str
    blockers: Tuple[TwistSculptIssue, ...] = field(default_factory=tuple)

    @property
    def can_apply(self) -> bool:
        return not self.blockers and self.previous_weights != self.target_weights


@dataclass(frozen=True)
class TwistProfileReceipt:
    graph_id: str
    module_id: str
    frame: float
    verified: bool
    maximum_weight_error: float
    previous_fingerprint: str
    previous_weights: Tuple[float, ...]
    target_weights: Tuple[float, ...]
    message: str


def _normalize_vector(vector: Iterable[float]) -> Vector3:
    values = tuple(float(value) for value in vector)
    if len(values) != 3 or not all(math.isfinite(value) for value in values):
        raise ValueError("扭转轴必须是三个有限数值")
    length = math.sqrt(sum(value * value for value in values))
    if length <= 1e-10:
        raise ValueError("扭转轴长度为零")
    return tuple(value / length for value in values)


def normalize_quaternion(quaternion: Iterable[float]) -> Quaternion:
    values = tuple(float(value) for value in quaternion)
    if len(values) != 4 or not all(math.isfinite(value) for value in values):
        raise ValueError("四元数必须包含四个有限数值")
    length = math.sqrt(sum(value * value for value in values))
    if length <= 1e-10:
        raise ValueError("四元数长度为零")
    normalized = tuple(value / length for value in values)
    return tuple(-value for value in normalized) if normalized[3] < 0.0 else normalized


def quaternion_product(left: Quaternion, right: Quaternion) -> Quaternion:
    lx, ly, lz, lw = left
    rx, ry, rz, rw = right
    return (
        lw * rx + lx * rw + ly * rz - lz * ry,
        lw * ry - lx * rz + ly * rw + lz * rx,
        lw * rz + lx * ry - ly * rx + lz * rw,
        lw * rw - lx * rx - ly * ry - lz * rz,
    )


def decompose_swing_twist(
    quaternion: Iterable[float],
    twist_axis: Iterable[float],
) -> Tuple[Quaternion, Quaternion, float]:
    """Split a rotation into swing and twist around an arbitrary local axis."""
    qx, qy, qz, qw = normalize_quaternion(quaternion)
    axis = _normalize_vector(twist_axis)
    projection = qx * axis[0] + qy * axis[1] + qz * axis[2]
    try:
        twist = normalize_quaternion((
            axis[0] * projection, axis[1] * projection,
            axis[2] * projection, qw,
        ))
    except ValueError:
        twist = (0.0, 0.0, 0.0, 1.0)
    conjugate = (-twist[0], -twist[1], -twist[2], twist[3])
    swing = normalize_quaternion(quaternion_product((qx, qy, qz, qw), conjugate))
    signed_projection = sum(twist[index] * axis[index] for index in range(3))
    angle = math.degrees(2.0 * math.atan2(signed_projection, twist[3]))
    if angle > 180.0:
        angle -= 360.0
    elif angle < -180.0:
        angle += 360.0
    return swing, twist, angle


def compute_twist_profile(
    joint_count: int,
    bias: float = 0.0,
    ease: float = 0.65,
    intensity: float = 1.0,
) -> Tuple[float, ...]:
    """Create a monotonic artistic twist distribution with endpoint-safe weights."""
    if not isinstance(joint_count, int) or joint_count < 1 or joint_count > 32:
        raise ValueError("扭转关节数量必须在 1–32 之间")
    values = (float(bias), float(ease), float(intensity))
    if not all(math.isfinite(value) for value in values):
        raise ValueError("扭转曲线参数必须是有限数值")
    if not -1.0 <= values[0] <= 1.0:
        raise ValueError("扭转偏置必须在 -1–1 之间")
    if not 0.0 <= values[1] <= 1.0 or not 0.0 <= values[2] <= 1.0:
        raise ValueError("缓入强度和扭转强度必须在 0–1 之间")
    result = []
    exponent = 1.0 + abs(values[0]) * 3.0
    for index in range(1, joint_count + 1):
        linear = index / float(joint_count + 1)
        if values[0] > 0.0:
            biased = linear ** exponent
        elif values[0] < 0.0:
            biased = 1.0 - (1.0 - linear) ** exponent
        else:
            biased = linear
        smooth = biased * biased * (3.0 - 2.0 * biased)
        shaped = biased + (smooth - biased) * values[1]
        result.append(round(max(0.0, min(1.0, shaped * values[2])), 9))
    return tuple(result)


def twist_profile_fingerprint(module_id: str, frame: float, weights: Iterable[float]) -> str:
    payload = {
        "module": str(module_id), "frame": round(float(frame), 9),
        "weights": [round(float(value), 9) for value in weights],
    }
    return hashlib.sha256(
        json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    ).hexdigest()


def plan_twist_profile(
    graph_id: str,
    module_id: str,
    frame: float,
    previous_weights: Iterable[float],
    bias: float,
    ease: float,
    intensity: float,
) -> TwistProfilePlan:
    previous = tuple(float(value) for value in previous_weights)
    blockers = []
    if not math.isfinite(float(frame)):
        blockers.append(TwistSculptIssue("frame", "当前动画帧无效", module_id))
    if not previous:
        blockers.append(TwistSculptIssue("missing_network", "当前肢体没有可塑形的 Twist 网络", module_id))
    if any(not math.isfinite(value) or not 0.0 <= value <= 1.0 for value in previous):
        blockers.append(TwistSculptIssue("invalid_weight", "Twist 网络包含无效权重", module_id))
    try:
        target = compute_twist_profile(len(previous), bias, ease, intensity) if previous else ()
    except ValueError as exc:
        blockers.append(TwistSculptIssue("profile", str(exc), module_id))
        target = ()
    fingerprint = (
        twist_profile_fingerprint(module_id, frame, previous)
        if previous and math.isfinite(float(frame)) else ""
    )
    return TwistProfilePlan(
        graph_id=str(graph_id), module_id=str(module_id), frame=float(frame),
        bias=float(bias), ease=float(ease), intensity=float(intensity),
        previous_weights=previous, target_weights=target,
        observed_fingerprint=fingerprint, blockers=tuple(blockers),
    )


__all__ = [
    "TwistProfilePlan", "TwistProfileReceipt", "TwistSculptIssue",
    "compute_twist_profile", "decompose_swing_twist", "normalize_quaternion",
    "plan_twist_profile", "quaternion_product", "twist_profile_fingerprint",
]
