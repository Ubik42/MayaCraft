# -*- coding: utf-8 -*-

from PySide6 import QtWidgets
from maya import OpenMayaUI as omui
from shiboken6 import wrapInstance

from ui.rigging.rigging_tab import RiggingTab
from ui.skinning.skinning_tab import SkinningTab
from ui.animation.animation_tab import AnimationTab
from ui.general.general_tab import GeneralTab


def get_maya_main_window():
    """获取Maya主窗口的指针"""
    main_window_ptr = omui.MQtUtil.mainWindow()
    return wrapInstance(int(main_window_ptr), QtWidgets.QWidget)


class MayaCraftMainWindow(QtWidgets.QMainWindow):
    """
    插件主窗口类。
    """
    _instance = None
    OBJECT_NAME = "MayaCraftMainWindow"  # 定义一个唯一的窗口对象名



    def __init__(self, parent=get_maya_main_window()):
        """
        构造函数
        """
        super().__init__(parent)  # <-- 使用现代化的super()

        self.setWindowTitle("MayaCraft Suite v1.0")
        self.setObjectName(self.OBJECT_NAME)  # <-- 使用类变量设置对象名
        self.setMinimumSize(800, 500)

        self.init_ui()

    def init_ui(self):
        """
        初始化UI布局和控件。
        """
        main_widget = QtWidgets.QWidget()
        self.setCentralWidget(main_widget)
        main_layout = QtWidgets.QVBoxLayout(main_widget)
        main_layout.setContentsMargins(5, 5, 5, 5)

        self.tab_widget = QtWidgets.QTabWidget()
        main_layout.addWidget(self.tab_widget)

        self.rigging_tab = RiggingTab()
        self.skinning_tab = SkinningTab()
        self.animation_tab = AnimationTab()
        self.general_tab = GeneralTab()

        self.tab_widget.addTab(self.rigging_tab, "绑定 (Rigging)")
        self.tab_widget.addTab(self.skinning_tab, "蒙皮 (Skinning)")
        self.tab_widget.addTab(self.animation_tab, "动画 (Animation)")
        self.tab_widget.addTab(self.general_tab, "通用")

    # 这是一个 类方法 (@classmethod)。普通的方法操作的是一个类的实例（self），而类方法操作的是类本身（cls）。cls就是我们给类本身随机起的代号。
    @classmethod
    def show_instance(cls):
        """
        以单例模式显示窗口。
        """
        # 注意：这里的逻辑简化了，因为关闭操作移到了launcher里
        if cls._instance is None:
            cls._instance = cls()

        #这都是pyside的内置方法
        cls._instance.show()
        #激活并“提”到所有窗口的最前面，让用户能立刻看到它。
        cls._instance.activateWindow()
        cls._instance.raise_()
        return cls._instance

    def closeEvent(self, event):
        """
        重写关闭事件。
        """
        self.__class__._instance = None
        super().closeEvent(event)  # <-- 使用现代化的super()
        print("MayaCraft Suite window closed.")