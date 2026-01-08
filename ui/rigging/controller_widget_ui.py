# ui/rigging/controller_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtGui, QtCore
from core.logic.rigging import controller_widget_logic as logic
from ui.collapsible_widget import CollapsibleWidget
import maya.cmds as cmds


class ControllerWidget(CollapsibleWidget):
    """“控制器形状管理”功能块的UI类。"""

    def __init__(self, parent=None):
        super().__init__("4. 控制器形状 | Controller Shapes", parent)

        content_layout = QtWidgets.QVBoxLayout()
        self._create_content(content_layout)
        self.set_content_layout(content_layout)

        self._connect_signals()
        self._initial_refresh()

    def _create_content(self, layout: QtWidgets.QVBoxLayout):

        # --- 1. 保存区域 ---
        save_group = QtWidgets.QGroupBox("保存 (Save)")
        save_layout = QtWidgets.QHBoxLayout()
        self.name_input = QtWidgets.QLineEdit()
        self.name_input.setPlaceholderText("输入文件名 (留空则使用对象名)")
        self.save_btn = QtWidgets.QPushButton("保存选中")
        self.save_btn.setStyleSheet("background-color: #5285a6; color: white;")

        save_layout.addWidget(self.name_input)
        save_layout.addWidget(self.save_btn)
        save_group.setLayout(save_layout)

        # --- 2. 加载与匹配区域 ---
        load_group = QtWidgets.QGroupBox("应用 (Apply)")
        load_layout = QtWidgets.QVBoxLayout()

        # 单个应用
        single_layout = QtWidgets.QHBoxLayout()
        self.shape_combo = QtWidgets.QComboBox()
        self.refresh_btn = QtWidgets.QPushButton("刷新")
        self.apply_btn = QtWidgets.QPushButton("应用选中")
        single_layout.addWidget(self.shape_combo, 1)
        single_layout.addWidget(self.refresh_btn)
        single_layout.addWidget(self.apply_btn)

        # 批量应用 [修改文案]
        batch_layout = QtWidgets.QHBoxLayout()
        self.import_all_btn = QtWidgets.QPushButton("一键导入所有控制器 (Import All)")
        self.import_all_btn.setToolTip("遍历 shape 文件夹下的所有文件，如果场景中有同名物体，则自动替换形状。")
        self.import_all_btn.setMinimumHeight(30)
        batch_layout.addWidget(self.import_all_btn)

        load_layout.addLayout(single_layout)
        load_layout.addLayout(batch_layout)
        load_group.setLayout(load_layout)

        # --- 3. 颜色工具区域 ---
        color_group = QtWidgets.QGroupBox("颜色 (Color)")
        color_layout = QtWidgets.QHBoxLayout()

        self.color_btn = QtWidgets.QPushButton("选择并应用颜色 (Pick Color)")
        self.color_btn.setMinimumHeight(30)

        self.btn_red = self._create_color_btn("#ff5c5c", (1, 0.2, 0.2))
        self.btn_yellow = self._create_color_btn("#ffdd5c", (1, 1, 0.2))
        self.btn_blue = self._create_color_btn("#5c9aff", (0.2, 0.4, 1))

        color_layout.addWidget(self.color_btn)
        color_layout.addWidget(self.btn_red)
        color_layout.addWidget(self.btn_yellow)
        color_layout.addWidget(self.btn_blue)
        color_group.setLayout(color_layout)

        layout.addWidget(save_group)
        layout.addWidget(load_group)
        layout.addWidget(color_group)

    def _create_color_btn(self, hex_color, rgb_tuple):
        """创建快速颜色按钮"""
        btn = QtWidgets.QPushButton()
        btn.setFixedSize(30, 30)
        btn.setStyleSheet(f"background-color: {hex_color}; border: none; border-radius: 4px;")
        btn.clicked.connect(lambda: logic.apply_color(QtGui.QColor.fromRgbF(*rgb_tuple)))
        return btn

    def _connect_signals(self):
        self.save_btn.clicked.connect(self._on_save_shape)
        self.refresh_btn.clicked.connect(self._on_refresh_list)
        self.apply_btn.clicked.connect(self._on_apply_shape)
        self.import_all_btn.clicked.connect(self._on_import_all)
        self.color_btn.clicked.connect(self._on_pick_color)

        self.shape_combo.currentTextChanged.connect(self._on_combo_changed)

    def _initial_refresh(self):
        self._on_refresh_list()

    # --- 槽函数 ---
    def _on_refresh_list(self):
        # 阻断信号，防止清空/添加条目时触发 _on_combo_changed 导致输入框被乱改
        self.shape_combo.blockSignals(True)

        current = self.shape_combo.currentText()
        files = logic.refresh_shape_list()
        self.shape_combo.clear()
        if files:
            self.shape_combo.addItems(files)
            index = self.shape_combo.findText(current)
            if index >= 0:
                self.shape_combo.setCurrentIndex(index)
        else:
            self.shape_combo.addItem("无形状文件")

        self.shape_combo.blockSignals(False)

    def _on_save_shape(self):
        name = self.name_input.text()
        if logic.save_shape(name):
            # 保存成功后刷新列表
            self._on_refresh_list()
            # 【修复】刷新列表后，强制清空输入框，防止下拉框逻辑自动回填
            self.name_input.clear()

    def _on_apply_shape(self):
        filename = self.shape_combo.currentText()
        if filename and filename != "无形状文件":
            logic.apply_shape(filename)

    def _on_import_all(self):
        """一键导入所有"""
        count = logic.import_all()
        cmds.inViewMessage(amg=f'<span style=\"color: #00FF00;\">已匹配并替换 {count} 个控制器形状</span>',
                           pos='midCenter', fade=True)

    def _on_pick_color(self):
        color = QtWidgets.QColorDialog.getColor()
        if color.isValid():
            logic.apply_color(color)

    def _on_combo_changed(self, text):
        if text and text != "无形状文件":
            # 只有用户手动切换下拉框时，才填入名字方便覆盖
            # 代码里的刷新逻辑会 blockSignals，所以不会触发这里
            name = text.replace(".json", "")
            self.name_input.setText(name)