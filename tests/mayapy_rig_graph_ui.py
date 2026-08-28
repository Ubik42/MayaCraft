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
    assert "73 个对象" in workspace.diff.text(), workspace.diff.text()
    assert "34 条物理行为" in workspace.diff.text(), workspace.diff.text()
    # A real OS cursor is unavailable in background mayapy. Exercise the same
    # Qt signal path deterministically instead of depending on desktop focus.
    workspace.canvas.moduleHovered.emit("root")
    app.processEvents()
    assert "角色根" in workspace.detail.text(), workspace.detail.text()

    artifacts = pathlib.Path(__file__).with_name("artifacts")
    artifacts.mkdir(exist_ok=True)
    preview = artifacts / "mayacraft_rig_graph_preview.png"
    assert window.grab().save(str(preview))
    workspace.apply_plan()
    app.processEvents()
    assert workspace.plan.is_noop
    assert workspace.receipt and workspace.receipt.verified
    assert len(workspace.service.scan_behaviors(workspace.graph.graph_id)) == 34
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
    )
    window.shutdown()
    window.close()
    window.deleteLater()
    app.processEvents()
    del window
finally:
    maya.standalone.uninitialize()
