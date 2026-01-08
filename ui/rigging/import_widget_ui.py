# ui/rigging/import_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets
# 导入此UI专属的后端逻辑
from core.logic.rigging import import_widget_logic as logic
# 导入通用的可折叠控件
from ui.collapsible_widget import CollapsibleWidget


class ImportWidget(CollapsibleWidget):
    """“预设与导入”功能块的UI类。"""

    def __init__(self, parent=None):
        super().__init__("1. 预设与导入 | Presets & Import", parent)

        # 创建并设置此控件的内容布局
        content_layout = QtWidgets.QVBoxLayout()
        self._create_content(content_layout)
        self.set_content_layout(content_layout)

        # 连接信号
        self._connect_signals()

        # 启动时自动刷新两个列表
        self._initial_refresh()

    def _create_content(self, layout: QtWidgets.QVBoxLayout):
        """创建此控件的所有内部UI元素。"""
        # 1. 导入示例 (.mb)
        example_layout = QtWidgets.QHBoxLayout()
        self.example_combo = QtWidgets.QComboBox()
        self.refresh_examples_btn = QtWidgets.QPushButton("刷新")
        self.import_example_btn = QtWidgets.QPushButton("打开选中示例")
        example_layout.addWidget(QtWidgets.QLabel("成品示例:"))
        example_layout.addWidget(self.example_combo, 1)
        example_layout.addWidget(self.refresh_examples_btn)
        example_layout.addWidget(self.import_example_btn)

        # 2. 导入骨骼 (.ma)
        skeleton_layout = QtWidgets.QHBoxLayout()
        self.skeleton_combo = QtWidgets.QComboBox()
        self.refresh_skeletons_btn = QtWidgets.QPushButton("刷新")
        self.import_skeleton_btn = QtWidgets.QPushButton("导入纯骨骼")
        skeleton_layout.addWidget(QtWidgets.QLabel("骨骼文件:"))
        skeleton_layout.addWidget(self.skeleton_combo, 1)
        skeleton_layout.addWidget(self.refresh_skeletons_btn)
        skeleton_layout.addWidget(self.import_skeleton_btn)

        # 3. [新增] 实用工具栏
        tools_layout = QtWidgets.QHBoxLayout()
        self.clear_labels_btn = QtWidgets.QPushButton("一键清空场景所有骨骼标签")
        # 可以给按钮加点警告色，提示这是个破坏性操作
        self.clear_labels_btn.setStyleSheet("background-color: #5D4037; color: white;")
        tools_layout.addWidget(self.clear_labels_btn)

        # 添加到主布局
        layout.addLayout(example_layout)
        layout.addLayout(skeleton_layout)
        layout.addSpacing(5)  # 加一点间距
        layout.addLayout(tools_layout)  # 添加工具栏

    def _connect_signals(self):
        """连接所有UI控件的信号到槽函数。"""
        self.refresh_examples_btn.clicked.connect(self._on_refresh_examples)
        self.import_example_btn.clicked.connect(self._on_import_example)
        self.refresh_skeletons_btn.clicked.connect(self._on_refresh_raw_skeletons)
        self.import_skeleton_btn.clicked.connect(self._on_import_raw_skeleton)

        # [新增] 连接清空按钮
        self.clear_labels_btn.clicked.connect(self._on_clear_all_labels)

    def _initial_refresh(self):
        """在UI启动时执行初始刷新。"""
        self._on_refresh_examples()
        self._on_refresh_raw_skeletons()

    # --- 槽函数 ---
    def _on_refresh_examples(self):
        print("UI请求: 刷新示例列表")
        names = logic.refresh_example_list()
        self.example_combo.clear()
        self.example_combo.addItems(names or ["未找到示例"])

    def _on_import_example(self):
        selected = self.example_combo.currentText()
        print(f"UI请求: 打开示例 -> {selected}")
        logic.import_example(selected)

    def _on_refresh_raw_skeletons(self):
        print("UI请求: 刷新纯骨骼列表")
        names = logic.refresh_raw_skeleton_list()
        self.skeleton_combo.clear()
        self.skeleton_combo.addItems(names or ["未找到骨骼"])

    def _on_import_raw_skeleton(self):
        selected = self.skeleton_combo.currentText()
        print(f"UI请求: 导入纯骨骼 -> {selected}")
        logic.import_raw_skeleton(selected)

    def _on_clear_all_labels(self):
        """[新增] 响应清空按钮点击"""
        # 可以加一个确认弹窗，防止误触
        result = QtWidgets.QMessageBox.question(
            self,
            "确认操作",
            "确定要清除场景中 **所有** 骨骼的标签吗？\n此操作不可撤销。",
            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No
        )

        if result == QtWidgets.QMessageBox.Yes:
            print("UI请求: 清空所有骨骼标签")
            logic.clear_all_joint_labels()
            print("UI提示: 标签已清空")