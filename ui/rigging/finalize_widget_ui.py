# finalize_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets
from core.logic.rigging import finalize_widget_logic as logic
from ui.collapsible_widget import CollapsibleWidget


class FinalizeWidget(CollapsibleWidget):
    """“完成与工具”功能块的UI类。"""

    def __init__(self, parent=None):
        super().__init__("3. 完成与工具 | Finalize & Utilities", parent)

        layout = QtWidgets.QVBoxLayout()
        self._create_content(layout)
        self.set_content_layout(layout)

        self._connect_signals()

    def _create_content(self, layout: QtWidgets.QVBoxLayout):
        """创建此控件的所有内部UI元素。"""
        # 控制器形状
        shape_layout = QtWidgets.QHBoxLayout()
        shape_label = QtWidgets.QLabel("控制器形状:")
        self.controller_shape_combo = QtWidgets.QComboBox()
        # 从后端逻辑的数据字典中动态获取形状名称
        self.controller_shape_combo.addItems(logic.CONTROLLER_SHAPES_DB.keys())
        self.apply_shape_btn = QtWidgets.QPushButton("应用到选中")

        shape_layout.addWidget(shape_label)
        shape_layout.addWidget(self.controller_shape_combo, 1)
        shape_layout.addWidget(self.apply_shape_btn)

        # 镜像和完成
        self.mirror_shape_btn = QtWidgets.QPushButton("镜像选中控制器形状 (_L -> _R)")
        self.finalize_rig_btn = QtWidgets.QPushButton("最终化绑定 (清理和锁定)")
        # 最终化是一个重要操作，可以给按钮添加一些视觉提示
        self.finalize_rig_btn.setStyleSheet("background-color: #8c2a2a;")

        layout.addLayout(shape_layout)
        layout.addWidget(self.mirror_shape_btn)
        layout.addWidget(self.finalize_rig_btn)

    def _connect_signals(self):
        """连接所有UI控件的信号到槽函数。"""
        self.apply_shape_btn.clicked.connect(self._on_apply_shape)
        self.mirror_shape_btn.clicked.connect(self._on_mirror_shape)
        self.finalize_rig_btn.clicked.connect(self._on_finalize_rig)

    # --- 槽函数 ---
    def _on_apply_shape(self):
        """请求后端应用选定的控制器形状。"""
        selected_shape = self.controller_shape_combo.currentText()
        print(f"UI请求: 应用控制器形状 -> {selected_shape}")
        logic.apply_controller_shape(selected_shape)

    def _on_mirror_shape(self):
        """请求后端镜像选中的控制器形状。"""
        print("UI请求: 镜像控制器形状")
        logic.mirror_controller_shapes()

    def _on_finalize_rig(self):
        """请求后端执行最终化操作。"""
        # 弹出一个确认对话框，防止误操作
        reply = QtWidgets.QMessageBox.question(
            self,
            "确认最终化",
            "这是一个不可逆的操作，将会锁定和隐藏绑定中的多个属性。\n您确定要继续吗？",
            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No,
            QtWidgets.QMessageBox.No
        )

        if reply == QtWidgets.QMessageBox.Yes:
            print("UI请求: 最终化绑定")
            logic.finalize_rig()
        else:
            print("最终化操作已取消。")