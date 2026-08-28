"""Maya 2025 transactions for the Twist Sculpt Hero workflow."""

from __future__ import annotations

from dataclasses import replace

from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
from MayaCraft.domain.twist_sculpt import (
    TwistProfilePlan, TwistProfileReceipt, TwistSculptIssue,
    decompose_swing_twist, plan_twist_profile, twist_profile_fingerprint,
)


def _cmds():
    import maya.cmds as cmds
    return cmds


class MayaTwistSculptService:
    def __init__(self, rig_graph_service=None):
        self.rig_graph_service = rig_graph_service or MayaRigGraphService()

    @staticmethod
    def _behavior_id(module_id, segment_index):
        return f"{module_id}.twist.{int(segment_index)}"

    @staticmethod
    def _behavior(graph, behavior_id):
        return next((item for item in graph.behaviors if item.stable_id == behavior_id), None)

    def _slerp_nodes(self, cmds, behavior_id):
        nodes = [
            item for item in self.rig_graph_service._behavior_aux_nodes(cmds, behavior_id)
            if cmds.nodeType(item) == "quatSlerp"
        ]
        return tuple(sorted(nodes, key=lambda item: int(
            self.rig_graph_service._get(cmds, item, "mayacraftTwistIndex", 999)
        )))

    def _weights(self, cmds, behavior_id):
        return tuple(float(cmds.getAttr(f"{node}.inputT")) for node in self._slerp_nodes(cmds, behavior_id))

    def plan_profile(self, graph, module_id, segment_index, bias, ease, intensity):
        cmds = _cmds()
        frame = float(cmds.currentTime(query=True))
        behavior_id = self._behavior_id(module_id, segment_index)
        behavior = self._behavior(graph, behavior_id)
        if behavior is None:
            return TwistProfilePlan(
                graph.graph_id, behavior_id, frame, float(bias), float(ease), float(intensity),
                (), (), "", blockers=(TwistSculptIssue(
                    "module", "请选择包含 Twist 分配的四肢骨段", behavior_id,
                ),),
            )
        build_plan = self.rig_graph_service.plan(graph)
        if not build_plan.is_noop:
            detail = build_plan.blockers[0].message if build_plan.blockers else "绑定图存在未应用差异"
            return TwistProfilePlan(
                graph.graph_id, behavior_id, frame, float(bias), float(ease), float(intensity),
                (), (), "", blockers=(TwistSculptIssue(
                    "rig_not_ready", "请先完成并验证 Rig Graph：" + detail, behavior_id,
                ),),
            )
        nodes = self._slerp_nodes(cmds, behavior_id)
        previous = self._weights(cmds, behavior_id)
        plan = plan_twist_profile(
            graph.graph_id, behavior_id, frame, previous,
            float(bias), float(ease), float(intensity),
        )
        issues = list(plan.blockers)
        for node in nodes:
            plug = f"{node}.inputT"
            if cmds.referenceQuery(node, isNodeReferenced=True):
                issues.append(TwistSculptIssue("referenced", "引用绑定网络不可直接塑形", behavior_id))
            if cmds.getAttr(plug, lock=True) or not cmds.getAttr(plug, settable=True):
                issues.append(TwistSculptIssue(
                    "locked_weight", f"Twist 权重已有输入或被锁定：{node.rsplit('|', 1)[-1]}", behavior_id,
                ))
        return replace(plan, blockers=tuple(issues))

    def probe_twist_angle(self, graph, module_id, segment_index):
        import maya.api.OpenMaya as om

        cmds = _cmds()
        behavior = self._behavior(graph, self._behavior_id(module_id, segment_index))
        if behavior is None:
            return 0.0
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        start = paths.get(behavior.sources[0], "")
        end = paths.get(behavior.sources[1], "")
        if not start or not end:
            return 0.0
        start_matrix = om.MMatrix(cmds.xform(start, query=True, worldSpace=True, matrix=True))
        end_matrix = om.MMatrix(cmds.xform(end, query=True, worldSpace=True, matrix=True))
        relative = end_matrix * start_matrix.inverse()
        quaternion = om.MTransformationMatrix(relative).rotation(asQuaternion=True)
        axis = tuple(float(value) for value in dict(behavior.settings)["aimAxis"].split(","))
        return decompose_swing_twist((quaternion.x, quaternion.y, quaternion.z, quaternion.w), axis)[2]

    def apply_profile(self, graph, plan):
        if not plan.can_apply:
            raise ValueError("当前 Twist 塑形计划不可应用")
        segment_index = int(plan.module_id.rsplit(".", 1)[-1])
        limb_id = plan.module_id.rsplit(".twist.", 1)[0]
        current = self.plan_profile(
            graph, limb_id, segment_index, plan.bias, plan.ease, plan.intensity,
        )
        if current.observed_fingerprint != plan.observed_fingerprint:
            raise RuntimeError("预览后 Twist 权重或当前帧已经变化，请重新预览")
        cmds = _cmds()
        nodes = self._slerp_nodes(cmds, plan.module_id)
        opened = False
        completed = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Twist 能量塑形")
            opened = True
            for node, value in zip(nodes, plan.target_weights):
                cmds.setAttr(f"{node}.inputT", value)
            cmds.undoInfo(closeChunk=True)
            opened = False
            observed = self._weights(cmds, plan.module_id)
            maximum_error = max(
                (abs(expected - actual) for expected, actual in zip(plan.target_weights, observed)),
                default=0.0,
            )
            if len(observed) != len(plan.target_weights) or maximum_error > 1e-8:
                raise RuntimeError(f"Twist 权重读回验证失败：最大误差 {maximum_error:.9f}")
            completed = True
            return TwistProfileReceipt(
                graph.graph_id, plan.module_id, plan.frame, True, maximum_error,
                plan.observed_fingerprint, plan.previous_weights, plan.target_weights,
                f"Twist 能量分布已验证 / 最大权重误差 {maximum_error:.9f}",
            )
        finally:
            if opened:
                cmds.undoInfo(closeChunk=True)
            if not completed:
                cmds.undo()

    def undo_profile(self, graph, receipt):
        if not receipt.verified:
            return False
        cmds = _cmds()
        cmds.undo()
        weights = self._weights(cmds, receipt.module_id)
        return (
            weights == receipt.previous_weights
            and twist_profile_fingerprint(receipt.module_id, receipt.frame, weights)
            == receipt.previous_fingerprint
        )


__all__ = ["MayaTwistSculptService"]
