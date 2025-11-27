# rigging_tab.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore

# 导入所有独立的、可折叠的子控件
from ui.rigging.import_widget_ui import ImportWidget
from ui.rigging.build_widget_ui import BuildWidget

from ui.rigging.finalize_widget_ui import FinalizeWidget


class RiggingTab(QtWidgets.QWidget):
    """
    绑定功能模块的主标签页。
    它的唯一职责是组装所有独立的子功能模块 (Widgets)。
    """

    def __init__(self, parent=None):
        super().__init__(parent)

        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setAlignment(QtCore.Qt.AlignTop)

        # --- 1. 创建并添加“导入”功能块 ---
        self.import_widget = ImportWidget(self)
        main_layout.addWidget(self.import_widget)

        # --- 2. 创建并添加“构建”功能块 ---
        self.build_widget = BuildWidget(self)
        main_layout.addWidget(self.build_widget)

        # --- 3. 创建并添加“完成”功能块 ---
        self.finalize_widget = FinalizeWidget(self)
        main_layout.addWidget(self.finalize_widget)

        # 添加一个伸缩弹簧，将所有内容推到顶部
        main_layout.addStretch()