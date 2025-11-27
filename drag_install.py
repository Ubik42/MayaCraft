# -*- coding: utf-8 -*-
import os
import sys
import maya.cmds as cmds
import maya.mel as mel


def on_install():
    # 获取当前文件所在目录
    project_path = os.path.dirname(os.path.abspath(__file__)).replace('\\', '/')

    # 获取当前工具架
    gShelfTopLevel = mel.eval('$tmpVar=$gShelfTopLevel')
    current_shelf = cmds.tabLayout(gShelfTopLevel, query=True, selectTab=True)

    # 按钮命令
    command_str = (
        f"import sys\n"
        f"import maya.cmds as cmds\n"
        f"project_path = r'{project_path}'\n"
        f"if project_path not in sys.path:\n"
        f"    sys.path.insert(0, project_path)\n"
        f"\n"
        f"import launch\n"
        f"from importlib import reload\n"
        f"try:\n"
        f"    reload(launch)\n"
        f"    launch.run()\n"
        f"except Exception as e:\n"
        f"    print('Error:', e)\n"
        f"    import traceback\n"
        f"    traceback.print_exc()"
    )

    # 图标路径
    icon_path = os.path.join(project_path, "icon.png").replace('\\', '/')
    if not os.path.exists(icon_path):
        icon_path = "pythonFamily.png"

    # 创建按钮
    cmds.shelfButton(
        parent=current_shelf,
        annotation='MayaCraft Launcher',
        label='MayaCraft',
        image=icon_path,
        command=command_str,
        sourceType='python',
        style='iconOnly'
    )

    cmds.confirmDialog(title='Success', message='安装成功！', button=['OK'])


# --- 核心入口函数 ---
# 必须定义在全局作用域，不能缩进
def onMayaDroppedPythonFile(*args):
    """拖拽释放时触发"""
    on_install()


if __name__ == '__main__':
    on_install()