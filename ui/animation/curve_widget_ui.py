# -*- coding: utf-8 -*-

from MayaCraft.compat.qt import QtWidgets, QtCore, QtGui
from MayaCraft.ui.collapsible_widget import CollapsibleWidget
# 导入逻辑
from MayaCraft.core.logic.animation import curve_logic as logic


class CurveWidget(CollapsibleWidget):
    """动画曲线编辑器小部件"""

    def __init__(self, parent=None):
        super().__init__("3. 曲线工具", parent)

        content_layout = QtWidgets.QVBoxLayout()
        self._create_content(content_layout)
        self.set_content_layout(content_layout)

        self._connect_signals()

    def _create_content(self, layout):
        # ============================================
        # 1. 横轴：Overshoot 均匀分布点
        # ============================================
        tween_group = QtWidgets.QWidget()
        tween_layout = QtWidgets.QHBoxLayout(tween_group)
        tween_layout.setContentsMargins(0, 0, 0, 0)
        tween_layout.setSpacing(2)

        percentages = [-50, -25, 0, 25, 50, 75, 100, 125, 150]

        for p in percentages:
            btn = QtWidgets.QPushButton(f"{p}%")
            btn.setToolTip(f"混合至 {p}%")
            btn.clicked.connect(lambda checked=False, val=p / 100.0: logic.tween_keys(val))

            if p == 0:
                btn.setStyleSheet("color: #85c9e0; font-weight: bold;")
            elif p == 100:
                btn.setStyleSheet("color: #85c9e0; font-weight: bold;")
            elif p == 50:
                btn.setStyleSheet("color: #ffb86c; font-weight: bold;")
            else:
                btn.setStyleSheet("color: gray;")

            tween_layout.addWidget(btn)

        layout.addWidget(tween_group)

        # ============================================
        # 2. 短横轴：Linear / Overshoot
        # ============================================
        linear_group = QtWidgets.QWidget()
        linear_layout = QtWidgets.QHBoxLayout(linear_group)
        linear_layout.setContentsMargins(0, 0, 0, 0)

        self.btn_over_left = QtWidgets.QPushButton("<< 左侧过冲")
        self.btn_over_left.clicked.connect(lambda: logic.tween_keys(-0.2))

        self.btn_linear = QtWidgets.QPushButton("线性 50%")
        self.btn_linear.setStyleSheet("background-color: #5285a6; color: white;")
        self.btn_linear.clicked.connect(lambda: logic.tween_keys(0.5))

        self.btn_over_right = QtWidgets.QPushButton("右侧过冲 >>")
        self.btn_over_right.clicked.connect(lambda: logic.tween_keys(1.2))

        linear_layout.addWidget(self.btn_over_left)
        linear_layout.addWidget(self.btn_linear)
        linear_layout.addWidget(self.btn_over_right)

        layout.addWidget(linear_group)

        # ============================================
        # 3. 数值精确控制
        # ============================================
        val_group = QtWidgets.QHBoxLayout()

        self.btn_val_minus = QtWidgets.QPushButton("-")
        self.val_input = QtWidgets.QDoubleSpinBox()
        self.val_input.setRange(0.0, 10000.0)
        self.val_input.setValue(1.0)
        self.val_input.setSingleStep(0.1)
        self.btn_val_plus = QtWidgets.QPushButton("+")

        val_group.addWidget(QtWidgets.QLabel("数值偏移："))
        val_group.addWidget(self.btn_val_minus)
        val_group.addWidget(self.val_input)
        val_group.addWidget(self.btn_val_plus)

        layout.addLayout(val_group)

        # ============================================
        # 4. 关键帧移动与重置
        # ============================================
        move_group = QtWidgets.QHBoxLayout()

        self.btn_move_left = QtWidgets.QPushButton("< 时间 -1")
        self.btn_move_right = QtWidgets.QPushButton("时间 +1 >")
        self.btn_zero = QtWidgets.QPushButton("关键帧归零")

        move_group.addWidget(self.btn_move_left)
        move_group.addWidget(self.btn_zero)
        move_group.addWidget(self.btn_move_right)

        layout.addLayout(move_group)

        # 分割线
        line = QtWidgets.QFrame()
        line.setFrameShape(QtWidgets.QFrame.HLine)
        line.setFrameShadow(QtWidgets.QFrame.Sunken)
        layout.addWidget(line)

        # ============================================
        # 5. 高级滑块模式 (自适应大小)
        # ============================================
        # 使用 GroupBox 包裹，让它视觉上更清晰，并允许垂直扩展
        mode_group_box = QtWidgets.QGroupBox("高级模式")
        mode_layout = QtWidgets.QHBoxLayout(mode_group_box)

        # --- 左侧列表 ---
        self.mode_list = QtWidgets.QListWidget()
        modes = [
            "拉近 / 推远",
            "噪波",
            "缓入缓出",
            "混合至默认值",
            "混合至相邻关键帧",
            "混合至镜像值",
            "混合至指定帧",
            "从默认值缩放",
            "从平均值缩放",
            "从左侧相邻值缩放",
            "从右侧相邻值缩放"
        ]
        self.mode_list.addItems(modes)
        self.mode_list.setCurrentRow(4)

        # [修改] 移除固定高度，设置最小高度，并允许垂直/水平扩展
        self.mode_list.setMinimumHeight(180)
        self.mode_list.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.MinimumExpanding)

        # --- 右侧滑块区域 ---
        slider_area = QtWidgets.QVBoxLayout()
        self.mode_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.mode_slider.setRange(0, 100)
        self.mode_slider.setValue(50)
        self.mode_slider.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)

        self.lbl_slider_val = QtWidgets.QLabel("系数：50%")
        self.lbl_slider_val.setAlignment(QtCore.Qt.AlignCenter)

        # 垂直弹簧，确保滑块居中
        slider_area.addStretch()
        slider_area.addWidget(self.lbl_slider_val)
        slider_area.addWidget(self.mode_slider)
        slider_area.addStretch()

        # 将列表和滑块加入布局
        # stretch 1:1 分配 (或者 1:2 根据需要)
        mode_layout.addWidget(self.mode_list, 4)  # 列表占稍多一点宽度
        mode_layout.addLayout(slider_area, 3)

        # [修改] 将 GroupBox 添加到主布局，并给予 stretch 权重 (1)，让其占据剩余垂直空间
        layout.addWidget(mode_group_box, 1)

    def _connect_signals(self):
        # Value Offset
        self.btn_val_minus.clicked.connect(self._on_val_minus)
        self.btn_val_plus.clicked.connect(self._on_val_plus)

        # Time Move
        self.btn_move_left.clicked.connect(lambda: logic.shift_time(-1))
        self.btn_move_right.clicked.connect(lambda: logic.shift_time(1))
        self.btn_zero.clicked.connect(lambda: logic.zero_value())

        # Mode Slider
        self.mode_slider.valueChanged.connect(self._on_slider_change)
        self.mode_slider.sliderReleased.connect(self._on_slider_release)

    # --- 槽函数 ---
    def _on_val_minus(self):
        val = self.val_input.value()
        logic.offset_value(-val)

    def _on_val_plus(self):
        val = self.val_input.value()
        logic.offset_value(val)

    def _on_slider_change(self, value):
        self.lbl_slider_val.setText(f"系数：{value}%")
        current_item = self.mode_list.currentItem()
        if current_item:
            mode = current_item.text()
            logic.apply_slider_mode(mode, value)

    def _on_slider_release(self):
        pass
