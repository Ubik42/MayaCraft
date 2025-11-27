# collapsible_widget.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore, QtGui


class CollapsibleWidget(QtWidgets.QWidget):
    """
    一个可折叠的自定义控件，包含一个标题栏和一个可隐藏的内容区域。
    """

    def __init__(self, title: str = "", parent=None):
        super(CollapsibleWidget, self).__init__(parent)

        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setContentsMargins(5, 5, 5, 5)  # 稍微增加一点边距
        main_layout.setSpacing(0)

        # --- 标题栏 ---
        self.toggle_button = QtWidgets.QToolButton(self)
        self.toggle_button.setStyleSheet("QToolButton { border: none; font-weight: bold; }")
        self.toggle_button.setToolButtonStyle(QtCore.Qt.ToolButtonTextBesideIcon)
        self.toggle_button.setArrowType(QtCore.Qt.RightArrow)
        self.toggle_button.setText(title)
        self.toggle_button.setCheckable(True)
        self.toggle_button.setChecked(False)

        # --- 分隔线 ---
        line = QtWidgets.QFrame()
        line.setFrameShape(QtWidgets.QFrame.HLine)
        line.setFrameShadow(QtWidgets.QFrame.Sunken)

        # --- 内容区域 ---
        self.content_area = QtWidgets.QWidget(self)
        # 初始状态为折叠 (不可见)
        self.content_area.setVisible(False)

        # --- 信号连接 ---
        self.toggle_button.toggled.connect(self._on_toggled)

        # --- 添加到主布局 ---
        main_layout.addWidget(self.toggle_button)
        main_layout.addWidget(line)
        main_layout.addWidget(self.content_area)

    def _on_toggled(self, checked):
        """当标题栏被点击时，展开或折叠内容区域。"""
        if checked:
            self.toggle_button.setArrowType(QtCore.Qt.DownArrow)
        else:
            self.toggle_button.setArrowType(QtCore.Qt.RightArrow)

        # --- 核心修正点 ---
        # 我们不再手动计算高度，而是直接控制 content_area 的可见性。
        # PySide6 的布局系统会自动处理高度的展开和收缩。
        self.content_area.setVisible(checked)

    def set_content_layout(self, layout: QtWidgets.QLayout):
        """设置内容区域的布局。"""
        # 移除旧的布局 (这是一个好的实践，以防重复设置)
        old_layout = self.content_area.layout()
        if old_layout is not None:
            QtWidgets.QWidget().setLayout(old_layout)  # 将旧布局从控件中移除

        # 应用新布局
        self.content_area.setLayout(layout)