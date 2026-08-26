# -*- coding: utf-8 -*-
"""
controller_widget_logic.py
处理控制器形状管理的后端逻辑。
连接 UI 与 core.controller。
"""
import os
from MayaCraft.compat.qt import QtGui
from MayaCraft.core import controller


def refresh_shape_list():
    """获取所有已保存的形状文件列表 (.json)。"""
    shape_dir = controller.get_shape_dir()
    if not shape_dir or not os.path.exists(shape_dir):
        return []

    files = [f for f in os.listdir(shape_dir) if f.endswith(".json")]
    files.sort()
    return files


def save_shape(filename):
    """
    保存当前选中的控制器形状。
    filename: UI 输入的文件名。如果为空字符串，core.controller 会自动处理为对象名。
    """
    return controller.save_curve(filename)


def apply_shape(filename):
    """
    将选中的形状文件应用到当前选中的物体。
    """
    if not filename:
        return

    shape_dir = controller.get_shape_dir()
    file_path = os.path.join(shape_dir, filename)

    # 逻辑层负责构建完整路径，然后调用 controller 的替换功能
    # controller.py 并没有暴露直接接受 path 的 replace 函数供外部调用(它有一个 replace_selected_with_file 但那是内部用的或者旧版遗留)
    # 最稳妥的方式是复用 controller.replace_shape，这里我们需要读一下文件

    # 实际上 controller.py 中应该有一个 helper，但为了保持逻辑层轻量，我们直接读取
    # 或者更好的是，我们在 controller.py 里加一个 apply_shape_from_file 的接口
    # 既然之前的 controller.py 里没有删掉 replace_selected_with_file (只是移除了 __main__ 测试)，我们可以利用它
    # 但 replace_selected_with_file 内部自己获取了 selection。

    # 为了保险，我们这里手动读一下传给 replace_shape
    import json
    if os.path.exists(file_path):
        try:
            with open(file_path, 'r') as f:
                shape_data = json.load(f)

            # 获取当前选中
            import maya.cmds as cmds
            selection = cmds.ls(selection=True)
            for node in selection:
                controller.replace_shape(node, shape_data)
        except Exception as e:
            print(f"Error applying shape: {e}")


def import_all():
    """
    一键导入所有控制器到 Shapes 组并排列。
    """
    # [修改] 调用新的 grid 导入函数
    return controller.import_all_to_grid()


def apply_color(qcolor):
    """
    应用颜色。
    将 PySide6 的 QColor 转换为 Maya 需要的 RGB (0-1) 格式。
    """
    if not qcolor.isValid():
        return

    # QColor (0-255) 转 Maya RGB (0.0-1.0)
    r = qcolor.red() / 255.0
    g = qcolor.green() / 255.0
    b = qcolor.blue() / 255.0

    controller.set_color((r, g, b))