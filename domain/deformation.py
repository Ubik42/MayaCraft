"""Host-independent skin-weight diagnostics for Deformation MRI."""

from __future__ import annotations

from dataclasses import dataclass, field
from math import log
from typing import Iterable, Sequence, Tuple


@dataclass(frozen=True)
class VertexWeightSignal:
    index: int
    heat: float
    weight_sum: float
    influence_count: int
    fragment_count: int
    entropy: float
    dominant_index: int = -1
    dominant_weight: float = 0.0
    findings: Tuple[str, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class DeformationReport:
    vertices: Tuple[VertexWeightSignal, ...] = field(default_factory=tuple)
    score: int = 0
    hotspot_count: int = 0
    unbound_count: int = 0
    normalization_count: int = 0
    excess_influence_count: int = 0
    fragment_count: int = 0

    @property
    def hottest(self):
        return tuple(sorted(self.vertices, key=lambda item: (-item.heat, item.index)))


@dataclass(frozen=True)
class InfluenceWeightDiagnostic:
    index: int
    path: str
    affected_vertex_count: int = 0
    dominant_vertex_count: int = 0
    total_weight: float = 0.0
    maximum_weight: float = 0.0
    locked: bool = False

    @property
    def leaf_name(self):
        return self.path.rsplit("|", 1)[-1].rsplit(":", 1)[-1]


@dataclass(frozen=True)
class DeformationInspectorReport:
    influences: Tuple[InfluenceWeightDiagnostic, ...] = field(default_factory=tuple)
    locked_vertices: Tuple[int, ...] = field(default_factory=tuple)
    high_entropy_vertices: Tuple[int, ...] = field(default_factory=tuple)
    low_dominance_vertices: Tuple[int, ...] = field(default_factory=tuple)
    missing_influences: Tuple[str, ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class DeformationMRIResult:
    mesh_path: str
    skin_cluster: str
    influences: Tuple[str, ...]
    report: DeformationReport
    elapsed_ms: float = 0.0
    locked_influences: Tuple[str, ...] = field(default_factory=tuple)
    missing_influences: Tuple[str, ...] = field(default_factory=tuple)
    vertex_positions: Tuple[Tuple[float, float, float], ...] = field(default_factory=tuple)
    triangles: Tuple[Tuple[int, int, int], ...] = field(default_factory=tuple)
    inspector: DeformationInspectorReport = field(default_factory=DeformationInspectorReport)


@dataclass(frozen=True)
class WeightVectorChange:
    vertex_index: int
    before: Tuple[float, ...]
    after: Tuple[float, ...]


@dataclass(frozen=True)
class DeformationRepairPlan:
    mesh_path: str
    skin_cluster: str
    influences: Tuple[str, ...]
    changes: Tuple[WeightVectorChange, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def can_apply(self):
        return bool(self.changes) and not self.blockers

    @property
    def is_noop(self):
        return not self.changes and not self.blockers


@dataclass(frozen=True)
class DeformationRepairReceipt:
    plan: DeformationRepairPlan
    verified: bool
    message: str


def analyze_weight_rows(
    rows: Iterable[Sequence[float]],
    start_index: int = 0,
    max_influences: int = 4,
    active_threshold: float = 0.001,
    fragment_threshold: float = 0.02,
    normalization_tolerance: float = 0.001,
) -> DeformationReport:
    signals = []
    for offset, raw_row in enumerate(rows):
        row = tuple(max(0.0, float(value)) for value in raw_row)
        total = sum(row)
        active = tuple(value for value in row if value > active_threshold)
        fragments = sum(active_threshold < value < fragment_threshold for value in row)
        findings = []
        unbound = total <= active_threshold
        normalization_error = abs(total - 1.0)
        excess = max(0, len(active) - max_influences)
        if unbound:
            findings.append("未绑定顶点")
        elif normalization_error > normalization_tolerance:
            findings.append(f"权重和 {total:.4f}")
        if excess:
            findings.append(f"{len(active)} 个活动影响骨骼")
        if fragments:
            findings.append(f"{fragments} 个低权重碎片")
        entropy = 0.0
        if total > active_threshold and len(active) > 1:
            probabilities = tuple(value / total for value in active)
            entropy = -sum(value * log(value) for value in probabilities) / log(len(probabilities))
        dominant_index = max(range(len(row)), key=row.__getitem__) if row else -1
        dominant_weight = row[dominant_index] if dominant_index >= 0 else 0.0
        norm_heat = min(1.0, normalization_error * 5.0)
        influence_heat = min(1.0, excess / max(1, max_influences))
        fragment_heat = min(1.0, fragments / 3.0)
        heat = 1.0 if unbound else min(1.0, 0.55 * norm_heat + 0.30 * influence_heat + 0.15 * fragment_heat)
        signals.append(
            VertexWeightSignal(
                index=start_index + offset,
                heat=heat,
                weight_sum=total,
                influence_count=len(active),
                fragment_count=fragments,
                entropy=entropy,
                dominant_index=dominant_index,
                dominant_weight=dominant_weight,
                findings=tuple(findings),
            )
        )
    hotspot_count = sum(signal.heat >= 0.12 for signal in signals)
    mean_heat = sum(signal.heat for signal in signals) / len(signals) if signals else 1.0
    return DeformationReport(
        vertices=tuple(signals),
        score=max(0, round(100.0 * (1.0 - mean_heat))) if signals else 0,
        hotspot_count=hotspot_count,
        unbound_count=sum("未绑定顶点" in signal.findings for signal in signals),
        normalization_count=sum(any(item.startswith("权重和") for item in signal.findings) for signal in signals),
        excess_influence_count=sum(any(item.endswith("个活动影响骨骼") for item in signal.findings) for signal in signals),
        fragment_count=sum(signal.fragment_count for signal in signals),
    )


def merge_reports(reports: Iterable[DeformationReport]) -> DeformationReport:
    vertices = tuple(vertex for report in reports for vertex in report.vertices)
    if not vertices:
        return DeformationReport()
    mean_heat = sum(vertex.heat for vertex in vertices) / len(vertices)
    return DeformationReport(
        vertices=vertices,
        score=max(0, round(100.0 * (1.0 - mean_heat))),
        hotspot_count=sum(report.hotspot_count for report in reports),
        unbound_count=sum(report.unbound_count for report in reports),
        normalization_count=sum(report.normalization_count for report in reports),
        excess_influence_count=sum(report.excess_influence_count for report in reports),
        fragment_count=sum(report.fragment_count for report in reports),
    )


def analyze_influence_rows(
    rows: Iterable[Sequence[float]],
    influence_paths: Sequence[str],
    locked_indices: Iterable[int] = (),
    start_index: int = 0,
    active_threshold: float = 0.001,
) -> DeformationInspectorReport:
    """Summarize one weight batch without retaining its dense weight matrix."""
    paths = tuple(str(path) for path in influence_paths)
    locked = {int(index) for index in locked_indices}
    affected = [0] * len(paths)
    dominant = [0] * len(paths)
    totals = [0.0] * len(paths)
    maximum = [0.0] * len(paths)
    locked_vertices = []
    for offset, raw_row in enumerate(rows):
        row = tuple(max(0.0, float(value)) for value in raw_row)
        if len(row) != len(paths):
            raise ValueError(
                f"顶点 {start_index + offset} 的权重维度 {len(row)} 与 {len(paths)} 个影响骨骼不一致"
            )
        dominant_index = max(range(len(row)), key=row.__getitem__) if row else -1
        if dominant_index >= 0 and row[dominant_index] > active_threshold:
            dominant[dominant_index] += 1
        has_locked_weight = False
        for index, value in enumerate(row):
            if value > active_threshold:
                affected[index] += 1
                totals[index] += value
                maximum[index] = max(maximum[index], value)
                has_locked_weight = has_locked_weight or index in locked
        if has_locked_weight:
            locked_vertices.append(start_index + offset)
    return DeformationInspectorReport(
        influences=tuple(
            InfluenceWeightDiagnostic(
                index=index,
                path=path,
                affected_vertex_count=affected[index],
                dominant_vertex_count=dominant[index],
                total_weight=totals[index],
                maximum_weight=maximum[index],
                locked=index in locked,
            )
            for index, path in enumerate(paths)
        ),
        locked_vertices=tuple(locked_vertices),
    )


def merge_influence_reports(
    reports: Iterable[DeformationInspectorReport],
    deformation_report: DeformationReport,
    missing_influences: Iterable[str] = (),
) -> DeformationInspectorReport:
    batches = tuple(reports)
    if not batches:
        return DeformationInspectorReport(missing_influences=tuple(missing_influences))
    width = len(batches[0].influences)
    if any(len(batch.influences) != width for batch in batches):
        raise ValueError("影响骨骼诊断批次宽度不一致")
    merged = []
    for index in range(width):
        values = tuple(batch.influences[index] for batch in batches)
        identity = values[0]
        if any(value.path != identity.path or value.index != identity.index for value in values):
            raise ValueError("影响骨骼诊断批次顺序不一致")
        merged.append(
            InfluenceWeightDiagnostic(
                index=identity.index,
                path=identity.path,
                affected_vertex_count=sum(value.affected_vertex_count for value in values),
                dominant_vertex_count=sum(value.dominant_vertex_count for value in values),
                total_weight=sum(value.total_weight for value in values),
                maximum_weight=max(value.maximum_weight for value in values),
                locked=identity.locked,
            )
        )
    return DeformationInspectorReport(
        influences=tuple(merged),
        locked_vertices=tuple(sorted(
            vertex for batch in batches for vertex in batch.locked_vertices
        )),
        high_entropy_vertices=tuple(
            signal.index for signal in deformation_report.vertices if signal.entropy >= 0.65
        ),
        low_dominance_vertices=tuple(
            signal.index
            for signal in deformation_report.vertices
            if signal.weight_sum > 0.001 and signal.dominant_weight < 0.55
        ),
        missing_influences=tuple(str(value) for value in missing_influences),
    )


def plan_normalization_repair(
    mesh_path: str,
    skin_cluster: str,
    influences: Sequence[str],
    indexed_rows: Iterable[Tuple[int, Sequence[float]]],
    tolerance: float = 0.001,
    maximum_changes: int = 5000,
) -> DeformationRepairPlan:
    changes = []
    blockers = []
    influence_values = tuple(influences)
    for vertex_index, raw_row in indexed_rows:
        before = tuple(max(0.0, float(value)) for value in raw_row)
        if len(before) != len(influence_values):
            blockers.append(f"顶点 {vertex_index} 的影响骨骼向量不兼容")
            continue
        total = sum(before)
        if total <= tolerance or abs(total - 1.0) <= tolerance:
            continue
        after = tuple(value / total for value in before)
        changes.append(WeightVectorChange(int(vertex_index), before, after))
    if len(changes) > maximum_changes:
        blockers.append(
            f"修复会影响 {len(changes)} 个顶点，交互安全上限为 {maximum_changes}"
        )
    return DeformationRepairPlan(
        mesh_path=mesh_path,
        skin_cluster=skin_cluster,
        influences=influence_values,
        changes=tuple(changes),
        blockers=tuple(blockers),
    )
