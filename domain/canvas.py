"""Host-independent projection and hit testing for the Living Rig Canvas."""

from __future__ import annotations

from dataclasses import dataclass
from math import hypot
from typing import Iterable, Optional, Tuple

from MayaCraft.domain.character import RigNode


@dataclass(frozen=True)
class ProjectedRigNode:
    path: str
    name: str
    kind: str
    side: str
    selected: bool
    x: float
    y: float


def project_rig_nodes(
    nodes: Iterable[RigNode],
    center: Tuple[float, float],
    extent: Tuple[float, float],
    z_bias: float = 0.18,
) -> Tuple[ProjectedRigNode, ...]:
    """Project Maya world positions into a stable front-biased 2D canvas."""

    values = tuple(nodes)
    if len(values) < 2:
        return ()
    raw = tuple((node.position[0] + node.position[2] * z_bias, node.position[1]) for node in values)
    xs = tuple(point[0] for point in raw)
    ys = tuple(point[1] for point in raw)
    span_x = max(xs) - min(xs)
    span_y = max(ys) - min(ys)
    if span_x < 0.001 and span_y < 0.001:
        return ()
    scale = min(extent[0] / max(span_x, 1.0), extent[1] / max(span_y, 1.0))
    mid_x = (min(xs) + max(xs)) * 0.5
    mid_y = (min(ys) + max(ys)) * 0.5
    return tuple(
        ProjectedRigNode(
            path=node.path,
            name=node.name,
            kind=node.kind,
            side=node.side,
            selected=node.selected,
            x=center[0] + (point[0] - mid_x) * scale,
            y=center[1] - (point[1] - mid_y) * scale,
        )
        for node, point in zip(values, raw)
    )


def hit_test(
    nodes: Iterable[ProjectedRigNode],
    point: Tuple[float, float],
    radius: float = 12.0,
) -> Optional[ProjectedRigNode]:
    """Return the nearest node within radius, preferring precise hits."""

    candidates = []
    for node in nodes:
        distance = hypot(node.x - point[0], node.y - point[1])
        if distance <= radius:
            candidates.append((distance, node))
    return min(candidates, key=lambda item: item[0])[1] if candidates else None
