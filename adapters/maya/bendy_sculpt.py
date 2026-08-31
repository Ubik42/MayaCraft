"""Maya 2025 preview/apply/verify transaction for Bendy silhouette sculpting."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
from MayaCraft.domain.bendy_deformation import (
    BendySculptIssue, BendySculptPlan, BendySculptReceipt,
    bendy_sculpt_fingerprint, map_bendy_intent, sample_bendy_arc,
)


def _cmds():
    import maya.cmds as cmds
    return cmds


class MayaBendySculptService:
    def __init__(self, rig_graph_service=None):
        self.rig_graph_service = rig_graph_service or MayaRigGraphService()

    @staticmethod
    def _behavior_id(module_id, segment_index):
        return f"{module_id}.bendy.{int(segment_index)}"

    @staticmethod
    def _behavior(graph, behavior_id):
        return next((item for item in graph.behaviors if item.stable_id == behavior_id), None)

    @staticmethod
    def _position(cmds, node):
        return tuple(float(value) for value in cmds.xform(
            node, query=True, worldSpace=True, translation=True,
        ))

    def _current_state(self, cmds, behavior, paths):
        start, in_control, out_control, end = (paths[item] for item in behavior.sources)
        volume_attribute = dict(behavior.settings).get("volumeAttribute", "volume")
        return (
            (self._position(cmds, start), self._position(cmds, end)),
            (self._position(cmds, in_control), self._position(cmds, out_control)),
            float(cmds.getAttr(f"{in_control}.{volume_attribute}")),
        )

    def plan_sculpt(self, graph, module_id, segment_index, local_controls, volume):
        cmds = _cmds()
        frame = float(cmds.currentTime(query=True))
        behavior_id = self._behavior_id(module_id, segment_index)
        behavior = self._behavior(graph, behavior_id)
        empty = ((0.0, 0.0, 0.0), (0.0, 0.0, 0.0))
        if behavior is None:
            return BendySculptPlan(
                graph.graph_id, behavior_id, frame, empty, empty, 0.0, float(volume),
                empty, "", blockers=(BendySculptIssue(
                    "module", "请选择包含 Bendy 形变网络的四肢骨段", behavior_id,
                ),),
            )
        build_plan = self.rig_graph_service.plan(graph)
        if not build_plan.is_noop:
            detail = build_plan.blockers[0].message if build_plan.blockers else "绑定图存在未应用差异"
            return BendySculptPlan(
                graph.graph_id, behavior_id, frame, empty, empty, 0.0, float(volume),
                empty, "", blockers=(BendySculptIssue(
                    "rig_not_ready", "请先完成并验证 Rig Graph：" + detail, behavior_id,
                ),),
            )
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        source_positions, previous_controls, previous_volume = self._current_state(
            cmds, behavior, paths,
        )
        pole = paths.get(f"{module_id}.pole.ctrl", "")
        midpoint = tuple((left + right) * 0.5 for left, right in zip(*source_positions))
        up_hint = tuple(
            value - midpoint[index]
            for index, value in enumerate(self._position(cmds, pole))
        ) if pole else (0.0, 1.0, 0.0)
        blockers = []
        try:
            local_values = tuple(tuple(float(value) for value in item) for item in local_controls)
            target_controls = map_bendy_intent(
                source_positions[0], source_positions[1], local_values, up_hint,
            )
            target_arc = sample_bendy_arc(
                (source_positions[0], *target_controls, source_positions[1]),
                sample_count=5, up_hint=up_hint, volume_preservation=float(volume),
            )
        except (TypeError, ValueError) as exc:
            blockers.append(BendySculptIssue("intent", str(exc), behavior_id))
            target_controls, target_arc = empty, None
        if not math.isfinite(float(volume)) or not 0.0 <= float(volume) <= 1.0:
            blockers.append(BendySculptIssue("volume", "体积保持必须在 0–1 之间", behavior_id))
        volume_attribute = dict(behavior.settings).get("volumeAttribute", "volume")
        for stable_id in behavior.sources[1:3]:
            node = paths[stable_id]
            if cmds.referenceQuery(node, isNodeReferenced=True):
                blockers.append(BendySculptIssue("referenced", f"引用控制器不可直接塑形：{node.rsplit('|', 1)[-1]}", stable_id))
            for axis in "XYZ":
                plug = f"{node}.translate{axis}"
                if cmds.getAttr(plug, lock=True) or not cmds.getAttr(plug, settable=True):
                    blockers.append(BendySculptIssue("locked_control", f"切线控制通道不可写：{plug}", stable_id))
        volume_plug = f"{paths[behavior.sources[1]]}.{volume_attribute}"
        if cmds.getAttr(volume_plug, lock=True) or not cmds.getAttr(volume_plug, settable=True):
            blockers.append(BendySculptIssue("locked_volume", f"体积属性不可写：{volume_plug}", behavior.sources[1]))
        fingerprint = bendy_sculpt_fingerprint(
            behavior_id, frame, source_positions, previous_controls, previous_volume,
        )
        return BendySculptPlan(
            graph.graph_id, behavior_id, frame, previous_controls, target_controls,
            previous_volume, float(volume), source_positions, fingerprint,
            target_arc=target_arc, blockers=tuple(blockers),
        )

    def apply_sculpt(self, graph, plan):
        if not plan.can_apply:
            raise ValueError("当前 Bendy 形变计划不可应用")
        # Replanning needs the original normalized intent, so compare the current
        # observed fingerprint directly before any scene write.
        cmds = _cmds()
        behavior = self._behavior(graph, plan.behavior_id)
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        source_positions, controls, volume = self._current_state(cmds, behavior, paths)
        current_fingerprint = bendy_sculpt_fingerprint(
            plan.behavior_id, float(cmds.currentTime(query=True)),
            source_positions, controls, volume,
        )
        if current_fingerprint != plan.observed_fingerprint:
            raise RuntimeError("预览后 Bendy 骨段、控制器、体积或当前帧已经变化，请重新预览")
        opened = False
        completed = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Bendy 形变塑形")
            opened = True
            for stable_id, target in zip(behavior.sources[1:3], plan.target_controls):
                cmds.xform(paths[stable_id], worldSpace=True, translation=target)
            volume_attribute = dict(behavior.settings).get("volumeAttribute", "volume")
            cmds.setAttr(f"{paths[behavior.sources[1]]}.{volume_attribute}", plan.target_volume)
            cmds.undoInfo(closeChunk=True)
            opened = False
            observed_controls = tuple(self._position(cmds, paths[item]) for item in behavior.sources[1:3])
            control_error = max(
                (math.dist(expected, actual) for expected, actual in zip(plan.target_controls, observed_controls)),
                default=0.0,
            )
            expected_joints = tuple(sample.position for sample in plan.target_arc.samples[1:4])
            observed_joints = tuple(self._position(cmds, paths[item]) for item in behavior.targets)
            joint_error = max(
                (math.dist(expected, actual) for expected, actual in zip(expected_joints, observed_joints)),
                default=0.0,
            )
            observed_volume = float(cmds.getAttr(f"{paths[behavior.sources[1]]}.{volume_attribute}"))
            if control_error > 1e-6 or joint_error > 2e-3 or abs(observed_volume - plan.target_volume) > 1e-8:
                raise RuntimeError(
                    f"Bendy 读回验证失败：控制误差 {control_error:.8f}，关节误差 {joint_error:.8f}",
                )
            completed = True
            return BendySculptReceipt(
                graph.graph_id, plan.behavior_id, plan.frame, True,
                control_error, joint_error, plan.observed_fingerprint,
                plan.previous_controls, plan.target_controls,
                plan.previous_volume, plan.target_volume,
                f"Bendy 形变已验证 / 关节最大误差 {joint_error:.6f}",
            )
        finally:
            if opened:
                cmds.undoInfo(closeChunk=True)
            if not completed:
                cmds.undo()

    def undo_sculpt(self, graph, receipt):
        if not receipt.verified or receipt.graph_id != graph.graph_id:
            return False
        cmds = _cmds()
        cmds.undo()
        behavior = self._behavior(graph, receipt.behavior_id)
        paths = self.rig_graph_service._paths_by_id(cmds, graph.graph_id)
        sources, controls, volume = self._current_state(cmds, behavior, paths)
        fingerprint = bendy_sculpt_fingerprint(
            receipt.behavior_id, receipt.frame, sources, controls, volume,
        )
        return (
            fingerprint == receipt.previous_fingerprint
            and controls == receipt.previous_controls
            and abs(volume - receipt.previous_volume) <= 1e-9
        )


__all__ = ["MayaBendySculptService"]
