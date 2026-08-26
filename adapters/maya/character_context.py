"""Read-only character discovery against the live Maya dependency graph."""

from __future__ import annotations

import hashlib
from time import perf_counter
from typing import Callable, Iterable, List, Optional

from MayaCraft.domain.character import CharacterSnapshot, NodeSummary, RigNode
from MayaCraft.adapters.maya.character_registration import (
    CHARACTER_ATTR,
    ID_ATTR,
    SCHEMA_ATTR,
)


def _maya_modules():
    import maya.api.OpenMaya as om
    import maya.cmds as cmds

    return cmds, om


def _short_name(path: str) -> str:
    return path.rsplit("|", 1)[-1]


def _namespace(name: str) -> str:
    leaf = _short_name(name)
    return leaf.rsplit(":", 1)[0] if ":" in leaf else "ROOT"


class MayaCharacterScanner:
    """Find a plausible character boundary and summarize it without scene writes."""

    CACHE_TTL_SECONDS = 0.75

    def __init__(self):
        self._structure_cache = {}

    def invalidate(self) -> None:
        self._structure_cache.clear()

    def capture_selection(self) -> CharacterSnapshot:
        cmds, _om = _maya_modules()
        selection = cmds.ls(selection=True, long=True) or []
        if not selection:
            return CharacterSnapshot.empty()

        roots = self._candidate_roots(cmds, selection)
        if not roots:
            return CharacterSnapshot.empty("当前选择没有可用的 DAG 角色上下文。")

        root = max(roots, key=lambda item: self._character_weight(cmds, item))
        return self.capture_root(root, selection)

    def capture_root(self, root: str, selection=()) -> CharacterSnapshot:
        """Summarize a known character root without changing Maya selection."""
        cmds, _om = _maya_modules()
        matches = cmds.ls(root, long=True) or []
        if not matches:
            return CharacterSnapshot.empty(f"角色根节点已不存在：{root}")
        root = matches[0]
        joints, mesh_shapes, curve_shapes = self._structure(cmds, root)
        mesh_transforms = set(
            (cmds.listRelatives(shape, parent=True, fullPath=True) or [shape])[0]
            for shape in mesh_shapes
        )
        control_transforms = set(
            (cmds.listRelatives(shape, parent=True, fullPath=True) or [shape])[0]
            for shape in curve_shapes
        )
        skin_clusters = set()
        for mesh in mesh_shapes:
            skin_clusters.update(cmds.ls(cmds.listHistory(mesh, pruneDagObjects=True) or [], type="skinCluster") or [])

        selection = tuple(selection)
        selected_summary = tuple(self._node_summary(cmds, node) for node in selection[:12])
        rig_nodes = self._rig_nodes(cmds, joints, control_transforms, selection)
        registered = bool(self._attribute(cmds, root, CHARACTER_ATTR, False))
        schema_version = int(self._attribute(cmds, root, SCHEMA_ATTR, 0) or 0)
        registered_id = self._attribute(cmds, root, ID_ATTR, "")
        uuid_values = cmds.ls(root, uuid=True) or []
        identity = uuid_values[0] if uuid_values else root
        generated_id = hashlib.sha1(identity.encode("utf-8")).hexdigest()[:10].upper()
        stable_id = registered_id if registered and registered_id else generated_id
        score = self._score(len(joints), len(mesh_transforms), len(control_transforms), len(skin_clusters))
        referenced = bool(cmds.referenceQuery(root, isNodeReferenced=True))
        name = _short_name(root).rsplit(":", 1)[-1]

        return CharacterSnapshot(
            stable_id=stable_id,
            display_name=name,
            root=root,
            namespace=_namespace(root),
            selected=selected_summary,
            rig_nodes=rig_nodes,
            joint_count=len(joints),
            mesh_count=len(mesh_transforms),
            control_count=len(control_transforms),
            skin_cluster_count=len(skin_clusters),
            referenced=referenced,
            registered=registered and bool(registered_id),
            schema_version=schema_version,
            score=score,
            message=f"已从 {len(selection)} 个所选节点捕获 {_short_name(root)}。",
        )

    def _structure(self, cmds, root):
        cached = self._structure_cache.get(root)
        now = perf_counter()
        if cached and now - cached[0] <= self.CACHE_TTL_SECONDS:
            return cached[1]
        members = [root] + (cmds.listRelatives(root, allDescendents=True, fullPath=True) or [])
        result = (
            tuple(self._of_type(cmds, members, "joint")),
            tuple(self._of_type(cmds, members, "mesh", include_intermediate=False)),
            tuple(self._of_type(cmds, members, "nurbsCurve", include_intermediate=False)),
        )
        self._structure_cache[root] = (now, result)
        return result

    @staticmethod
    def _candidate_roots(cmds, selection: Iterable[str]) -> List[str]:
        roots: List[str] = []
        for node in selection:
            object_matches = cmds.ls(node, objectsOnly=True, long=True) or []
            if object_matches:
                node = object_matches[0]
            if not cmds.objectType(node, isAType="dagNode"):
                continue
            if cmds.nodeType(node) not in {"transform", "joint"}:
                parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
                if not parents:
                    continue
                node = parents[0]
            lineage = [node]
            cursor = node
            seed_namespace = _namespace(node)
            while True:
                parents = cmds.listRelatives(cursor, parent=True, fullPath=True) or []
                if not parents:
                    break
                candidate = parents[0]
                if seed_namespace != "ROOT" and _namespace(candidate) != seed_namespace:
                    break
                cursor = candidate
                lineage.append(cursor)
            roots.append(lineage[-1])
        return list(dict.fromkeys(roots))

    @staticmethod
    def _node_summary(cmds, selected: str) -> NodeSummary:
        objects = cmds.ls(selected, objectsOnly=True, long=True) or []
        node = objects[0] if objects else selected
        return NodeSummary(_short_name(selected), selected, cmds.nodeType(node))

    @staticmethod
    def _of_type(cmds, members: Iterable[str], node_type: str, include_intermediate: bool = True) -> List[str]:
        result = [node for node in members if cmds.nodeType(node) == node_type]
        if not include_intermediate and node_type in {"mesh", "nurbsCurve"}:
            result = [node for node in result if not cmds.getAttr(node + ".intermediateObject")]
        return result

    @staticmethod
    def _character_weight(cmds, root: str) -> int:
        members = [root] + (cmds.listRelatives(root, allDescendents=True, fullPath=True) or [])
        types = [cmds.nodeType(node) for node in members]
        return (types.count("joint") * 5) + (types.count("mesh") * 3) + types.count("nurbsCurve")

    @staticmethod
    def _score(joints: int, meshes: int, controls: int, skins: int) -> int:
        return min(100, min(joints, 20) * 2 + min(meshes, 5) * 7 + min(controls, 20) + min(skins, 5) * 5)

    @staticmethod
    def _attribute(cmds, node: str, attribute: str, default):
        if not cmds.attributeQuery(attribute, node=node, exists=True):
            return default
        try:
            return cmds.getAttr(f"{node}.{attribute}")
        except Exception:
            return default

    @classmethod
    def _rig_nodes(cls, cmds, joints, controls, selection) -> tuple:
        selected_paths = set(selection)
        nodes = list(joints[:200])
        nodes.extend(sorted(controls, key=str.casefold)[:80])
        node_paths = set(nodes)
        result = []
        for node in nodes:
            parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
            parent_path = parents[0] if parents and parents[0] in node_paths else ""
            try:
                raw_position = cmds.xform(node, query=True, worldSpace=True, translation=True)
                position = tuple(float(value) for value in raw_position[:3])
            except Exception:
                position = (0.0, 0.0, 0.0)
            result.append(
                RigNode(
                    name=_short_name(node),
                    path=node,
                    kind="joint" if cmds.nodeType(node) == "joint" else "control",
                    parent_path=parent_path,
                    position=position,
                    side=cls._side(_short_name(node)),
                    selected=node in selected_paths,
                )
            )
        return tuple(result)

    @staticmethod
    def _side(name: str) -> str:
        leaf = name.rsplit(":", 1)[-1].lower()
        if leaf.startswith(("l_", "left_")) or leaf.endswith(("_l", "_left", ".l")):
            return "left"
        if leaf.startswith(("r_", "right_")) or leaf.endswith(("_r", "_right", ".r")):
            return "right"
        return "center"


class MayaSelectionWatcher:
    """Lifecycle-owned Maya selection callback; safe to start and stop repeatedly."""

    def __init__(self, callback: Callable[[], None]):
        self._callback = callback
        self._callback_id: Optional[int] = None
        self._maya_callback = lambda *_args: self._callback()

    def start(self) -> None:
        if self._callback_id is not None:
            return
        _cmds, om = _maya_modules()
        self._callback_id = om.MEventMessage.addEventCallback("SelectionChanged", self._maya_callback)

    def stop(self) -> None:
        if self._callback_id is None:
            return
        _cmds, om = _maya_modules()
        try:
            om.MMessage.removeCallback(self._callback_id)
        finally:
            self._callback_id = None

    def __del__(self):
        try:
            self.stop()
        except Exception:
            pass
