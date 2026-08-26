# -*- coding: utf-8 -*-
from functools import partial
from MayaCraft.compat.qt import QtWidgets, QtCore, QtGui
from MayaCraft.core.logic.face import face_tab_logic as logic


class FaceTab(QtWidgets.QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        # 1. 主布局
        self.main_layout = QtWidgets.QVBoxLayout(self)
        self.main_layout.setContentsMargins(0, 0, 0, 0)

        # 2. 滚动区域 (防止屏幕太小显示不全)
        scroll_area = QtWidgets.QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_area.setFrameShape(QtWidgets.QFrame.NoFrame)

        # 滚动区域的内容容器
        self.content_widget = QtWidgets.QWidget()
        self.content_layout = QtWidgets.QVBoxLayout(self.content_widget)
        self.content_layout.setContentsMargins(10, 10, 10, 10)
        self.content_layout.setSpacing(10)

        scroll_area.setWidget(self.content_widget)
        self.main_layout.addWidget(scroll_area)

        # ==========================================
        # UI 构建区域
        # ==========================================

        # 顶部：全局操作
        self._create_global_actions()

        # 中部：手风琴式分步操作
        self._create_part_toolbox()

        # 底部弹簧
        self.content_layout.addStretch()

    def _create_global_actions(self):
        """创建顶部的全局操作按钮"""
        group = QtWidgets.QGroupBox("全局操作")
        layout = QtWidgets.QHBoxLayout(group)

        btn_build_all = QtWidgets.QPushButton("一键构建全部面部绑定")
        btn_build_all.setMinimumHeight(35)
        # 设置一点样式让它显眼
        btn_build_all.setStyleSheet("background-color: #5D4037; font-weight: bold;")
        btn_build_all.clicked.connect(logic.run_build_all)

        btn_update = QtWidgets.QPushButton("合并并更新次级模块")
        btn_update.setMinimumHeight(35)
        btn_update.clicked.connect(logic.update_second)

        layout.addWidget(btn_build_all)
        layout.addWidget(btn_update)

        self.content_layout.addWidget(group)

    def _create_part_toolbox(self):
        """创建分部位的工具箱"""
        self.toolbox = QtWidgets.QToolBox()
        self.toolbox.setStyleSheet("QToolBox::tab { font-weight: bold; }")

        # --- 1. 眉毛 Brow ---
        self.toolbox.addItem(self._create_brow_page(), "1. 眉毛")

        # --- 2. 眼睛 Eye & Lid ---
        self.toolbox.addItem(self._create_eye_page(), "2. 眼睛与眼皮")

        # --- 3. 鼻子 Nose ---
        self.toolbox.addItem(self._create_nose_page(), "3. 鼻子")

        # --- 4. 下颚与嘴唇 Jaw & Lip ---
        self.toolbox.addItem(self._create_mouth_page(), "4. 下颚与嘴唇")

        # --- 5. 脸颊 Bulge & Cheek ---
        self.toolbox.addItem(self._create_cheek_page(), "5. 脸颊与其它")

        self.content_layout.addWidget(self.toolbox)

    # ==========================================
    # 各个页面的具体实现
    # ==========================================

    def _create_brow_page(self):
        widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(widget)
        layout.setSpacing(10)

        # --- 顶部原理图解说明 ---
        info_text = (
            "<h3>眉毛绑定原理 (Concept)</h3>"
            "眉毛绑定模拟的是<b>“眼球转动”</b>机制：眉毛是贴着额头骨骼（球面）滑动的。<br>"
            "系统会自动根据左侧定位器，<b>镜像生成</b>右侧绑定。"
        )
        info = self._create_info_label(info_text)
        layout.addWidget(info)

        # --- 步骤 1: 曲线 ---
        g1 = self._create_step_group("步骤 1：创建形状曲线")

        desc1 = (
            "<b>1. 选择对象：</b><br>"
            "请选中角色 <span style='color:#FF5252;'><b>左侧 (Left Side)</b></span> 眉毛中心的一条完整的 <b>Loop 边</b>。"
        )
        l1 = self._create_hint_label(desc1)

        # 按钮：参数映射 Part=Brow, Type=Curve
        b1 = self._create_action_btn("创建眉毛曲线",
                                     lambda: logic.create_locator("Brow", "Curve", "", ""))
        g1.layout().addWidget(l1)
        g1.layout().addWidget(b1)
        layout.addWidget(g1)

        # --- 步骤 2: 旋转中心 ---
        g2 = self._create_step_group("步骤 2：创建滑动轴心")

        desc2 = (
            "<b>1. 选择对象：</b><br>"
            "框选 <span style='color:#FF5252;'><b>左侧眉毛区域</b></span> 的一簇顶点(Vertices)，用于计算表面中心。<br>"
            "<br>"
            "<b>2. <span style='color:orange;'>重要：手动调整 (Manual Adjust)</span></b><br>"
            "创建后，场景中会出现 <b>SelectionBrowRoll</b> 对象。<br>"
            "请务必将其 <b>移动到脑袋内部深处</b> (即额头的球心位置)。<br>"
            "<i>*Roll(球心) 到 Joint(表面) 的距离决定了眉毛滑动的弧度。</i>"
        )
        l2 = self._create_hint_label(desc2)

        # 按钮：参数映射 Part=Brow, Type=Roll
        b2 = self._create_action_btn("创建旋转中心",
                                     lambda: logic.create_locator("Brow", "Roll", "", ""))

        g2.layout().addWidget(l2)
        g2.layout().addWidget(b2)
        layout.addWidget(g2)

        # --- 分割线 ---
        layout.addWidget(self._create_separator())

        # --- 步骤 3: 构建 ---
        # 按钮：调用 build_selected("Brow")
        btn_build = self._create_build_btn("构建眉毛绑定", "Brow")

        # 底部提示
        l3 = self._create_hint_label("点击构建后，系统将自动生成左右两侧的控制器。")
        l3.setAlignment(QtCore.Qt.AlignCenter)

        layout.addWidget(btn_build)
        layout.addWidget(l3)

        layout.addStretch()
        return widget

    def _create_eye_page(self):
        widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(widget)

        info = self._create_info_label("眼球中心用于眼皮的旋转。眼皮曲线定义形状。")
        layout.addWidget(info)

        # 眼球
        g1 = self._create_step_group("步骤 1：眼球中心")
        l1 = self._create_hint_label("选择眼球模型上的 <b>环形边</b> 或 <b>顶点</b> 计算中心。")
        b1 = self._create_action_btn("创建眼球中心",
                                     lambda: logic.create_locator("Eye", "Roll", "", ""))
        g1.layout().addWidget(l1)
        g1.layout().addWidget(b1)
        layout.addWidget(g1)

        # 眼皮
        g2 = self._create_step_group("步骤 2：眼皮曲线")
        l2 = self._create_hint_label("分别选择 <b>上眼皮</b> 和 <b>下眼皮</b> 的边缘线。")

        b_up = self._create_action_btn("创建上眼皮曲线",
                                       lambda: logic.create_locator("Lid", "Curve", "MainUp", ""))
        b_dn = self._create_action_btn("创建下眼皮曲线",
                                       lambda: logic.create_locator("Lid", "Curve", "MainDn", ""))

        g2.layout().addWidget(b_up)
        g2.layout().addWidget(b_dn)
        layout.addWidget(g2)

        # 构建
        layout.addWidget(self._create_separator())
        layout.addWidget(self._create_build_btn("构建眼睛绑定", "Eye"))
        layout.addWidget(self._create_build_btn("构建眼皮绑定", "Lid"))

        layout.addStretch()
        return widget

    def _create_nose_page(self):
        widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(widget)

        g1 = self._create_step_group("鼻子定位器")
        l1 = self._create_hint_label("选择鼻头/鼻翼相关的边或点。")
        b1 = self._create_action_btn("创建鼻子曲线",
                                     lambda: logic.create_locator("Nose", "Curve", "", ""))
        b2 = self._create_action_btn("创建鼻子中心",
                                     lambda: logic.create_locator("Nose", "Roll", "", ""))
        g1.layout().addWidget(l1)
        g1.layout().addWidget(b1)
        g1.layout().addWidget(b2)
        layout.addWidget(g1)

        layout.addWidget(self._create_build_btn("构建鼻子绑定", "Nose"))
        layout.addStretch()
        return widget

    def _create_mouth_page(self):
        widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(widget)

        info = self._create_info_label(
            "<span style='color:orange;'>注意：嘴唇绑定依赖下颚，请先构建下颚绑定。</span>"
        )
        layout.addWidget(info)

        # 下颚
        g1 = self._create_step_group("1. 下颚")
        l1 = self._create_hint_label("选择下巴附近的点，计算旋转轴心。")
        b1 = self._create_action_btn("创建下颚中心",
                                     lambda: logic.create_locator("Jaw", "Roll", "", ""))
        g1.layout().addWidget(l1)
        g1.layout().addWidget(b1)
        layout.addWidget(g1)

        layout.addWidget(self._create_build_btn("构建下颚绑定", "Jaw"))

        # 嘴唇
        g2 = self._create_step_group("2. 嘴唇")
        l2 = self._create_hint_label("分别选择 <b>上嘴唇</b> 和 <b>下嘴唇</b> 最内圈的闭合环形边。")

        b_up = self._create_action_btn("创建上唇曲线",
                                       lambda: logic.create_locator("Lip", "Curve", "Up", ""))
        b_dn = self._create_action_btn("创建下唇曲线",
                                       lambda: logic.create_locator("Lip", "Curve", "Dn", ""))

        g2.layout().addWidget(b_up)
        g2.layout().addWidget(b_dn)

        # 嘴唇Roll
        l3 = self._create_hint_label("选择嘴唇中心点。")
        b_roll = self._create_action_btn("创建嘴唇中心",
                                         lambda: logic.create_locator("Lip", "Roll", "", ""))
        g2.layout().addWidget(l3)
        g2.layout().addWidget(b_roll)

        layout.addWidget(g2)
        layout.addWidget(self._create_build_btn("构建嘴唇绑定", "Lip"))

        layout.addStretch()
        return widget

    def _create_cheek_page(self):
        widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(widget)

        info = self._create_info_label(
            "<span style='color:orange;'>注意：脸颊鼓包依赖嘴唇和下颚，请最后构建。</span>"
        )
        layout.addWidget(info)

        g1 = self._create_step_group("脸颊鼓包")
        l1 = self._create_hint_label(
            "选择脸颊外侧(法令纹外)的一条<b>垂直线</b>。<br>"
            "该线定义脸颊肌肉的滑动轨迹。"
        )
        b1 = self._create_action_btn("创建脸颊曲线",
                                     lambda: logic.create_locator("Bulge", "Curve", "", ""))

        g1.layout().addWidget(l1)
        g1.layout().addWidget(b1)
        layout.addWidget(g1)

        layout.addWidget(self._create_build_btn("构建脸颊绑定", "Bulge"))
        layout.addStretch()
        return widget

    # ==========================================
    # 辅助控件工厂方法 (Helper Factories)
    # ==========================================

    def _create_info_label(self, text):
        """创建顶部说明文字"""
        lbl = QtWidgets.QLabel(text)
        lbl.setWordWrap(True)
        lbl.setStyleSheet("color: #AAA; font-size: 11px; padding: 5px;")
        return lbl

    def _create_hint_label(self, text):
        """创建步骤内的提示文字"""
        lbl = QtWidgets.QLabel(text)
        lbl.setWordWrap(True)
        lbl.setStyleSheet("color: #888; font-size: 10px; margin-bottom: 2px;")
        return lbl

    def _create_step_group(self, title):
        """创建步骤分组框"""
        group = QtWidgets.QGroupBox(title)
        group.setStyleSheet("QGroupBox { font-weight: bold; border: 1px solid #444; margin-top: 6px; } "
                            "QGroupBox::title { subcontrol-origin: margin; left: 10px; padding: 0 3px; }")
        layout = QtWidgets.QVBoxLayout(group)
        layout.setContentsMargins(10, 15, 10, 10)
        layout.setSpacing(5)
        return group

    def _create_action_btn(self, text, func):
        """创建创建定位器的操作按钮"""
        btn = QtWidgets.QPushButton(text)
        btn.clicked.connect(func)
        return btn

    def _create_build_btn(self, text, part):
        """创建构建按钮 (绿色高亮)"""
        btn = QtWidgets.QPushButton(text)
        btn.setMinimumHeight(30)
        btn.setStyleSheet("background-color: #2E7D32; color: white; font-weight: bold;")
        btn.clicked.connect(lambda: logic.build_selected(part))
        return btn

    def _create_separator(self):
        """创建分割线"""
        line = QtWidgets.QFrame()
        line.setFrameShape(QtWidgets.QFrame.HLine)
        line.setFrameShadow(QtWidgets.QFrame.Sunken)
        line.setStyleSheet("background-color: #444;")
        return line
