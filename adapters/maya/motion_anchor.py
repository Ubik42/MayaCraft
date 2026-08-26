"""Non-destructive Contact Anchor transaction on a Maya animation layer."""

from __future__ import annotations

from dataclasses import replace
from math import sqrt

from MayaCraft.adapters.maya.motion_capture import MayaMotionCapture, _maya_modules
from MayaCraft.domain.motion import ContactAnchorReceipt, plan_contact_anchor


class MayaContactAnchorService:
    VERIFY_TOLERANCE = 0.01

    def __init__(self, capture=None):
        self._capture = capture or MayaMotionCapture()

    def plan(self, baseline, candidate, contact_index, blend_samples=2):
        plan = plan_contact_anchor(
            baseline,
            candidate,
            contact_index,
            blend_samples=blend_samples,
        )
        if plan.blockers:
            return plan
        cmds, _om = _maya_modules()
        blockers = []
        if not cmds.objExists(plan.node_path):
            blockers.append("运动源已不存在")
        elif cmds.referenceQuery(plan.node_path, isNodeReferenced=True):
            blockers.append("引用控制器无法接收本地锚点动画层")
        for attribute in ("translateX", "translateY", "translateZ"):
            plug = f"{plan.node_path}.{attribute}"
            if cmds.getAttr(plug, lock=True):
                blockers.append(f"{attribute} 已锁定")
        if cmds.objExists(plan.layer_name):
            blockers.append(f"动画层已经存在：{plan.layer_name}")
        return replace(plan, blockers=tuple(blockers)) if blockers else plan

    def apply(self, plan):
        if not plan.can_apply:
            raise ValueError("当前接触锚点计划不可应用")
        cmds, om = _maya_modules()
        self._verify_expected_positions(plan)
        opened = False
        layer = ""
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Contact Anchor")
            opened = True
            layer = cmds.animLayer(plan.layer_name, override=False)
            for attribute in ("translateX", "translateY", "translateZ"):
                cmds.animLayer(layer, edit=True, attribute=f"{plan.node_path}.{attribute}")
            for correction in plan.corrections:
                local_delta = self._world_to_parent_delta(
                    plan.node_path,
                    correction.frame,
                    correction.world_delta,
                    cmds,
                    om,
                )
                for attribute, value in zip(("translateX", "translateY", "translateZ"), local_delta):
                    cmds.setKeyframe(
                        plan.node_path,
                        attribute=attribute,
                        time=correction.frame,
                        value=value,
                        animLayer=layer,
                        noResolve=True,
                    )
            cmds.undoInfo(closeChunk=True)
            opened = False
            maximum_error = self._verify_targets(plan)
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
            cmds.undo()
            raise
        return ContactAnchorReceipt(
            plan=plan,
            layer_name=layer,
            verified=True,
            maximum_error=maximum_error,
            message=(
                f"已创建 {layer}，包含 {len(plan.corrections)} 个锚定采样；"
                f"最大世界空间误差 {maximum_error:.4f}。"
            ),
        )

    def undo(self, receipt):
        if not receipt.verified:
            raise ValueError("无法撤销未经验证的接触锚点回执")
        cmds, _om = _maya_modules()
        cmds.undo()
        if cmds.objExists(receipt.layer_name):
            raise RuntimeError("Maya 撤销后接触锚点动画层仍然存在")
        self._verify_expected_positions(receipt.plan)
        return True

    def _verify_expected_positions(self, plan):
        for correction in plan.corrections:
            sample = self._capture._sample(
                plan.node_path,
                correction.frame,
                self._capture._seconds_per_frame(),
            )
            error = self._distance(sample.position, correction.expected_position)
            if error > self.VERIFY_TOLERANCE:
                raise RuntimeError(
                    f"预览后第 {correction.frame:g} 帧的运动已经变化（误差 {error:.4f}）"
                )

    def _verify_targets(self, plan):
        errors = []
        for correction in plan.corrections:
            sample = self._capture._sample(
                plan.node_path,
                correction.frame,
                self._capture._seconds_per_frame(),
            )
            errors.append(self._distance(sample.position, correction.target_position))
        maximum = max(errors, default=0.0)
        if maximum > self.VERIFY_TOLERANCE:
            raise RuntimeError(f"接触锚点读回误差超出容差：{maximum:.4f}")
        return maximum

    @staticmethod
    def _world_to_parent_delta(node, frame, delta, cmds, om):
        parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
        if not parents:
            return tuple(float(value) for value in delta)
        raw = cmds.getAttr(parents[0] + ".worldMatrix[0]", time=frame)
        values = raw[0] if len(raw) == 1 and hasattr(raw[0], "__len__") else raw
        parent_inverse = om.MMatrix(values).inverse()
        local = om.MVector(*delta) * parent_inverse
        return (float(local.x), float(local.y), float(local.z))

    @staticmethod
    def _distance(left, right):
        return sqrt(sum((a - b) ** 2 for a, b in zip(left, right)))
