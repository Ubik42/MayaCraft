"""Maya 2025 verified Retarget override Animation Layer transaction."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture
    from MayaCraft.adapters.maya.retarget_layer import MayaRetargetLayerService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.retarget import (
        build_retarget_profile, retarget_axis_templates,
        with_retarget_axis_template,
    )

    def joint(name, position, parent=""):
        cmds.select(clear=True)
        value = cmds.joint(name=name, position=position)
        if parent:
            cmds.parent(value, parent)
        return (cmds.ls(value, long=True) or [value])[0]

    def skeleton(namespace, scale):
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
    target_joints, target_pelvis = skeleton("target", 1.5)
    source_hand = next(path for path in source_joints if path.endswith("source:L_hand_JNT"))
    target_hand = next(path for path in target_joints if path.endswith("target:L_hand_JNT"))
    cmds.setAttr(target_hand + ".jointOrientY", 35.0)
    for frame, root_x, hand_z in ((1, 0.0, 0.0), (3, 2.0, 45.0), (5, 4.0, 90.0)):
        cmds.setKeyframe(source_pelvis, attribute="translateX", time=frame, value=root_x)
        cmds.setKeyframe(source_hand, attribute="rotateZ", time=frame, value=hand_z)
    cmds.currentTime(1)
    cmds.select(source_hand)
    selection_before = tuple(cmds.ls(selection=True, long=True) or ())

    scanner = MayaSkeletonScanner()
    source_analysis = scanner.capture_joint(source_joints[0])
    target_analysis = scanner.capture_joint(target_joints[0])
    profile = build_retarget_profile(source_analysis, target_analysis)
    capture = MayaPoseClipCapture()
    source_reference = capture.capture_pose(source_joints, "源参考").frame
    target_reference = capture.capture_pose(target_joints, "目标参考").frame
    source_clip = capture.capture_clip(source_joints, 1, 5, 2, "源动作")
    service = MayaRetargetLayerService(capture)
    plan = service.plan(source_clip, source_reference, target_reference, profile)
    assert plan.can_apply, plan.blockers
    assert any(key.semantic_role == "pelvis" and key.write_translation for key in plan.keys)
    assert all(not key.write_translation for key in plan.keys if key.semantic_role != "pelvis")
    receipt = service.apply(plan)
    assert receipt.verified and cmds.objExists(receipt.layer_name)
    assert receipt.maximum_translation_error < 1e-4
    assert receipt.maximum_rotation_error_degrees < 0.02
    target_result = capture.capture_clip(target_joints, 1, 5, 2, "目标结果")
    assert abs(target_result.frames[-1].node("pelvis_JNT").local_translation[0] - 6.0) < 1e-4
    target_hand_rotation = target_result.frames[-1].node("L_hand_JNT").local_rotation
    hand_key = next(
        key for key in plan.keys if key.semantic_role == "left_hand" and key.frame == 5.0
    )
    assert abs(sum(a * b for a, b in zip(target_hand_rotation, hand_key.desired_rotation))) > 0.999999
    assert abs(sum(a * b for a, b in zip(target_hand_rotation, (0.0, 0.0, 2 ** -0.5, 2 ** -0.5)))) < 0.999

    def multiply(left, right):
        ax, ay, az, aw = left
        bx, by, bz, bw = right
        return (
            aw * bx + ax * bw + ay * bz - az * by,
            aw * by - ax * bz + ay * bw + az * bx,
            aw * bz + ax * by - ay * bx + az * bw,
            aw * bw - ax * bx - ay * by - az * bz,
        )

    def inverse(value):
        return (-value[0], -value[1], -value[2], value[3])

    source_last_world = source_clip.frames[-1].node("L_hand_JNT").world_rotation
    source_rest_world = source_reference.node("L_hand_JNT").world_rotation
    target_rest_world = target_reference.node("L_hand_JNT").world_rotation
    expected_world = multiply(multiply(source_last_world, inverse(source_rest_world)), target_rest_world)
    actual_world = target_result.frames[-1].node("L_hand_JNT").world_rotation
    assert abs(sum(a * b for a, b in zip(expected_world, actual_world))) > 0.99999
    assert cmds.currentTime(query=True) == 1.0
    assert tuple(cmds.ls(selection=True, long=True) or ()) == selection_before
    service.undo(receipt)
    assert not cmds.objExists(receipt.layer_name)
    restored = capture.capture_clip(target_joints, 1, 5, 2, "撤销结果")
    assert abs(restored.frames[-1].node("pelvis_JNT").local_translation[0]) < 1e-6
    assert abs(restored.frames[-1].node("L_hand_JNT").local_rotation[2]) < 1e-6

    axis_template = next(
        item for item in retarget_axis_templates()
        if item.template_id == "z_forward_to_x_forward"
    )
    axis_profile = with_retarget_axis_template(profile, axis_template)
    axis_plan = service.plan(
        source_clip, source_reference, target_reference, axis_profile
    )
    assert axis_plan.can_apply, axis_plan.blockers
    axis_pelvis = next(
        key for key in axis_plan.keys
        if key.semantic_role == "pelvis" and key.frame == 5.0
    )
    assert abs(axis_pelvis.desired_translation[0]) < 1e-5
    assert abs(axis_pelvis.desired_translation[2] + 6.0) < 1e-5
    axis_receipt = service.apply(axis_plan)
    axis_result = capture.capture_clip(target_joints, 1, 5, 2, "跨轴目标结果")
    axis_pelvis_result = axis_result.frames[-1].node("pelvis_JNT")
    assert abs(axis_pelvis_result.local_translation[0]) < 1e-5
    assert abs(axis_pelvis_result.local_translation[2] + 6.0) < 1e-5
    axis_hand_world = axis_result.frames[-1].node("L_hand_JNT").world_rotation
    axis_rotation = axis_template.rotation
    source_delta = multiply(source_last_world, inverse(source_rest_world))
    calibrated_delta = multiply(multiply(axis_rotation, source_delta), inverse(axis_rotation))
    expected_axis_world = multiply(calibrated_delta, target_rest_world)
    assert abs(sum(a * b for a, b in zip(axis_hand_world, expected_axis_world))) > 0.99999
    service.undo(axis_receipt)
    assert not cmds.objExists(axis_receipt.layer_name)

    stale_plan = service.plan(source_clip, source_reference, target_reference, profile)
    cmds.setAttr(target_hand + ".rotateY", 10.0)
    try:
        service.apply(stale_plan)
    except RuntimeError as exc:
        assert "预览后" in str(exc)
    else:
        raise AssertionError("stale target pose was not rejected")
    cmds.setAttr(target_hand + ".rotateY", 0.0)
    cmds.setAttr(target_hand + ".rotateZ", lock=True)
    blocked = service.plan(source_clip, source_reference, target_reference, profile)
    assert not blocked.can_apply and any("已锁定" in item for item in blocked.blockers)

    print(
        "MAYACRAFT_RETARGET_LAYER_OK",
        len(plan.keys), len(axis_plan.keys), receipt.layer_name,
        round(receipt.maximum_translation_error, 6),
        round(receipt.maximum_rotation_error_degrees, 5),
    )
finally:
    maya.standalone.uninitialize()
