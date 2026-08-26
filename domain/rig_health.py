"""Deterministic semantic grouping and structural health for a captured rig graph."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Iterable, Tuple

from MayaCraft.domain.character import RigNode


MODULE_ORDER = ("core", "head", "arm", "hand", "leg", "foot", "controls", "other")
MODULE_LABELS = {
    "core": "核心",
    "head": "头部",
    "arm": "手臂",
    "hand": "手部",
    "leg": "腿部",
    "foot": "足部",
    "controls": "控制",
    "other": "其他",
}


@dataclass(frozen=True)
class RigModuleHealth:
    key: str
    label: str
    node_paths: Tuple[str, ...]
    score: int = 100
    findings: Tuple[str, ...] = field(default_factory=tuple)
    left_count: int = 0
    right_count: int = 0

    @property
    def state(self) -> str:
        if self.score >= 90:
            return "healthy"
        if self.score >= 70:
            return "watch"
        return "risk"


@dataclass(frozen=True)
class RigHealthReport:
    modules: Tuple[RigModuleHealth, ...] = field(default_factory=tuple)
    overall_score: int = 0
    issue_count: int = 0

    def module(self, key: str):
        return next((item for item in self.modules if item.key == key), None)


def semantic_module(node: RigNode) -> str:
    leaf = node.name.rsplit(":", 1)[-1].lower()
    if any(token in leaf for token in ("finger", "thumb", "palm", "hand")):
        return "hand"
    if any(token in leaf for token in ("ankle", "foot", "toe", "ball")):
        return "foot"
    if any(token in leaf for token in ("clav", "shoulder", "upperarm", "lowerarm", "forearm", "elbow", "wrist", "arm_")):
        return "arm"
    if any(token in leaf for token in ("thigh", "knee", "shin", "calf", "upleg", "lowleg", "leg_")):
        return "leg"
    if any(token in leaf for token in ("head", "jaw", "eye", "brow", "lip", "face")):
        return "head"
    if any(token in leaf for token in ("root", "cog", "pelvis", "hips", "spine", "chest", "neck")):
        return "core"
    if node.kind == "control":
        return "controls"
    return "other"


def analyze_rig(nodes: Iterable[RigNode]) -> RigHealthReport:
    values = tuple(nodes)
    by_path = {node.path: node for node in values}
    groups = {key: [] for key in MODULE_ORDER}
    for node in values:
        groups[semantic_module(node)].append(node)

    modules = []
    for key in MODULE_ORDER:
        group = groups[key]
        if not group:
            continue
        findings = []
        deduction = 0
        left = sum(node.side == "left" for node in group)
        right = sum(node.side == "right" for node in group)
        if key in {"arm", "hand", "leg", "foot"} and (left or right):
            imbalance = abs(left - right)
            if imbalance:
                deduction += min(48, 18 * imbalance)
                findings.append(f"左右数量不平衡 L{left}/R{right}")
        missing_parents = sum(
            bool(node.parent_path) and node.parent_path not in by_path
            for node in group
            if node.kind == "joint"
        )
        if missing_parents:
            deduction += min(30, 10 * missing_parents)
            findings.append(f"{missing_parents} 条父级连接位于捕获范围外")
        modules.append(
            RigModuleHealth(
                key=key,
                label=MODULE_LABELS[key],
                node_paths=tuple(node.path for node in group),
                score=max(0, 100 - deduction),
                findings=tuple(findings),
                left_count=left,
                right_count=right,
            )
        )
    if not modules:
        return RigHealthReport()
    issue_count = sum(len(module.findings) for module in modules)
    weighted_score = round(
        sum(module.score * len(module.node_paths) for module in modules)
        / sum(len(module.node_paths) for module in modules)
    )
    return RigHealthReport(tuple(modules), weighted_score, issue_count)


def focus_rig_nodes(nodes: Iterable[RigNode], report: RigHealthReport, module_key: str):
    """Return a module plus its ancestors, preserving a readable hierarchy spine."""
    values = tuple(nodes)
    module = report.module(module_key)
    if module is None:
        return values
    by_path = {node.path: node for node in values}
    included = set(module.node_paths)
    for path in tuple(included):
        cursor = by_path.get(path)
        while cursor and cursor.parent_path:
            included.add(cursor.parent_path)
            cursor = by_path.get(cursor.parent_path)
    return tuple(node for node in values if node.path in included)
