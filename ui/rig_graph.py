"""Native Maya PySide6/QPainter workspace for semantic skeleton and Rig Graph compilation."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.bendy_sculpt import MayaBendySculptService
from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
from MayaCraft.adapters.maya.rig_switching import MayaRigSwitchService
from MayaCraft.adapters.maya.twist_sculpt import MayaTwistSculptService
from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.bendy_deformation import sample_bendy_arc
from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph
from MayaCraft.domain.twist_sculpt import compute_twist_profile
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


class TwistEnergyField(QtWidgets.QWidget):
    """Animated quaternion distribution ribbon for the active limb segment."""

    def __init__(self, parent=None):
        super().__init__(parent)
        self._weights = (0.25, 0.5, 0.75)
        self._angle = 0.0
        self._phase = 0.0
        self.setMinimumHeight(106)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(32)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_state(self, weights, angle):
        self._weights = tuple(float(value) for value in weights) or (0.0, 0.0, 0.0)
        self._angle = float(angle)
        self.update()

    def _tick(self):
        self._phase = (self._phase + 0.016) % 1.0
        if self.isVisible():
            self.update()

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(1, 1, self.width() - 2, self.height() - 2)
        background = QtGui.QLinearGradient(rect.topLeft(), rect.bottomRight())
        background.setColorAt(0.0, QtGui.QColor("#081824"))
        background.setColorAt(0.55, QtGui.QColor("#15102A"))
        background.setColorAt(1.0, QtGui.QColor("#20101D"))
        painter.setBrush(background)
        painter.setPen(QtGui.QPen(QtGui.QColor("#3B5570"), 1))
        painter.drawRoundedRect(rect, 10, 10)
        left, right = rect.left() + 24.0, rect.right() - 24.0
        center_y = rect.center().y() + 4.0
        painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 75), 2))
        painter.drawLine(QtCore.QPointF(left, center_y), QtCore.QPointF(right, center_y))
        helix = QtGui.QPainterPath()
        samples = 72
        amplitude = 8.0 + min(10.0, abs(self._angle) / 18.0)
        for index in range(samples + 1):
            t = index / samples
            x = left + (right - left) * t
            y = center_y + math.sin((t * 3.0 + self._phase) * math.tau) * amplitude
            helix.moveTo(x, y) if index == 0 else helix.lineTo(x, y)
        helix_gradient = QtGui.QLinearGradient(left, 0, right, 0)
        helix_gradient.setColorAt(0.0, QtGui.QColor("#42E8FF"))
        helix_gradient.setColorAt(0.5, QtGui.QColor("#B46BFF"))
        helix_gradient.setColorAt(1.0, QtGui.QColor("#FF6E8A"))
        painter.setPen(QtGui.QPen(QtGui.QBrush(helix_gradient), 2.2))
        painter.drawPath(helix)
        for index, weight in enumerate(self._weights):
            x = left + (right - left) * ((index + 1) / (len(self._weights) + 1))
            radius = 7.0 + weight * 7.0
            glow = QtGui.QRadialGradient(QtCore.QPointF(x, center_y), radius * 1.8)
            glow.setColorAt(0.0, QtGui.QColor(167, 255, 106, 150))
            glow.setColorAt(1.0, QtGui.QColor(167, 255, 106, 0))
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(glow)
            painter.drawEllipse(QtCore.QPointF(x, center_y), radius * 1.8, radius * 1.8)
            painter.setBrush(QtGui.QColor("#0A1018"))
            painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 2))
            painter.drawEllipse(QtCore.QPointF(x, center_y), radius, radius)
            painter.setPen(QtGui.QColor("#EAF8D9"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
            painter.drawText(
                QtCore.QRectF(x - 22, center_y - 7, 44, 14),
                QtCore.Qt.AlignCenter, f"{round(weight * 100):d}",
            )
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
        painter.setPen(QtGui.QColor("#42E8FF"))
        painter.drawText(rect.adjusted(10, 6, -10, 0), QtCore.Qt.AlignTop | QtCore.Qt.AlignLeft, "SWING–TWIST / 四元数能量场")
        painter.setPen(QtGui.QColor("#FFB15C"))
        painter.drawText(rect.adjusted(10, 6, -10, 0), QtCore.Qt.AlignTop | QtCore.Qt.AlignRight, f"{self._angle:+.1f}°")


class BendyArcField(QtWidgets.QWidget):
    """Direct-manipulation silhouette ribbon backed by the Bendy arc solver."""

    intentChanged = QtCore.Signal(float, float, float, float)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._handles = [[0.31, -0.28], [0.69, -0.28]]
        self._volume = 0.65
        self._active_handle = -1
        self._hovered_handle = -1
        self._handle_points = []
        self._phase = 0.0
        self._last_arc = None
        self.setMouseTracking(True)
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.setAccessibleName("可拖拽 Bendy 形变弧场")
        self.setMinimumHeight(220)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(40)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    @staticmethod
    def _pos(event):
        return event.position() if hasattr(event, "position") else event.localPos()

    def _tick(self):
        self._phase = (self._phase + 0.012) % 1.0
        if self.isVisible():
            self.update()

    def set_volume_preservation(self, value):
        self._volume = max(0.0, min(1.0, float(value)))
        self._emit_intent()

    def set_intent(self, start_x=0.31, start_y=-0.28, end_x=0.69, end_y=-0.28):
        self._handles = [
            [max(0.12, min(0.48, float(start_x))), max(-0.72, min(0.72, float(start_y)))],
            [max(0.52, min(0.88, float(end_x))), max(-0.72, min(0.72, float(end_y)))],
        ]
        self._emit_intent()

    def set_preset(self, preset):
        if preset == "S":
            self.set_intent(0.31, -0.44, 0.69, 0.44)
        elif preset == "STRAIGHT":
            self.set_intent(0.31, 0.0, 0.69, 0.0)
        else:
            self.set_intent(0.31, -0.34, 0.69, -0.34)

    def control_points(self):
        return (
            (0.0, 0.0, 0.0),
            (self._handles[0][0] * 10.0, -self._handles[0][1] * 5.0, 0.0),
            (self._handles[1][0] * 10.0, -self._handles[1][1] * 5.0, 0.0),
            (10.0, 0.0, 0.0),
        )

    def arc(self):
        self._last_arc = sample_bendy_arc(
            self.control_points(), sample_count=11,
            up_hint=(0.0, 1.0, 0.0), volume_preservation=self._volume,
        )
        return self._last_arc

    def _emit_intent(self):
        self.arc()
        self.intentChanged.emit(
            self._handles[0][0], self._handles[0][1],
            self._handles[1][0], self._handles[1][1],
        )
        self.update()

    def _field_rect(self):
        return QtCore.QRectF(24.0, 42.0, max(80.0, self.width() - 48.0), max(90.0, self.height() - 72.0))

    def _model_to_view(self, point, field):
        return QtCore.QPointF(
            field.left() + field.width() * (point[0] / 10.0),
            field.center().y() - point[1] * field.height() / 5.4,
        )

    def _update_handle_points(self, field):
        self._handle_points = [QtCore.QPointF(
            field.left() + item[0] * field.width(),
            field.center().y() + item[1] * field.height() * 0.72,
        ) for item in self._handles]
        midpoint = self._model_to_view(self.arc().samples[5].position, field)
        self._handle_points.append(midpoint)

    def _hit_handle(self, point):
        return next((index for index, handle in enumerate(self._handle_points)
                     if QtCore.QLineF(point, handle).length() <= 16.0), -1)

    def mouseMoveEvent(self, event):
        point = self._pos(event)
        if self._active_handle >= 0:
            field = self._field_rect()
            normalized_x = (point.x() - field.left()) / max(1.0, field.width())
            normalized_y = (point.y() - field.center().y()) / max(1.0, field.height() * 0.72)
            if self._active_handle < 2:
                lower, upper = ((0.12, 0.48) if self._active_handle == 0 else (0.52, 0.88))
                self._handles[self._active_handle][0] = max(lower, min(upper, normalized_x))
                self._handles[self._active_handle][1] = max(-0.72, min(0.72, normalized_y))
            else:
                current_mid = (self._handles[0][1] + self._handles[1][1]) * 0.5
                target_mid = max(-0.72, min(0.72, normalized_y))
                delta = target_mid - current_mid
                self._handles[0][1] = max(-0.72, min(0.72, self._handles[0][1] + delta))
                self._handles[1][1] = max(-0.72, min(0.72, self._handles[1][1] + delta))
            self._emit_intent()
            return
        hovered = self._hit_handle(point)
        if hovered != self._hovered_handle:
            self._hovered_handle = hovered
            self.setCursor(QtCore.Qt.SizeAllCursor if hovered >= 0 else QtCore.Qt.ArrowCursor)
            self.update()
        super().mouseMoveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton:
            self._active_handle = self._hit_handle(self._pos(event))
            if self._active_handle >= 0:
                self.setFocus(QtCore.Qt.MouseFocusReason)
                self.update()
                return
        super().mousePressEvent(event)

    def mouseReleaseEvent(self, event):
        if self._active_handle >= 0:
            self._active_handle = -1
            self.update()
            return
        super().mouseReleaseEvent(event)

    def keyPressEvent(self, event):
        if self._hovered_handle not in (0, 1, 2):
            return super().keyPressEvent(event)
        step = 0.025 if not (event.modifiers() & QtCore.Qt.ShiftModifier) else 0.008
        dx = -step if event.key() == QtCore.Qt.Key_Left else step if event.key() == QtCore.Qt.Key_Right else 0.0
        dy = -step if event.key() == QtCore.Qt.Key_Up else step if event.key() == QtCore.Qt.Key_Down else 0.0
        if not dx and not dy:
            return super().keyPressEvent(event)
        if self._hovered_handle < 2:
            handle = self._handles[self._hovered_handle]
            lower, upper = ((0.12, 0.48) if self._hovered_handle == 0 else (0.52, 0.88))
            handle[0] = max(lower, min(upper, handle[0] + dx))
            handle[1] = max(-0.72, min(0.72, handle[1] + dy))
        else:
            for handle in self._handles:
                handle[1] = max(-0.72, min(0.72, handle[1] + dy))
        self._emit_intent()

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(1, 1, self.width() - 2, self.height() - 2)
        background = QtGui.QLinearGradient(rect.topLeft(), rect.bottomRight())
        background.setColorAt(0.0, QtGui.QColor("#171713"))
        background.setColorAt(0.52, QtGui.QColor("#101311"))
        background.setColorAt(1.0, QtGui.QColor("#19110F"))
        painter.setBrush(background)
        painter.setPen(QtGui.QPen(QtGui.QColor("#554A3B"), 1))
        painter.drawRoundedRect(rect, 6, 6)
        field = self._field_rect()
        painter.setPen(QtGui.QPen(QtGui.QColor(205, 185, 145, 24), 1, QtCore.Qt.DotLine))
        for index in range(1, 6):
            y = field.top() + field.height() * index / 6.0
            painter.drawLine(QtCore.QPointF(field.left(), y), QtCore.QPointF(field.right(), y))
        arc = self.arc()
        views = [self._model_to_view(sample.position, field) for sample in arc.samples]
        upper, lower = [], []
        base_width = 9.0 + 5.0 * arc.samples[0].volume_scale
        for index, point in enumerate(views):
            before = views[max(0, index - 1)]
            after = views[min(len(views) - 1, index + 1)]
            delta = after - before
            length = math.hypot(delta.x(), delta.y()) or 1.0
            normal = QtCore.QPointF(-delta.y() / length, delta.x() / length)
            belly = math.sin(arc.samples[index].arc_fraction * math.pi)
            width = base_width * (0.72 + belly * 0.38)
            upper.append(point + normal * width)
            lower.append(point - normal * width)
        ribbon = QtGui.QPainterPath(upper[0])
        for point in upper[1:]:
            ribbon.lineTo(point)
        for point in reversed(lower):
            ribbon.lineTo(point)
        ribbon.closeSubpath()
        fill = QtGui.QLinearGradient(field.left(), field.top(), field.right(), field.bottom())
        fill.setColorAt(0.0, QtGui.QColor("#E7D7AE"))
        fill.setColorAt(0.52, QtGui.QColor("#E9825C"))
        fill.setColorAt(1.0, QtGui.QColor("#9E3F32"))
        painter.setBrush(fill)
        painter.setPen(QtGui.QPen(QtGui.QColor("#F5E6C2"), 1.4))
        painter.drawPath(ribbon)
        center = QtGui.QPainterPath(views[0])
        for point in views[1:]:
            center.lineTo(point)
        dash_offset = int(self._phase * 18)
        pen = QtGui.QPen(QtGui.QColor("#301814"), 1.2, QtCore.Qt.DashLine)
        pen.setDashOffset(dash_offset)
        painter.setPen(pen)
        painter.drawPath(center)
        for index, point in enumerate(views):
            if index in (0, len(views) - 1):
                painter.setBrush(QtGui.QColor("#F3E6C8"))
                painter.setPen(QtGui.QPen(QtGui.QColor("#6B5841"), 2))
                painter.drawRect(QtCore.QRectF(point.x() - 5, point.y() - 9, 10, 18))
            elif index % 2 == 0:
                painter.setBrush(QtGui.QColor("#251612"))
                painter.setPen(QtGui.QPen(QtGui.QColor("#F2B071"), 1.4))
                painter.drawEllipse(point, 4.2, 4.2)
        self._update_handle_points(field)
        start, end, belly = self._handle_points
        painter.setPen(QtGui.QPen(QtGui.QColor(240, 177, 113, 120), 1, QtCore.Qt.DashLine))
        painter.drawLine(views[0], start)
        painter.drawLine(views[-1], end)
        for index, point in enumerate(self._handle_points):
            active = index in {self._hovered_handle, self._active_handle}
            radius = 9.0 if index == 2 else 7.0
            painter.setBrush(QtGui.QColor("#FFF0D0" if active else "#F2B071"))
            painter.setPen(QtGui.QPen(QtGui.QColor("#5B281E"), 2))
            painter.drawEllipse(point, radius, radius)
            if index == 2:
                painter.setPen(QtGui.QColor("#4A211A"))
                painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
                painter.drawText(QtCore.QRectF(point.x() - 20, point.y() - 7, 40, 14), QtCore.Qt.AlignCenter, "肌腹")
        compact = self.width() < 360
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 8 if not compact else 7, QtGui.QFont.Bold))
        painter.setPen(QtGui.QColor("#F4E8CE"))
        painter.drawText(
            rect.adjusted(12, 9, -12, 0), QtCore.Qt.AlignTop | QtCore.Qt.AlignLeft,
            "拖动轮廓" if compact else "形变弧场 · 拖动轮廓",
        )
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
        painter.setPen(QtGui.QColor("#E6A46B"))
        painter.drawText(
            rect.adjusted(12, 10, -12, 0), QtCore.Qt.AlignTop | QtCore.Qt.AlignRight,
            (f"{arc.arc_length:.2f} / {arc.samples[0].volume_scale:.0%}" if compact else
             f"弧长 {arc.arc_length:.2f}  ·  截面 {arc.samples[0].volume_scale:.0%}"),
        )



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
        self.bendy_service = MayaBendySculptService(self.service)
        self.switch_service = MayaRigSwitchService(self.service)
        self.twist_service = MayaTwistSculptService(self.service)
        self.skeleton = None
        self.plan = None
        self.receipt = None
        self.active_limb = ""
        self.pending_switch_plan = None
        self.pending_switch_kind = ""
        self.switch_receipt = None
        self.switch_receipt_kind = ""
        self.twist_mode = False
        self.bendy_mode = False
        self.pending_bendy_plan = None
        self.bendy_receipt = None
        self.pending_twist_plan = None
        self.twist_receipt = None
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
        self.eyebrow = QtWidgets.QLabel("绑定图 / 实时编译器")
        self.eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title = QtWidgets.QLabel("黄金双足模板")
        self.title.setStyleSheet("font-size:20px;font-weight:900;")
        self.title.setWordWrap(True)
        self.summary = QtWidgets.QLabel("声明式模块 · 真实矩阵行为 · 物理漂移检测")
        self.summary.setProperty("muted", True)
        self.summary.setWordWrap(True)
        side.addWidget(self.eyebrow)
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
        self.twist_entry_button = QtWidgets.QPushButton("进入 Twist 能量塑形舱  ↗")
        self.twist_entry_button.setObjectName("TwistEntry")
        self.twist_entry_button.clicked.connect(self.show_twist_panel)
        self.bendy_entry_button = QtWidgets.QPushButton("打开形变弧场  ↗")
        self.bendy_entry_button.setObjectName("BendyEntry")
        self.bendy_entry_button.clicked.connect(self.show_bendy_panel)
        match_layout.addWidget(self.bendy_entry_button)
        match_layout.addWidget(self.twist_entry_button)
        self.match_panel.setStyleSheet(
            "QFrame#RigMatchCapsule{background:#0C1420;border:1px solid #35566A;border-radius:10px;}"
            "QPushButton#RigMatchFKToIK{color:#071015;background:#42E8FF;border:0;}"
            "QPushButton#RigMatchFKToIK:disabled{color:#45626A;background:#17333A;}"
            "QPushButton#RigMatchIKToFK{color:#160711;background:#FF5CBC;border:0;}"
            "QPushButton#RigMatchIKToFK:disabled{color:#79516A;background:#33192C;}"
            "QPushButton#RigMatchApply{color:#071008;background:#A7FF6A;border:0;font-weight:900;}"
            "QPushButton#RigMatchApply:disabled{color:#5D6B58;background:#233323;}"
            "QPushButton#BendyEntry{color:#28130D;background:#E7AD73;border:1px solid #FFE1B4;font-weight:900;}"
            "QPushButton#TwistEntry{color:#F7E9FF;background:#3B2057;border:1px solid #9D6CFF;}"
            "QComboBox{min-height:30px;color:#DCE5FA;background:#111827;border:1px solid #354158;border-radius:7px;padding:0 8px;}"
        )
        self.match_panel.setVisible(False)
        side.addWidget(self.match_panel)

        self.bendy_panel = QtWidgets.QFrame()
        self.bendy_panel.setObjectName("BendyArcCapsule")
        bendy_layout = QtWidgets.QVBoxLayout(self.bendy_panel)
        bendy_layout.setContentsMargins(10, 10, 10, 10)
        bendy_layout.setSpacing(7)
        bendy_header = QtWidgets.QHBoxLayout()
        self.bendy_back_button = QtWidgets.QPushButton("‹ 返回匹配")
        self.bendy_back_button.setObjectName("BendyBack")
        self.bendy_back_button.clicked.connect(self.hide_bendy_panel)
        self.bendy_title = QtWidgets.QLabel("左臂 / 形变弧场")
        self.bendy_title.setStyleSheet("color:#F4E8CE;font-size:10px;font-weight:900;")
        bendy_header.addWidget(self.bendy_back_button)
        bendy_header.addWidget(self.bendy_title, 1, QtCore.Qt.AlignRight)
        bendy_layout.addLayout(bendy_header)
        self.bendy_segment_combo = QtWidgets.QComboBox()
        self.bendy_segment_combo.addItems(("上段 · 肩/髋 → 肘/膝", "下段 · 肘/膝 → 腕/踝"))
        self.bendy_segment_combo.currentIndexChanged.connect(self._bendy_segment_changed)
        bendy_layout.addWidget(self.bendy_segment_combo)
        self.bendy_field = BendyArcField()
        self.bendy_field.intentChanged.connect(self._bendy_intent_changed)
        bendy_layout.addWidget(self.bendy_field, 1)
        preset_row = QtWidgets.QHBoxLayout()
        preset_row.setSpacing(5)
        for label, preset in (("自然 C 弧", "C"), ("反向 S 弧", "S"), ("回到直线", "STRAIGHT")):
            button = QtWidgets.QPushButton(label)
            button.setProperty("bendyPreset", True)
            button.clicked.connect(lambda _checked=False, value=preset: self.bendy_field.set_preset(value))
            preset_row.addWidget(button)
        bendy_layout.addLayout(preset_row)
        self.bendy_volume_label = QtWidgets.QLabel("体积保持  65%")
        self.bendy_volume_label.setStyleSheet("color:#EADCC0;font-size:8px;font-weight:700;")
        bendy_layout.addWidget(self.bendy_volume_label)
        self.bendy_volume_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.bendy_volume_slider.setRange(0, 100)
        self.bendy_volume_slider.setValue(65)
        self.bendy_volume_slider.valueChanged.connect(self._bendy_volume_changed)
        bendy_layout.addWidget(self.bendy_volume_slider)
        self.bendy_status = QtWidgets.QLabel("拖动切线或肌腹；当前只计算轮廓，不修改 Maya 场景。")
        self.bendy_status.setWordWrap(True)
        self.bendy_status.setMinimumHeight(30)
        self.bendy_status.setStyleSheet("color:#BFAF92;font-size:8px;")
        bendy_layout.addWidget(self.bendy_status)
        bendy_actions = QtWidgets.QHBoxLayout()
        self.bendy_confirm_button = QtWidgets.QPushButton("生成零写入计划")
        self.bendy_confirm_button.setObjectName("BendyConfirm")
        self.bendy_confirm_button.clicked.connect(self.confirm_bendy_intent)
        self.bendy_apply_button = QtWidgets.QPushButton("应用并验证")
        self.bendy_apply_button.setObjectName("BendyApply")
        self.bendy_apply_button.setEnabled(False)
        self.bendy_apply_button.clicked.connect(self.apply_bendy_intent)
        self.bendy_undo_button = QtWidgets.QPushButton("撤销")
        self.bendy_undo_button.setEnabled(False)
        self.bendy_undo_button.clicked.connect(self.undo_bendy_intent)
        bendy_actions.addWidget(self.bendy_confirm_button)
        bendy_actions.addWidget(self.bendy_apply_button, 1)
        bendy_actions.addWidget(self.bendy_undo_button)
        bendy_layout.addLayout(bendy_actions)
        self.bendy_panel.setStyleSheet(
            "QFrame#BendyArcCapsule{background:#12120F;border:1px solid #6E5A3D;border-radius:6px;}"
            "QPushButton#BendyBack{color:#D5C7AD;background:transparent;border:0;text-align:left;padding:0;}"
            "QPushButton#BendyConfirm{color:#28130D;background:#F0B171;border:0;font-weight:900;}"
            "QPushButton#BendyApply{color:#F8EBCF;background:#7F3F2D;border:1px solid #E9825C;font-weight:900;}"
            "QPushButton#BendyApply:disabled{color:#6E6254;background:#25211B;border-color:#4A4033;}"
            "QComboBox{min-height:28px;color:#F0DEC1;background:#211B15;border:1px solid #5A4C37;border-radius:4px;padding:0 8px;}"
            "QPushButton[bendyPreset=\"true\"]{color:#E8DBC1;background:#252119;border:1px solid #5A4C37;padding:5px;}"
            "QPushButton[bendyPreset=\"true\"]:hover{color:#FFF2D5;background:#3A2D20;border-color:#D89A62;}"
            "QSlider::groove:horizontal{height:5px;background:#332B20;border-radius:2px;}"
            "QSlider::sub-page:horizontal{background:#E9825C;border-radius:2px;}"
            "QSlider::handle:horizontal{width:14px;margin:-5px 0;background:#F5E6C2;border:2px solid #6A3426;border-radius:7px;}"
        )
        self.bendy_panel.setVisible(False)
        side.addWidget(self.bendy_panel)

        self.twist_panel = QtWidgets.QFrame()
        self.twist_panel.setObjectName("TwistSculptCapsule")
        twist_layout = QtWidgets.QVBoxLayout(self.twist_panel)
        twist_layout.setContentsMargins(10, 10, 10, 10)
        twist_layout.setSpacing(7)
        twist_header = QtWidgets.QHBoxLayout()
        self.twist_back_button = QtWidgets.QPushButton("‹ 返回匹配")
        self.twist_back_button.setObjectName("TwistBack")
        self.twist_back_button.clicked.connect(self.hide_twist_panel)
        self.twist_title = QtWidgets.QLabel("Twist 能量塑形舱")
        self.twist_title.setStyleSheet("color:#F4F7FF;font-size:10px;font-weight:900;")
        twist_header.addWidget(self.twist_back_button)
        twist_header.addWidget(self.twist_title, 1, QtCore.Qt.AlignRight)
        twist_layout.addLayout(twist_header)
        self.twist_field = TwistEnergyField()
        twist_layout.addWidget(self.twist_field)
        self.twist_segment_combo = QtWidgets.QComboBox()
        self.twist_segment_combo.addItems(("上段 · 肩/髋 → 肘/膝", "下段 · 肘/膝 → 腕/踝"))
        self.twist_segment_combo.currentIndexChanged.connect(self._twist_values_changed)
        twist_layout.addWidget(self.twist_segment_combo)

        self.twist_bias_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.twist_bias_slider.setRange(-100, 100)
        self.twist_bias_slider.setValue(0)
        self.twist_ease_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.twist_ease_slider.setRange(0, 100)
        self.twist_ease_slider.setValue(65)
        self.twist_intensity_slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.twist_intensity_slider.setRange(0, 100)
        self.twist_intensity_slider.setValue(100)
        self.twist_bias_label = QtWidgets.QLabel()
        self.twist_ease_label = QtWidgets.QLabel()
        self.twist_intensity_label = QtWidgets.QLabel()
        for label, slider in (
            (self.twist_bias_label, self.twist_bias_slider),
            (self.twist_ease_label, self.twist_ease_slider),
            (self.twist_intensity_label, self.twist_intensity_slider),
        ):
            label.setStyleSheet("color:#C5CEE2;font-size:8px;font-weight:700;")
            twist_layout.addWidget(label)
            twist_layout.addWidget(slider)
            slider.valueChanged.connect(self._twist_values_changed)
        self.twist_status = QtWidgets.QLabel("拖动参数观察能量带，再生成零写入计划。")
        self.twist_status.setWordWrap(True)
        self.twist_status.setMinimumHeight(30)
        self.twist_status.setStyleSheet("color:#8791A8;font-size:8px;")
        twist_layout.addWidget(self.twist_status)
        twist_actions = QtWidgets.QHBoxLayout()
        self.twist_preview_button = QtWidgets.QPushButton("预览分布")
        self.twist_preview_button.clicked.connect(self.preview_twist_profile)
        self.twist_apply_button = QtWidgets.QPushButton("应用并验证")
        self.twist_apply_button.setObjectName("TwistApply")
        self.twist_apply_button.setEnabled(False)
        self.twist_apply_button.clicked.connect(self.apply_twist_profile)
        self.twist_undo_button = QtWidgets.QPushButton("撤销")
        self.twist_undo_button.setEnabled(False)
        self.twist_undo_button.clicked.connect(self.undo_twist_profile)
        twist_actions.addWidget(self.twist_preview_button)
        twist_actions.addWidget(self.twist_apply_button, 1)
        twist_actions.addWidget(self.twist_undo_button)
        twist_layout.addLayout(twist_actions)
        self.twist_panel.setStyleSheet(
            "QFrame#TwistSculptCapsule{background:#0B111C;border:1px solid #7650B4;border-radius:10px;}"
            "QPushButton#TwistBack{color:#B6C3DB;background:transparent;border:0;text-align:left;padding:0;}"
            "QPushButton#TwistApply{color:#13091A;background:#D884FF;border:0;font-weight:900;}"
            "QPushButton#TwistApply:disabled{color:#655070;background:#2D2035;}"
            "QComboBox{min-height:30px;color:#F4E9FF;background:#1B1026;border:1px solid #5A397B;border-radius:7px;padding:0 8px;}"
            "QSlider::groove:horizontal{height:4px;background:#253047;border-radius:2px;}"
            "QSlider::sub-page:horizontal{background:#B46BFF;border-radius:2px;}"
            "QSlider::handle:horizontal{width:13px;margin:-5px 0;background:#A7FF6A;border:2px solid #0B111C;border-radius:7px;}"
        )
        self.twist_panel.setVisible(False)
        side.addWidget(self.twist_panel)
        side.addStretch(1)
        self.detail = QtWidgets.QLabel("悬停模块以查看编译状态。")
        self.detail.setProperty("muted", True)
        self.detail.setWordWrap(True)
        side.addWidget(self.detail)
        layout.addWidget(panel)

    def resizeEvent(self, event):
        compact = self.height() < 580
        sculpting = self.twist_mode or self.bendy_mode
        self.summary.setVisible(not compact and not sculpting)
        self.detail.setVisible(not compact and not sculpting)
        self.diff.setMinimumHeight(76 if compact else 104)
        self.diff.setMaximumHeight(82 if compact else 16777215)
        margin = 12 if compact else 18
        self._inspector_layout.setContentsMargins(margin, margin, margin, margin)
        self._inspector_layout.setSpacing(6 if compact else 10)
        narrow = self.width() < 850
        self.bendy_confirm_button.setText("零写入预览" if narrow else "生成零写入计划")
        if not self.bendy_receipt and self.bendy_apply_button.text() not in {"正在塑形…", "重新预览"}:
            self.bendy_apply_button.setText("应用" if narrow else "应用并验证")
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
        self.match_panel.setVisible(visible and not self.twist_mode and not self.bendy_mode)
        self.twist_panel.setVisible(visible and self.twist_mode)
        self.bendy_panel.setVisible(visible and self.bendy_mode)
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
        if self.twist_mode:
            self._refresh_twist_panel()
        elif self.bendy_mode:
            self._refresh_bendy_panel()

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

    def show_twist_panel(self):
        self.twist_mode = True
        self.bendy_mode = False
        self.eyebrow.setText("四元数塑形 / 实时扭转")
        self.eyebrow.setStyleSheet("color:#B46BFF;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title.setText("Twist 能量场")
        self.pending_twist_plan = None
        for widget in (
            self.summary, self.signal, self.capture_button, self.diff,
            self.preview_button, self.apply_button, self.undo_button, self.detail,
        ):
            widget.setVisible(False)
        self.match_panel.setVisible(False)
        self.bendy_panel.setVisible(False)
        self.twist_panel.setVisible(True)
        self._refresh_twist_panel()
        self.statusChanged.emit("已进入 quaternion Twist 能量塑形舱")

    def hide_twist_panel(self):
        self.twist_mode = False
        self.eyebrow.setText("绑定图 / 实时编译器")
        self.eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title.setText("黄金双足模板")
        self.pending_twist_plan = None
        self.twist_panel.setVisible(False)
        compact = self.height() < 580
        self.summary.setVisible(not compact)
        self.detail.setVisible(not compact)
        self.signal.setVisible(True)
        self.capture_button.setVisible(True)
        self.diff.setVisible(True)
        self.undo_button.setVisible(True)
        self._refresh_match_panel()

    def show_bendy_panel(self):
        self.bendy_mode = True
        self.twist_mode = False
        self.pending_bendy_plan = None
        self.eyebrow.setText("形变设计 / 轮廓草绘")
        self.eyebrow.setStyleSheet("color:#E7AD73;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title.setText("形变设计台")
        for widget in (
            self.summary, self.signal, self.capture_button, self.diff,
            self.preview_button, self.apply_button, self.undo_button, self.detail,
        ):
            widget.setVisible(False)
        self.match_panel.setVisible(False)
        self.twist_panel.setVisible(False)
        self.bendy_panel.setVisible(True)
        self._refresh_bendy_panel()
        self.statusChanged.emit("已进入 Bendy 形变弧场，拖动仅更新零写入轮廓")

    def hide_bendy_panel(self):
        self.bendy_mode = False
        self.eyebrow.setText("绑定图 / 实时编译器")
        self.eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:900;letter-spacing:2px;")
        self.title.setText("黄金双足模板")
        self.bendy_panel.setVisible(False)
        compact = self.height() < 580
        self.summary.setVisible(not compact)
        self.detail.setVisible(not compact)
        self.signal.setVisible(True)
        self.capture_button.setVisible(True)
        self.diff.setVisible(True)
        self.undo_button.setVisible(True)
        self._refresh_match_panel()

    def _refresh_bendy_panel(self):
        if not self.active_limb:
            return
        self.bendy_title.setText(f"{MODULE_LABELS.get(self.active_limb, self.active_limb)} / 形变弧场")
        arc = self.bendy_field.arc()
        self.bendy_volume_label.setText(f"体积保持  {self.bendy_volume_slider.value()}%")
        self.bendy_status.setStyleSheet("color:#BFAF92;font-size:9px;")
        self.bendy_status.setText(
            f"零写入轮廓 / {len(arc.samples)} 个等弧长采样点\n"
            f"弧长 {arc.arc_length:.2f} · 伸长 {arc.stretch_ratio:.3f}× · 截面 {arc.samples[0].volume_scale:.1%}"
        )

    def _bendy_intent_changed(self, *_values):
        if not self.bendy_mode:
            return
        self._refresh_bendy_panel()
        self.pending_bendy_plan = None
        self.bendy_apply_button.setEnabled(False)
        self.bendy_status.setText(self.bendy_status.text() + "\n轮廓已改变，Maya 场景保持不变。")

    def _bendy_segment_changed(self, *_values):
        self.pending_bendy_plan = None
        self.bendy_apply_button.setEnabled(False)
        if self.bendy_mode:
            self._refresh_bendy_panel()

    def _bendy_volume_changed(self, value):
        self.bendy_volume_label.setText(f"体积保持  {value}%")
        self.bendy_field.set_volume_preservation(value / 100.0)

    def confirm_bendy_intent(self):
        arc = self.bendy_field.arc()
        controls = self.bendy_field.control_points()[1:3]
        plan = self.bendy_service.plan_sculpt(
            self.graph, self.active_limb,
            self.bendy_segment_combo.currentIndex(), controls,
            self.bendy_volume_slider.value() / 100.0,
        )
        self.pending_bendy_plan = plan
        self.bendy_apply_button.setEnabled(plan.can_apply)
        if plan.blockers:
            self.bendy_status.setStyleSheet("color:#FF765F;font-size:8px;font-weight:800;")
            self.bendy_status.setText("预检阻断 / " + " · ".join(item.message for item in plan.blockers[:2]))
        elif not plan.can_apply:
            self.bendy_status.setStyleSheet("color:#D9BE86;font-size:8px;")
            self.bendy_status.setText("当前形变已与目标一致，无需写入。")
        else:
            self.bendy_status.setStyleSheet("color:#F0B171;font-size:9px;font-weight:800;")
            self.bendy_status.setText(
                f"零写入计划 / {len(plan.target_arc.samples) - 2} 枚 Bendy 关节\n"
                f"目标弧长 {plan.target_arc.arc_length:.3f} · 截面 {plan.target_arc.samples[0].volume_scale:.1%}"
            )
        self.statusChanged.emit("Bendy 零写入形变计划已生成")

    def apply_bendy_intent(self):
        if not self.pending_bendy_plan or not self.pending_bendy_plan.can_apply:
            return
        self.bendy_apply_button.setEnabled(False)
        self.bendy_apply_button.setText("正在塑形…")
        QtWidgets.QApplication.processEvents()
        try:
            self.bendy_receipt = self.bendy_service.apply_sculpt(
                self.graph, self.pending_bendy_plan,
            )
        except Exception as exc:
            self.bendy_status.setStyleSheet("color:#FF765F;font-size:8px;")
            self.bendy_status.setText(f"事务已回滚 / {type(exc).__name__}: {exc}")
            self.bendy_apply_button.setText("重新预览")
            self.statusChanged.emit("Bendy 形变失败，场景已恢复")
            return
        self.pending_bendy_plan = None
        self.bendy_apply_button.setText("验证通过")
        self.bendy_undo_button.setEnabled(True)
        self.bendy_status.setStyleSheet("color:#A7D89B;font-size:8px;font-weight:800;")
        self.bendy_status.setText(self.bendy_receipt.message + "\n曲线、体积与 Twist 子层保持联动，可整块撤销。")
        self.statusChanged.emit(self.bendy_receipt.message)

    def undo_bendy_intent(self):
        if not self.bendy_receipt:
            return
        try:
            restored = self.bendy_service.undo_sculpt(self.graph, self.bendy_receipt)
        except Exception as exc:
            restored = False
            self.bendy_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
        if not restored:
            self.statusChanged.emit("Bendy 撤销未能验证，请检查 Maya Undo 队列")
            return
        self.bendy_receipt = None
        self.bendy_undo_button.setEnabled(False)
        self.bendy_apply_button.setText("应用并验证")
        self.bendy_apply_button.setEnabled(False)
        self.bendy_status.setStyleSheet("color:#A7D89B;font-size:8px;")
        self.bendy_status.setText("撤销验证通过 / 切线控制器、体积与 Bendy 关节均已恢复。")
        self.statusChanged.emit("Bendy 形变已撤销并验证")

    def _twist_parameters(self):
        return (
            self.twist_bias_slider.value() / 100.0,
            self.twist_ease_slider.value() / 100.0,
            self.twist_intensity_slider.value() / 100.0,
        )

    def _refresh_twist_panel(self):
        if not self.active_limb:
            return
        bias, ease, intensity = self._twist_parameters()
        segment = self.twist_segment_combo.currentIndex()
        plan = self.twist_service.plan_profile(
            self.graph, self.active_limb, segment, bias, ease, intensity,
        )
        try:
            angle = self.twist_service.probe_twist_angle(
                self.graph, self.active_limb, segment,
            )
        except Exception:
            angle = 0.0
        weights = plan.previous_weights or compute_twist_profile(3, bias, ease, intensity)
        self.twist_field.set_state(weights, angle)
        self.twist_title.setText(f"{MODULE_LABELS.get(self.active_limb, self.active_limb)} / Twist 塑形")
        self.twist_bias_label.setText(f"分布偏置  {bias:+.2f}  ·  左侧更早 / 右侧更晚")
        self.twist_ease_label.setText(f"缓入曲线  {round(ease * 100):d}%")
        self.twist_intensity_label.setText(f"扭转强度  {round(intensity * 100):d}%")
        if plan.blockers:
            self.twist_status.setStyleSheet("color:#FF7B93;font-size:8px;")
            self.twist_status.setText("塑形阻断 / " + " · ".join(item.message for item in plan.blockers[:2]))
        self.twist_apply_button.setEnabled(False)

    def _twist_values_changed(self, *_args):
        bias, ease, intensity = self._twist_parameters()
        self.twist_bias_label.setText(f"分布偏置  {bias:+.2f}  ·  左侧更早 / 右侧更晚")
        self.twist_ease_label.setText(f"缓入曲线  {round(ease * 100):d}%")
        self.twist_intensity_label.setText(f"扭转强度  {round(intensity * 100):d}%")
        try:
            angle = self.twist_service.probe_twist_angle(
                self.graph, self.active_limb, self.twist_segment_combo.currentIndex(),
            ) if self.active_limb else 0.0
            weights = compute_twist_profile(3, bias, ease, intensity)
        except Exception:
            angle, weights = 0.0, (0.0, 0.0, 0.0)
        self.twist_field.set_state(weights, angle)
        self.pending_twist_plan = None
        self.twist_apply_button.setEnabled(False)
        self.twist_status.setStyleSheet("color:#B6A2D7;font-size:8px;")
        self.twist_status.setText("参数已改变 / 当前仅更新可视化，点击“预览分布”检查 Maya 场景。")

    def preview_twist_profile(self):
        if not self.active_limb:
            return
        bias, ease, intensity = self._twist_parameters()
        plan = self.twist_service.plan_profile(
            self.graph, self.active_limb, self.twist_segment_combo.currentIndex(),
            bias, ease, intensity,
        )
        self.pending_twist_plan = plan
        self.twist_field.set_state(plan.target_weights or plan.previous_weights, self.twist_service.probe_twist_angle(
            self.graph, self.active_limb, self.twist_segment_combo.currentIndex(),
        ))
        self.twist_apply_button.setEnabled(plan.can_apply)
        if plan.blockers:
            self.twist_status.setStyleSheet("color:#FF7B93;font-size:8px;")
            self.twist_status.setText("预检阻断 / " + " · ".join(item.message for item in plan.blockers[:2]))
        elif not plan.can_apply:
            self.twist_status.setStyleSheet("color:#FFDB69;font-size:8px;")
            self.twist_status.setText("当前分布已与目标一致，无需写入。")
        else:
            values = "  ·  ".join(f"J{index + 1} {value:.0%}" for index, value in enumerate(plan.target_weights))
            self.twist_status.setStyleSheet("color:#42E8FF;font-size:8px;")
            self.twist_status.setText(f"零写入预览 / {values}\n将更新实时 quaternion slerp 权重。")
        self.statusChanged.emit("Twist 分布零写入计划已生成")

    def apply_twist_profile(self):
        if not self.pending_twist_plan or not self.pending_twist_plan.can_apply:
            return
        self.twist_apply_button.setEnabled(False)
        self.twist_apply_button.setText("正在塑形…")
        QtWidgets.QApplication.processEvents()
        try:
            self.twist_receipt = self.twist_service.apply_profile(
                self.graph, self.pending_twist_plan,
            )
        except Exception as exc:
            self.twist_status.setStyleSheet("color:#FF7B93;font-size:8px;")
            self.twist_status.setText(f"事务已回滚 / {type(exc).__name__}: {exc}")
            self.twist_apply_button.setText("重新预览")
            self.statusChanged.emit("Twist 塑形失败，场景已恢复")
            return
        self.pending_twist_plan = None
        self.twist_apply_button.setText("验证通过")
        self.twist_undo_button.setEnabled(True)
        self.twist_status.setStyleSheet("color:#A7FF6A;font-size:8px;font-weight:800;")
        self.twist_status.setText(self.twist_receipt.message + "\n实时 Twist 关节已更新，可整块撤销。")
        self.statusChanged.emit(self.twist_receipt.message)

    def undo_twist_profile(self):
        if not self.twist_receipt:
            return
        try:
            restored = self.twist_service.undo_profile(self.graph, self.twist_receipt)
        except Exception as exc:
            restored = False
            self.twist_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
        if not restored:
            self.statusChanged.emit("Twist 撤销未能验证，请检查 Maya Undo 队列")
            return
        self.twist_receipt = None
        self.twist_undo_button.setEnabled(False)
        self.twist_apply_button.setText("应用并验证")
        self.twist_status.setStyleSheet("color:#A7FF6A;font-size:8px;")
        self.twist_status.setText("撤销验证通过 / 三枚 Twist 权重和实时关节姿态均已恢复。")
        self.statusChanged.emit("Twist 能量塑形已撤销并验证")
        self._refresh_twist_panel()


__all__ = [
    "BendyArcField", "RigGraphCanvas", "RigGraphWorkspace",
    "RigMatchGauge", "TwistEnergyField",
]
