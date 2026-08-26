"""Maya 2025 offscreen validation for spatial MRI heat field and local brush selection."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone
from PySide6 import QtTest


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
from MayaCraft.compat.qt import QtCore, QtWidgets


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
maya.standalone.initialize(name="python")
window = None
try:
    import maya.cmds as cmds

    from MayaCraft.adapters.maya.character_context import MayaCharacterScanner
    from MayaCraft.ui.main_window import MayaCraftMainWindow

    root = cmds.createNode("transform", name="MRI_DEMO_CHARACTER")
    left = cmds.createNode("joint", name="L_field_JNT", parent=root)
    right = cmds.createNode("joint", name="R_field_JNT", parent=root)
    cmds.setAttr(left + ".translateX", -2.0)
    cmds.setAttr(right + ".translateX", 2.0)
    mesh = cmds.polyPlane(
        name="MRI_field_GEO", width=8, height=8, subdivisionsX=12, subdivisionsY=12
    )[0]
    cmds.parent(mesh, root)
    skin = cmds.skinCluster(left, right, mesh, toSelectedBones=True, normalizeWeights=1)[0]
    cmds.setAttr(
        skin + ".matrix[7]",
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
        type="matrix",
    )
    cmds.setAttr(left + ".liw", True)
    cmds.select(mesh)
    snapshot = MayaCharacterScanner().capture_selection()

    window = MayaCraftMainWindow()
    window.resize(1100, 780)
    window.show()
    window.deformation_workspace.set_snapshot(snapshot)
    window.show_deformation()
    window.deformation_workspace.scan()
    app.processEvents()

    result = window.deformation_workspace.result
    heatmap = window.deformation_workspace.heatmap
    assert result is not None and len(result.vertex_positions) == 169
    assert result.triangles and heatmap._projection.triangles
    locked_diagnostic = next(item for item in result.inspector.influences if item.locked)
    assert locked_diagnostic.path.endswith("L_field_JNT")
    assert result.inspector.locked_vertices
    assert result.inspector.missing_influences == ("matrix[7]",)

    window.deformation_workspace.inspector_mode_buttons["entropy"].click()
    app.processEvents()
    assert heatmap.mode == "entropy"
    assert "平均熵" in window.deformation_workspace.inspector_summary.text()
    entropy_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_entropy_cn.png"
    entropy_output.parent.mkdir(exist_ok=True)
    assert window.grab().save(str(entropy_output)), entropy_output

    window.deformation_workspace.inspector_mode_buttons["locked"].click()
    app.processEvents()
    assert heatmap.mode == "locked"
    assert "锁定影响" in window.deformation_workspace.inspector_summary.text()
    assert "矩阵空洞" in window.deformation_workspace.inspector_summary.text()
    locked_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_locked_cn.png"
    assert window.grab().save(str(locked_output)), locked_output

    spectrum_point = window.deformation_workspace.influence_spectrum.hit_point(locked_diagnostic.index)
    assert spectrum_point is not None
    QtTest.QTest.mouseMove(window.deformation_workspace.influence_spectrum, spectrum_point)
    QtTest.QTest.mouseClick(
        window.deformation_workspace.influence_spectrum,
        QtCore.Qt.LeftButton,
        pos=spectrum_point,
    )
    app.processEvents()
    assert heatmap.mode == "dominant"
    assert cmds.ls(selection=True, long=True)[0] == locked_diagnostic.path
    center_index = min(
        heatmap._projection.vertices,
        key=lambda item: item.x * item.x + item.y * item.y,
    ).index
    center = heatmap.hit_point(center_index)
    assert center is not None
    QtTest.QTest.mouseMove(heatmap, center)
    QtTest.QTest.mousePress(heatmap, QtCore.Qt.LeftButton, QtCore.Qt.ShiftModifier, center)
    target = center + QtCore.QPoint(10, 5)
    QtTest.QTest.mouseMove(heatmap, target, delay=20)
    QtTest.QTest.mouseRelease(
        heatmap, QtCore.Qt.LeftButton, QtCore.Qt.ShiftModifier, target
    )
    app.processEvents()
    selected = cmds.ls(selection=True, flatten=True) or []
    assert len(selected) > 1, selected
    assert all(".vtx[" in item for item in selected)
    assert "刷选" in window.status_text.text()

    output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_spatial_brush_cn.png"
    assert window.grab().save(str(output)), output
    window.resize(760, 620)
    app.processEvents()
    narrow_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_mri_inspector_narrow_cn.png"
    assert window.grab().save(str(narrow_output)), narrow_output
    print(
        "MAYACRAFT_MRI_SPATIAL_UI_OK", len(selected), output,
        entropy_output, locked_output, narrow_output,
    )
finally:
    if window is not None:
        window.shutdown()
        window.close()
    maya.standalone.uninitialize()
