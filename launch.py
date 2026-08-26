"""MayaCraft's public Maya entry point.

Maya and Qt are imported only when :func:`run` is called. Package discovery,
documentation builds, and offline tests therefore remain usable outside Maya.
"""

from __future__ import annotations

import importlib
from typing import Any, Optional, Tuple


WORKSPACE_CONTROL = "MayaCraftWorkspaceControl"
_window: Optional[Any] = None


def _maya_modules() -> Tuple[Any, Any, Any, Any]:
    """Load Maya/Qt bindings with one actionable compatibility error."""
    try:
        import maya.OpenMayaUI as omui
        import maya.cmds as cmds
        from MayaCraft.compat.qt import QtWidgets, wrap_instance
    except ImportError as exc:
        raise RuntimeError(
            "MayaCraft currently targets Maya 2025 with PySide6."
        ) from exc
    return cmds, omui, wrap_instance, QtWidgets


def close() -> None:
    """Close the current MayaCraft panel if it exists."""
    global _window

    cmds, _omui, _wrap_instance, _QtWidgets = _maya_modules()
    if _window is not None:
        try:
            shutdown = getattr(_window, "shutdown", None)
            if callable(shutdown):
                shutdown()
            _window.setParent(None)
            _window.deleteLater()
        finally:
            _window = None

    if cmds.workspaceControl(WORKSPACE_CONTROL, exists=True):
        cmds.deleteUI(WORKSPACE_CONTROL, control=True)


def run(*, development: bool = False) -> Any:
    """Create and return the dockable MayaCraft panel.

    Args:
        development: Reload already imported ``MayaCraft`` modules first.
            Leave disabled for artist sessions; enable while editing source.
    """
    global _window

    cmds, omui, wrap_instance, QtWidgets = _maya_modules()
    close()

    if development:
        from MayaCraft.utils.reload_handler import reload_package

        reload_package("MayaCraft", exclude={__name__})

    main_window = importlib.import_module("MayaCraft.ui.main_window")
    cmds.workspaceControl(
        WORKSPACE_CONTROL,
        label="MayaCraft",
        retain=False,
        floating=True,
    )

    pointer = omui.MQtUtil.findControl(WORKSPACE_CONTROL)
    if pointer is None:
        cmds.deleteUI(WORKSPACE_CONTROL, control=True)
        raise RuntimeError(
            f"Maya created {WORKSPACE_CONTROL!r}, but its Qt control was not found."
        )

    dock_widget = wrap_instance(int(pointer), QtWidgets.QWidget)
    layout = dock_widget.layout()
    if layout is None:
        layout = QtWidgets.QVBoxLayout(dock_widget)
        layout.setContentsMargins(0, 0, 0, 0)

    _window = main_window.MayaCraftMainWindow(parent=dock_widget)
    layout.addWidget(_window)
    _window.show()
    return _window


show = run


if __name__ == "__main__":
    run()
