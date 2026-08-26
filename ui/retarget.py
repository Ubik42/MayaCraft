"""Native PySide6 semantic Retarget Ghost workspace for Maya 2025."""

from __future__ import annotations

import math
from dataclasses import replace
from pathlib import Path

from MayaCraft.adapters.storage.clip_package import ClipPackageStore
from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture
from MayaCraft.adapters.maya.motion_capture import MayaMotionCapture
from MayaCraft.adapters.maya.contact_ik_layer import MayaContactIKLayerService
from MayaCraft.adapters.maya.retarget_layer import MayaRetargetLayerService
from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.retarget import (
    build_retarget_profile, preview_retarget_clip, preview_retarget_pose,
    retarget_axis_templates, validate_retarget_result, with_retarget_axis_template,
)
from MayaCraft.domain.ik import ContactIKSettings, preview_retarget_contact_ik
from MayaCraft.domain.clip_package import ClipPackage, remap_clip_package_paths
from MayaCraft.domain.clip_library import preflight_clip_package
from MayaCraft.ui.clip_browser import ClipLibraryPanel
from MayaCraft.ui.theme import ensure_ui_font


UI_FONT_FAMILY = ensure_ui_font()


class RetargetStage(QtWidgets.QWidget):
    mappingActivated = QtCore.Signal(object)
    anchorAdjustmentRequested = QtCore.Signal(object)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._source = None
        self._target = None
        self._profile = None
        self._preview = None
        self._contact_ik = None
        self._validation = None
        self._phase = 0.0
        self._hovered = ""
        self._hovered_anchor = ""
        self._mapping_hits = ()
        self._anchor_hits = ()
        self._drag_anchor = ""
        self._drag_start = None
        self._drag_scale = 1.0
        self._drag_initial_offset = (0.0, 0.0, 0.0)
        self.setMouseTracking(True)
        self.setMinimumHeight(300)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(34)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_data(self, source=None, target=None, profile=None, preview=None, contact_ik=None):
        self._source = source
        self._target = target
        self._profile = profile
        self._preview = preview
        self._contact_ik = contact_ik
        self._hovered = ""
        self.update()

    def mapping_hit_point(self, role):
        return next((point.toPoint() for value, point, _mapping in self._mapping_hits if value == role), None)

    def anchor_hit_point(self, side):
        return next((point.toPoint() for value, point, _scale_value in self._anchor_hits if value == side), None)

    def _tick(self):
        self._phase = (self._phase + 0.018) % 1.0
        if self.isVisible() and self._profile and self._profile.mappings:
            self.update()

    def mouseMoveEvent(self, event):
        point = event.position() if hasattr(event, "position") else event.localPos()
        if self._drag_anchor and self._drag_start is not None:
            delta = point - self._drag_start
            offset = (
                self._drag_initial_offset[0] + delta.x() / max(self._drag_scale, 1e-8),
                self._drag_initial_offset[1] - delta.y() / max(self._drag_scale, 1e-8),
                self._drag_initial_offset[2],
            )
            self.anchorAdjustmentRequested.emit((self._drag_anchor, offset))
            event.accept()
            return
        ranked = sorted(
            (((hit.x() - point.x()) ** 2 + (hit.y() - point.y()) ** 2), role)
            for role, hit, _mapping in self._mapping_hits
        )
        anchor_ranked = sorted(
            (((hit.x() - point.x()) ** 2 + (hit.y() - point.y()) ** 2), side)
            for side, hit, _scale_value in self._anchor_hits
        )
        anchor_hovered = anchor_ranked[0][1] if anchor_ranked and anchor_ranked[0][0] <= 12.0 ** 2 else ""
        hovered = ranked[0][1] if ranked and ranked[0][0] <= 15.0 ** 2 and not anchor_hovered else ""
        if hovered != self._hovered or anchor_hovered != self._hovered_anchor:
            self._hovered = hovered
            self._hovered_anchor = anchor_hovered
            self.setCursor(
                QtCore.Qt.OpenHandCursor if anchor_hovered
                else QtCore.Qt.PointingHandCursor if hovered
                else QtCore.Qt.ArrowCursor
            )
            self.update()
        super().mouseMoveEvent(event)

    def leaveEvent(self, event):
        self._hovered = ""
        self._hovered_anchor = ""
        self.setCursor(QtCore.Qt.ArrowCursor)
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        point = event.position() if hasattr(event, "position") else event.localPos()
        if event.button() == QtCore.Qt.LeftButton and self._contact_ik:
            ranked = sorted(
                (((hit.x() - point.x()) ** 2 + (hit.y() - point.y()) ** 2), side, scale_value)
                for side, hit, scale_value in self._anchor_hits
            )
            if ranked and ranked[0][0] <= 12.0 ** 2:
                self._drag_anchor = ranked[0][1]
                self._drag_scale = ranked[0][2]
                self._drag_start = point
                self._drag_initial_offset = self._contact_ik.settings.anchor_offset(self._drag_anchor)
                self.setCursor(QtCore.Qt.ClosedHandCursor)
                event.accept()
                return
        if event.button() == QtCore.Qt.LeftButton and self._hovered:
            mapping = next(item[2] for item in self._mapping_hits if item[0] == self._hovered)
            self.mappingActivated.emit((mapping.source_path, mapping.target_path))
            event.accept()
            return
        super().mousePressEvent(event)

    def mouseReleaseEvent(self, event):
        if self._drag_anchor and event.button() == QtCore.Qt.LeftButton:
            self._drag_anchor = ""
            self._drag_start = None
            self.setCursor(QtCore.Qt.OpenHandCursor)
            event.accept()
            return
        super().mouseReleaseEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(self.rect())
        gradient = QtGui.QLinearGradient(0, 0, rect.width(), rect.height())
        gradient.setColorAt(0.0, QtGui.QColor("#080B12"))
        gradient.setColorAt(0.5, QtGui.QColor("#11112A"))
        gradient.setColorAt(1.0, QtGui.QColor("#07151B"))
        painter.fillRect(rect, gradient)
        painter.setPen(QtGui.QPen(QtGui.QColor(59, 72, 103, 70), 1))
        for x in range(0, self.width(), 32):
            painter.drawLine(x, 0, x, self.height())
        for y in range(0, self.height(), 32):
            painter.drawLine(0, y, self.width(), y)
        left_rect = QtCore.QRectF(20, 42, rect.width() * 0.39, rect.height() - 76)
        right_rect = QtCore.QRectF(rect.width() * 0.61, 42, rect.width() * 0.39 - 20, rect.height() - 76)
        self._draw_header(painter, left_rect, "源骨架", "动作信号", "#9D6CFF", self._source)
        self._draw_header(painter, right_rect, "目标骨架", "Ghost 预览", "#42E8FF", self._target)
        if self._profile:
            self._draw_axis_template(painter, rect, self._profile.axis_template)
        if not self._source and not self._target:
            painter.setPen(QtGui.QColor("#63708A"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 10, QtGui.QFont.DemiBold))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "依次捕获源骨架与目标骨架，建立语义映射场")
            self._mapping_hits = ()
            return
        source_points = self._project_skeleton(self._source, left_rect) if self._source else {}
        target_points = self._project_skeleton(self._target, right_rect) if self._target else {}
        self._draw_skeleton(painter, self._source, source_points, QtGui.QColor("#9D6CFF"))
        self._draw_skeleton(painter, self._target, target_points, QtGui.QColor("#42E8FF"))
        hits = []
        if self._profile:
            for index, mapping in enumerate(self._profile.mappings):
                source = source_points.get(mapping.source_path)
                target = target_points.get(mapping.target_path)
                if source is None or target is None:
                    continue
                hovered = mapping.semantic_role == self._hovered
                color = QtGui.QColor("#FFB15C" if mapping.confidence < 0.65 else "#42E8FF")
                color.setAlpha(205 if hovered else 82)
                painter.setPen(QtGui.QPen(color, 1.7 if hovered else 0.85, QtCore.Qt.DashLine))
                control_a = QtCore.QPointF(rect.center().x() - 35, source.y())
                control_b = QtCore.QPointF(rect.center().x() + 35, target.y())
                path = QtGui.QPainterPath(source)
                path.cubicTo(control_a, control_b, target)
                painter.drawPath(path)
                packet = path.pointAtPercent((self._phase + index / max(1, len(self._profile.mappings))) % 1.0)
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(QtGui.QColor(color.red(), color.green(), color.blue(), 230))
                painter.drawEllipse(packet, 2.5 if not hovered else 4.0, 2.5 if not hovered else 4.0)
                midpoint = path.pointAtPercent(0.5)
                hits.append((mapping.semantic_role, midpoint, mapping))
        self._mapping_hits = tuple(hits)
        if self._preview and self._target:
            self._draw_ghost(painter, right_rect, target_points)
        if self._contact_ik and self._preview and self._target:
            self._draw_contact_ik(painter, right_rect)
        else:
            self._anchor_hits = ()
        if self._hovered and self._profile:
            mapping = self._profile.mapping(self._hovered)
            painter.setPen(QtGui.QColor("#F4F7FF"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 8, QtGui.QFont.DemiBold))
            painter.drawText(
                QtCore.QRectF(24, rect.height() - 28, rect.width() - 48, 18),
                QtCore.Qt.AlignCenter,
                f"{mapping.semantic_role} / 置信度 {mapping.confidence:.0%} / 点击同时定位源与目标关节",
            )

    @staticmethod
    def _draw_header(painter, rect, title, subtitle, color, analysis):
        painter.setPen(QtGui.QColor(color))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 9, QtGui.QFont.Bold))
        painter.drawText(QtCore.QRectF(rect.left(), 12, rect.width(), 20), QtCore.Qt.AlignCenter, title)
        painter.setPen(QtGui.QColor("#78849B"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
        count = len(analysis.joints) if analysis else 0
        painter.drawText(QtCore.QRectF(rect.left(), 28, rect.width(), 14), QtCore.Qt.AlignCenter, f"{subtitle} / {count} 个关节")

    def _draw_axis_template(self, painter, rect, template):
        center = QtCore.QPointF(rect.center().x(), 24.0)
        active = not template.is_identity
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        painter.setPen(QtGui.QPen(
            QtGui.QColor(157, 108, 255, 210 if active else 90),
            1.4 if active else 0.9,
        ))
        painter.setBrush(QtGui.QColor(17, 13, 35, 225))
        painter.drawRoundedRect(
            QtCore.QRectF(center.x() - 47, 7, 94, 34), 8, 8
        )
        painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 72), 0.9))
        painter.drawArc(
            QtCore.QRectF(center.x() - 16 - pulse * 2, 10 - pulse * 2, 32 + pulse * 4, 28 + pulse * 4),
            25 * 16, 130 * 16,
        )
        painter.setPen(QtGui.QColor("#E7DCFF" if active else "#78849B"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6, QtGui.QFont.Bold))
        painter.drawText(
            QtCore.QRectF(center.x() - 43, 9, 86, 13), QtCore.Qt.AlignCenter,
            "轴基变换" if active else "轴空间同向",
        )
        painter.setPen(QtGui.QColor("#BFF8FF"))
        painter.drawText(
            QtCore.QRectF(center.x() - 43, 24, 86, 12), QtCore.Qt.AlignCenter,
            f"{template.source_forward} → {template.target_forward}  /  {template.angle_degrees:.0f}°",
        )

    @staticmethod
    def _project_skeleton(analysis, rect):
        if not analysis or not analysis.joints:
            return {}
        xs = tuple(item.position[0] for item in analysis.joints)
        ys = tuple(item.position[1] for item in analysis.joints)
        center_x = (min(xs) + max(xs)) * 0.5
        center_y = (min(ys) + max(ys)) * 0.5
        span_x = max(max(xs) - min(xs), 1.0)
        span_y = max(max(ys) - min(ys), 1.0)
        scale = min(rect.width() * 0.82 / span_x, rect.height() * 0.86 / span_y)
        return {
            joint.path: QtCore.QPointF(
                rect.center().x() + (joint.position[0] - center_x) * scale,
                rect.center().y() - (joint.position[1] - center_y) * scale,
            )
            for joint in analysis.joints
        }

    @staticmethod
    def _draw_skeleton(painter, analysis, points, color):
        if not analysis:
            return
        by_path = {joint.path: joint for joint in analysis.joints}
        painter.setPen(QtGui.QPen(QtGui.QColor(color.red(), color.green(), color.blue(), 145), 1.5))
        for joint in analysis.joints:
            if joint.parent_path in by_path:
                painter.drawLine(points[joint.parent_path], points[joint.path])
        for joint in analysis.joints:
            point = points[joint.path]
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(QtGui.QColor(color.red(), color.green(), color.blue(), 45))
            painter.drawEllipse(point, 7.0, 7.0)
            painter.setBrush(color)
            painter.drawEllipse(point, 2.8, 2.8)

    def _draw_ghost(self, painter, rect, target_points):
        ghost_positions = {node.node_path: node.world_translation for node in self._preview.frame.nodes}
        if not ghost_positions:
            return
        target_by_path = {joint.path: joint for joint in self._target.joints}
        base_positions = {joint.path: joint.position for joint in self._target.joints}
        xs = tuple(value[0] for value in base_positions.values())
        ys = tuple(value[1] for value in base_positions.values())
        center_x = (min(xs) + max(xs)) * 0.5
        center_y = (min(ys) + max(ys)) * 0.5
        span_x = max(max(xs) - min(xs), 1.0)
        span_y = max(max(ys) - min(ys), 1.0)
        scale = min(rect.width() * 0.82 / span_x, rect.height() * 0.86 / span_y)
        ghost_points = {
            path: QtCore.QPointF(
                rect.center().x() + (position[0] - center_x) * scale,
                rect.center().y() - (position[1] - center_y) * scale,
            )
            for path, position in ghost_positions.items()
            if path in target_by_path
        }
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        painter.setPen(QtGui.QPen(QtGui.QColor(167, 255, 106, 180), 1.3, QtCore.Qt.DashLine))
        for path, joint in target_by_path.items():
            if joint.parent_path in ghost_points and path in ghost_points:
                painter.drawLine(ghost_points[joint.parent_path], ghost_points[path])
        for path, point in ghost_points.items():
            base = target_points.get(path)
            if base and math.hypot(point.x() - base.x(), point.y() - base.y()) > 1.0:
                painter.setPen(QtGui.QPen(QtGui.QColor(167, 255, 106, 90), 0.8))
                painter.drawLine(base, point)
            painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 1.2))
            painter.setBrush(QtGui.QColor(167, 255, 106, 20))
            painter.drawEllipse(point, 4.0 + pulse * 2.0, 4.0 + pulse * 2.0)

    def _draw_contact_ik(self, painter, rect):
        samples = self._contact_ik.samples_at_frame(self._preview.frame.frame)
        if not samples:
            return
        xs = tuple(joint.position[0] for joint in self._target.joints)
        ys = tuple(joint.position[1] for joint in self._target.joints)
        center_x = (min(xs) + max(xs)) * 0.5
        center_y = (min(ys) + max(ys)) * 0.5
        span_x = max(max(xs) - min(xs), 1.0)
        span_y = max(max(ys) - min(ys), 1.0)
        scale = min(rect.width() * 0.82 / span_x, rect.height() * 0.86 / span_y)

        def project(position):
            return QtCore.QPointF(
                rect.center().x() + (position[0] - center_x) * scale,
                rect.center().y() - (position[1] - center_y) * scale,
            )

        anchor_hits = []
        for sample in samples:
            before = tuple(project(value) for value in sample.before_positions)
            shifted = tuple(project(value) for value in (
                sample.shifted_positions or sample.before_positions
            ))
            solved = tuple(project(value) for value in sample.solved_positions)
            anchor = project(sample.anchor_position)
            target = project(sample.target_position)
            painter.setPen(QtGui.QPen(QtGui.QColor(255, 65, 108, 125), 1.2, QtCore.Qt.DashLine))
            painter.drawPolyline(QtGui.QPolygonF(before))
            if math.sqrt(sum(value * value for value in sample.pelvis_offset)) > 1e-6:
                painter.setPen(QtGui.QPen(QtGui.QColor(66, 232, 255, 175), 1.4, QtCore.Qt.DashLine))
                painter.drawPolyline(QtGui.QPolygonF(shifted))
                painter.drawLine(before[0], shifted[0])
                direction = shifted[0] - before[0]
                length = math.hypot(direction.x(), direction.y()) or 1.0
                unit = QtCore.QPointF(direction.x() / length, direction.y() / length)
                normal = QtCore.QPointF(-unit.y(), unit.x())
                painter.drawLine(shifted[0], shifted[0] - unit * 7.0 + normal * 3.5)
                painter.drawLine(shifted[0], shifted[0] - unit * 7.0 - normal * 3.5)
            painter.setPen(QtGui.QPen(
                QtGui.QColor("#A7FF6A" if sample.reached else "#FFB15C"), 2.0
            ))
            painter.drawPolyline(QtGui.QPolygonF(solved))
            painter.setBrush(QtGui.QColor(167, 255, 106, 25))
            painter.setPen(QtGui.QPen(QtGui.QColor("#A7FF6A"), 1.3))
            radius = 6.0 + sample.weight * 2.0
            painter.drawEllipse(anchor, radius, radius)
            painter.drawLine(before[-1], target)
            if sample.weight < 0.999:
                painter.setPen(QtGui.QPen(QtGui.QColor(167, 255, 106, 105), 1.0, QtCore.Qt.DotLine))
                painter.drawLine(target, anchor)
                painter.setBrush(QtGui.QColor(167, 255, 106, 180))
                painter.setPen(QtCore.Qt.NoPen)
                painter.drawEllipse(target, 2.5, 2.5)
            painter.setPen(QtGui.QColor("#DFFFF0"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6, QtGui.QFont.Bold))
            painter.drawText(
                QtCore.QRectF(anchor.x() - 10, anchor.y() - 18, 20, 10),
                QtCore.Qt.AlignCenter,
                "左" if sample.semantic_side == "left" else "右",
            )
            anchor_hits.append((sample.semantic_side, anchor, scale))
        self._anchor_hits = tuple(anchor_hits)


class RetargetClipTimeline(QtWidgets.QWidget):
    frameActivated = QtCore.Signal(int)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._preview = None
        self._validation = None
        self._hovered = -1
        self._active = -1
        self._points = ()
        self.setMouseTracking(True)
        self.setMinimumHeight(72)
        self.setMaximumHeight(92)

    def set_preview(self, preview):
        self._preview = preview
        self._hovered = -1
        self._active = 0 if preview and preview.signals else -1
        self.update()

    def set_validation(self, validation):
        self._validation = validation
        self.update()

    def set_active(self, index):
        self._active = int(index)
        self.update()

    def hit_point(self, index):
        return self._points[index].toPoint() if 0 <= index < len(self._points) else None

    def mouseMoveEvent(self, event):
        point = event.position() if hasattr(event, "position") else event.localPos()
        ranked = sorted(
            (((value.x() - point.x()) ** 2 + (value.y() - point.y()) ** 2), index)
            for index, value in enumerate(self._points)
        )
        hovered = ranked[0][1] if ranked and ranked[0][0] <= 13.0 ** 2 else -1
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
            self.frameActivated.emit(self._active)
            self.update()
            event.accept()
            return
        super().mousePressEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = QtCore.QRectF(self.rect()).adjusted(1, 1, -1, -1)
        painter.setPen(QtGui.QPen(QtGui.QColor(55, 69, 99, 100), 1))
        painter.setBrush(QtGui.QColor(8, 13, 24, 220))
        painter.drawRoundedRect(rect, 7, 7)
        if not self._preview or not self._preview.signals:
            painter.setPen(QtGui.QColor("#63708A"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 8, QtGui.QFont.DemiBold))
            painter.drawText(rect, QtCore.Qt.AlignCenter, "捕获源 Clip 后显示根运动、旋转增量与足底接触")
            self._points = ()
            return
        signals = self._preview.signals
        plot = rect.adjusted(14, 10, -14, -18)
        maximum_root = max((item.root_motion_target for item in signals), default=1.0) or 1.0
        maximum_rotation = max((item.maximum_rotation_delta_degrees for item in signals), default=1.0) or 1.0
        frame_min, frame_max = signals[0].frame, signals[-1].frame
        frame_span = max(frame_max - frame_min, 1e-8)
        for contact in self._preview.contacts:
            left = plot.left() + (contact.start_frame - frame_min) / frame_span * plot.width()
            right = plot.left() + (contact.end_frame - frame_min) / frame_span * plot.width()
            color = QtGui.QColor("#A7FF6A" if contact.preserved else "#FF416C")
            color.setAlpha(35)
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(color)
            painter.drawRoundedRect(QtCore.QRectF(left, plot.top(), max(3.0, right - left), plot.height()), 3, 3)
        points = []
        rotation_path = QtGui.QPainterPath()
        for index, signal in enumerate(signals):
            x = plot.left() + (signal.frame - frame_min) / frame_span * plot.width()
            root_height = signal.root_motion_target / maximum_root * plot.height() * 0.72
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(QtGui.QColor(157, 108, 255, 105))
            painter.drawRoundedRect(QtCore.QRectF(x - 1.5, plot.bottom() - root_height, 3.0, root_height), 1.5, 1.5)
            rotation_y = plot.bottom() - signal.maximum_rotation_delta_degrees / maximum_rotation * plot.height()
            point = QtCore.QPointF(x, rotation_y)
            if index == 0:
                rotation_path.moveTo(point)
            else:
                rotation_path.lineTo(point)
            points.append(point)
        painter.setBrush(QtCore.Qt.NoBrush)
        painter.setPen(QtGui.QPen(QtGui.QColor("#42E8FF"), 1.4))
        painter.drawPath(rotation_path)
        self._points = tuple(points)
        for index, point in enumerate(points):
            active = index == self._active
            hovered = index == self._hovered
            painter.setPen(QtGui.QPen(QtGui.QColor("#FFFFFF" if hovered else "#A7FF6A" if active else "#42E8FF"), 1.2))
            painter.setBrush(QtGui.QColor(66, 232, 255, 35))
            painter.drawEllipse(point, 4.0 if active or hovered else 2.5, 4.0 if active or hovered else 2.5)
        if self._validation and self._validation.signals:
            maximum_error = self._validation.maximum_position_error or 1.0
            by_frame = {}
            for signal in self._validation.signals:
                by_frame[signal.frame] = max(by_frame.get(signal.frame, 0.0), signal.position_error)
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(QtGui.QColor("#FF416C"))
            for signal in signals:
                error = by_frame.get(signal.frame, 0.0)
                if error <= 1e-5:
                    continue
                x = plot.left() + (signal.frame - frame_min) / frame_span * plot.width()
                height = 2.0 + error / maximum_error * 7.0
                painter.drawRoundedRect(QtCore.QRectF(x - 1.5, plot.bottom() - height, 3.0, height), 1.5, 1.5)
        painter.setPen(QtGui.QColor("#78849B"))
        painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
        painter.drawText(
            QtCore.QRectF(14, rect.bottom() - 15, rect.width() - 28, 12),
            QtCore.Qt.AlignLeft,
            f"Clip {frame_min:g}—{frame_max:g} / 紫色柱 = 根运动 / 电青线 = 旋转增量 / 绿色区 = 接触 / 红色针 = 实际偏差",
        )
        index = self._hovered if self._hovered >= 0 else self._active
        if index >= 0:
            signal = signals[index]
            painter.setPen(QtGui.QColor("#F4F7FF"))
            painter.drawText(
                QtCore.QRectF(14, 2, rect.width() - 28, 14), QtCore.Qt.AlignRight,
                f"第 {signal.frame:g} 帧 / 根运动 {signal.root_motion_target:.2f} / 旋转增量 {signal.maximum_rotation_delta_degrees:.1f}°",
            )


class RetargetWorkspace(QtWidgets.QWidget):
    statusChanged = QtCore.Signal(str)
    nodesActivated = QtCore.Signal(object)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._scanner = MayaSkeletonScanner()
        self._capture = MayaPoseClipCapture()
        self._layer_service = MayaRetargetLayerService(self._capture)
        self._ik_layer_service = MayaContactIKLayerService(self._capture)
        self._clip_store = ClipPackageStore()
        self.source = None
        self.target = None
        self.source_reference = None
        self.target_reference = None
        self.profile = None
        self.preview = None
        self.source_clip = None
        self.clip_preview = None
        self.layer_plan = None
        self.layer_receipt = None
        self.result_validation = None
        self.base_result_validation = None
        self.actual_clip = None
        self.corrected_clip = None
        self.contact_ik_preview = None
        self.contact_ik_plan = None
        self.contact_ik_receipt = None
        self.contact_ik_settings = ContactIKSettings()
        self.axis_templates = retarget_axis_templates()
        self.loaded_clip_package = None
        self.last_export_receipt = None
        self._contact_settings_timer = QtCore.QTimer(self)
        self._contact_settings_timer.setSingleShot(True)
        self._contact_settings_timer.setInterval(80)
        self._contact_settings_timer.timeout.connect(self._refresh_contact_preview)
        self._build_ui()

    def _build_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        self._root_layout = layout
        layout.setContentsMargins(18, 16, 18, 16)
        layout.setSpacing(10)
        header = QtWidgets.QVBoxLayout()
        header.setSpacing(6)
        title_box = QtWidgets.QVBoxLayout()
        eyebrow = QtWidgets.QLabel("动画与重定向 / 语义映射场")
        eyebrow.setStyleSheet("color:#9D6CFF;font-size:9px;font-weight:900;letter-spacing:2px;")
        title = QtWidgets.QLabel("让两个骨架共享意图，而不是共享名字。")
        title.setStyleSheet("font-size:21px;font-weight:850;")
        title_box.addWidget(eyebrow)
        title_box.addWidget(title)
        header.addLayout(title_box)
        actions = QtWidgets.QHBoxLayout()
        actions.addStretch(1)
        self.source_button = QtWidgets.QPushButton("捕获源骨架")
        self.source_button.clicked.connect(self.capture_source)
        self.target_button = QtWidgets.QPushButton("捕获目标骨架")
        self.target_button.clicked.connect(self.capture_target)
        self.preview_button = QtWidgets.QPushButton("生成 Ghost 预览  /")
        self.preview_button.setObjectName("RetargetPreviewButton")
        self.preview_button.setEnabled(False)
        self.preview_button.clicked.connect(self.preview_current_pose)
        actions.addWidget(self.source_button)
        actions.addWidget(self.target_button)
        actions.addWidget(self.preview_button)
        header.addLayout(actions)
        layout.addLayout(header)
        metrics = QtWidgets.QHBoxLayout()
        self.metrics = {}
        self.metric_captions = []
        for key, caption in (
            ("mapping", "语义映射"), ("confidence", "映射置信度"),
            ("scale", "骨架比例"), ("issues", "待确认问题"),
        ):
            card = QtWidgets.QFrame()
            card.setObjectName("MRIMetric")
            card_layout = QtWidgets.QVBoxLayout(card)
            card_layout.setContentsMargins(12, 8, 12, 8)
            value = QtWidgets.QLabel("—")
            value.setStyleSheet("font-size:18px;font-weight:900;color:#F4F7FF;")
            label = QtWidgets.QLabel(caption)
            label.setProperty("muted", True)
            label.setStyleSheet("font-size:7px;font-weight:800;")
            card_layout.addWidget(value)
            card_layout.addWidget(label)
            self.metric_captions.append(label)
            metrics.addWidget(card)
            self.metrics[key] = value
        layout.addLayout(metrics)
        self.stage = RetargetStage()
        self.stage.mappingActivated.connect(self.nodesActivated.emit)
        self.stage.anchorAdjustmentRequested.connect(self.adjust_contact_anchor)
        layout.addWidget(self.stage, 1)
        self.clip_browser = ClipLibraryPanel(
            self._clip_store, self._preflight_clip_path, self
        )
        self.clip_browser.assetActivated.connect(self._load_browser_asset)
        self.clip_browser.closed.connect(self.hide_clip_browser)
        self.clip_browser.setVisible(False)
        layout.addWidget(self.clip_browser, 1)
        self.timeline = RetargetClipTimeline()
        self.timeline.frameActivated.connect(self._activate_clip_frame)
        layout.addWidget(self.timeline)
        tuning = QtWidgets.QFrame()
        tuning.setObjectName("ContactTuningStrip")
        tuning_layout = QtWidgets.QHBoxLayout(tuning)
        tuning_layout.setContentsMargins(10, 5, 10, 5)
        tuning_layout.setSpacing(7)
        self.tuning_caption = QtWidgets.QLabel("接触调校 / 拖动脚底绿环微调锚点")
        self.tuning_caption.setProperty("muted", True)
        self.tuning_caption.setStyleSheet("font-size:8px;")
        self.axis_caption = QtWidgets.QLabel("骨架轴空间")
        self.axis_caption.setProperty("muted", True)
        self.axis_caption.setStyleSheet("font-size:8px;")
        self.axis_combo = QtWidgets.QComboBox()
        self.axis_combo.setObjectName("AxisTemplateCombo")
        for template in self.axis_templates:
            self.axis_combo.addItem(template.label, template.template_id)
        self.axis_combo.setEnabled(False)
        self.axis_combo.currentIndexChanged.connect(self.change_axis_template)
        self.fade_spin = QtWidgets.QSpinBox()
        self.fade_spin.setObjectName("ContactTuningField")
        self.fade_spin.setRange(0, 12)
        self.fade_spin.setValue(2)
        self.fade_spin.setPrefix("过渡 ")
        self.fade_spin.setSuffix(" 帧")
        self.slope_spin = QtWidgets.QDoubleSpinBox()
        self.slope_spin.setObjectName("ContactTuningField")
        self.slope_spin.setRange(-30.0, 30.0)
        self.slope_spin.setDecimals(1)
        self.slope_spin.setSingleStep(1.0)
        self.slope_spin.setPrefix("坡度 ")
        self.slope_spin.setSuffix("°")
        self.ground_spin = QtWidgets.QDoubleSpinBox()
        self.ground_spin.setObjectName("ContactTuningField")
        self.ground_spin.setRange(-100.0, 100.0)
        self.ground_spin.setDecimals(2)
        self.ground_spin.setSingleStep(0.1)
        self.ground_spin.setPrefix("地面 ")
        self.reset_anchor_button = QtWidgets.QPushButton("重置锚点")
        self.reset_anchor_button.setObjectName("ContactResetButton")
        self.reset_anchor_button.clicked.connect(self.reset_contact_anchors)
        tuning_layout.addWidget(self.axis_caption)
        tuning_layout.addWidget(self.axis_combo)
        tuning_layout.addWidget(self.tuning_caption, 1)
        tuning_layout.addWidget(self.fade_spin)
        tuning_layout.addWidget(self.slope_spin)
        tuning_layout.addWidget(self.ground_spin)
        tuning_layout.addWidget(self.reset_anchor_button)
        self.contact_tuning_strip = tuning
        self._contact_controls = (
            self.fade_spin, self.slope_spin, self.ground_spin,
            self.reset_anchor_button,
        )
        self._set_contact_controls_enabled(False)
        layout.addWidget(tuning)
        self.fade_spin.valueChanged.connect(self.schedule_contact_settings_refresh)
        self.slope_spin.valueChanged.connect(self.schedule_contact_settings_refresh)
        self.ground_spin.valueChanged.connect(self.schedule_contact_settings_refresh)
        self.summary = QtWidgets.QLabel("选择源骨架中的任意关节并捕获，然后选择目标骨架。")
        self.summary.setWordWrap(True)
        self.summary.setProperty("muted", True)
        self.summary.setStyleSheet("font-size:9px;")
        layout.addWidget(self.summary)
        transaction = QtWidgets.QFrame()
        transaction.setObjectName("MotionAnchorCapsule")
        transaction_layout = QtWidgets.QHBoxLayout(transaction)
        transaction_layout.setContentsMargins(11, 7, 11, 7)
        self.layer_status = QtWidgets.QLabel("Clip 动画层 / 等待源与目标参考姿态")
        self.layer_status.setProperty("muted", True)
        self.layer_status.setStyleSheet("font-size:8px;")
        self.clip_button = QtWidgets.QPushButton("捕获播放范围 Clip")
        self.clip_button.setEnabled(False)
        self.clip_button.clicked.connect(self.capture_clip)
        self.load_clip_button = QtWidgets.QPushButton("载入资产 Clip")
        self.load_clip_button.setEnabled(False)
        self.load_clip_button.clicked.connect(self.show_clip_browser)
        self.preview_layer_button = QtWidgets.QPushButton("预览动画层")
        self.preview_layer_button.setEnabled(False)
        self.preview_layer_button.clicked.connect(self.preview_layer)
        self.apply_layer_button = QtWidgets.QPushButton("应用并验证")
        self.apply_layer_button.setObjectName("RetargetLayerApply")
        self.apply_layer_button.setEnabled(False)
        self.apply_layer_button.clicked.connect(self.apply_layer)
        self.undo_layer_button = QtWidgets.QPushButton("撤销")
        self.undo_layer_button.setEnabled(False)
        self.undo_layer_button.clicked.connect(self.undo_layer)
        transaction_layout.addWidget(self.layer_status, 1)
        transaction_layout.addWidget(self.clip_button)
        transaction_layout.addWidget(self.load_clip_button)
        transaction_layout.addWidget(self.preview_layer_button)
        transaction_layout.addWidget(self.apply_layer_button)
        transaction_layout.addWidget(self.undo_layer_button)
        layout.addWidget(transaction)
        self.transaction_capsule = transaction

        ik_transaction = QtWidgets.QFrame()
        ik_transaction.setObjectName("MotionAnchorCapsule")
        ik_layout = QtWidgets.QHBoxLayout(ik_transaction)
        ik_layout.setContentsMargins(11, 7, 11, 7)
        self.ik_status = QtWidgets.QLabel("接触 IK / 等待基础重定向结果验证")
        self.ik_status.setProperty("muted", True)
        self.ik_status.setStyleSheet("font-size:8px;")
        self.ik_preview_button = QtWidgets.QPushButton("求解骨盆与接触")
        self.ik_preview_button.setEnabled(False)
        self.ik_preview_button.clicked.connect(self.preview_contact_ik)
        self.ik_plan_button = QtWidgets.QPushButton("预览 IK 动画层")
        self.ik_plan_button.setEnabled(False)
        self.ik_plan_button.clicked.connect(self.preview_contact_ik_layer)
        self.ik_apply_button = QtWidgets.QPushButton("应用并验证 IK")
        self.ik_apply_button.setObjectName("RetargetLayerApply")
        self.ik_apply_button.setEnabled(False)
        self.ik_apply_button.clicked.connect(self.apply_contact_ik_layer)
        self.ik_undo_button = QtWidgets.QPushButton("撤销 IK")
        self.ik_undo_button.setEnabled(False)
        self.ik_undo_button.clicked.connect(self.undo_contact_ik_layer)
        self.export_clip_button = QtWidgets.QPushButton("导出结果 Clip")
        self.export_clip_button.setEnabled(False)
        self.export_clip_button.clicked.connect(self.export_result_clip)
        ik_layout.addWidget(self.ik_status, 1)
        ik_layout.addWidget(self.ik_preview_button)
        ik_layout.addWidget(self.ik_plan_button)
        ik_layout.addWidget(self.ik_apply_button)
        ik_layout.addWidget(self.ik_undo_button)
        ik_layout.addWidget(self.export_clip_button)
        layout.addWidget(ik_transaction)
        self.ik_transaction_capsule = ik_transaction

    def resizeEvent(self, event):
        self._apply_compact_layout(self.height() < 680)
        super().resizeEvent(event)

    def _apply_compact_layout(self, compact):
        self._root_layout.setContentsMargins(10, 9, 10, 9) if compact else self._root_layout.setContentsMargins(18, 16, 18, 16)
        self._root_layout.setSpacing(6 if compact else 10)
        self.stage.setMinimumHeight(110 if compact else 300)
        self.timeline.setMinimumHeight(54 if compact else 72)
        self.timeline.setMaximumHeight(60 if compact else 92)
        self.summary.setVisible(not compact)
        self.layer_status.setVisible(not compact)
        self.ik_status.setVisible(not compact)
        self.tuning_caption.setVisible(not compact)
        self.axis_caption.setVisible(not compact)
        self.axis_combo.setMinimumWidth(136 if compact else 176)
        for caption in self.metric_captions:
            caption.setVisible(not compact)
        self.clip_button.setText("捕获 Clip" if compact else "捕获播放范围 Clip")
        self.load_clip_button.setText("浏览 Clip" if compact else "浏览资产 Clip")
        self.preview_layer_button.setText("预览层" if compact else "预览动画层")
        if not self.layer_receipt:
            self.apply_layer_button.setText("应用验证" if compact else "应用并验证")
        self.ik_preview_button.setText("求解接触" if compact else "求解骨盆与接触")
        self.ik_plan_button.setText("预览 IK 层" if compact else "预览 IK 动画层")
        if not self.contact_ik_receipt:
            self.ik_apply_button.setText("应用 IK" if compact else "应用并验证 IK")
        self.export_clip_button.setText("导出 Clip" if compact else "导出结果 Clip")

    def capture_source(self):
        if self.layer_receipt or self.contact_ik_receipt:
            self.layer_status.setText("请先依次撤销接触 IK 层与重定向层，再重新捕获参考骨架")
            return
        analysis = self._scanner.capture_selection()
        if not analysis.is_usable:
            self._show_error("源骨架不可用", analysis)
            return
        try:
            reference = self._capture.capture_pose(
                tuple(joint.path for joint in analysis.joints), "源参考姿态"
            ).frame
        except Exception as exc:
            self.summary.setText(f"源姿态捕获失败：{type(exc).__name__}: {exc}")
            return
        self.source, self.source_reference = analysis, reference
        self._reset_clip_state()
        self._rebuild_profile()
        self.statusChanged.emit(f"已捕获源骨架 / {len(analysis.joints)} 个关节 / 零写入")

    def capture_target(self):
        if self.layer_receipt or self.contact_ik_receipt:
            self.layer_status.setText("请先依次撤销接触 IK 层与重定向层，再重新捕获参考骨架")
            return
        analysis = self._scanner.capture_selection()
        if not analysis.is_usable:
            self._show_error("目标骨架不可用", analysis)
            return
        try:
            reference = self._capture.capture_pose(
                tuple(joint.path for joint in analysis.joints), "目标参考姿态"
            ).frame
        except Exception as exc:
            self.summary.setText(f"目标姿态捕获失败：{type(exc).__name__}: {exc}")
            return
        self.target, self.target_reference = analysis, reference
        self._reset_clip_state()
        self._rebuild_profile()
        self.statusChanged.emit(f"已捕获目标骨架 / {len(analysis.joints)} 个关节 / 零写入")

    def _rebuild_profile(self):
        self.profile = build_retarget_profile(self.source, self.target) if self.source and self.target else None
        if self.profile:
            self.profile = with_retarget_axis_template(
                self.profile, self.axis_templates[self.axis_combo.currentIndex()]
            )
        self.axis_combo.setEnabled(bool(self.profile and self.profile.can_preview and not self.layer_receipt))
        self.preview_button.setEnabled(bool(self.profile and self.profile.can_preview))
        self.clip_button.setEnabled(bool(self.profile and self.profile.can_preview))
        self.load_clip_button.setEnabled(bool(self.profile and self.profile.can_preview))
        if self.profile:
            self.metrics["mapping"].setText(str(len(self.profile.mappings)))
            self.metrics["confidence"].setText(f"{self.profile.confidence:.0%}")
            self.metrics["scale"].setText(f"{self.profile.scale_ratio:.2f}×")
            self.metrics["issues"].setText(str(len(self.profile.issues) + len(self.profile.blockers)))
            details = self.profile.blockers or self.profile.issues
            self.summary.setText(
                f"{len(self.profile.mappings)} 个语义已连接 / 比例 {self.profile.scale_ratio:.3f} / "
                f"置信度 {self.profile.confidence:.0%} / 轴空间 {self.profile.axis_template.label}"
                + ("\n" + " / ".join(details[:3]) if details else "")
            )
        self.stage.set_data(self.source, self.target, self.profile, self.preview, self.contact_ik_preview)

    def preview_current_pose(self):
        if not self.profile or not self.profile.can_preview:
            return
        try:
            source_pose = self._capture.capture_pose(
                tuple(joint.path for joint in self.source.joints), "源当前姿态"
            ).frame
            self.preview = preview_retarget_pose(
                source_pose, self.source_reference, self.target_reference, self.profile
            )
        except Exception as exc:
            self.summary.setText(f"Ghost 预览失败：{type(exc).__name__}: {exc}")
            return
        maximum_rotation = max((item.rotation_delta_degrees for item in self.preview.signals), default=0.0)
        self.summary.setText(
            f"零写入 Ghost / {len(self.preview.signals)} 个语义信号 / 最大旋转增量 {maximum_rotation:.1f}° / "
            f"轴空间 {self.profile.axis_template.label} / 目标 Maya 骨架未修改"
        )
        self.stage.set_data(self.source, self.target, self.profile, self.preview, self.contact_ik_preview)
        self.statusChanged.emit(self.summary.text())

    def capture_clip(self):
        if not self.profile or not self.profile.can_preview:
            return
        self.clip_button.setEnabled(False)
        self.clip_button.setText("正在采样 Clip…")
        QtWidgets.QApplication.processEvents()
        try:
            self.source_clip = self._capture.capture_clip(
                tuple(joint.path for joint in self.source.joints),
                label="源播放范围 Clip",
            )
            self.clip_preview = preview_retarget_clip(
                self.source_clip, self.source_reference, self.target_reference, self.profile
            )
        except Exception as exc:
            self.layer_status.setText(f"Clip 捕获失败：{type(exc).__name__}: {exc}")
            self.source_clip = None
            self.clip_preview = None
        finally:
            self.clip_button.setText("捕获 Clip" if self.height() < 680 else "捕获播放范围 Clip")
            self.clip_button.setEnabled(True)
        if not self.clip_preview:
            return
        self.loaded_clip_package = None
        self._accept_source_clip("场景播放范围")

    def show_clip_browser(self, directory=None):
        if isinstance(directory, bool):
            directory = None
        if not self.profile or not self.profile.can_preview:
            return
        if self.layer_receipt or self.contact_ik_receipt:
            self.layer_status.setText("请先撤销现有动画层，再浏览 Clip 资产")
            return
        self.stage.setVisible(False)
        self.timeline.setVisible(False)
        self.contact_tuning_strip.setVisible(False)
        self.summary.setVisible(False)
        self.transaction_capsule.setVisible(False)
        self.ik_transaction_capsule.setVisible(False)
        self.clip_browser.setVisible(True)
        if directory:
            self.clip_browser.load_directory(directory)
        elif not self.clip_browser.directory:
            self.clip_browser.choose_directory()

    def hide_clip_browser(self):
        self.clip_browser.setVisible(False)
        self.stage.setVisible(True)
        self.timeline.setVisible(True)
        self.contact_tuning_strip.setVisible(True)
        self.transaction_capsule.setVisible(True)
        self.ik_transaction_capsule.setVisible(True)
        self._apply_compact_layout(self.height() < 680)

    def _preflight_clip_path(self, path):
        package = self._clip_store.read(path)
        return preflight_clip_package(
            package,
            self.source_reference,
            self.profile.axis_template,
            maximum_nodes=self._capture.MAXIMUM_NODES,
            maximum_frame_samples=self._capture.MAXIMUM_FRAME_SAMPLES,
        )

    def _load_browser_asset(self, path):
        package = self.load_clip_package(path)
        if package is not None:
            self.hide_clip_browser()

    def load_clip_package(self, path=None):
        if isinstance(path, bool):
            path = None
        if not self.profile or not self.profile.can_preview:
            return
        if self.layer_receipt or self.contact_ik_receipt:
            self.layer_status.setText("请先撤销现有动画层，再载入 Clip 资产")
            return
        if path is None:
            path, _selected = QtWidgets.QFileDialog.getOpenFileName(
                self, "载入 MayaCraft Clip 资产", "",
                "MayaCraft Clip (*.mayaclip *.json);;JSON (*.json);;所有文件 (*)",
            )
        if not path:
            return
        try:
            package = self._clip_store.read(path)
            preflight = preflight_clip_package(
                package,
                self.source_reference,
                self.profile.axis_template,
                maximum_nodes=self._capture.MAXIMUM_NODES,
                maximum_frame_samples=self._capture.MAXIMUM_FRAME_SAMPLES,
            )
            if preflight.blockers:
                raise ValueError("；".join(preflight.blockers))
            path_by_key = {node.key: node.node_path for node in self.source_reference.nodes}
            remapped = remap_clip_package_paths(package, path_by_key)
            self.source_clip = remapped.clip
            self.source_reference = remapped.reference_pose
            self.clip_preview = preview_retarget_clip(
                self.source_clip, self.source_reference, self.target_reference, self.profile
            )
            self.loaded_clip_package = remapped
        except Exception as exc:
            self.layer_status.setText(f"Clip 资产载入失败：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.layer_status.text())
            return
        migrated = " / 已迁移旧版首帧参考" if package.migrated_from else ""
        self._accept_source_clip(f"资产 {Path(path).name}{migrated}")
        return self.loaded_clip_package

    def _accept_source_clip(self, origin):
        self.timeline.set_preview(self.clip_preview)
        self.timeline.set_validation(None)
        self.preview = self.clip_preview.frames[0]
        self.stage.set_data(self.source, self.target, self.profile, self.preview)
        self.preview_layer_button.setEnabled(True)
        self.apply_layer_button.setEnabled(False)
        self.undo_layer_button.setEnabled(False)
        self.layer_plan = None
        self.layer_receipt = None
        self.result_validation = None
        self.base_result_validation = None
        self.actual_clip = None
        self.corrected_clip = None
        self.contact_ik_preview = None
        self.contact_ik_plan = None
        self.contact_ik_receipt = None
        self.ik_preview_button.setEnabled(False)
        self.ik_plan_button.setEnabled(False)
        self.ik_apply_button.setEnabled(False)
        self.ik_undo_button.setEnabled(False)
        self.ik_status.setText("接触 IK / 等待基础重定向结果验证")
        self._set_contact_controls_enabled(False)
        self.axis_combo.setEnabled(True)
        self.contact_ik_settings = replace(self.contact_ik_settings, anchor_offsets=())
        self.export_clip_button.setEnabled(False)
        self.last_export_receipt = None
        failed_contacts = sum(not item.preserved for item in self.clip_preview.contacts)
        self.layer_status.setText(
            f"零写入 Clip / {origin} / {len(self.source_clip.frames)} 帧 / "
            f"接触保持 {self.clip_preview.contact_preservation:.0%} / {failed_contacts} 个接触待修正"
        )
        self.statusChanged.emit(self.layer_status.text())

    def export_result_clip(self, path=None, overwrite=None):
        if isinstance(path, bool):
            path = None
        clip = self.corrected_clip or self.actual_clip
        if clip is None or self.target_reference is None:
            self.ik_status.setText("没有经过验证的目标结果可供导出")
            return None
        interactive = path is None
        if interactive:
            suggested = (clip.label or "MayaCraft_重定向结果") + ".mayaclip"
            path, _selected = QtWidgets.QFileDialog.getSaveFileName(
                self, "导出 MayaCraft Clip 结果", suggested,
                "MayaCraft Clip (*.mayaclip);;JSON (*.json)",
            )
        if not path:
            return None
        target = Path(path)
        if not target.suffix:
            target = target.with_suffix(".mayaclip")
        package = ClipPackage(
            clip=clip,
            reference_pose=self.target_reference,
            display_name=clip.label,
            tags=tuple(filter(None, (
                "重定向结果",
                "接触 IK" if self.corrected_clip is not None else "基础重定向",
            ))),
            coordinate_forward=self.profile.axis_template.target_forward,
            coordinate_up=self.profile.axis_template.target_up,
            metadata=tuple(sorted((
                ("产品", "MayaCraft"),
                ("目标根节点", self.profile.target_root),
                ("接触保持率", f"{self.result_validation.contact_preservation:.6f}"),
                ("包含接触IK", "是" if self.corrected_clip is not None else "否"),
                ("轴模板ID", self.profile.axis_template.template_id),
                ("轴模板", self.profile.axis_template.label),
                ("接触过渡帧", str(self.contact_ik_settings.fade_frames)),
                ("地面法线", ",".join(f"{value:.6f}" for value in self.contact_ik_settings.ground_normal)),
                ("地面高度", f"{self.contact_ik_settings.ground_offset:.6f}"),
                (
                    "脚底锚点偏移",
                    ";".join(
                        side + ":" + ",".join(f"{value:.6f}" for value in offset)
                        for side, offset in self.contact_ik_settings.anchor_offsets
                    ) or "无",
                ),
            ))),
        )
        try:
            self.last_export_receipt = self._clip_store.write(
                target, package,
                overwrite=interactive if overwrite is None else bool(overwrite),
            )
        except Exception as exc:
            self.ik_status.setText(f"Clip 结果导出失败：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.ik_status.text())
            return None
        self.ik_status.setText("导出验证通过 / " + self.last_export_receipt.message)
        self.statusChanged.emit(self.ik_status.text())
        return self.last_export_receipt

    @staticmethod
    def _pose_extent(frame):
        if not frame.nodes:
            return 0.0
        axes = tuple(tuple(node.world_translation[axis] for node in frame.nodes) for axis in range(3))
        return max((max(values) - min(values) for values in axes), default=0.0)

    def _activate_clip_frame(self, index):
        if not self.clip_preview or not 0 <= index < len(self.clip_preview.frames):
            return
        self.preview = self.clip_preview.frames[index]
        self.stage.set_data(self.source, self.target, self.profile, self.preview, self.contact_ik_preview)
        frame = self.source_clip.frames[index].frame
        try:
            MayaMotionCapture.go_to_frame(frame)
        except Exception as exc:
            self.layer_status.setText(f"时间定位失败：{type(exc).__name__}: {exc}")
            return
        self.layer_status.setText(
            f"第 {frame:g} 帧 Ghost / 根运动 {self.clip_preview.signals[index].root_motion_target:.2f} / "
            f"最大旋转增量 {self.clip_preview.signals[index].maximum_rotation_delta_degrees:.1f}°"
        )

    def preview_layer(self):
        if self.source_clip is None:
            return
        try:
            self.layer_plan = self._layer_service.plan(
                self.source_clip, self.source_reference, self.target_reference, self.profile
            )
        except Exception as exc:
            self.layer_status.setText(f"动画层预览失败：{type(exc).__name__}: {exc}")
            return
        self.layer_receipt = None
        self.undo_layer_button.setEnabled(False)
        if self.layer_plan.blockers:
            self.layer_status.setText("已阻断 / " + " / ".join(self.layer_plan.blockers[:3]))
            self.apply_layer_button.setEnabled(False)
        elif self.layer_plan.is_noop:
            self.layer_status.setText("预览验证通过 / 目标动画已经符合当前语义 Clip")
            self.apply_layer_button.setEnabled(False)
        else:
            translated = sum(key.write_translation for key in self.layer_plan.keys)
            self.layer_status.setText(
                f"零写入计划 / {len(self.layer_plan.keys)} 个语义节点帧 / "
                f"{translated} 个根运动帧 / Override Animation Layer"
            )
            self.apply_layer_button.setEnabled(True)
        self.statusChanged.emit(self.layer_status.text())

    def apply_layer(self):
        if not self.layer_plan or not self.layer_plan.can_apply:
            return
        self.apply_layer_button.setEnabled(False)
        self.apply_layer_button.setText("正在读回验证…")
        QtWidgets.QApplication.processEvents()
        try:
            self.layer_receipt = self._layer_service.apply(self.layer_plan)
        except Exception as exc:
            self.layer_status.setText(f"已回滚 / {type(exc).__name__}: {exc}")
            self.apply_layer_button.setText("应用并验证")
            self.statusChanged.emit(self.layer_status.text())
            return
        try:
            frames = tuple(frame.frame for frame in self.source_clip.frames)
            step = frames[1] - frames[0] if len(frames) > 1 else 1.0
            self.actual_clip = self._capture.capture_clip(
                tuple(joint.path for joint in self.target.joints),
                start=frames[0], end=frames[-1], step=step,
                label="目标重定向结果",
            )
            self.result_validation = validate_retarget_result(
                self.actual_clip, self.clip_preview, self.profile
            )
            self.base_result_validation = self.result_validation
            self.timeline.set_validation(self.result_validation)
        except Exception as exc:
            try:
                self._layer_service.undo(self.layer_receipt)
            finally:
                self.layer_receipt = None
            self.layer_status.setText(f"结果验证失败并已回滚：{type(exc).__name__}: {exc}")
            self.apply_layer_button.setText("应用并验证")
            self.statusChanged.emit(self.layer_status.text())
            return
        self.apply_layer_button.setText("验证通过")
        self.undo_layer_button.setEnabled(True)
        self.ik_preview_button.setEnabled(
            self.result_validation.contact_preservation < 1.0
        )
        self.axis_combo.setEnabled(False)
        self._set_contact_controls_enabled(True)
        self.export_clip_button.setEnabled(True)
        self.last_export_receipt = None
        self.ik_status.setText(
            f"基础结果 / 接触保持 {self.result_validation.contact_preservation:.0%} / "
            "可进入骨盆补偿与接触求解"
        )
        self.layer_status.setText(
            "验证通过 / " + self.layer_receipt.message
            + f" / 世界旋转误差 {self.result_validation.maximum_rotation_error_degrees:.3f}°"
            + f" / 接触保持 {self.result_validation.contact_preservation:.0%} / 可撤销"
        )
        self.statusChanged.emit(self.layer_status.text())

    def preview_contact_ik(self):
        if not self.actual_clip or not self.clip_preview:
            return
        self._contact_settings_timer.stop()
        self.contact_ik_settings = self._settings_from_controls()
        try:
            self.contact_ik_preview = preview_retarget_contact_ik(
                self.actual_clip, self.clip_preview, self.profile,
                settings=self.contact_ik_settings,
            )
        except Exception as exc:
            self.ik_status.setText(f"接触 IK 预览失败：{type(exc).__name__}: {exc}")
            return
        self.stage.set_data(
            self.source, self.target, self.profile, self.preview, self.contact_ik_preview
        )
        self.contact_ik_plan = None
        self.ik_plan_button.setEnabled(
            bool(self.contact_ik_preview.samples) and not self.contact_ik_preview.unreachable_count
        )
        self.ik_apply_button.setEnabled(False)
        self._set_contact_preview_status("零写入全身约束预览")
        self.statusChanged.emit(self.ik_status.text())

    def schedule_contact_settings_refresh(self, _value=None):
        if self.contact_ik_receipt or not self.actual_clip:
            return
        self._contact_settings_timer.start()

    def _set_contact_controls_enabled(self, enabled):
        for widget in getattr(self, "_contact_controls", ()):
            widget.setEnabled(bool(enabled))

    def change_axis_template(self, index):
        if not self.profile or self.layer_receipt or self.contact_ik_receipt:
            return
        try:
            template = self.axis_templates[int(index)]
            self.profile = with_retarget_axis_template(self.profile, template)
            if self.source_clip:
                self.clip_preview = preview_retarget_clip(
                    self.source_clip, self.source_reference,
                    self.target_reference, self.profile,
                )
                self._accept_source_clip(f"轴模板 {template.label}")
            elif self.preview:
                self.preview_current_pose()
            else:
                self.stage.set_data(
                    self.source, self.target, self.profile,
                    self.preview, self.contact_ik_preview,
                )
                self.summary.setText(
                    f"轴空间已切换为 {template.label} / 当前为零写入映射配置"
                )
        except Exception as exc:
            self.summary.setText(f"轴模板切换失败：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.summary.text())
            return
        self.statusChanged.emit(
            f"轴空间已切换为 {template.label} / Ghost 已重新计算 / Maya 场景未修改"
        )

    def _settings_from_controls(self):
        radians = math.radians(float(self.slope_spin.value()))
        return ContactIKSettings(
            ground_normal=(0.0, math.cos(radians), math.sin(radians)),
            ground_offset=float(self.ground_spin.value()),
            fade_frames=int(self.fade_spin.value()),
            anchor_offsets=self.contact_ik_settings.anchor_offsets,
            align_root_to_ground=True,
        )

    def _refresh_contact_preview(self):
        if self.contact_ik_receipt or not self.actual_clip or not self.clip_preview:
            return
        self.contact_ik_settings = self._settings_from_controls()
        try:
            self.contact_ik_preview = preview_retarget_contact_ik(
                self.actual_clip, self.clip_preview, self.profile,
                settings=self.contact_ik_settings,
            )
        except Exception as exc:
            self.ik_status.setText(f"接触调校失败：{type(exc).__name__}: {exc}")
            self.ik_plan_button.setEnabled(False)
            self.ik_apply_button.setEnabled(False)
            return
        self.contact_ik_plan = None
        self.ik_plan_button.setEnabled(
            bool(self.contact_ik_preview.samples) and not self.contact_ik_preview.unreachable_count
        )
        self.ik_apply_button.setEnabled(False)
        self.stage.set_data(
            self.source, self.target, self.profile, self.preview, self.contact_ik_preview
        )
        self._set_contact_preview_status("调校已更新 / 零写入")
        self.statusChanged.emit(self.ik_status.text())

    def adjust_contact_anchor(self, payload):
        if self.contact_ik_receipt or not self.contact_ik_preview:
            return
        side, offset = payload
        offsets = dict(self.contact_ik_settings.anchor_offsets)
        offsets[str(side)] = tuple(float(value) for value in offset)
        self.contact_ik_settings = replace(
            self.contact_ik_settings,
            anchor_offsets=tuple(sorted(offsets.items())),
        )
        self._refresh_contact_preview()
        side_label = "左脚" if side == "left" else "右脚"
        self.ik_status.setText(
            f"{side_label}锚点已微调 / X {offset[0]:+.3f} / Y {offset[1]:+.3f} / "
            "目标 Maya 骨架未修改"
        )
        self.statusChanged.emit(self.ik_status.text())

    def reset_contact_anchors(self):
        if self.contact_ik_receipt:
            return
        self.contact_ik_settings = replace(self.contact_ik_settings, anchor_offsets=())
        self._refresh_contact_preview()

    def _set_contact_preview_status(self, prefix):
        if not self.contact_ik_preview:
            return
        self.ik_status.setText(
            f"{prefix} / 坡度 {self.contact_ik_preview.maximum_ground_angle_degrees:.1f}° / "
            f"骨盆补偿 {self.contact_ik_preview.maximum_pelvis_offset:.5f} / "
            f"{self.contact_ik_preview.solved_count} 个链帧收敛 / "
            f"{self.contact_ik_preview.unreachable_count} 个不可达 / "
            f"末端误差 {self.contact_ik_preview.maximum_error:.5f}"
        )

    def preview_contact_ik_layer(self):
        if not self.actual_clip or not self.contact_ik_preview:
            return
        self._contact_settings_timer.stop()
        try:
            self.contact_ik_plan = self._ik_layer_service.plan(
                self.actual_clip, self.contact_ik_preview, self.profile
            )
        except Exception as exc:
            self.ik_status.setText(f"IK 动画层预览失败：{type(exc).__name__}: {exc}")
            return
        if self.contact_ik_plan.blockers:
            self.ik_status.setText("已阻断 / " + " / ".join(self.contact_ik_plan.blockers[:3]))
            self.ik_apply_button.setEnabled(False)
        elif self.contact_ik_plan.is_noop:
            self.ik_status.setText("接触 IK 无需写入 / 当前结果已满足全部锚点")
            self.ik_apply_button.setEnabled(False)
        else:
            pelvis_keys = sum(key.write_translation for key in self.contact_ik_plan.keys)
            self.ik_status.setText(
                f"零写入 IK 层计划 / {len(self.contact_ik_plan.keys)} 个节点帧 / "
                f"{pelvis_keys} 个骨盆补偿键 / 独立覆盖动画层"
            )
            self.ik_apply_button.setEnabled(True)
        self.statusChanged.emit(self.ik_status.text())

    def apply_contact_ik_layer(self):
        if not self.contact_ik_plan or not self.contact_ik_plan.can_apply:
            return
        self._contact_settings_timer.stop()
        self.ik_apply_button.setEnabled(False)
        self.ik_apply_button.setText("正在验证脚底锚点…")
        QtWidgets.QApplication.processEvents()
        try:
            self.contact_ik_receipt = self._ik_layer_service.apply(self.contact_ik_plan)
            frames = tuple(frame.frame for frame in self.source_clip.frames)
            step = frames[1] - frames[0] if len(frames) > 1 else 1.0
            self.corrected_clip = self._capture.capture_clip(
                tuple(joint.path for joint in self.target.joints),
                start=frames[0], end=frames[-1], step=step,
                label="目标接触 IK 结果",
            )
            self.result_validation = validate_retarget_result(
                self.corrected_clip, self.clip_preview, self.profile
            )
            # Slope alignment and artist-adjusted anchors intentionally move the
            # feet away from the original Ghost positions. The adapter has just
            # read back every current intent target, so report contact against
            # those verified targets instead of the superseded Ghost anchors.
            self.result_validation = replace(
                self.result_validation,
                contact_preservation=(
                    1.0 if self.contact_ik_receipt.verified
                    and self.contact_ik_receipt.maximum_anchor_error <= 0.02
                    else 0.0
                ),
            )
            self.timeline.set_validation(self.result_validation)
        except Exception as exc:
            if self.contact_ik_receipt:
                try:
                    self._ik_layer_service.undo(self.contact_ik_receipt)
                except Exception as undo_exc:
                    self.ik_status.setText(
                        f"接触 IK 验证失败，自动撤销也失败：{type(undo_exc).__name__}: {undo_exc}"
                    )
                    self.statusChanged.emit(self.ik_status.text())
                    return
            self.contact_ik_receipt = None
            self.corrected_clip = None
            self.ik_apply_button.setText("应用并验证 IK")
            self.ik_status.setText(f"接触 IK 已回滚：{type(exc).__name__}: {exc}")
            self.statusChanged.emit(self.ik_status.text())
            return
        self.ik_apply_button.setText("IK 验证通过")
        self._set_contact_controls_enabled(False)
        self.export_clip_button.setEnabled(True)
        self.last_export_receipt = None
        self.ik_undo_button.setEnabled(True)
        self.ik_preview_button.setEnabled(False)
        self.ik_plan_button.setEnabled(False)
        self.ik_status.setText(
            "IK 验证通过 / " + self.contact_ik_receipt.message
            + f" / 接触保持 {self.result_validation.contact_preservation:.0%} / 可撤销"
        )
        self.statusChanged.emit(self.ik_status.text())

    def undo_contact_ik_layer(self):
        if not self.contact_ik_receipt:
            return
        try:
            self._ik_layer_service.undo(self.contact_ik_receipt)
        except Exception as exc:
            self.ik_status.setText(f"IK 撤销验证失败：{type(exc).__name__}: {exc}")
            return
        self.contact_ik_receipt = None
        self.corrected_clip = None
        self.last_export_receipt = None
        self.result_validation = self.base_result_validation
        self.timeline.set_validation(self.result_validation)
        self.ik_apply_button.setText("应用并验证 IK")
        self.ik_apply_button.setEnabled(bool(self.contact_ik_plan and self.contact_ik_plan.can_apply))
        self.ik_undo_button.setEnabled(False)
        self.ik_preview_button.setEnabled(True)
        self._set_contact_controls_enabled(True)
        self.ik_plan_button.setEnabled(bool(self.contact_ik_preview))
        self.ik_status.setText("IK 撤销验证通过 / 已恢复基础重定向结果与脚滑诊断")
        self.statusChanged.emit(self.ik_status.text())

    def undo_layer(self):
        if self.contact_ik_receipt:
            self.layer_status.setText("请先撤销接触 IK 层，再撤销基础重定向层")
            return
        if not self.layer_receipt:
            return
        try:
            self._layer_service.undo(self.layer_receipt)
        except Exception as exc:
            self.layer_status.setText(f"撤销验证失败：{type(exc).__name__}: {exc}")
            return
        self.layer_receipt = None
        self.result_validation = None
        self.base_result_validation = None
        self.actual_clip = None
        self.corrected_clip = None
        self.contact_ik_preview = None
        self.contact_ik_plan = None
        self.timeline.set_validation(None)
        self.ik_preview_button.setEnabled(False)
        self.ik_plan_button.setEnabled(False)
        self.ik_apply_button.setEnabled(False)
        self.ik_undo_button.setEnabled(False)
        self.export_clip_button.setEnabled(False)
        self.ik_status.setText("接触 IK / 等待基础重定向结果验证")
        self._set_contact_controls_enabled(False)
        self.axis_combo.setEnabled(bool(self.profile and self.profile.can_preview))
        self.layer_plan = None
        self.apply_layer_button.setText("应用并验证")
        self.apply_layer_button.setEnabled(False)
        self.undo_layer_button.setEnabled(False)
        self.layer_status.setText("撤销验证通过 / 目标基线动画与层级状态已恢复")
        self.statusChanged.emit(self.layer_status.text())

    def _reset_clip_state(self):
        self.preview = None
        self.source_clip = None
        self.clip_preview = None
        self.layer_plan = None
        self.layer_receipt = None
        self.result_validation = None
        self.base_result_validation = None
        self.actual_clip = None
        self.corrected_clip = None
        self.contact_ik_preview = None
        self.contact_ik_plan = None
        self.contact_ik_receipt = None
        self.contact_ik_settings = replace(self.contact_ik_settings, anchor_offsets=())
        self.loaded_clip_package = None
        self.last_export_receipt = None
        self.timeline.set_preview(None)
        self.timeline.set_validation(None)
        self.preview_layer_button.setEnabled(False)
        self.apply_layer_button.setEnabled(False)
        self.apply_layer_button.setText("应用并验证")
        self.undo_layer_button.setEnabled(False)
        self.ik_preview_button.setEnabled(False)
        self.ik_plan_button.setEnabled(False)
        self.ik_apply_button.setEnabled(False)
        self.ik_apply_button.setText("应用并验证 IK")
        self.ik_undo_button.setEnabled(False)
        self.export_clip_button.setEnabled(False)
        self.ik_status.setText("接触 IK / 等待基础重定向结果验证")
        self._set_contact_controls_enabled(False)
        self.axis_combo.setEnabled(bool(self.profile and self.profile.can_preview))
        self.layer_status.setText("Clip 动画层 / 等待捕获源播放范围")

    def _show_error(self, label, analysis):
        details = tuple(issue.message for issue in analysis.issues)
        self.summary.setText(label + "：" + (" / ".join(details[:3]) if details else "请选择关节层级"))
        self.statusChanged.emit(self.summary.text())


__all__ = ["RetargetStage", "RetargetWorkspace"]
