"""Offscreen Maya 2025 UI validation for semantic Retarget Ghost workspace."""

from __future__ import annotations

import pathlib
import sys
import tempfile

import maya.standalone
from PySide6 import QtTest


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
from MayaCraft.compat.qt import QtCore, QtWidgets
from MayaCraft.domain.clip_package import ClipPackage


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
maya.standalone.initialize(name="python")
window = None
temporary = tempfile.TemporaryDirectory()
try:
    import maya.cmds as cmds

    from MayaCraft.ui.main_window import MayaCraftMainWindow

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
    target_joints, _target_pelvis = skeleton("target", 1.65)
    source_hand = next(path for path in source_joints if path.endswith("source:L_hand_JNT"))
    source_feet = tuple(path for path in source_joints if path.endswith(("source:L_foot_JNT", "source:R_foot_JNT")))
    target_hand = next(path for path in target_joints if path.endswith("target:L_hand_JNT"))
    target_before = tuple(tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints)

    cmds.select(source_hand)
    window = MayaCraftMainWindow()
    window.resize(1120, 760)
    window.show()
    window.show_retarget()
    workspace = window.retarget_workspace
    workspace.source_button.click()
    app.processEvents()
    assert workspace.source and workspace.source.is_usable
    cmds.select(target_hand)
    workspace.target_button.click()
    app.processEvents()
    assert workspace.profile and workspace.profile.can_preview
    assert len(workspace.profile.mappings) == 18
    assert 1.6 < workspace.profile.scale_ratio < 1.7
    axis_index = workspace.axis_combo.findData("z_forward_to_x_forward")
    assert axis_index >= 0 and workspace.axis_combo.isEnabled()
    workspace.axis_combo.setCurrentIndex(axis_index)
    app.processEvents()
    assert workspace.profile.axis_template.template_id == "z_forward_to_x_forward"
    assert "轴空间已切换" in workspace.summary.text()
    assert tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    ) == target_before

    mapping_point = workspace.stage.mapping_hit_point("left_hand")
    assert mapping_point is not None
    workspace.stage._hovered = "left_hand"
    QtTest.QTest.mouseClick(workspace.stage, QtCore.Qt.LeftButton, pos=mapping_point)
    app.processEvents()
    selected = tuple(cmds.ls(selection=True, long=True) or ())
    assert set(selected) == {source_hand, target_hand}

    cmds.setAttr(source_pelvis + ".translateX", cmds.getAttr(source_pelvis + ".translateX") + 1.0)
    cmds.setAttr(source_hand + ".rotateZ", 52.0)
    cmds.select(source_hand)
    workspace.preview_button.click()
    app.processEvents()
    assert workspace.preview and len(workspace.preview.signals) == 18
    assert "零写入 Ghost" in workspace.summary.text()
    target_after = tuple(tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints)
    assert target_after == target_before
    artifacts = pathlib.Path(__file__).with_name("artifacts")
    artifacts.mkdir(exist_ok=True)
    preview_output = artifacts / "mayacraft_retarget_ghost_cn.png"
    assert window.grab().save(str(preview_output)), preview_output
    axis_output = artifacts / "mayacraft_retarget_axis_template_cn.png"
    assert window.grab().save(str(axis_output)), axis_output

    for frame, root_x, hand_z in ((1, 0.0, 0.0), (3, 1.0, 26.0), (5, 2.0, 52.0)):
        cmds.setKeyframe(source_pelvis, attribute="translateX", time=frame, value=root_x)
        cmds.setKeyframe(source_hand, attribute="rotateZ", time=frame, value=hand_z)
        for foot in source_feet:
            cmds.setKeyframe(foot, attribute="translateX", time=frame, value=-root_x)
    cmds.playbackOptions(minTime=1, maxTime=5)
    workspace.clip_button.click()
    app.processEvents()
    assert workspace.source_clip and len(workspace.source_clip.frames) == 5
    assert workspace.clip_preview and len(workspace.clip_preview.signals) == 5
    assert len(workspace.clip_preview.contacts) == 2
    assert workspace.clip_preview.contact_preservation == 1.0
    source_package_path = pathlib.Path(temporary.name) / "源动作.mayaclip"
    workspace._clip_store.write(
        source_package_path,
        ClipPackage(workspace.source_clip, workspace.source_reference),
    )
    damaged_package_path = pathlib.Path(temporary.name) / "损坏动作.mayaclip"
    damaged_package_path.write_text("{not-json", encoding="utf-8")
    workspace.show_clip_browser(temporary.name)
    app.processEvents()
    assert workspace.clip_browser.isVisible() and not workspace.stage.isVisible()
    assert workspace.clip_browser.last_scan.scanned_files == 2
    assert workspace.clip_browser.last_scan.invalid_files == 1
    assert workspace.clip_browser.asset_list.count() == 2
    clip_browser_output = artifacts / "mayacraft_clip_library_cn.png"
    assert window.grab().save(str(clip_browser_output)), clip_browser_output
    workspace.clip_browser.search.setText("源")
    app.processEvents()
    assert workspace.clip_browser.select_path(source_package_path)
    assert workspace.clip_browser.load_button.isEnabled()
    workspace.clip_browser.load_button.click()
    app.processEvents()
    assert not workspace.clip_browser.isVisible() and workspace.stage.isVisible()
    assert workspace.loaded_clip_package
    assert workspace.source_clip.fingerprint == workspace.loaded_clip_package.clip.fingerprint
    assert "资产 源动作.mayaclip" in workspace.layer_status.text()
    last_point = workspace.timeline.hit_point(4)
    assert last_point is not None
    workspace.timeline._hovered = 4
    QtTest.QTest.mouseClick(workspace.timeline, QtCore.Qt.LeftButton, pos=last_point)
    app.processEvents()
    assert cmds.currentTime(query=True) == 5.0
    assert workspace.preview.frame.frame == 5.0
    workspace.preview_layer_button.click()
    assert workspace.layer_plan and workspace.layer_plan.can_apply
    assert "零写入计划" in workspace.layer_status.text()
    workspace.apply_layer_button.click()
    app.processEvents()
    assert workspace.layer_receipt and workspace.layer_receipt.verified
    assert not workspace.axis_combo.isEnabled()
    assert cmds.objExists(workspace.layer_receipt.layer_name)
    assert workspace.result_validation
    assert workspace.result_validation.maximum_rotation_error_degrees < 0.1, workspace.result_validation
    assert workspace.result_validation.maximum_position_error > 1.0
    assert workspace.result_validation.contact_preservation == 0.0
    assert workspace.ik_preview_button.isEnabled()
    layer_output = artifacts / "mayacraft_retarget_clip_layer_verified_cn.png"
    assert window.grab().save(str(layer_output)), layer_output

    target_after_layer = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    )
    workspace.slope_spin.setValue(8.0)
    workspace.ik_preview_button.click()
    app.processEvents()
    assert workspace.contact_ik_preview
    assert workspace.contact_ik_preview.solved_count == 10
    assert workspace.contact_ik_preview.unreachable_count == 0
    assert workspace.contact_ik_preview.maximum_error < 1e-4
    assert 0.01 < workspace.contact_ik_preview.maximum_pelvis_offset < 2.0, (
        workspace.contact_ik_preview.maximum_pelvis_offset
    )
    assert abs(workspace.contact_ik_preview.maximum_ground_angle_degrees - 8.0) < 1e-5
    assert "零写入全身约束预览" in workspace.ik_status.text()
    target_after_ik_preview = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    )
    assert target_after_ik_preview == target_after_layer
    window.grab()
    app.processEvents()
    anchor_point = workspace.stage.anchor_hit_point("left")
    assert anchor_point is not None
    workspace.stage._hovered_anchor = "left"
    QtTest.QTest.mousePress(workspace.stage, QtCore.Qt.LeftButton, pos=anchor_point)
    QtTest.QTest.mouseMove(workspace.stage, anchor_point + QtCore.QPoint(7, -4))
    QtTest.QTest.mouseRelease(
        workspace.stage, QtCore.Qt.LeftButton,
        pos=anchor_point + QtCore.QPoint(7, -4),
    )
    app.processEvents()
    left_offset = workspace.contact_ik_settings.anchor_offset("left")
    assert left_offset[0] > 0.0 and left_offset[1] > 0.0
    assert workspace.contact_ik_plan is None
    assert workspace.ik_plan_button.isEnabled()
    assert "目标 Maya 骨架未修改" in workspace.ik_status.text()
    target_after_anchor_drag = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True))
        for path in target_joints
    )
    assert target_after_anchor_drag == target_after_layer
    ik_output = artifacts / "mayacraft_retarget_contact_ik_preview_cn.png"
    assert window.grab().save(str(ik_output)), ik_output

    workspace.ik_plan_button.click()
    assert workspace.contact_ik_plan and workspace.contact_ik_plan.can_apply
    assert len(workspace.contact_ik_plan.keys) == 40
    assert "零写入 IK 层计划" in workspace.ik_status.text()
    workspace.ik_apply_button.click()
    app.processEvents()
    assert workspace.contact_ik_receipt and workspace.contact_ik_receipt.verified, (
        workspace.ik_status.text()
    )
    assert workspace.contact_ik_receipt.maximum_anchor_error < 0.02
    assert cmds.objExists(workspace.contact_ik_receipt.layer_name)
    assert workspace.result_validation.contact_preservation == 1.0
    ik_verified_output = artifacts / "mayacraft_retarget_contact_ik_verified_cn.png"
    assert window.grab().save(str(ik_verified_output)), ik_verified_output
    export_path = pathlib.Path(temporary.name) / "已验证重定向结果.mayaclip"
    export_receipt = workspace.export_result_clip(export_path)
    assert export_receipt and export_receipt.verified
    exported = workspace._clip_store.read(export_path, allow_legacy=False)
    assert exported.package_version == 2
    assert exported.coordinate_forward == "+X"
    assert "重定向结果" in exported.tags
    assert exported.clip.fingerprint == workspace.corrected_clip.fingerprint
    assert dict(exported.metadata)["包含接触IK"] == "是"
    assert dict(exported.metadata)["轴模板ID"] == "z_forward_to_x_forward"
    assert dict(exported.metadata)["地面法线"] != "0.000000,1.000000,0.000000"
    assert dict(exported.metadata)["脚底锚点偏移"] != "无"
    window.resize(760, 620)
    app.processEvents()
    assert workspace.stage.geometry().bottom() < workspace.timeline.geometry().top()
    assert workspace.timeline.geometry().bottom() < workspace.contact_tuning_strip.geometry().top()
    assert workspace.contact_tuning_strip.geometry().bottom() < workspace.transaction_capsule.geometry().top()
    assert workspace.transaction_capsule.geometry().bottom() < workspace.ik_transaction_capsule.geometry().top()
    narrow_output = artifacts / "mayacraft_retarget_ghost_narrow_cn.png"
    assert window.grab().save(str(narrow_output)), narrow_output
    workspace.ik_undo_button.click()
    app.processEvents()
    assert not cmds.objExists("MayaCraft_ContactIK_root_JNT")
    restored_after_ik = tuple(
        tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints
    )
    ik_restore_error = max(
        abs(left - right)
        for left_matrix, right_matrix in zip(restored_after_ik, target_after_layer)
        for left, right in zip(left_matrix, right_matrix)
    )
    assert ik_restore_error < 1e-9, ik_restore_error
    workspace.undo_layer_button.click()
    app.processEvents()
    assert workspace.axis_combo.isEnabled()
    assert not cmds.objExists("MayaCraft_Retarget_root_JNT")
    restored_target = tuple(tuple(cmds.xform(path, query=True, worldSpace=True, matrix=True)) for path in target_joints)
    assert restored_target == target_before
    print(
        "MAYACRAFT_RETARGET_UI_OK",
        preview_output, axis_output, clip_browser_output, layer_output,
        ik_output, ik_verified_output, narrow_output,
    )
finally:
    if window is not None:
        window.shutdown()
        window.close()
    maya.standalone.uninitialize()
    temporary.cleanup()
