"""Maya 2025 skin-weight mirror transaction with spatial and weight readback verification."""

from __future__ import annotations

from dataclasses import replace

from MayaCraft.domain.skin_mirror import (
    InfluenceObservation,
    SkinMirrorPlan,
    SkinMirrorReceipt,
    SkinVertexObservation,
    plan_skin_mirror,
)


def _maya_modules():
    import maya.api.OpenMaya as om
    import maya.api.OpenMayaAnim as oma
    import maya.cmds as cmds
    return cmds, om, oma


class MayaSkinMirrorService:
    """Preview, apply, verify and undo a bounded directional mirror."""

    def plan_selection(self, direction="left_to_right", **kwargs):
        cmds, _om, _oma = _maya_modules()
        selection = cmds.ls(selection=True, objectsOnly=True, long=True) or []
        if not selection:
            return SkinMirrorPlan("", "", (), direction, self._empty_map(), blockers=("请选择一个已蒙皮网格",))
        mesh = self._mesh_shape(cmds, selection[0])
        if not mesh:
            return SkinMirrorPlan("", "", (), direction, self._empty_map(), blockers=("当前选择不是多边形网格",))
        skins = cmds.ls(cmds.listHistory(mesh, pruneDagObjects=True) or [], type="skinCluster") or []
        if not skins:
            return SkinMirrorPlan(mesh, "", (), direction, self._empty_map(), blockers=("所选网格没有 skinCluster",))
        return self.plan_mesh(mesh, skins[0], direction=direction, **kwargs)

    def plan_mesh(self, mesh_path, skin_cluster, direction="left_to_right", **kwargs):
        cmds, _om, _oma = _maya_modules()
        influences, vertices = self._capture(mesh_path, skin_cluster)
        plan = plan_skin_mirror(mesh_path, skin_cluster, influences, vertices, direction=direction, **kwargs)
        blockers = list(plan.blockers)
        if cmds.referenceQuery(mesh_path, isNodeReferenced=True) or cmds.referenceQuery(skin_cluster, isNodeReferenced=True):
            blockers.append("引用资产中的蒙皮数据必须在源资产内编辑")
        locked = {
            index for index, path in enumerate(plan.influences)
            if cmds.attributeQuery("liw", node=path, exists=True) and bool(cmds.getAttr(path + ".liw"))
        }
        changed_locked = sorted({
            index for change in plan.changes for index in locked
            if abs(change.before[index] - change.after[index]) > 1e-8
        })
        if changed_locked:
            blockers.append("镜像会修改已锁定的影响骨骼：" + ", ".join(plan.influences[index] for index in changed_locked))
        return replace(plan, blockers=tuple(blockers))

    def apply(self, plan):
        if not plan.can_apply:
            raise ValueError("当前蒙皮镜像计划不可应用")
        fresh = self.plan_mesh(plan.mesh_path, plan.skin_cluster, direction=plan.direction)
        if self._fingerprint(fresh) != self._fingerprint(plan):
            raise RuntimeError("预览后蒙皮权重或拓扑已经变化，请重新生成计划")
        cmds, _om, _oma = _maya_modules()
        opened = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Skin Mirror")
            opened = True
            for change in plan.changes:
                component = f"{plan.mesh_path}.vtx[{change.target_index}]"
                cmds.skinPercent(
                    plan.skin_cluster,
                    component,
                    transformValue=tuple(zip(plan.influences, change.after)),
                    normalize=False,
                )
            cmds.undoInfo(closeChunk=True)
            opened = False
            ordered_changes = tuple(sorted(plan.changes, key=lambda item: item.target_index))
            rows, influences = self._read_rows(
                plan.mesh_path, plan.skin_cluster,
                tuple(change.target_index for change in ordered_changes),
            )
            if tuple(influences) != tuple(plan.influences) or not all(
                self._vector_close(row, change.after)
                for row, change in zip(rows, ordered_changes)
            ):
                mismatch = next((
                    (change.target_index, tuple(round(value, 6) for value in row), tuple(round(value, 6) for value in change.after))
                    for row, change in zip(rows, ordered_changes) if not self._vector_close(row, change.after)
                ), None)
                raise RuntimeError(f"蒙皮镜像读回结果与预览不一致：{mismatch}")
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
            cmds.undo()
            raise
        return SkinMirrorReceipt(plan, True, f"已镜像并验证 {len(plan.changes)} 个顶点权重向量。")

    def undo(self, receipt):
        if not receipt.verified:
            raise ValueError("无法撤销未经验证的蒙皮镜像回执")
        cmds, _om, _oma = _maya_modules()
        cmds.undo()
        plan = receipt.plan
        ordered_changes = tuple(sorted(plan.changes, key=lambda item: item.target_index))
        rows, influences = self._read_rows(
            plan.mesh_path, plan.skin_cluster,
            tuple(change.target_index for change in ordered_changes),
        )
        if tuple(influences) != tuple(plan.influences) or not all(
            self._vector_close(row, change.before)
            for row, change in zip(rows, ordered_changes)
        ):
            raise RuntimeError("Maya 撤销没有恢复预览中的目标权重")
        return True

    @staticmethod
    def _capture(mesh_path, skin_cluster):
        cmds, om, oma = _maya_modules()
        mesh_selection = om.MSelectionList()
        mesh_selection.add(mesh_path)
        mesh_dag = mesh_selection.getDagPath(0)
        if mesh_dag.node().hasFn(om.MFn.kTransform):
            mesh_dag.extendToShape()
        skin_selection = om.MSelectionList()
        skin_selection.add(skin_cluster)
        skin_fn = oma.MFnSkinCluster(skin_selection.getDependNode(0))
        influence_paths = tuple(path.fullPathName() for path in skin_fn.influenceObjects())
        influences = tuple(
            InfluenceObservation(index, path, tuple(om.MTransformationMatrix(
                influence.inclusiveMatrix()).translation(om.MSpace.kWorld)))
            for index, (path, influence) in enumerate(zip(influence_paths, skin_fn.influenceObjects()))
        )
        mesh_fn = om.MFnMesh(mesh_dag)
        points = mesh_fn.getPoints(om.MSpace.kWorld)
        component_fn = om.MFnSingleIndexedComponent()
        component = component_fn.create(om.MFn.kMeshVertComponent)
        component_fn.addElements(range(mesh_fn.numVertices))
        weights, influence_count = skin_fn.getWeights(mesh_dag, component)
        vertices = tuple(
            SkinVertexObservation(
                index,
                (points[index].x, points[index].y, points[index].z),
                tuple(float(weights[index * influence_count + column]) for column in range(influence_count)),
            )
            for index in range(mesh_fn.numVertices)
        )
        return influences, vertices

    @staticmethod
    def _read_rows(mesh_path, skin_cluster, indices):
        if not indices:
            return (), ()
        _cmds, om, oma = _maya_modules()
        mesh_selection = om.MSelectionList()
        mesh_selection.add(mesh_path)
        mesh_dag = mesh_selection.getDagPath(0)
        if mesh_dag.node().hasFn(om.MFn.kTransform):
            mesh_dag.extendToShape()
        skin_selection = om.MSelectionList()
        skin_selection.add(skin_cluster)
        skin_fn = oma.MFnSkinCluster(skin_selection.getDependNode(0))
        component_fn = om.MFnSingleIndexedComponent()
        component = component_fn.create(om.MFn.kMeshVertComponent)
        component_fn.addElements(indices)
        weights, influence_count = skin_fn.getWeights(mesh_dag, component)
        rows = tuple(
            tuple(float(weights[row * influence_count + column]) for column in range(influence_count))
            for row in range(len(indices))
        )
        return rows, tuple(path.fullPathName() for path in skin_fn.influenceObjects())

    @staticmethod
    def _mesh_shape(cmds, node):
        if cmds.nodeType(node) == "mesh":
            return (cmds.ls(node, long=True) or [node])[0]
        shapes = cmds.listRelatives(node, shapes=True, noIntermediate=True, type="mesh", fullPath=True) or []
        return shapes[0] if shapes else ""

    @staticmethod
    def _fingerprint(plan):
        return (
            plan.mesh_path, plan.skin_cluster, plan.influences, plan.direction,
            tuple((item.left_index, item.right_index) for item in plan.influence_map.pairs),
            tuple((item.source_index, item.target_index, item.source_position, item.target_position, item.before, item.after) for item in plan.changes),
            plan.unmatched_vertices, plan.blockers, plan.vertex_count,
        )

    @staticmethod
    def _vector_close(left, right, tolerance=1e-6):
        return len(left) == len(right) and all(abs(a - b) <= tolerance for a, b in zip(left, right))

    @staticmethod
    def _empty_map():
        from MayaCraft.domain.skin_mirror import InfluenceMirrorMap
        return InfluenceMirrorMap()


__all__ = ["MayaSkinMirrorService"]
