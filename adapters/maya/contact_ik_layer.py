"""Maya 2025 transaction for a verified contact-IK override animation layer."""

from __future__ import annotations

from dataclasses import replace
import math
import re

from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture, _maya_modules
from MayaCraft.adapters.maya.retarget_layer import MayaRetargetLayerService
from MayaCraft.domain.ik import (
    ContactIKLayerReceipt,
    plan_contact_ik_layer,
)


class MayaContactIKLayerService(MayaRetargetLayerService):
    CHUNK_NAME = "MayaCraft Contact IK"
    ANCHOR_TOLERANCE = 0.02

    def __init__(self, capture=None):
        super().__init__(capture or MayaPoseClipCapture())

    def plan(self, actual_clip, preview, profile):
        cmds, _om = _maya_modules()
        leaf = profile.target_root.rsplit("|", 1)[-1].rsplit(":", 1)[-1]
        safe_leaf = re.sub(r"[^A-Za-z0-9_]+", "_", leaf).strip("_") or "Target"
        layer_name = f"MayaCraft_ContactIK_{safe_leaf}"
        plan = plan_contact_ik_layer(
            actual_clip, preview, profile, layer_name
        )
        blockers = list(plan.blockers)
        if cmds.objExists(layer_name):
            blockers.append(f"接触 IK 动画层已经存在：{layer_name}")
        for path in sorted({key.target_path for key in plan.keys}):
            if not cmds.objExists(path):
                blockers.append(f"接触 IK 目标节点已不存在：{path}")
                continue
            if cmds.referenceQuery(path, isNodeReferenced=True):
                blockers.append(f"引用节点无法接收本地接触 IK 层：{path}")
            attributes = ["rotateX", "rotateY", "rotateZ"]
            if any(key.target_path == path and key.write_translation for key in plan.keys):
                attributes.extend(("translateX", "translateY", "translateZ"))
            for attribute in attributes:
                plug = f"{path}.{attribute}"
                if not cmds.objExists(plug):
                    blockers.append(f"目标通道不存在：{plug}")
                elif cmds.getAttr(plug, lock=True):
                    blockers.append(f"目标通道已锁定：{plug}")
        return replace(plan, blockers=tuple(dict.fromkeys(blockers))) if blockers else plan

    def apply(self, plan):
        base_receipt = super().apply(plan)
        try:
            maximum_anchor_error = self._verify_anchors(plan)
        except Exception:
            super().undo(base_receipt)
            raise
        return ContactIKLayerReceipt(
            plan=plan,
            layer_name=base_receipt.layer_name,
            verified=True,
            maximum_translation_error=base_receipt.maximum_translation_error,
            maximum_rotation_error_degrees=base_receipt.maximum_rotation_error_degrees,
            maximum_anchor_error=maximum_anchor_error,
            message=(
                f"已创建 {base_receipt.layer_name}，验证 {len(plan.keys)} 个节点帧；"
                f"最大脚底锚点误差 {maximum_anchor_error:.5f}。"
            ),
        )

    def undo(self, receipt):
        return super().undo(receipt)

    def _verify_anchors(self, plan):
        _cmds, om = _maya_modules()
        by_frame = {}
        for anchor in plan.anchors:
            by_frame.setdefault(anchor.frame, set()).add(anchor.target_path)
        positions = {}
        for frame, paths in by_frame.items():
            captured = self._capture._capture_frame(tuple(sorted(paths)), frame, om)
            for node in captured.nodes:
                positions[(frame, node.node_path)] = node.world_translation
        errors = []
        for anchor in plan.anchors:
            current = positions.get((anchor.frame, anchor.target_path))
            if current is None:
                raise RuntimeError(
                    f"第 {anchor.frame:g} 帧无法读回脚底锚点：{anchor.target_path}"
                )
            errors.append(math.dist(current, anchor.world_position))
        maximum = max(errors, default=0.0)
        if maximum > self.ANCHOR_TOLERANCE:
            raise RuntimeError(f"接触 IK 写后脚底锚点误差过大：{maximum:.5f}")
        return maximum


__all__ = ["MayaContactIKLayerService"]
