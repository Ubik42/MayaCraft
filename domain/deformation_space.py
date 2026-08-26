"""Host-independent PCA projection and local brush queries for deformation fields."""

from __future__ import annotations

from dataclasses import dataclass, field
import math
from typing import Iterable, Sequence, Tuple


@dataclass(frozen=True)
class SpatialVertexSignal:
    index: int
    x: float
    y: float
    depth: float
    heat: float
    dominant_index: int = -1
    entropy: float = 0.0


@dataclass(frozen=True)
class DeformationFieldProjection:
    vertices: Tuple[SpatialVertexSignal, ...] = field(default_factory=tuple)
    triangles: Tuple[Tuple[int, int, int], ...] = field(default_factory=tuple)
    center: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    axis_u: Tuple[float, float, float] = (1.0, 0.0, 0.0)
    axis_v: Tuple[float, float, float] = (0.0, 1.0, 0.0)
    axis_depth: Tuple[float, float, float] = (0.0, 0.0, 1.0)
    source_count: int = 0

    def vertex(self, index):
        return next((item for item in self.vertices if item.index == index), None)


def project_deformation_field(
    positions: Iterable[Sequence[float]],
    signals: Iterable,
    triangles: Iterable[Sequence[int]] = (),
    maximum_vertices: int = 12000,
) -> DeformationFieldProjection:
    points = tuple(tuple(float(value) for value in position[:3]) for position in positions)
    signal_values = tuple(signals)
    source_triangles = tuple(
        tuple(int(index) for index in triangle[:3])
        for triangle in triangles
        if len(triangle) >= 3
    )
    if not points or len(points) != len(signal_values):
        return DeformationFieldProjection(source_count=len(points))
    center = tuple(sum(point[axis] for point in points) / len(points) for axis in range(3))
    centered = tuple(tuple(point[axis] - center[axis] for axis in range(3)) for point in points)
    covariance = tuple(tuple(
        sum(point[row] * point[column] for point in centered) / len(centered)
        for column in range(3)
    ) for row in range(3))
    axis_u = _principal_axis(covariance)
    axis_v = _principal_axis(covariance, orthogonal_to=axis_u)
    axis_depth = _normalize(_cross(axis_u, axis_v), fallback=(0.0, 0.0, 1.0))
    raw = tuple((_dot(point, axis_u), _dot(point, axis_v), _dot(point, axis_depth)) for point in centered)
    spans = []
    centers = []
    for axis in range(3):
        values = tuple(item[axis] for item in raw)
        low, high = min(values), max(values)
        spans.append(max(high - low, 1e-9))
        centers.append((low + high) * 0.5)
    vertex_budget = max(3, int(maximum_vertices))
    if len(points) <= vertex_budget:
        kept = set(range(len(points)))
    elif source_triangles:
        # Keep complete sampled faces. A raw vertex stride normally leaves no
        # complete triangles, turning a production mesh into an unreadable dot cloud.
        face_budget = max(1, vertex_budget // 3)
        face_stride = max(1, math.ceil(len(source_triangles) / face_budget))
        kept = {
            index
            for triangle in source_triangles[::face_stride]
            for index in triangle
            if 0 <= index < len(points)
        }
    else:
        stride = max(1, math.ceil(len(points) / vertex_budget))
        kept = set(range(0, len(points), stride))
    # Always keep hotspots, even when the base field is decimated.
    kept.update(index for index, signal in enumerate(signal_values) if float(getattr(signal, "heat", 0.0)) >= 0.12)
    projected = tuple(
        SpatialVertexSignal(
            index=index,
            x=(raw[index][0] - centers[0]) / (spans[0] * 0.5),
            y=(raw[index][1] - centers[1]) / (spans[1] * 0.5),
            depth=(raw[index][2] - centers[2]) / (spans[2] * 0.5),
            heat=float(getattr(signal_values[index], "heat", 0.0)),
            dominant_index=int(getattr(signal_values[index], "dominant_index", -1)),
            entropy=float(getattr(signal_values[index], "entropy", 0.0)),
        )
        for index in sorted(kept)
    )
    valid = {item.index for item in projected}
    triangle_values = tuple(
        triangle for triangle in source_triangles if all(index in valid for index in triangle)
    )
    return DeformationFieldProjection(projected, triangle_values, center, axis_u, axis_v, axis_depth, len(points))


def hit_test_spatial(projection: DeformationFieldProjection, point, radius=0.04):
    x, y = float(point[0]), float(point[1])
    ranked = sorted(
        ((item.x - x) ** 2 + (item.y - y) ** 2, item.index, item)
        for item in projection.vertices
    )
    return ranked[0][2] if ranked and ranked[0][0] <= radius * radius else None


def vertices_in_brush(projection: DeformationFieldProjection, point, radius=0.12):
    x, y = float(point[0]), float(point[1])
    radius_squared = float(radius) ** 2
    return tuple(sorted(
        item.index for item in projection.vertices
        if (item.x - x) ** 2 + (item.y - y) ** 2 <= radius_squared
    ))


def _principal_axis(matrix, orthogonal_to=None):
    diagonal = tuple(matrix[index][index] for index in range(3))
    seeds = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0))
    seed = seeds[max(range(3), key=lambda index: diagonal[index])]
    if orthogonal_to is not None:
        candidates = tuple(_reject(value, orthogonal_to) for value in seeds)
        # Pick the remaining direction carrying the most covariance energy.
        # Choosing only by vector length is ambiguous for axis-aligned planes and
        # can select their zero-variance normal, collapsing the 2D projection.
        seed = max(candidates, key=lambda value: _length(_matrix_vector(matrix, value)))
    vector = _normalize(seed)
    for _ in range(24):
        value = tuple(sum(matrix[row][column] * vector[column] for column in range(3)) for row in range(3))
        if orthogonal_to is not None:
            value = _reject(value, orthogonal_to)
        updated = _normalize(value, fallback=vector)
        if _length(tuple(updated[index] - vector[index] for index in range(3))) < 1e-10:
            vector = updated
            break
        vector = updated
    largest = max(range(3), key=lambda index: abs(vector[index]))
    return tuple(-value for value in vector) if vector[largest] < 0.0 else vector


def _dot(left, right):
    return sum(a * b for a, b in zip(left, right))


def _matrix_vector(matrix, vector):
    return tuple(
        sum(matrix[row][column] * vector[column] for column in range(3))
        for row in range(3)
    )


def _cross(left, right):
    return (
        left[1] * right[2] - left[2] * right[1],
        left[2] * right[0] - left[0] * right[2],
        left[0] * right[1] - left[1] * right[0],
    )


def _reject(value, axis):
    amount = _dot(value, axis)
    return tuple(value[index] - axis[index] * amount for index in range(3))


def _length(value):
    return math.sqrt(sum(item * item for item in value))


def _normalize(value, fallback=(1.0, 0.0, 0.0)):
    length = _length(value)
    return tuple(item / length for item in value) if length > 1e-12 else tuple(fallback)


__all__ = [
    "DeformationFieldProjection", "SpatialVertexSignal", "hit_test_spatial",
    "project_deformation_field", "vertices_in_brush",
]
