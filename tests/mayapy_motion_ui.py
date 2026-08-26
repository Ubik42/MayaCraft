"""Maya 2025 offscreen PySide6 validation for Motion Magnetism."""

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

    cmds.currentUnit(time="film")
    cmds.playbackOptions(minTime=1, maxTime=25)
    control = cmds.circle(name="magnet:hand_CTRL", constructionHistory=False)[0]
    for frame, position in (
        (1, (0.0, 0.0, 0.0)),
        (7, (0.0, 0.0, 0.0)),
        (13, (7.0, 6.0, 2.0)),
        (19, (15.0, 0.0, -1.0)),
        (25, (15.0, 0.0, -1.0)),
    ):
        for attribute, value in zip(("translateX", "translateY", "translateZ"), position):
            cmds.setKeyframe(control, attribute=attribute, time=frame, value=value)
    cmds.setKeyframe(control, attribute="rotateY", time=1, value=0.0)
    cmds.setKeyframe(control, attribute="rotateY", time=12, value=15.0)
    cmds.setKeyframe(control, attribute="rotateY", time=13, value=145.0)
    cmds.setKeyframe(control, attribute="rotateY", time=25, value=160.0)
    cmds.keyTangent(control, inTangentType="linear", outTangentType="linear")
    cmds.select(control)
    cmds.currentTime(13)

    window = MayaCraftMainWindow()
    window.resize(980, 760)
    window.show()
    window.show_motion()
    cmds.select(clear=True)
    window.motion_workspace.capture_selection()
    assert window.motion_workspace.capture_result is None
    assert "捕获安全失败" in window.motion_workspace.readout.text()
    cmds.select(control)
    window.motion_workspace.capture_selection()
    app.processEvents()
    capture = window.motion_workspace.capture_result
    assert capture is not None and len(capture.samples) == 25
    assert len(capture.analysis.contacts) >= 2
    assert capture.analysis.rotation_jump_count >= 1
    assert cmds.currentTime(query=True) == 13
    window.motion_workspace.set_baseline()
    assert window.motion_workspace._baseline is capture
    cmds.setKeyframe(control, attribute="translateY", time=13, value=8.0)
    cmds.setKeyframe(control, attribute="translateX", time=1, value=1.0)
    cmds.setKeyframe(control, attribute="translateX", time=7, value=1.0)
    window.motion_workspace.capture_selection()
    app.processEvents()
    capture = window.motion_workspace.capture_result
    comparison = window.motion_workspace._comparison
    assert comparison is not None and comparison.maximum_position_error >= 1.99
    assert "位置 RMS" in window.motion_workspace.comparison_readout.text()

    contact_point = window.motion_workspace.canvas.hit_point(2)
    assert contact_point is not None
    QtTest.QTest.mouseMove(window.motion_workspace.canvas, contact_point)
    app.processEvents()
    assert window.motion_workspace.preview_anchor_button.isEnabled()
    window.motion_workspace.preview_anchor()
    assert window.motion_workspace._anchor_plan.can_apply
    artifacts = pathlib.Path(__file__).with_name("artifacts")
    artifacts.mkdir(exist_ok=True)
    anchor_preview = artifacts / "mayacraft_motion_anchor_preview.png"
    assert window.grab().save(str(anchor_preview)), anchor_preview
    window.motion_workspace.apply_anchor()
    app.processEvents()
    receipt = window.motion_workspace._anchor_receipt
    assert receipt is not None and receipt.verified and cmds.objExists(receipt.layer_name)
    anchor_verified = artifacts / "mayacraft_motion_anchor_verified.png"
    assert window.grab().save(str(anchor_verified)), anchor_verified
    window.motion_workspace.undo_anchor()
    assert not cmds.objExists(receipt.layer_name)
    assert "撤销验证通过" in window.motion_workspace.anchor_status.text()

    signal_index = 9
    signal_point = window.motion_workspace.canvas.hit_point(signal_index)
    assert signal_point is not None
    QtTest.QTest.mouseMove(window.motion_workspace.canvas, signal_point)
    app.processEvents()
    assert window.motion_workspace.canvas._hovered_index == signal_index
    QtTest.QTest.mouseClick(window.motion_workspace.canvas, QtCore.Qt.LeftButton, pos=signal_point)
    assert cmds.currentTime(query=True) == capture.samples[signal_index].frame

    wide = artifacts / "mayacraft_motion_magnetism.png"
    assert window.grab().save(str(wide)), wide
    window.resize(720, 520)
    app.processEvents()
    narrow = artifacts / "mayacraft_motion_magnetism_narrow.png"
    assert window.grab().save(str(narrow)), narrow
    print("MAYACRAFT_MOTION_UI_OK", wide, narrow, anchor_preview, anchor_verified)
finally:
    if window is not None:
        window.shutdown()
        window.close()
    maya.standalone.uninitialize()
