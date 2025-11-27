# -*- coding: utf-8 -*-
import sys
from PySide6 import QtWidgets
import maya.mel as mel
from importlib import reload

# --- 1. 路径设置 (不再需要！) ---
# 解释：因为 shelf 按钮的代码里已经执行了 sys.path.insert，
# 所以当代码运行到这里时，Python 已经知道项目在哪里了。

# --- 2. 导入我们的重载处理器 ---
# 建议加上 try-except 以防万一路径没配好时的报错提示
try:
    from utils import reload_handler
    reload(reload_handler)
except ImportError:
    print("❌ 错误: 无法导入 utils 包。请检查 sys.path 是否包含项目根目录。")
    raise

# --- 3. 根据需要清理场景 ---
# mel.eval('file -new -force') # 开发时可以开着，发布时建议注释掉，以免误删用户文件

# --- 4. 正常导入模块 ---
from core import name
from core.rigging import bone, fk, ik, ikfk, stretchy, build_plan
from ui import main_window

# --- 5. 重载 (开发神器) ---
PACKAGES_TO_RELOAD = ["core", "ui", "utils"]
for pkg_name in PACKAGES_TO_RELOAD:
    reload_handler.reload_package(pkg_name)

# --- 6. 主函数 ---
def run():
    # 检查并关闭旧窗口
    for widget in QtWidgets.QApplication.instance().topLevelWidgets():
        if widget.objectName() == main_window.MayaCraftMainWindow.OBJECT_NAME:
            print(f"关闭旧窗口: {widget.objectName()}")
            widget.close()

    # 显示新窗口
    app = main_window.MayaCraftMainWindow.show_instance()
    return app

# 注意：launch.py 主要是被 import 调用的。
# 如果你还是习惯直接在编辑器里 Run 这个文件，可以保留下面这行：
if __name__ == "__main__":
    run()