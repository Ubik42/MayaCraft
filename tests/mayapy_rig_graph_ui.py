"""Offscreen Maya 2025 interaction test for the native Rig Graph workspace."""

from __future__ import annotations

import pathlib
import sys
import maya.standalone
from PySide6 import QtGui, QtTest, QtWidgets

app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
QtGui.QFontDatabase.addApplicationFont("C:/Windows/Fonts/segoeui.ttf")
maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds
    sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
    from MayaCraft.compat.qt import QtCore
    from MayaCraft.ui.main_window import MayaCraftMainWindow

    def joint(name, position, parent=""):
        cmds.select(clear=True)
        value = cmds.joint(name=name, position=position)
        if parent:
            cmds.parent(value, parent)
        return (cmds.ls(value, long=True) or [value])[0]

    root = joint("root_JNT", (0, 0, 0))
    pelvis = joint("pelvis_JNT", (0, 10, 0), root)
    spine = joint("spine_JNT", (0, 13, 0), pelvis)
    chest = joint("chest_JNT", (0, 17, 0), spine)
    neck = joint("neck_JNT", (0, 20, 0), chest)
    joint("head_JNT", (0, 23, 0), neck)
    for prefix, sign in (("L", 1), ("R", -1)):
        arm = joint(f"{prefix}_upperArm_JNT", (4 * sign, 17, 0), chest)
        forearm = joint(f"{prefix}_forearm_JNT", (8 * sign, 17, 0), arm)
        joint(f"{prefix}_hand_JNT", (11 * sign, 17, 0), forearm)
        thigh = joint(f"{prefix}_thigh_JNT", (3 * sign, 9, 0), pelvis)
        calf = joint(f"{prefix}_calf_JNT", (3 * sign, 5, 0), thigh)
        joint(f"{prefix}_foot_JNT", (3 * sign, 1, 1), calf)
    cmds.select(clear=True)

    window = MayaCraftMainWindow()
    window.resize(1120, 760)
    window.show()
    window.show_rig_graph()
    app.processEvents()
    workspace = window.rig_graph_workspace
    cmds.select("L_hand_JNT")
    workspace.capture_skeleton()
    app.processEvents()
    assert workspace.skeleton.is_usable
    assert workspace.plan.can_apply
    assert "137 个对象" in workspace.diff.text(), workspace.diff.text()
    assert "50 条物理行为" in workspace.diff.text(), workspace.diff.text()
    # A real OS cursor is unavailable in background mayapy. Exercise the same
    # Qt signal path deterministically instead of depending on desktop focus.
    workspace.canvas.moduleHovered.emit("root")
    app.processEvents()
    assert "角色根" in workspace.detail.text(), workspace.detail.text()

    artifacts = pathlib.Path(__file__).with_name("artifacts")
    artifacts.mkdir(exist_ok=True)
    docs_images = pathlib.Path(__file__).parents[1] / "docs" / "images"
    preview = artifacts / "mayacraft_rig_graph_preview.png"
    assert window.grab().save(str(preview))
    workspace.apply_plan()
    app.processEvents()
    assert workspace.plan.is_noop
    assert workspace.receipt and workspace.receipt.verified
    assert len(workspace.service.scan_behaviors(workspace.graph.graph_id)) == 50
    hand_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL|L_forearm_FK_CTRL|L_hand_FK_CTRL"
    result_hand = "|MC_RIG|MC_DELIVERY|L_upperArm_RESULT_JNT|L_forearm_RESULT_JNT|L_hand_RESULT_JNT"
    ik_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_IK_SPACE|L_hand_IK_CTRL"
    assert cmds.objExists(hand_control)
    assert cmds.objExists(result_hand)
    assert cmds.attributeQuery("space", node=ik_control, exists=True)
    assert cmds.attributeQuery("ikFk", node=ik_control, exists=True)
    hand_position = cmds.xform(hand_control, query=True, worldSpace=True, translation=True)
    assert all(abs(value - expected) < 1e-5 for value, expected in zip(hand_position, (11, 17, 0))), hand_position
    assert cmds.getAttr(hand_control + ".mayacraftSourceJoint").endswith("|L_hand_JNT")
    upper_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL"
    upper_joint = "|MC_RIG|MC_DELIVERY|L_upperArm_RESULT_JNT"
    cmds.setAttr(upper_control + ".rotateZ", 18.0)
    driven = cmds.xform(upper_joint, query=True, worldSpace=True, rotation=True)
    assert abs(driven[2] - 18.0) < 1e-5, driven
    cmds.undo()  # Undo only the interaction probe before testing the build receipt.
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft UI IK Probe")
    cmds.setAttr(ik_control + ".ikFk", 1.0)
    ik_target = (10.0, 18.0, 2.0)
    cmds.xform(ik_control, worldSpace=True, translation=ik_target)
    cmds.undoInfo(closeChunk=True)
    ik_result = cmds.xform(result_hand, query=True, worldSpace=True, translation=True)
    assert sum((value - expected) ** 2 for value, expected in zip(ik_result, ik_target)) ** 0.5 < 1e-4
    pole = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_POLE_CTRL"
    pole_position = cmds.xform(pole, query=True, worldSpace=True, translation=True)
    assert abs(pole_position[2]) > 1.0, pole_position
    cmds.undo()

    # Bendy Hero: direct silhouette -> zero-write plan -> DG apply/readback -> Undo -> blocker.
    workspace.show_bendy_panel()
    workspace.bendy_field.set_preset("S")
    workspace.bendy_volume_slider.setValue(82)
    workspace.confirm_bendy_intent()
    app.processEvents()
    assert workspace.pending_bendy_plan and workspace.pending_bendy_plan.can_apply
    assert "零写入计划" in workspace.bendy_status.text()
    bendy_preview = artifacts / "mayacraft_bendy_preview_cn.png"
    assert window.grab().save(str(bendy_preview))
    assert window.grab().save(str(docs_images / "bendy_preview.png"))
    workspace.apply_bendy_intent()
    app.processEvents()
    assert workspace.bendy_receipt and workspace.bendy_receipt.verified
    assert "验证" in workspace.bendy_status.text()
    bendy_verified = artifacts / "mayacraft_bendy_verified_cn.png"
    assert window.grab().save(str(bendy_verified))
    assert window.grab().save(str(docs_images / "bendy_verified.png"))
    window.resize(760, 620)
    app.processEvents()
    assert workspace.bendy_panel.isVisible()
    assert workspace.bendy_panel.geometry().bottom() <= workspace.height()
    bendy_narrow = artifacts / "mayacraft_bendy_narrow_cn.png"
    assert window.grab().save(str(bendy_narrow))
    assert window.grab().save(str(docs_images / "bendy_narrow.png"))
    window.resize(1120, 760)
    app.processEvents()
    workspace.undo_bendy_intent()
    app.processEvents()
    assert workspace.bendy_receipt is None
    assert "撤销验证通过" in workspace.bendy_status.text()
    bendy_undo = artifacts / "mayacraft_bendy_undo_cn.png"
    assert window.grab().save(str(bendy_undo))
    assert window.grab().save(str(docs_images / "bendy_undo.png"))
    bendy_in = workspace.service._paths_by_id(cmds, workspace.graph.graph_id)["l_arm.bendy.0.in"]
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft UI Bendy Locked Probe")
    cmds.setAttr(f"{bendy_in}.translateY", lock=True)
    workspace.confirm_bendy_intent()
    app.processEvents()
    assert not workspace.pending_bendy_plan.can_apply
    assert "预检阻断" in workspace.bendy_status.text()
    bendy_blocked = artifacts / "mayacraft_bendy_blocked_cn.png"
    assert window.grab().save(str(bendy_blocked))
    assert window.grab().save(str(docs_images / "bendy_blocked.png"))
    cmds.undoInfo(closeChunk=True)
    cmds.undo()
    workspace.hide_bendy_panel()

    # Native animator workflow: zero-write preview -> keyed match -> verified UI -> Undo.
    workspace.preview_match("FK_TO_IK")
    app.processEvents()
    assert workspace.pending_switch_plan and workspace.pending_switch_plan.can_apply
    assert "零写入预览" in workspace.match_status.text()
    match_preview = artifacts / "mayacraft_rig_match_preview_cn.png"
    assert window.grab().save(str(match_preview))
    workspace.apply_switch_plan()
    app.processEvents()
    assert workspace.switch_receipt and workspace.switch_receipt.verified
    assert "验证通过" in workspace.match_status.text()
    match_verified = artifacts / "mayacraft_rig_match_verified_cn.png"
    assert window.grab().save(str(match_verified))
    window.resize(760, 620)
    app.processEvents()
    assert workspace.match_panel.isVisible()
    assert workspace.match_panel.geometry().bottom() <= workspace.height()
    match_narrow = artifacts / "mayacraft_rig_match_narrow_cn.png"
    assert window.grab().save(str(match_narrow))
    window.resize(1120, 760)
    app.processEvents()
    workspace.undo_switch()
    app.processEvents()
    assert workspace.switch_receipt is None
    assert "撤销验证通过" in workspace.match_status.text()
    match_undo = artifacts / "mayacraft_rig_match_undo_cn.png"
    assert window.grab().save(str(match_undo))

    # Twist Hero: live quaternion probe -> zero-write profile -> apply/verify -> Undo -> blocker.
    forearm_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL|L_forearm_FK_CTRL"
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft UI Twist Pose Probe")
    cmds.setAttr(forearm_control + ".rotateX", 90.0)
    cmds.undoInfo(closeChunk=True)
    workspace.show_twist_panel()
    workspace.twist_bias_slider.setValue(-65)
    workspace.twist_ease_slider.setValue(85)
    workspace.twist_intensity_slider.setValue(90)
    workspace.preview_twist_profile()
    app.processEvents()
    assert workspace.pending_twist_plan and workspace.pending_twist_plan.can_apply
    assert "零写入预览" in workspace.twist_status.text()
    twist_preview = artifacts / "mayacraft_twist_preview_cn.png"
    assert window.grab().save(str(twist_preview))
    workspace.apply_twist_profile()
    app.processEvents()
    assert workspace.twist_receipt and workspace.twist_receipt.verified
    assert "验证" in workspace.twist_status.text()
    twist_verified = artifacts / "mayacraft_twist_verified_cn.png"
    assert window.grab().save(str(twist_verified))
    window.resize(760, 620)
    app.processEvents()
    assert workspace.twist_panel.isVisible()
    assert workspace.twist_panel.geometry().bottom() <= workspace.height()
    twist_narrow = artifacts / "mayacraft_twist_narrow_cn.png"
    assert window.grab().save(str(twist_narrow))
    window.resize(1120, 760)
    app.processEvents()
    workspace.undo_twist_profile()
    app.processEvents()
    assert workspace.twist_receipt is None
    assert "撤销验证通过" in workspace.twist_status.text()
    twist_undo = artifacts / "mayacraft_twist_undo_cn.png"
    assert window.grab().save(str(twist_undo))
    slerp = workspace.twist_service._slerp_nodes(cmds, "l_arm.twist.0")[0]
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft UI Twist Locked Probe")
    cmds.setAttr(f"{slerp}.inputT", lock=True)
    workspace.preview_twist_profile()
    app.processEvents()
    assert not workspace.pending_twist_plan.can_apply
    assert "预检阻断" in workspace.twist_status.text()
    twist_blocked = artifacts / "mayacraft_twist_blocked_cn.png"
    assert window.grab().save(str(twist_blocked))
    cmds.setAttr(f"{slerp}.inputT", lock=False)
    cmds.undoInfo(closeChunk=True)
    cmds.undo()
    workspace.hide_twist_panel()
    cmds.undo()

    cmds.undoInfo(openChunk=True, chunkName="MayaCraft UI Locked Match Probe")
    cmds.setAttr(ik_control + ".translateX", lock=True)
    workspace.preview_match("FK_TO_IK")
    app.processEvents()
    assert not workspace.pending_switch_plan.can_apply
    assert "预检阻断" in workspace.match_status.text()
    match_blocked = artifacts / "mayacraft_rig_match_blocked_cn.png"
    assert window.grab().save(str(match_blocked))
    cmds.setAttr(ik_control + ".translateX", lock=False)
    cmds.undoInfo(closeChunk=True)
    cmds.undo()

    verified = artifacts / "mayacraft_rig_graph_verified.png"
    assert window.grab().save(str(verified))
    workspace.undo_build()
    assert not workspace.service.scan(workspace.graph.graph_id)
    assert not workspace.service.scan_behaviors(workspace.graph.graph_id)
    cmds.rename("L_hand_JNT", "L_hand_RENAMED_JNT")
    missing_source_plan = workspace.service.plan(workspace.graph)
    assert any(item.code == "missing_source_joint" for item in missing_source_plan.blockers)

    window.resize(760, 620)
    app.processEvents()
    assert not workspace.summary.isVisible()
    assert not workspace.detail.isVisible()
    ordered = (workspace.diff, workspace.preview_button, workspace.apply_button, workspace.undo_button)
    for first, second in zip(ordered, ordered[1:]):
        assert first.geometry().bottom() < second.geometry().top(), (first.geometry(), second.geometry())
    narrow = artifacts / "mayacraft_rig_graph_narrow.png"
    assert window.grab().save(str(narrow))
    print(
        "MAYACRAFT_RIG_GRAPH_UI_OK", preview, verified, narrow,
        match_preview, match_verified, match_narrow, match_undo, match_blocked,
        twist_preview, twist_verified, twist_narrow, twist_undo, twist_blocked,
        bendy_preview, bendy_verified, bendy_narrow, bendy_undo, bendy_blocked,
    )
    window.shutdown()
    window.close()
    window.deleteLater()
    app.processEvents()
    del window
finally:
    maya.standalone.uninitialize()
