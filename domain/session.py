"""Host-independent multi-character session state."""

from __future__ import annotations

from dataclasses import dataclass, field, replace
from typing import Iterable, Tuple

from MayaCraft.domain.character import CharacterSnapshot


@dataclass(frozen=True)
class SessionCharacter:
    stable_id: str
    display_name: str
    root: str
    namespace: str = "ROOT"
    registered: bool = False
    pinned: bool = False
    score: int = 0

    @classmethod
    def from_snapshot(cls, snapshot: CharacterSnapshot, pinned: bool = False):
        return cls(
            stable_id=snapshot.stable_id,
            display_name=snapshot.display_name,
            root=snapshot.root,
            namespace=snapshot.namespace,
            registered=snapshot.registered,
            pinned=pinned,
            score=snapshot.score,
        )


@dataclass(frozen=True)
class CharacterSession:
    characters: Tuple[SessionCharacter, ...] = field(default_factory=tuple)
    active_id: str = ""

    def reconcile(
        self,
        discovered: Iterable[CharacterSnapshot],
        current: CharacterSnapshot = None,
    ) -> "CharacterSession":
        previous = {item.stable_id: item for item in self.characters}
        merged = {}
        for snapshot in discovered:
            if snapshot.root and snapshot.stable_id:
                old = previous.get(snapshot.stable_id)
                merged[snapshot.stable_id] = SessionCharacter.from_snapshot(
                    snapshot, pinned=bool(old and old.pinned)
                )
        for item in self.characters:
            if item.pinned and item.stable_id not in merged:
                merged[item.stable_id] = item
        active_id = ""
        if current is not None and current.root and current.stable_id:
            old = previous.get(current.stable_id)
            merged[current.stable_id] = SessionCharacter.from_snapshot(
                current, pinned=bool(old and old.pinned)
            )
            active_id = current.stable_id
        elif self.active_id in merged:
            active_id = self.active_id
        ordered = sorted(
            merged.values(),
            key=lambda item: (
                item.stable_id != active_id,
                not item.pinned,
                not item.registered,
                item.display_name.casefold(),
            ),
        )
        return CharacterSession(tuple(ordered), active_id)

    def pin(self, stable_id: str) -> "CharacterSession":
        if stable_id not in {item.stable_id for item in self.characters}:
            return self
        return replace(
            self,
            characters=tuple(
                replace(item, pinned=True) if item.stable_id == stable_id else item
                for item in self.characters
            ),
        )

    def root_for(self, stable_id: str) -> str:
        return next((item.root for item in self.characters if item.stable_id == stable_id), "")
