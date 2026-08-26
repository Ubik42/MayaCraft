"""Native PySide6/QPainter Ghost Trajectory workspace."""

from __future__ import annotations

import math

from MayaCraft.adapters.maya.motion_capture import MayaMotionCapture
from MayaCraft.adapters.maya.motion_anchor import MayaContactAnchorService
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.motion import compare_motion
from MayaCraft.ui.theme import ensure_ui_font

UI_FONT_FAMILY = ensure_ui_font()


class MotionFieldCanvas(QtWidgets.QWidget):
    frameActivated = QtCore.Signal(float)
    signalHovered = QtCore.Signal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._capture = None
        self._baseline = None
        self._comparison = None
        self._anchor_plan = None
        self._points = ()
        self._baseline_points = ()
        self._hovered_index = -1
        self._phase = 0.0
        self.setMouseTracking(True)
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self.setMinimumSize(390, 210)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(32)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_capture(self, capture, baseline=None, comparison=None):
        self._capture = capture
        self._baseline = baseline
        self._comparison = comparison
        self._hovered_index = -1
        self.update()

    def set_anchor_plan(self, plan):
        self._anchor_plan = plan
        self.update()

    def hit_point(self, sample_index):
        if 0 <= sample_index < len(self._points):
            return self._points[sample_index].toPoint()
        return None

    def _tick(self):
        self._phase = (self._phase + 0.012) % 1.0
        if self.isVisible() and self._capture:
            self.update()

    @staticmethod
    def _event_position(event):
        return event.position() if hasattr(event, "position") else event.localPos()

    def mouseMoveEvent(self, event):
        point = self._event_position(event)
        nearest = -1
        distance = 14.0
        for index, projected in enumerate(self._points):
            candidate = math.hypot(projected.x() - point.x(), projected.y() - point.y())
            if candidate < distance:
                distance = candidate
                nearest = index
        if nearest != self._hovered_index:
            self._hovered_index = nearest
            self.setCursor(QtCore.Qt.PointingHandCursor if nearest >= 0 else QtCore.Qt.ArrowCursor)
            self.signalHovered.emit(nearest)
            self.update()
        super().mouseMoveEvent(event)

    def leaveEvent(self, event):
        self._hovered_index = -1
        self.signalHovered.emit(-1)
        self.setCursor(QtCore.Qt.ArrowCursor)
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton and self._hovered_index >= 0 and self._capture:
            self.frameActivated.emit(self._capture.samples[self._hovered_index].frame)
            event.accept()
            return
        super().mousePressEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = self.rect()
        background = QtGui.QRadialGradient(rect.center(), max(rect.width(), rect.height()) * 0.72)
        background.setColorAt(0.0, QtGui.QColor("#19142B"))
        background.setColorAt(0.52, QtGui.QColor("#0C101A"))
        background.setColorAt(1.0, QtGui.QColor("#07080D"))
        painter.fillRect(rect, background)
        self._draw_field_grid(painter, rect)
        if not self._capture or not self._capture.analysis.signals:
            self._points = ()
            painter.setPen(QtGui.QColor("#626D84"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 9, QtGui.QFont.DemiBold))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "选择一个动画控制器 / 捕获运动")
            return
        self._points, self._baseline_points = self._project_pair(
            self._capture.samples,
            self._baseline.samples if self._baseline else (),
            rect,
        )
        self._draw_baseline_comparison(painter)
        self._draw_anchor_preview(painter)
        self._draw_contacts(painter)
        self._draw_trajectory(painter)
        self._draw_ghosts(painter)
        self._draw_timeline(painter, rect)
        self._draw_hover_hud(painter, rect)

    @staticmethod
    def _draw_field_grid(painter, rect):
        painter.setPen(QtGui.QPen(QtGui.QColor(45, 54, 76, 78), 1))
        horizon = int(rect.height() * 0.73)
        for offset in range(0, rect.height() - horizon + 40, 22):
            painter.drawLine(0, horizon + offset, rect.width(), horizon + offset)
        for x in range(-rect.width(), rect.width() * 2, 52):
            painter.drawLine(rect.center().x(), horizon - 18, x, rect.height())

    @staticmethod
    def _project_pair(samples, baseline_samples, rect):
        raw = tuple(
            (sample.position[0] + sample.position[2] * 0.22, sample.position[1] + sample.position[2] * 0.08)
            for sample in samples
        )
        baseline_raw = tuple(
            (sample.position[0] + sample.position[2] * 0.22, sample.position[1] + sample.position[2] * 0.08)
            for sample in baseline_samples
        )
        combined = raw + baseline_raw
        xs = tuple(point[0] for point in combined)
        ys = tuple(point[1] for point in combined)
        span_x = max(max(xs) - min(xs), 1.0)
        span_y = max(max(ys) - min(ys), 1.0)
        scale = min(max(120.0, rect.width() - 96.0) / span_x, max(100.0, rect.height() - 150.0) / span_y)
        center_x = (min(xs) + max(xs)) * 0.5
        center_y = (min(ys) + max(ys)) * 0.5
        screen_center = QtCore.QPointF(rect.center().x(), rect.center().y() - 24.0)
        def project(points):
            return tuple(QtCore.QPointF(
                screen_center.x() + (x - center_x) * scale,
                screen_center.y() - (y - center_y) * scale,
            ) for x, y in points)
        return project(raw), project(baseline_raw)

    def _draw_baseline_comparison(self, painter):
        if not self._baseline_points or not self._comparison:
            return
        baseline_path = QtGui.QPainterPath(self._baseline_points[0])
        for point in self._baseline_points[1:]:
            baseline_path.lineTo(point)
        baseline_pen = QtGui.QPen(QtGui.QColor(180, 197, 225, 130), 1.2, QtCore.Qt.DashLine)
        baseline_pen.setDashPattern((3.0, 4.0))
        painter.setPen(baseline_pen)
        painter.setBrush(QtCore.Qt.NoBrush)
        painter.drawPath(baseline_path)
        maximum = max(self._comparison.maximum_position_error, 1e-9)
        stride = max(1, len(self._points) // 18)
        for index, (source, target, signal) in enumerate(
            zip(self._baseline_points, self._points, self._comparison.signals)
        ):
            if index % stride and signal.position_error < maximum * 0.8:
                continue
            ratio = min(1.0, signal.position_error / maximum)
            color = QtGui.QColor("#FF5C7C" if signal.contact_expected and not signal.contact_preserved else "#FFDB69")
            color.setAlpha(65 + int(145 * ratio))
            painter.setPen(QtGui.QPen(color, 0.8 + ratio * 1.4))
            painter.drawLine(source, target)
            if ratio > 0.45:
                painter.setBrush(color)
                painter.setPen(QtCore.Qt.NoPen)
                painter.drawEllipse(target, 2.0 + ratio * 2.0, 2.0 + ratio * 2.0)

    def _draw_anchor_preview(self, painter):
        if not self._anchor_plan or not self._baseline_points:
            return
        pulse = (math.sin(self._phase * math.tau * 2.0) + 1.0) * 0.5
        for correction in self._anchor_plan.corrections:
            index = correction.sample_index
            if index >= len(self._points) or index >= len(self._baseline_points):
                continue
            source = self._points[index]
            baseline = self._baseline_points[index]
            target = QtCore.QPointF(
                source.x() + (baseline.x() - source.x()) * correction.influence,
                source.y() + (baseline.y() - source.y()) * correction.influence,
            )
            color = QtGui.QColor("#A7FF6A" if correction.influence >= 0.999 else "#9D6CFF")
            color.setAlpha(110 + int(90 * correction.influence))
            painter.setPen(QtGui.QPen(color, 1.0 + correction.influence))
            painter.drawLine(source, target)
            painter.setBrush(QtCore.Qt.NoBrush)
            painter.drawEllipse(target, 4.0 + pulse * 4.0 * correction.influence, 4.0 + pulse * 4.0 * correction.influence)

    def _draw_contacts(self, painter):
        for contact in self._capture.analysis.contacts:
            points = self._points[contact.start_index:contact.end_index + 1]
            if not points:
                continue
            path = QtGui.QPainterPath(points[0])
            for point in points[1:]:
                path.lineTo(point)
            glow = QtGui.QPen(QtGui.QColor(167, 255, 106, 44), 13.0)
            glow.setCapStyle(QtCore.Qt.RoundCap)
            painter.setPen(glow)
            painter.drawPath(path)
            painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 2.3))
            painter.drawPath(path)
            anchor = points[len(points) // 2]
            painter.setBrush(QtCore.Qt.NoBrush)
            painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 1.2))
            painter.drawEllipse(anchor, 8.0, 8.0)

    def _draw_trajectory(self, painter):
        path = QtGui.QPainterPath(self._points[0])
        for point in self._points[1:]:
            path.lineTo(point)
        glow = QtGui.QPen(QtGui.QColor(157, 108, 255, 48), 9.0)
        glow.setCapStyle(QtCore.Qt.RoundCap)
        glow.setJoinStyle(QtCore.Qt.RoundJoin)
        painter.setPen(glow)
        painter.drawPath(path)
        gradient = QtGui.QLinearGradient(self._points[0], self._points[-1])
        gradient.setColorAt(0.0, QtGui.QColor("#42E8FF"))
        gradient.setColorAt(0.5, QtGui.QColor("#9D6CFF"))
        gradient.setColorAt(1.0, QtGui.QColor("#FF5C7C"))
        pen = QtGui.QPen(QtGui.QBrush(gradient), 2.2)
        pen.setCapStyle(QtCore.Qt.RoundCap)
        pen.setJoinStyle(QtCore.Qt.RoundJoin)
        painter.setPen(pen)
        painter.drawPath(path)
        scan_index = min(len(self._points) - 1, int(self._phase * len(self._points)))
        scan = self._points[scan_index]
        painter.setPen(QtCore.Qt.NoPen)
        painter.setBrush(QtGui.QColor(255, 255, 255, 55))
        painter.drawEllipse(scan, 12.0, 12.0)
        painter.setBrush(QtGui.QColor("#FFFFFF"))
        painter.drawEllipse(scan, 3.2, 3.2)

    def _draw_ghosts(self, painter):
        signals = self._capture.analysis.signals
        stride = max(1, len(signals) // 8)
        maximum_speed = max(self._capture.analysis.maximum_speed, 1e-9)
        for index, (signal, point) in enumerate(zip(signals, self._points)):
            if index % stride and index not in {0, len(signals) - 1, self._hovered_index}:
                continue
            speed_ratio = min(1.0, signal.speed / maximum_speed)
            color = QtGui.QColor("#FFDB69" if signal.rotation_jump else "#42E8FF")
            color.setAlpha(110 + int(100 * speed_ratio))
            radius = 4.0 + speed_ratio * 5.0
            painter.setPen(QtGui.QPen(color, 1.1))
            painter.setBrush(QtCore.Qt.NoBrush)
            painter.drawEllipse(point, radius, radius)
            painter.drawLine(point + QtCore.QPointF(-radius - 3, 0), point + QtCore.QPointF(radius + 3, 0))
            painter.drawLine(point + QtCore.QPointF(0, -radius - 3), point + QtCore.QPointF(0, radius + 3))
            if signal.jerk_magnitude >= self._capture.analysis.maximum_jerk * 0.72 and signal.jerk_magnitude > 0:
                painter.setPen(QtGui.QPen(QtGui.QColor(255, 92, 124, 160), 1.0))
                painter.drawLine(point, point + QtCore.QPointF(0, -16.0 - radius))

    def _draw_timeline(self, painter, rect):
        bar = QtCore.QRectF(24, rect.height() - 39, rect.width() - 48, 6)
        painter.setPen(QtCore.Qt.NoPen)
        painter.setBrush(QtGui.QColor("#242A3A"))
        painter.drawRoundedRect(bar, 3, 3)
        count = max(1, len(self._capture.samples) - 1)
        for contact in self._capture.analysis.contacts:
            left = bar.left() + bar.width() * contact.start_index / count
            right = bar.left() + bar.width() * contact.end_index / count
            painter.setBrush(QtGui.QColor("#A7FF6A"))
            painter.drawRoundedRect(QtCore.QRectF(left, bar.top(), max(3.0, right - left), bar.height()), 3, 3)
        painter.setPen(QtGui.QColor("#8791A8"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
        start = self._capture.samples[0].frame
        end = self._capture.samples[-1].frame
        painter.drawText(QtCore.QRectF(bar.left(), bar.bottom() + 4, 90, 16), QtCore.Qt.AlignLeft, f"F {start:g}")
        painter.drawText(QtCore.QRectF(bar.right() - 90, bar.bottom() + 4, 90, 16), QtCore.Qt.AlignRight, f"F {end:g}")

    def _draw_hover_hud(self, painter, rect):
        if self._hovered_index < 0:
            return
        signal = self._capture.analysis.signals[self._hovered_index]
        point = self._points[self._hovered_index]
        pulse = (math.sin(self._phase * math.tau * 2.0) + 1.0) * 0.5
        painter.setPen(QtCore.Qt.NoPen)
        painter.setBrush(QtGui.QColor(157, 108, 255, 45))
        painter.drawEllipse(point, 17.0 + pulse * 5.0, 17.0 + pulse * 5.0)
        label = (
            f"帧 {signal.sample.frame:g}   速度 {signal.speed:.2f}   加速度 {signal.acceleration_magnitude:.2f}   "
            f"Jerk {signal.jerk_magnitude:.2f}   弧长 {signal.arc_length:.2f}"
        )
        font = QtGui.QFont(UI_FONT_FAMILY, 8, QtGui.QFont.Bold)
        width = min(rect.width() - 24, QtGui.QFontMetrics(font).horizontalAdvance(label) + 24)
        x = min(max(12.0, point.x() - width * 0.5), rect.width() - width - 12.0)
        y = max(14.0, point.y() - 47.0)
        hud = QtCore.QRectF(x, y, width, 27)
        painter.setPen(QtGui.QPen(QtGui.QColor("#9D6CFF"), 1.0))
        painter.setBrush(QtGui.QColor(12, 14, 23, 235))
        painter.drawRoundedRect(hud, 7, 7)
        painter.setPen(QtGui.QColor("#F4F7FF"))
        painter.setFont(font)
        painter.drawText(hud, QtCore.Qt.AlignCenter, label)


class MotionMagnetismWorkspace(QtWidgets.QWidget):
    statusChanged = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._adapter = MayaMotionCapture()
        self._anchor_service = MayaContactAnchorService(self._adapter)
        self._capture = None
        self._baseline = None
        self._comparison = None
        self._selected_contact_index = -1
        self._anchor_plan = None
        self._anchor_receipt = None
        self._build_ui()

    @property
    def capture_result(self):
        return self._capture

    def _build_ui(self):
        root = QtWidgets.QVBoxLayout(self)
        root.setContentsMargins(15, 14, 15, 14)
        root.setSpacing(9)
        header = QtWidgets.QHBoxLayout()
        copy = QtWidgets.QVBoxLayout()
        eyebrow = QtWidgets.QLabel("运动磁场 / 世界空间轨迹")
        eyebrow.setStyleSheet("color:#FF5C7C;font-size:9px;font-weight:900;letter-spacing:2px;")
        self.title = QtWidgets.QLabel("捕获角色在时空中的运动意图。")
        self.title.setStyleSheet("font-size:21px;font-weight:850;")
        copy.addWidget(eyebrow)
        copy.addWidget(self.title)
        self.capture_button = QtWidgets.QPushButton("捕获所选控制器  ↗")
        self.capture_button.setObjectName("MotionCaptureButton")
        self.capture_button.clicked.connect(self.capture_selection)
        self.baseline_button = QtWidgets.QPushButton("设为基准")
        self.baseline_button.setObjectName("MotionBaselineButton")
        self.baseline_button.setEnabled(False)
        self.baseline_button.clicked.connect(self.set_baseline)
        header.addLayout(copy, 1)
        header.addWidget(self.baseline_button)
        header.addWidget(self.capture_button)
        root.addLayout(header)
        instrument = QtWidgets.QFrame()
        instrument.setObjectName("MotionInstrument")
        instrument_layout = QtWidgets.QHBoxLayout(instrument)
        instrument_layout.setContentsMargins(14, 7, 14, 7)
        self.metrics = {}
        specs = (("arc", "轨迹弧长"), ("speed", "最大速度"), ("jerk", "最大 Jerk"), ("contacts", "接触区间"), ("rotation", "旋转跳变"))
        for index, (key, caption) in enumerate(specs):
            block = QtWidgets.QWidget()
            layout = QtWidgets.QVBoxLayout(block)
            layout.setContentsMargins(0, 0, 0, 0)
            value = QtWidgets.QLabel("—")
            value.setStyleSheet("font-size:17px;font-weight:900;")
            label = QtWidgets.QLabel(caption)
            label.setProperty("muted", True)
            label.setStyleSheet("font-size:7px;font-weight:800;letter-spacing:1px;")
            layout.addWidget(value)
            layout.addWidget(label)
            instrument_layout.addWidget(block, 1)
            if index < len(specs) - 1:
                separator = QtWidgets.QFrame()
                separator.setFrameShape(QtWidgets.QFrame.VLine)
                separator.setStyleSheet("color:#2A3142;")
                instrument_layout.addWidget(separator)
            self.metrics[key] = value
        root.addWidget(instrument)
        self.canvas = MotionFieldCanvas()
        self.canvas.frameActivated.connect(self._go_to_frame)
        self.canvas.signalHovered.connect(self._hover_signal)
        root.addWidget(self.canvas, 1)
        self.readout = QtWidgets.QLabel("世界空间捕获为只读；点击轨迹信号可定位 Maya 时间。")
        self.readout.setProperty("muted", True)
        self.readout.setStyleSheet("font-size:9px;")
        root.addWidget(self.readout)
        self.comparison_readout = QtWidgets.QLabel("基准未锁定 / 先捕获运动场，再锁定需要保留的运动意图")
        self.comparison_readout.setObjectName("MotionComparisonReadout")
        self.comparison_readout.setStyleSheet("color:#9D6CFF;font-size:8px;font-weight:800;letter-spacing:1px;")
        root.addWidget(self.comparison_readout)
        anchor = QtWidgets.QFrame()
        anchor.setObjectName("MotionAnchorCapsule")
        anchor_layout = QtWidgets.QHBoxLayout(anchor)
        anchor_layout.setContentsMargins(11, 7, 11, 7)
        self.anchor_status = QtWidgets.QLabel("接触锚点 / 悬停基准接触信号以选择意图")
        self.anchor_status.setProperty("muted", True)
        self.anchor_status.setStyleSheet("font-size:8px;")
        self.preview_anchor_button = QtWidgets.QPushButton("预览锚点")
        self.preview_anchor_button.setEnabled(False)
        self.preview_anchor_button.clicked.connect(self.preview_anchor)
        self.apply_anchor_button = QtWidgets.QPushButton("应用动画层")
        self.apply_anchor_button.setObjectName("MotionAnchorApply")
        self.apply_anchor_button.setEnabled(False)
        self.apply_anchor_button.clicked.connect(self.apply_anchor)
        self.undo_anchor_button = QtWidgets.QPushButton("撤销")
        self.undo_anchor_button.setEnabled(False)
        self.undo_anchor_button.clicked.connect(self.undo_anchor)
        anchor_layout.addWidget(self.anchor_status, 1)
        anchor_layout.addWidget(self.preview_anchor_button)
        anchor_layout.addWidget(self.apply_anchor_button)
        anchor_layout.addWidget(self.undo_anchor_button)
        root.addWidget(anchor)

    def capture_selection(self):
        self.capture_button.setEnabled(False)
        self.capture_button.setText("正在采样世界空间…")
        QtWidgets.QApplication.processEvents()
        try:
            capture = self._adapter.capture_selection()
        except Exception as exc:
            self.readout.setText(f"捕获安全失败：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.readout.text())
            return
        finally:
            self.capture_button.setEnabled(True)
            self.capture_button.setText("捕获所选控制器  ↗")
        self._capture = capture
        self._comparison = None
        self._anchor_plan = None
        self._anchor_receipt = None
        self.canvas.set_anchor_plan(None)
        self.apply_anchor_button.setEnabled(False)
        self.undo_anchor_button.setEnabled(False)
        if self._baseline:
            try:
                self._comparison = compare_motion(self._baseline.analysis, capture.analysis)
            except ValueError as exc:
                self.comparison_readout.setText(f"对比已阻断 / {exc}")
            else:
                comparison = self._comparison
                self._present_comparison(comparison)
        self.canvas.set_capture(capture, self._baseline, self._comparison)
        self.baseline_button.setEnabled(True)
        self._present_metrics(capture)
        self.title.setText(capture.node_path.rsplit("|", 1)[-1] + " / 磁场轨迹")
        analysis = capture.analysis
        self.readout.setText(
            f"{len(capture.samples)} 个采样 · {capture.frames_per_second:.3f} fps · "
            f"{len(analysis.contacts)} 个接触区间 · 点击任意信号定位 Maya 时间"
        )
        self.statusChanged.emit(f"已捕获 {len(capture.samples)} 个世界空间运动采样")

    def _present_metrics(self, capture):
        analysis = capture.analysis
        values = {
            "arc": f"{analysis.total_arc_length:.2f}",
            "speed": f"{analysis.maximum_speed:.2f}",
            "jerk": f"{analysis.maximum_jerk:.1f}",
            "contacts": str(len(analysis.contacts)),
            "rotation": str(analysis.rotation_jump_count),
        }
        for key, value in values.items():
            self.metrics[key].setText(value)

    def _present_comparison(self, comparison):
        self.comparison_readout.setText(
            f"基准差异 / 位置 RMS {comparison.rms_position_error:.3f} / 最大值 {comparison.maximum_position_error:.3f} / "
            f"速度 RMS {comparison.rms_velocity_error:.3f} / 接触保持 {comparison.contact_preservation:.0%}"
        )

    def set_baseline(self):
        if self._capture is None:
            return
        self._baseline = self._capture
        self._comparison = None
        self.canvas.set_capture(self._capture)
        self.baseline_button.setText("更新基准")
        self.comparison_readout.setText(
            f"基准已锁定 / {len(self._baseline.samples)} 个采样 / 编辑动画或切换空间后再次捕获候选"
        )
        self.statusChanged.emit("运动基准已锁定，可进行非破坏对比")

    def preview_anchor(self):
        if not self._baseline or not self._capture or self._selected_contact_index < 0:
            return
        plan = self._anchor_service.plan(
            self._baseline,
            self._capture,
            self._selected_contact_index,
            blend_samples=2,
        )
        self._anchor_plan = plan
        self._anchor_receipt = None
        self.undo_anchor_button.setEnabled(False)
        self.canvas.set_anchor_plan(plan if plan.can_apply else None)
        if plan.blockers:
            self.anchor_status.setText("已阻断 / " + " / ".join(plan.blockers))
            self.apply_anchor_button.setEnabled(False)
        elif plan.is_noop:
            self.anchor_status.setText("预览验证通过 / 候选动画已经保持该接触")
            self.apply_anchor_button.setEnabled(False)
        else:
            maximum = max(math.sqrt(sum(value * value for value in change.world_delta)) for change in plan.corrections)
            self.anchor_status.setText(
                f"零写入 / 第 {plan.contact_start_frame:g}–{plan.contact_end_frame:g} 帧 / "
                f"{len(plan.corrections)} 个采样 / 最大 Δ {maximum:.3f} / 置信度 {plan.contact_confidence:.0%}"
            )
            self.apply_anchor_button.setEnabled(True)
        self.statusChanged.emit(self.anchor_status.text())

    def apply_anchor(self):
        if not self._anchor_plan or not self._anchor_plan.can_apply:
            return
        self.apply_anchor_button.setEnabled(False)
        self.apply_anchor_button.setText("正在验证…")
        QtWidgets.QApplication.processEvents()
        try:
            receipt = self._anchor_service.apply(self._anchor_plan)
        except Exception as exc:
            self.anchor_status.setText(f"已回滚 / {type(exc).__name__}: {exc}")
            self.apply_anchor_button.setText("应用动画层")
            self.statusChanged.emit(self.anchor_status.text())
            return
        self._anchor_receipt = receipt
        self.apply_anchor_button.setText("验证通过")
        self.undo_anchor_button.setEnabled(True)
        self.canvas.set_anchor_plan(None)
        self._capture = self._adapter.capture_node(
            receipt.plan.node_path,
            start=self._baseline.samples[0].frame,
            end=self._baseline.samples[-1].frame,
        )
        self._comparison = compare_motion(self._baseline.analysis, self._capture.analysis)
        self.canvas.set_capture(self._capture, self._baseline, self._comparison)
        self._present_metrics(self._capture)
        self._present_comparison(self._comparison)
        self.anchor_status.setText("验证通过 / " + receipt.message + " / 可撤销")
        self.statusChanged.emit(self.anchor_status.text())

    def undo_anchor(self):
        if not self._anchor_receipt:
            return
        receipt = self._anchor_receipt
        try:
            self._anchor_service.undo(receipt)
        except Exception as exc:
            self.anchor_status.setText(f"撤销验证失败 / {type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.anchor_status.text())
            return
        self._capture = self._adapter.capture_node(
            receipt.plan.node_path,
            start=self._baseline.samples[0].frame,
            end=self._baseline.samples[-1].frame,
        )
        self._comparison = compare_motion(self._baseline.analysis, self._capture.analysis)
        self.canvas.set_capture(self._capture, self._baseline, self._comparison)
        self._present_metrics(self._capture)
        self._present_comparison(self._comparison)
        self._anchor_plan = None
        self._anchor_receipt = None
        self.apply_anchor_button.setText("应用动画层")
        self.apply_anchor_button.setEnabled(False)
        self.undo_anchor_button.setEnabled(False)
        self.anchor_status.setText("撤销验证通过 / 候选运动和动画层状态已恢复")
        self.statusChanged.emit(self.anchor_status.text())

    def _go_to_frame(self, frame):
        try:
            current = self._adapter.go_to_frame(frame)
        except Exception as exc:
            self.statusChanged.emit(f"时间定位失败：{type(exc).__name__}: {exc}")
            return
        self.statusChanged.emit(f"已选择第 {current:g} 帧的运动信号")

    def _hover_signal(self, index):
        if index < 0 or not self._capture:
            return
        signal = self._capture.analysis.signals[index]
        contact = None
        self._selected_contact_index = -1
        if self._baseline:
            for contact_index, interval in enumerate(self._baseline.analysis.contacts):
                if interval.start_index <= index <= interval.end_index:
                    self._selected_contact_index = contact_index
                    contact = interval
                    break
        if contact is None:
            contact = next(
                (item for item in self._capture.analysis.contacts if item.start_index <= index <= item.end_index),
                None,
            )
        self.preview_anchor_button.setEnabled(
            self._baseline is not None and self._comparison is not None and self._selected_contact_index >= 0
        )
        contact_text = f" / 接触置信度 {contact.confidence:.0%}" if contact else ""
        self.readout.setText(
            f"第 {signal.sample.frame:g} 帧 / 速度 {signal.speed:.2f} / 加速度 {signal.acceleration_magnitude:.2f} / "
            f"Jerk {signal.jerk_magnitude:.2f}{contact_text}"
        )
