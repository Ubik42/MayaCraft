"""Native Maya PySide6/QPainter workspace for semantic skeleton and Rig Graph compilation."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
from MayaCraft.adapters.maya.rig_switching import MayaRigSwitchService
from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph
from MayaCraft.ui.theme import ensure_ui_font

UI_FONT_FAMILY = ensure_ui_font()


ACTION_COLORS = {
    "CREATE": "#42E8FF", "PRESERVE": "#526079", "UPDATE": "#A7FF6A",
    "RENAME": "#FFDB69", "REPARENT": "#FFB15C", "REBUILD": "#FF5C7C", "REMOVE": "#FF5C7C",
}
ACTION_LABELS = {
    "CREATE": "创建", "PRESERVE": "保留", "UPDATE": "更新", "RENAME": "重命名",
    "REPARENT": "重设父级", "REBUILD": "重建", "REMOVE": "移除", "AWAITING": "等待扫描",
}
MODULE_LABELS = {
    "root": "角色根", "spine": "脊柱", "head": "头部", "l_arm": "左臂",
    "r_arm": "右臂", "l_leg": "左腿", "r_leg": "右腿",
}
MODULE_TYPE_LABELS = {
    "root": "角色根",
    "fk_chain": "真实 FK 链",
    "ikfk_limb": "FK ↔ IK 链",
}


class RigMatchGauge(QtWidgets.QWidget):
    """Animated FK/IK continuity instrument driven by the real blend value."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self._blend = 0.0
        self._phase = 0.0
        self.setFixedHeight(46)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(32)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_blend(self, value):
        self._blend = max(0.0, min(1.0, float(value)))
        self.update()

    def _tick(self):
        self._phase = (self._phase + 0.018) % 1.0
        if self.isVisible():
            self.update()

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(2, 9, self.width() - 4, 25)
        painter.setPen(QtGui.QPen(QtGui.QColor("#30394E"), 1))
        painter.setBrush(QtGui.QColor("#0A0E16"))
        painter.drawRoundedRect(rect, 8, 8)
        split = rect.left() + rect.width() * 0.5
        painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 120), 2))
        painter.drawLine(rect.left() + 9, rect.center().y(), split - 8, rect.center().y())
        painter.setPen(QtGui.QPen(QtGui.QColor(255, 92, 188, 120), 2))
        painter.drawLine(split + 8, rect.center().y(), rect.right() - 9, rect.center().y())
        x = rect.left() + 10 + (rect.width() - 20) * self._blend
        glow = QtGui.QRadialGradient(QtCore.QPointF(x, rect.center().y()), 11 + math.sin(self._phase * math.tau) * 2)
        glow.setColorAt(0.0, QtGui.QColor("#A7FF6A"))
        glow.setColorAt(1.0, QtGui.QColor(167, 255, 106, 0))
        painter.setPen(QtCore.Qt.NoPen)
        painter.setBrush(glow)
        painter.drawEllipse(QtCore.QPointF(x, rect.center().y()), 12, 12)
        painter.setPen(QtGui.QColor("#DCE5FA"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
        painter.drawText(rect.adjusted(9, 0, -9, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, f"FK {round((1.0 - self._blend) * 100):d}%")
        painter.drawText(rect.adjusted(9, 0, -9, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignRight, f"IK {round(self._blend * 100):d}%")


class RigGraphCanvas(QtWidgets.QWidget):
    moduleHovered = QtCore.Signal(str)
    moduleActivated = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.graph = None
        self.plan = None
        self.skeleton = None
        self._rects = {}
        self._hovered = ""
        self._selected = ""
        self._phase = 0.0
        self.setMouseTracking(True)
        self.setMinimumSize(430, 330)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(32)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_state(self, graph, plan=None, skeleton=None):
        self.graph, self.plan, self.skeleton = graph, plan, skeleton
        self.update()

    def _tick(self):
        self._phase = (self._phase + 0.009) % 1.0
        if self.isVisible():
            self.update()

    @staticmethod
    def _pos(event):
        return event.position() if hasattr(event, "position") else event.localPos()

    def mouseMoveEvent(self, event):
        point = self._pos(event)
        found = next((key for key, rect in self._rects.items() if rect.contains(point)), "")
        if found != self._hovered:
            self._hovered = found
            self.setCursor(QtCore.Qt.PointingHandCursor if found else QtCore.Qt.ArrowCursor)
            self.moduleHovered.emit(found)
            self.update()

    def leaveEvent(self, event):
        self._hovered = ""
        self.moduleHovered.emit("")
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton and self._hovered:
            self._selected = self._hovered
            self.moduleActivated.emit(self._hovered)
            self.update()
            return
        super().mousePressEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = self.rect()
        gradient = QtGui.QRadialGradient(rect.center(), max(rect.width(), rect.height()) * 0.78)
        gradient.setColorAt(0.0, QtGui.QColor("#17132A"))
        gradient.setColorAt(0.52, QtGui.QColor("#0C111B"))
        gradient.setColorAt(1.0, QtGui.QColor("#07080D"))
        painter.fillRect(rect, gradient)
        self._draw_grid(painter, rect)
        if not self.graph:
            painter.setPen(QtGui.QColor("#8791A8"))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "没有绑定图声明")
            return
        self._layout_modules(rect)
        self._draw_connections(painter)
        self._draw_modules(painter)
        self._draw_scan_beam(painter, rect)
        self._draw_legend(painter, rect)

    @staticmethod
    def _draw_grid(painter, rect):
        painter.setPen(QtGui.QPen(QtGui.QColor(55, 66, 92, 48), 1))
        for x in range(16, rect.width(), 28):
            painter.drawLine(x, 0, x, rect.height())
        for y in range(16, rect.height(), 28):
            painter.drawLine(0, y, rect.width(), y)

    def _layout_modules(self, rect):
        width, height = 126.0, 72.0
        cx = rect.center().x()
        top = max(46.0, rect.height() * 0.12)
        arm_spread = min(178.0, max(105.0, (rect.width() - width - 22.0) * 0.5))
        leg_spread = min(138.0, max(132.0, arm_spread * 0.94))
        rows = {
            "root": (cx, top), "spine": (cx, top + 102), "head": (cx, top + 204),
            "l_arm": (cx - arm_spread, top + 204), "r_arm": (cx + arm_spread, top + 204),
            "l_leg": (cx - leg_spread, top + 102), "r_leg": (cx + leg_spread, top + 102),
        }
        self._rects = {}
        for index, module in enumerate(self.graph.modules):
            x, y = rows.get(module.module_id, (cx + (index % 3 - 1) * 160, top + (index // 3) * 102))
            self._rects[module.module_id] = QtCore.QRectF(x - width / 2, y - height / 2, width, height)

    def _draw_connections(self, painter):
        for connection in self.graph.connections:
            source = self._rects.get(connection.source_module)
            target = self._rects.get(connection.target_module)
            if not source or not target:
                continue
            start, end = source.center(), target.center()
            delta = end - start
            length = math.hypot(delta.x(), delta.y()) or 1.0
            unit = QtCore.QPointF(delta.x() / length, delta.y() / length)
            start += unit * 40.0
            end -= unit * 40.0
            path = QtGui.QPainterPath(start)
            control = QtCore.QPointF((start.x() + end.x()) * 0.5, (start.y() + end.y()) * 0.5)
            normal = QtCore.QPointF(-unit.y(), unit.x()) * min(26.0, length * 0.12)
            path.quadTo(control + normal, end)
            color = QtGui.QColor("#42E8FF")
            color.setAlpha(85)
            painter.setPen(QtGui.QPen(color, 1.4))
            painter.drawPath(path)
            moving = path.pointAtPercent(self._phase)
            glow = QtGui.QRadialGradient(moving, 7)
            glow.setColorAt(0, QtGui.QColor(66, 232, 255, 230))
            glow.setColorAt(1, QtGui.QColor(66, 232, 255, 0))
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(glow)
            painter.drawEllipse(moving, 7, 7)

    def _module_action(self, module_id):
        if not self.plan:
            return "AWAITING"
        actions = [item.action for item in self.plan.all_changes if item.owner_module == module_id]
        priority = ("REBUILD", "REMOVE", "REPARENT", "RENAME", "UPDATE", "CREATE", "PRESERVE")
        return next((item for item in priority if item in actions), "PRESERVE")

    def _draw_modules(self, painter):
        for module in self.graph.modules:
            rect = self._rects[module.module_id]
            action = self._module_action(module.module_id)
            color = QtGui.QColor(ACTION_COLORS.get(action, "#9D6CFF"))
            active = module.module_id in {self._hovered, self._selected}
            if active:
                glow = QtGui.QColor(color)
                glow.setAlpha(45)
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(glow)
                painter.drawRoundedRect(rect.adjusted(-7, -7, 7, 7), 16, 16)
            fill = QtGui.QLinearGradient(rect.topLeft(), rect.bottomRight())
            fill.setColorAt(0, QtGui.QColor("#1C2131" if active else "#141925"))
            fill.setColorAt(1, QtGui.QColor("#0E111A"))
            painter.setBrush(fill)
            painter.setPen(QtGui.QPen(color, 1.8 if active else 1.0))
            painter.drawRoundedRect(rect, 12, 12)
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(color)
            painter.drawEllipse(rect.left() - 4, rect.center().y() - 4, 8, 8)
            painter.drawEllipse(rect.right() - 4, rect.center().y() - 4, 8, 8)
            painter.setPen(QtGui.QColor("#F4F7FF"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 10, QtGui.QFont.DemiBold))
            painter.drawText(rect.adjusted(12, 9, -8, -30), QtCore.Qt.AlignLeft, MODULE_LABELS.get(module.module_id, module.display_name))
            painter.setPen(color)
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
            type_label = MODULE_TYPE_LABELS.get(module.module_type, module.module_type)
            behavior_text = f" · {len(module.behaviors)} 路驱动" if module.behaviors else ""
            painter.drawText(
                rect.adjusted(12, 34, -8, -7), QtCore.Qt.AlignLeft,
                f"{type_label} / {ACTION_LABELS.get(action, action)}{behavior_text}",
            )
            if module.module_type == "ikfk_limb":
                lane_y = rect.bottom() - 7.0
                painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 155), 1.4))
                painter.drawLine(rect.left() + 13, lane_y, rect.center().x() - 3, lane_y)
                painter.setPen(QtGui.QPen(QtGui.QColor(255, 92, 188, 155), 1.4))
                painter.drawLine(rect.center().x() + 3, lane_y, rect.right() - 13, lane_y)
                pulse_x = rect.left() + 13 + (rect.width() - 26) * self._phase
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(QtGui.QColor("#A7FF6A"))
                painter.drawEllipse(QtCore.QPointF(pulse_x, lane_y), 2.4, 2.4)

    def _draw_scan_beam(self, painter, rect):
        x = rect.left() + rect.width() * self._phase
        beam = QtGui.QLinearGradient(x - 18, 0, x + 18, 0)
        beam.setColorAt(0, QtGui.QColor(157, 108, 255, 0))
        beam.setColorAt(.5, QtGui.QColor(157, 108, 255, 28))
        beam.setColorAt(1, QtGui.QColor(157, 108, 255, 0))
        painter.fillRect(QtCore.QRectF(x - 18, 0, 36, rect.height()), beam)

    def _draw_legend(self, painter, rect):
        semantic_count = len(self.skeleton.semantics) if self.skeleton else 0
        confidence = int(self.skeleton.confidence * 100) if self.skeleton else 0
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
        painter.setPen(QtGui.QColor("#8791A8"))
        painter.drawText(16, rect.height() - 14, f"语义信号  {semantic_count} 个关节  /  置信度 {confidence}%")


class RigGraphWorkspace(QtWidgets.QWidget):
    statusChanged = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self.graph = golden_biped_graph()
        self.scanner = MayaSkeletonScanner()
        self.service = MayaRigGraphService()
        self.switch_service = MayaRigSwitchService(self.service)
        self.skeleton = None
        self.plan = None
        self.receipt = None
        self.active_limb = ""
        self.pending_switch_plan = None
        self.pending_switch_kind = ""
        self.switch_receipt = None
        self.switch_receipt_kind = ""
        self._build_ui()
        self.refresh_plan()

    def _build_ui(self):
        layout = QtWidgets.QHBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(8)
        self.canvas = RigGraphCanvas()
        self.canvas.moduleHovered.connect(self._hover_module)
        self.canvas.moduleActivated.connect(self._activate_module)
        layout.addWidget(self.canvas, 1)
        panel = QtWidgets.QFrame()
        panel.setObjectName("RigGraphInspector")
        panel.setMinimumWidth(245)
        panel.setMaximumWidth(340)
        side = QtWidgets.QVBoxLayout(panel)
        self._inspector_panel = panel
        self._inspector_layout = side
        side.setContentsMargins(18, 18, 18, 18)
        side.setSpacing(10)
        eyebrow = QtWidgets.QLabel("绑定图 / 实时编译器")
        eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title = QtWidgets.QLabel("黄金双足模板")
        self.title.setStyleSheet("font-size:20px;font-weight:900;")
        self.title.setWordWrap(True)
        self.summary = QtWidgets.QLabel("声明式模块 · 真实矩阵行为 · 物理漂移检测")
        self.summary.setProperty("muted", True)
        self.summary.setWordWrap(True)
        side.addWidget(eyebrow)
        side.addWidget(self.title)
        side.addWidget(self.summary)
        self.signal = QtWidgets.QLabel("骨架信号 / 尚未捕获")
        self.signal.setObjectName("RigGraphSignal")
        self.signal.setWordWrap(True)
        side.addWidget(self.signal)
        self.capture_button = QtWidgets.QPushButton("扫描骨架  ↗")
        self.capture_button.setObjectName("RigGraphCapture")
        self.capture_button.clicked.connect(self.capture_skeleton)
        side.addWidget(self.capture_button)
        self.diff = QtWidgets.QLabel()
        self.diff.setObjectName("RigGraphDiff")
        self.diff.setWordWrap(True)
        self.diff.setMinimumHeight(104)
        side.addWidget(self.diff)
        self.preview_button = QtWidgets.QPushButton("刷新零写入差异")
        self.preview_button.clicked.connect(self.refresh_plan)
        side.addWidget(self.preview_button)
        self.apply_button = QtWidgets.QPushButton("应用并验证")
        self.apply_button.setObjectName("RigGraphApply")
        self.apply_button.clicked.connect(self.apply_plan)
        side.addWidget(self.apply_button)
        self.undo_button = QtWidgets.QPushButton("撤销已验证构建")
        self.undo_button.clicked.connect(self.undo_build)
        self.undo_button.setEnabled(False)
        side.addWidget(self.undo_button)
        self.match_panel = QtWidgets.QFrame()
        self.match_panel.setObjectName("RigMatchCapsule")
        match_layout = QtWidgets.QVBoxLayout(self.match_panel)
        match_layout.setContentsMargins(11, 10, 11, 10)
        match_layout.setSpacing(6)
        match_header = QtWidgets.QHBoxLayout()
        self.match_title = QtWidgets.QLabel("左臂 / 动画匹配舱")
        self.match_title.setStyleSheet("color:#F4F7FF;font-size:10px;font-weight:900;")
        self.match_frame = QtWidgets.QLabel("第 1 帧")
        self.match_frame.setStyleSheet("color:#A7FF6A;font-size:8px;font-weight:800;")
        match_header.addWidget(self.match_title, 1)
        match_header.addWidget(self.match_frame)
        match_layout.addLayout(match_header)
        self.match_gauge = RigMatchGauge()
        match_layout.addWidget(self.match_gauge)
        direction_row = QtWidgets.QHBoxLayout()
        direction_row.setSpacing(6)
        self.fk_to_ik_button = QtWidgets.QPushButton("预览 FK → IK")
        self.fk_to_ik_button.setObjectName("RigMatchFKToIK")
        self.ik_to_fk_button = QtWidgets.QPushButton("预览 IK → FK")
        self.ik_to_fk_button.setObjectName("RigMatchIKToFK")
        self.fk_to_ik_button.clicked.connect(lambda: self.preview_match("FK_TO_IK"))
        self.ik_to_fk_button.clicked.connect(lambda: self.preview_match("IK_TO_FK"))
        direction_row.addWidget(self.fk_to_ik_button)
        direction_row.addWidget(self.ik_to_fk_button)
        match_layout.addLayout(direction_row)
        space_row = QtWidgets.QHBoxLayout()
        self.space_combo = QtWidgets.QComboBox()
        self.space_combo.addItems(("全局空间", "胸腔空间"))
        self.space_preview_button = QtWidgets.QPushButton("预览空间切换")
        self.space_preview_button.clicked.connect(self.preview_space)
        space_row.addWidget(self.space_combo, 1)
        space_row.addWidget(self.space_preview_button)
        match_layout.addLayout(space_row)
        self.match_status = QtWidgets.QLabel("选择方向后生成零写入匹配计划。")
        self.match_status.setWordWrap(True)
        self.match_status.setMinimumHeight(30)
        self.match_status.setStyleSheet("color:#8791A8;font-size:8px;")
        match_layout.addWidget(self.match_status)
        action_row = QtWidgets.QHBoxLayout()
        self.match_apply_button = QtWidgets.QPushButton("应用并在当前帧设键")
        self.match_apply_button.setObjectName("RigMatchApply")
        self.match_apply_button.setEnabled(False)
        self.match_apply_button.clicked.connect(self.apply_switch_plan)
        self.match_undo_button = QtWidgets.QPushButton("撤销")
        self.match_undo_button.setEnabled(False)
        self.match_undo_button.clicked.connect(self.undo_switch)
        action_row.addWidget(self.match_apply_button, 1)
        action_row.addWidget(self.match_undo_button)
        match_layout.addLayout(action_row)
        self.match_panel.setStyleSheet(
            "QFrame#RigMatchCapsule{background:#0C1420;border:1px solid #35566A;border-radius:10px;}"
            "QPushButton#RigMatchFKToIK{color:#071015;background:#42E8FF;border:0;}"
            "QPushButton#RigMatchFKToIK:disabled{color:#45626A;background:#17333A;}"
            "QPushButton#RigMatchIKToFK{color:#160711;background:#FF5CBC;border:0;}"
            "QPushButton#RigMatchIKToFK:disabled{color:#79516A;background:#33192C;}"
            "QPushButton#RigMatchApply{color:#071008;background:#A7FF6A;border:0;font-weight:900;}"
            "QPushButton#RigMatchApply:disabled{color:#5D6B58;background:#233323;}"
            "QComboBox{min-height:30px;color:#DCE5FA;background:#111827;border:1px solid #354158;border-radius:7px;padding:0 8px;}"
        )
        self.match_panel.setVisible(False)
        side.addWidget(self.match_panel)
        side.addStretch(1)
        self.detail = QtWidgets.QLabel("悬停模块以查看编译状态。")
        self.detail.setProperty("muted", True)
        self.detail.setWordWrap(True)
        side.addWidget(self.detail)
        layout.addWidget(panel)

    def resizeEvent(self, event):
        compact = self.height() < 580
        self.summary.setVisible(not compact)
        self.detail.setVisible(not compact)
        self.diff.setMinimumHeight(76 if compact else 104)
        self.diff.setMaximumHeight(82 if compact else 16777215)
        margin = 12 if compact else 18
        self._inspector_layout.setContentsMargins(margin, margin, margin, margin)
        self._inspector_layout.setSpacing(6 if compact else 10)
        super().resizeEvent(event)

    def capture_skeleton(self):
        try:
            self.skeleton = self.scanner.capture_selection()
        except Exception as exc:
            self.signal.setText(f"扫描中止 / {type(exc).__name__}")
            self.statusChanged.emit(str(exc))
            return
        if self.skeleton.is_usable:
            try:
                self.graph = bind_graph_to_skeleton(golden_biped_graph(), self.skeleton)
            except ValueError as exc:
                self.signal.setText("黄金双足模板已阻断\n" + str(exc))
                self.statusChanged.emit(str(exc))
                self.skeleton = None
                self.graph = golden_biped_graph()
                self.canvas.set_state(self.graph, None, None)
                self.refresh_plan()
                return
            self.signal.setText(f"骨架在线 / {len(self.skeleton.joints)} 个关节\n对称度 {self.skeleton.symmetry_score}%  ·  置信度 {self.skeleton.confidence:.0%}")
            self.statusChanged.emit(f"已从 {self.skeleton.root_path.rsplit('|', 1)[-1]} 识别 {len(self.skeleton.semantics)} 个语义关节")
        else:
            self.signal.setText("骨架扫描已阻断 / " + " · ".join(item.message for item in self.skeleton.issues[:2]))
            self.statusChanged.emit(self.skeleton.issues[0].message if self.skeleton.issues else "骨架不可用")
        self.canvas.set_state(self.graph, self.plan, self.skeleton)
        self.refresh_plan()

    def refresh_plan(self):
        try:
            self.plan = self.service.plan(self.graph)
        except Exception as exc:
            self.plan = None
            self.diff.setText(f"差异计算失败\n{type(exc).__name__}: {exc}")
            self.apply_button.setEnabled(False)
            self.statusChanged.emit(str(exc))
            return
        counts = {}
        for change in self.plan.all_changes:
            counts[change.action] = counts.get(change.action, 0) + 1
        lines = [f"{ACTION_LABELS.get(key, key):<9} {value:>2}" for key, value in counts.items()]
        if self.plan.blockers:
            lines += ["", "已阻断", *(item.message for item in self.plan.blockers[:2])]
        elif self.plan.is_noop:
            lines += ["", f"绑定图验证通过 / {len(self.graph.behaviors)} 条行为在线"]
        else:
            lines += [
                "",
                f"{len(self.graph.nodes)} 个对象 · {len(self.graph.behaviors)} 条物理行为",
                f"{self.plan.destructive_count} 项破坏性变更",
            ]
            if not self.skeleton or not self.skeleton.is_usable:
                lines += ["请先扫描并确认语义骨架"]
        self.diff.setText("\n".join(lines))
        ready = self.plan.can_apply and bool(self.skeleton and self.skeleton.is_usable)
        self.apply_button.setEnabled(ready)
        if self.plan.is_noop:
            self.apply_button.setText("绑定图已验证")
        elif not ready:
            self.apply_button.setText("请先扫描骨架")
        else:
            self.apply_button.setText("构建真实 FK 并验证")
        self.canvas.set_state(self.graph, self.plan, self.skeleton)
        self._refresh_match_panel()
        self.statusChanged.emit("绑定图零写入差异已刷新")

    def apply_plan(self):
        if not self.plan or not self.plan.can_apply:
            return
        self.apply_button.setEnabled(False)
        self.apply_button.setText("正在编译…")
        QtWidgets.QApplication.processEvents()
        try:
            self.receipt = self.service.apply(self.graph, self.plan)
        except Exception as exc:
            self.apply_button.setText("事务已中止")
            self.statusChanged.emit(f"绑定构建已回滚：{type(exc).__name__}: {exc}")
            self.refresh_plan()
            return
        self.undo_button.setEnabled(True)
        self.statusChanged.emit(self.receipt.message)
        self.refresh_plan()

    def undo_build(self):
        if not self.receipt:
            return
        try:
            self.service.undo(self.graph, self.receipt)
        except Exception as exc:
            self.statusChanged.emit(f"撤销验证失败：{type(exc).__name__}: {exc}")
            return
        self.receipt = None
        self.undo_button.setEnabled(False)
        self.statusChanged.emit("已撤销验证过的绑定图构建，场景先前状态已恢复")
        self.refresh_plan()

    def _hover_module(self, module_id):
        if not module_id:
            self.detail.setText("悬停模块以查看编译状态。")
            return
        module = next(item for item in self.graph.modules if item.module_id == module_id)
        changes = [item for item in (self.plan.all_changes if self.plan else ()) if item.owner_module == module_id]
        behavior_summary = f"{len(module.nodes)} 个对象 · {len(module.behaviors)} 条真实行为"
        self.detail.setText(
            f"{MODULE_LABELS.get(module_id, module.display_name)} / {MODULE_TYPE_LABELS.get(module.module_type, module.module_type)}\n"
            + behavior_summary + "\n" + "\n".join(item.summary for item in changes[:3])
        )

    def _activate_module(self, module_id):
        self._hover_module(module_id)
        if module_id in {"l_arm", "r_arm", "l_leg", "r_leg"}:
            self.active_limb = module_id
            self._refresh_match_panel()
        self.statusChanged.emit(f"已聚焦绑定模块：{MODULE_LABELS.get(module_id, module_id)}")

    def _refresh_match_panel(self):
        ready = bool(self.plan and self.plan.is_noop)
        if ready and not self.active_limb:
            self.active_limb = "l_arm"
        visible = ready and self.active_limb in {"l_arm", "r_arm", "l_leg", "r_leg"}
        self.match_panel.setVisible(visible)
        self.preview_button.setVisible(not ready)
        self.apply_button.setVisible(not ready)
        if not visible:
            return
        probe = self.switch_service.plan_match(self.graph, self.active_limb, "FK_TO_IK")
        self.match_title.setText(f"{MODULE_LABELS.get(self.active_limb, self.active_limb)} / 动画匹配舱")
        self.match_frame.setText(f"第 {probe.frame:g} 帧")
        self.match_gauge.set_blend(probe.blend_before)
        self.fk_to_ik_button.setEnabled(probe.blend_before < 0.999)
        self.ik_to_fk_button.setEnabled(probe.blend_before > 0.001)
        space_probe = self.switch_service.plan_space(self.graph, self.active_limb, 1, True)
        self.space_combo.blockSignals(True)
        self.space_combo.setCurrentIndex(max(0, min(1, space_probe.previous_space)))
        self.space_combo.blockSignals(False)

    def _show_switch_plan(self, plan, kind):
        self.pending_switch_plan = plan
        self.pending_switch_kind = kind
        self.match_apply_button.setEnabled(plan.can_apply)
        if plan.blockers:
            self.match_status.setStyleSheet("color:#FF7B93;font-size:8px;")
            self.match_status.setText("预检阻断 / " + " · ".join(item.message for item in plan.blockers[:2]))
        elif kind == "match":
            self.match_status.setStyleSheet("color:#42E8FF;font-size:8px;")
            self.match_status.setText(
                f"零写入预览 / {plan.direction_label}\n"
                f"将匹配 {len(plan.targets)} 个控制目标，并在第 {plan.frame:g} 帧写入补偿键。"
            )
        else:
            self.match_status.setStyleSheet("color:#9D6CFF;font-size:8px;")
            guard = f"第 {plan.guard_frame:g} 帧保护键 + " if plan.guard_frame is not None else ""
            self.match_status.setText(
                f"零写入预览 / {plan.previous_label} → {plan.target_label}\n"
                f"{guard}第 {plan.frame:g} 帧补偿世界姿态。"
            )

    def preview_match(self, direction):
        if not self.active_limb:
            return
        try:
            plan = self.switch_service.plan_match(self.graph, self.active_limb, direction)
        except Exception as exc:
            self.match_status.setText(f"预览失败 / {type(exc).__name__}: {exc}")
            return
        self._show_switch_plan(plan, "match")
        self.statusChanged.emit("FK/IK 零写入匹配计划已生成")

    def preview_space(self):
        if not self.active_limb:
            return
        try:
            plan = self.switch_service.plan_space(
                self.graph, self.active_limb, self.space_combo.currentIndex(), True,
            )
        except Exception as exc:
            self.match_status.setText(f"空间预览失败 / {type(exc).__name__}: {exc}")
            return
        self._show_switch_plan(plan, "space")
        self.statusChanged.emit("Space Switch 零写入补偿计划已生成")

    def apply_switch_plan(self):
        if not self.pending_switch_plan or not self.pending_switch_plan.can_apply:
            return
        self.match_apply_button.setEnabled(False)
        self.match_apply_button.setText("正在匹配并验证…")
        QtWidgets.QApplication.processEvents()
        try:
            if self.pending_switch_kind == "match":
                self.switch_receipt = self.switch_service.apply_match(self.graph, self.pending_switch_plan, key=True)
            else:
                self.switch_receipt = self.switch_service.apply_space(self.graph, self.pending_switch_plan, key=True)
            self.switch_receipt_kind = self.pending_switch_kind
        except Exception as exc:
            self.match_status.setStyleSheet("color:#FF7B93;font-size:8px;")
            self.match_status.setText(f"事务已回滚 / {type(exc).__name__}: {exc}")
            self.match_apply_button.setText("重新预览后应用")
            self.statusChanged.emit("动画匹配失败，场景已恢复")
            self._refresh_match_panel()
            return
        self.match_status.setStyleSheet("color:#A7FF6A;font-size:8px;font-weight:800;")
        self.match_status.setText(self.switch_receipt.message + "\n已设关键帧 / 可整块撤销")
        self.match_apply_button.setText("验证通过")
        self.match_undo_button.setEnabled(True)
        self.pending_switch_plan = None
        self.statusChanged.emit(self.switch_receipt.message)
        self._refresh_match_panel()

    def undo_switch(self):
        if not self.switch_receipt:
            return
        try:
            if self.switch_receipt_kind == "match":
                restored = self.switch_service.undo_match(self.graph, self.switch_receipt)
            else:
                restored = self.switch_service.undo_space(self.graph, self.switch_receipt)
        except Exception as exc:
            restored = False
            self.match_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
        if not restored:
            self.statusChanged.emit("动画匹配撤销未能验证，请检查 Maya Undo 队列")
            return
        self.switch_receipt = None
        self.switch_receipt_kind = ""
        self.match_undo_button.setEnabled(False)
        self.match_apply_button.setText("应用并在当前帧设键")
        self.match_status.setStyleSheet("color:#A7FF6A;font-size:8px;")
        self.match_status.setText("撤销验证通过 / 姿态、属性与新增关键帧均已恢复")
        self.statusChanged.emit("无跳变动画操作已撤销并验证")
        self._refresh_match_panel()


__all__ = ["RigGraphCanvas", "RigGraphWorkspace", "RigMatchGauge"]
