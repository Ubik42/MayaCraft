"""Integrated Maya 2025 smoke test: UI preview -> transaction -> verification."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone
from PySide6 import QtTest


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
QtGui.QFontDatabase.addApplicationFont("C:/Windows/Fonts/segoeui.ttf")
maya.standalone.initialize(name="python")
window = None
try:
    import maya.cmds as cmds

    from MayaCraft.ui.main_window import MayaCraftMainWindow

    root = cmds.createNode("transform", name="pulse:CHARACTER")
    pelvis = cmds.createNode("joint", name="pulse:pelvis_JNT", parent=root)
    cmds.setAttr(pelvis + ".translateY", 8)
    spine = cmds.createNode("joint", name="pulse:spine_JNT", parent=pelvis)
    cmds.setAttr(spine + ".translateY", 3)
    chest = cmds.createNode("joint", name="pulse:chest_JNT", parent=spine)
    cmds.setAttr(chest + ".translateY", 3)
    neck = cmds.createNode("joint", name="pulse:neck_JNT", parent=chest)
    cmds.setAttr(neck + ".translateY", 2)
    head = cmds.createNode("joint", name="pulse:head_JNT", parent=neck)
    cmds.setAttr(head + ".translateY", 2)
    for side, direction in (("L", 1), ("R", -1)):
        shoulder = cmds.createNode("joint", name=f"pulse:{side}_shoulder_JNT", parent=chest)
        cmds.setAttr(shoulder + ".translate", direction * 2, 0.8, 0)
        elbow = cmds.createNode("joint", name=f"pulse:{side}_elbow_JNT", parent=shoulder)
        cmds.setAttr(elbow + ".translateX", direction * 3)
        wrist = cmds.createNode("joint", name=f"pulse:{side}_wrist_JNT", parent=elbow)
        cmds.setAttr(wrist + ".translateX", direction * 3)
        hip = cmds.createNode("joint", name=f"pulse:{side}_hip_JNT", parent=pelvis)
        cmds.setAttr(hip + ".translate", direction * 1.3, -1, 0)
        knee = cmds.createNode("joint", name=f"pulse:{side}_knee_JNT", parent=hip)
        cmds.setAttr(knee + ".translateY", -4)
        ankle = cmds.createNode("joint", name=f"pulse:{side}_ankle_JNT", parent=knee)
        cmds.setAttr(ankle + ".translateY", -4)
    mesh = cmds.polyCube(name="pulse:body_GEO", constructionHistory=False)[0]
    cmds.parent(mesh, root)
    control = cmds.circle(name="pulse:main_CTRL", constructionHistory=False)[0]
    cmds.parent(control, root)
    skin_influences = [pelvis, spine, chest]
    skin_influences.extend(cmds.ls("pulse:*_shoulder_JNT")[:2])
    skin = cmds.skinCluster(*skin_influences, mesh, toSelectedBones=True, normalizeWeights=0)[0]
    cmds.setAttr(skin + ".normalizeWeights", 0)
    cmds.skinPercent(skin, mesh + ".vtx[0]", transformValue=((pelvis, 0.25), (spine, 0.25)), normalize=False)
    cmds.skinPercent(
        skin,
        mesh + ".vtx[1]",
        transformValue=tuple((joint, 0.2) for joint in skin_influences),
        normalize=False,
    )

    echo_root = cmds.createNode("transform", name="echo:CHARACTER")
    cmds.createNode("joint", name="echo:root_JNT", parent=echo_root)
    cmds.addAttr(echo_root, longName="mayacraftCharacter", attributeType="bool")
    cmds.setAttr(echo_root + ".mayacraftCharacter", True)
    cmds.addAttr(echo_root, longName="mayacraftCharacterId", dataType="string")
    cmds.setAttr(echo_root + ".mayacraftCharacterId", "ECHO-DEMO", type="string")
    cmds.addAttr(echo_root, longName="mayacraftSchemaVersion", attributeType="long")
    cmds.setAttr(echo_root + ".mayacraftSchemaVersion", 1)
    cmds.select(head)

    window = MayaCraftMainWindow()
    window.resize(980, 760)
    window.show()
    app.processEvents()
    assert {item.stable_id for item in window._session.characters} == {
        window._snapshot.stable_id,
        "ECHO-DEMO",
    }
    window.pin_button.click()
    assert next(item for item in window._session.characters if item.stable_id == window._snapshot.stable_id).pinned
    echo_point = window.character_orbit.hit_point("ECHO-DEMO")
    assert echo_point is not None
    QtTest.QTest.mouseClick(window.character_orbit, QtCore.Qt.LeftButton, pos=echo_point)
    switch_loop = QtCore.QEventLoop()
    QtCore.QTimer.singleShot(120, switch_loop.quit)
    switch_loop.exec()
    assert window._snapshot.stable_id == "ECHO-DEMO"
    pulse_point = window.character_orbit.hit_point(next(item.stable_id for item in window._session.characters if item.pinned))
    assert pulse_point is not None
    QtTest.QTest.mouseClick(window.character_orbit, QtCore.Qt.LeftButton, pos=pulse_point)
    switch_back_loop = QtCore.QEventLoop()
    QtCore.QTimer.singleShot(120, switch_back_loop.quit)
    switch_back_loop.exec()
    assert window._snapshot.root == cmds.ls(root, long=True)[0]
    arm_point = window.stage.module_hit_point("arm")
    assert arm_point is not None
    QtTest.QTest.mouseClick(window.stage, QtCore.Qt.LeftButton, pos=arm_point)
    app.processEvents()
    assert window.stage.focused_module == "arm"
    assert window.stage.module_health("arm").score == 100
    wrist_path = next(node.path for node in window._snapshot.rig_nodes if node.name.endswith("L_wrist_JNT"))
    wrist_point = window.stage.hit_point(wrist_path)
    assert wrist_point is not None
    # Background mayapy has no reliable OS cursor. Drive the widget's hover
    # state through its Qt-owned path; the following click remains a real event.
    window.stage._set_hovered_path(wrist_path)
    assert window.stage._hovered_path == wrist_path
    QtTest.QTest.mouseClick(window.stage, QtCore.Qt.LeftButton, pos=wrist_point)
    assert cmds.ls(selection=True, long=True)[0] == wrist_path
    sync_loop = QtCore.QEventLoop()
    QtCore.QTimer.singleShot(120, sync_loop.quit)
    sync_loop.exec()
    assert any(node.path == wrist_path and node.selected for node in window._snapshot.rig_nodes)
    original_id = window._snapshot.stable_id
    window.preview_registration()
    assert window._pending_plan is not None and window._pending_plan.can_apply
    loop = QtCore.QEventLoop()
    QtCore.QTimer.singleShot(280, loop.quit)
    loop.exec()
    window.apply_registration()
    app.processEvents()

    assert window._snapshot.registered
    assert window._snapshot.stable_id == original_id
    assert cmds.getAttr(root + ".mayacraftCharacter") is True
    assert cmds.getAttr(root + ".mayacraftCharacterId") == original_id
    assert cmds.getAttr(root + ".mayacraftSchemaVersion") == 1
    assert window.apply_button.text() == "验证通过"
    assert window.change_capsule.maximumHeight() == 176
    output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_maya2025_verified_workspace.png"
    output.parent.mkdir(exist_ok=True)
    assert window.grab().save(str(output)), output
    window.show_deformation()
    window.deformation_workspace.scan()
    app.processEvents()
    mri_result = window.deformation_workspace.result
    assert mri_result is not None and len(mri_result.report.vertices) == 8
    assert mri_result.report.normalization_count >= 1
    vertex_point = window.deformation_workspace.heatmap.hit_point(0)
    assert vertex_point is not None
    window.deformation_workspace.heatmap.vertexActivated.emit(0)
    assert cmds.ls(selection=True, flatten=True)[0].endswith(".vtx[0]")
    mri_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_maya2025.png"
    assert window.grab().save(str(mri_output)), mri_output
    window.deformation_workspace.preview_repair()
    assert window.deformation_workspace._repair_plan.can_apply
    assert "零写入" in window.deformation_workspace.repair_status.text()
    window.deformation_workspace.apply_repair()
    app.processEvents()
    assert window.deformation_workspace._repair_receipt.verified
    assert window.deformation_workspace.result.report.normalization_count == 0
    repair_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_repair_verified.png"
    assert window.grab().save(str(repair_output)), repair_output
    window.deformation_workspace.undo_repair()
    app.processEvents()
    assert window.deformation_workspace.result.report.normalization_count >= 1
    assert "撤销验证通过" in window.deformation_workspace.repair_status.text()
    window.resize(720, 520)
    app.processEvents()
    narrow_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_narrow.png"
    assert window.grab().save(str(narrow_output)), narrow_output
    print("MAYACRAFT_WORKFLOW_OK", original_id, output, mri_output, repair_output, narrow_output)
finally:
    if window is not None:
        window.shutdown()
        window.close()
    maya.standalone.uninitialize()
