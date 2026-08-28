"""Host-independent plans for no-pop FK/IK and animated space switching."""

from __future__ import annotations

from dataclasses import dataclass, field
import hashlib
import json
import math
from typing import Iterable, Tuple

from MayaCraft.domain.rig_graph import compute_pole_vector_position


Matrix16 = Tuple[float, ...]


@dataclass(frozen=True)
class RigSwitchIssue:
    code: str
    message: str
    subject_id: str = ""


@dataclass(frozen=True)
class RigTransformSample:
    stable_id: str
    world_matrix: Matrix16

    @property
    def world_position(self) -> Tuple[float, float, float]:
        if len(self.world_matrix) != 16:
            return (0.0, 0.0, 0.0)
        return tuple(float(value) for value in self.world_matrix[12:15])


@dataclass(frozen=True)
class RigMatchTarget:
    stable_id: str
    world_matrix: Matrix16
    channels: Tuple[str, ...] = ("translate", "rotate")

    @property
    def world_position(self) -> Tuple[float, float, float]:
        return tuple(float(value) for value in self.world_matrix[12:15])


@dataclass(frozen=True)
class FKIKMatchPlan:
    graph_id: str
    module_id: str
    direction: str
    frame: float
    blend_before: float
    blend_after: float
    twist_before: float = 0.0
    result_intent: Tuple[RigTransformSample, ...] = field(default_factory=tuple)
    targets: Tuple[RigMatchTarget, ...] = field(default_factory=tuple)
    observed_fingerprint: str = ""
    blockers: Tuple[RigSwitchIssue, ...] = field(default_factory=tuple)

    @property
    def can_apply(self) -> bool:
        return not self.blockers and bool(self.targets) and self.blend_before != self.blend_after

    @property
    def direction_label(self) -> str:
        return "FK 匹配到 IK" if self.direction == "FK_TO_IK" else "IK 匹配到 FK"


@dataclass(frozen=True)
class FKIKMatchReceipt:
    graph_id: str
    module_id: str
    direction: str
    frame: float
    verified: bool
    keyed: bool
    maximum_position_error: float
    maximum_matrix_error: float
    previous_fingerprint: str
    message: str
    previous_key_count: int = 0
    result_key_count: int = 0


@dataclass(frozen=True)
class SpaceSwitchPlan:
    graph_id: str
    module_id: str
    frame: float
    selector_id: str
    control_id: str
    previous_space: int
    target_space: int
    space_labels: Tuple[str, ...]
    preserved_world_matrix: Matrix16
    guard_frame: float | None
    observed_fingerprint: str = ""
    blockers: Tuple[RigSwitchIssue, ...] = field(default_factory=tuple)

    @property
    def can_apply(self) -> bool:
        return (
            not self.blockers
            and self.previous_space != self.target_space
            and 0 <= self.target_space < len(self.space_labels)
        )

    @property
    def previous_label(self) -> str:
        return self.space_labels[self.previous_space] if 0 <= self.previous_space < len(self.space_labels) else "未知"

    @property
    def target_label(self) -> str:
        return self.space_labels[self.target_space] if 0 <= self.target_space < len(self.space_labels) else "未知"


@dataclass(frozen=True)
class SpaceSwitchReceipt:
    graph_id: str
    module_id: str
    frame: float
    verified: bool
    keyed: bool
    previous_space: int
    target_space: int
    maximum_matrix_error: float
    previous_fingerprint: str
    message: str
    previous_key_count: int = 0
    result_key_count: int = 0


def _finite_matrix(matrix: Iterable[float]) -> bool:
    values = tuple(matrix)
    return len(values) == 16 and all(math.isfinite(float(value)) for value in values)


def _replace_translation(matrix: Matrix16, position: Tuple[float, float, float]) -> Matrix16:
    values = list(matrix)
    values[12:15] = tuple(float(value) for value in position)
    return tuple(values)


def transform_fingerprint(
    samples: Iterable[RigTransformSample],
    scalar_values: Iterable[Tuple[str, float]] = (),
) -> str:
    """Return a deterministic drift fingerprint without host-specific objects."""
    payload = {
        "transforms": [
            [sample.stable_id, [round(float(value), 9) for value in sample.world_matrix]]
            for sample in samples
        ],
        "scalars": [[str(key), round(float(value), 9)] for key, value in scalar_values],
    }
    encoded = json.dumps(payload, ensure_ascii=False, separators=(",", ":"), sort_keys=True).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def maximum_matrix_error(expected: Matrix16, observed: Matrix16) -> float:
    if not _finite_matrix(expected) or not _finite_matrix(observed):
        return math.inf
    return max(abs(float(a) - float(b)) for a, b in zip(expected, observed))


def maximum_position_error(
    expected: Iterable[RigTransformSample],
    observed: Iterable[RigTransformSample],
) -> float:
    actual_by_id = {item.stable_id: item for item in observed}
    errors = []
    for item in expected:
        actual = actual_by_id.get(item.stable_id)
        if actual is None:
            return math.inf
        errors.append(math.dist(item.world_position, actual.world_position))
    return max(errors, default=0.0)


def plan_fk_ik_match(
    graph_id: str,
    module_id: str,
    direction: str,
    frame: float,
    result_chain: Iterable[RigTransformSample],
    fk_controls: Iterable[RigTransformSample],
    ik_control: RigTransformSample,
    pole_control: RigTransformSample,
    blend_value: float,
    twist_value: float = 0.0,
) -> FKIKMatchPlan:
    """Plan a pose-preserving FK/IK transition without modifying a host scene."""
    results = tuple(result_chain)
    controls = tuple(fk_controls)
    blockers = []
    if direction not in {"FK_TO_IK", "IK_TO_FK"}:
        blockers.append(RigSwitchIssue("direction", "FK/IK 匹配方向无效", module_id))
    if len(results) != 3 or len(controls) != 3:
        blockers.append(RigSwitchIssue("chain_length", "FK/IK 匹配需要三段结果链和三个 FK 控制器", module_id))
    all_samples = results + controls + (ik_control, pole_control)
    invalid = tuple(item.stable_id for item in all_samples if not _finite_matrix(item.world_matrix))
    if invalid:
        blockers.append(RigSwitchIssue("invalid_matrix", "发现无效或非有限世界矩阵：" + ", ".join(invalid), module_id))
    if not math.isfinite(float(frame)):
        blockers.append(RigSwitchIssue("frame", "当前动画帧无效", module_id))
    if not math.isfinite(float(blend_value)) or not -1e-6 <= float(blend_value) <= 1.0 + 1e-6:
        blockers.append(RigSwitchIssue("blend", "当前 FK/IK 混合值不在 0–1 范围内", module_id))
    if not math.isfinite(float(twist_value)):
        blockers.append(RigSwitchIssue("twist", "当前 IK Twist 值无效", module_id))

    targets = ()
    blend_after = 1.0 if direction == "FK_TO_IK" else 0.0
    if not blockers and direction == "FK_TO_IK":
        try:
            pole_position = compute_pole_vector_position(
                results[0].world_position,
                results[1].world_position,
                results[2].world_position,
            )
        except ValueError:
            blockers.append(RigSwitchIssue("degenerate_chain", "结果链长度为零，无法计算稳定 Pole 位置", module_id))
        else:
            targets = (
                RigMatchTarget(ik_control.stable_id, results[-1].world_matrix),
                RigMatchTarget(
                    pole_control.stable_id,
                    _replace_translation(pole_control.world_matrix, pole_position),
                    ("translate",),
                ),
            )
    elif not blockers and direction == "IK_TO_FK":
        targets = tuple(
            RigMatchTarget(control.stable_id, result.world_matrix)
            for control, result in zip(controls, results)
        )

    fingerprint = transform_fingerprint(
        all_samples,
        (("frame", float(frame)), ("ikFk", float(blend_value)), ("twist", float(twist_value))),
    ) if all(_finite_matrix(item.world_matrix) for item in all_samples) else ""
    return FKIKMatchPlan(
        graph_id=graph_id,
        module_id=module_id,
        direction=direction,
        frame=float(frame),
        blend_before=float(blend_value),
        blend_after=blend_after,
        twist_before=float(twist_value),
        result_intent=results,
        targets=targets,
        observed_fingerprint=fingerprint,
        blockers=tuple(blockers),
    )


def plan_space_switch(
    graph_id: str,
    module_id: str,
    frame: float,
    selector_id: str,
    control: RigTransformSample,
    previous_space: int,
    target_space: int,
    space_labels: Iterable[str],
    create_guard_key: bool = True,
) -> SpaceSwitchPlan:
    """Plan a world-pose-preserving space change at the current frame."""
    labels = tuple(str(value).strip() for value in space_labels)
    blockers = []
    if not _finite_matrix(control.world_matrix):
        blockers.append(RigSwitchIssue("invalid_matrix", "空间切换控制器的世界矩阵无效", control.stable_id))
    if not math.isfinite(float(frame)):
        blockers.append(RigSwitchIssue("frame", "当前动画帧无效", module_id))
    if not labels or any(not value for value in labels):
        blockers.append(RigSwitchIssue("space_labels", "空间名称为空或不完整", selector_id))
    if not 0 <= int(previous_space) < len(labels):
        blockers.append(RigSwitchIssue("current_space", "当前空间索引超出声明范围", selector_id))
    if not 0 <= int(target_space) < len(labels):
        blockers.append(RigSwitchIssue("target_space", "目标空间索引超出声明范围", selector_id))
    if int(previous_space) == int(target_space):
        blockers.append(RigSwitchIssue("same_space", "目标空间与当前空间相同，无需切换", selector_id))
    guard_frame = float(frame) - 1.0 if create_guard_key and math.isfinite(float(frame)) else None
    fingerprint = transform_fingerprint(
        (control,),
        (("frame", float(frame)), ("space", float(previous_space))),
    ) if _finite_matrix(control.world_matrix) and math.isfinite(float(frame)) else ""
    return SpaceSwitchPlan(
        graph_id=graph_id,
        module_id=module_id,
        frame=float(frame),
        selector_id=selector_id,
        control_id=control.stable_id,
        previous_space=int(previous_space),
        target_space=int(target_space),
        space_labels=labels,
        preserved_world_matrix=tuple(control.world_matrix),
        guard_frame=guard_frame,
        observed_fingerprint=fingerprint,
        blockers=tuple(blockers),
    )


__all__ = [
    "FKIKMatchPlan",
    "FKIKMatchReceipt",
    "RigMatchTarget",
    "RigSwitchIssue",
    "RigTransformSample",
    "SpaceSwitchPlan",
    "SpaceSwitchReceipt",
    "maximum_matrix_error",
    "maximum_position_error",
    "plan_fk_ik_match",
    "plan_space_switch",
    "transform_fingerprint",
]
