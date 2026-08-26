"""Versioned, host-independent Pose and Clip data for animation/retarget workflows."""

from __future__ import annotations

from dataclasses import dataclass, field
import hashlib
import json
import math
from typing import Iterable, Mapping, Sequence, Tuple


Vector3 = Tuple[float, float, float]
Quaternion = Tuple[float, float, float, float]
ScalarChannel = Tuple[str, float]


@dataclass(frozen=True)
class PoseNode:
    key: str
    node_path: str
    parent_key: str = ""
    local_translation: Vector3 = (0.0, 0.0, 0.0)
    local_rotation: Quaternion = (0.0, 0.0, 0.0, 1.0)
    local_scale: Vector3 = (1.0, 1.0, 1.0)
    world_translation: Vector3 = (0.0, 0.0, 0.0)
    world_rotation: Quaternion = (0.0, 0.0, 0.0, 1.0)
    custom_channels: Tuple[ScalarChannel, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class PoseFrame:
    frame: float
    nodes: Tuple[PoseNode, ...] = field(default_factory=tuple)

    def node(self, key: str):
        return next((item for item in self.nodes if item.key == key), None)


@dataclass(frozen=True)
class PoseAsset:
    label: str
    character_id: str
    frame: PoseFrame
    schema_version: int = 1
    source: str = "MayaCraft"

    @property
    def fingerprint(self):
        payload = pose_asset_to_dict(self)
        return hashlib.sha256(
            json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
        ).hexdigest()


@dataclass(frozen=True)
class ClipAsset:
    label: str
    character_id: str
    frames_per_second: float
    frames: Tuple[PoseFrame, ...] = field(default_factory=tuple)
    schema_version: int = 1
    source: str = "MayaCraft"

    @property
    def start_frame(self):
        return self.frames[0].frame if self.frames else 0.0

    @property
    def end_frame(self):
        return self.frames[-1].frame if self.frames else 0.0

    @property
    def channel_keys(self):
        return tuple(node.key for node in self.frames[0].nodes) if self.frames else ()

    @property
    def fingerprint(self):
        payload = clip_asset_to_dict(self)
        return hashlib.sha256(
            json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
        ).hexdigest()


@dataclass(frozen=True)
class PoseDifference:
    matched_keys: Tuple[str, ...] = field(default_factory=tuple)
    missing_left: Tuple[str, ...] = field(default_factory=tuple)
    missing_right: Tuple[str, ...] = field(default_factory=tuple)
    rms_world_translation: float = 0.0
    maximum_world_translation: float = 0.0
    rms_world_rotation_degrees: float = 0.0
    maximum_world_rotation_degrees: float = 0.0


def validate_pose_frame(frame: PoseFrame) -> Tuple[str, ...]:
    issues = []
    keys = tuple(node.key for node in frame.nodes)
    if not frame.nodes:
        issues.append("姿态不包含任何节点")
    duplicates = tuple(sorted({key for key in keys if keys.count(key) > 1}))
    if duplicates:
        issues.append("姿态节点键重复：" + "，".join(duplicates))
    key_set = set(keys)
    for node in frame.nodes:
        if not node.key:
            issues.append("姿态包含空节点键")
        if node.parent_key and node.parent_key not in key_set:
            issues.append(f"{node.key} 的父节点键 {node.parent_key} 不在姿态中")
        if len(node.local_rotation) != 4 or len(node.world_rotation) != 4:
            issues.append(f"{node.key} 的四元数维度无效")
        channel_names = tuple(name for name, _value in node.custom_channels)
        if len(channel_names) != len(set(channel_names)):
            issues.append(f"{node.key} 的自定义通道重复")
    return tuple(dict.fromkeys(issues))


def validate_clip(clip: ClipAsset) -> Tuple[str, ...]:
    issues = []
    if clip.frames_per_second <= 0.0:
        issues.append("Clip 帧率必须大于零")
    if not clip.frames:
        issues.append("Clip 不包含任何采样帧")
        return tuple(issues)
    frame_numbers = tuple(frame.frame for frame in clip.frames)
    if any(upper <= lower for lower, upper in zip(frame_numbers, frame_numbers[1:])):
        issues.append("Clip 帧序列必须严格递增")
    reference = _frame_channel_signature(clip.frames[0])
    for frame in clip.frames:
        issues.extend(validate_pose_frame(frame))
        if _frame_channel_signature(frame) != reference:
            issues.append(f"第 {frame.frame:g} 帧的节点通道拓扑与首帧不一致")
    return tuple(dict.fromkeys(issues))


def blend_pose_frames(left: PoseFrame, right: PoseFrame, weight: float) -> PoseFrame:
    amount = max(0.0, min(1.0, float(weight)))
    left_map = {node.key: node for node in left.nodes}
    right_map = {node.key: node for node in right.nodes}
    if set(left_map) != set(right_map):
        raise ValueError("Pose 混合要求两侧具有完全一致的节点键")
    nodes = []
    for key in (node.key for node in left.nodes):
        source, target = left_map[key], right_map[key]
        if source.parent_key != target.parent_key:
            raise ValueError(f"Pose 混合时 {key} 的父节点语义不一致")
        source_custom = dict(source.custom_channels)
        target_custom = dict(target.custom_channels)
        if set(source_custom) != set(target_custom):
            raise ValueError(f"Pose 混合时 {key} 的自定义通道不一致")
        nodes.append(PoseNode(
            key=key,
            node_path=target.node_path or source.node_path,
            parent_key=source.parent_key,
            local_translation=_lerp_vector(source.local_translation, target.local_translation, amount),
            local_rotation=_slerp(source.local_rotation, target.local_rotation, amount),
            local_scale=_lerp_vector(source.local_scale, target.local_scale, amount),
            world_translation=_lerp_vector(source.world_translation, target.world_translation, amount),
            world_rotation=_slerp(source.world_rotation, target.world_rotation, amount),
            custom_channels=tuple(
                (name, source_custom[name] + (target_custom[name] - source_custom[name]) * amount)
                for name in sorted(source_custom)
            ),
        ))
    return PoseFrame(
        frame=left.frame + (right.frame - left.frame) * amount,
        nodes=tuple(nodes),
    )


def compare_pose_frames(left: PoseFrame, right: PoseFrame) -> PoseDifference:
    left_map = {node.key: node for node in left.nodes}
    right_map = {node.key: node for node in right.nodes}
    matched = tuple(sorted(set(left_map) & set(right_map)))
    translations = tuple(
        _distance(left_map[key].world_translation, right_map[key].world_translation)
        for key in matched
    )
    rotations = tuple(
        _quaternion_error_degrees(left_map[key].world_rotation, right_map[key].world_rotation)
        for key in matched
    )
    return PoseDifference(
        matched_keys=matched,
        missing_left=tuple(sorted(set(right_map) - set(left_map))),
        missing_right=tuple(sorted(set(left_map) - set(right_map))),
        rms_world_translation=_rms(translations),
        maximum_world_translation=max(translations, default=0.0),
        rms_world_rotation_degrees=_rms(rotations),
        maximum_world_rotation_degrees=max(rotations, default=0.0),
    )


def pose_asset_to_dict(asset: PoseAsset) -> dict:
    return {
        "schema": "mayacraft.pose",
        "version": int(asset.schema_version),
        "label": asset.label,
        "character_id": asset.character_id,
        "source": asset.source,
        "frame": _frame_to_dict(asset.frame),
    }


def pose_asset_from_dict(payload: Mapping) -> PoseAsset:
    if payload.get("schema") != "mayacraft.pose":
        raise ValueError("不是 MayaCraft Pose 数据")
    if int(payload.get("version", 0)) != 1:
        raise ValueError(f"不支持的 Pose schema 版本：{payload.get('version')}")
    asset = PoseAsset(
        label=str(payload.get("label", "")),
        character_id=str(payload.get("character_id", "")),
        frame=_frame_from_dict(payload["frame"]),
        schema_version=1,
        source=str(payload.get("source", "MayaCraft")),
    )
    issues = validate_pose_frame(asset.frame)
    if issues:
        raise ValueError("；".join(issues))
    return asset


def clip_asset_to_dict(asset: ClipAsset) -> dict:
    return {
        "schema": "mayacraft.clip",
        "version": int(asset.schema_version),
        "label": asset.label,
        "character_id": asset.character_id,
        "frames_per_second": asset.frames_per_second,
        "source": asset.source,
        "frames": [_frame_to_dict(frame) for frame in asset.frames],
    }


def clip_asset_from_dict(payload: Mapping) -> ClipAsset:
    if payload.get("schema") != "mayacraft.clip":
        raise ValueError("不是 MayaCraft Clip 数据")
    if int(payload.get("version", 0)) != 1:
        raise ValueError(f"不支持的 Clip schema 版本：{payload.get('version')}")
    asset = ClipAsset(
        label=str(payload.get("label", "")),
        character_id=str(payload.get("character_id", "")),
        frames_per_second=float(payload.get("frames_per_second", 0.0)),
        frames=tuple(_frame_from_dict(frame) for frame in payload.get("frames", ())),
        schema_version=1,
        source=str(payload.get("source", "MayaCraft")),
    )
    issues = validate_clip(asset)
    if issues:
        raise ValueError("；".join(issues))
    return asset


def _frame_to_dict(frame):
    return {
        "frame": frame.frame,
        "nodes": [
            {
                "key": node.key,
                "path": node.node_path,
                "parent": node.parent_key,
                "local_t": list(node.local_translation),
                "local_q": list(node.local_rotation),
                "local_s": list(node.local_scale),
                "world_t": list(node.world_translation),
                "world_q": list(node.world_rotation),
                "custom": [[name, value] for name, value in node.custom_channels],
            }
            for node in frame.nodes
        ],
    }


def _frame_from_dict(payload):
    return PoseFrame(
        frame=float(payload["frame"]),
        nodes=tuple(PoseNode(
            key=str(node["key"]),
            node_path=str(node.get("path", "")),
            parent_key=str(node.get("parent", "")),
            local_translation=_vector(node.get("local_t", (0, 0, 0)), 3),
            local_rotation=_vector(node.get("local_q", (0, 0, 0, 1)), 4),
            local_scale=_vector(node.get("local_s", (1, 1, 1)), 3),
            world_translation=_vector(node.get("world_t", (0, 0, 0)), 3),
            world_rotation=_vector(node.get("world_q", (0, 0, 0, 1)), 4),
            custom_channels=tuple((str(name), float(value)) for name, value in node.get("custom", ())),
        ) for node in payload.get("nodes", ())),
    )


def _frame_channel_signature(frame):
    return tuple(
        (node.key, node.parent_key, tuple(name for name, _value in node.custom_channels))
        for node in frame.nodes
    )


def _vector(values: Sequence[float], size: int):
    result = tuple(float(value) for value in values)
    if len(result) != size:
        raise ValueError(f"向量维度应为 {size}，实际为 {len(result)}")
    return result


def _lerp_vector(left, right, amount):
    return tuple(a + (b - a) * amount for a, b in zip(left, right))


def _normalize_quaternion(value):
    magnitude = math.sqrt(sum(component * component for component in value))
    return tuple(component / magnitude for component in value) if magnitude > 1e-12 else (0.0, 0.0, 0.0, 1.0)


def _slerp(left, right, amount):
    first = _normalize_quaternion(left)
    second = _normalize_quaternion(right)
    dot = sum(a * b for a, b in zip(first, second))
    if dot < 0.0:
        second = tuple(-value for value in second)
        dot = -dot
    dot = max(-1.0, min(1.0, dot))
    if dot > 0.9995:
        return _normalize_quaternion(_lerp_vector(first, second, amount))
    angle = math.acos(dot)
    sine = math.sin(angle)
    left_weight = math.sin((1.0 - amount) * angle) / sine
    right_weight = math.sin(amount * angle) / sine
    return tuple(a * left_weight + b * right_weight for a, b in zip(first, second))


def _distance(left, right):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(left, right)))


def _quaternion_error_degrees(left, right):
    first, second = _normalize_quaternion(left), _normalize_quaternion(right)
    dot = max(-1.0, min(1.0, abs(sum(a * b for a, b in zip(first, second)))))
    return math.degrees(2.0 * math.acos(dot))


def _rms(values):
    return math.sqrt(sum(value * value for value in values) / len(values)) if values else 0.0


__all__ = [
    "ClipAsset", "PoseAsset", "PoseDifference", "PoseFrame", "PoseNode",
    "blend_pose_frames", "clip_asset_from_dict", "clip_asset_to_dict",
    "compare_pose_frames", "pose_asset_from_dict", "pose_asset_to_dict",
    "validate_clip", "validate_pose_frame",
]
