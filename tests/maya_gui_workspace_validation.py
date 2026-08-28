"""Real Maya GUI validation for workspaceControl and lifecycle behavior."""

from __future__ import annotations

import json
import os
import pathlib
import sys
import time
import traceback

import maya.cmds as cmds


REPO_ROOT = pathlib.Path(os.environ["MAYACRAFT_VALIDATION_ROOT"])
ARTIFACTS = REPO_ROOT / "tests" / "artifacts"
MAYA_VERSION = str(cmds.about(version=True)).split(".", 1)[0]
REPORT = ARTIFACTS / f"maya{MAYA_VERSION}_workspace_report.json"
SCREENSHOT = ARTIFACTS / f"maya{MAYA_VERSION}_workspace_gui.png"


def _write_report(payload):
    ARTIFACTS.mkdir(exist_ok=True)
    REPORT.write_text(json.dumps(payload, indent=2, ensure_ascii=False), encoding="utf-8")


def _quit(exit_code):
    cmds.quit(force=True, exitCode=exit_code)


def validate():
    validation_started = time.perf_counter()
    report = {
        "maya_version": cmds.about(version=True),
        "process_id": os.getpid(),
        "steps": [],
        "timings_ms": {},
    }
    try:
        package_parent = REPO_ROOT.parent
        sys.path.insert(0, str(package_parent))
        from MayaCraft import __version__ as plugin_version, launch
        from MayaCraft.compat.qt import QT_API, QtCore, QtWidgets

        report["qt_api"] = QT_API
        report["plugin_version"] = plugin_version
        cmds.file(new=True, force=True)
        root = cmds.createNode("transform", name="gui:CHARACTER")
        joint = cmds.createNode("joint", name="gui:root_JNT", parent=root)
        cmds.setAttr(joint + ".translateY", 5)
        child = cmds.createNode("joint", name="gui:spine_JNT", parent=joint)
        cmds.setAttr(child + ".translateY", 5)
        mesh = cmds.polyCube(name="gui:body_GEO", constructionHistory=False)[0]
        cmds.parent(mesh, root)
        control = cmds.circle(name="gui:main_CTRL", constructionHistory=False)[0]
        cmds.parent(control, root)
        cmds.select(child)

        started = time.perf_counter()
        first = launch.run(development=False)
        first.resize(980, 760)
        first_callback = first._watcher._callback_id
        assert first_callback is not None
        assert cmds.workspaceControl(launch.WORKSPACE_CONTROL, exists=True)
        report["steps"].append("initial_launch")
        report["timings_ms"]["initial_launch"] = round((time.perf_counter() - started) * 1000.0, 3)

        started = time.perf_counter()
        second = launch.run(development=False)
        second.resize(980, 760)
        assert first._watcher._callback_id is None
        second_callback = second._watcher._callback_id
        assert second_callback is not None and second_callback != first_callback
        assert cmds.workspaceControl(launch.WORKSPACE_CONTROL, exists=True)
        report["steps"].append("repeat_launch_cleanup")
        report["timings_ms"]["repeat_launch_cleanup"] = round((time.perf_counter() - started) * 1000.0, 3)

        started = time.perf_counter()
        third = launch.run(development=True)
        third.resize(980, 760)
        assert second._watcher._callback_id is None
        third_callback = third._watcher._callback_id
        assert third_callback is not None
        assert cmds.workspaceControl(launch.WORKSPACE_CONTROL, exists=True)
        report["steps"].append("development_hot_reload")
        report["timings_ms"]["development_hot_reload"] = round((time.perf_counter() - started) * 1000.0, 3)

        def capture_and_close():
            try:
                QtWidgets.QApplication.processEvents()
                assert third.grab().save(str(SCREENSHOT))
                report["screenshot"] = str(SCREENSHOT)
                report["character_root"] = third._snapshot.root
                report["rig_nodes"] = len(third._snapshot.rig_nodes)
                close_started = time.perf_counter()
                launch.close()
                assert third._watcher._callback_id is None
                assert not cmds.workspaceControl(launch.WORKSPACE_CONTROL, exists=True)
                report["steps"].append("close_cleanup")
                report["timings_ms"]["close_cleanup"] = round((time.perf_counter() - close_started) * 1000.0, 3)
                report["timings_ms"]["total_until_report"] = round((time.perf_counter() - validation_started) * 1000.0, 3)
                report["cleanup_verified"] = True
                report["passed"] = True
                _write_report(report)
                QtCore.QTimer.singleShot(0, lambda: _quit(0))
            except Exception:
                report["passed"] = False
                report["error"] = traceback.format_exc()
                _write_report(report)
                QtCore.QTimer.singleShot(0, lambda: _quit(1))

        QtCore.QTimer.singleShot(1000, capture_and_close)
    except Exception:
        report["passed"] = False
        report["error"] = traceback.format_exc()
        _write_report(report)
        cmds.evalDeferred(lambda: _quit(1))


cmds.evalDeferred(validate, lowestPriority=True)
