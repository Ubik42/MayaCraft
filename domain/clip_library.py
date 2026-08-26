"""Host-independent Clip library indexing, filtering, and load preflight."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Tuple

from MayaCraft.domain.clip_package import ClipPackage
from MayaCraft.domain.pose_clip import PoseFrame
from MayaCraft.domain.retarget import RetargetAxisTemplate


@dataclass(frozen=True)
class ClipLibraryEntry:
    path: str
    name: str
    tags: Tuple[str, ...] = field(default_factory=tuple)
    frame_count: int = 0
    node_count: int = 0
    frames_per_second: float = 0.0
    duration_seconds: float = 0.0
    coordinate_forward: str = "+Z"
    coordinate_up: str = "+Y"
    package_version: int = 0
    fingerprint: str = ""
    bytes_on_disk: int = 0
    modified_time_ns: int = 0
    migrated_from: str = ""
    state: str = "ready"
    issues: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def is_ready(self):
        return self.state in {"ready", "migrated"} and bool(self.fingerprint)

    @property
    def searchable_text(self):
        return " ".join((self.name, self.path, *self.tags)).casefold()


@dataclass(frozen=True)
class ClipPackagePreflight:
    can_load: bool
    blockers: Tuple[str, ...] = field(default_factory=tuple)
    issues: Tuple[str, ...] = field(default_factory=tuple)
    missing_keys: Tuple[str, ...] = field(default_factory=tuple)
    extra_keys: Tuple[str, ...] = field(default_factory=tuple)
    scale_ratio: float = 1.0
    frame_samples: int = 0


def build_clip_library_entry(
    package: ClipPackage,
    path: str,
    bytes_on_disk: int = 0,
    modified_time_ns: int = 0,
) -> ClipLibraryEntry:
    frame_count = len(package.clip.frames)
    node_count = len(package.reference_pose.nodes)
    if frame_count > 1 and package.clip.frames_per_second > 1e-8:
        frame_span = package.clip.frames[-1].frame - package.clip.frames[0].frame
        duration = max(0.0, frame_span / package.clip.frames_per_second)
    else:
        duration = 0.0
    issues = (f"已从 {package.migrated_from} 迁移",) if package.migrated_from else ()
    return ClipLibraryEntry(
        path=str(path),
        name=package.name,
        tags=tuple(sorted(package.tags, key=str.casefold)),
        frame_count=frame_count,
        node_count=node_count,
        frames_per_second=package.clip.frames_per_second,
        duration_seconds=duration,
        coordinate_forward=package.coordinate_forward,
        coordinate_up=package.coordinate_up,
        package_version=package.package_version,
        fingerprint=package.fingerprint,
        bytes_on_disk=int(bytes_on_disk),
        modified_time_ns=int(modified_time_ns),
        migrated_from=package.migrated_from,
        state="migrated" if package.migrated_from else "ready",
        issues=issues,
    )


def preflight_clip_package(
    package: ClipPackage,
    target_reference: PoseFrame,
    axis_template: RetargetAxisTemplate,
    maximum_nodes: int = 2_000,
    maximum_frame_samples: int = 500_000,
    scale_tolerance: float = 0.1,
) -> ClipPackagePreflight:
    blockers = []
    issues = []
    package_keys = tuple(node.key for node in package.reference_pose.nodes)
    target_keys = tuple(node.key for node in target_reference.nodes)
    package_set, target_set = set(package_keys), set(target_keys)
    missing = tuple(sorted(package_set - target_set))
    extra = tuple(sorted(target_set - package_set))
    if missing:
        blockers.append("当前源骨架缺少 Clip 节点键：" + "，".join(missing[:12]))
    if extra:
        issues.append(f"当前源骨架包含 {len(extra)} 个 Clip 未使用节点")
    node_count = len(package_keys)
    frame_samples = node_count * len(package.clip.frames)
    if node_count > int(maximum_nodes):
        blockers.append(f"Clip 包含 {node_count} 个节点，交互上限为 {maximum_nodes}")
    if frame_samples > int(maximum_frame_samples):
        blockers.append(f"Clip 包含 {frame_samples} 个节点帧，交互上限为 {maximum_frame_samples}")
    package_extent = _pose_extent(package.reference_pose)
    target_extent = _pose_extent(target_reference)
    scale_ratio = package_extent / max(target_extent, 1e-8)
    if not (1.0 - scale_tolerance <= scale_ratio <= 1.0 + scale_tolerance):
        blockers.append(
            f"Clip 参考骨架与当前源骨架尺度不匹配：{scale_ratio:.3f}×"
        )
    if (
        package.coordinate_forward != axis_template.source_forward
        or package.coordinate_up != axis_template.source_up
    ):
        blockers.append(
            f"Clip 轴空间 {package.coordinate_forward}/{package.coordinate_up} 与模板源空间 "
            f"{axis_template.source_forward}/{axis_template.source_up} 不一致"
        )
    if package.migrated_from:
        issues.append(f"资产已从 {package.migrated_from} 迁移，建议另存为 v2")
    return ClipPackagePreflight(
        can_load=not blockers,
        blockers=tuple(dict.fromkeys(blockers)),
        issues=tuple(dict.fromkeys(issues)),
        missing_keys=missing,
        extra_keys=extra,
        scale_ratio=scale_ratio,
        frame_samples=frame_samples,
    )


def filter_clip_library_entries(
    entries,
    query: str = "",
    tags=(),
    include_invalid: bool = True,
) -> Tuple[ClipLibraryEntry, ...]:
    words = tuple(word.casefold() for word in str(query).split() if word.strip())
    required_tags = {str(tag).casefold() for tag in tags if str(tag).strip()}
    result = []
    for entry in entries:
        if not include_invalid and not entry.is_ready:
            continue
        if words and not all(word in entry.searchable_text for word in words):
            continue
        if required_tags and not required_tags.issubset({tag.casefold() for tag in entry.tags}):
            continue
        result.append(entry)
    return tuple(sorted(result, key=lambda item: (
        0 if item.is_ready else 1, item.name.casefold(), item.path.casefold()
    )))


def _pose_extent(frame):
    if not frame.nodes:
        return 0.0
    axes = tuple(tuple(node.world_translation[index] for node in frame.nodes) for index in range(3))
    return max((max(values) - min(values) for values in axes), default=0.0)


__all__ = [
    "ClipLibraryEntry", "ClipPackagePreflight", "build_clip_library_entry",
    "filter_clip_library_entries", "preflight_clip_package",
]
