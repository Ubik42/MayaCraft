"""Maya 2025 transactions for no-pop FK/IK and animated space switching."""

from __future__ import annotations

from dataclasses import replace
import math

from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
from MayaCraft.domain.rig_switching import (
    FKIKMatchPlan,
    FKIKMatchReceipt,
    RigSwitchIssue,
    RigTransformSample,
    SpaceSwitchPlan,
    SpaceSwitchReceipt,
    maximum_matrix_error,
    maximum_position_error,
    plan_fk_ik_match,
    plan_space_switch,
)


def _cmds():
    import maya.cmds as cmds
    return cmds


class MayaRigSwitchService:
    """Thin Maya host layer around immutable switching plans."""

    def __init__(self, rig_graph_service=None):
        self.rig_graph_service = rig_graph_service or MayaRigGraphService()

    @staticmethod
    def _module(graph, module_id):
        return next((item for item in graph.modules if item.module_id == module_id), None)

    @staticmethod
    def _sample(cmds, paths, stable_id):
        path = paths.get(stable_id, "")
        if not path or not cmds.objExists(path):
            raise RuntimeError(f"绑定控制对象不存在：{stable_id}")
        matrix = tuple(float(value) for value in cmds.xform(path, query=True, worldSpace=True, matrix=True))
        return RigTransformSample(stable_id, matrix)

    def _ready_issue(self, graph, module_id):
        module = self._module(graph, module_id)
        if module is None or module.module_type != "ikfk_limb":
            return RigSwitchIssue("module", "请选择一个已构建的 FK/IK 手臂或腿部模块", module_id)
        build_plan = self.rig_graph_service.plan(graph)
        if not build_plan.is_noop:
            detail = build_plan.blockers[0].message if build_plan.blockers else "绑定图存在未应用差异"
            return RigSwitchIssue("rig_not_ready", "请先完成并验证 Rig Graph：" + detail, module_id)
        return None

    @staticmethod
    def _target_issues(cmds, paths, targets, selector_plug):
        issues = []
        for target in targets:
            path = paths.get(target.stable_id, "")
            if not path or not cmds.objExists(path):
                issues.append(RigSwitchIssue("missing_target", f"匹配目标不存在：{target.stable_id}", target.stable_id))
                continue
            if cmds.referenceQuery(path, isNodeReferenced=True):
                issues.append(RigSwitchIssue("referenced", f"引用控制器不可直接写入：{path}", target.stable_id))
            for channel in target.channels:
                for axis in "XYZ":
                    plug = f"{path}.{channel}{axis}"
                    if cmds.getAttr(plug, lock=True) or not cmds.getAttr(plug, settable=True):
                        short_name = path.rsplit("|", 1)[-1]
                        issues.append(RigSwitchIssue(
                            "locked_channel",
                            f"{short_name}.{channel}{axis} 已锁定或已有输入连接",
                            target.stable_id,
                        ))
        selector_node = selector_plug.split(".", 1)[0]
        if cmds.referenceQuery(selector_node, isNodeReferenced=True):
            issues.append(RigSwitchIssue("referenced", f"引用属性不可直接写入：{selector_plug}", selector_plug))
        if cmds.getAttr(selector_plug, lock=True) or not cmds.getAttr(selector_plug, settable=True):
            short_plug = selector_plug.rsplit("|", 1)[-1]
            issues.append(RigSwitchIssue("locked_selector", f"切换属性 {short_plug} 不可写", selector_plug))
        unique = {(item.code, item.message, item.subject_id): item for item in issues}
        return tuple(unique.values())

    def plan_match(self, graph, module_id, direction):
        cmds = _cmds()
        issue = self._ready_issue(graph, module_id)
        if issue:
            return FKIKMatchPlan(graph.graph_id, module_id, direction, float(cmds.currentTime(query=True)), 0.0, 0.0, blockers=(issue,))
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        result_ids = tuple(f"{module_id}.deform.{index}" for index in range(3))
        fk_ids = tuple(f"{module_id}.fk.{index}" for index in range(3))
        ik_id = f"{module_id}.ik.ctrl"
        pole_id = f"{module_id}.pole.ctrl"
        try:
            results = tuple(self._sample(cmds, paths, item) for item in result_ids)
            controls = tuple(self._sample(cmds, paths, item) for item in fk_ids)
            ik_control = self._sample(cmds, paths, ik_id)
            pole_control = self._sample(cmds, paths, pole_id)
            blend = float(cmds.getAttr(f"{paths[ik_id]}.ikFk"))
            twist = float(cmds.getAttr(f"{paths[ik_id]}.twist"))
        except (KeyError, RuntimeError, TypeError, ValueError) as error:
            return FKIKMatchPlan(
                graph.graph_id, module_id, direction, float(cmds.currentTime(query=True)), 0.0, 0.0,
                blockers=(RigSwitchIssue("capture", "无法读取 FK/IK 当前姿态：" + str(error), module_id),),
            )
        plan = plan_fk_ik_match(
            graph.graph_id, module_id, direction, float(cmds.currentTime(query=True)),
            results, controls, ik_control, pole_control, blend, twist,
        )
        selector_plug = f"{paths[ik_id]}.ikFk"
        host_issues = self._target_issues(cmds, paths, plan.targets, selector_plug)
        twist_plug = f"{paths[ik_id]}.twist"
        if direction == "FK_TO_IK" and (
            cmds.getAttr(twist_plug, lock=True) or not cmds.getAttr(twist_plug, settable=True)
        ):
            host_issues += (RigSwitchIssue("locked_twist", f"IK Twist 不可写：{twist_plug}", ik_id),)
        if direction == "FK_TO_IK":
            for index in range(3):
                for axis in "XYZ":
                    plug = f"{paths[ik_id]}.matchCorr{index}{axis}"
                    if not cmds.objExists(plug) or cmds.getAttr(plug, lock=True) or not cmds.getAttr(plug, settable=True):
                        host_issues += (RigSwitchIssue("locked_correction", f"IK 匹配补偿通道不可写：{plug}", ik_id),)
        return replace(plan, blockers=plan.blockers + host_issues)

    @staticmethod
    def _keyable_plugs(paths, targets, selector_plug):
        plugs = [selector_plug]
        for target in targets:
            path = paths[target.stable_id]
            for channel in target.channels:
                plugs.extend(f"{path}.{channel}{axis}" for axis in "XYZ")
        return tuple(dict.fromkeys(plugs))

    @staticmethod
    def _key_count(cmds, plugs):
        return sum(int(cmds.keyframe(plug, query=True, keyframeCount=True) or 0) for plug in plugs)

    @staticmethod
    def _set_target_matrices(cmds, paths, targets):
        for target in targets:
            cmds.xform(paths[target.stable_id], worldSpace=True, matrix=target.world_matrix)

    def _set_match_corrections(self, cmds, paths, plan):
        """Store a keyed rotation correction between RP IK roll and FK intent."""
        import maya.api.OpenMaya as om

        ik_path = paths[f"{plan.module_id}.ik.ctrl"]
        for index, expected in enumerate(plan.result_intent):
            actual = self._sample(cmds, paths, f"{plan.module_id}.ik_joint.{index}")
            desired_rotation = om.MTransformationMatrix(om.MMatrix(expected.world_matrix)).rotation(asQuaternion=True).asMatrix()
            actual_rotation = om.MTransformationMatrix(om.MMatrix(actual.world_matrix)).rotation(asQuaternion=True).asMatrix()
            correction = desired_rotation * actual_rotation.inverse()
            euler = om.MTransformationMatrix(correction).rotation(asQuaternion=False)
            for axis, value in zip("XYZ", (euler.x, euler.y, euler.z)):
                cmds.setAttr(f"{ik_path}.matchCorr{index}{axis}", math.degrees(value))

    @staticmethod
    def _key_targets(cmds, paths, targets, selector_plug, selector_value, frame):
        for target in targets:
            path = paths[target.stable_id]
            for channel in target.channels:
                for axis in "XYZ":
                    cmds.setKeyframe(f"{path}.{channel}{axis}", time=frame)
        cmds.setKeyframe(selector_plug, time=frame, value=selector_value)

    def apply_match(self, graph, plan, key=True):
        if not plan.can_apply:
            raise ValueError("当前 FK/IK 匹配计划不可应用")
        current = self.plan_match(graph, plan.module_id, plan.direction)
        if current.observed_fingerprint != plan.observed_fingerprint:
            raise RuntimeError("预览后控制器、结果骨架或当前帧已经变化，请重新预览")
        cmds = _cmds()
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        ik_id = f"{plan.module_id}.ik.ctrl"
        selector_plug = f"{paths[ik_id]}.ikFk"
        plugs = list(self._keyable_plugs(paths, plan.targets, selector_plug))
        twist_plug = f"{paths[ik_id]}.twist"
        if plan.direction == "FK_TO_IK":
            plugs.append(twist_plug)
            plugs.extend(
                f"{paths[ik_id]}.matchCorr{index}{axis}"
                for index in range(3) for axis in "XYZ"
            )
        plugs = tuple(dict.fromkeys(plugs))
        previous_key_count = self._key_count(cmds, plugs)
        opened = False
        completed = False
        try:
            cmds.undoInfo(openChunk=True, chunkName=f"MayaCraft {plan.direction_label}")
            opened = True
            self._set_target_matrices(cmds, paths, plan.targets)
            if plan.direction == "FK_TO_IK":
                cmds.setAttr(twist_plug, 0.0)
                self._set_match_corrections(cmds, paths, plan)
            cmds.setAttr(selector_plug, plan.blend_after)
            if key:
                self._key_targets(cmds, paths, plan.targets, selector_plug, plan.blend_after, plan.frame)
                if plan.direction == "FK_TO_IK":
                    cmds.setKeyframe(twist_plug, time=plan.frame)
                    for index in range(3):
                        for axis in "XYZ":
                            cmds.setKeyframe(f"{paths[ik_id]}.matchCorr{index}{axis}", time=plan.frame)
            cmds.undoInfo(closeChunk=True)
            opened = False

            observed = tuple(self._sample(cmds, paths, item.stable_id) for item in plan.result_intent)
            position_error = maximum_position_error(plan.result_intent, observed)
            matrix_errors = [
                maximum_matrix_error(expected.world_matrix, actual.world_matrix)
                for expected, actual in zip(plan.result_intent, observed)
            ]
            matrix_error = max(matrix_errors, default=0.0)
            if position_error > 1e-4 or matrix_error > 1e-3:
                expected_positions = [tuple(round(value, 4) for value in item.world_position) for item in plan.result_intent]
                observed_positions = [tuple(round(value, 4) for value in item.world_position) for item in observed]
                ik_positions = [
                    tuple(round(value, 4) for value in self._sample(cmds, paths, f"{plan.module_id}.ik_joint.{index}").world_position)
                    for index in range(3)
                ]
                raise RuntimeError(
                    f"FK/IK 匹配读回误差超限：位置 {position_error:.6f}，矩阵 {matrix_error:.6f}；"
                    f"期望 {expected_positions}，实际 {observed_positions}，IK 链 {ik_positions}，"
                    f"逐关节矩阵误差 {[round(value, 6) for value in matrix_errors]}，"
                    f"首关节期望 {[round(value, 4) for value in plan.result_intent[0].world_matrix[:12]]}，"
                    f"实际 {[round(value, 4) for value in observed[0].world_matrix[:12]]}"
                )
            result_key_count = self._key_count(cmds, plugs)
            completed = True
            return FKIKMatchReceipt(
                graph.graph_id, plan.module_id, plan.direction, plan.frame, True, bool(key),
                position_error, matrix_error, plan.observed_fingerprint,
                f"{plan.direction_label}验证通过 / 最大位置误差 {position_error:.6f}",
                previous_key_count, result_key_count,
            )
        finally:
            if opened:
                cmds.undoInfo(closeChunk=True)
            if not completed:
                cmds.undo()

    def undo_match(self, graph, receipt):
        if not receipt.verified:
            return False
        cmds = _cmds()
        cmds.undo()
        current = self.plan_match(graph, receipt.module_id, receipt.direction)
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        target_ids = (
            (f"{receipt.module_id}.ik.ctrl", f"{receipt.module_id}.pole.ctrl")
            if receipt.direction == "FK_TO_IK"
            else tuple(f"{receipt.module_id}.fk.{index}" for index in range(3))
        )
        dummy_targets = tuple(
            type("Target", (), {"stable_id": item, "channels": (("translate",) if item.endswith("pole.ctrl") else ("translate", "rotate"))})
            for item in target_ids
        )
        selector_plug = f"{paths[f'{receipt.module_id}.ik.ctrl']}.ikFk"
        plugs = self._keyable_plugs(paths, dummy_targets, selector_plug)
        if receipt.direction == "FK_TO_IK":
            ik_path = paths[f"{receipt.module_id}.ik.ctrl"]
            plugs += (f"{ik_path}.twist",) + tuple(
                f"{ik_path}.matchCorr{index}{axis}" for index in range(3) for axis in "XYZ"
            )
        return (
            current.observed_fingerprint == receipt.previous_fingerprint
            and self._key_count(cmds, plugs) == receipt.previous_key_count
        )

    def plan_space(self, graph, module_id, target_space, create_guard_key=True):
        cmds = _cmds()
        issue = self._ready_issue(graph, module_id)
        frame = float(cmds.currentTime(query=True))
        if issue:
            return SpaceSwitchPlan(graph.graph_id, module_id, frame, "", "", 0, int(target_space), (), (), None, blockers=(issue,))
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        control_id = f"{module_id}.ik.ctrl"
        path = paths.get(control_id, "")
        if not path or not cmds.objExists(path):
            return SpaceSwitchPlan(
                graph.graph_id, module_id, frame, control_id, control_id, 0, int(target_space), (), (), None,
                blockers=(RigSwitchIssue("capture", "IK 控制器不存在，无法切换空间", control_id),),
            )
        selector_plug = f"{path}.space"
        enum_names = (cmds.attributeQuery("space", node=path, listEnum=True) or [""])[0]
        labels = tuple(item for item in enum_names.split(":") if item)
        current_space = int(cmds.getAttr(selector_plug))
        control = self._sample(cmds, paths, control_id)
        plan = plan_space_switch(
            graph.graph_id, module_id, frame, control_id, control,
            current_space, int(target_space), labels, create_guard_key,
        )
        target = type("Target", (), {"stable_id": control_id, "channels": ("translate", "rotate")})
        host_issues = self._target_issues(cmds, paths, (target,), selector_plug)
        return replace(plan, blockers=plan.blockers + host_issues)

    @staticmethod
    def _space_plugs(path):
        return (f"{path}.space",) + tuple(
            f"{path}.{channel}{axis}" for channel in ("translate", "rotate") for axis in "XYZ"
        )

    def apply_space(self, graph, plan, key=True):
        if not plan.can_apply:
            raise ValueError("当前空间切换计划不可应用")
        current = self.plan_space(graph, plan.module_id, plan.target_space, plan.guard_frame is not None)
        if current.observed_fingerprint != plan.observed_fingerprint:
            raise RuntimeError("预览后控制器、空间属性或当前帧已经变化，请重新预览")
        cmds = _cmds()
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        path = paths[plan.control_id]
        selector_plug = f"{path}.space"
        plugs = self._space_plugs(path)
        previous_key_count = self._key_count(cmds, plugs)
        opened = False
        completed = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft 无跳变空间切换")
            opened = True
            if key and plan.guard_frame is not None:
                cmds.setKeyframe(selector_plug, time=plan.guard_frame, value=plan.previous_space)
                for plug in plugs[1:]:
                    value = cmds.getAttr(plug, time=plan.guard_frame)
                    cmds.setKeyframe(plug, time=plan.guard_frame, value=value)
            cmds.setAttr(selector_plug, plan.target_space)
            cmds.xform(path, worldSpace=True, matrix=plan.preserved_world_matrix)
            if key:
                cmds.setKeyframe(selector_plug, time=plan.frame, value=plan.target_space)
                for plug in plugs[1:]:
                    cmds.setKeyframe(plug, time=plan.frame)
                tangent_times = (plan.guard_frame, plan.frame) if plan.guard_frame is not None else (plan.frame,)
                for time in tangent_times:
                    cmds.keyTangent(selector_plug, time=(time, time), inTangentType="step", outTangentType="step")
            cmds.undoInfo(closeChunk=True)
            opened = False
            observed = tuple(float(value) for value in cmds.xform(path, query=True, worldSpace=True, matrix=True))
            error = maximum_matrix_error(plan.preserved_world_matrix, observed)
            if int(cmds.getAttr(selector_plug)) != plan.target_space or error > 1e-4:
                raise RuntimeError(f"空间切换读回验证失败：世界矩阵误差 {error:.6f}")
            result_key_count = self._key_count(cmds, plugs)
            completed = True
            return SpaceSwitchReceipt(
                graph.graph_id, plan.module_id, plan.frame, True, bool(key),
                plan.previous_space, plan.target_space, error, plan.observed_fingerprint,
                f"空间已从{plan.previous_label}切换到{plan.target_label} / 世界姿态保持",
                previous_key_count, result_key_count,
            )
        finally:
            if opened:
                cmds.undoInfo(closeChunk=True)
            if not completed:
                cmds.undo()

    def undo_space(self, graph, receipt):
        if not receipt.verified:
            return False
        cmds = _cmds()
        cmds.undo()
        current = self.plan_space(graph, receipt.module_id, receipt.target_space, True)
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        path = paths[f"{receipt.module_id}.ik.ctrl"]
        return (
            current.observed_fingerprint == receipt.previous_fingerprint
            and self._key_count(cmds, self._space_plugs(path)) == receipt.previous_key_count
        )


__all__ = ["MayaRigSwitchService"]
