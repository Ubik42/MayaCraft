"""Read-only discovery of MayaCraft-linked characters in the current scene."""

from __future__ import annotations

from MayaCraft.adapters.maya.character_context import MayaCharacterScanner, _maya_modules
from MayaCraft.adapters.maya.character_registration import CHARACTER_ATTR, ID_ATTR


class MayaCharacterSessionScanner:
    def __init__(self, scanner=None):
        self._scanner = scanner or MayaCharacterScanner()

    def discover(self):
        cmds, _om = _maya_modules()
        candidates = cmds.ls(
            f"*.{CHARACTER_ATTR}", objectsOnly=True, long=True, recursive=True
        ) or []
        snapshots = []
        for root in sorted(set(candidates), key=str.casefold):
            if not cmds.objExists(root) or not cmds.objectType(root, isAType="dagNode"):
                continue
            if not self._truthy_attribute(cmds, root, CHARACTER_ATTR):
                continue
            if not self._truthy_attribute(cmds, root, ID_ATTR):
                continue
            snapshot = self._scanner.capture_root(root)
            if snapshot.registered:
                snapshots.append(snapshot)
        return tuple(snapshots)

    @staticmethod
    def _truthy_attribute(cmds, node, attribute):
        try:
            return bool(cmds.getAttr(f"{node}.{attribute}"))
        except Exception:
            return False
