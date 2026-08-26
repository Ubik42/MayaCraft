"""Deterministic host-independent FABRIK and retarget contact-chain previews."""

from __future__ import annotations

from dataclasses import dataclass, field
import math
from typing import Iterable, Tuple

from MayaCraft.domain.pose_clip import ClipAsset
from MayaCraft.domain.retarget import RetargetClipPreview, RetargetProfile


Vector3 = Tuple[float, float, float]
Quaternion = Tuple[float, float, float, float]


@dataclass(frozen=True)
class ContactIKSettings:
    ground_normal: Vector3 = (0.0, 1.0, 0.0)
    ground_offset: float = 0.0
    fade_frames: int = 2
    anchor_offsets: Tuple[Tuple[str, Vector3], ...] = field(default_factory=tuple)
    align_root_to_ground: bool = True

    def anchor_offset(self, side):
        return next((value for name, value in self.anchor_offsets if name == side), (0.0, 0.0, 0.0))


@dataclass(frozen=True)
class FabrikResult:
    positions: Tuple[Vector3, ...] = field(default_factory=tuple)
    target: Vector3 = (0.0, 0.0, 0.0)
    reached: bool = False
    stretched: bool = False
    iterations: int = 0
    error: float = 0.0


@dataclass(frozen=True)
class ContactIKSample:
    semantic_side: str
    frame: float
    hip_path: str
    knee_path: str
    foot_path: str
    anchor_position: Vector3
    before_positions: Tuple[Vector3, Vector3, Vector3]
    solved_positions: Tuple[Vector3, Vector3, Vector3]
    reached: bool
    error: float
    pelvis_offset: Vector3 = (0.0, 0.0, 0.0)
    shifted_positions: Tuple[Vector3, Vector3, Vector3] = field(default_factory=tuple)
    target_position: Vector3 = (0.0, 0.0, 0.0)
    weight: float = 1.0
    ground_rotation: Quaternion = (0.0, 0.0, 0.0, 1.0)


@dataclass(frozen=True)
class PelvisCompensation:
    frame: float
    target_path: str
    world_offset: Vector3
    residual: float = 0.0
    desired_world_position: Vector3 = (0.0, 0.0, 0.0)


@dataclass(frozen=True)
class RootGroundCorrection:
    frame: float
    target_path: str
    desired_world_rotation: Quaternion
    ground_normal: Vector3
    angle_degrees: float = 0.0


@dataclass(frozen=True)
class ContactIKLayerKey:
    semantic_role: str
    target_path: str
    frame: float
    expected_translation: Vector3
    expected_rotation: Tuple[float, float, float, float]
    desired_translation: Vector3
    desired_rotation: Tuple[float, float, float, float]
    write_translation: bool = False


@dataclass(frozen=True)
class ContactIKAnchorTarget:
    frame: float
    target_path: str
    world_position: Vector3


@dataclass(frozen=True)
class ContactIKLayerPlan:
    layer_name: str
    target_root: str
    source_label: str
    keys: Tuple[ContactIKLayerKey, ...] = field(default_factory=tuple)
    anchors: Tuple[ContactIKAnchorTarget, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def can_apply(self):
        return bool(self.keys) and not self.blockers

    @property
    def is_noop(self):
        return not self.keys and not self.blockers


@dataclass(frozen=True)
class ContactIKLayerReceipt:
    plan: ContactIKLayerPlan
    layer_name: str
    verified: bool
    maximum_translation_error: float
    maximum_rotation_error_degrees: float
    maximum_anchor_error: float
    message: str


@dataclass(frozen=True)
class RetargetContactIKPreview:
    samples: Tuple[ContactIKSample, ...] = field(default_factory=tuple)
    pelvis_compensations: Tuple[PelvisCompensation, ...] = field(default_factory=tuple)
    root_corrections: Tuple[RootGroundCorrection, ...] = field(default_factory=tuple)
    settings: ContactIKSettings = field(default_factory=ContactIKSettings)
    solved_count: int = 0
    unreachable_count: int = 0
    maximum_error: float = 0.0
    maximum_pelvis_offset: float = 0.0
    maximum_ground_angle_degrees: float = 0.0

    def samples_at_frame(self, frame):
        return tuple(item for item in self.samples if abs(item.frame - frame) <= 1e-6)


def solve_fabrik(
    positions: Iterable[Vector3],
    target: Vector3,
    pole: Vector3 | None = None,
    tolerance: float = 1e-4,
    maximum_iterations: int = 32,
) -> FabrikResult:
    values = tuple(tuple(float(component) for component in point) for point in positions)
    target_value = tuple(float(component) for component in target)
    if len(values) < 2:
        raise ValueError("FABRIK 至少需要两个链节点")
    if any(len(point) != 3 for point in values) or len(target_value) != 3:
        raise ValueError("FABRIK 只接受三维位置")
    lengths = tuple(_distance(left, right) for left, right in zip(values, values[1:]))
    if any(length <= 1e-8 for length in lengths):
        raise ValueError("FABRIK 链包含零长度段")
    root = values[0]
    reach = sum(lengths)
    root_distance = _distance(root, target_value)
    if root_distance >= reach - tolerance:
        direction = _normalize(_sub(target_value, root), fallback=(1.0, 0.0, 0.0))
        result = [root]
        for length in lengths:
            result.append(_add(result[-1], _scale(direction, length)))
        error = _distance(result[-1], target_value)
        return FabrikResult(tuple(result), target_value, error <= tolerance, True, 1, error)
    if len(values) == 3 and pole is not None:
        result = _solve_two_bone(root, target_value, lengths[0], lengths[1], pole)
        error = _distance(result[-1], target_value)
        return FabrikResult(tuple(result), target_value, error <= tolerance, False, 1, error)
    result = [tuple(point) for point in values]
    iterations = 0
    for iterations in range(1, max(1, int(maximum_iterations)) + 1):
        result[-1] = target_value
        for index in range(len(result) - 2, -1, -1):
            direction = _normalize(_sub(result[index], result[index + 1]))
            result[index] = _add(result[index + 1], _scale(direction, lengths[index]))
        result[0] = root
        for index in range(len(result) - 1):
            direction = _normalize(_sub(result[index + 1], result[index]))
            result[index + 1] = _add(result[index], _scale(direction, lengths[index]))
        if _distance(result[-1], target_value) <= tolerance:
            break
    error = _distance(result[-1], target_value)
    return FabrikResult(tuple(result), target_value, error <= tolerance, False, iterations, error)


def preview_retarget_contact_ik(
    actual_clip: ClipAsset,
    preview: RetargetClipPreview,
    profile: RetargetProfile,
    settings: ContactIKSettings | None = None,
    tolerance: float = 1e-4,
) -> RetargetContactIKPreview:
    if len(actual_clip.frames) != len(preview.frames):
        raise ValueError("接触 IK 要求实际结果与 Ghost Preview 采样数量一致")
    settings = settings or ContactIKSettings()
    normal = _normalize(settings.ground_normal, fallback=(0.0, 0.0, 0.0))
    if _length(normal) <= 1e-8:
        raise ValueError("地面法线不能是零向量")
    fade_frames = int(settings.fade_frames)
    if not 0 <= fade_frames <= 30:
        raise ValueError("接触权重过渡帧必须在 0 到 30 之间")
    offset_names = tuple(name for name, _value in settings.anchor_offsets)
    if len(offset_names) != len(set(offset_names)) or any(name not in {"left", "right"} for name in offset_names):
        raise ValueError("脚底锚点偏移只允许唯一的 left/right 项")
    samples = []
    pelvis_compensations = []
    root_corrections = []
    actual_by_frame = {frame.frame: frame for frame in actual_clip.frames}
    ghost_by_frame = {item.frame.frame: item.frame for item in preview.frames}
    frame_values = tuple(frame.frame for frame in actual_clip.frames)
    frame_indices = {value: index for index, value in enumerate(frame_values)}
    pelvis_mapping = profile.mapping("pelvis")
    root_mapping = profile.mapping("root")
    constraints_by_frame = {}
    definitions = []
    for contact in preview.contacts:
        side = contact.semantic_role.split("_", 1)[0]
        upper_mapping = profile.mapping(f"{side}_upper_leg")
        lower_mapping = profile.mapping(f"{side}_lower_leg")
        foot_mapping = profile.mapping(f"{side}_foot")
        if not all((upper_mapping, lower_mapping, foot_mapping)):
            continue
        interval_frames = tuple(
            frame.frame for frame in actual_clip.frames
            if contact.start_frame - 1e-6 <= frame.frame <= contact.end_frame + 1e-6
        )
        ghost_feet = []
        for frame in interval_frames:
            ghost = ghost_by_frame[frame]
            foot = next((node for node in ghost.nodes if node.node_path == foot_mapping.target_path), None)
            if foot:
                ghost_feet.append(foot.world_translation)
        if not ghost_feet:
            continue
        anchor = tuple(sum(value[axis] for value in ghost_feet) / len(ghost_feet) for axis in range(3))
        definitions.append((
            side, upper_mapping, lower_mapping, foot_mapping, anchor,
            frame_indices[interval_frames[0]], frame_indices[interval_frames[-1]],
        ))
    if not definitions:
        return RetargetContactIKPreview(settings=settings)
    plane_seed = tuple(
        sum(item[4][axis] for item in definitions) / len(definitions) for axis in range(3)
    )
    plane_origin = _add(plane_seed, _scale(normal, float(settings.ground_offset)))
    for side, upper_mapping, lower_mapping, foot_mapping, raw_anchor, lower, upper in definitions:
        anchor = _add(
            _project_to_plane(raw_anchor, plane_origin, normal),
            settings.anchor_offset(side),
        )
        start = max(0, lower - fade_frames)
        end = min(len(frame_values) - 1, upper + fade_frames)
        for index in range(start, end + 1):
            weight = _contact_weight(index, lower, upper, fade_frames)
            if weight <= 1e-8:
                continue
            constraints_by_frame.setdefault(frame_values[index], []).append((
                side, upper_mapping, lower_mapping, foot_mapping, anchor, weight,
            ))
    for frame in sorted(constraints_by_frame):
        actual = actual_by_frame[frame]
        by_path = {node.node_path: node for node in actual.nodes}
        root = by_path.get(root_mapping.target_path) if root_mapping else None
        frame_weight = max(item[5] for item in constraints_by_frame[frame])
        if settings.align_root_to_ground and root:
            current_up = _rotate_vector(root.world_rotation, (0.0, 1.0, 0.0))
            ground_rotation = _slerp_quaternion(
                (0.0, 0.0, 0.0, 1.0),
                _quaternion_between(current_up, normal),
                frame_weight,
            )
            root_world_rotation = _normalize_quaternion(
                _multiply_quaternion(ground_rotation, root.world_rotation)
            )
            ground_angle = _quaternion_error_degrees(
                (0.0, 0.0, 0.0, 1.0), ground_rotation
            )
            pivot = root.world_translation
            root_corrections.append(RootGroundCorrection(
                frame=frame,
                target_path=root.node_path,
                desired_world_rotation=root_world_rotation,
                ground_normal=normal,
                angle_degrees=ground_angle,
            ))
        else:
            ground_rotation = (0.0, 0.0, 0.0, 1.0)
            ground_angle = 0.0
            pivot = root.world_translation if root else (0.0, 0.0, 0.0)
        chains = []
        for side, upper_mapping, lower_mapping, foot_mapping, anchor, weight in constraints_by_frame[frame]:
            paths = (upper_mapping.target_path, lower_mapping.target_path, foot_mapping.target_path)
            if not all(path in by_path for path in paths):
                continue
            before = tuple(by_path[path].world_translation for path in paths)
            grounded = tuple(
                _add(pivot, _rotate_vector(ground_rotation, _sub(position, pivot)))
                for position in before
            )
            target = _lerp(grounded[-1], anchor, weight)
            chains.append((
                side, upper_mapping, lower_mapping, foot_mapping, anchor,
                before, grounded, target, weight,
            ))
        if not chains:
            continue
        pelvis_offset, pelvis_residual = _solve_pelvis_offset(
            tuple(value[6] for value in chains), tuple(value[7] for value in chains), tolerance
        ) if pelvis_mapping else ((0.0, 0.0, 0.0), 0.0)
        if pelvis_mapping:
            pelvis_node = by_path.get(pelvis_mapping.target_path)
            grounded_pelvis = (
                _add(pivot, _rotate_vector(
                    ground_rotation, _sub(pelvis_node.world_translation, pivot)
                )) if pelvis_node else (0.0, 0.0, 0.0)
            )
            pelvis_compensations.append(PelvisCompensation(
                frame=frame,
                target_path=pelvis_mapping.target_path,
                world_offset=pelvis_offset,
                residual=pelvis_residual,
                desired_world_position=_add(grounded_pelvis, pelvis_offset),
            ))
        for side, upper_mapping, lower_mapping, foot_mapping, anchor, before, grounded, target, weight in chains:
            hip, knee, foot = before
            shifted = tuple(_add(position, pelvis_offset) for position in grounded)
            pole_direction = _sub(grounded[1], _scale(_add(grounded[0], grounded[2]), 0.5))
            pole = _add(
                shifted[1],
                _scale(
                    _normalize(pole_direction, fallback=(0.0, 0.0, 1.0)),
                    max(_distance(hip, knee), 1.0),
                ),
            )
            solved = solve_fabrik(shifted, target, pole=pole, tolerance=tolerance)
            samples.append(ContactIKSample(
                semantic_side=side,
                frame=frame,
                hip_path=upper_mapping.target_path,
                knee_path=lower_mapping.target_path,
                foot_path=foot_mapping.target_path,
                anchor_position=anchor,
                before_positions=before,
                solved_positions=solved.positions,
                reached=solved.reached,
                error=solved.error,
                pelvis_offset=pelvis_offset,
                shifted_positions=shifted,
                target_position=target,
                weight=weight,
                ground_rotation=ground_rotation,
            ))
    return RetargetContactIKPreview(
        samples=tuple(samples),
        pelvis_compensations=tuple(pelvis_compensations),
        root_corrections=tuple(root_corrections),
        settings=settings,
        solved_count=sum(item.reached for item in samples),
        unreachable_count=sum(not item.reached for item in samples),
        maximum_error=max((item.error for item in samples), default=0.0),
        maximum_pelvis_offset=max(
            (_length(item.world_offset) for item in pelvis_compensations), default=0.0
        ),
        maximum_ground_angle_degrees=max(
            (item.angle_degrees for item in root_corrections), default=0.0
        ),
    )


def plan_contact_ik_layer(
    actual_clip: ClipAsset,
    preview: RetargetContactIKPreview,
    profile: RetargetProfile,
    layer_name: str,
    maximum_keys: int = 50_000,
    maximum_pelvis_ratio: float = 0.25,
    tolerance: float = 1e-6,
) -> ContactIKLayerPlan:
    blockers = []
    if not preview.samples:
        blockers.append("接触 IK 预览不包含任何约束链")
    if preview.unreachable_count:
        blockers.append(f"仍有 {preview.unreachable_count} 个接触链帧不可达")
    frames = {frame.frame: frame for frame in actual_clip.frames}
    sample_frames = {sample.frame for sample in preview.samples}
    if not sample_frames.issubset(frames):
        blockers.append("接触 IK 预览帧与目标实际 Clip 不一致")
    pelvis_mapping = profile.mapping("pelvis")
    root_mapping = profile.mapping("root")
    if preview.pelvis_compensations and not pelvis_mapping:
        blockers.append("骨盆补偿需要 pelvis 语义映射")
    if preview.root_corrections and not root_mapping:
        blockers.append("地面法线根朝向需要 root 语义映射")
    minimum_reach = min((
        _distance(sample.before_positions[0], sample.before_positions[1])
        + _distance(sample.before_positions[1], sample.before_positions[2])
        for sample in preview.samples
    ), default=0.0)
    if minimum_reach and preview.maximum_pelvis_offset > minimum_reach * maximum_pelvis_ratio:
        blockers.append(
            f"骨盆补偿 {preview.maximum_pelvis_offset:.4f} 超过腿链长度的 {maximum_pelvis_ratio:.0%} 安全上限"
        )
    desired_by_frame_path = {}
    roles_by_path = {}
    correction_by_frame = {item.frame: item for item in preview.pelvis_compensations}
    root_correction_by_frame = {item.frame: item for item in preview.root_corrections}
    samples_by_frame = {}
    for sample in preview.samples:
        samples_by_frame.setdefault(sample.frame, []).append(sample)
    if not blockers:
        for frame_value, frame in frames.items():
            by_path = {node.node_path: node for node in frame.nodes}
            by_key = {node.key: node for node in frame.nodes}
            root_correction = root_correction_by_frame.get(frame_value)
            root = by_path.get(root_mapping.target_path) if root_mapping else None
            if root_correction and root:
                parent = by_key.get(root.parent_key)
                parent_rotation = parent.world_rotation if parent else (0.0, 0.0, 0.0, 1.0)
                desired_root = _desired_channel_rotation(
                    root, parent_rotation, parent_rotation,
                    root_correction.desired_world_rotation,
                )
                desired_by_frame_path[(frame_value, root.node_path)] = (
                    root.local_translation, desired_root, False,
                )
                roles_by_path[root.node_path] = "root"
            correction = correction_by_frame.get(frame_value)
            if correction and pelvis_mapping:
                pelvis = by_path.get(pelvis_mapping.target_path)
                if pelvis is None:
                    blockers.append(f"第 {frame_value:g} 帧缺少 pelvis 目标节点")
                else:
                    parent = by_key.get(pelvis.parent_key)
                    parent_rotation = parent.world_rotation if parent else (0.0, 0.0, 0.0, 1.0)
                    desired_parent_rotation = (
                        root_correction.desired_world_rotation
                        if root_correction and root and parent and parent.node_path == root.node_path
                        else parent_rotation
                    )
                    parent_position = parent.world_translation if parent else (0.0, 0.0, 0.0)
                    desired_translation = _rotate_vector(
                        _inverse_quaternion(desired_parent_rotation),
                        _sub(correction.desired_world_position, parent_position),
                    )
                    desired_by_frame_path[(frame_value, pelvis.node_path)] = (
                        desired_translation, pelvis.local_rotation, True,
                    )
                    roles_by_path[pelvis.node_path] = "pelvis"
            for sample in samples_by_frame.get(frame_value, ()):
                hip = by_path.get(sample.hip_path)
                knee = by_path.get(sample.knee_path)
                foot = by_path.get(sample.foot_path)
                if not all((hip, knee, foot)):
                    blockers.append(f"第 {frame_value:g} 帧缺少 {sample.semantic_side} 腿链节点")
                    continue
                shifted = sample.shifted_positions or tuple(
                    _add(position, sample.pelvis_offset) for position in sample.before_positions
                )
                solved = sample.solved_positions
                hip_delta = _quaternion_between(_sub(shifted[1], shifted[0]), _sub(solved[1], solved[0]))
                knee_delta = _quaternion_between(_sub(shifted[2], shifted[1]), _sub(solved[2], solved[1]))
                ground_hip_world = _normalize_quaternion(
                    _multiply_quaternion(sample.ground_rotation, hip.world_rotation)
                )
                ground_knee_world = _normalize_quaternion(
                    _multiply_quaternion(sample.ground_rotation, knee.world_rotation)
                )
                ground_foot_world = _normalize_quaternion(
                    _multiply_quaternion(sample.ground_rotation, foot.world_rotation)
                )
                desired_hip_world = _normalize_quaternion(_multiply_quaternion(hip_delta, ground_hip_world))
                desired_knee_world = _normalize_quaternion(_multiply_quaternion(knee_delta, ground_knee_world))
                desired_foot_world = ground_foot_world
                hip_parent = by_key.get(hip.parent_key)
                hip_parent_world = hip_parent.world_rotation if hip_parent else (0.0, 0.0, 0.0, 1.0)
                desired_hip_parent_world = _normalize_quaternion(
                    _multiply_quaternion(sample.ground_rotation, hip_parent_world)
                )
                desired_hip = _desired_channel_rotation(
                    hip, hip_parent_world, desired_hip_parent_world, desired_hip_world
                )
                desired_knee = _desired_channel_rotation(
                    knee, hip.world_rotation, desired_hip_world, desired_knee_world
                )
                desired_foot = _desired_channel_rotation(
                    foot, knee.world_rotation, desired_knee_world, desired_foot_world
                )
                for role, node, rotation in (
                    (f"{sample.semantic_side}_upper_leg", hip, desired_hip),
                    (f"{sample.semantic_side}_lower_leg", knee, desired_knee),
                    (f"{sample.semantic_side}_foot", foot, desired_foot),
                ):
                    desired_by_frame_path[(frame_value, node.node_path)] = (
                        node.local_translation, rotation, False,
                    )
                    roles_by_path[node.node_path] = role
    changed_paths = set()
    for (frame_value, path), (translation, rotation, write_translation) in desired_by_frame_path.items():
        node = next(item for item in frames[frame_value].nodes if item.node_path == path)
        if (
            (write_translation and _distance(node.local_translation, translation) > tolerance)
            or _quaternion_error_degrees(node.local_rotation, rotation) > tolerance
        ):
            changed_paths.add(path)
    keys = []
    for frame in actual_clip.frames:
        by_path = {node.node_path: node for node in frame.nodes}
        for path in sorted(changed_paths):
            node = by_path.get(path)
            if node is None:
                blockers.append(f"第 {frame.frame:g} 帧缺少接触 IK 目标节点：{path}")
                continue
            desired = desired_by_frame_path.get(
                (frame.frame, path), (node.local_translation, node.local_rotation, path == (pelvis_mapping.target_path if pelvis_mapping else ""))
            )
            keys.append(ContactIKLayerKey(
                semantic_role=roles_by_path.get(path, node.key),
                target_path=path,
                frame=frame.frame,
                expected_translation=node.local_translation,
                expected_rotation=node.local_rotation,
                desired_translation=desired[0],
                desired_rotation=desired[1],
                write_translation=bool(desired[2]),
            ))
    if len(keys) > maximum_keys:
        blockers.append(f"接触 IK 计划包含 {len(keys)} 个节点帧，交互上限为 {maximum_keys}")
    return ContactIKLayerPlan(
        layer_name=str(layer_name),
        target_root=profile.target_root,
        source_label=actual_clip.label,
        keys=tuple(keys),
        anchors=tuple(ContactIKAnchorTarget(
            frame=sample.frame,
            target_path=sample.foot_path,
            world_position=sample.target_position,
        ) for sample in preview.samples),
        blockers=tuple(dict.fromkeys(blockers)),
    )


def _solve_two_bone(root, target, upper_length, lower_length, pole):
    axis_vector = _sub(target, root)
    distance = _length(axis_vector)
    axis = _normalize(axis_vector, fallback=(1.0, 0.0, 0.0))
    minimum = abs(upper_length - lower_length)
    if distance < minimum + 1e-8:
        # The requested point lies inside the chain's minimum reach.
        direction = axis if upper_length >= lower_length else _scale(axis, -1.0)
        knee = _add(root, _scale(direction, upper_length))
        end = _add(knee, _scale(direction, -lower_length))
        return root, knee, end
    along = (upper_length ** 2 - lower_length ** 2 + distance ** 2) / (2.0 * distance)
    height = math.sqrt(max(0.0, upper_length ** 2 - along ** 2))
    pole_offset = _sub(pole, root)
    plane = _sub(pole_offset, _scale(axis, _dot(pole_offset, axis)))
    if _length(plane) <= 1e-8:
        seed = (0.0, 1.0, 0.0) if abs(axis[1]) < 0.9 else (0.0, 0.0, 1.0)
        plane = _cross(axis, seed)
    plane = _normalize(plane)
    knee = _add(_add(root, _scale(axis, along)), _scale(plane, height))
    return root, knee, target


def _project_to_plane(point, origin, normal):
    return _sub(point, _scale(normal, _dot(_sub(point, origin), normal)))


def _contact_weight(index, lower, upper, fade_frames):
    if lower <= index <= upper:
        return 1.0
    if fade_frames <= 0:
        return 0.0
    if index < lower:
        amount = (index - (lower - fade_frames)) / float(fade_frames)
    else:
        amount = ((upper + fade_frames) - index) / float(fade_frames)
    amount = max(0.0, min(1.0, amount))
    return amount * amount * (3.0 - 2.0 * amount)


def _solve_pelvis_offset(chains, anchors, tolerance, maximum_iterations=96):
    """Project the smallest pelvis offset into every active leg reach sphere."""
    balls = []
    for chain, anchor in zip(chains, anchors):
        reach = sum(_distance(left, right) for left, right in zip(chain, chain[1:]))
        center = _sub(anchor, chain[0])
        balls.append((center, max(reach - max(tolerance * 2.0, 1e-7), 1e-7)))
    if not balls:
        return (0.0, 0.0, 0.0), 0.0
    value = (0.0, 0.0, 0.0)
    corrections = [(0.0, 0.0, 0.0) for _ball in balls]
    for _iteration in range(maximum_iterations):
        previous = value
        for index, (center, radius) in enumerate(balls):
            candidate = _add(value, corrections[index])
            offset = _sub(candidate, center)
            distance = _length(offset)
            if distance > radius:
                projected = _add(center, _scale(offset, radius / distance))
            else:
                projected = candidate
            corrections[index] = _sub(candidate, projected)
            value = projected
        residual = max(
            max(0.0, _distance(value, center) - radius) for center, radius in balls
        )
        if residual <= tolerance and _distance(value, previous) <= tolerance:
            break
    residual = max(max(0.0, _distance(value, center) - radius) for center, radius in balls)
    return value, residual


def _desired_channel_rotation(node, current_parent_world, desired_parent_world, desired_world):
    current_local_total = _multiply_quaternion(
        _inverse_quaternion(current_parent_world), node.world_rotation
    )
    static_axis_offset = _multiply_quaternion(
        current_local_total, _inverse_quaternion(node.local_rotation)
    )
    desired_local_total = _multiply_quaternion(
        _inverse_quaternion(desired_parent_world), desired_world
    )
    return _normalize_quaternion(_multiply_quaternion(
        _inverse_quaternion(static_axis_offset), desired_local_total
    ))


def _quaternion_between(source, target):
    left = _normalize(source, fallback=(1.0, 0.0, 0.0))
    right = _normalize(target, fallback=left)
    dot = max(-1.0, min(1.0, _dot(left, right)))
    if dot >= 1.0 - 1e-10:
        return (0.0, 0.0, 0.0, 1.0)
    if dot <= -1.0 + 1e-10:
        seed = (1.0, 0.0, 0.0) if abs(left[0]) < 0.8 else (0.0, 1.0, 0.0)
        axis = _normalize(_cross(left, seed), fallback=(0.0, 0.0, 1.0))
        return (axis[0], axis[1], axis[2], 0.0)
    cross = _cross(left, right)
    return _normalize_quaternion((cross[0], cross[1], cross[2], 1.0 + dot))


def _slerp_quaternion(left, right, amount):
    first = _normalize_quaternion(left)
    second = _normalize_quaternion(right)
    dot = sum(a * b for a, b in zip(first, second))
    if dot < 0.0:
        second = tuple(-value for value in second)
        dot = -dot
    dot = max(-1.0, min(1.0, dot))
    weight = max(0.0, min(1.0, float(amount)))
    if dot > 0.9995:
        return _normalize_quaternion(tuple(
            a + (b - a) * weight for a, b in zip(first, second)
        ))
    angle = math.acos(dot)
    sine = math.sin(angle)
    return tuple(
        a * math.sin((1.0 - weight) * angle) / sine
        + b * math.sin(weight * angle) / sine
        for a, b in zip(first, second)
    )


def _multiply_quaternion(left, right):
    ax, ay, az, aw = left
    bx, by, bz, bw = right
    return (
        aw * bx + ax * bw + ay * bz - az * by,
        aw * by - ax * bz + ay * bw + az * bx,
        aw * bz + ax * by - ay * bx + az * bw,
        aw * bw - ax * bx - ay * by - az * bz,
    )


def _normalize_quaternion(value):
    magnitude = math.sqrt(sum(component * component for component in value))
    return tuple(component / magnitude for component in value) if magnitude > 1e-12 else (0.0, 0.0, 0.0, 1.0)


def _inverse_quaternion(value):
    normalized = _normalize_quaternion(value)
    return (-normalized[0], -normalized[1], -normalized[2], normalized[3])


def _rotate_vector(quaternion, vector):
    value = (float(vector[0]), float(vector[1]), float(vector[2]), 0.0)
    rotated = _multiply_quaternion(
        _multiply_quaternion(quaternion, value), _inverse_quaternion(quaternion)
    )
    return rotated[:3]


def _quaternion_error_degrees(left, right):
    first, second = _normalize_quaternion(left), _normalize_quaternion(right)
    dot = max(-1.0, min(1.0, abs(sum(a * b for a, b in zip(first, second)))))
    return math.degrees(2.0 * math.acos(dot))


def _add(left, right):
    return tuple(a + b for a, b in zip(left, right))


def _sub(left, right):
    return tuple(a - b for a, b in zip(left, right))


def _scale(value, amount):
    return tuple(component * amount for component in value)


def _lerp(left, right, amount):
    return tuple(a + (b - a) * amount for a, b in zip(left, right))


def _dot(left, right):
    return sum(a * b for a, b in zip(left, right))


def _cross(left, right):
    return (
        left[1] * right[2] - left[2] * right[1],
        left[2] * right[0] - left[0] * right[2],
        left[0] * right[1] - left[1] * right[0],
    )


def _length(value):
    return math.sqrt(sum(component * component for component in value))


def _normalize(value, fallback=(1.0, 0.0, 0.0)):
    length = _length(value)
    return tuple(component / length for component in value) if length > 1e-12 else tuple(fallback)


def _distance(left, right):
    return _length(_sub(left, right))


__all__ = [
    "ContactIKAnchorTarget", "ContactIKLayerKey", "ContactIKLayerPlan", "ContactIKLayerReceipt",
    "ContactIKSample", "ContactIKSettings", "FabrikResult", "PelvisCompensation",
    "RetargetContactIKPreview", "RootGroundCorrection",
    "plan_contact_ik_layer", "preview_retarget_contact_ik", "solve_fabrik",
]
