"""Maya 2025 metadata adapter and transactional incremental Rig Graph compiler."""

from __future__ import annotations

import json
import math
from dataclasses import replace

from MayaCraft.domain.rig_graph import (
    ObservedRigBehavior,
    ObservedRigNode,
    RigBuildReceipt,
    RigGraphIssue,
    compile_incremental_rig,
)


NODE_MARKER = "mayacraftRigNode"
NODE_ID = "mayacraftRigNodeId"
GRAPH_ID = "mayacraftRigGraphId"
MODULE_ID = "mayacraftRigModuleId"
RIG_LAYER = "mayacraftRigLayer"
SIGNATURE = "mayacraftRigSignature"
BEHAVIOR_MARKER = "mayacraftRigBehavior"
BEHAVIOR_ID = "mayacraftRigBehaviorId"
BEHAVIOR_TYPE = "mayacraftRigBehaviorType"
BEHAVIOR_SIGNATURE = "mayacraftRigBehaviorSignature"
BEHAVIOR_OWNER_ID = "mayacraftRigBehaviorOwnerId"


def _cmds():
    import maya.cmds as cmds

    return cmds


class MayaRigGraphService:
    """Compile only MayaCraft-owned nodes and verify the complete declared graph."""

    def scan(self, graph_id: str):
        cmds = _cmds()
        candidates = cmds.ls(f"*.{NODE_MARKER}", objectsOnly=True, long=True, recursive=True) or []
        result = []
        seen = set()
        for node in sorted(set(candidates), key=str.casefold):
            if not cmds.objExists(node) or not self._get(cmds, node, NODE_MARKER, False):
                continue
            if self._get(cmds, node, GRAPH_ID, "") != graph_id:
                continue
            stable_id = self._get(cmds, node, NODE_ID, "")
            if not stable_id:
                continue
            if stable_id in seen:
                raise RuntimeError(f"场景中存在重复的 MayaCraft 绑定节点 ID：{stable_id}")
            seen.add(stable_id)
            parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
            parent_id = self._get(cmds, parents[0], NODE_ID, "") if parents else ""
            raw_signature = self._get(cmds, node, SIGNATURE, "[]")
            try:
                signature = tuple(tuple(item) for item in json.loads(raw_signature or "[]"))
            except (TypeError, ValueError):
                signature = (("__invalid__", str(raw_signature)),)
            signature = self._physical_node_signature(cmds, node, signature)
            result.append(
                ObservedRigNode(
                    stable_id=stable_id,
                    maya_name=node.rsplit("|", 1)[-1],
                    node_type=cmds.nodeType(node),
                    owner_module=self._get(cmds, node, MODULE_ID, ""),
                    layer=self._get(cmds, node, RIG_LAYER, ""),
                    parent_id=parent_id,
                    signature=signature,
                )
            )
        return tuple(result)

    def scan_behaviors(self, graph_id: str):
        cmds = _cmds()
        candidates = cmds.ls(f"*.{BEHAVIOR_MARKER}", objectsOnly=True, long=True, recursive=True) or []
        result = []
        seen = set()
        for node in sorted(set(candidates), key=str.casefold):
            if not cmds.objExists(node) or not self._get(cmds, node, BEHAVIOR_MARKER, False):
                continue
            if self._get(cmds, node, GRAPH_ID, "") != graph_id:
                continue
            stable_id = self._get(cmds, node, BEHAVIOR_ID, "")
            if not stable_id:
                continue
            if stable_id in seen:
                raise RuntimeError(f"场景中存在重复的 MayaCraft 绑定行为 ID：{stable_id}")
            seen.add(stable_id)
            behavior_type = self._get(cmds, node, BEHAVIOR_TYPE, "")
            raw = self._get(cmds, node, BEHAVIOR_SIGNATURE, "[]")
            try:
                stored = dict(tuple(item) for item in json.loads(raw or "[]"))
            except (TypeError, ValueError):
                stored = {"__invalid__": str(raw)}
            sources, targets = self._physical_behavior_endpoints(cmds, node, behavior_type, stable_id)
            stored["sources"] = "|".join(sources)
            stored["targets"] = "|".join(targets)
            result.append(ObservedRigBehavior(
                stable_id=stable_id,
                behavior_type=behavior_type,
                owner_module=self._get(cmds, node, MODULE_ID, ""),
                sources=sources,
                targets=targets,
                signature=tuple(sorted(stored.items())),
            ))
        return tuple(result)

    def plan(self, graph):
        observed = self.scan(graph.graph_id)
        observed_behaviors = self.scan_behaviors(graph.graph_id)
        plan = compile_incremental_rig(graph, observed, observed_behaviors)
        if plan.blockers:
            return plan
        cmds = _cmds()
        missing_sources = sorted({
            dict(node.attributes).get("sourceJoint", "")
            for node in graph.nodes
            if dict(node.attributes).get("sourceJoint", "")
            and not cmds.objExists(dict(node.attributes)["sourceJoint"])
        })
        if missing_sources:
            issue = RigGraphIssue(
                "missing_source_joint",
                "声明引用的源关节已经缺失或改名：" + ", ".join(missing_sources[:4]),
                graph.graph_id,
            )
            return replace(plan, blockers=plan.blockers + (issue,))
        referenced = []
        by_id = self._paths_by_id(cmds, graph.graph_id)
        changed_ids = {change.stable_id for change in plan.changes if change.action != "PRESERVE"}
        behavior_by_id = {item.stable_id: item for item in graph.behaviors}
        for change in plan.behavior_changes:
            if change.action != "PRESERVE" and change.stable_id in behavior_by_id:
                behavior = behavior_by_id[change.stable_id]
                changed_ids.update(behavior.sources + behavior.targets)
        for stable_id in changed_ids:
            path = by_id.get(stable_id)
            if path and cmds.referenceQuery(path, isNodeReferenced=True):
                referenced.append(stable_id)
        if referenced:
            issue = RigGraphIssue(
                "referenced_change",
                "引用绑定图节点需要在源资产中构建：" + ", ".join(sorted(referenced)),
                graph.graph_id,
            )
            return replace(plan, blockers=plan.blockers + (issue,))
        return plan

    def apply(self, graph, plan):
        if not plan.can_apply:
            raise ValueError("当前绑定构建计划不可应用")
        current_plan = self.plan(graph)
        if self._fingerprint(current_plan) != self._fingerprint(plan):
            raise RuntimeError("预览后绑定图已经变化，请重新生成计划")
        previous = self.scan(graph.graph_id)
        previous_behaviors = self.scan_behaviors(graph.graph_id)
        cmds = _cmds()
        opened = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Incremental Rig Build")
            opened = True
            paths = self._paths_by_id(cmds, graph.graph_id)
            desired = {node.stable_id: node for node in graph.nodes}
            behavior_paths = self._behavior_paths_by_id(cmds, graph.graph_id)
            for change in plan.behavior_changes:
                if change.action in {"REMOVE", "REBUILD", "UPDATE"}:
                    path = behavior_paths.get(change.stable_id)
                    if path and cmds.objExists(path):
                        self._delete_behavior(cmds, path, change.stable_id)
            for change in plan.changes:
                if change.action == "REBUILD" and change.stable_id in paths:
                    cmds.delete(paths.pop(change.stable_id))
            node_changes = {item.stable_id: item for item in plan.changes}
            for target in self._ordered_specs(graph.nodes):
                paths.update(self._paths_by_id(cmds, graph.graph_id))
                path = paths.get(target.stable_id)
                change = node_changes[target.stable_id]
                if change.action == "PRESERVE":
                    if not path or not cmds.objExists(path):
                        raise RuntimeError(f"预期保留的绑定节点已经消失：{target.stable_id}")
                    continue
                if not path or not cmds.objExists(path):
                    path = cmds.createNode(target.node_type, name=target.maya_name)
                elif path.rsplit("|", 1)[-1] != target.maya_name:
                    path = cmds.rename(path, target.maya_name)
                self._write_metadata(cmds, path, graph.graph_id, target)
                paths[target.stable_id] = (cmds.ls(path, long=True) or [path])[0]
                if target.parent_id:
                    parent = paths.get(target.parent_id)
                    if not parent:
                        raise RuntimeError(f"父节点未在子节点之前完成编译：{target.parent_id}")
                    current_parent = cmds.listRelatives(paths[target.stable_id], parent=True, fullPath=True) or []
                    if not current_parent or current_parent[0] != parent:
                        paths[target.stable_id] = cmds.parent(paths[target.stable_id], parent)[0]
                        paths[target.stable_id] = (cmds.ls(paths[target.stable_id], long=True) or [paths[target.stable_id]])[0]
                self._apply_declared_transform(cmds, paths[target.stable_id], target)
            paths.update(self._paths_by_id(cmds, graph.graph_id))
            desired_behaviors = {item.stable_id: item for item in graph.behaviors}
            for change in plan.behavior_changes:
                if change.action in {"CREATE", "REBUILD", "UPDATE"}:
                    self._apply_behavior(cmds, graph.graph_id, desired_behaviors[change.stable_id], paths)
            for change in plan.changes:
                if change.action == "REMOVE":
                    paths.update(self._paths_by_id(cmds, graph.graph_id))
                    path = paths.get(change.stable_id)
                    if path and cmds.objExists(path):
                        cmds.delete(path)
            cmds.undoInfo(closeChunk=True)
            opened = False
            verification = compile_incremental_rig(
                graph,
                self.scan(graph.graph_id),
                self.scan_behaviors(graph.graph_id),
            )
            if not verification.is_noop:
                details = ", ".join(f"{item.action}:{item.stable_id}" for item in verification.all_changes if item.action != "PRESERVE")
                observed_behavior_map = {
                    item.stable_id: item for item in self.scan_behaviors(graph.graph_id)
                }
                endpoint_details = []
                for item in verification.behavior_changes:
                    if item.action == "PRESERVE":
                        continue
                    observed_item = observed_behavior_map.get(item.stable_id)
                    if observed_item:
                        endpoint_details.append(
                            f"{item.stable_id}[输入={observed_item.sources}, 输出={observed_item.targets}]"
                        )
                if endpoint_details:
                    details += "；物理端点 " + ", ".join(endpoint_details)
                raise RuntimeError(f"绑定图读回结果与声明不一致：{details}")
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
            cmds.undo()
            raise
        applied_count = sum(change.action != "PRESERVE" for change in plan.all_changes)
        return RigBuildReceipt(
            graph_id=graph.graph_id,
            verified=True,
            applied_count=applied_count,
            previous=previous,
            message=f"已应用并验证 {applied_count} 项增量绑定图变更。",
            previous_behaviors=previous_behaviors,
        )

    def undo(self, graph, receipt):
        if not receipt.verified or receipt.graph_id != graph.graph_id:
            raise ValueError("绑定构建回执与当前图不匹配")
        cmds = _cmds()
        cmds.undo()
        restored = self.scan(graph.graph_id)
        if self._observed_fingerprint(restored) != self._observed_fingerprint(receipt.previous):
            raise RuntimeError("Maya 撤销没有恢复先前的绑定图状态")
        restored_behaviors = self.scan_behaviors(graph.graph_id)
        if self._observed_behavior_fingerprint(restored_behaviors) != self._observed_behavior_fingerprint(receipt.previous_behaviors):
            raise RuntimeError("Maya 撤销没有恢复先前的绑定行为状态")
        return True

    @staticmethod
    def _fingerprint(plan):
        return (
            tuple((item.code, item.message, item.subject_id) for item in plan.blockers),
            tuple((item.action, item.stable_id, item.summary) for item in plan.changes),
            tuple((item.action, item.stable_id, item.summary) for item in plan.behavior_changes),
            plan.observed_fingerprint,
            plan.observed_behavior_fingerprint,
        )

    @staticmethod
    def _observed_fingerprint(values):
        return tuple(sorted(
            (item.stable_id, item.maya_name, item.node_type, item.owner_module, item.layer, item.parent_id, tuple(sorted(item.signature)))
            for item in values
        ))

    @staticmethod
    def _observed_behavior_fingerprint(values):
        return tuple(sorted(
            (item.stable_id, item.behavior_type, item.owner_module, item.sources, item.targets, tuple(sorted(item.signature)))
            for item in values
        ))

    @staticmethod
    def _paths_by_id(cmds, graph_id):
        paths = {}
        candidates = cmds.ls(f"*.{NODE_MARKER}", objectsOnly=True, long=True, recursive=True) or []
        for path in candidates:
            if MayaRigGraphService._get(cmds, path, GRAPH_ID, "") == graph_id:
                stable_id = MayaRigGraphService._get(cmds, path, NODE_ID, "")
                if stable_id:
                    paths[stable_id] = path
        return paths

    @staticmethod
    def _behavior_paths_by_id(cmds, graph_id):
        paths = {}
        candidates = cmds.ls(f"*.{BEHAVIOR_MARKER}", objectsOnly=True, long=True, recursive=True) or []
        for path in candidates:
            if MayaRigGraphService._get(cmds, path, GRAPH_ID, "") == graph_id:
                stable_id = MayaRigGraphService._get(cmds, path, BEHAVIOR_ID, "")
                if stable_id:
                    paths[stable_id] = path
        return paths

    @staticmethod
    def _ordered_specs(nodes):
        values = {node.stable_id: node for node in nodes}
        result = []
        remaining = set(values)
        compiled = set()
        while remaining:
            ready = sorted(node_id for node_id in remaining if not values[node_id].parent_id or values[node_id].parent_id in compiled)
            if not ready:
                raise RuntimeError("无法确定绑定节点层级的构建顺序")
            for node_id in ready:
                result.append(values[node_id])
                compiled.add(node_id)
                remaining.remove(node_id)
        return tuple(result)

    @staticmethod
    def _write_metadata(cmds, node, graph_id, target):
        values = {
            NODE_MARKER: (True, "bool"),
            NODE_ID: (target.stable_id, "string"),
            GRAPH_ID: (graph_id, "string"),
            MODULE_ID: (target.owner_module, "string"),
            RIG_LAYER: (target.layer, "string"),
            SIGNATURE: (json.dumps(target.signature, separators=(",", ":")), "string"),
        }
        for attribute, (value, data_type) in values.items():
            if not cmds.attributeQuery(attribute, node=node, exists=True):
                if data_type == "bool":
                    cmds.addAttr(node, longName=attribute, attributeType="bool")
                else:
                    cmds.addAttr(node, longName=attribute, dataType="string")
            if data_type == "string":
                cmds.setAttr(f"{node}.{attribute}", value, type="string")
            else:
                cmds.setAttr(f"{node}.{attribute}", value)

    @staticmethod
    def _physical_node_signature(cmds, node, signature):
        """Resolve declarations that must be backed by real Maya objects."""
        values = dict(signature)
        if "controlShape" in values:
            shapes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
            has_curve = any(cmds.nodeType(shape) == "nurbsCurve" for shape in shapes)
            if not has_curve:
                values["controlShape"] = "__missing__"
        source = values.get("sourceJoint", "")
        if source and not cmds.objExists(source):
            values["sourceJoint"] = "__missing__"
        for key in tuple(values):
            if key.startswith("customFloat:"):
                attribute = key.split(":", 1)[1]
                if not cmds.attributeQuery(attribute, node=node, exists=True):
                    values[key] = "__missing__"
            if key.startswith("customEnum:"):
                attribute = key.split(":", 1)[1]
                if not cmds.attributeQuery(attribute, node=node, exists=True):
                    values[key] = "__missing__"
        return tuple(sorted(values.items()))

    @staticmethod
    def _physical_behavior_endpoints(cmds, node, behavior_type, behavior_id):
        if not cmds.objExists(node):
            return (), ()

        def stable_from_plug(plug):
            source_node = plug.split(".", 1)[0]
            return MayaRigGraphService._get(cmds, source_node, NODE_ID, "")

        def input_stable(plug):
            values = cmds.listConnections(plug, source=True, destination=False, plugs=True) or []
            if not values:
                return ""
            stable_id = stable_from_plug(values[0])
            if stable_id:
                return stable_id
            source_node = values[0].split(".", 1)[0]
            if cmds.nodeType(source_node) == "multMatrix":
                for index in (1, 0):
                    traced = input_stable(f"{source_node}.matrixIn[{index}]")
                    if traced:
                        return traced
            return ""

        def output_targets(plug):
            values = cmds.listConnections(plug, source=False, destination=True, plugs=True) or []
            result = []
            for value in values:
                if value.endswith(".offsetParentMatrix"):
                    stable_id = stable_from_plug(value)
                    if stable_id:
                        result.append(stable_id)
            return tuple(sorted(set(result)))

        if behavior_type == "matrix_drive":
            source = input_stable(f"{node}.matrixIn[0]")
            return ((source,) if source else ()), output_targets(f"{node}.matrixSum")
        if behavior_type == "matrix_blend":
            sources = tuple(item for item in (
                input_stable(f"{node}.inputMatrix"),
                input_stable(f"{node}.target[0].targetMatrix"),
                input_stable(f"{node}.target[0].weight"),
            ) if item)
            targets = ()
            for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id):
                if cmds.nodeType(aux) != "multMatrix":
                    continue
                found = output_targets(f"{aux}.matrixSum")
                if found:
                    targets = found
                    break
            return sources, targets
        if behavior_type == "space_switch":
            drivers = []
            indices = cmds.getAttr(f"{node}.input", multiIndices=True) or []
            for index in sorted(indices):
                input_plugs = cmds.listConnections(
                    f"{node}.input[{index}]", source=True, destination=False,
                    plugs=True,
                ) or []
                if not input_plugs:
                    continue
                source_mult = input_plugs[0].split(".", 1)[0]
                stable_id = input_stable(f"{source_mult}.matrixIn[1]")
                if stable_id:
                    drivers.append(stable_id)
            selector = input_stable(f"{node}.selector")
            targets = ()
            for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id):
                if cmds.nodeType(aux) == "multMatrix":
                    found = output_targets(f"{aux}.matrixSum")
                    if found:
                        targets = found
                        break
            return tuple(drivers + ([selector] if selector else [])), targets
        if behavior_type == "rp_ik":
            parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
            ik_control = MayaRigGraphService._get(cmds, parents[0], NODE_ID, "") if parents else ""
            pole_control = ""
            for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id):
                if cmds.nodeType(aux) != "poleVectorConstraint":
                    continue
                targets = cmds.poleVectorConstraint(aux, query=True, targetList=True) or []
                if targets:
                    pole_control = MayaRigGraphService._get(cmds, targets[0], NODE_ID, "")
            joint_values = cmds.ikHandle(node, query=True, jointList=True) or []
            effector = cmds.ikHandle(node, query=True, endEffector=True)
            if effector and cmds.objExists(effector):
                end_connections = cmds.listConnections(
                    f"{effector}.translateX", source=True, destination=False,
                ) or []
                if end_connections:
                    joint_values.append(end_connections[0])
            joint_ids = []
            for joint in joint_values:
                stable_id = MayaRigGraphService._get(cmds, joint, NODE_ID, "")
                if stable_id and stable_id not in joint_ids:
                    joint_ids.append(stable_id)
            return tuple(item for item in (ik_control, pole_control) if item), tuple(joint_ids)
        if behavior_type == "twist_distribution":
            start = input_stable(f"{node}.matrixIn[1]")
            end = input_stable(f"{node}.matrixIn[0]")
            targets = []
            for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id):
                if cmds.nodeType(aux) != "quatToEuler":
                    continue
                outputs = cmds.listConnections(
                    f"{aux}.outputRotate", source=False, destination=True, plugs=True,
                ) or []
                for plug in outputs:
                    stable_id = stable_from_plug(plug)
                    if stable_id and stable_id not in targets:
                        targets.append(stable_id)
            targets.sort(key=lambda stable_id: next(
                (
                    MayaRigGraphService._get(cmds, aux, "mayacraftTwistIndex", 999)
                    for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id)
                    if cmds.nodeType(aux) == "quatSlerp"
                    and MayaRigGraphService._get(cmds, aux, "mayacraftTwistTarget", "") == stable_id
                ),
                999,
            ))
            return tuple(item for item in (start, end) if item), tuple(targets)
        if behavior_type == "bendy_curve":
            source_nodes = []
            target_nodes = []
            for aux in MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id):
                if cmds.nodeType(aux) == "multMatrix" and cmds.attributeQuery(
                    "mayacraftBendySourceIndex", node=aux, exists=True,
                ):
                    stable_id = input_stable(f"{aux}.matrixIn[0]")
                    if stable_id:
                        source_nodes.append((int(cmds.getAttr(f"{aux}.mayacraftBendySourceIndex")), stable_id))
                if cmds.nodeType(aux) == "motionPath" and cmds.attributeQuery(
                    "mayacraftBendyTargetIndex", node=aux, exists=True,
                ):
                    positions = cmds.listConnections(
                        f"{aux}.allCoordinates", source=False, destination=True, plugs=True,
                    ) or []
                    rotations = cmds.listConnections(
                        f"{aux}.rotate", source=False, destination=True, plugs=True,
                    ) or []
                    position_ids = {stable_from_plug(plug) for plug in positions}
                    rotation_ids = {stable_from_plug(plug) for plug in rotations}
                    stable_ids = tuple(item for item in position_ids & rotation_ids if item)
                    if len(stable_ids) != 1:
                        continue
                    target_path = next((
                        plug.split(".", 1)[0] for plug in positions
                        if stable_from_plug(plug) == stable_ids[0]
                    ), "")
                    scaled_axes = sum(
                        any(MayaRigGraphService._get(cmds, item, BEHAVIOR_OWNER_ID, "") == behavior_id
                            for item in (cmds.listConnections(
                                f"{target_path}.scale{axis}", source=True, destination=False,
                            ) or []))
                        for axis in "XYZ"
                    ) if target_path else 0
                    scaled = scaled_axes >= 2
                    if scaled:
                        target_nodes.append((
                            int(cmds.getAttr(f"{aux}.mayacraftBendyTargetIndex")), stable_ids[0],
                        ))
            return (
                tuple(item[1] for item in sorted(source_nodes)),
                tuple(item[1] for item in sorted(target_nodes)),
            )
        return (), ()

    @staticmethod
    def _apply_behavior(cmds, graph_id, behavior, paths):
        endpoints = tuple(paths.get(item) for item in behavior.sources + behavior.targets)
        if not all(endpoints) or not all(cmds.objExists(item) for item in endpoints):
            raise RuntimeError(f"绑定行为 {behavior.stable_id} 的端点不存在")
        if behavior.behavior_type == "matrix_drive":
            MayaRigGraphService._apply_matrix_drive(cmds, graph_id, behavior, paths)
        elif behavior.behavior_type == "matrix_blend":
            MayaRigGraphService._apply_matrix_blend(cmds, graph_id, behavior, paths)
        elif behavior.behavior_type == "rp_ik":
            MayaRigGraphService._apply_rp_ik(cmds, graph_id, behavior, paths)
        elif behavior.behavior_type == "space_switch":
            MayaRigGraphService._apply_space_switch(cmds, graph_id, behavior, paths)
        elif behavior.behavior_type == "twist_distribution":
            MayaRigGraphService._apply_twist_distribution(cmds, graph_id, behavior, paths)
        elif behavior.behavior_type == "bendy_curve":
            MayaRigGraphService._apply_bendy_curve(cmds, graph_id, behavior, paths)
        else:
            raise ValueError(f"尚未实现的绑定行为：{behavior.behavior_type}")

    @staticmethod
    def _apply_matrix_drive(cmds, graph_id, behavior, paths):
        source = paths[behavior.sources[0]]
        target = paths[behavior.targets[0]]
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_") + "_MMX"
        node = cmds.createNode("multMatrix", name=safe_name)
        MayaRigGraphService._tag_behavior_marker(cmds, node, graph_id, behavior)
        MayaRigGraphService._reset_driven_transform(cmds, target)
        cmds.connectAttr(f"{source}.worldMatrix[0]", f"{node}.matrixIn[0]", force=True)
        MayaRigGraphService._connect_explicit_parent_inverse(cmds, target, node, 1)
        cmds.connectAttr(f"{node}.matrixSum", f"{target}.offsetParentMatrix", force=True)

    @staticmethod
    def _apply_matrix_blend(cmds, graph_id, behavior, paths):
        fk_joint, ik_joint, control = (paths[item] for item in behavior.sources)
        target = paths[behavior.targets[0]]
        settings = dict(behavior.settings)
        weight_attribute = settings.get("weightAttribute", "ikFk")
        if not cmds.attributeQuery(weight_attribute, node=control, exists=True):
            raise RuntimeError(f"FK/IK 权重属性不存在：{control}.{weight_attribute}")
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_")
        blend = cmds.createNode("blendMatrix", name=safe_name + "_BLM")
        correction = cmds.createNode("composeMatrix", name=safe_name + "_CORRECT_CMP")
        corrected_ik = cmds.createNode("multMatrix", name=safe_name + "_CORRECT_MMX")
        local = cmds.createNode("multMatrix", name=safe_name + "_LOCAL_MMX")
        MayaRigGraphService._tag_behavior_marker(cmds, blend, graph_id, behavior)
        MayaRigGraphService._tag_behavior_aux(cmds, correction, behavior.stable_id)
        MayaRigGraphService._tag_behavior_aux(cmds, corrected_ik, behavior.stable_id)
        MayaRigGraphService._tag_behavior_aux(cmds, local, behavior.stable_id)
        MayaRigGraphService._reset_driven_transform(cmds, target)
        try:
            joint_index = int(behavior.stable_id.rsplit(".", 1)[-1])
        except ValueError:
            joint_index = 0
        for axis in "XYZ":
            attribute = f"matchCorr{joint_index}{axis}"
            if not cmds.attributeQuery(attribute, node=control, exists=True):
                cmds.addAttr(control, longName=attribute, attributeType="doubleAngle", keyable=True, hidden=True)
            cmds.connectAttr(f"{control}.{attribute}", f"{correction}.inputRotate{axis}", force=True)
        cmds.connectAttr(f"{fk_joint}.worldMatrix[0]", f"{blend}.inputMatrix", force=True)
        cmds.connectAttr(f"{correction}.outputMatrix", f"{corrected_ik}.matrixIn[0]", force=True)
        cmds.connectAttr(f"{ik_joint}.worldMatrix[0]", f"{corrected_ik}.matrixIn[1]", force=True)
        cmds.connectAttr(f"{corrected_ik}.matrixSum", f"{blend}.target[0].targetMatrix", force=True)
        cmds.connectAttr(f"{control}.{weight_attribute}", f"{blend}.target[0].weight", force=True)
        cmds.connectAttr(f"{blend}.outputMatrix", f"{local}.matrixIn[0]", force=True)
        MayaRigGraphService._connect_explicit_parent_inverse(cmds, target, local, 1)
        cmds.connectAttr(f"{local}.matrixSum", f"{target}.offsetParentMatrix", force=True)

    @staticmethod
    def _apply_rp_ik(cmds, graph_id, behavior, paths):
        ik_control, pole_control = (paths[item] for item in behavior.sources)
        start_joint, _middle_joint, end_joint = (paths[item] for item in behavior.targets)
        solver = dict(behavior.settings).get("solver", "ikRPsolver")
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_")
        handle, effector = cmds.ikHandle(
            name=safe_name + "_IKH", startJoint=start_joint,
            endEffector=end_joint, solver=solver,
        )
        handle = cmds.parent(handle, ik_control, absolute=True)[0]
        constraint = cmds.poleVectorConstraint(
            pole_control, handle, name=safe_name + "_PVC",
        )[0]
        if cmds.attributeQuery("twist", node=ik_control, exists=True):
            cmds.connectAttr(f"{ik_control}.twist", f"{handle}.twist", force=True)
        cmds.setAttr(f"{handle}.visibility", False)
        MayaRigGraphService._tag_behavior_marker(cmds, handle, graph_id, behavior)
        MayaRigGraphService._tag_behavior_aux(cmds, effector, behavior.stable_id)
        MayaRigGraphService._tag_behavior_aux(cmds, constraint, behavior.stable_id)

    @staticmethod
    def _apply_space_switch(cmds, graph_id, behavior, paths):
        import maya.api.OpenMaya as om

        drivers = tuple(paths[item] for item in behavior.sources[:-1])
        selector_control = paths[behavior.sources[-1]]
        target = paths[behavior.targets[0]]
        selector_attribute = dict(behavior.settings).get("selectorAttribute", "space")
        if not cmds.attributeQuery(selector_attribute, node=selector_control, exists=True):
            raise RuntimeError(f"空间选择属性不存在：{selector_control}.{selector_attribute}")
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_")
        choice = cmds.createNode("choice", name=safe_name + "_CHOICE")
        local = cmds.createNode("multMatrix", name=safe_name + "_LOCAL_MMX")
        MayaRigGraphService._tag_behavior_marker(cmds, choice, graph_id, behavior)
        MayaRigGraphService._tag_behavior_aux(cmds, local, behavior.stable_id)
        target_world = om.MMatrix(cmds.xform(target, query=True, worldSpace=True, matrix=True))
        for index, driver in enumerate(drivers):
            source_world = om.MMatrix(cmds.xform(driver, query=True, worldSpace=True, matrix=True))
            offset = target_world * source_world.inverse()
            space_mult = cmds.createNode("multMatrix", name=f"{safe_name}_SPACE{index}_MMX")
            MayaRigGraphService._tag_behavior_aux(cmds, space_mult, behavior.stable_id)
            cmds.setAttr(f"{space_mult}.matrixIn[0]", *tuple(offset), type="matrix")
            cmds.connectAttr(f"{driver}.worldMatrix[0]", f"{space_mult}.matrixIn[1]", force=True)
            cmds.connectAttr(f"{space_mult}.matrixSum", f"{choice}.input[{index}]", force=True)
        cmds.connectAttr(f"{selector_control}.{selector_attribute}", f"{choice}.selector", force=True)
        MayaRigGraphService._reset_driven_transform(cmds, target)
        cmds.connectAttr(f"{choice}.output", f"{local}.matrixIn[0]", force=True)
        MayaRigGraphService._connect_explicit_parent_inverse(cmds, target, local, 1)
        cmds.connectAttr(f"{local}.matrixSum", f"{target}.offsetParentMatrix", force=True)

    @staticmethod
    def _connect_explicit_parent_inverse(cmds, target, mult_matrix, index):
        """Avoid the driven node's parentInverseMatrix feedback in OPM graphs."""
        parents = cmds.listRelatives(target, parent=True, fullPath=True) or []
        if parents:
            cmds.connectAttr(
                f"{parents[0]}.worldInverseMatrix[0]",
                f"{mult_matrix}.matrixIn[{index}]",
                force=True,
            )
        else:
            identity = (
                1.0, 0.0, 0.0, 0.0,
                0.0, 1.0, 0.0, 0.0,
                0.0, 0.0, 1.0, 0.0,
                0.0, 0.0, 0.0, 1.0,
            )
            cmds.setAttr(f"{mult_matrix}.matrixIn[{index}]", *identity, type="matrix")

    @staticmethod
    def _apply_twist_distribution(cmds, graph_id, behavior, paths):
        try:
            if not cmds.pluginInfo("quatNodes", query=True, loaded=True):
                cmds.loadPlugin("quatNodes", quiet=True)
        except Exception as exc:
            raise RuntimeError("Maya 2025 内置 quatNodes 无法加载，Twist 网络未创建") from exc
        start = paths[behavior.sources[0]]
        end = paths[behavior.sources[1]]
        targets = tuple(paths[item] for item in behavior.targets)
        settings = dict(behavior.settings)
        axis = tuple(float(value) for value in settings.get("aimAxis", "1,0,0").split(","))
        weights = tuple(float(value) for value in settings.get("weights", "").split("|") if value)
        if len(axis) != 3 or sum(value * value for value in axis) <= 1e-10:
            raise ValueError(f"{behavior.stable_id} 的 Twist 局部轴无效")
        if len(weights) != len(targets):
            raise ValueError(f"{behavior.stable_id} 的 Twist 权重数量与关节数量不一致")
        axis_length = math.sqrt(sum(value * value for value in axis))
        axis = tuple(value / axis_length for value in axis)
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_")
        relative = cmds.createNode("multMatrix", name=safe_name + "_REL_MMX")
        decompose = cmds.createNode("decomposeMatrix", name=safe_name + "_REL_DCM")
        dot = cmds.createNode("vectorProduct", name=safe_name + "_TWIST_DOT")
        project = cmds.createNode("multiplyDivide", name=safe_name + "_TWIST_PROJECT")
        normalize = cmds.createNode("quatNormalize", name=safe_name + "_TWIST_NORM")
        MayaRigGraphService._tag_behavior_marker(cmds, relative, graph_id, behavior)
        for node in (decompose, dot, project, normalize):
            MayaRigGraphService._tag_behavior_aux(cmds, node, behavior.stable_id)
        cmds.connectAttr(f"{end}.worldMatrix[0]", f"{relative}.matrixIn[0]", force=True)
        cmds.connectAttr(f"{start}.worldInverseMatrix[0]", f"{relative}.matrixIn[1]", force=True)
        cmds.connectAttr(f"{relative}.matrixSum", f"{decompose}.inputMatrix", force=True)
        cmds.setAttr(f"{dot}.operation", 1)
        for source_axis, axis_value in zip("XYZ", axis):
            cmds.connectAttr(
                f"{decompose}.outputQuat{source_axis}", f"{dot}.input1{source_axis}", force=True,
            )
            cmds.setAttr(f"{dot}.input2{source_axis}", axis_value)
            cmds.setAttr(f"{project}.input1{source_axis}", axis_value)
            cmds.connectAttr(f"{dot}.outputX", f"{project}.input2{source_axis}", force=True)
            cmds.connectAttr(
                f"{project}.output{source_axis}", f"{normalize}.inputQuat{source_axis}", force=True,
            )
        cmds.connectAttr(f"{decompose}.outputQuatW", f"{normalize}.inputQuatW", force=True)
        for index, (stable_id, target, weight) in enumerate(zip(behavior.targets, targets, weights)):
            slerp = cmds.createNode("quatSlerp", name=f"{safe_name}_{index + 1:02d}_SLERP")
            to_euler = cmds.createNode("quatToEuler", name=f"{safe_name}_{index + 1:02d}_QTE")
            MayaRigGraphService._tag_behavior_aux(cmds, slerp, behavior.stable_id)
            MayaRigGraphService._tag_behavior_aux(cmds, to_euler, behavior.stable_id)
            cmds.addAttr(slerp, longName="mayacraftTwistIndex", attributeType="long", defaultValue=index)
            cmds.addAttr(slerp, longName="mayacraftTwistTarget", dataType="string")
            cmds.setAttr(f"{slerp}.mayacraftTwistTarget", stable_id, type="string")
            cmds.setAttr(f"{slerp}.input1QuatW", 1.0)
            cmds.setAttr(f"{slerp}.inputT", weight)
            cmds.connectAttr(f"{normalize}.outputQuat", f"{slerp}.input2Quat", force=True)
            cmds.connectAttr(f"{slerp}.outputQuat", f"{to_euler}.inputQuat", force=True)
            for rotate_axis in "XYZ":
                plug = f"{target}.rotate{rotate_axis}"
                if cmds.getAttr(plug, lock=True) or not cmds.getAttr(plug, settable=True):
                    raise RuntimeError(f"Twist 关节旋转通道不可写：{plug}")
            cmds.connectAttr(f"{to_euler}.outputRotate", f"{target}.rotate", force=True)

    @staticmethod
    def _apply_bendy_curve(cmds, graph_id, behavior, paths):
        sources = tuple(paths[item] for item in behavior.sources)
        targets = tuple(paths[item] for item in behavior.targets)
        settings = dict(behavior.settings)
        fractions = tuple(float(value) for value in settings.get("fractions", "").split("|") if value)
        if len(fractions) != len(targets) or any(not 0.0 < value < 1.0 for value in fractions):
            raise ValueError(f"{behavior.stable_id} 的 Bendy 弧长分布无效")
        volume_attribute = settings.get("volumeAttribute", "volume")
        volume_control = sources[1]
        if not cmds.attributeQuery(volume_attribute, node=volume_control, exists=True):
            raise RuntimeError(f"Bendy 体积属性不存在：{volume_control}.{volume_attribute}")
        axis = tuple(float(value) for value in settings.get("aimAxis", "1,0,0").split(","))
        if len(axis) != 3 or sum(value * value for value in axis) <= 1e-10:
            raise ValueError(f"{behavior.stable_id} 的 Bendy 主轴无效")
        front_axis = max(range(3), key=lambda index: abs(axis[index]))
        inverse_front = axis[front_axis] < 0.0
        up_axis = 1 if front_axis != 1 else 2
        cross_axes = tuple(index for index in range(3) if index != front_axis)
        safe_name = behavior.stable_id.replace(".", "_").replace(":", "_")
        world_positions = tuple(tuple(cmds.xform(
            source, query=True, worldSpace=True, translation=True,
        )) for source in sources)
        curve = cmds.curve(
            name=safe_name + "_CRV", degree=3, point=world_positions,
        )
        if paths.get("rig.deform"):
            curve = cmds.parent(curve, paths["rig.deform"], absolute=True)[0]
        curve = (cmds.ls(curve, long=True) or [curve])[0]
        shape = (cmds.listRelatives(curve, shapes=True, fullPath=True) or [""])[0]
        if not shape:
            raise RuntimeError(f"{behavior.stable_id} 未能创建 Bendy 曲线形状")
        MayaRigGraphService._tag_behavior_marker(cmds, curve, graph_id, behavior)
        MayaRigGraphService._tag_behavior_aux(cmds, shape, behavior.stable_id)
        cmds.setAttr(f"{shape}.overrideEnabled", True)
        cmds.setAttr(f"{shape}.overrideColor", 21)
        decomposes = []
        for index, source in enumerate(sources):
            local = cmds.createNode("multMatrix", name=f"{safe_name}_CV{index}_MMX")
            decompose = cmds.createNode("decomposeMatrix", name=f"{safe_name}_CV{index}_DCM")
            for aux in (local, decompose):
                MayaRigGraphService._tag_behavior_aux(cmds, aux, behavior.stable_id)
            cmds.addAttr(local, longName="mayacraftBendySourceIndex", attributeType="long", defaultValue=index)
            cmds.connectAttr(f"{source}.worldMatrix[0]", f"{local}.matrixIn[0]", force=True)
            cmds.connectAttr(f"{curve}.worldInverseMatrix[0]", f"{local}.matrixIn[1]", force=True)
            cmds.connectAttr(f"{local}.matrixSum", f"{decompose}.inputMatrix", force=True)
            cmds.connectAttr(f"{decompose}.outputTranslate", f"{shape}.controlPoints[{index}]", force=True)
            decomposes.append(decompose)
        curve_info = cmds.createNode("curveInfo", name=safe_name + "_ARC_CIF")
        chord = cmds.createNode("distanceBetween", name=safe_name + "_CHORD_DST")
        ratio = cmds.createNode("multiplyDivide", name=safe_name + "_STRETCH_DIV")
        exponent = cmds.createNode("multiplyDivide", name=safe_name + "_VOLUME_EXP")
        power = cmds.createNode("multiplyDivide", name=safe_name + "_VOLUME_POW")
        for aux in (curve_info, chord, ratio, exponent, power):
            MayaRigGraphService._tag_behavior_aux(cmds, aux, behavior.stable_id)
        cmds.connectAttr(f"{shape}.worldSpace[0]", f"{curve_info}.inputCurve", force=True)
        cmds.connectAttr(f"{decomposes[0]}.outputTranslate", f"{chord}.point1", force=True)
        cmds.connectAttr(f"{decomposes[3]}.outputTranslate", f"{chord}.point2", force=True)
        cmds.setAttr(f"{ratio}.operation", 2)
        cmds.connectAttr(f"{curve_info}.arcLength", f"{ratio}.input1X", force=True)
        cmds.connectAttr(f"{chord}.distance", f"{ratio}.input2X", force=True)
        cmds.setAttr(f"{exponent}.operation", 1)
        cmds.connectAttr(f"{volume_control}.{volume_attribute}", f"{exponent}.input1X", force=True)
        cmds.setAttr(f"{exponent}.input2X", -0.5)
        cmds.setAttr(f"{power}.operation", 3)
        cmds.connectAttr(f"{ratio}.outputX", f"{power}.input1X", force=True)
        cmds.connectAttr(f"{exponent}.outputX", f"{power}.input2X", force=True)
        axis_names = "XYZ"
        for index, (target, fraction) in enumerate(zip(targets, fractions)):
            motion = cmds.createNode("motionPath", name=f"{safe_name}_{index + 1:02d}_MOP")
            MayaRigGraphService._tag_behavior_aux(cmds, motion, behavior.stable_id)
            cmds.addAttr(motion, longName="mayacraftBendyTargetIndex", attributeType="long", defaultValue=index)
            cmds.addAttr(motion, longName="mayacraftBendyTarget", dataType="string")
            cmds.setAttr(f"{motion}.mayacraftBendyTarget", behavior.targets[index], type="string")
            cmds.setAttr(f"{motion}.fractionMode", True)
            cmds.setAttr(f"{motion}.follow", True)
            cmds.setAttr(f"{motion}.frontAxis", front_axis)
            cmds.setAttr(f"{motion}.upAxis", up_axis)
            cmds.setAttr(f"{motion}.inverseFront", inverse_front)
            cmds.setAttr(f"{motion}.worldUpType", 3)
            cmds.setAttr(f"{motion}.worldUpVector", 0.0, 1.0, 0.0, type="double3")
            cmds.setAttr(f"{motion}.uValue", fraction)
            MayaRigGraphService._reset_driven_transform(cmds, target)
            cmds.connectAttr(f"{shape}.worldSpace[0]", f"{motion}.geometryPath", force=True)
            cmds.connectAttr(f"{motion}.allCoordinates", f"{target}.translate", force=True)
            cmds.connectAttr(f"{motion}.rotate", f"{target}.rotate", force=True)
            for cross_axis in cross_axes:
                cmds.connectAttr(
                    f"{power}.outputX", f"{target}.scale{axis_names[cross_axis]}", force=True,
                )

    @staticmethod
    def _tag_behavior_marker(cmds, node, graph_id, behavior):
        metadata = {
            BEHAVIOR_MARKER: (True, "bool"),
            BEHAVIOR_ID: (behavior.stable_id, "string"),
            BEHAVIOR_TYPE: (behavior.behavior_type, "string"),
            GRAPH_ID: (graph_id, "string"),
            MODULE_ID: (behavior.owner_module, "string"),
            BEHAVIOR_SIGNATURE: (json.dumps(behavior.signature, separators=(",", ":")), "string"),
        }
        for attribute, (value, data_type) in metadata.items():
            if data_type == "bool":
                cmds.addAttr(node, longName=attribute, attributeType="bool")
                cmds.setAttr(f"{node}.{attribute}", value)
            else:
                cmds.addAttr(node, longName=attribute, dataType="string")
                cmds.setAttr(f"{node}.{attribute}", value, type="string")

    @staticmethod
    def _tag_behavior_aux(cmds, node, behavior_id):
        if not cmds.attributeQuery(BEHAVIOR_OWNER_ID, node=node, exists=True):
            cmds.addAttr(node, longName=BEHAVIOR_OWNER_ID, dataType="string")
        cmds.setAttr(f"{node}.{BEHAVIOR_OWNER_ID}", behavior_id, type="string")

    @staticmethod
    def _behavior_aux_nodes(cmds, behavior_id):
        candidates = cmds.ls(f"*.{BEHAVIOR_OWNER_ID}", objectsOnly=True, long=True, recursive=True) or []
        return tuple(item for item in candidates if MayaRigGraphService._get(cmds, item, BEHAVIOR_OWNER_ID, "") == behavior_id)

    @staticmethod
    def _delete_behavior(cmds, marker, behavior_id):
        nodes = list(MayaRigGraphService._behavior_aux_nodes(cmds, behavior_id))
        if marker and cmds.objExists(marker):
            nodes.append(marker)
        existing = [item for item in dict.fromkeys(nodes) if cmds.objExists(item)]
        if existing:
            cmds.delete(existing)

    @staticmethod
    def _reset_driven_transform(cmds, target):
        for channel in ("translate", "rotate"):
            for axis in "XYZ":
                plug = f"{target}.{channel}{axis}"
                if cmds.getAttr(plug, lock=True):
                    raise RuntimeError(f"矩阵驱动目标通道被锁定：{plug}")
                cmds.setAttr(plug, 0.0)
        for axis in "XYZ":
            plug = f"{target}.scale{axis}"
            if cmds.getAttr(plug, lock=True):
                raise RuntimeError(f"矩阵驱动目标通道被锁定：{plug}")
            cmds.setAttr(plug, 1.0)

    @staticmethod
    def _apply_declared_transform(cmds, node, target):
        declared = dict(target.attributes)
        if declared.get("controlShape") and cmds.objectType(node, isAType="transform"):
            shapes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
            if not any(cmds.nodeType(shape) == "nurbsCurve" for shape in shapes):
                if declared.get("controlShape") == "diamond":
                    temp = cmds.curve(
                        name=target.maya_name + "_shapeBuild", degree=1,
                        point=((0, 0, 1.2), (1.2, 0, 0), (0, 0, -1.2), (-1.2, 0, 0), (0, 0, 1.2)),
                    )
                else:
                    temp = cmds.circle(
                        name=target.maya_name + "_shapeBuild",
                        normal=(1.0, 0.0, 0.0), radius=1.25, sections=12,
                        constructionHistory=False,
                    )[0]
                temp_shapes = cmds.listRelatives(temp, shapes=True, fullPath=True) or []
                for shape in temp_shapes:
                    adopted = cmds.parent(shape, node, shape=True, relative=True)[0]
                    cmds.rename(adopted, target.maya_name + "Shape")
                cmds.delete(temp)
        for key, specification in declared.items():
            if not key.startswith("customFloat:"):
                continue
            attribute = key.split(":", 1)[1]
            parts = tuple(float(item) for item in specification.split("|"))
            if len(parts) != 3:
                raise ValueError(f"{target.stable_id} 的浮点属性声明无效：{key}")
            default, minimum, maximum = parts
            if minimum > maximum or not minimum <= default <= maximum:
                raise ValueError(f"{target.stable_id} 的浮点属性范围无效：{key}")
            if not cmds.attributeQuery(attribute, node=node, exists=True):
                cmds.addAttr(
                    node, longName=attribute, attributeType="double",
                    defaultValue=default, minValue=minimum, maxValue=maximum,
                    keyable=True,
                )
        for key, specification in declared.items():
            if not key.startswith("customEnum:"):
                continue
            attribute = key.split(":", 1)[1]
            labels, separator, default_text = specification.partition("|")
            if not separator or not labels:
                raise ValueError(f"{target.stable_id} 的枚举属性声明无效：{key}")
            default = int(default_text)
            label_values = labels.split(":")
            if default < 0 or default >= len(label_values):
                raise ValueError(f"{target.stable_id} 的枚举默认值无效：{key}")
            if not cmds.attributeQuery(attribute, node=node, exists=True):
                cmds.addAttr(
                    node, longName=attribute, attributeType="enum",
                    enumName=labels, defaultValue=default, keyable=True,
                )
        source = declared.get("sourceJoint", "")
        if source:
            attribute = "mayacraftSourceJoint"
            if not cmds.attributeQuery(attribute, node=node, exists=True):
                cmds.addAttr(node, longName=attribute, dataType="string")
            cmds.setAttr(f"{node}.{attribute}", source, type="string")
        position = declared.get("worldPosition")
        if position and cmds.objectType(node, isAType="transform"):
            values = tuple(float(item) for item in position.split(","))
            if len(values) != 3:
                raise ValueError(f"{target.stable_id} 的 worldPosition 声明无效")
            cmds.xform(node, worldSpace=True, translation=values)
        quaternion = declared.get("worldQuaternion")
        if quaternion and cmds.objectType(node, isAType="transform"):
            values = tuple(float(item) for item in quaternion.split(","))
            if len(values) != 4:
                raise ValueError(f"{target.stable_id} 的 worldQuaternion 声明无效")
            import maya.api.OpenMaya as om
            euler = om.MQuaternion(*values).asEulerRotation()
            rotation = tuple(math.degrees(value) for value in (euler.x, euler.y, euler.z))
            cmds.xform(node, worldSpace=True, rotation=rotation)

    @staticmethod
    def _get(cmds, node, attribute, default):
        if not node or not cmds.objExists(node) or not cmds.attributeQuery(attribute, node=node, exists=True):
            return default
        try:
            return cmds.getAttr(f"{node}.{attribute}")
        except Exception:
            return default
