# ui/rigging/rigging_tab.py
# -*- coding: utf-8 -*-
from MayaCraft.compat.qt import QtWidgets

# 导入各个子模块 UI
from MayaCraft.ui.rigging.import_widget_ui import ImportWidget
from MayaCraft.ui.rigging.build_widget_ui import BuildWidget
from MayaCraft.ui.rigging.controller_widget_ui import ControllerWidget


class RiggingTab(QtWidgets.QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)
        self._create_ui()

    def _create_ui(self):
        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setContentsMargins(0, 0, 0, 0)
        main_layout.setSpacing(5)

        # 滚动区域
        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QtWidgets.QFrame.NoFrame)

        content_widget = QtWidgets.QWidget()
        content_layout = QtWidgets.QVBoxLayout(content_widget)
        content_layout.setContentsMargins(5, 5, 5, 5)
        content_layout.setSpacing(5)

        # --- 添加各个功能模块 ---

        # 1. 导入模块
        self.import_widget = ImportWidget()
        # [修改] 强制默认展开 (模拟点击或直接设置 checked)
        if hasattr(self.import_widget, 'toggle_button'):
            self.import_widget.toggle_button.setChecked(True)
        content_layout.addWidget(self.import_widget)

        # 2. 构建模块 (Build)
        self.build_widget = BuildWidget()
        # [修改] 强制默认展开
        if hasattr(self.build_widget, 'toggle_button'):
            self.build_widget.toggle_button.setChecked(True)
        content_layout.addWidget(self.build_widget)

        # 3. 控制器形状管理
        self.controller_widget = ControllerWidget()
        # [修改] 强制默认展开
        if hasattr(self.controller_widget, 'toggle_button'):
            self.controller_widget.toggle_button.setChecked(True)
        content_layout.addWidget(self.controller_widget)

        # 弹簧垫
        content_layout.addStretch()

        scroll.setWidget(content_widget)
        main_layout.addWidget(scroll)