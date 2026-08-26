"""Native Maya PySide6/QPainter workspace for semantic skeleton and Rig Graph compilation."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
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
        self.skeleton = None
        self.plan = None
        self.receipt = None
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
            self.graph = bind_graph_to_skeleton(golden_biped_graph(), self.skeleton)
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
        self.statusChanged.emit(f"已聚焦绑定模块：{MODULE_LABELS.get(module_id, module_id)}")


__all__ = ["RigGraphCanvas", "RigGraphWorkspace"]
