# -*- coding: utf-8 -*-
import os
import sys
from PySide6 import QtWidgets

import maya.mel as mel

# --- 1. 项目路径设置 ---
# 这里必要必要必要，最稳妥的方法
PROJECT_ROOT = 'F:/05 3D/Maya/Python/MyWork/MayaCraft'
if not os.path.exists(PROJECT_ROOT):
    raise FileNotFoundError(f"错误：项目路径不存在！请检查路径拼写:\n{PROJECT_ROOT}")
if PROJECT_ROOT not in sys.path:
    sys.path.append(PROJECT_ROOT)

# --- 2. 导入我们的重载处理器 ---
from utils import reload_handler
# 在开发时，甚至 reload_handler 本身也可能被修改，所以先重载它自己
from importlib import reload
reload(reload_handler)

# --- 3. 根据需要清理场景 ---
mel.eval('file -new -force')

# --- 4. 正常导入模块 ---
from core import name
from core.rigging import bone,fk,ik,ikfk,stretchy,build_plan
from ui import main_window

# --- 5. 重载(这个顺序是对的！） ---
PACKAGES_TO_RELOAD = ["core", "ui", "utils"]  # 注意：现在我们重载整个包
for pkg_name in PACKAGES_TO_RELOAD:
    reload_handler.reload_package(pkg_name)

# --- 6. 测试代码 ---
# bone.run_bone_manager_test()
# f_manager.run_fk_creation_test()
# ik.run_ik_creation_test()
# ikfk.run_full_system_creation_test()
# utils.run_rename_test()
# stretchy.run_stretchy_ik_test()
# build_plan.run_build_plan_test()

# --- 7. 主函数 ---
def run():
    """
    启动插件的函数。
    """

    # 检查并关闭旧窗口
    for widget in QtWidgets.QApplication.instance().topLevelWidgets():
        if widget.objectName() == main_window.MayaCraftMainWindow.OBJECT_NAME:
            print(f"找到已存在的窗口: {widget.objectName()}。正在关闭...")
            widget.close()

    # 调用主窗口类的 show_instance 方法来显示一个全新的窗口
    app = main_window.MayaCraftMainWindow.show_instance()
    return app

# --- 执行启动函数 ---
run()