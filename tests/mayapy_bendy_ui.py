"""Focused Maya 2025 Qt render check for the production Bendy arc field."""

from __future__ import annotations

import pathlib

from MayaCraft.compat.qt import QtWidgets


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication([])
import maya.standalone

maya.standalone.initialize(name="python")

from MayaCraft.ui.rig_graph import BendyArcField, RigGraphWorkspace
from MayaCraft.ui.theme import stylesheet

app.setStyleSheet(stylesheet())

field = BendyArcField()
changes = []
field.intentChanged.connect(lambda *values: changes.append(values))
field.resize(760, 420)
field.show()
app.processEvents()

field.set_intent(0.27, -0.48, 0.74, 0.24)
field.set_volume_preservation(0.82)
app.processEvents()
arc = field.arc()
assert len(arc.samples) == 11
assert arc.arc_length > arc.chord_length
assert changes
assert field.accessibleName() == "可拖拽 Bendy 形变弧场"

artifacts = pathlib.Path(__file__).with_name("artifacts")
artifacts.mkdir(exist_ok=True)
wide = artifacts / "mayacraft_bendy_arc_field_cn.png"
assert field.grab().save(str(wide)), wide
showcase = pathlib.Path(__file__).parents[1] / "docs" / "images" / "bendy_arc_field_preview.png"
assert field.grab().save(str(showcase)), showcase

field.resize(330, 340)
field.set_preset("S")
app.processEvents()
assert field.minimumHeight() <= field.height()
assert all(left.normal[2] * right.normal[2] >= 0.0
           for left, right in zip(field.arc().samples, field.arc().samples[1:]))
narrow = artifacts / "mayacraft_bendy_arc_field_narrow_cn.png"
assert field.grab().save(str(narrow)), narrow

workspace = RigGraphWorkspace()
workspace.resize(760, 620)
workspace.active_limb = "l_arm"
workspace.show()
workspace.show_bendy_panel()
app.processEvents()
assert workspace.bendy_panel.isVisible()
assert not workspace.match_panel.isVisible()
assert not workspace.twist_panel.isVisible()
assert workspace.bendy_panel.geometry().bottom() <= workspace.height()
assert "左臂" in workspace.bendy_title.text()
assert "零写入轮廓" in workspace.bendy_status.text()
integrated = artifacts / "mayacraft_bendy_workspace_cn.png"
assert workspace.grab().save(str(integrated)), integrated

print("MAYACRAFT_BENDY_UI_OK", wide, narrow, integrated, showcase, f"arc={arc.arc_length:.4f}")
workspace.close()
workspace.deleteLater()
field.close()
field.deleteLater()
app.processEvents()
maya.standalone.uninitialize()
