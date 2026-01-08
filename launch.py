# -*- coding: utf-8 -*-
import sys
from importlib import reload
import maya.cmds as cmds
import maya.OpenMayaUI as omui
import shiboken6
from PySide6 import QtWidgets

from ui import main_window

# --- 重载逻辑 (保持不变) ---
from utils import reload_handler

reload(reload_handler)
PACKAGES_TO_RELOAD = ["core", "ui", "utils"]
for pkg_name in PACKAGES_TO_RELOAD:
    if pkg_name in sys.modules:
        reload_handler.reload_package(pkg_name)


# --- 运行入口 ---
def run():
    workspace_control_name = "MayaCraftWorkspaceControl"

    # 1. 彻底清除旧的
    if cmds.workspaceControl(workspace_control_name, exists=True):
        cmds.deleteUI(workspace_control_name)

    # 2. 创建 Maya 面板
    cmds.workspaceControl(workspace_control_name,
                          label="MayaCraft",
                          uiScript="pass",
                          retain=False,
                          floating=True)

    # 3. 获取指针并转换
    ptr = omui.MQtUtil.findControl(workspace_control_name)
    maya_dock_widget = shiboken6.wrapInstance(int(ptr), QtWidgets.QWidget)

    # 4. 获取或创建布局
    if maya_dock_widget.layout() is None:
        layout = QtWidgets.QVBoxLayout(maya_dock_widget)
        layout.setContentsMargins(0, 0, 0, 0)
    else:
        layout = maya_dock_widget.layout()

    # 5. 实例化你的窗口 (现在它是 QWidget，非常安全)
    app = main_window.MayaCraftMainWindow(parent=maya_dock_widget)

    # 6. 添加进布局
    layout.addWidget(app)

    # 7. 只要父级显示了，子级默认也会显示，但显式调用一下更保险
    app.show()

    return app


if __name__ == "__main__":
    run()