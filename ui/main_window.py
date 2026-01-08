# -*- coding: utf-8 -*-

from PySide6 import QtWidgets

# 导入你的 Tab 页 (保持不变)
from ui.rigging.rigging_tab import RiggingTab
from ui.skinning.skinning_tab import SkinningTab
from ui.animation.animation_tab import AnimationTab
from ui.general.general_tab import GeneralTab
from ui.face.face_tab import FaceTab
from ui.td.td_tab import TDTab


class MayaCraftMainWindow(QtWidgets.QWidget):  # <--- 改动1: 继承 QWidget
    """
    插件主窗口类。
    改为继承 QWidget 以便完美适配 Maya 的 workspaceControl 内嵌系统。
    """
    OBJECT_NAME = "MayaCraftMainWindow"

    def __init__(self, parent=None):
        """
        构造函数
        """
        super().__init__(parent)

        self.setWindowTitle("MayaCraft Suite v1.0")
        self.setObjectName(self.OBJECT_NAME)

        # 内嵌窗口建议不要设置死 MinimumSize，否则拖拽停靠时可能会导致 Maya 界面卡住无法缩小
        # 如果非要设置，数值给小一点
        self.setMinimumSize(300, 200)

        self.init_ui()

    def init_ui(self):
        """
        初始化UI布局和控件。
        """
        # <--- 改动2: QWidget 直接设置布局，不需要 CentralWidget
        main_layout = QtWidgets.QVBoxLayout(self)
        # 设置为 0 边距，这样你的工具能填满 Maya 的面板，不会留白边
        main_layout.setContentsMargins(0, 0, 0, 0)

        self.tab_widget = QtWidgets.QTabWidget()
        main_layout.addWidget(self.tab_widget)

        # 实例化 Tabs
        self.rigging_tab = RiggingTab()
        self.face_tab = FaceTab()
        self.skinning_tab = SkinningTab()
        self.animation_tab = AnimationTab()
        self.general_tab = GeneralTab()
        self.td_tab = TDTab()

        # 添加 Tabs
        self.tab_widget.addTab(self.rigging_tab, "Rigging")
        self.tab_widget.addTab(self.face_tab, "Face")
        self.tab_widget.addTab(self.skinning_tab, "Skinning")
        self.tab_widget.addTab(self.animation_tab, "Animation")
        self.tab_widget.addTab(self.general_tab, "General")
        self.tab_widget.addTab(self.td_tab,"TD")
