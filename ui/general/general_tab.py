# -*- coding: utf-8 -*-
"""
general_tab_ui.py
通用功能标签页的前端UI实现。
此类负责构建和显示界面，并将用户交互传递给后端逻辑。
"""

from PySide6.QtWidgets import (
    QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QLineEdit,
    QListWidget, QGroupBox, QComboBox, QSlider, QLabel, QCheckBox,
    QFormLayout, QListWidgetItem
)
from PySide6.QtCore import Qt

# 导入后端逻辑模块
from core.logic import general_tab_logic


class GeneralTab(QWidget):
    """通用功能标签页的UI类。"""

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("通用绑定工具")

        # 实例化后端逻辑
        self.logic = general_tab_logic

        # 初始化UI
        self._create_widgets()
        self._create_layouts()
        self._connect_signals()

    def _create_widgets(self):
        """创建所有UI控件。"""
        # --- 空间定位 ---
        self.align_group = QGroupBox("空间定位")
        self.target_get_btn = QPushButton("获取目标")
        self.target_le = QLineEdit()
        self.target_le.setReadOnly(True)
        self.source_get_btn = QPushButton("获取源")
        self.source_lw = QListWidget()
        self.source_lw.setSelectionMode(QListWidget.NoSelection)
        self.align_btn = QPushButton("定位")

        # --- 控制器 ---
        self.controller_group = QGroupBox("控制器")
        self.controller_combo = QComboBox()
        self.controller_combo.addItems(self.logic.CONTROLLER_SHAPES.keys())
        self.controller_replace_btn = QPushButton("替换选中")

        # --- 变换工具 ---
        self.transform_group = QGroupBox("变换工具")
        self.freeze_to_group_btn = QPushButton("冻结Transform到父组")
        self.quick_align_translate_cb = QCheckBox("位移")
        self.quick_align_rotate_cb = QCheckBox("旋转")
        self.quick_align_scale_cb = QCheckBox("缩放")
        self.quick_align_btn = QPushButton("快速对齐 (选中项 -> 最后一项)")
        self.quick_align_translate_cb.setChecked(True)
        self.quick_align_rotate_cb.setChecked(True)

        # --- 骨骼显示 ---
        self.joint_display_group = QGroupBox("骨骼显示")
        self.joint_size_slider = QSlider(Qt.Horizontal)
        self.joint_size_slider.setMinimum(1)
        self.joint_size_slider.setMaximum(200)
        self.joint_size_slider.setValue(100)
        self.joint_size_label = QLabel("1.0")
        self.joint_axis_cb = QCheckBox("显示局部坐标轴 (Joint Axis)")

    def _create_layouts(self):
        """创建和设置布局。"""
        main_layout = QVBoxLayout(self)

        # --- 空间定位布局 ---
        align_layout = QVBoxLayout()
        target_layout = QHBoxLayout()
        target_layout.addWidget(self.target_get_btn)
        target_layout.addWidget(self.target_le)
        source_layout = QHBoxLayout()
        source_layout.addWidget(self.source_get_btn)
        source_layout.addWidget(self.source_lw)
        align_layout.addLayout(target_layout)
        align_layout.addLayout(source_layout)
        align_layout.addWidget(self.align_btn)
        self.align_group.setLayout(align_layout)

        # --- 控制器布局 ---
        controller_layout = QHBoxLayout()
        controller_layout.addWidget(QLabel("选择形状:"))
        controller_layout.addWidget(self.controller_combo)
        controller_layout.addWidget(self.controller_replace_btn)
        self.controller_group.setLayout(controller_layout)

        # --- 变换工具布局 ---
        transform_layout = QVBoxLayout()
        transform_layout.addWidget(self.freeze_to_group_btn)
        quick_align_options_layout = QHBoxLayout()
        quick_align_options_layout.addWidget(self.quick_align_translate_cb)
        quick_align_options_layout.addWidget(self.quick_align_rotate_cb)
        quick_align_options_layout.addWidget(self.quick_align_scale_cb)
        transform_layout.addLayout(quick_align_options_layout)
        transform_layout.addWidget(self.quick_align_btn)
        self.transform_group.setLayout(transform_layout)

        # --- 骨骼显示布局 ---
        joint_display_layout = QFormLayout()
        joint_size_layout = QHBoxLayout()
        joint_size_layout.addWidget(self.joint_size_slider)
        joint_size_layout.addWidget(self.joint_size_label)
        joint_display_layout.addRow("全局骨骼大小:", joint_size_layout)
        joint_display_layout.addRow(self.joint_axis_cb)
        self.joint_display_group.setLayout(joint_display_layout)

        # --- 添加所有组到主布局 ---
        main_layout.addWidget(self.align_group)
        main_layout.addWidget(self.controller_group)
        main_layout.addWidget(self.transform_group)
        main_layout.addWidget(self.joint_display_group)
        main_layout.addStretch()

    def _connect_signals(self):
        """连接所有控件的信号到槽函数。"""
        self.target_get_btn.clicked.connect(self._on_get_target)
        self.source_get_btn.clicked.connect(self._on_get_sources)
        self.align_btn.clicked.connect(self._on_align)

        self.controller_replace_btn.clicked.connect(self._on_replace_controller)

        self.freeze_to_group_btn.clicked.connect(self.logic.freeze_transform_to_parent_group)
        self.quick_align_btn.clicked.connect(self._on_quick_align)

        self.joint_size_slider.valueChanged.connect(self._on_joint_size_changed)
        self.joint_axis_cb.stateChanged.connect(self._on_joint_axis_toggled)

    # --- 槽函数 (Slot Functions) ---
    def _on_get_target(self):
        """当“获取目标”按钮被点击时。"""
        target_name = self.logic.get_first_selected()
        self.target_le.setText(target_name)

    def _on_get_sources(self):
        """当“获取源”按钮被点击时。"""
        source_names = self.logic.get_all_selected()
        self.source_lw.clear()
        for name in source_names:
            self.source_lw.addItem(QListWidgetItem(name))

    def _on_align(self):
        """当“定位”按钮被点击时。"""
        target = self.target_le.text()
        sources = [self.source_lw.item(i).text() for i in range(self.source_lw.count())]
        self.logic.align_transform(target, sources)

    def _on_replace_controller(self):
        """当“替换选中”按钮被点击时。"""
        shape_type = self.controller_combo.currentText()
        self.logic.replace_selected_controllers(shape_type)

    def _on_quick_align(self):
        """当“快速对齐”按钮被点击时。"""
        do_translate = self.quick_align_translate_cb.isChecked()
        do_rotate = self.quick_align_rotate_cb.isChecked()
        do_scale = self.quick_align_scale_cb.isChecked()
        self.logic.quick_align(do_translate, do_rotate, do_scale)

    def _on_joint_size_changed(self, value):
        """当骨骼大小滑块值改变时。"""
        radius = value / 100.0
        self.joint_size_label.setText(f"{radius:.2f}")
        self.logic.set_all_joint_radius(radius)

    def _on_joint_axis_toggled(self, state):
        """当“显示局部坐标轴”复选框状态改变时。"""
        self.logic.toggle_joint_axis_display(bool(state))


# --- 用于在Maya中独立启动和测试的函数 ---
def show_ui():
    """在Maya中显示UI窗口。"""
    try:
        # 尝试关闭已存在的窗口
        global general_tab_window
        general_tab_window.close()
    except:
        pass

    general_tab_window = GeneralTab()
    general_tab_window.show()
    return general_tab_window


# 如果直接运行此文件，则显示UI
if __name__ == "__main__":
    show_ui()