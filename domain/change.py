"""Host-independent change plans and verification receipts."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Tuple


@dataclass(frozen=True)
class AttributeChange:
    """One explicit Maya attribute mutation in a previewable plan."""

    attribute: str
    label: str
    current_value: Any
    target_value: Any
    data_type: str

    @property
    def creates_attribute(self) -> bool:
        return self.current_value is None


@dataclass(frozen=True)
class CharacterRegistrationPlan:
    """Immutable preview for registering one character root."""

    target_root: str
    stable_id: str
    changes: Tuple[AttributeChange, ...] = field(default_factory=tuple)
    warnings: Tuple[str, ...] = field(default_factory=tuple)
    blockers: Tuple[str, ...] = field(default_factory=tuple)

    @property
    def is_noop(self) -> bool:
        return not self.changes and not self.blockers

    @property
    def can_apply(self) -> bool:
        return bool(self.target_root and self.changes and not self.blockers)


@dataclass(frozen=True)
class ChangeReceipt:
    """Result returned only after the adapter has verified scene state."""

    operation: str
    target_root: str
    applied_count: int
    verified: bool
    message: str

