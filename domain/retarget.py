"""Semantic retarget mapping and non-destructive Ghost Pose preview."""

from __future__ import annotations

from dataclasses import dataclass, field, replace
import math
from typing import Tuple

from MayaCraft.domain.pose_clip import ClipAsset, PoseFrame, PoseNode
from MayaCraft.domain.skeleton import SkeletonAnalysis


@dataclass(frozen=True)
class RetargetAxisTemplate:
    """Signed source/target coordinate conventions for world-space motion."""

    template_id: str = "maya_y_up_z_forward"
    label: str = "同向 / Y 向上 · Z 向前"
    source_forward: str = "+Z"
    source_up: str = "+Y"
    target_forward: str = "+Z"
    target_up: str = "+Y"

    @property
    def rotation(self):
        issues = validate_retarget_axis_template(self)
        if issues:
            raise ValueError("；".join(issues))
        source = _axis_basis(self.source_forward, self.source_up)
        target = _axis_basis(self.target_forward, self.target_up)
        matrix = _matrix_multiply(target, _matrix_transpose(source))
        return _quaternion_from_matrix(matrix)

    @property
    def angle_degrees(self):
        quaternion = self.rotation
        return math.degrees(2.0 * math.acos(max(-1.0, min(1.0, abs(quaternion[3])))))

    @property
    def is_identity(self):
        return self.angle_degrees <= 1e-7


@dataclass(frozen=True)
class RetargetJointMapping:
    semantic_role: str
    source_path: str
    target_path: str
    confidence: float
    evidence: Tuple[str, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class RetargetProfile:
    source_root: str = ""
    target_root: str = ""
    mappings: Tuple[RetargetJointMapping, ...] = field(default_factory=tuple)
    scale_ratio: float = 1.0
    confidence: float = 0.0
    axis_template: RetargetAxisTemplate = field(default_factory=RetargetAxisTemplate)
    issues: Tuple[str, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def can_preview(self):
        return bool(self.mappings) and not self.blockers

    def mapping(self, role):
        return next((item for item in self.mappings if item.semantic_role == role), None)


def retarget_axis_templates() -> Tuple[RetargetAxisTemplate, ...]:
    """Built-in, deterministic templates for common DCC/game skeleton frames."""

    return (
        RetargetAxisTemplate(),
        RetargetAxisTemplate(
            "z_forward_to_x_forward", "+Z 向前 → +X 向前",
            "+Z", "+Y", "+X", "+Y",
        ),
        RetargetAxisTemplate(
            "x_forward_to_z_forward", "+X 向前 → +Z 向前",
            "+X", "+Y", "+Z", "+Y",
        ),
        RetargetAxisTemplate(
            "opposite_z_forward", "+Z 向前 → -Z 向前",
            "+Z", "+Y", "-Z", "+Y",
        ),
        RetargetAxisTemplate(
            "z_up_to_y_up", "Z 向上 / -Y 向前 → Y 向上 / +Z 向前",
            "-Y", "+Z", "+Z", "+Y",
        ),
    )


def validate_retarget_axis_template(template: RetargetAxisTemplate) -> Tuple[str, ...]:
    issues = []
    axes = {"+X", "-X", "+Y", "-Y", "+Z", "-Z"}
    values = (
        ("源向前轴", template.source_forward),
        ("源向上轴", template.source_up),
        ("目标向前轴", template.target_forward),
        ("目标向上轴", template.target_up),
    )
    for label, value in values:
        if value not in axes:
            issues.append(f"{label}无效：{value}")
    if template.source_forward in axes and template.source_up in axes:
        if template.source_forward[-1] == template.source_up[-1]:
            issues.append("源向前轴与向上轴不能平行")
    if template.target_forward in axes and template.target_up in axes:
        if template.target_forward[-1] == template.target_up[-1]:
            issues.append("目标向前轴与向上轴不能平行")
    if not str(template.template_id).strip():
        issues.append("轴模板必须包含稳定 ID")
    if not str(template.label).strip():
        issues.append("轴模板必须包含中文显示名")
    return tuple(dict.fromkeys(issues))


def with_retarget_axis_template(
    profile: RetargetProfile,
    template: RetargetAxisTemplate,
) -> RetargetProfile:
    issues = validate_retarget_axis_template(template)
    if issues:
        raise ValueError("；".join(issues))
    return replace(profile, axis_template=template)


@dataclass(frozen=True)
class RetargetPreviewSignal:
    semantic_role: str
    source_path: str
    target_path: str
    source_translation_delta: Tuple[float, float, float]
    target_translation_delta: Tuple[float, float, float]
    rotation_delta_degrees: float
    confidence: float


@dataclass(frozen=True)
class RetargetPosePreview:
    frame: PoseFrame
    signals: Tuple[RetargetPreviewSignal, ...] = field(default_factory=tuple)
    unmatched_source: Tuple[str, ...] = field(default_factory=tuple)
    unmatched_target: Tuple[str, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class RetargetClipFrameSignal:
    frame: float
    root_motion_source: float
    root_motion_target: float
    maximum_rotation_delta_degrees: float
    mean_confidence: float


@dataclass(frozen=True)
class RetargetContactDiagnostic:
    semantic_role: str
    start_frame: float
    end_frame: float
    source_drift: float
    ghost_drift: float
    preserved: bool
    confidence: float


@dataclass(frozen=True)
class RetargetClipPreview:
    frames_per_second: float
    frames: Tuple[RetargetPosePreview, ...] = field(default_factory=tuple)
    signals: Tuple[RetargetClipFrameSignal, ...] = field(default_factory=tuple)
    contacts: Tuple[RetargetContactDiagnostic, ...] = field(default_factory=tuple)
    maximum_root_motion: float = 0.0
    maximum_rotation_delta_degrees: float = 0.0
    contact_preservation: float = 1.0


@dataclass(frozen=True)
class RetargetLayerKey:
    semantic_role: str
    target_path: str
    frame: float
    expected_translation: Tuple[float, float, float]
    expected_rotation: Tuple[float, float, float, float]
    desired_translation: Tuple[float, float, float]
    desired_rotation: Tuple[float, float, float, float]
    write_translation: bool = False


@dataclass(frozen=True)
class RetargetLayerPlan:
    layer_name: str
    source_label: str
    target_root: str
    keys: Tuple[RetargetLayerKey, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def can_apply(self):
        return bool(self.keys) and not self.blockers

    @property
    def is_noop(self):
        return not self.keys and not self.blockers


@dataclass(frozen=True)
class RetargetLayerReceipt:
    plan: RetargetLayerPlan
    layer_name: str
    verified: bool
    maximum_translation_error: float
    maximum_rotation_error_degrees: float
    message: str


@dataclass(frozen=True)
class RetargetValidationSignal:
    frame: float
    semantic_role: str
    target_path: str
    position_error: float
    rotation_error_degrees: float


@dataclass(frozen=True)
class RetargetResultValidation:
    signals: Tuple[RetargetValidationSignal, ...] = field(default_factory=tuple)
    rms_position_error: float = 0.0
    maximum_position_error: float = 0.0
    rms_rotation_error_degrees: float = 0.0
    maximum_rotation_error_degrees: float = 0.0
    contact_preservation: float = 1.0
    missing_targets: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def passed_rotation(self):
        return self.maximum_rotation_error_degrees <= 0.1 and not self.missing_targets


_REQUIRED = (
    "pelvis", "spine", "chest", "head",
    "left_hand", "right_hand", "left_foot", "right_foot",
)


def build_retarget_profile(source: SkeletonAnalysis, target: SkeletonAnalysis) -> RetargetProfile:
    blockers = []
    issues = []
    if not source.is_usable:
        blockers.append("源骨架语义分析不可用")
    if not target.is_usable:
        blockers.append("目标骨架语义分析不可用")
    source_map = {item.role: item for item in source.semantics}
    target_map = {item.role: item for item in target.semantics}
    common = tuple(sorted(set(source_map) & set(target_map)))
    mappings = tuple(
        RetargetJointMapping(
            semantic_role=role,
            source_path=source_map[role].path,
            target_path=target_map[role].path,
            confidence=min(source_map[role].confidence, target_map[role].confidence),
            evidence=tuple(source_map[role].evidence) + tuple(target_map[role].evidence),
        )
        for role in common
    )
    for role in _REQUIRED:
        if role not in common:
            issues.append(f"缺少重定向关键语义：{role}")
    if len(common) < 6:
        blockers.append(f"源/目标仅共享 {len(common)} 个骨架语义，至少需要 6 个")
    source_scale = _skeleton_scale(source)
    target_scale = _skeleton_scale(target)
    ratio = target_scale / source_scale if source_scale > 1e-8 else 1.0
    coverage = len(common) / max(1, len(set(source_map) | set(target_map)))
    semantic_confidence = sum(item.confidence for item in mappings) / max(1, len(mappings))
    confidence = coverage * semantic_confidence
    if confidence < 0.45:
        issues.append(f"骨架映射置信度偏低：{confidence:.0%}")
    return RetargetProfile(
        source_root=source.root_path,
        target_root=target.root_path,
        mappings=mappings,
        scale_ratio=ratio,
        confidence=confidence,
        issues=tuple(issues),
        blockers=tuple(blockers),
    )


def preview_retarget_pose(
    source_pose: PoseFrame,
    source_reference: PoseFrame,
    target_reference: PoseFrame,
    profile: RetargetProfile,
) -> RetargetPosePreview:
    if not profile.can_preview:
        raise ValueError("当前重定向映射不可预览：" + "；".join(profile.blockers))
    source_current = {node.node_path: node for node in source_pose.nodes}
    source_rest = {node.node_path: node for node in source_reference.nodes}
    target_rest = {node.node_path: node for node in target_reference.nodes}
    target_nodes = {node.node_path: node for node in target_reference.nodes}
    signals = []
    mapped_source = set()
    mapped_target = set()
    axis_rotation = profile.axis_template.rotation
    axis_rotation_inverse = _inverse(axis_rotation)
    for mapping in profile.mappings:
        current = source_current.get(mapping.source_path)
        source_base = source_rest.get(mapping.source_path)
        target_base = target_rest.get(mapping.target_path)
        if current is None or source_base is None or target_base is None:
            continue
        mapped_source.add(mapping.source_path)
        mapped_target.add(mapping.target_path)
        source_delta = _sub(current.world_translation, source_base.world_translation)
        target_delta = _rotate_vector(
            axis_rotation, _scale(source_delta, profile.scale_ratio)
        )
        source_rotation_delta = _multiply(
            current.world_rotation,
            _inverse(source_base.world_rotation),
        )
        rotation_delta = _multiply(
            _multiply(axis_rotation, source_rotation_delta),
            axis_rotation_inverse,
        )
        target_rotation = _normalize(_multiply(rotation_delta, target_base.world_rotation))
        target_nodes[mapping.target_path] = replace(
            target_base,
            world_translation=_add(target_base.world_translation, target_delta),
            world_rotation=target_rotation,
        )
        signals.append(RetargetPreviewSignal(
            semantic_role=mapping.semantic_role,
            source_path=mapping.source_path,
            target_path=mapping.target_path,
            source_translation_delta=source_delta,
            target_translation_delta=target_delta,
            rotation_delta_degrees=_quaternion_error_degrees(
                current.world_rotation, source_base.world_rotation
            ),
            confidence=mapping.confidence,
        ))
    ordered = tuple(target_nodes[node.node_path] for node in target_reference.nodes)
    return RetargetPosePreview(
        frame=PoseFrame(frame=source_pose.frame, nodes=ordered),
        signals=tuple(signals),
        unmatched_source=tuple(sorted(set(source_current) - mapped_source)),
        unmatched_target=tuple(sorted(set(target_rest) - mapped_target)),
    )


def preview_retarget_clip(
    source_clip: ClipAsset,
    source_reference: PoseFrame,
    target_reference: PoseFrame,
    profile: RetargetProfile,
) -> RetargetClipPreview:
    if not source_clip.frames:
        return RetargetClipPreview(frames_per_second=source_clip.frames_per_second)
    previews = tuple(
        preview_retarget_pose(frame, source_reference, target_reference, profile)
        for frame in source_clip.frames
    )
    root_mapping = profile.mapping("pelvis") or profile.mapping("root")
    source_reference_by_path = {node.node_path: node for node in source_reference.nodes}
    target_reference_by_path = {node.node_path: node for node in target_reference.nodes}
    signals = []
    for source_frame, preview in zip(source_clip.frames, previews):
        root_source = source_frame.node(
            source_reference_by_path[root_mapping.source_path].key
        ) if root_mapping and root_mapping.source_path in source_reference_by_path else None
        root_source_reference = source_reference_by_path.get(root_mapping.source_path) if root_mapping else None
        root_target = next(
            (node for node in preview.frame.nodes if root_mapping and node.node_path == root_mapping.target_path),
            None,
        )
        root_target_reference = target_reference_by_path.get(root_mapping.target_path) if root_mapping else None
        root_source_motion = _distance(root_source.world_translation, root_source_reference.world_translation) if root_source and root_source_reference else 0.0
        root_target_motion = _distance(root_target.world_translation, root_target_reference.world_translation) if root_target and root_target_reference else 0.0
        signals.append(RetargetClipFrameSignal(
            frame=source_frame.frame,
            root_motion_source=root_source_motion,
            root_motion_target=root_target_motion,
            maximum_rotation_delta_degrees=max(
                (item.rotation_delta_degrees for item in preview.signals), default=0.0
            ),
            mean_confidence=sum(item.confidence for item in preview.signals) / max(1, len(preview.signals)),
        ))
    contacts = _contact_diagnostics(source_clip, previews, source_reference, target_reference, profile)
    preserved = sum(item.preserved for item in contacts)
    return RetargetClipPreview(
        frames_per_second=source_clip.frames_per_second,
        frames=previews,
        signals=tuple(signals),
        contacts=contacts,
        maximum_root_motion=max((item.root_motion_target for item in signals), default=0.0),
        maximum_rotation_delta_degrees=max(
            (item.maximum_rotation_delta_degrees for item in signals), default=0.0
        ),
        contact_preservation=preserved / len(contacts) if contacts else 1.0,
    )


def plan_retarget_layer(
    source_clip: ClipAsset,
    source_reference: PoseFrame,
    target_reference: PoseFrame,
    target_baseline: ClipAsset,
    profile: RetargetProfile,
    layer_name: str,
    maximum_keys: int = 50_000,
    tolerance: float = 1e-6,
) -> RetargetLayerPlan:
    blockers = []
    if not profile.can_preview:
        blockers.extend(profile.blockers or ("重定向语义映射不可用",))
    if len(source_clip.frames) != len(target_baseline.frames):
        blockers.append("源 Clip 与目标基线采样数量不一致")
    elif any(abs(left.frame - right.frame) > 1e-6 for left, right in zip(source_clip.frames, target_baseline.frames)):
        blockers.append("源 Clip 与目标基线采样帧不一致")
    if abs(source_clip.frames_per_second - target_baseline.frames_per_second) > 1e-6:
        blockers.append("源 Clip 与目标基线帧率不一致")
    source_rest = {node.node_path: node for node in source_reference.nodes}
    target_rest = {node.node_path: node for node in target_reference.nodes}
    candidate_keys = []
    changed_paths = set()
    if not blockers:
        for source_frame, baseline_frame in zip(source_clip.frames, target_baseline.frames):
            source_nodes = {node.node_path: node for node in source_frame.nodes}
            baseline_nodes = {node.node_path: node for node in baseline_frame.nodes}
            ghost_preview = preview_retarget_pose(
                source_frame, source_reference, target_reference, profile
            )
            ghost_by_path = {node.node_path: node for node in ghost_preview.frame.nodes}
            target_rest_by_key = {node.key: node for node in target_reference.nodes}
            ghost_by_key = {node.key: node for node in ghost_preview.frame.nodes}
            for mapping in profile.mappings:
                source = source_nodes.get(mapping.source_path)
                source_base = source_rest.get(mapping.source_path)
                target_base = target_rest.get(mapping.target_path)
                expected = baseline_nodes.get(mapping.target_path)
                if not all((source, source_base, target_base, expected)):
                    blockers.append(f"第 {source_frame.frame:g} 帧缺少 {mapping.semantic_role} 的源或目标通道")
                    continue
                target_ghost = ghost_by_path[mapping.target_path]
                parent_rest = target_rest_by_key.get(target_base.parent_key)
                parent_ghost = ghost_by_key.get(target_ghost.parent_key)
                parent_rest_rotation = parent_rest.world_rotation if parent_rest else (0.0, 0.0, 0.0, 1.0)
                parent_ghost_rotation = parent_ghost.world_rotation if parent_ghost else (0.0, 0.0, 0.0, 1.0)
                reference_local_total = _multiply(
                    _inverse(parent_rest_rotation), target_base.world_rotation
                )
                static_axis_offset = _multiply(
                    reference_local_total, _inverse(target_base.local_rotation)
                )
                desired_local_total = _multiply(
                    _inverse(parent_ghost_rotation), target_ghost.world_rotation
                )
                desired_rotation = _normalize(_multiply(
                    _inverse(static_axis_offset), desired_local_total
                ))
                write_translation = mapping.semantic_role in {"root", "pelvis"}
                if write_translation:
                    parent_position = parent_ghost.world_translation if parent_ghost else (0.0, 0.0, 0.0)
                    desired_translation = _rotate_vector(
                        _inverse(parent_ghost_rotation),
                        _sub(target_ghost.world_translation, parent_position),
                    )
                else:
                    desired_translation = expected.local_translation
                changed = not (
                    _distance(expected.local_translation, desired_translation) <= tolerance
                    and _quaternion_error_degrees(expected.local_rotation, desired_rotation) <= tolerance
                )
                key = RetargetLayerKey(
                    semantic_role=mapping.semantic_role,
                    target_path=mapping.target_path,
                    frame=source_frame.frame,
                    expected_translation=expected.local_translation,
                    expected_rotation=expected.local_rotation,
                    desired_translation=desired_translation,
                    desired_rotation=desired_rotation,
                    write_translation=write_translation,
                )
                candidate_keys.append(key)
                if changed:
                    changed_paths.add(mapping.target_path)
    # An Override Animation Layer extrapolates its first/last authored values.
    # Once a channel changes anywhere in the clip, retain its complete sampled
    # boundary so a zero-delta first frame cannot inherit a later rotation.
    keys = tuple(key for key in candidate_keys if key.target_path in changed_paths)
    if len(keys) > maximum_keys:
        blockers.append(f"重定向计划包含 {len(keys)} 个节点帧，交互上限为 {maximum_keys}")
    return RetargetLayerPlan(
        layer_name=str(layer_name),
        source_label=source_clip.label,
        target_root=profile.target_root,
        keys=keys,
        blockers=tuple(dict.fromkeys(blockers)),
    )


def validate_retarget_result(
    actual_clip: ClipAsset,
    preview: RetargetClipPreview,
    profile: RetargetProfile,
    contact_tolerance: float = 0.05,
) -> RetargetResultValidation:
    if len(actual_clip.frames) != len(preview.frames):
        raise ValueError("目标结果与 Ghost Preview 的采样数量不一致")
    if any(
        abs(actual.frame - ghost.frame.frame) > 1e-6
        for actual, ghost in zip(actual_clip.frames, preview.frames)
    ):
        raise ValueError("目标结果与 Ghost Preview 的采样帧不一致")
    signals = []
    missing = set()
    for actual_frame, ghost_preview in zip(actual_clip.frames, preview.frames):
        actual_by_path = {node.node_path: node for node in actual_frame.nodes}
        ghost_by_path = {node.node_path: node for node in ghost_preview.frame.nodes}
        for mapping in profile.mappings:
            actual = actual_by_path.get(mapping.target_path)
            ghost = ghost_by_path.get(mapping.target_path)
            if actual is None or ghost is None:
                missing.add(mapping.target_path)
                continue
            signals.append(RetargetValidationSignal(
                frame=actual_frame.frame,
                semantic_role=mapping.semantic_role,
                target_path=mapping.target_path,
                position_error=_distance(actual.world_translation, ghost.world_translation),
                rotation_error_degrees=_quaternion_error_degrees(
                    actual.world_rotation, ghost.world_rotation
                ),
            ))
    position_values = tuple(item.position_error for item in signals)
    rotation_values = tuple(item.rotation_error_degrees for item in signals)
    contact_results = []
    by_role_frame = {
        (item.semantic_role, item.frame): item for item in signals
    }
    for contact in preview.contacts:
        indices = tuple(
            index for index, frame in enumerate(actual_clip.frames)
            if contact.start_frame - 1e-6 <= frame.frame <= contact.end_frame + 1e-6
        )
        errors = tuple(
            by_role_frame[(contact.semantic_role, actual_clip.frames[index].frame)].position_error
            for index in indices
            if (contact.semantic_role, actual_clip.frames[index].frame) in by_role_frame
        )
        if errors:
            contact_results.append(max(errors) <= max(float(contact_tolerance), contact.ghost_drift + contact_tolerance))
    return RetargetResultValidation(
        signals=tuple(signals),
        rms_position_error=_rms(position_values),
        maximum_position_error=max(position_values, default=0.0),
        rms_rotation_error_degrees=_rms(rotation_values),
        maximum_rotation_error_degrees=max(rotation_values, default=0.0),
        contact_preservation=sum(contact_results) / len(contact_results) if contact_results else 1.0,
        missing_targets=tuple(sorted(missing)),
    )


def _contact_diagnostics(source_clip, previews, source_reference, target_reference, profile):
    diagnostics = []
    if len(source_clip.frames) < 2:
        return ()
    source_scale = max(
        (_distance(node.world_translation, source_reference.nodes[0].world_translation) for node in source_reference.nodes),
        default=1.0,
    )
    velocity_threshold = max(source_scale * 0.05, 1e-4)
    drift_threshold = max(source_scale * 0.025, 1e-4)
    seconds_per_frame = 1.0 / max(source_clip.frames_per_second, 1e-8)
    for role in ("left_foot", "right_foot"):
        mapping = profile.mapping(role)
        if not mapping:
            continue
        source_positions = []
        ghost_positions = []
        for source_frame, preview in zip(source_clip.frames, previews):
            source_node = next((node for node in source_frame.nodes if node.node_path == mapping.source_path), None)
            ghost_node = next((node for node in preview.frame.nodes if node.node_path == mapping.target_path), None)
            if source_node is None or ghost_node is None:
                break
            source_positions.append(source_node.world_translation)
            ghost_positions.append(ghost_node.world_translation)
        if len(source_positions) != len(source_clip.frames):
            continue
        speeds = [0.0]
        for previous, current, previous_frame, current_frame in zip(
            source_positions, source_positions[1:], source_clip.frames, source_clip.frames[1:]
        ):
            duration = max((current_frame.frame - previous_frame.frame) * seconds_per_frame, 1e-8)
            speeds.append(_distance(previous, current) / duration)
        candidates = tuple(speed <= velocity_threshold for speed in speeds)
        start = None
        ranges = []
        for index, candidate in enumerate(candidates + (False,)):
            if candidate and start is None:
                start = index
            elif not candidate and start is not None:
                if index - start >= 2:
                    ranges.append((start, index - 1))
                start = None
        for lower, upper in ranges:
            source_segment = source_positions[lower:upper + 1]
            ghost_segment = ghost_positions[lower:upper + 1]
            source_drift = _segment_drift(source_segment)
            ghost_drift = _segment_drift(ghost_segment)
            allowed = source_drift * profile.scale_ratio + drift_threshold * profile.scale_ratio
            diagnostics.append(RetargetContactDiagnostic(
                semantic_role=role,
                start_frame=source_clip.frames[lower].frame,
                end_frame=source_clip.frames[upper].frame,
                source_drift=source_drift,
                ghost_drift=ghost_drift,
                preserved=ghost_drift <= allowed,
                confidence=max(0.0, min(1.0, 1.0 - ghost_drift / max(allowed * 2.0, 1e-8))),
            ))
    return tuple(diagnostics)


def _segment_drift(values):
    center = tuple(sum(value[axis] for value in values) / len(values) for axis in range(3))
    return max((_distance(value, center) for value in values), default=0.0)


def _skeleton_scale(analysis):
    if not analysis.joints:
        return 1.0
    xs = tuple(joint.position[0] for joint in analysis.joints)
    ys = tuple(joint.position[1] for joint in analysis.joints)
    zs = tuple(joint.position[2] for joint in analysis.joints)
    return max(max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs), 1e-8)


def _add(left, right):
    return tuple(a + b for a, b in zip(left, right))


def _sub(left, right):
    return tuple(a - b for a, b in zip(left, right))


def _scale(value, amount):
    return tuple(component * amount for component in value)


_AXIS_VECTORS = {
    "+X": (1.0, 0.0, 0.0), "-X": (-1.0, 0.0, 0.0),
    "+Y": (0.0, 1.0, 0.0), "-Y": (0.0, -1.0, 0.0),
    "+Z": (0.0, 0.0, 1.0), "-Z": (0.0, 0.0, -1.0),
}


def _axis_basis(forward_axis, up_axis):
    forward = _AXIS_VECTORS[forward_axis]
    up = _AXIS_VECTORS[up_axis]
    right = _cross(up, forward)
    return (
        (right[0], up[0], forward[0]),
        (right[1], up[1], forward[1]),
        (right[2], up[2], forward[2]),
    )


def _cross(left, right):
    return (
        left[1] * right[2] - left[2] * right[1],
        left[2] * right[0] - left[0] * right[2],
        left[0] * right[1] - left[1] * right[0],
    )


def _matrix_transpose(value):
    return tuple(tuple(value[column][row] for column in range(3)) for row in range(3))


def _matrix_multiply(left, right):
    return tuple(tuple(
        sum(left[row][index] * right[index][column] for index in range(3))
        for column in range(3)
    ) for row in range(3))


def _quaternion_from_matrix(matrix):
    m00, m01, m02 = matrix[0]
    m10, m11, m12 = matrix[1]
    m20, m21, m22 = matrix[2]
    trace = m00 + m11 + m22
    if trace > 0.0:
        scale = math.sqrt(trace + 1.0) * 2.0
        quaternion = ((m21 - m12) / scale, (m02 - m20) / scale, (m10 - m01) / scale, 0.25 * scale)
    elif m00 > m11 and m00 > m22:
        scale = math.sqrt(1.0 + m00 - m11 - m22) * 2.0
        quaternion = (0.25 * scale, (m01 + m10) / scale, (m02 + m20) / scale, (m21 - m12) / scale)
    elif m11 > m22:
        scale = math.sqrt(1.0 + m11 - m00 - m22) * 2.0
        quaternion = ((m01 + m10) / scale, 0.25 * scale, (m12 + m21) / scale, (m02 - m20) / scale)
    else:
        scale = math.sqrt(1.0 + m22 - m00 - m11) * 2.0
        quaternion = ((m02 + m20) / scale, (m12 + m21) / scale, 0.25 * scale, (m10 - m01) / scale)
    return _normalize(quaternion)


def _distance(left, right):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(left, right)))


def _rms(values):
    return math.sqrt(sum(value * value for value in values) / len(values)) if values else 0.0


def _normalize(value):
    magnitude = math.sqrt(sum(component * component for component in value))
    return tuple(component / magnitude for component in value) if magnitude > 1e-12 else (0.0, 0.0, 0.0, 1.0)


def _inverse(value):
    normalized = _normalize(value)
    return (-normalized[0], -normalized[1], -normalized[2], normalized[3])


def _multiply(left, right):
    ax, ay, az, aw = left
    bx, by, bz, bw = right
    return (
        aw * bx + ax * bw + ay * bz - az * by,
        aw * by - ax * bz + ay * bw + az * bx,
        aw * bz + ax * by - ay * bx + az * bw,
        aw * bw - ax * bx - ay * by - az * bz,
    )


def _rotate_vector(quaternion, vector):
    value = (float(vector[0]), float(vector[1]), float(vector[2]), 0.0)
    rotated = _multiply(_multiply(quaternion, value), _inverse(quaternion))
    return rotated[:3]


def _quaternion_error_degrees(left, right):
    first, second = _normalize(left), _normalize(right)
    dot = max(-1.0, min(1.0, abs(sum(a * b for a, b in zip(first, second)))))
    return math.degrees(2.0 * math.acos(dot))


__all__ = [
    "RetargetClipFrameSignal", "RetargetClipPreview", "RetargetContactDiagnostic",
    "RetargetJointMapping", "RetargetLayerKey", "RetargetLayerPlan", "RetargetLayerReceipt",
    "RetargetAxisTemplate", "RetargetPosePreview", "RetargetPreviewSignal", "RetargetProfile",
    "RetargetResultValidation", "RetargetValidationSignal",
    "build_retarget_profile", "plan_retarget_layer", "preview_retarget_clip",
    "preview_retarget_pose", "retarget_axis_templates", "validate_retarget_axis_template",
    "validate_retarget_result", "with_retarget_axis_template",
]
