"""Deterministic, explainable influence pairing for skin-weight mirroring."""

from __future__ import annotations

from dataclasses import dataclass, field
import math
import re
from typing import Iterable, Tuple


@dataclass(frozen=True)
class InfluenceObservation:
    index: int
    path: str
    position: Tuple[float, float, float]

    @property
    def name(self):
        return self.path.rsplit("|", 1)[-1].rsplit(":", 1)[-1]


@dataclass(frozen=True)
class InfluenceMirrorPair:
    left_index: int
    right_index: int
    confidence: float
    method: str
    distance: float = 0.0


@dataclass(frozen=True)
class InfluenceMirrorIssue:
    code: str
    message: str
    indices: Tuple[int, ...] = field(default_factory=tuple)
    severity: str = "warning"


@dataclass(frozen=True)
class InfluenceMirrorMap:
    pairs: Tuple[InfluenceMirrorPair, ...] = field(default_factory=tuple)
    centers: Tuple[int, ...] = field(default_factory=tuple)
    unpaired: Tuple[int, ...] = field(default_factory=tuple)
    issues: Tuple[InfluenceMirrorIssue, ...] = field(default_factory=tuple)
    confidence: float = 0.0

    def mirrored_index(self, index):
        for pair in self.pairs:
            if pair.left_index == index:
                return pair.right_index
            if pair.right_index == index:
                return pair.left_index
        return index if index in self.centers else -1


@dataclass(frozen=True)
class SkinVertexObservation:
    index: int
    position: Tuple[float, float, float]
    weights: Tuple[float, ...]


@dataclass(frozen=True)
class SkinMirrorChange:
    source_index: int
    target_index: int
    source_position: Tuple[float, float, float]
    target_position: Tuple[float, float, float]
    before: Tuple[float, ...]
    after: Tuple[float, ...]
    distance: float


@dataclass(frozen=True)
class SkinMirrorPlan:
    mesh_path: str
    skin_cluster: str
    influences: Tuple[str, ...]
    direction: str
    influence_map: InfluenceMirrorMap
    changes: Tuple[SkinMirrorChange, ...] = field(default_factory=tuple)
    unmatched_vertices: Tuple[int, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)
    vertex_count: int = 0

    @property
    def can_apply(self):
        return bool(self.changes) and not self.blockers

    @property
    def is_noop(self):
        return not self.changes and not self.blockers


@dataclass(frozen=True)
class SkinMirrorReceipt:
    plan: SkinMirrorPlan
    verified: bool
    message: str


_LEFT = {"l", "lf", "left"}
_RIGHT = {"r", "rt", "right"}


def _name_parts(name):
    expanded = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", name).lower()
    return tuple(item for item in re.split(r"[^a-z0-9]+", expanded) if item)


def _name_side(name):
    parts = _name_parts(name)
    left = bool(set(parts) & _LEFT)
    right = bool(set(parts) & _RIGHT)
    if left == right:
        return ""
    return "left" if left else "right"


def _canonical(name):
    return "_".join(item for item in _name_parts(name) if item not in _LEFT | _RIGHT)


def build_influence_mirror_map(
    influences: Iterable[InfluenceObservation],
    center_tolerance_ratio: float = 0.01,
    pair_tolerance_ratio: float = 0.08,
) -> InfluenceMirrorMap:
    values = tuple(sorted(influences, key=lambda item: item.index))
    if not values:
        return InfluenceMirrorMap(issues=(InfluenceMirrorIssue("empty", "没有提供蒙皮影响骨骼", severity="blocker"),))
    indices = [item.index for item in values]
    if len(set(indices)) != len(indices):
        return InfluenceMirrorMap(issues=(InfluenceMirrorIssue("duplicate_index", "影响骨骼索引必须唯一", tuple(indices), "blocker"),))
    xs = [item.position[0] for item in values]
    ys = [item.position[1] for item in values]
    zs = [item.position[2] for item in values]
    scale = max(max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs), 1.0)
    center_tolerance = scale * center_tolerance_ratio
    pair_tolerance = scale * pair_tolerance_ratio
    centers = {item.index for item in values if abs(item.position[0]) <= center_tolerance and not _name_side(item.name)}
    remaining = {item.index: item for item in values if item.index not in centers}
    pairs = []
    issues = []

    groups = {}
    for item in remaining.values():
        side = _name_side(item.name)
        if side:
            groups.setdefault(_canonical(item.name), {}).setdefault(side, []).append(item)
    used = set()
    for canonical, sides in sorted(groups.items()):
        left, right = sides.get("left", []), sides.get("right", [])
        if len(left) == len(right) == 1:
            a, b = left[0], right[0]
            distance = _mirror_distance(a.position, b.position)
            geometry = max(0.0, 1.0 - distance / max(pair_tolerance, 1e-9))
            pairs.append(InfluenceMirrorPair(a.index, b.index, round(0.82 + geometry * 0.18, 3), "name+geometry", distance))
            used.update((a.index, b.index))
        elif left or right:
            candidates = tuple(item.index for item in left + right)
            issues.append(InfluenceMirrorIssue("ambiguous_name", f"命名配对存在歧义：{canonical}", candidates))

    leftovers = [item for item in remaining.values() if item.index not in used]
    left_values = [item for item in leftovers if item.position[0] > center_tolerance]
    right_values = [item for item in leftovers if item.position[0] < -center_tolerance]
    candidates = sorted(
        (_mirror_distance(left.position, right.position), left, right)
        for left in left_values for right in right_values
    )
    for distance, left, right in candidates:
        if left.index in used or right.index in used or distance > pair_tolerance:
            continue
        confidence = max(0.35, 0.78 * (1.0 - distance / max(pair_tolerance, 1e-9)))
        pairs.append(InfluenceMirrorPair(left.index, right.index, round(confidence, 3), "geometry", distance))
        used.update((left.index, right.index))
    unpaired = tuple(sorted(item.index for item in values if item.index not in used and item.index not in centers))
    for index in unpaired:
        issues.append(InfluenceMirrorIssue("unpaired", f"影响骨骼 {index} 没有安全的镜像配对", (index,)))
    pair_values = tuple(sorted(pairs, key=lambda item: (item.left_index, item.right_index)))
    confidence = sum(item.confidence for item in pair_values) / len(pair_values) if pair_values else 0.0
    return InfluenceMirrorMap(pair_values, tuple(sorted(centers)), unpaired, tuple(issues), round(confidence, 3))


def _mirror_distance(left, right):
    return math.sqrt((left[0] + right[0]) ** 2 + (left[1] - right[1]) ** 2 + (left[2] - right[2]) ** 2)


def plan_skin_mirror(
    mesh_path: str,
    skin_cluster: str,
    influences: Iterable[InfluenceObservation],
    vertices: Iterable[SkinVertexObservation],
    direction: str = "left_to_right",
    position_tolerance: float = 0.001,
    weight_tolerance: float = 1e-6,
    maximum_changes: int = 5000,
) -> SkinMirrorPlan:
    if direction not in {"left_to_right", "right_to_left"}:
        raise ValueError("蒙皮镜像方向必须是 left_to_right 或 right_to_left")
    influence_values = tuple(sorted(influences, key=lambda item: item.index))
    vertex_values = tuple(sorted(vertices, key=lambda item: item.index))
    influence_map = build_influence_mirror_map(influence_values)
    blockers = [item.message for item in influence_map.issues if item.severity == "blocker"]
    influence_paths = tuple(item.path for item in influence_values)
    expected_indices = tuple(range(len(influence_values)))
    if tuple(item.index for item in influence_values) != expected_indices:
        blockers.append("影响骨骼逻辑索引必须连续，才能镜像权重向量")
    if influence_map.unpaired:
        weighted_unpaired = []
        for index in influence_map.unpaired:
            if any(index < len(vertex.weights) and vertex.weights[index] > weight_tolerance for vertex in vertex_values):
                weighted_unpaired.append(index)
        if weighted_unpaired:
            blockers.append("带权重的影响骨骼没有安全镜像配对：" + ", ".join(map(str, weighted_unpaired)))
    for vertex in vertex_values:
        if len(vertex.weights) != len(influence_values):
            blockers.append(f"顶点 {vertex.index} 的影响骨骼向量不兼容")
            break
    if blockers:
        return SkinMirrorPlan(mesh_path, skin_cluster, influence_paths, direction, influence_map, blockers=tuple(blockers), vertex_count=len(vertex_values))
    tolerance = max(float(position_tolerance), 1e-9)
    source_positive = direction == "left_to_right"
    sources = [item for item in vertex_values if (item.position[0] > tolerance) == source_positive and abs(item.position[0]) > tolerance]
    targets = [item for item in vertex_values if (item.position[0] < -tolerance) == source_positive and abs(item.position[0]) > tolerance]
    buckets = {}
    cell = tolerance * 2.0
    for target in targets:
        key = _spatial_key(target.position, cell)
        buckets.setdefault(key, []).append(target)
    used_targets = set()
    unmatched = []
    changes = []
    for source in sources:
        mirror = (-source.position[0], source.position[1], source.position[2])
        key = _spatial_key(mirror, cell)
        candidates = []
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                for dz in (-1, 0, 1):
                    candidates.extend(buckets.get((key[0] + dx, key[1] + dy, key[2] + dz), ()))
        ranked = sorted(
            (_distance(mirror, item.position), item.index, item)
            for item in candidates if item.index not in used_targets
        )
        if not ranked or ranked[0][0] > tolerance:
            unmatched.append(source.index)
            continue
        distance, _index, target = ranked[0]
        if len(ranked) > 1 and ranked[1][0] <= tolerance and abs(ranked[1][0] - distance) <= tolerance * 0.05:
            unmatched.append(source.index)
            continue
        used_targets.add(target.index)
        after = [0.0] * len(source.weights)
        for source_influence, value in enumerate(source.weights):
            target_influence = influence_map.mirrored_index(source_influence)
            if target_influence >= 0:
                after[target_influence] += value
        after_values = tuple(after)
        if not _vector_close(target.weights, after_values, weight_tolerance):
            changes.append(SkinMirrorChange(
                source.index, target.index, source.position, target.position,
                target.weights, after_values, distance,
            ))
    if len(changes) > maximum_changes:
        blockers.append(f"镜像会影响 {len(changes)} 个顶点，交互安全上限为 {maximum_changes}")
    if sources and len(unmatched) / len(sources) > 0.05:
        blockers.append(f"拓扑对称性不足：{len(sources)} 个源顶点中有 {len(unmatched)} 个未匹配")
    return SkinMirrorPlan(
        mesh_path, skin_cluster, influence_paths, direction, influence_map,
        tuple(changes), tuple(sorted(unmatched)), tuple(blockers), len(vertex_values),
    )


def _spatial_key(position, cell):
    return tuple(int(math.floor(value / cell)) for value in position)


def _distance(left, right):
    return math.sqrt(sum((a - b) ** 2 for a, b in zip(left, right)))


def _vector_close(left, right, tolerance):
    return len(left) == len(right) and all(abs(a - b) <= tolerance for a, b in zip(left, right))


__all__ = [
    "InfluenceObservation", "InfluenceMirrorIssue", "InfluenceMirrorMap", "InfluenceMirrorPair",
    "SkinMirrorChange", "SkinMirrorPlan", "SkinMirrorReceipt", "SkinVertexObservation",
    "build_influence_mirror_map", "plan_skin_mirror",
]
