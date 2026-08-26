"""Versioned, portable Clip packages with a required reference pose."""

from __future__ import annotations

from dataclasses import dataclass, field
import hashlib
import json
from typing import Mapping, Tuple

from MayaCraft.domain.pose_clip import (
    ClipAsset,
    PoseFrame,
    PoseNode,
    clip_asset_from_dict,
    clip_asset_to_dict,
    validate_clip,
    validate_pose_frame,
)


@dataclass(frozen=True)
class ClipPackage:
    clip: ClipAsset
    reference_pose: PoseFrame
    package_version: int = 2
    display_name: str = ""
    tags: Tuple[str, ...] = field(default_factory=tuple)
    coordinate_forward: str = "+Z"
    coordinate_up: str = "+Y"
    metadata: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)
    migrated_from: str = ""

    @property
    def name(self):
        return str(self.display_name).strip() or self.clip.label or "未命名 Clip"

    @property
    def fingerprint(self):
        payload = clip_package_to_dict(self, include_fingerprint=False)
        return hashlib.sha256(
            json.dumps(
                payload, ensure_ascii=False, sort_keys=True,
                separators=(",", ":"), allow_nan=False,
            ).encode("utf-8")
        ).hexdigest()


def validate_clip_package(package: ClipPackage) -> Tuple[str, ...]:
    issues = list(validate_clip(package.clip))
    issues.extend(validate_pose_frame(package.reference_pose))
    if package.package_version != 2:
        issues.append(f"不支持的 Clip Package 版本：{package.package_version}")
    if package.clip.frames:
        reference_signature = tuple(
            (node.key, node.parent_key, tuple(name for name, _value in node.custom_channels))
            for node in package.reference_pose.nodes
        )
        clip_signature = tuple(
            (node.key, node.parent_key, tuple(name for name, _value in node.custom_channels))
            for node in package.clip.frames[0].nodes
        )
        if reference_signature != clip_signature:
            issues.append("Clip Package 的参考姿态与动画通道拓扑不一致")
    names = tuple(name for name, _value in package.metadata)
    if len(names) != len(set(names)):
        issues.append("Clip Package metadata 键重复")
    if not package.name.strip():
        issues.append("Clip Package 缺少资产显示名")
    normalized_tags = tuple(str(tag).strip() for tag in package.tags)
    if any(not tag for tag in normalized_tags):
        issues.append("Clip Package 标签不能为空")
    if len(normalized_tags) > 32 or any(len(tag) > 48 for tag in normalized_tags):
        issues.append("Clip Package 标签超过 32 个或单项超过 48 个字符")
    if len({tag.casefold() for tag in normalized_tags}) != len(normalized_tags):
        issues.append("Clip Package 标签重复")
    valid_axes = {"+X", "-X", "+Y", "-Y", "+Z", "-Z"}
    if package.coordinate_forward not in valid_axes:
        issues.append(f"Clip Package 向前轴无效：{package.coordinate_forward}")
    if package.coordinate_up not in valid_axes:
        issues.append(f"Clip Package 向上轴无效：{package.coordinate_up}")
    if (
        package.coordinate_forward in valid_axes
        and package.coordinate_up in valid_axes
        and package.coordinate_forward[-1] == package.coordinate_up[-1]
    ):
        issues.append("Clip Package 向前轴与向上轴不能平行")
    return tuple(dict.fromkeys(issues))


def clip_package_to_dict(package: ClipPackage, include_fingerprint=True) -> dict:
    issues = validate_clip_package(package)
    if issues:
        raise ValueError("；".join(issues))
    payload = {
        "schema": "mayacraft.clip.package",
        "version": 2,
        "asset": {
            "name": package.name,
            "tags": sorted(str(tag).strip() for tag in package.tags),
            "coordinate": {
                "forward": package.coordinate_forward,
                "up": package.coordinate_up,
            },
        },
        "clip": clip_asset_to_dict(package.clip),
        "reference_pose": _frame_to_dict(package.reference_pose),
        "metadata": {name: value for name, value in sorted(package.metadata)},
        "migrated_from": package.migrated_from,
    }
    if include_fingerprint:
        payload["fingerprint"] = package.fingerprint
    return payload


def clip_package_from_dict(payload: Mapping, allow_legacy=True) -> ClipPackage:
    schema = payload.get("schema")
    if schema == "mayacraft.clip" and allow_legacy:
        clip = clip_asset_from_dict(payload)
        if not clip.frames:
            raise ValueError("旧版 Clip 没有可作为参考姿态的首帧")
        package = ClipPackage(
            clip=clip,
            reference_pose=clip.frames[0],
            display_name=clip.label,
            migrated_from="mayacraft.clip/v1:first-frame-reference",
        )
        return package
    if schema != "mayacraft.clip.package":
        raise ValueError("不是 MayaCraft Clip Package 数据")
    version = int(payload.get("version", 0))
    if version == 1:
        if not allow_legacy:
            raise ValueError("当前操作不允许读取 Clip Package v1")
        return _migrate_v1_package(payload)
    if version != 2:
        raise ValueError(f"不支持的 Clip Package schema 版本：{payload.get('version')}")
    metadata = payload.get("metadata", {})
    if not isinstance(metadata, Mapping):
        raise ValueError("Clip Package metadata 必须是对象")
    asset = payload.get("asset", {})
    if not isinstance(asset, Mapping):
        raise ValueError("Clip Package v2 asset 必须是对象")
    tags = asset.get("tags", ())
    if not isinstance(tags, (list, tuple)):
        raise ValueError("Clip Package v2 tags 必须是数组")
    coordinate = asset.get("coordinate", {})
    if not isinstance(coordinate, Mapping):
        raise ValueError("Clip Package v2 coordinate 必须是对象")
    package = ClipPackage(
        clip=clip_asset_from_dict(payload["clip"]),
        reference_pose=_frame_from_dict(payload["reference_pose"]),
        package_version=2,
        display_name=str(asset.get("name", "")),
        tags=tuple(str(tag).strip() for tag in tags),
        coordinate_forward=str(coordinate.get("forward", "+Z")),
        coordinate_up=str(coordinate.get("up", "+Y")),
        metadata=tuple(sorted((str(name), str(value)) for name, value in metadata.items())),
        migrated_from=str(payload.get("migrated_from", "")),
    )
    issues = validate_clip_package(package)
    if issues:
        raise ValueError("；".join(issues))
    expected = str(payload.get("fingerprint", ""))
    if not expected:
        raise ValueError("Clip Package 缺少 fingerprint")
    if expected != package.fingerprint:
        raise ValueError("Clip Package fingerprint 校验失败，文件可能损坏或被修改")
    return package


def _migrate_v1_package(payload):
    expected = str(payload.get("fingerprint", ""))
    if not expected:
        raise ValueError("Clip Package v1 缺少 fingerprint")
    legacy_payload = dict(payload)
    legacy_payload.pop("fingerprint", None)
    actual = hashlib.sha256(
        json.dumps(
            legacy_payload, ensure_ascii=False, sort_keys=True,
            separators=(",", ":"), allow_nan=False,
        ).encode("utf-8")
    ).hexdigest()
    if actual != expected:
        raise ValueError("Clip Package v1 fingerprint 校验失败，文件可能损坏或被修改")
    metadata = payload.get("metadata", {})
    if not isinstance(metadata, Mapping):
        raise ValueError("Clip Package v1 metadata 必须是对象")
    clip = clip_asset_from_dict(payload["clip"])
    previous = str(payload.get("migrated_from", ""))
    migrated = "mayacraft.clip.package/v1"
    if previous:
        migrated += " <- " + previous
    package = ClipPackage(
        clip=clip,
        reference_pose=_frame_from_dict(payload["reference_pose"]),
        display_name=clip.label,
        metadata=tuple(sorted((str(name), str(value)) for name, value in metadata.items())),
        migrated_from=migrated,
    )
    issues = validate_clip_package(package)
    if issues:
        raise ValueError("；".join(issues))
    return package


def remap_clip_package_paths(package: ClipPackage, path_by_key: Mapping[str, str]) -> ClipPackage:
    required = tuple(node.key for node in package.reference_pose.nodes)
    missing = tuple(key for key in required if key not in path_by_key)
    if missing:
        raise ValueError("目标骨架缺少 Clip 节点键：" + "，".join(missing))

    def remap_frame(frame):
        return PoseFrame(frame.frame, tuple(PoseNode(
            key=node.key,
            node_path=str(path_by_key[node.key]),
            parent_key=node.parent_key,
            local_translation=node.local_translation,
            local_rotation=node.local_rotation,
            local_scale=node.local_scale,
            world_translation=node.world_translation,
            world_rotation=node.world_rotation,
            custom_channels=node.custom_channels,
        ) for node in frame.nodes))

    return ClipPackage(
        clip=ClipAsset(
            label=package.clip.label,
            character_id=package.clip.character_id,
            frames_per_second=package.clip.frames_per_second,
            frames=tuple(remap_frame(frame) for frame in package.clip.frames),
            schema_version=package.clip.schema_version,
            source=package.clip.source,
        ),
        reference_pose=remap_frame(package.reference_pose),
        package_version=package.package_version,
        display_name=package.display_name,
        tags=package.tags,
        coordinate_forward=package.coordinate_forward,
        coordinate_up=package.coordinate_up,
        metadata=package.metadata,
        migrated_from=package.migrated_from,
    )


def _frame_to_dict(frame):
    return {
        "frame": frame.frame,
        "nodes": [{
            "key": node.key,
            "path": node.node_path,
            "parent": node.parent_key,
            "local_t": list(node.local_translation),
            "local_q": list(node.local_rotation),
            "local_s": list(node.local_scale),
            "world_t": list(node.world_translation),
            "world_q": list(node.world_rotation),
            "custom": [[name, value] for name, value in node.custom_channels],
        } for node in frame.nodes],
    }


def _frame_from_dict(payload):
    def vector(values, size):
        result = tuple(float(value) for value in values)
        if len(result) != size:
            raise ValueError(f"参考姿态向量维度应为 {size}，实际为 {len(result)}")
        return result

    return PoseFrame(float(payload["frame"]), tuple(PoseNode(
        key=str(node["key"]),
        node_path=str(node.get("path", "")),
        parent_key=str(node.get("parent", "")),
        local_translation=vector(node.get("local_t", (0, 0, 0)), 3),
        local_rotation=vector(node.get("local_q", (0, 0, 0, 1)), 4),
        local_scale=vector(node.get("local_s", (1, 1, 1)), 3),
        world_translation=vector(node.get("world_t", (0, 0, 0)), 3),
        world_rotation=vector(node.get("world_q", (0, 0, 0, 1)), 4),
        custom_channels=tuple(
            (str(name), float(value)) for name, value in node.get("custom", ())
        ),
    ) for node in payload.get("nodes", ())))


__all__ = [
    "ClipPackage", "clip_package_from_dict", "clip_package_to_dict",
    "remap_clip_package_paths", "validate_clip_package",
]
