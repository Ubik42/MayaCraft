# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore, QtGui
import os

# 导入后端逻辑
from core.logic.animation import animation_tab_logic as logic
from ui.animation.curve_widget_ui import CurveWidget


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

        # --- [新增] 3. 曲线工具部分 ---
        self.curve_widget = CurveWidget()
        main_layout.addWidget(self.curve_widget)

        main_layout.addStretch()  # 添加一个弹簧

        # --- 连接所有信号 ---
        self.connect_signals()

        # --- 初始刷新 ---
        self._refresh_pose_list()

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
        # 图标模式
        self.pose_list_widget.setViewMode(QtWidgets.QListView.IconMode)
        self.pose_list_widget.setResizeMode(QtWidgets.QListView.Adjust)
        self.pose_list_widget.setWordWrap(True)
        self.pose_list_widget.setIconSize(QtCore.QSize(100, 100))  # 稍微大一点的缩略图
        self.pose_list_widget.setSpacing(5)

        pose_list_layout.addWidget(self.pose_list_widget)

        # 右侧: 操作按钮
        pose_actions_layout = QtWidgets.QVBoxLayout()
        self.save_pose_btn = QtWidgets.QPushButton("保存新Pose")
        self.save_pose_btn.setStyleSheet("background-color: #5285a6; color: white;")
        self.delete_pose_btn = QtWidgets.QPushButton("删除选中Pose")
        self.mirror_pose_btn = QtWidgets.QPushButton("镜像Pose (L<->R)")

        # Pose混合应用
        apply_blend_layout = QtWidgets.QHBoxLayout()
        self.apply_pose_btn = QtWidgets.QPushButton("应用")
        self.apply_pose_btn.setMinimumHeight(40)
        self.pose_blend_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.pose_blend_slider.setRange(0, 100)
        self.pose_blend_slider.setValue(100)
        self.pose_blend_label = QtWidgets.QLabel("100%")
        self.pose_blend_label.setFixedWidth(30)

        apply_blend_layout.addWidget(self.apply_pose_btn)
        apply_blend_layout.addWidget(self.pose_blend_slider)
        apply_blend_layout.addWidget(self.pose_blend_label)

        pose_actions_layout.addWidget(self.save_pose_btn)
        pose_actions_layout.addWidget(self.delete_pose_btn)
        pose_actions_layout.addStretch()
        pose_actions_layout.addWidget(self.mirror_pose_btn)
        pose_actions_layout.addLayout(apply_blend_layout)

        main_pose_layout.addLayout(pose_list_layout, 3)
        main_pose_layout.addLayout(pose_actions_layout, 2)

        return group

    def _create_anim_utils_ui(self):
        """创建动画工具集UI"""
        group = QtWidgets.QGroupBox("2. 动画工具集 | Animation Utilities")
        layout = QtWidgets.QGridLayout(group)

        self.bake_anim_btn = QtWidgets.QPushButton("动画烘焙 (Bake)")
        self.motion_trail_btn = QtWidgets.QPushButton("创建运动轨迹 (Motion Trail)")
        self.tween_machine_btn = QtWidgets.QPushButton("中间帧 (Tween 50%)")

        layout.addWidget(self.bake_anim_btn, 0, 0)
        layout.addWidget(self.motion_trail_btn, 0, 1)
        layout.addWidget(self.tween_machine_btn, 1, 0, 1, 2)

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

        # 双击列表项直接应用
        self.pose_list_widget.itemDoubleClicked.connect(self._on_apply_pose)

        # Anim Utilities
        self.bake_anim_btn.clicked.connect(self._on_bake_animation)
        self.motion_trail_btn.clicked.connect(self._on_create_motion_trail)
        self.tween_machine_btn.clicked.connect(self._on_open_tween_machine)

    # ---------------------------------------------------------------------------
    # 核心逻辑实现
    # ---------------------------------------------------------------------------

    def _refresh_pose_list(self):
        """刷新列表显示，加载名称和缩略图"""
        self.pose_list_widget.clear()

        pose_names = logic.get_pose_list()

        for name in pose_names:
            item = QtWidgets.QListWidgetItem(name)
            item.setTextAlignment(QtCore.Qt.AlignHCenter | QtCore.Qt.AlignBottom)

            # 加载缩略图
            icon_path = logic.get_icon_path(name)
            if icon_path and os.path.exists(icon_path):
                icon = QtGui.QIcon(icon_path)
                item.setIcon(icon)
            else:
                # 默认图标 (可选)
                # item.setIcon(self.style().standardIcon(QtWidgets.QStyle.SP_FileIcon))
                pass

            self.pose_list_widget.addItem(item)

    def _on_save_pose(self):
        """保存 Pose"""
        text, ok = QtWidgets.QInputDialog.getText(self, "保存 Pose", "请输入 Pose 名称:")
        if ok and text:
            # 去除非法字符
            safe_text = "".join([c for c in text if c.isalnum() or c in "_-"])
            if logic.save_pose(safe_text):
                self._refresh_pose_list()

    def _on_delete_pose(self):
        """删除 Pose"""
        selected_items = self.pose_list_widget.selectedItems()
        if not selected_items: return

        # 确认对话框
        reply = QtWidgets.QMessageBox.question(
            self, '确认删除',
            f"确定要删除选中的 {len(selected_items)} 个 Pose 吗？",
            QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No,
            QtWidgets.QMessageBox.No
        )

        if reply == QtWidgets.QMessageBox.Yes:
            for item in selected_items:
                logic.delete_pose(item.text())
            self._refresh_pose_list()

    def _on_mirror_pose(self):
        """镜像 Pose"""
        logic.mirror_pose()

    def _on_apply_pose(self):
        """应用 Pose"""
        selected_items = self.pose_list_widget.selectedItems()
        if not selected_items: return

        pose_name = selected_items[0].text()
        blend_val = self.pose_blend_slider.value()

        logic.apply_pose(pose_name, blend_val)

    def _on_blend_slider_changed(self, value):
        self.pose_blend_label.setText(f"{value}%")

    def _on_bake_animation(self):
        logic.bake_animation()

    def _on_create_motion_trail(self):
        logic.create_motion_trail()

    def _on_open_tween_machine(self):
        """应用 Tween (默认 0.5)"""
        # 这里暂时直接调用逻辑应用 50%
        # 如果需要更复杂的UI（比如滑条控制Tween），可以弹出一个新窗口
        logic.tween_machine(0.5)