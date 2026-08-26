"""Host-independent skeleton semantics used by the Rig Graph compiler."""

from __future__ import annotations

from dataclasses import dataclass, field
import math
import re
from typing import Iterable, Tuple


@dataclass(frozen=True)
class JointObservation:
    path: str
    name: str
    parent_path: str = ""
    position: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    orientation: Tuple[float, float, float, float] = (0.0, 0.0, 0.0, 1.0)
    child_count: int = 0


@dataclass(frozen=True)
class SemanticJoint:
    role: str
    path: str
    side: str
    confidence: float
    evidence: Tuple[str, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class SkeletonIssue:
    code: str
    message: str
    paths: Tuple[str, ...] = field(default_factory=tuple)
    severity: str = "warning"


@dataclass(frozen=True)
class SkeletonAnalysis:
    root_path: str = ""
    joints: Tuple[JointObservation, ...] = field(default_factory=tuple)
    semantics: Tuple[SemanticJoint, ...] = field(default_factory=tuple)
    issues: Tuple[SkeletonIssue, ...] = field(default_factory=tuple)
    symmetry_score: int = 0
    confidence: float = 0.0

    def semantic(self, role: str):
        return next((item for item in self.semantics if item.role == role), None)

    @property
    def is_usable(self):
        return bool(self.root_path) and not any(item.severity == "blocker" for item in self.issues)


_ROLE_TOKENS = {
    "root": ("root", "reference", "global"),
    "pelvis": ("pelvis", "hips", "hip", "cog"),
    "spine": ("spine", "abdomen", "torso"),
    "chest": ("chest", "thorax", "spine2", "spine3"),
    "neck": ("neck",),
    "head": ("head",),
    "clavicle": ("clavicle", "collar", "shoulder"),
    "upper_arm": ("upperarm", "upper_arm", "arm", "humerus"),
    "lower_arm": ("lowerarm", "lower_arm", "forearm", "elbow"),
    "hand": ("hand", "wrist"),
    "upper_leg": ("upperleg", "upper_leg", "thigh", "upleg"),
    "lower_leg": ("lowerleg", "lower_leg", "calf", "shin", "knee"),
    "foot": ("foot", "ankle"),
    "toe": ("toe", "ball"),
}
_BILATERAL = {"clavicle", "upper_arm", "lower_arm", "hand", "upper_leg", "lower_leg", "foot", "toe"}
_EXPECTED = ("pelvis", "spine", "chest", "neck", "head")


def _tokens(name: str):
    leaf = name.rsplit(":", 1)[-1]
    expanded = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", leaf).lower()
    return tuple(item for item in re.split(r"[^a-z0-9]+", expanded) if item)


def _side(joint: JointObservation, center_x: float, scale: float):
    tokens = _tokens(joint.name)
    left = bool(set(tokens) & {"l", "lf", "left"}) or joint.name.lower().startswith("left")
    right = bool(set(tokens) & {"r", "rt", "right"}) or joint.name.lower().startswith("right")
    if left != right:
        return ("left" if left else "right"), 1.0, "name side token"
    delta = joint.position[0] - center_x
    if abs(delta) > max(scale * 0.025, 1e-4):
        return ("left" if delta > 0.0 else "right"), 0.62, "world X side"
    return "center", 0.9, "center plane"


def _role_score(joint: JointObservation, role: str, height_min: float, height_span: float):
    name_tokens = _tokens(joint.name)
    collapsed = "_".join(name_tokens)
    score = 0.0
    evidence = []
    for token in _ROLE_TOKENS[role]:
        token_parts = tuple(token.split("_"))
        boundary_match = any(
            tuple(name_tokens[index:index + len(token_parts)]) == token_parts
            for index in range(max(0, len(name_tokens) - len(token_parts) + 1))
        )
        if boundary_match:
            quality = 0.82
            score = max(score, quality)
            evidence.append(f"name:{token}")
        elif token in collapsed:
            # A weak fallback helps unusual studio naming without allowing
            # "arm" inside "forearm" to outrank the explicit upper-arm joint.
            quality = 0.60
            score = max(score, quality)
            evidence.append(f"name-fragment:{token}")
    normalized_y = (joint.position[1] - height_min) / max(height_span, 1e-6)
    ranges = {
        "pelvis": (0.35, 0.62), "spine": (0.42, 0.72), "chest": (0.55, 0.82),
        "neck": (0.72, 0.94), "head": (0.78, 1.05), "clavicle": (0.62, 0.87),
        "upper_arm": (0.48, 0.84), "lower_arm": (0.32, 0.78), "hand": (0.22, 0.72),
        "upper_leg": (0.20, 0.60), "lower_leg": (0.05, 0.42), "foot": (-0.04, 0.18), "toe": (-0.04, 0.15),
        "root": (-0.10, 0.45),
    }
    low, high = ranges[role]
    if low <= normalized_y <= high:
        score += 0.12
        evidence.append("height band")
    return min(score, 1.0), tuple(evidence)


def analyze_skeleton(joints: Iterable[JointObservation]) -> SkeletonAnalysis:
    values = tuple(joints)
    if not values:
        return SkeletonAnalysis(issues=(SkeletonIssue("empty", "请选择一个关节层级进行分析", severity="blocker"),))
    by_path = {item.path: item for item in values}
    roots = tuple(item for item in values if not item.parent_path or item.parent_path not in by_path)
    issues = []
    if len(roots) != 1:
        issues.append(SkeletonIssue("multiple_roots", f"骨架应只有一个根节点，当前发现 {len(roots)} 个", tuple(item.path for item in roots), "blocker"))
    root_path = roots[0].path if roots else ""
    ys = [item.position[1] for item in values]
    xs = [item.position[0] for item in values]
    height_min, height_max = min(ys), max(ys)
    scale = max(height_max - height_min, max(xs) - min(xs), 1.0)
    center_x = sum(item.position[0] for item in roots) / len(roots) if roots else 0.0
    candidates = []
    for joint in values:
        side, side_confidence, side_evidence = _side(joint, center_x, scale)
        for base_role in _ROLE_TOKENS:
            if base_role in _BILATERAL and side == "center":
                continue
            score, evidence = _role_score(joint, base_role, height_min, height_max - height_min)
            if score < 0.45:
                continue
            if base_role in _BILATERAL:
                role = f"{side}_{base_role}"
                score *= side_confidence
                evidence += (side_evidence,)
            else:
                role = base_role
                if side != "center":
                    score *= 0.78
                    evidence += ("off center",)
            candidates.append((score, role, joint.path, side, evidence))
    semantics = []
    for role in sorted({item[1] for item in candidates}):
        ranked = sorted((item for item in candidates if item[1] == role), reverse=True)
        score, _, path, side, evidence = ranked[0]
        semantics.append(SemanticJoint(role, path, side, round(score, 3), evidence))
        if len(ranked) > 1 and ranked[1][0] >= score - 0.08:
            issues.append(SkeletonIssue("ambiguous_role", f"{role} 存在多个竞争候选", (path, ranked[1][2])))
    found = {item.role for item in semantics}
    for role in _EXPECTED:
        if role not in found:
            issues.append(SkeletonIssue("missing_role", f"无法识别必需语义：{role}"))
    pairs = 0
    pair_scores = []
    for role in _BILATERAL:
        left = next((item for item in semantics if item.role == f"left_{role}"), None)
        right = next((item for item in semantics if item.role == f"right_{role}"), None)
        if bool(left) != bool(right):
            issues.append(SkeletonIssue("missing_pair", f"{role} 语义缺少左右配对", tuple(item.path for item in (left, right) if item)))
        elif left and right:
            pairs += 1
            lp, rp = by_path[left.path].position, by_path[right.path].position
            distance = math.sqrt((abs(lp[0] - center_x) - abs(rp[0] - center_x)) ** 2 + (lp[1] - rp[1]) ** 2 + (lp[2] - rp[2]) ** 2)
            pair_scores.append(max(0.0, 1.0 - distance / max(scale * 0.1, 1e-6)))
    symmetry = round(100.0 * sum(pair_scores) / len(pair_scores)) if pair_scores else 0
    confidence = sum(item.confidence for item in semantics) / len(semantics) if semantics else 0.0
    if pairs < 3:
        issues.append(SkeletonIssue("low_bilateral_coverage", "识别出的双侧肢体配对少于三组"))
    return SkeletonAnalysis(root_path, values, tuple(semantics), tuple(issues), symmetry, round(confidence, 3))


__all__ = ["JointObservation", "SemanticJoint", "SkeletonAnalysis", "SkeletonIssue", "analyze_skeleton"]
