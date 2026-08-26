"""Standalone PySide6 smoke test for the Maya 2025 UI surface."""

from __future__ import annotations

import pathlib
import sys

from PySide6 import QtCore, QtGui, QtWidgets


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))

from MayaCraft.adapters.maya.character_context import MayaCharacterScanner, MayaSelectionWatcher
from MayaCraft.adapters.maya.character_registration import CharacterRegistrationService
from MayaCraft.domain.character import CharacterSnapshot
from MayaCraft.domain.change import AttributeChange, CharacterRegistrationPlan


snapshot = CharacterSnapshot(
    stable_id="6E2C88A14B",
    display_name="AURA / RIG",
    root="|aura:CHARACTER",
    namespace="aura",
    joint_count=76,
    mesh_count=9,
    control_count=58,
    skin_cluster_count=6,
    score=96,
    referenced=False,
    message="Captured aura:CHARACTER from the live Maya selection.",
)
MayaCharacterScanner.capture_selection = lambda _self: snapshot
MayaSelectionWatcher.start = lambda _self: None
MayaSelectionWatcher.stop = lambda _self: None
CharacterRegistrationService.plan = lambda _self, _snapshot: CharacterRegistrationPlan(
    _snapshot.root,
    _snapshot.stable_id,
    changes=(
        AttributeChange("mayacraftCharacter", "Character marker", None, True, "bool"),
        AttributeChange("mayacraftCharacterId", "Stable character ID", None, _snapshot.stable_id, "string"),
        AttributeChange("mayacraftSchemaVersion", "Schema version", None, 1, "long"),
    ),
)

from MayaCraft.compat.qt import QT_API
from MayaCraft.ui.main_window import MayaCraftMainWindow


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
QtGui.QFontDatabase.addApplicationFont("C:/Windows/Fonts/segoeui.ttf")
window = MayaCraftMainWindow()
window.resize(980, 760)
window.show()
app.processEvents()
window.preview_registration()
loop = QtCore.QEventLoop()
QtCore.QTimer.singleShot(280, loop.quit)
loop.exec()
output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_pyside6_workspace.png"
output.parent.mkdir(exist_ok=True)
assert QT_API == "PySide6"
assert window.grab().save(str(output)), output
assert window.character_name.text() == "AURA / RIG"
assert window.metrics["controls"].value.text() == "58"
assert window.change_capsule.maximumHeight() == 176
window.resize(720, 520)
app.processEvents()
narrow_output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_pyside6_narrow.png"
assert window.grab().save(str(narrow_output)), narrow_output
assert window.inspector_scroll.horizontalScrollBar().maximum() == 0
print("MAYACRAFT_QT6_OK", output)
window.shutdown()
window.close()
