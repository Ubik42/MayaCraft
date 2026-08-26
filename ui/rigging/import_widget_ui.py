# ui/rigging/import_widget_ui.py
# -*- coding: utf-8 -*-

from MayaCraft.compat.qt import QtWidgets
from MayaCraft.core.logic.rigging import import_widget_logic as logic
from MayaCraft.ui.collapsible_widget import CollapsibleWidget


class ImportWidget(CollapsibleWidget):
    """“预设与导入”功能块的UI类。"""

    def __init__(self, parent=None):
        super().__init__("1. 预设与导入", parent)

        content_layout = QtWidgets.QVBoxLayout()
        self._create_content(content_layout)
        self.set_content_layout(content_layout)

        self._connect_signals()
        self._initial_refresh()

    def _create_content(self, layout: QtWidgets.QVBoxLayout):
        """创建此控件的所有内部UI元素。"""
        # 1. 导入示例
        example_layout = QtWidgets.QHBoxLayout()
        self.example_combo = QtWidgets.QComboBox()
        self.refresh_examples_btn = QtWidgets.QPushButton("刷新")
        self.import_example_btn = QtWidgets.QPushButton("打开选中示例")
        example_layout.addWidget(QtWidgets.QLabel("成品示例:"))
        example_layout.addWidget(self.example_combo, 1)
        example_layout.addWidget(self.refresh_examples_btn)
        example_layout.addWidget(self.import_example_btn)

        # 2. 导入骨骼
        skeleton_layout = QtWidgets.QHBoxLayout()
        self.skeleton_combo = QtWidgets.QComboBox()
        self.refresh_skeletons_btn = QtWidgets.QPushButton("刷新")
        self.import_skeleton_btn = QtWidgets.QPushButton("导入纯骨骼")
        skeleton_layout.addWidget(QtWidgets.QLabel("骨骼文件:"))
        skeleton_layout.addWidget(self.skeleton_combo, 1)
        skeleton_layout.addWidget(self.refresh_skeletons_btn)
        skeleton_layout.addWidget(self.import_skeleton_btn)

        # 3. [修改] 实用工具栏
        tools_group = QtWidgets.QGroupBox("场景清理工具")
        tools_layout = QtWidgets.QHBoxLayout(tools_group)

        self.clear_labels_btn = QtWidgets.QPushButton("清空所有骨骼标签")
        self.clear_labels_btn.setStyleSheet("background-color: #5D4037; color: white;")

        # [新增] 清空所有属性按钮
        self.clear_attrs_btn = QtWidgets.QPushButton("清空所有自定义属性")
        self.clear_attrs_btn.setStyleSheet("background-color: #455A64; color: white;")

        tools_layout.addWidget(self.clear_labels_btn)
        tools_layout.addWidget(self.clear_attrs_btn)  # 添加新按钮

        # 添加到主布局
        layout.addLayout(example_layout)
        layout.addLayout(skeleton_layout)
        layout.addSpacing(5)
        layout.addWidget(tools_group)

    def _connect_signals(self):
        """连接所有UI控件的信号到槽函数。"""
        self.refresh_examples_btn.clicked.connect(self._on_refresh_examples)
        self.import_example_btn.clicked.connect(self._on_import_example)
        self.refresh_skeletons_btn.clicked.connect(self._on_refresh_raw_skeletons)
        self.import_skeleton_btn.clicked.connect(self._on_import_raw_skeleton)

        self.clear_labels_btn.clicked.connect(self._on_clear_all_labels)
        # [新增] 连接新按钮的信号
        self.clear_attrs_btn.clicked.connect(self._on_clear_all_attrs)

    def _on_clear_all_attrs(self):
        """[新增] 响应清空所有属性按钮"""
        result = QtWidgets.QMessageBox.question(
            self,
            "确认操作",
            "确定要清除场景中所有骨骼的【所有自定义属性】吗？\n(包括 twist, bendy 等)\n此操作不可撤销。",
            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No
        )

        if result == QtWidgets.QMessageBox.Yes:
            print("UI请求: 清空所有自定义属性")
            # 调用新的 logic 函数
            logic.clear_all_custom_attributes()
            print("UI提示: 自定义属性已清空")

    # --- 其他函数保持不变 ---
    def _initial_refresh(self):
        self._on_refresh_examples()
        self._on_refresh_raw_skeletons()

    def _on_refresh_examples(self):
        names = logic.refresh_example_list()
        self.example_combo.clear()
        self.example_combo.addItems(names or ["未找到示例"])

    def _on_import_example(self):
        selected = self.example_combo.currentText()
        logic.import_example(selected)

    def _on_refresh_raw_skeletons(self):
        names = logic.refresh_raw_skeleton_list()
        self.skeleton_combo.clear()
        self.skeleton_combo.addItems(names or ["未找到骨骼"])

    def _on_import_raw_skeleton(self):
        selected = self.skeleton_combo.currentText()
        logic.import_raw_skeleton(selected)

    def _on_clear_all_labels(self):
        result = QtWidgets.QMessageBox.question(
            self, "确认操作", "确定要清除场景中 **所有** 骨骼的标签吗？\n此操作不可撤销。",
            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No
        )
        if result == QtWidgets.QMessageBox.Yes:
            print("UI请求: 清空所有骨骼标签")
            logic.clear_all_joint_labels()
            print("UI提示: 标签已清空")
