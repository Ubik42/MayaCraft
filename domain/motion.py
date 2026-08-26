"""Host-independent motion analysis for Motion Magnetism."""

from __future__ import annotations

from dataclasses import dataclass, field
from math import acos, degrees, sqrt
from typing import Iterable, Tuple
import re


Vector3 = Tuple[float, float, float]
Quaternion = Tuple[float, float, float, float]


@dataclass(frozen=True)
class MotionSample:
    frame: float
    time_seconds: float
    position: Vector3
    rotation: Quaternion = (0.0, 0.0, 0.0, 1.0)


@dataclass(frozen=True)
class MotionSignal:
    sample: MotionSample
    velocity: Vector3
    acceleration: Vector3
    jerk: Vector3
    speed: float
    acceleration_magnitude: float
    jerk_magnitude: float
    arc_length: float
    angular_speed_degrees: float
    rotation_jump: bool = False


@dataclass(frozen=True)
class ContactInterval:
    start_frame: float
    end_frame: float
    start_index: int
    end_index: int
    anchor_position: Vector3
    max_drift: float
    confidence: float


@dataclass(frozen=True)
class MotionAnalysis:
    signals: Tuple[MotionSignal, ...] = field(default_factory=tuple)
    contacts: Tuple[ContactInterval, ...] = field(default_factory=tuple)
    total_arc_length: float = 0.0
    maximum_speed: float = 0.0
    maximum_acceleration: float = 0.0
    maximum_jerk: float = 0.0
    rotation_jump_count: int = 0


@dataclass(frozen=True)
class MotionCapture:
    node_path: str
    samples: Tuple[MotionSample, ...]
    analysis: MotionAnalysis
    frames_per_second: float
    source_label: str = "Maya worldMatrix"


@dataclass(frozen=True)
class MotionComparisonSignal:
    frame: float
    position_error: float
    velocity_error: float
    angular_error_degrees: float
    contact_expected: bool
    contact_preserved: bool


@dataclass(frozen=True)
class MotionComparison:
    signals: Tuple[MotionComparisonSignal, ...] = field(default_factory=tuple)
    rms_position_error: float = 0.0
    maximum_position_error: float = 0.0
    rms_velocity_error: float = 0.0
    maximum_angular_error_degrees: float = 0.0
    arc_length_delta: float = 0.0
    contact_preservation: float = 1.0


@dataclass(frozen=True)
class AnchorCorrection:
    sample_index: int
    frame: float
    expected_position: Vector3
    target_position: Vector3
    world_delta: Vector3
    influence: float


@dataclass(frozen=True)
class ContactAnchorPlan:
    node_path: str
    layer_name: str
    contact_start_frame: float
    contact_end_frame: float
    contact_confidence: float
    corrections: Tuple[AnchorCorrection, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def can_apply(self) -> bool:
        return bool(self.corrections) and not self.blockers

    @property
    def is_noop(self) -> bool:
        return not self.corrections and not self.blockers


@dataclass(frozen=True)
class ContactAnchorReceipt:
    plan: ContactAnchorPlan
    layer_name: str
    verified: bool
    maximum_error: float
    message: str


def _sub(left: Vector3, right: Vector3) -> Vector3:
    return tuple(a - b for a, b in zip(left, right))


def _scale(value: Vector3, factor: float) -> Vector3:
    return tuple(component * factor for component in value)


def _magnitude(value: Vector3) -> float:
    return sqrt(sum(component * component for component in value))


def _distance(left: Vector3, right: Vector3) -> float:
    return _magnitude(_sub(left, right))


def _derivative(values: Tuple[Vector3, ...], times: Tuple[float, ...]) -> Tuple[Vector3, ...]:
    if len(values) < 2:
        return tuple((0.0, 0.0, 0.0) for _ in values)
    result = []
    for index in range(len(values)):
        lower = max(0, index - 1)
        upper = min(len(values) - 1, index + 1)
        duration = times[upper] - times[lower]
        if duration <= 0.0:
            raise ValueError("运动采样时间必须严格递增")
        result.append(_scale(_sub(values[upper], values[lower]), 1.0 / duration))
    return tuple(result)


def _normalize_quaternion(value: Quaternion) -> Quaternion:
    magnitude = sqrt(sum(component * component for component in value))
    if magnitude <= 1e-12:
        return (0.0, 0.0, 0.0, 1.0)
    return tuple(component / magnitude for component in value)


def _quaternion_error_degrees(left: Quaternion, right: Quaternion) -> float:
    left_value = _normalize_quaternion(left)
    right_value = _normalize_quaternion(right)
    dot = sum(a * b for a, b in zip(left_value, right_value))
    return degrees(2.0 * acos(min(1.0, max(-1.0, abs(dot)))))


def _angular_signals(
    rotations: Tuple[Quaternion, ...],
    times: Tuple[float, ...],
    jump_degrees: float,
) -> Tuple[Tuple[float, bool], ...]:
    if not rotations:
        return ()
    result = [(0.0, False)]
    previous = _normalize_quaternion(rotations[0])
    for index in range(1, len(rotations)):
        current = _normalize_quaternion(rotations[index])
        dot = sum(a * b for a, b in zip(previous, current))
        dot = min(1.0, max(-1.0, abs(dot)))
        delta_degrees = degrees(2.0 * acos(dot))
        duration = times[index] - times[index - 1]
        if duration <= 0.0:
            raise ValueError("运动采样时间必须严格递增")
        result.append((delta_degrees / duration, delta_degrees > jump_degrees))
        previous = current
    return tuple(result)


def analyze_motion(
    samples: Iterable[MotionSample],
    contact_speed_threshold: float = 2.0,
    contact_height_threshold: float = 1.0,
    contact_drift_threshold: float = 0.75,
    minimum_contact_samples: int = 3,
    floor_height: float = 0.0,
    rotation_jump_degrees: float = 60.0,
) -> MotionAnalysis:
    values = tuple(samples)
    if not values:
        return MotionAnalysis()
    times = tuple(float(sample.time_seconds) for sample in values)
    if any(upper <= lower for lower, upper in zip(times, times[1:])):
        raise ValueError("运动采样时间必须严格递增")
    positions = tuple(sample.position for sample in values)
    velocities = _derivative(positions, times)
    accelerations = _derivative(velocities, times)
    jerks = _derivative(accelerations, times)
    angular = _angular_signals(tuple(sample.rotation for sample in values), times, rotation_jump_degrees)
    arc_lengths = [0.0]
    for previous, current in zip(positions, positions[1:]):
        arc_lengths.append(arc_lengths[-1] + _distance(previous, current))
    signals = tuple(
        MotionSignal(
            sample=sample,
            velocity=velocity,
            acceleration=acceleration,
            jerk=jerk,
            speed=_magnitude(velocity),
            acceleration_magnitude=_magnitude(acceleration),
            jerk_magnitude=_magnitude(jerk),
            arc_length=arc_length,
            angular_speed_degrees=angular_signal[0],
            rotation_jump=angular_signal[1],
        )
        for sample, velocity, acceleration, jerk, arc_length, angular_signal in zip(
            values, velocities, accelerations, jerks, arc_lengths, angular
        )
    )
    contacts = _infer_contacts(
        signals,
        speed_threshold=max(1e-9, contact_speed_threshold),
        height_threshold=max(1e-9, contact_height_threshold),
        drift_threshold=max(1e-9, contact_drift_threshold),
        minimum_samples=max(1, minimum_contact_samples),
        floor_height=floor_height,
    )
    return MotionAnalysis(
        signals=signals,
        contacts=contacts,
        total_arc_length=arc_lengths[-1],
        maximum_speed=max(signal.speed for signal in signals),
        maximum_acceleration=max(signal.acceleration_magnitude for signal in signals),
        maximum_jerk=max(signal.jerk_magnitude for signal in signals),
        rotation_jump_count=sum(signal.rotation_jump for signal in signals),
    )


def _infer_contacts(
    signals: Tuple[MotionSignal, ...],
    speed_threshold: float,
    height_threshold: float,
    drift_threshold: float,
    minimum_samples: int,
    floor_height: float,
) -> Tuple[ContactInterval, ...]:
    candidates = tuple(
        signal.speed <= speed_threshold
        and abs(signal.sample.position[1] - floor_height) <= height_threshold
        for signal in signals
    )
    ranges = []
    start = None
    for index, candidate in enumerate(candidates + (False,)):
        if candidate and start is None:
            start = index
        elif not candidate and start is not None:
            if index - start >= minimum_samples:
                ranges.append((start, index - 1))
            start = None
    contacts = []
    for start, end in ranges:
        segment = signals[start:end + 1]
        count = len(segment)
        anchor = tuple(
            sum(signal.sample.position[axis] for signal in segment) / count for axis in range(3)
        )
        max_drift = max(_distance(signal.sample.position, anchor) for signal in segment)
        maximum_speed = max(signal.speed for signal in segment)
        maximum_height = max(abs(signal.sample.position[1] - floor_height) for signal in segment)
        speed_score = 1.0 - min(1.0, maximum_speed / speed_threshold)
        height_score = 1.0 - min(1.0, maximum_height / height_threshold)
        drift_score = 1.0 - min(1.0, max_drift / drift_threshold)
        duration_score = min(1.0, count / max(minimum_samples * 2.0, 1.0))
        confidence = max(0.0, min(1.0, 0.35 * speed_score + 0.25 * height_score + 0.25 * drift_score + 0.15 * duration_score))
        contacts.append(
            ContactInterval(
                start_frame=segment[0].sample.frame,
                end_frame=segment[-1].sample.frame,
                start_index=start,
                end_index=end,
                anchor_position=anchor,
                max_drift=max_drift,
                confidence=confidence,
            )
        )
    return tuple(contacts)


def compare_motion(
    baseline: MotionAnalysis,
    candidate: MotionAnalysis,
    contact_position_tolerance: float = 0.75,
) -> MotionComparison:
    if len(baseline.signals) != len(candidate.signals):
        raise ValueError("运动对比要求采样数量一致")
    if not baseline.signals:
        return MotionComparison()
    baseline_frames = tuple(signal.sample.frame for signal in baseline.signals)
    candidate_frames = tuple(signal.sample.frame for signal in candidate.signals)
    if any(abs(left - right) > 1e-6 for left, right in zip(baseline_frames, candidate_frames)):
        raise ValueError("运动对比要求采样帧一致")
    baseline_contact_indices = {
        index
        for contact in baseline.contacts
        for index in range(contact.start_index, contact.end_index + 1)
    }
    signals = []
    expected_contacts = 0
    preserved_contacts = 0
    for index, (source, target) in enumerate(zip(baseline.signals, candidate.signals)):
        position_error = _distance(source.sample.position, target.sample.position)
        velocity_error = _distance(source.velocity, target.velocity)
        expected = index in baseline_contact_indices
        preserved = expected and position_error <= contact_position_tolerance
        expected_contacts += int(expected)
        preserved_contacts += int(preserved)
        signals.append(
            MotionComparisonSignal(
                frame=source.sample.frame,
                position_error=position_error,
                velocity_error=velocity_error,
                angular_error_degrees=_quaternion_error_degrees(source.sample.rotation, target.sample.rotation),
                contact_expected=expected,
                contact_preserved=preserved,
            )
        )
    count = len(signals)
    return MotionComparison(
        signals=tuple(signals),
        rms_position_error=sqrt(sum(item.position_error ** 2 for item in signals) / count),
        maximum_position_error=max(item.position_error for item in signals),
        rms_velocity_error=sqrt(sum(item.velocity_error ** 2 for item in signals) / count),
        maximum_angular_error_degrees=max(item.angular_error_degrees for item in signals),
        arc_length_delta=candidate.total_arc_length - baseline.total_arc_length,
        contact_preservation=(preserved_contacts / expected_contacts) if expected_contacts else 1.0,
    )


def plan_contact_anchor(
    baseline: MotionCapture,
    candidate: MotionCapture,
    contact_index: int,
    blend_samples: int = 2,
    tolerance: float = 1e-5,
) -> ContactAnchorPlan:
    blockers = []
    if baseline.node_path != candidate.node_path:
        blockers.append("基准与候选必须指向同一个 Maya 节点")
    if len(baseline.samples) != len(candidate.samples):
        blockers.append("基准与候选的采样数量不一致")
    elif any(abs(left.frame - right.frame) > 1e-6 for left, right in zip(baseline.samples, candidate.samples)):
        blockers.append("基准与候选的采样帧不一致")
    if not 0 <= contact_index < len(baseline.analysis.contacts):
        blockers.append("所选基准接触区间已不存在")
    leaf = baseline.node_path.rsplit("|", 1)[-1].rsplit(":", 1)[-1]
    safe_leaf = re.sub(r"[^A-Za-z0-9_]+", "_", leaf).strip("_") or "Control"
    layer_name = f"MayaCraft_Anchor_{safe_leaf}"
    if blockers:
        return ContactAnchorPlan(
            node_path=baseline.node_path,
            layer_name=layer_name,
            contact_start_frame=0.0,
            contact_end_frame=0.0,
            contact_confidence=0.0,
            blockers=tuple(blockers),
        )
    contact = baseline.analysis.contacts[contact_index]
    blend = max(0, int(blend_samples))
    lower = max(0, contact.start_index - blend)
    upper = min(len(baseline.samples) - 1, contact.end_index + blend)
    corrections = []
    for index in range(lower, upper + 1):
        if index < contact.start_index:
            influence = (index - lower + 1) / (contact.start_index - lower + 1)
        elif index > contact.end_index:
            influence = (upper - index + 1) / (upper - contact.end_index + 1)
        else:
            influence = 1.0
        source = candidate.samples[index]
        target_source = baseline.samples[index]
        full_delta = _sub(target_source.position, source.position)
        delta = _scale(full_delta, influence)
        if _magnitude(delta) <= tolerance:
            continue
        target = tuple(value + change for value, change in zip(source.position, delta))
        corrections.append(
            AnchorCorrection(
                sample_index=index,
                frame=source.frame,
                expected_position=source.position,
                target_position=target,
                world_delta=delta,
                influence=influence,
            )
        )
    return ContactAnchorPlan(
        node_path=baseline.node_path,
        layer_name=layer_name,
        contact_start_frame=contact.start_frame,
        contact_end_frame=contact.end_frame,
        contact_confidence=contact.confidence,
        corrections=tuple(corrections),
    )
