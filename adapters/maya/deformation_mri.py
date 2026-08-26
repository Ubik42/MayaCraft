"""Maya API 2.0 extraction for Deformation MRI."""

from __future__ import annotations

from time import perf_counter

from MayaCraft.domain.deformation import (
    DeformationMRIResult,
    DeformationRepairPlan,
    DeformationRepairReceipt,
    analyze_influence_rows,
    analyze_weight_rows,
    merge_influence_reports,
    merge_reports,
    plan_normalization_repair,
)


def _maya_modules():
    import maya.api.OpenMaya as om
    import maya.api.OpenMayaAnim as oma
    import maya.cmds as cmds

    return cmds, om, oma


class MayaDeformationScanner:
    """Read skin weights in bounded batches without changing selection or scene data."""

    def scan_character(self, snapshot, batch_size: int = 4096):
        if snapshot.is_empty:
            return ()
        cmds, _om, _oma = _maya_modules()
        members = cmds.listRelatives(snapshot.root, allDescendents=True, fullPath=True) or []
        mesh_shapes = [
            node
            for node in members
            if cmds.nodeType(node) == "mesh" and not cmds.getAttr(node + ".intermediateObject")
        ]
        results = []
        seen = set()
        for mesh_path in mesh_shapes:
            skin_clusters = cmds.ls(
                cmds.listHistory(mesh_path, pruneDagObjects=True) or [], type="skinCluster"
            ) or []
            for skin_cluster in skin_clusters:
                key = (mesh_path, skin_cluster)
                if key in seen:
                    continue
                seen.add(key)
                results.append(self.scan_mesh(mesh_path, skin_cluster, batch_size=batch_size))
        return tuple(results)

    @staticmethod
    def scan_mesh(mesh_path: str, skin_cluster: str, batch_size: int = 4096):
        cmds, om, oma = _maya_modules()
        started = perf_counter()
        mesh_selection = om.MSelectionList()
        mesh_selection.add(mesh_path)
        mesh_dag = mesh_selection.getDagPath(0)
        skin_selection = om.MSelectionList()
        skin_selection.add(skin_cluster)
        skin_object = skin_selection.getDependNode(0)
        skin_fn = oma.MFnSkinCluster(skin_object)
        influence_paths = tuple(path.fullPathName() for path in skin_fn.influenceObjects())
        locked = tuple(
            path
            for path in influence_paths
            if cmds.attributeQuery("liw", node=path, exists=True) and bool(cmds.getAttr(path + ".liw"))
        )
        locked_columns = tuple(
            index for index, path in enumerate(influence_paths) if path in set(locked)
        )
        connected_indices = {
            int(skin_fn.indexForInfluenceObject(path)) for path in skin_fn.influenceObjects()
        }
        matrix_indices = set(cmds.getAttr(skin_cluster + ".matrix", multiIndices=True) or [])
        missing = tuple(f"matrix[{index}]" for index in sorted(matrix_indices - connected_indices))
        mesh_fn = om.MFnMesh(mesh_dag)
        vertex_count = mesh_fn.numVertices
        world_points = mesh_fn.getPoints(om.MSpace.kWorld)
        positions = tuple((float(point.x), float(point.y), float(point.z)) for point in world_points)
        _triangle_counts, triangle_indices = mesh_fn.getTriangles()
        triangles = tuple(
            tuple(int(triangle_indices[offset + axis]) for axis in range(3))
            for offset in range(0, len(triangle_indices), 3)
        )
        reports = []
        inspector_batches = []
        step = max(1, int(batch_size))
        for start in range(0, vertex_count, step):
            count = min(step, vertex_count - start)
            component_fn = om.MFnSingleIndexedComponent()
            component = component_fn.create(om.MFn.kMeshVertComponent)
            component_fn.addElements(range(start, start + count))
            weights, influence_count = skin_fn.getWeights(mesh_dag, component)
            rows = tuple(
                tuple(float(weights[row * influence_count + column]) for column in range(influence_count))
                for row in range(count)
            )
            reports.append(analyze_weight_rows(rows, start_index=start))
            inspector_batches.append(
                analyze_influence_rows(
                    rows,
                    influence_paths,
                    locked_indices=locked_columns,
                    start_index=start,
                )
            )
        report = merge_reports(reports)
        inspector = merge_influence_reports(inspector_batches, report, missing)
        return DeformationMRIResult(
            mesh_path=mesh_path,
            skin_cluster=skin_cluster,
            influences=influence_paths,
            report=report,
            elapsed_ms=(perf_counter() - started) * 1000.0,
            locked_influences=locked,
            missing_influences=missing,
            vertex_positions=positions,
            triangles=triangles,
            inspector=inspector,
        )


class MayaDeformationRepairService:
    """Sparse, previewable normalization repair with readback and Maya undo."""

    def plan(self, result: DeformationMRIResult):
        indices = tuple(
            signal.index
            for signal in result.report.vertices
            if signal.weight_sum > 0.001 and abs(signal.weight_sum - 1.0) > 0.001
        )
        if not indices:
            return plan_normalization_repair(
                result.mesh_path, result.skin_cluster, result.influences, ()
            )
        rows, influences = self._read_rows(result.mesh_path, result.skin_cluster, indices)
        if tuple(influences) != tuple(result.influences):
            return DeformationRepairPlan(
                mesh_path=result.mesh_path,
                skin_cluster=result.skin_cluster,
                influences=tuple(result.influences),
                blockers=("Skin influence order changed after the MRI scan",),
            )
        return plan_normalization_repair(
            result.mesh_path,
            result.skin_cluster,
            influences,
            zip(indices, rows),
        )

    def apply(self, plan):
        if not plan.can_apply:
            raise ValueError("当前变形修复计划不可应用")
        cmds, _om, _oma = _maya_modules()
        indices = tuple(change.vertex_index for change in plan.changes)
        current_rows, influences = self._read_rows(plan.mesh_path, plan.skin_cluster, indices)
        if tuple(influences) != tuple(plan.influences):
            raise RuntimeError("预览后蒙皮影响骨骼已经变化，请重新生成计划")
        for change, current in zip(plan.changes, current_rows):
            if not self._vector_close(current, change.before):
                raise RuntimeError(
                    f"Weights changed after preview at vtx[{change.vertex_index}]; rebuild the plan"
                )
        opened = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Deformation MRI Normalize")
            opened = True
            for change in plan.changes:
                component = f"{plan.mesh_path}.vtx[{change.vertex_index}]"
                cmds.skinPercent(
                    plan.skin_cluster,
                    component,
                    transformValue=tuple(zip(plan.influences, change.after)),
                    normalize=False,
                )
            cmds.undoInfo(closeChunk=True)
            opened = False
            verified_rows, _influences = self._read_rows(plan.mesh_path, plan.skin_cluster, indices)
            if not all(
                self._vector_close(current, change.after)
                for change, current in zip(plan.changes, verified_rows)
            ):
                raise RuntimeError("权重读回结果与修复计划不一致")
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
            cmds.undo()
            raise
        return DeformationRepairReceipt(
            plan=plan,
            verified=True,
            message=f"已归一化并验证 {len(plan.changes)} 个顶点权重向量。",
        )

    def undo(self, receipt):
        if not receipt.verified:
            raise ValueError("无法撤销未经验证的变形修复回执")
        cmds, _om, _oma = _maya_modules()
        cmds.undo()
        plan = receipt.plan
        indices = tuple(change.vertex_index for change in plan.changes)
        restored, _influences = self._read_rows(plan.mesh_path, plan.skin_cluster, indices)
        if not all(
            self._vector_close(current, change.before)
            for change, current in zip(plan.changes, restored)
        ):
            raise RuntimeError("Maya 撤销没有恢复预览中的权重向量")
        return True

    @staticmethod
    def _read_rows(mesh_path, skin_cluster, indices):
        if not indices:
            return (), ()
        _cmds, om, oma = _maya_modules()
        mesh_selection = om.MSelectionList()
        mesh_selection.add(mesh_path)
        mesh_dag = mesh_selection.getDagPath(0)
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
        influences = tuple(path.fullPathName() for path in skin_fn.influenceObjects())
        return rows, influences

    @staticmethod
    def _vector_close(left, right, tolerance=1e-6):
        return len(left) == len(right) and all(abs(a - b) <= tolerance for a, b in zip(left, right))
