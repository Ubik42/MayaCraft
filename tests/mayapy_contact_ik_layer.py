"""Maya 2025 verification for pelvis-compensated Contact IK layer transactions."""

from __future__ import annotations

import pathlib
import sys
import math

import maya.standalone


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    from MayaCraft.adapters.maya.contact_ik_layer import MayaContactIKLayerService
    from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture
    from MayaCraft.adapters.maya.retarget_layer import MayaRetargetLayerService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.ik import ContactIKSettings, preview_retarget_contact_ik
    from MayaCraft.domain.retarget import (
        build_retarget_profile,
        preview_retarget_clip,
        validate_retarget_result,
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

    scanner = MayaSkeletonScanner()
    capture = MayaPoseClipCapture()
    source_joints, source_pelvis = skeleton("source", 1.0)
    target_joints, target_pelvis = skeleton("target", 1.65)
    source_feet = tuple(path for path in source_joints if path.endswith(("source:L_foot_JNT", "source:R_foot_JNT")))
    source_hand = next(path for path in source_joints if path.endswith("source:L_hand_JNT"))
    target_hand = next(path for path in target_joints if path.endswith("target:L_hand_JNT"))
    target_initial = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints
    )

    cmds.currentTime(1)
    cmds.select(source_hand)
    source_analysis = scanner.capture_selection()
    source_reference = capture.capture_pose(source_joints, "源参考").frame
    cmds.select(target_hand)
    target_analysis = scanner.capture_selection()
    target_reference = capture.capture_pose(target_joints, "目标参考").frame
    profile = build_retarget_profile(source_analysis, target_analysis)
    assert profile.can_preview and len(profile.mappings) == 18

    for frame, root_x, hand_z in ((1, 0.0, 0.0), (3, 1.0, 26.0), (5, 2.0, 52.0)):
        cmds.setKeyframe(source_pelvis, attribute="translateX", time=frame, value=root_x)
        cmds.setKeyframe(source_hand, attribute="rotateZ", time=frame, value=hand_z)
        for foot in source_feet:
            cmds.setKeyframe(foot, attribute="translateX", time=frame, value=-root_x)
    cmds.playbackOptions(minTime=1, maxTime=5)
    source_clip = capture.capture_clip(source_joints, label="源接触动作")
    ghost = preview_retarget_clip(
        source_clip, source_reference, target_reference, profile
    )
    assert len(ghost.contacts) == 2 and ghost.contact_preservation == 1.0

    retarget_service = MayaRetargetLayerService(capture)
    retarget_plan = retarget_service.plan(
        source_clip, source_reference, target_reference, profile
    )
    retarget_receipt = retarget_service.apply(retarget_plan)
    frames = tuple(frame.frame for frame in source_clip.frames)
    actual_clip = capture.capture_clip(
        target_joints, start=frames[0], end=frames[-1], label="重定向实际结果"
    )
    before_ik = actual_clip.fingerprint
    ik_preview = preview_retarget_contact_ik(actual_clip, ghost, profile)
    assert ik_preview.samples
    assert ik_preview.unreachable_count == 0, ik_preview
    assert ik_preview.maximum_error < 1e-4
    assert 0.1 < ik_preview.maximum_pelvis_offset < 1.0

    ik_service = MayaContactIKLayerService(capture)
    ik_plan = ik_service.plan(actual_clip, ik_preview, profile)
    assert ik_plan.can_apply, ik_plan.blockers
    assert any(key.semantic_role == "pelvis" and key.write_translation for key in ik_plan.keys)
    assert any(key.semantic_role == "left_upper_leg" for key in ik_plan.keys)

    pelvis_frame = next(
        key for key in ik_plan.keys
        if key.semantic_role == "pelvis" and key.frame == 3.0
    )
    cmds.undoInfo(openChunk=True, chunkName="Contact IK Drift Probe")
    try:
        cmds.setKeyframe(
            target_pelvis, attribute="translateY", time=3,
            value=pelvis_frame.expected_translation[1] + 0.125,
            animLayer=retarget_receipt.layer_name, noResolve=True,
        )
    finally:
        cmds.undoInfo(closeChunk=True)
    try:
        ik_service.apply(ik_plan)
    except RuntimeError as exc:
        assert "预览后" in str(exc)
    else:
        raise AssertionError("场景漂移后的接触 IK 计划必须拒绝应用")
    assert not cmds.objExists(ik_plan.layer_name)
    cmds.undo()

    ik_receipt = ik_service.apply(ik_plan)
    assert ik_receipt.verified
    assert ik_receipt.maximum_anchor_error < 0.02
    assert cmds.objExists(ik_receipt.layer_name)
    corrected_clip = capture.capture_clip(
        target_joints, start=frames[0], end=frames[-1], label="接触 IK 结果"
    )
    final_validation = validate_retarget_result(corrected_clip, ghost, profile)
    assert final_validation.contact_preservation == 1.0, final_validation

    ik_service.undo(ik_receipt)
    assert not cmds.objExists(ik_plan.layer_name)
    restored_ik_baseline = capture.capture_clip(
        target_joints, start=frames[0], end=frames[-1], label="重定向实际结果"
    )
    assert restored_ik_baseline.fingerprint == before_ik

    slope_radians = 10.0 * 3.141592653589793 / 180.0
    slope_normal = (0.0, math.cos(slope_radians), math.sin(slope_radians))
    slope_preview = preview_retarget_contact_ik(
        actual_clip, ghost, profile,
        settings=ContactIKSettings(
            ground_normal=slope_normal,
            fade_frames=0,
            anchor_offsets=(
                ("left", (0.1, 0.0, 0.0)),
                ("right", (-0.1, 0.0, 0.0)),
            ),
        ),
    )
    assert slope_preview.unreachable_count == 0
    assert abs(slope_preview.maximum_ground_angle_degrees - 10.0) < 1e-4
    slope_plan = ik_service.plan(actual_clip, slope_preview, profile)
    assert slope_plan.can_apply, slope_plan.blockers
    assert any(key.semantic_role == "root" for key in slope_plan.keys)
    slope_receipt = ik_service.apply(slope_plan)
    assert slope_receipt.maximum_anchor_error < 0.02
    root_mapping = profile.mapping("root")
    slope_frame = capture._capture_frame((root_mapping.target_path,), 3.0, __import__("maya.api.OpenMaya", fromlist=["OpenMaya"]))
    root_q = slope_frame.nodes[0].world_rotation

    def rotate_vector(q, value):
        x, y, z, w = q
        vx, vy, vz = value
        tx = 2.0 * (y * vz - z * vy)
        ty = 2.0 * (z * vx - x * vz)
        tz = 2.0 * (x * vy - y * vx)
        return (
            vx + w * tx + (y * tz - z * ty),
            vy + w * ty + (z * tx - x * tz),
            vz + w * tz + (x * ty - y * tx),
        )

    root_up = rotate_vector(root_q, (0.0, 1.0, 0.0))
    assert sum(a * b for a, b in zip(root_up, slope_normal)) > 0.9999
    ik_service.undo(slope_receipt)
    assert not cmds.objExists(slope_plan.layer_name)

    retarget_service.undo(retarget_receipt)
    target_restored = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints
    )
    assert target_restored == target_initial
    print(
        "MAYACRAFT_CONTACT_IK_LAYER_OK",
        len(ik_plan.keys),
        ik_receipt.maximum_anchor_error,
        ik_preview.maximum_pelvis_offset,
        slope_receipt.maximum_anchor_error,
    )
finally:
    maya.standalone.uninitialize()
