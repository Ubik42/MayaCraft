"""Offscreen UI smoke test using Maya 2025's bundled PySide6 runtime."""

from __future__ import annotations

import pathlib
import sys
import maya.standalone

package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets

from MayaCraft.adapters.maya.character_context import MayaCharacterScanner, MayaSelectionWatcher
from MayaCraft.adapters.maya.character_registration import CharacterRegistrationService
from MayaCraft.domain.character import CharacterSnapshot, NodeSummary
from MayaCraft.domain.change import AttributeChange, CharacterRegistrationPlan


snapshot = CharacterSnapshot(
    stable_id="74A0C91E2F",
    display_name="NOVA / HERO",
    root="|nova:CHARACTER",
    namespace="nova",
    selected=(NodeSummary("spine_JNT", "|nova:CHARACTER|spine_JNT", "joint"),),
    joint_count=68,
    mesh_count=7,
    control_count=42,
    skin_cluster_count=5,
    score=92,
    message="Captured nova:CHARACTER from the live Maya selection.",
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

from MayaCraft.ui.main_window import MayaCraftMainWindow


app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
QtGui.QFontDatabase.addApplicationFont("C:/Windows/Fonts/segoeui.ttf")
maya.standalone.initialize(name="python")
window = MayaCraftMainWindow()
window.resize(980, 760)
window.show()
app.processEvents()
window.preview_registration()
loop = QtCore.QEventLoop()
QtCore.QTimer.singleShot(280, loop.quit)
loop.exec()
output = pathlib.Path(__file__).with_name("artifacts") / "mayacraft_maya2025_character_workspace.png"
output.parent.mkdir(exist_ok=True)
assert window.grab().save(str(output)), output
assert window.character_name.text() == "NOVA / HERO"
assert window.metrics["joints"].value.text() == "68"
assert window.change_capsule.maximumHeight() == 176
print("MAYACRAFT_UI_OK", output)
window.shutdown()
window.close()
window.deleteLater()
app.processEvents()
del window
maya.standalone.uninitialize()
