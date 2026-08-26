# ui/general/general_tab.py
# -*- coding: utf-8 -*-
"""
general_tab_ui.py
通用功能标签页的前端UI实现。
"""
from MayaCraft.compat.qt import QtWidgets
from MayaCraft.compat.qt import (
    QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QLineEdit,
    QListWidget, QGroupBox, QComboBox, QSlider, QLabel, QCheckBox,
    QFormLayout, QListWidgetItem
)
from MayaCraft.compat.qt import Qt

# 导入后端逻辑模块
from MayaCraft.core.logic import general_tab_logic


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

        # --- [修改] 命名工具 ---
        self.rename_group = QGroupBox("命名工具")

        # 前后缀
        self.prefix_le = QLineEdit()
        self.prefix_le.setPlaceholderText("前缀")
        self.suffix_le = QLineEdit()
        self.suffix_le.setPlaceholderText("后缀")
        self.apply_affix_btn = QPushButton("批量添加前后缀")

        # 查找替换
        self.search_le = QLineEdit()
        self.search_le.setPlaceholderText("查找内容")
        self.replace_le = QLineEdit()
        self.replace_le.setPlaceholderText("替换为")
        self.replace_btn = QPushButton("批量替换")

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
        self.joint_axis_cb = QCheckBox("显示关节局部坐标轴")
        self.create_joint_btn = QPushButton("根据几何生成骨骼位置 (选中项中心)")

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

        # --- [修改] 命名工具布局 ---
        rename_layout = QVBoxLayout()

        # 前后缀行
        affix_layout = QHBoxLayout()
        affix_layout.addWidget(self.prefix_le)
        affix_layout.addWidget(self.suffix_le)
        rename_layout.addLayout(affix_layout)
        rename_layout.addWidget(self.apply_affix_btn)

        # 添加分隔线 (可选)
        separator = QtWidgets.QFrame()
        separator.setFrameShape(QtWidgets.QFrame.HLine)
        separator.setFrameShadow(QtWidgets.QFrame.Sunken)
        rename_layout.addWidget(separator)

        # 查找替换行
        replace_layout = QHBoxLayout()
        replace_layout.addWidget(self.search_le)
        replace_layout.addWidget(self.replace_le)
        rename_layout.addLayout(replace_layout)
        rename_layout.addWidget(self.replace_btn)

        self.rename_group.setLayout(rename_layout)

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
        joint_display_layout.addRow(self.create_joint_btn)
        self.joint_display_group.setLayout(joint_display_layout)

        # --- 添加所有组到主布局 ---
        main_layout.addWidget(self.align_group)
        main_layout.addWidget(self.rename_group)  # [修改] 添加新组
        main_layout.addWidget(self.transform_group)
        main_layout.addWidget(self.joint_display_group)
        main_layout.addStretch()

    def _connect_signals(self):
        """连接所有控件的信号到槽函数。"""
        # 定位
        self.target_get_btn.clicked.connect(self._on_get_target)
        self.source_get_btn.clicked.connect(self._on_get_sources)
        self.align_btn.clicked.connect(self._on_align)

        # [修改] 命名
        self.apply_affix_btn.clicked.connect(self._on_apply_affix)
        self.replace_btn.clicked.connect(self._on_replace_name)

        # 变换
        self.freeze_to_group_btn.clicked.connect(self.logic.freeze_transform_to_parent_group)
        self.quick_align_btn.clicked.connect(self._on_quick_align)

        # 骨骼显示
        self.joint_size_slider.valueChanged.connect(self._on_joint_size_changed)
        self.joint_axis_cb.stateChanged.connect(self._on_joint_axis_toggled)
        self.create_joint_btn.clicked.connect(self._on_create_joint_at_center)

    # --- 槽函数 (Slot Functions) ---
    def _on_get_target(self):
        target_name = self.logic.get_first_selected()
        self.target_le.setText(target_name)

    def _on_get_sources(self):
        source_names = self.logic.get_all_selected()
        self.source_lw.clear()
        for name in source_names:
            self.source_lw.addItem(QListWidgetItem(name))

    def _on_align(self):
        target = self.target_le.text()
        sources = [self.source_lw.item(i).text() for i in range(self.source_lw.count())]
        self.logic.align_transform(target, sources)

    def _on_apply_affix(self):
        """[新增] 响应“添加前后缀”按钮"""
        prefix = self.prefix_le.text()
        suffix = self.suffix_le.text()
        self.logic.add_prefix_suffix_to_selection(prefix, suffix)

    def _on_replace_name(self):
        """[新增] 响应“替换名称”按钮"""
        search_str = self.search_le.text()
        replace_str = self.replace_le.text()
        self.logic.search_replace_selection_names(search_str, replace_str)

    def _on_quick_align(self):
        do_translate = self.quick_align_translate_cb.isChecked()
        do_rotate = self.quick_align_rotate_cb.isChecked()
        do_scale = self.quick_align_scale_cb.isChecked()
        self.logic.quick_align(do_translate, do_rotate, do_scale)

    def _on_joint_size_changed(self, value):
        radius = value / 100.0
        self.joint_size_label.setText(f"{radius:.2f}")
        self.logic.set_all_joint_radius(radius)

    def _on_joint_axis_toggled(self, state):
        self.logic.toggle_joint_axis_display(bool(state))

    def _on_create_joint_at_center(self):
        if hasattr(self.logic, 'create_joint_at_selection_center'):
            self.logic.create_joint_at_selection_center()
        else:
            print("Error: 逻辑层缺少 create_joint_at_selection_center 方法")
