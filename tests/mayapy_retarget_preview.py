"""Maya 2025 semantic retarget mapping and zero-write Ghost Pose preview."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.retarget import build_retarget_profile, preview_retarget_pose

    def joint(name, position, parent=""):
        cmds.select(clear=True)
        value = cmds.joint(name=name, position=position)
        if parent:
            cmds.parent(value, parent)
        return (cmds.ls(value, long=True) or [value])[0]

    def skeleton(namespace, scale):
        if not cmds.namespace(exists=namespace):
            cmds.namespace(add=namespace)
        root = joint(f"{namespace}:root_JNT", (0, 0, 0))
        pelvis = joint(f"{namespace}:pelvis_JNT", (0, 10 * scale, 0), root)
        spine = joint(f"{namespace}:spine_JNT", (0, 13 * scale, 0), pelvis)
        chest = joint(f"{namespace}:chest_JNT", (0, 17 * scale, 0), spine)
        neck = joint(f"{namespace}:neck_JNT", (0, 20 * scale, 0), chest)
        head = joint(f"{namespace}:head_JNT", (0, 23 * scale, 0), neck)
        values = [root, pelvis, spine, chest, neck, head]
        for prefix, sign in (("L", 1), ("R", -1)):
            arm = joint(f"{namespace}:{prefix}_upperArm_JNT", (4 * sign * scale, 17 * scale, 0), chest)
            forearm = joint(f"{namespace}:{prefix}_forearm_JNT", (8 * sign * scale, 17 * scale, 0), arm)
            hand = joint(f"{namespace}:{prefix}_hand_JNT", (11 * sign * scale, 17 * scale, 0), forearm)
            thigh = joint(f"{namespace}:{prefix}_thigh_JNT", (3 * sign * scale, 9 * scale, 0), pelvis)
            calf = joint(f"{namespace}:{prefix}_calf_JNT", (3 * sign * scale, 5 * scale, 0), thigh)
            foot = joint(f"{namespace}:{prefix}_foot_JNT", (3 * sign * scale, 1 * scale, 1 * scale), calf)
            values.extend((arm, forearm, hand, thigh, calf, foot))
        return tuple(values), pelvis

    source_joints, source_pelvis = skeleton("source", 1.0)
    target_joints, _target_pelvis = skeleton("target", 2.0)
    scanner = MayaSkeletonScanner()
    source_analysis = scanner.capture_joint(source_joints[0])
    target_analysis = scanner.capture_joint(target_joints[0])
    profile = build_retarget_profile(source_analysis, target_analysis)
    assert profile.can_preview, profile.blockers
    assert len(profile.mappings) >= 12
    assert 1.95 <= profile.scale_ratio <= 2.05, profile.scale_ratio

    capture = MayaPoseClipCapture()
    source_reference = capture.capture_pose(source_joints, "源参考姿态").frame
    target_reference = capture.capture_pose(target_joints, "目标参考姿态").frame
    target_before = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    )
    cmds.setAttr(source_pelvis + ".translateX", cmds.getAttr(source_pelvis + ".translateX") + 1.0)
    source_hand = next(path for path in source_joints if path.endswith("source:L_hand_JNT"))
    cmds.setAttr(source_hand + ".rotateZ", 45.0)
    cmds.currentTime(7)
    cmds.select(source_hand)
    selection_before = tuple(cmds.ls(selection=True, long=True) or ())
    source_pose = capture.capture_pose(source_joints, "源动作姿态").frame
    preview = preview_retarget_pose(source_pose, source_reference, target_reference, profile)
    target_pelvis_path = profile.mapping("pelvis").target_path
    target_pelvis_ghost = next(node for node in preview.frame.nodes if node.node_path == target_pelvis_path)
    target_pelvis_rest = target_reference.node(target_pelvis_ghost.key)
    assert abs((target_pelvis_ghost.world_translation[0] - target_pelvis_rest.world_translation[0]) - 2.0) < 1e-5
    hand_signal = next(item for item in preview.signals if item.semantic_role == "left_hand")
    assert hand_signal.rotation_delta_degrees > 44.9
    assert cmds.currentTime(query=True) == 7.0
    assert tuple(cmds.ls(selection=True, long=True) or ()) == selection_before
    target_after = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    )
    assert target_after == target_before
    print(
        "MAYACRAFT_RETARGET_PREVIEW_OK",
        len(profile.mappings),
        round(profile.scale_ratio, 3),
        round(profile.confidence, 3),
        round(hand_signal.rotation_delta_degrees, 3),
    )
finally:
    maya.standalone.uninitialize()
