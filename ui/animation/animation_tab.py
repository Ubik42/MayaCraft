# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore


class AnimationTab(QtWidgets.QWidget):
    """
    动画功能模块的完整UI布局。
    """

    def __init__(self, parent=None):
        super().__init__(parent)

        # --- 主布局 ---
        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setAlignment(QtCore.Qt.AlignTop)

        # --- 1. Pose库部分 ---
        pose_lib_group = self._create_pose_library_ui()
        main_layout.addWidget(pose_lib_group)

        # --- 2. 动画工具集部分 ---
        anim_utils_group = self._create_anim_utils_ui()
        main_layout.addWidget(anim_utils_group)

        main_layout.addStretch()  # 添加一个弹簧，让UI向上集中

        # --- 连接所有信号 ---
        self.connect_signals()

    # ---------------------------------------------------------------------------
    # UI 创建 (分块)
    # ---------------------------------------------------------------------------
    def _create_pose_library_ui(self):
        """创建Pose库UI"""
        group = QtWidgets.QGroupBox("1. Pose库 | Pose Library")
        main_pose_layout = QtWidgets.QHBoxLayout(group)

        # 左侧: Pose列表
        pose_list_layout = QtWidgets.QVBoxLayout()
        self.pose_list_widget = QtWidgets.QListWidget()
        # 设置显示模式为图标模式，为未来的缩略图做准备
        self.pose_list_widget.setViewMode(QtWidgets.QListView.IconMode)
        self.pose_list_widget.setResizeMode(QtWidgets.QListView.Adjust)
        self.pose_list_widget.setWordWrap(True)
        self.pose_list_widget.setIconSize(QtCore.QSize(80, 80))  # 设置缩略图大小
        # 添加一些占位符
        self.pose_list_widget.addItems(["Fist_Pose", "Open_Hand", "Point", "Relaxed"])
        pose_list_layout.addWidget(self.pose_list_widget)

        # 右侧: 操作按钮
        pose_actions_layout = QtWidgets.QVBoxLayout()
        self.save_pose_btn = QtWidgets.QPushButton("保存新Pose")
        self.delete_pose_btn = QtWidgets.QPushButton("删除选中Pose")
        self.mirror_pose_btn = QtWidgets.QPushButton("镜像Pose")

        # Pose混合应用
        apply_blend_layout = QtWidgets.QHBoxLayout()
        self.apply_pose_btn = QtWidgets.QPushButton("应用")
        self.pose_blend_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.pose_blend_slider.setRange(0, 100)
        self.pose_blend_slider.setValue(100)
        self.pose_blend_label = QtWidgets.QLabel("100%")
        apply_blend_layout.addWidget(self.apply_pose_btn)
        apply_blend_layout.addWidget(self.pose_blend_slider)
        apply_blend_layout.addWidget(self.pose_blend_label)

        pose_actions_layout.addWidget(self.save_pose_btn)
        pose_actions_layout.addWidget(self.delete_pose_btn)
        pose_actions_layout.addStretch()
        pose_actions_layout.addWidget(self.mirror_pose_btn)
        pose_actions_layout.addLayout(apply_blend_layout)

        main_pose_layout.addLayout(pose_list_layout, 3)  # 列表占3份空间
        main_pose_layout.addLayout(pose_actions_layout, 2)  # 按钮占2份空间

        return group

    def _create_anim_utils_ui(self):
        """创建动画工具集UI"""
        group = QtWidgets.QGroupBox("2. 动画工具集 | Animation Utilities")
        layout = QtWidgets.QGridLayout(group)

        self.bake_anim_btn = QtWidgets.QPushButton("动画烘焙")
        self.motion_trail_btn = QtWidgets.QPushButton("创建运动轨迹")
        self.tween_machine_btn = QtWidgets.QPushButton("中间帧工具")

        layout.addWidget(self.bake_anim_btn, 0, 0)
        layout.addWidget(self.motion_trail_btn, 0, 1)
        layout.addWidget(self.tween_machine_btn, 1, 0, 1, 2)  # 占据一行两列

        return group

    # ---------------------------------------------------------------------------
    # 信号连接
    # ---------------------------------------------------------------------------
    def connect_signals(self):
        """连接所有UI控件的信号到对应的槽函数。"""
        # Pose Library
        self.save_pose_btn.clicked.connect(self._on_save_pose)
        self.delete_pose_btn.clicked.connect(self._on_delete_pose)
        self.mirror_pose_btn.clicked.connect(self._on_mirror_pose)
        self.apply_pose_btn.clicked.connect(self._on_apply_pose)
        self.pose_blend_slider.valueChanged.connect(self._on_blend_slider_changed)

        # Anim Utilities
        self.bake_anim_btn.clicked.connect(self._on_bake_animation)
        self.motion_trail_btn.clicked.connect(self._on_create_motion_trail)
        self.tween_machine_btn.clicked.connect(self._on_open_tween_machine)

    # ---------------------------------------------------------------------------
    # 槽函数 (占位符)
    # ---------------------------------------------------------------------------
    def _on_save_pose(self):
        print("UI请求: 保存新Pose")

    def _on_delete_pose(self):
        selected_items = [item.text() for item in self.pose_list_widget.selectedItems()]
        print(f"UI请求: 删除选中Pose -> {selected_items}")

    def _on_mirror_pose(self):
        print("UI请求: 镜像Pose")

    def _on_apply_pose(self):
        blend_value = self.pose_blend_slider.value()
        selected_items = [item.text() for item in self.pose_list_widget.selectedItems()]
        print(f"UI请求: 应用选中Pose -> {selected_items} (混合值: {blend_value}%)")

    def _on_blend_slider_changed(self, value):
        self.pose_blend_label.setText(f"{value}%")

    def _on_bake_animation(self):
        print("UI请求: 动画烘焙")

    def _on_create_motion_trail(self):
        print("UI请求: 创建运动轨迹")

    def _on_open_tween_machine(self):
        print("UI请求: 打开中间帧工具")