# build_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets
from maya import cmds

# 导入此UI专属的后端逻辑
from core.logic.rigging import build_widget_logic as logic
# 导入通用的可折叠控件
from ui.collapsible_widget import CollapsibleWidget


class BuildWidget(CollapsibleWidget):
    """“骨骼与模块”功能块的UI类。"""

    def __init__(self, parent=None):
        super().__init__("2. 骨骼与模块 | Joints & Modules", parent)

        # 创建并设置此控件的内容布局
        main_build_layout = QtWidgets.QHBoxLayout()
        self._create_content(main_build_layout)
        self.set_content_layout(main_build_layout)

        # 连接信号
        self._connect_signals()

        # 初始刷新
        self._on_refresh_joint_labels()

    def _create_content(self, main_layout: QtWidgets.QHBoxLayout):
        """创建此控件的所有内部UI元素。"""
        # 左侧: 骨骼标签列表
        labels_layout = QtWidgets.QVBoxLayout()
        labels_header_layout = QtWidgets.QHBoxLayout()
        labels_header_layout.addWidget(QtWidgets.QLabel("场景骨骼标签:"))
        self.refresh_labels_btn = QtWidgets.QPushButton("刷新")
        labels_header_layout.addWidget(self.refresh_labels_btn)

        self.joint_labels_lw = QtWidgets.QListWidget()

        labels_layout.addLayout(labels_header_layout)
        labels_layout.addWidget(self.joint_labels_lw)

        # 右侧: 编辑和工具
        tools_layout = QtWidgets.QVBoxLayout()

        # 设置标签
        set_label_group = QtWidgets.QGroupBox("设置选中骨骼标签")
        set_label_layout = QtWidgets.QHBoxLayout(set_label_group)
        self.new_label_le = QtWidgets.QLineEdit()
        self.new_label_le.setPlaceholderText("例如: L_Arm_Shoulder")
        self.set_label_btn = QtWidgets.QPushButton("设置")
        set_label_layout.addWidget(self.new_label_le)
        set_label_layout.addWidget(self.set_label_btn)

        # 镜像工具
        mirror_group = QtWidgets.QGroupBox("镜像工具")
        mirror_layout = QtWidgets.QVBoxLayout(mirror_group)
        self.mirror_joints_btn = QtWidgets.QPushButton("镜像选中骨骼 (_L -> _R)")
        mirror_layout.addWidget(self.mirror_joints_btn)

        tools_layout.addWidget(set_label_group)
        tools_layout.addWidget(mirror_group)
        tools_layout.addStretch()

        main_layout.addLayout(labels_layout, 1)
        main_layout.addLayout(tools_layout, 1)

    def _connect_signals(self):
        """连接所有UI控件的信号到槽函数。"""
        self.refresh_labels_btn.clicked.connect(self._on_refresh_joint_labels)
        self.joint_labels_lw.itemClicked.connect(self._on_label_item_clicked)
        self.set_label_btn.clicked.connect(self._on_set_joint_label)
        self.mirror_joints_btn.clicked.connect(self._on_mirror_joints)

    # --- 槽函数 ---
    def _on_refresh_joint_labels(self):
        """刷新场景骨骼标签列表。"""
        print("UI请求: 刷新骨骼标签列表")
        self.joint_labels_lw.clear()

        # 从后端获取数据，并将数据缓存到UI实例中
        self.labels_data = logic.get_all_joint_labels()

        if self.labels_data:
            sorted_labels = sorted(self.labels_data.keys())
            self.joint_labels_lw.addItems(sorted_labels)
        else:
            self.joint_labels_lw.addItem("场景中无带标签的骨骼")

    def _on_label_item_clicked(self, item):
        """当列表中的标签被点击时，选中对应的骨骼。"""
        label_text = item.text()
        print(f"UI请求: 选中标签为 '{label_text}' 的骨骼")
        # 使用缓存的数据来查找骨骼名称
        if hasattr(self, 'labels_data'):
            logic.select_joint_by_label(self.labels_data, label_text)

    def _on_set_joint_label(self):
        """为当前选中的骨骼设置新标签。"""
        selection = cmds.ls(sl=True, type='joint')
        if not selection:
            cmds.warning("请先选中一个骨骼。")
            return

        target_joint = selection[0]
        new_label = self.new_label_le.text()

        print(f"UI请求: 为 '{target_joint}' 设置标签 '{new_label}'")
        # 调用后端逻辑，并检查是否成功
        success = logic.set_joint_label(target_joint, new_label)

        # 如果设置成功，则刷新列表并清空输入框
        if success:
            self._on_refresh_joint_labels()
            self.new_label_le.clear()

    def _on_mirror_joints(self):
        """请求后端执行镜像操作，并在完成后刷新UI。"""
        print("UI请求: 镜像选中骨骼")
        logic.mirror_selected_joints()
        # 镜像完成后，场景中的标签已更新，需要刷新列表
        self._on_refresh_joint_labels()