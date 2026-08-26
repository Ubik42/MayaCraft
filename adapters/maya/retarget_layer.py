"""Verified non-destructive semantic retarget transaction on a Maya override layer."""

from __future__ import annotations

from dataclasses import replace
import math
import re

from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture, _maya_modules
from MayaCraft.domain.pose_clip import ClipAsset
from MayaCraft.domain.retarget import RetargetLayerReceipt, plan_retarget_layer


class MayaRetargetLayerService:
    CHUNK_NAME = "MayaCraft Semantic Retarget"
    TRANSLATION_TOLERANCE = 1e-4
    ROTATION_TOLERANCE_DEGREES = 0.02

    def __init__(self, capture=None):
        self._capture = capture or MayaPoseClipCapture()

    def plan(self, source_clip, source_reference, target_reference, profile):
        cmds, _om = _maya_modules()
        target_paths = tuple(mapping.target_path for mapping in profile.mappings)
        baseline = self._capture_target_clip(
            target_paths,
            tuple(frame.frame for frame in source_clip.frames),
            source_clip.frames_per_second,
            label="目标场景基线",
        )
        leaf = profile.target_root.rsplit("|", 1)[-1].rsplit(":", 1)[-1]
        safe_leaf = re.sub(r"[^A-Za-z0-9_]+", "_", leaf).strip("_") or "Target"
        layer_name = f"MayaCraft_Retarget_{safe_leaf}"
        plan = plan_retarget_layer(
            source_clip,
            source_reference,
            target_reference,
            baseline,
            profile,
            layer_name,
        )
        blockers = list(plan.blockers)
        if cmds.objExists(layer_name):
            blockers.append(f"动画层已经存在：{layer_name}")
        for path in sorted({key.target_path for key in plan.keys}):
            if not cmds.objExists(path):
                blockers.append(f"目标节点已不存在：{path}")
                continue
            if cmds.referenceQuery(path, isNodeReferenced=True):
                blockers.append(f"引用节点无法接收本地重定向层：{path}")
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
        if not plan.can_apply:
            raise ValueError("当前重定向动画层计划不可应用")
        cmds, om = _maya_modules()
        self._verify_plan_state(plan, desired=False)
        opened = False
        layer = ""
        try:
            cmds.undoInfo(openChunk=True, chunkName=self.CHUNK_NAME)
            opened = True
            layer = cmds.animLayer(plan.layer_name, override=True)
            paths = sorted({key.target_path for key in plan.keys})
            for path in paths:
                for attribute in ("rotateX", "rotateY", "rotateZ"):
                    cmds.animLayer(layer, edit=True, attribute=f"{path}.{attribute}")
                if any(key.target_path == path and key.write_translation for key in plan.keys):
                    for attribute in ("translateX", "translateY", "translateZ"):
                        cmds.animLayer(layer, edit=True, attribute=f"{path}.{attribute}")
            for key in plan.keys:
                euler_degrees = self._quaternion_to_euler_degrees(
                    key.desired_rotation,
                    int(cmds.getAttr(key.target_path + ".rotateOrder")),
                    om,
                )
                for attribute, value in zip(("rotateX", "rotateY", "rotateZ"), euler_degrees):
                    cmds.setKeyframe(
                        key.target_path,
                        attribute=attribute,
                        time=key.frame,
                        value=value,
                        animLayer=layer,
                        noResolve=True,
                    )
                if key.write_translation:
                    for attribute, value in zip(("translateX", "translateY", "translateZ"), key.desired_translation):
                        cmds.setKeyframe(
                            key.target_path,
                            attribute=attribute,
                            time=key.frame,
                            value=value,
                            animLayer=layer,
                            noResolve=True,
                        )
            cmds.undoInfo(closeChunk=True)
            opened = False
            maximum_translation, maximum_rotation = self._verify_plan_state(plan, desired=True)
            self._refresh_current_context(cmds)
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
            cmds.undo()
            raise
        return RetargetLayerReceipt(
            plan=plan,
            layer_name=layer,
            verified=True,
            maximum_translation_error=maximum_translation,
            maximum_rotation_error_degrees=maximum_rotation,
            message=(
                f"已创建 {layer}，验证 {len(plan.keys)} 个语义节点帧；"
                f"最大位移误差 {maximum_translation:.5f}，最大旋转误差 {maximum_rotation:.4f}°。"
            ),
        )

    def undo(self, receipt):
        if not receipt.verified:
            raise ValueError("无法撤销未经验证的重定向回执")
        cmds, _om = _maya_modules()
        cmds.undo()
        if cmds.objExists(receipt.layer_name):
            raise RuntimeError("Maya 撤销后重定向动画层仍然存在")
        self._verify_plan_state(receipt.plan, desired=False)
        self._refresh_current_context(cmds)
        return True

    @staticmethod
    def _refresh_current_context(cmds):
        current = float(cmds.currentTime(query=True))
        undo_enabled = bool(cmds.undoInfo(query=True, state=True))
        if undo_enabled:
            cmds.undoInfo(stateWithoutFlush=False)
        try:
            cmds.dgdirty(allPlugs=True)
            cmds.currentTime(current, edit=True, update=True)
        finally:
            if undo_enabled:
                cmds.undoInfo(stateWithoutFlush=True)

    def _verify_plan_state(self, plan, desired):
        cmds, om = _maya_modules()
        by_frame = {}
        for key in plan.keys:
            by_frame.setdefault(key.frame, set()).add(key.target_path)
        states = {}
        for frame, paths in by_frame.items():
            captured = self._capture._capture_frame(tuple(sorted(paths)), frame, om)
            for node in captured.nodes:
                states[(frame, node.node_path)] = node
        translation_errors = []
        rotation_errors = []
        for key in plan.keys:
            current = states[(key.frame, key.target_path)]
            expected_translation = key.desired_translation if desired else key.expected_translation
            expected_rotation = key.desired_rotation if desired else key.expected_rotation
            if key.write_translation:
                translation_errors.append(self._distance(current.local_translation, expected_translation))
            rotation_errors.append(self._quaternion_error_degrees(current.local_rotation, expected_rotation))
        maximum_translation = max(translation_errors, default=0.0)
        maximum_rotation = max(rotation_errors, default=0.0)
        if maximum_translation > self.TRANSLATION_TOLERANCE:
            state = "写后" if desired else "预览后"
            raise RuntimeError(f"{state}目标位移与计划不一致：{maximum_translation:.6f}")
        if maximum_rotation > self.ROTATION_TOLERANCE_DEGREES:
            state = "写后" if desired else "预览后"
            raise RuntimeError(f"{state}目标旋转与计划不一致：{maximum_rotation:.4f}°")
        return maximum_translation, maximum_rotation

    def _capture_target_clip(self, paths, frames, fps, label):
        _cmds, om = _maya_modules()
        pose_frames = tuple(self._capture._capture_frame(paths, frame, om) for frame in frames)
        return ClipAsset(
            label=label,
            character_id="",
            frames_per_second=float(fps),
            frames=pose_frames,
            source="Maya 2025 target baseline / API 2.0 DG Context",
        )

    @staticmethod
    def _quaternion_to_euler_degrees(value, rotate_order, om):
        quaternion = om.MQuaternion(*value)
        euler = quaternion.asEulerRotation()
        euler.reorderIt(rotate_order)
        return tuple(math.degrees(component) for component in (euler.x, euler.y, euler.z))

    @staticmethod
    def _distance(left, right):
        return math.sqrt(sum((a - b) ** 2 for a, b in zip(left, right)))

    @staticmethod
    def _quaternion_error_degrees(left, right):
        left_length = math.sqrt(sum(value * value for value in left)) or 1.0
        right_length = math.sqrt(sum(value * value for value in right)) or 1.0
        dot = abs(sum(a * b for a, b in zip(left, right)) / (left_length * right_length))
        return math.degrees(2.0 * math.acos(max(-1.0, min(1.0, dot))))


__all__ = ["MayaRetargetLayerService"]
