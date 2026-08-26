"""Deformation MRI workspace: dense, animated skin-weight diagnostics."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.deformation_mri import MayaDeformationRepairService, MayaDeformationScanner
from MayaCraft.adapters.maya.skin_mirror import MayaSkinMirrorService
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.character import CharacterSnapshot
from MayaCraft.domain.deformation import DeformationReport
from MayaCraft.domain.deformation_space import project_deformation_field, vertices_in_brush
from MayaCraft.ui.theme import ensure_ui_font

UI_FONT_FAMILY = ensure_ui_font()


class DeformationHeatmap(QtWidgets.QWidget):
    vertexActivated = QtCore.Signal(int)
    verticesActivated = QtCore.Signal(object)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._report = DeformationReport()
        self._phase = 0.0
        self._cells = ()
        self._hovered = -1
        self._mirror_plan = None
        self._result = None
        self._projection = None
        self._screen_points = {}
        self._brushing = False
        self._brush_center = None
        self._brush_vertices = ()
        self._mode = "health"
        self._focused_influence = -1
        self._locked_vertices = set()
        self.setMouseTracking(True)
        self.setMinimumHeight(160)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(34)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_report(self, report):
        self._report = report or DeformationReport()
        self._result = None
        self._projection = None
        self._hovered = -1
        self.update()

    def set_result(self, result):
        self._result = result
        self._report = result.report if result else DeformationReport()
        self._projection = project_deformation_field(
            result.vertex_positions, result.report.vertices, result.triangles
        ) if result and result.vertex_positions else None
        self._hovered = -1
        self._brush_vertices = ()
        self._locked_vertices = set(result.inspector.locked_vertices) if result else set()
        self.update()

    def set_mode(self, mode, focused_influence=-1):
        if mode not in {"health", "dominant", "entropy", "locked"}:
            raise ValueError(f"未知 MRI 观察模式：{mode}")
        self._mode = mode
        self._focused_influence = int(focused_influence)
        self.update()

    @property
    def mode(self):
        return self._mode

    def set_mirror_plan(self, plan):
        self._mirror_plan = plan
        self.update()

    def hit_point(self, vertex_index: int):
        if vertex_index in self._screen_points:
            return self._screen_points[vertex_index].toPoint()
        for index, rect in self._cells:
            if index == vertex_index:
                return rect.center().toPoint()
        return None

    def _tick(self):
        self._phase = (self._phase + 0.025) % 1.0
        if self.isVisible() and self._report.vertices:
            self.update()

    def _position(self, event):
        return event.position() if hasattr(event, "position") else event.localPos()

    def mouseMoveEvent(self, event):
        point = self._position(event)
        if self._projection and self._screen_points:
            ranked = sorted(
                ((screen.x() - point.x()) ** 2 + (screen.y() - point.y()) ** 2, index)
                for index, screen in self._screen_points.items()
            )
            hovered = ranked[0][1] if ranked and ranked[0][0] <= 14.0 ** 2 else -1
            if self._brushing:
                self._update_brush(point)
        else:
            hovered = next((index for index, rect in self._cells if rect.contains(point)), -1)
        if hovered != self._hovered:
            self._hovered = hovered
            self.setCursor(QtCore.Qt.PointingHandCursor if hovered >= 0 else QtCore.Qt.ArrowCursor)
            self.update()
        super().mouseMoveEvent(event)

    def leaveEvent(self, event):
        if self._brushing:
            self._brushing = False
        self._hovered = -1
        self.setCursor(QtCore.Qt.ArrowCursor)
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if (
            event.button() == QtCore.Qt.LeftButton
            and self._projection
            and bool(event.modifiers() & QtCore.Qt.ShiftModifier)
        ):
            self._brushing = True
            self._brush_center = self._position(event)
            self._update_brush(self._brush_center)
            event.accept()
            return
        if event.button() == QtCore.Qt.LeftButton and self._hovered >= 0:
            self.vertexActivated.emit(self._hovered)
            event.accept()
            return
        super().mousePressEvent(event)

    def mouseReleaseEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton and self._brushing:
            self._brushing = False
            if self._brush_vertices:
                self.verticesActivated.emit(self._brush_vertices)
            self.update()
            event.accept()
            return
        super().mouseReleaseEvent(event)

    def _update_brush(self, screen_point):
        if not self._projection:
            return
        normalized = self._screen_to_normalized(screen_point)
        extent = max(1.0, min(self.width() - 56.0, self.height() - 70.0))
        self._brush_vertices = vertices_in_brush(self._projection, normalized, radius=56.0 / extent)
        self._brush_center = screen_point
        self.update()

    def _screen_to_normalized(self, point):
        draw = QtCore.QRectF(28.0, 24.0, max(1.0, self.width() - 56.0), max(1.0, self.height() - 70.0))
        return (
            ((point.x() - draw.center().x()) / (draw.width() * 0.46)),
            -((point.y() - draw.center().y()) / (draw.height() * 0.46)),
        )

    @staticmethod
    def _heat_color(heat):
        if heat >= 0.55:
            return QtGui.QColor("#FF416C")
        if heat >= 0.20:
            return QtGui.QColor("#FFB15C")
        if heat >= 0.08:
            return QtGui.QColor("#9D6CFF")
        return QtGui.QColor("#42E8FF")

    @staticmethod
    def _influence_color(index):
        palette = (
            "#42E8FF", "#9D6CFF", "#FF416C", "#A7FF6A", "#FFB15C",
            "#4F8CFF", "#F56CFF", "#2EF2B1", "#FFD866", "#7CFFEE",
        )
        return QtGui.QColor(palette[index % len(palette)] if index >= 0 else "#59647A")

    def _signal_color(self, signal):
        if self._mode == "dominant":
            if self._focused_influence >= 0 and signal.dominant_index != self._focused_influence:
                return QtGui.QColor("#273047")
            return self._influence_color(signal.dominant_index)
        if self._mode == "entropy":
            value = max(0.0, min(1.0, signal.entropy))
            if value < 0.5:
                return self._mix_color(QtGui.QColor("#193C54"), QtGui.QColor("#9D6CFF"), value * 2.0)
            return self._mix_color(QtGui.QColor("#9D6CFF"), QtGui.QColor("#FF416C"), (value - 0.5) * 2.0)
        if self._mode == "locked":
            return QtGui.QColor("#FFB15C") if signal.index in self._locked_vertices else QtGui.QColor("#23374A")
        return self._heat_color(signal.heat)

    @staticmethod
    def _mix_color(left, right, amount):
        amount = max(0.0, min(1.0, float(amount)))
        return QtGui.QColor(
            round(left.red() + (right.red() - left.red()) * amount),
            round(left.green() + (right.green() - left.green()) * amount),
            round(left.blue() + (right.blue() - left.blue()) * amount),
        )

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = self.rect()
        gradient = QtGui.QLinearGradient(0, 0, rect.width(), rect.height())
        gradient.setColorAt(0, QtGui.QColor("#090B12"))
        gradient.setColorAt(0.55, QtGui.QColor("#141329"))
        gradient.setColorAt(1, QtGui.QColor("#09141A"))
        painter.fillRect(rect, gradient)
        painter.setPen(QtGui.QPen(QtGui.QColor(51, 60, 85, 80), 1))
        for y in range(28, rect.height(), 28):
            painter.drawLine(0, y, rect.width(), y)
        vertices = self._report.vertices
        self._cells = ()
        self._screen_points = {}
        if not vertices:
            painter.setPen(QtGui.QColor("#59647A"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 9, QtGui.QFont.DemiBold))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "尚无权重场 / 请运行深度扫描")
            return
        if self._projection and self._projection.vertices:
            self._draw_spatial_field(painter, rect)
            return
        sample_count = min(256, len(vertices))
        bucket_size = max(1, math.ceil(len(vertices) / sample_count))
        buckets = [vertices[index:index + bucket_size] for index in range(0, len(vertices), bucket_size)]
        gap = 2.0
        width = max(2.0, (rect.width() - 30.0 - gap * (len(buckets) - 1)) / len(buckets))
        x = 15.0
        baseline = rect.height() - 36.0
        cells = []
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        mirror_targets = {item.target_index for item in self._mirror_plan.changes} if self._mirror_plan else set()
        for bucket in buckets:
            signal = max(bucket, key=lambda item: item.heat)
            heat = signal.heat
            height = 28.0 + heat * max(38.0, rect.height() - 92.0)
            cell = QtCore.QRectF(x, baseline - height, width, height)
            cells.append((signal.index, QtCore.QRectF(x - 1, 18, width + 2, baseline - 10)))
            color = self._signal_color(signal)
            glow = QtGui.QColor(color)
            glow.setAlpha(32 + int(30 * heat))
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(glow)
            painter.drawRoundedRect(cell.adjusted(-2, -3 - pulse * heat * 3, 2, 2), 3, 3)
            painter.setBrush(color)
            painter.drawRoundedRect(cell, 2, 2)
            if signal.index in mirror_targets:
                painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 1.6))
                painter.setBrush(QtCore.Qt.NoBrush)
                painter.drawRoundedRect(cell.adjusted(-3, -3, 3, 3), 4, 4)
            if signal.index == self._hovered:
                painter.setPen(QtGui.QPen(QtGui.QColor("#FFFFFF"), 1.2))
                painter.setBrush(QtCore.Qt.NoBrush)
                painter.drawRoundedRect(cell.adjusted(-2, -2, 2, 2), 3, 3)
            x += width + gap
        self._cells = tuple(cells)
        scan_x = 15.0 + self._phase * max(1.0, rect.width() - 30.0)
        scan_pen = QtGui.QPen(QtGui.QColor(66, 232, 255, 115), 1.2)
        painter.setPen(scan_pen)
        painter.drawLine(QtCore.QPointF(scan_x, 20), QtCore.QPointF(scan_x, baseline + 2))
        painter.setPen(QtGui.QColor("#8791A8"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
        painter.drawText(QtCore.QRectF(15, baseline + 8, rect.width() - 30, 18), QtCore.Qt.AlignLeft, f"顶点场  0 — {vertices[-1].index}")
        if self._hovered >= 0:
            signal = next((item for item in vertices if item.index == self._hovered), None)
            if signal:
                detail = ", ".join(signal.findings) or "正常"
                painter.setPen(QtGui.QColor("#F4F7FF"))
                painter.drawText(
                    QtCore.QRectF(15, 9, rect.width() - 30, 18),
                    QtCore.Qt.AlignRight,
                    f"顶点 {signal.index} / 热度 {signal.heat:.2f} / 主导 {signal.dominant_index}:{signal.dominant_weight:.2f} / 熵 {signal.entropy:.2f} / {detail}",
                )

    def _draw_spatial_field(self, painter, rect):
        draw = QtCore.QRectF(28.0, 24.0, max(1.0, rect.width() - 56.0), max(1.0, rect.height() - 70.0))
        screen = {
            item.index: QtCore.QPointF(
                draw.center().x() + item.x * draw.width() * 0.46,
                draw.center().y() - item.y * draw.height() * 0.46,
            )
            for item in self._projection.vertices
        }
        self._screen_points = screen
        by_index = {item.index: item for item in self._projection.vertices}
        triangles = sorted(
            self._projection.triangles,
            key=lambda tri: sum(by_index[index].depth for index in tri) / 3.0,
        )
        for triangle in triangles:
            values = tuple(by_index[index] for index in triangle)
            heat = sum(item.heat for item in values) / 3.0
            depth = sum(item.depth for item in values) / 3.0
            vertex_colors = tuple(self._signal_color(item) for item in values)
            color = QtGui.QColor(
                sum(item.red() for item in vertex_colors) // 3,
                sum(item.green() for item in vertex_colors) // 3,
                sum(item.blue() for item in vertex_colors) // 3,
            )
            signal_strength = (
                sum(item.entropy for item in values) / 3.0 if self._mode == "entropy"
                else sum(item.index in self._locked_vertices for item in values) / 3.0 if self._mode == "locked"
                else heat
            )
            color.setAlpha(28 + int(105 * min(1.0, signal_strength + 0.12)) + int(15 * max(-1.0, min(1.0, depth))))
            polygon = QtGui.QPolygonF(tuple(screen[index] for index in triangle))
            painter.setBrush(color)
            painter.setPen(QtGui.QPen(QtGui.QColor(75, 94, 125, 68), 0.65))
            painter.drawPolygon(polygon)
        mirror_targets = {item.target_index for item in self._mirror_plan.changes} if self._mirror_plan else set()
        brush_set = set(self._brush_vertices)
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        for item in sorted(self._projection.vertices, key=lambda value: value.depth):
            point = screen[item.index]
            color = self._signal_color(item)
            radius = 2.0 + item.heat * 4.5
            emphasized = (
                item.entropy >= 0.65 if self._mode == "entropy"
                else item.index in self._locked_vertices if self._mode == "locked"
                else self._focused_influence == item.dominant_index if self._mode == "dominant" and self._focused_influence >= 0
                else item.heat >= 0.12
            )
            if emphasized:
                glow = QtGui.QColor(color)
                glow.setAlpha(28 + int(35 * pulse))
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(glow)
                painter.drawEllipse(point, radius + 5.0 + pulse * 2.0, radius + 5.0 + pulse * 2.0)
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(color)
            painter.drawEllipse(point, radius, radius)
            if item.index == self._hovered or item.index in mirror_targets or item.index in brush_set:
                outline = "#FFFFFF" if item.index == self._hovered else "#A7FF6A" if item.index in mirror_targets else "#42E8FF"
                painter.setBrush(QtCore.Qt.NoBrush)
                painter.setPen(QtGui.QPen(QtGui.QColor(outline), 1.4))
                painter.drawEllipse(point, radius + 3.0, radius + 3.0)
        scan_y = draw.top() + self._phase * draw.height()
        painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 68), 1.0))
        painter.drawLine(QtCore.QPointF(draw.left(), scan_y), QtCore.QPointF(draw.right(), scan_y))
        if self._brush_center is not None and (self._brushing or self._brush_vertices):
            painter.setBrush(QtGui.QColor(66, 232, 255, 18))
            painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 150), 1.1, QtCore.Qt.DashLine))
            painter.drawEllipse(self._brush_center, 28.0, 28.0)
        painter.setPen(QtGui.QColor("#8791A8"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.Bold))
        painter.drawText(
            QtCore.QRectF(28, rect.height() - 30, rect.width() - 56, 18),
            QtCore.Qt.AlignLeft,
            f"{self._mode_label()} / {self._projection.source_count} 个顶点 / Shift + 拖拽局部刷选",
        )
        if self._hovered >= 0:
            signal = next((item for item in self._report.vertices if item.index == self._hovered), None)
            if signal:
                detail = "，".join(signal.findings) or "正常"
                painter.setPen(QtGui.QColor("#F4F7FF"))
                painter.drawText(
                    QtCore.QRectF(28, 6, rect.width() - 56, 18), QtCore.Qt.AlignRight,
                    f"顶点 {signal.index} / 热度 {signal.heat:.2f} / 主导 {signal.dominant_index}:{signal.dominant_weight:.2f} / 熵 {signal.entropy:.2f} / {detail}",
                )

    def _mode_label(self):
        return {
            "health": "综合异常热力场",
            "dominant": "主导影响骨骼分区",
            "entropy": "混合熵扩散场",
            "locked": "锁定影响骨骼覆盖场",
        }[self._mode]


class InfluenceSpectrum(QtWidgets.QWidget):
    influenceActivated = QtCore.Signal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._report = None
        self._items = ()
        self._cells = ()
        self._hovered = -1
        self._active = -1
        self._phase = 0.0
        self.setMouseTracking(True)
        self.setMinimumHeight(58)
        self.setMaximumHeight(72)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(42)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_report(self, report):
        self._report = report
        influences = report.influences if report else ()
        self._items = tuple(sorted(
            influences,
            key=lambda item: (-item.total_weight, item.index),
        )[:14])
        self._hovered = -1
        self._active = -1
        self.update()

    def set_active(self, index):
        self._active = int(index)
        self.update()

    def hit_point(self, index):
        return next((rect.center().toPoint() for item_index, rect in self._cells if item_index == index), None)

    def _tick(self):
        self._phase = (self._phase + 0.035) % 1.0
        if self.isVisible() and self._items:
            self.update()

    def mouseMoveEvent(self, event):
        point = event.position() if hasattr(event, "position") else event.localPos()
        hovered = next((index for index, rect in self._cells if rect.contains(point)), -1)
        if hovered != self._hovered:
            self._hovered = hovered
            self.setCursor(QtCore.Qt.PointingHandCursor if hovered >= 0 else QtCore.Qt.ArrowCursor)
            self.update()
        super().mouseMoveEvent(event)

    def leaveEvent(self, event):
        self._hovered = -1
        self.setCursor(QtCore.Qt.ArrowCursor)
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton and self._hovered >= 0:
            self._active = self._hovered
            self.influenceActivated.emit(self._active)
            self.update()
            event.accept()
            return
        super().mousePressEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(self.rect()).adjusted(1, 1, -1, -1)
        painter.setPen(QtGui.QPen(QtGui.QColor(70, 84, 118, 90), 1))
        painter.setBrush(QtGui.QColor(8, 13, 24, 205))
        painter.drawRoundedRect(rect, 7, 7)
        if not self._items:
            painter.setPen(QtGui.QColor("#59647A"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 8, QtGui.QFont.DemiBold))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "扫描后显示影响骨骼覆盖光谱")
            self._cells = ()
            return
        content = rect.adjusted(9, 6, -9, -5)
        gap = 4.0
        width = max(24.0, (content.width() - gap * (len(self._items) - 1)) / len(self._items))
        maximum = max(item.total_weight for item in self._items) or 1.0
        cells = []
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        for slot, item in enumerate(self._items):
            x = content.left() + slot * (width + gap)
            cell = QtCore.QRectF(x, content.top(), width, content.height())
            cells.append((item.index, cell))
            ratio = item.total_weight / maximum
            bar = QtCore.QRectF(x, content.bottom() - 12.0 - ratio * 24.0, width, 4.0 + ratio * 24.0)
            color = DeformationHeatmap._influence_color(item.index)
            glow = QtGui.QColor(color)
            glow.setAlpha(28 + int(24 * pulse))
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(glow)
            painter.drawRoundedRect(bar.adjusted(-2, -2, 2, 1), 3, 3)
            painter.setBrush(color)
            painter.drawRoundedRect(bar, 2, 2)
            dominant_ratio = item.dominant_vertex_count / max(1, item.affected_vertex_count)
            dominant_y = bar.bottom() - dominant_ratio * bar.height()
            painter.setPen(QtGui.QPen(QtGui.QColor(245, 248, 255, 210), 1.5))
            painter.drawLine(QtCore.QPointF(x + 1, dominant_y), QtCore.QPointF(x + width - 1, dominant_y))
            if item.locked:
                painter.setPen(QtGui.QPen(QtGui.QColor("#FFB15C"), 1.4))
                painter.drawLine(QtCore.QPointF(x, content.top() + 1), QtCore.QPointF(x + width, content.top() + 1))
            if item.index in {self._hovered, self._active}:
                painter.setBrush(QtCore.Qt.NoBrush)
                painter.setPen(QtGui.QPen(
                    QtGui.QColor("#FFFFFF" if item.index == self._hovered else "#42E8FF"), 1.2
                ))
                painter.drawRoundedRect(cell.adjusted(-1, -1, 1, 1), 4, 4)
            painter.setPen(QtGui.QColor("#A8B2C8"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6, QtGui.QFont.DemiBold))
            name = QtGui.QFontMetrics(painter.font()).elidedText(item.leaf_name, QtCore.Qt.ElideRight, int(width))
            painter.drawText(QtCore.QRectF(x, content.bottom() - 10, width, 10), QtCore.Qt.AlignCenter, name)
        self._cells = tuple(cells)
        if self._hovered >= 0:
            item = next(value for value in self._items if value.index == self._hovered)
            text = (
                f"{item.leaf_name}  /  覆盖 {item.affected_vertex_count}  /  主导 {item.dominant_vertex_count}"
                f"  /  累计权重 {item.total_weight:.1f}" + ("  /  已锁定" if item.locked else "")
            )
            painter.setPen(QtGui.QColor("#F4F7FF"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
            painter.drawText(QtCore.QRectF(12, 2, rect.width() - 24, 13), QtCore.Qt.AlignRight, text)


class DeformationMRIWorkspace(QtWidgets.QWidget):
    statusChanged = QtCore.Signal(str)
    componentActivated = QtCore.Signal(str)
    componentsActivated = QtCore.Signal(object)
    influenceActivated = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._snapshot = CharacterSnapshot.empty()
        self._scanner = MayaDeformationScanner()
        self._repair = MayaDeformationRepairService()
        self._mirror = MayaSkinMirrorService()
        self._result = None
        self._repair_plan = None
        self._repair_receipt = None
        self._mirror_plan = None
        self._mirror_receipt = None
        self._build_ui()

    @property
    def result(self):
        return self._result

    def _build_ui(self):
        root = QtWidgets.QVBoxLayout(self)
        self._root_layout = root
        root.setContentsMargins(18, 16, 18, 16)
        root.setSpacing(10)
        header = QtWidgets.QHBoxLayout()
        titles = QtWidgets.QVBoxLayout()
        eyebrow = QtWidgets.QLabel("变形 MRI / 实时权重场")
        eyebrow.setStyleSheet("color:#9D6CFF;font-size:9px;font-weight:900;letter-spacing:2px;")
        self.title = QtWidgets.QLabel("理解蒙皮，而不是再造一张权重表。")
        self.title.setStyleSheet("font-size:21px;font-weight:850;")
        titles.addWidget(eyebrow)
        titles.addWidget(self.title)
        self.scan_button = QtWidgets.QPushButton("运行深度扫描  /")
        self.scan_button.setObjectName("MRIScanButton")
        self.scan_button.clicked.connect(self.scan)
        header.addLayout(titles, 1)
        header.addWidget(self.scan_button)
        root.addLayout(header)

        metrics = QtWidgets.QHBoxLayout()
        self.metric_labels = {}
        self.metric_captions = []
        for key, label in (("score", "权重场评分"), ("hotspots", "异常热点"), ("normalization", "权重和错误"), ("fragments", "碎片权重"), ("time", "扫描毫秒")):
            card = QtWidgets.QFrame()
            card.setObjectName("MRIMetric")
            layout = QtWidgets.QVBoxLayout(card)
            layout.setContentsMargins(11, 8, 11, 8)
            value = QtWidgets.QLabel("—")
            value.setStyleSheet("font-size:18px;font-weight:900;color:#F4F7FF;")
            caption = QtWidgets.QLabel(label)
            caption.setProperty("muted", True)
            caption.setStyleSheet("font-size:7px;font-weight:800;letter-spacing:1px;")
            layout.addWidget(value)
            layout.addWidget(caption)
            self.metric_captions.append(caption)
            self.metric_labels[key] = value
            metrics.addWidget(card)
        root.addLayout(metrics)
        inspector_header = QtWidgets.QFrame()
        inspector_header.setObjectName("MRIInspectorHeader")
        inspector_layout = QtWidgets.QHBoxLayout(inspector_header)
        inspector_layout.setContentsMargins(10, 6, 10, 6)
        inspector_layout.setSpacing(6)
        inspector_title = QtWidgets.QLabel("诊断光谱")
        inspector_title.setStyleSheet("color:#F4F7FF;font-size:8px;font-weight:900;")
        inspector_layout.addWidget(inspector_title)
        self.inspector_mode_group = QtWidgets.QButtonGroup(self)
        self.inspector_mode_group.setExclusive(True)
        self.inspector_mode_buttons = {}
        for mode, label in (
            ("health", "综合热度"),
            ("dominant", "主导骨骼"),
            ("entropy", "混合熵"),
            ("locked", "锁定影响"),
        ):
            button = QtWidgets.QToolButton()
            button.setText(label)
            button.setCheckable(True)
            button.setChecked(mode == "health")
            button.setProperty("mriMode", True)
            button.setStyleSheet(
                "QToolButton{color:#8791A8;background:#0D1320;border:1px solid #27334A;"
                "border-radius:5px;padding:4px 9px;font-size:8px;font-weight:800;}"
                "QToolButton:hover{color:#F4F7FF;border-color:#596C98;}"
                "QToolButton:checked{color:#061018;background:#42E8FF;border-color:#7CFFEE;}"
            )
            button.clicked.connect(lambda _checked=False, value=mode: self._set_inspector_mode(value))
            self.inspector_mode_group.addButton(button)
            self.inspector_mode_buttons[mode] = button
            inspector_layout.addWidget(button)
        self.inspector_summary = QtWidgets.QLabel("扫描后可切换权重场的诊断维度")
        self.inspector_summary.setProperty("muted", True)
        self.inspector_summary.setAlignment(QtCore.Qt.AlignRight | QtCore.Qt.AlignVCenter)
        self.inspector_summary.setStyleSheet("font-size:8px;")
        inspector_layout.addWidget(self.inspector_summary, 1)
        root.addWidget(inspector_header)
        self.heatmap = DeformationHeatmap()
        self.heatmap.vertexActivated.connect(self._activate_vertex)
        self.heatmap.verticesActivated.connect(self._activate_vertices)
        root.addWidget(self.heatmap, 1)
        self.influence_spectrum = InfluenceSpectrum()
        self.influence_spectrum.influenceActivated.connect(self._focus_influence)
        root.addWidget(self.influence_spectrum)
        repair = QtWidgets.QFrame()
        repair.setObjectName("MRIRepairCapsule")
        repair_layout = QtWidgets.QHBoxLayout(repair)
        repair_layout.setContentsMargins(12, 9, 12, 9)
        copy = QtWidgets.QVBoxLayout()
        repair_eyebrow = QtWidgets.QLabel("安全修复 / 仅归一化")
        repair_eyebrow.setStyleSheet("color:#A7FF6A;font-size:7px;font-weight:900;letter-spacing:1px;")
        self.repair_status = QtWidgets.QLabel("精确预览修复前后向量；不执行裁剪或艺术性重分配。")
        self.repair_status.setProperty("muted", True)
        self.repair_status.setStyleSheet("font-size:8px;")
        copy.addWidget(repair_eyebrow)
        copy.addWidget(self.repair_status)
        self.preview_repair_button = QtWidgets.QPushButton("预览归一化")
        self.preview_repair_button.clicked.connect(self.preview_repair)
        self.apply_repair_button = QtWidgets.QPushButton("应用并验证")
        self.apply_repair_button.setObjectName("MRIApplyButton")
        self.apply_repair_button.setEnabled(False)
        self.apply_repair_button.clicked.connect(self.apply_repair)
        self.undo_repair_button = QtWidgets.QPushButton("撤销")
        self.undo_repair_button.setEnabled(False)
        self.undo_repair_button.clicked.connect(self.undo_repair)
        repair_layout.addLayout(copy, 1)
        repair_layout.addWidget(self.preview_repair_button)
        repair_layout.addWidget(self.apply_repair_button)
        repair_layout.addWidget(self.undo_repair_button)
        root.addWidget(repair)
        mirror = QtWidgets.QFrame()
        mirror.setObjectName("MRIMirrorCapsule")
        mirror_layout = QtWidgets.QHBoxLayout(mirror)
        mirror_layout.setContentsMargins(12, 9, 12, 9)
        mirror_copy = QtWidgets.QVBoxLayout()
        mirror_eyebrow = QtWidgets.QLabel("对称迁移 / 空间 + 语义")
        mirror_eyebrow.setStyleSheet("color:#42E8FF;font-size:7px;font-weight:900;letter-spacing:1px;")
        self.mirror_status = QtWidgets.QLabel("先按语义配对影响骨骼，再按镜像世界坐标配对顶点。")
        self.mirror_status.setProperty("muted", True)
        self.mirror_status.setStyleSheet("font-size:8px;")
        self.mirror_status.setWordWrap(True)
        mirror_copy.addWidget(mirror_eyebrow)
        mirror_copy.addWidget(self.mirror_status)
        self.mirror_direction = QtWidgets.QComboBox()
        self.mirror_direction.setObjectName("MRIMirrorDirection")
        self.mirror_direction.addItem("L  →  R", "left_to_right")
        self.mirror_direction.addItem("R  →  L", "right_to_left")
        self.preview_mirror_button = QtWidgets.QPushButton("预览镜像")
        self.preview_mirror_button.clicked.connect(self.preview_mirror)
        self.apply_mirror_button = QtWidgets.QPushButton("应用并验证")
        self.apply_mirror_button.setObjectName("MRIMirrorApply")
        self.apply_mirror_button.setEnabled(False)
        self.apply_mirror_button.clicked.connect(self.apply_mirror)
        self.undo_mirror_button = QtWidgets.QPushButton("撤销")
        self.undo_mirror_button.setEnabled(False)
        self.undo_mirror_button.clicked.connect(self.undo_mirror)
        mirror_layout.addLayout(mirror_copy, 1)
        mirror_layout.addWidget(self.mirror_direction)
        mirror_layout.addWidget(self.preview_mirror_button)
        mirror_layout.addWidget(self.apply_mirror_button)
        mirror_layout.addWidget(self.undo_mirror_button)
        root.addWidget(mirror)
        self.findings = QtWidgets.QLabel("选择已关联或已捕获的角色，然后扫描其 skinCluster。")
        self.findings.setProperty("muted", True)
        self.findings.setWordWrap(True)
        self.findings.setStyleSheet("font-size:9px;")
        root.addWidget(self.findings)

    def resizeEvent(self, event):
        self._apply_compact_layout(self.height() < 680)
        super().resizeEvent(event)

    def _apply_compact_layout(self, compact):
        self._root_layout.setContentsMargins(10, 9, 10, 9) if compact else self._root_layout.setContentsMargins(18, 16, 18, 16)
        self._root_layout.setSpacing(6 if compact else 10)
        self.heatmap.setMinimumHeight(118 if compact else 160)
        self.influence_spectrum.setMinimumHeight(42 if compact else 58)
        self.influence_spectrum.setMaximumHeight(46 if compact else 72)
        self.repair_status.setVisible(not compact)
        self.mirror_status.setVisible(not compact)
        self.findings.setMaximumHeight(30 if compact else 16777215)
        for caption in self.metric_captions:
            caption.setVisible(not compact)

    def set_snapshot(self, snapshot):
        changed = snapshot.stable_id != self._snapshot.stable_id
        if changed:
            self._result = None
            self._repair_plan = None
            self._repair_receipt = None
            self._mirror_plan = None
            self._mirror_receipt = None
            self.heatmap.set_report(None)
            self.heatmap.set_mirror_plan(None)
            self.influence_spectrum.set_report(None)
            self.inspector_summary.setText("扫描后可切换权重场的诊断维度")
            for label in self.metric_labels.values():
                label.setText("—")
        self._snapshot = snapshot
        self.title.setText(f"{snapshot.display_name} / 蒙皮智能" if not snapshot.is_empty else "理解蒙皮，而不是再造一张权重表。")
        self.scan_button.setEnabled(not snapshot.is_empty)
        if changed:
            self.preview_repair_button.setEnabled(False)
            self.apply_repair_button.setEnabled(False)
            self.undo_repair_button.setEnabled(False)
            self.preview_mirror_button.setEnabled(False)
            self.apply_mirror_button.setEnabled(False)
            self.undo_mirror_button.setEnabled(False)

    def scan(self):
        if self._snapshot.is_empty:
            return
        self.scan_button.setEnabled(False)
        self.scan_button.setText("正在读取权重场…")
        QtWidgets.QApplication.processEvents()
        try:
            results = self._scanner.scan_character(self._snapshot)
        except Exception as exc:
            self.findings.setText(f"扫描安全失败：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.findings.text())
            results = ()
        finally:
            self.scan_button.setEnabled(True)
            self.scan_button.setText("运行深度扫描  /")
        if not results:
            self._result = None
            self.heatmap.set_report(None)
            self.findings.setText("在已捕获的角色根节点下没有找到 skinCluster。")
            self.statusChanged.emit(self.findings.text())
            return
        self._result = max(results, key=lambda item: len(item.report.vertices))
        report = self._result.report
        self.heatmap.set_result(self._result)
        self.influence_spectrum.set_report(self._result.inspector)
        self._set_inspector_mode(self.heatmap.mode)
        values = {
            "score": str(report.score),
            "hotspots": str(report.hotspot_count),
            "normalization": str(report.normalization_count),
            "fragments": str(report.fragment_count),
            "time": f"{self._result.elapsed_ms:.1f}",
        }
        for key, value in values.items():
            self.metric_labels[key].setText(value)
        hottest = report.hottest[:3]
        summary = "  /  ".join(
            f"顶点[{item.index}] {item.heat:.2f} {'; '.join(item.findings) or '正常'}"
            for item in hottest
        )
        influence_state = (
            f"{len(self._result.locked_influences)} 个锁定 / {len(self._result.missing_influences)} 个缺失"
        )
        self.findings.setText(f"{self._result.skin_cluster}  ·  {len(report.vertices)} 个顶点  ·  {len(self._result.influences)} 个影响骨骼  ·  {influence_state}\n{summary}")
        self.statusChanged.emit(f"变形 MRI 已在 {self._result.elapsed_ms:.1f} 毫秒内扫描 {len(report.vertices)} 个顶点")
        self.preview_repair_button.setEnabled(report.normalization_count > 0)
        self.preview_mirror_button.setEnabled(True)

    def _set_inspector_mode(self, mode):
        button = self.inspector_mode_buttons.get(mode)
        if button and not button.isChecked():
            button.setChecked(True)
        focused = self.influence_spectrum._active if mode == "dominant" else -1
        self.heatmap.set_mode(mode, focused_influence=focused)
        if self._result is None:
            return
        inspector = self._result.inspector
        if mode == "health":
            text = f"{self._result.report.hotspot_count} 个热点 / 评分 {self._result.report.score}"
        elif mode == "dominant":
            active = next((item for item in inspector.influences if item.index == focused), None)
            text = (
                f"聚焦 {active.leaf_name} / 主导 {active.dominant_vertex_count} 个顶点"
                if active else f"{len(inspector.influences)} 个影响骨骼 / 点击下方光谱聚焦"
            )
        elif mode == "entropy":
            values = self._result.report.vertices
            mean = sum(item.entropy for item in values) / max(1, len(values))
            text = f"{len(inspector.high_entropy_vertices)} 个高混合顶点 / 平均熵 {mean:.2f}"
        else:
            locked_count = sum(item.locked for item in inspector.influences)
            text = f"{locked_count} 个锁定影响 / 覆盖 {len(inspector.locked_vertices)} 个顶点"
            if inspector.missing_influences:
                text += f" / {len(inspector.missing_influences)} 个矩阵空洞"
        self.inspector_summary.setText(text)
        self.inspector_summary.setToolTip(
            "缺失连接：" + "，".join(inspector.missing_influences)
            if inspector.missing_influences else ""
        )
        self.statusChanged.emit(f"MRI 诊断模式：{button.text() if button else mode} / {text}")

    def _focus_influence(self, index):
        if self._result is None:
            return
        diagnostic = next(
            (item for item in self._result.inspector.influences if item.index == index), None
        )
        if diagnostic is None:
            return
        self.inspector_mode_buttons["dominant"].setChecked(True)
        self.heatmap.set_mode("dominant", focused_influence=index)
        self.influence_spectrum.set_active(index)
        self.inspector_summary.setText(
            f"聚焦 {diagnostic.leaf_name} / 覆盖 {diagnostic.affected_vertex_count} / "
            f"主导 {diagnostic.dominant_vertex_count}" + (" / 已锁定" if diagnostic.locked else "")
        )
        self.influenceActivated.emit(diagnostic.path)

    def preview_repair(self):
        if self._result is None:
            return
        try:
            plan = self._repair.plan(self._result)
        except Exception as exc:
            self.repair_status.setText(f"预览安全失败：{type(exc).__name__}: {exc}")
            return
        self._repair_plan = plan
        self._repair_receipt = None
        self.undo_repair_button.setEnabled(False)
        if plan.blockers:
            self.repair_status.setText("已阻断 / " + " / ".join(plan.blockers))
            self.apply_repair_button.setEnabled(False)
        elif plan.is_noop:
            self.repair_status.setText("预览验证通过 / 没有剩余的非零归一化错误")
            self.apply_repair_button.setEnabled(False)
        else:
            largest = max(abs(sum(change.before) - 1.0) for change in plan.changes)
            self.repair_status.setText(
                f"零写入 / {len(plan.changes)} 个向量 / 最大权重和误差 {largest:.4f} / Maya 撤销块已就绪"
            )
            self.apply_repair_button.setEnabled(True)
        self.statusChanged.emit(self.repair_status.text())

    def apply_repair(self):
        if self._repair_plan is None or not self._repair_plan.can_apply:
            return
        self.apply_repair_button.setEnabled(False)
        self.apply_repair_button.setText("正在验证…")
        QtWidgets.QApplication.processEvents()
        try:
            receipt = self._repair.apply(self._repair_plan)
        except Exception as exc:
            self.repair_status.setText(f"已回滚 / {type(exc).__name__}: {exc}")
            self.apply_repair_button.setText("应用并验证")
            self.statusChanged.emit(self.repair_status.text())
            return
        self._repair_receipt = receipt
        self.repair_status.setText("验证通过 / " + receipt.message + " / 可撤销")
        self.apply_repair_button.setText("验证通过")
        self.undo_repair_button.setEnabled(True)
        self.scan()
        self.undo_repair_button.setEnabled(True)
        self.statusChanged.emit(self.repair_status.text())

    def undo_repair(self):
        if self._repair_receipt is None:
            return
        try:
            self._repair.undo(self._repair_receipt)
        except Exception as exc:
            self.repair_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.repair_status.text())
            return
        self._repair_receipt = None
        self._repair_plan = None
        self.apply_repair_button.setText("应用并验证")
        self.apply_repair_button.setEnabled(False)
        self.undo_repair_button.setEnabled(False)
        self.scan()
        self.repair_status.setText("撤销验证通过 / 原始权重向量已恢复")
        self.statusChanged.emit(self.repair_status.text())

    def preview_mirror(self):
        if self._result is None:
            return
        direction = self.mirror_direction.currentData()
        try:
            plan = self._mirror.plan_mesh(self._result.mesh_path, self._result.skin_cluster, direction=direction)
        except Exception as exc:
            self.mirror_status.setText(f"预览安全失败 / {type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.mirror_status.text())
            return
        self._mirror_plan = plan
        self._mirror_receipt = None
        self.heatmap.set_mirror_plan(plan)
        self.undo_mirror_button.setEnabled(False)
        if plan.blockers:
            self.mirror_status.setText("已阻断 / " + " / ".join(plan.blockers[:3]))
            self.apply_mirror_button.setEnabled(False)
        elif plan.is_noop:
            self.mirror_status.setText("预览验证通过 / 目标侧已经与源侧一致")
            self.apply_mirror_button.setEnabled(False)
        else:
            self.mirror_status.setText(
                f"零写入 / {len(plan.changes)} 个向量 / {len(plan.influence_map.pairs)} 对影响骨骼 / "
                f"置信度 {plan.influence_map.confidence:.0%} / {len(plan.unmatched_vertices)} 个未匹配顶点"
            )
            self.apply_mirror_button.setEnabled(True)
        self.statusChanged.emit(self.mirror_status.text())

    def apply_mirror(self):
        if self._mirror_plan is None or not self._mirror_plan.can_apply:
            return
        self.apply_mirror_button.setEnabled(False)
        self.apply_mirror_button.setText("正在验证…")
        QtWidgets.QApplication.processEvents()
        try:
            self._mirror_receipt = self._mirror.apply(self._mirror_plan)
        except Exception as exc:
            self.mirror_status.setText(f"已回滚 / {type(exc).__name__}: {exc}")
            self.apply_mirror_button.setText("应用并验证")
            self.statusChanged.emit(self.mirror_status.text())
            return
        self.mirror_status.setText("验证通过 / " + self._mirror_receipt.message + " / 可撤销")
        self.apply_mirror_button.setText("验证通过")
        self.undo_mirror_button.setEnabled(True)
        self.statusChanged.emit(self.mirror_status.text())

    def undo_mirror(self):
        if self._mirror_receipt is None:
            return
        try:
            self._mirror.undo(self._mirror_receipt)
        except Exception as exc:
            self.mirror_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.mirror_status.text())
            return
        self._mirror_receipt = None
        self._mirror_plan = None
        self.heatmap.set_mirror_plan(None)
        self.apply_mirror_button.setText("应用并验证")
        self.apply_mirror_button.setEnabled(False)
        self.undo_mirror_button.setEnabled(False)
        self.mirror_status.setText("撤销验证通过 / 目标侧原始权重已恢复")
        self.statusChanged.emit(self.mirror_status.text())

    def _activate_vertex(self, index):
        if self._result:
            self.componentActivated.emit(f"{self._result.mesh_path}.vtx[{index}]")

    def _activate_vertices(self, indices):
        if self._result and indices:
            self.componentsActivated.emit(tuple(f"{self._result.mesh_path}.vtx[{index}]" for index in indices))
