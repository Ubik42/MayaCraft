"""Maya 2025 validation for non-mutating Motion Magnetism sampling."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    package_parent = pathlib.Path(__file__).resolve().parents[2]
    sys.path.insert(0, str(package_parent))
    from MayaCraft.adapters.maya.motion_capture import MayaMotionCapture
    from MayaCraft.adapters.maya.motion_anchor import MayaContactAnchorService

    cmds.currentUnit(time="film")
    cmds.playbackOptions(minTime=1, maxTime=25)
    control = cmds.createNode("transform", name="motion_CTRL")
    for frame, position in (
        (1, (0.0, 0.0, 0.0)),
        (8, (0.0, 0.0, 0.0)),
        (16, (10.0, 5.0, 0.0)),
        (20, (15.0, 0.0, 0.0)),
        (25, (15.0, 0.0, 0.0)),
    ):
        for attribute, value in zip(("translateX", "translateY", "translateZ"), position):
            cmds.setKeyframe(control, attribute=attribute, time=frame, value=value)
    cmds.setKeyframe(control, attribute="rotateY", time=1, value=0.0)
    cmds.setKeyframe(control, attribute="rotateY", time=15, value=20.0)
    cmds.setKeyframe(control, attribute="rotateY", time=16, value=150.0)
    cmds.setKeyframe(control, attribute="rotateY", time=25, value=160.0)
    cmds.keyTangent(control, inTangentType="linear", outTangentType="linear")
    cmds.select(control)
    cmds.currentTime(13)

    capture = MayaMotionCapture().capture_selection()
    assert len(capture.samples) == 25, len(capture.samples)
    assert capture.node_path == "|motion_CTRL", capture.node_path
    assert abs(capture.frames_per_second - 24.0) < 1e-6, capture.frames_per_second
    assert cmds.currentTime(query=True) == 13, "Sampler changed Maya current time"
    assert capture.analysis.total_arc_length > 17.0, capture.analysis.total_arc_length
    assert len(capture.analysis.contacts) >= 2, capture.analysis.contacts
    assert capture.analysis.rotation_jump_count >= 1, capture.analysis.rotation_jump_count
    assert capture.analysis.maximum_speed > 0.0
    assert capture.analysis.maximum_jerk > 0.0
    cmds.setKeyframe(control, attribute="translateX", time=1, value=1.0)
    cmds.setKeyframe(control, attribute="translateX", time=8, value=1.0)
    candidate = MayaMotionCapture().capture_selection()
    anchor_service = MayaContactAnchorService()
    anchor_plan = anchor_service.plan(capture, candidate, 0, blend_samples=1)
    assert anchor_plan.can_apply and anchor_plan.corrections, anchor_plan
    anchor_receipt = anchor_service.apply(anchor_plan)
    assert anchor_receipt.verified and cmds.objExists(anchor_receipt.layer_name), anchor_receipt
    assert anchor_receipt.maximum_error <= 0.01, anchor_receipt
    assert anchor_service.undo(anchor_receipt)
    restored_candidate = MayaMotionCapture().capture_selection()
    assert abs(restored_candidate.samples[0].position[0] - 1.0) < 1e-6
    cmds.setAttr(control + ".translateX", lock=True)
    locked_plan = anchor_service.plan(capture, restored_candidate, 0)
    assert not locked_plan.can_apply and any("已锁定" in item for item in locked_plan.blockers)
    cmds.setAttr(control + ".translateX", lock=False)
    drift_plan = anchor_service.plan(capture, restored_candidate, 0)
    assert drift_plan.can_apply
    cmds.setKeyframe(control, attribute="translateX", time=1, value=2.0)
    try:
        anchor_service.apply(drift_plan)
        raise AssertionError("Expected scene-drift protection to block stale anchor plan")
    except RuntimeError as exc:
        assert "预览后" in str(exc), exc
    assert not cmds.objExists(drift_plan.layer_name)
    print(
        "MAYACRAFT_MOTION_OK",
        len(capture.samples),
        round(capture.analysis.total_arc_length, 3),
        len(capture.analysis.contacts),
        capture.analysis.rotation_jump_count,
    )
finally:
    maya.standalone.uninitialize()
