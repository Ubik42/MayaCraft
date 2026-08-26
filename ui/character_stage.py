"""Animated central stage for the currently captured character."""

from __future__ import annotations

import math

from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.character import CharacterSnapshot
from MayaCraft.domain.canvas import hit_test, project_rig_nodes
from MayaCraft.domain.rig_health import analyze_rig, focus_rig_nodes
from MayaCraft.ui.theme import ensure_ui_font

UI_FONT_FAMILY = ensure_ui_font()


class CharacterStage(QtWidgets.QWidget):
    """A lightweight procedural visualization that remains responsive inside Maya."""

    nodeHovered = QtCore.Signal(str)
    nodeActivated = QtCore.Signal(str)
    moduleFocused = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._snapshot = CharacterSnapshot.empty()
        self._phase = 0.0
        self._projected_nodes = ()
        self._hovered_path = ""
        self._health = analyze_rig(())
        self._focused_module = ""
        self._hovered_module = ""
        self._module_regions = ()
        self.setMinimumSize(360, 390)
        self.setAttribute(QtCore.Qt.WA_OpaquePaintEvent, True)
        self.setMouseTracking(True)
        self.setFocusPolicy(QtCore.Qt.StrongFocus)
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(33)
        self._timer.timeout.connect(self._tick)
        self._timer.start()

    def set_snapshot(self, snapshot: CharacterSnapshot) -> None:
        self._snapshot = snapshot
        self._health = analyze_rig(snapshot.rig_nodes)
        if self._focused_module and self._health.module(self._focused_module) is None:
            self._focused_module = ""
        if self._hovered_path and not any(node.path == self._hovered_path for node in snapshot.rig_nodes):
            self._set_hovered_path("")
        self.update()

    def hit_point(self, path: str):
        """Expose a projected point for deterministic Maya/Qt interaction tests."""
        for node in self._projected_nodes:
            if node.path == path:
                return QtCore.QPoint(round(node.x), round(node.y))
        return None

    def module_hit_point(self, key: str):
        for module_key, rect in self._module_regions:
            if module_key == key:
                return rect.center().toPoint()
        return None

    def module_health(self, key: str):
        return self._health.module(key)

    @property
    def focused_module(self) -> str:
        return self._focused_module

    def mouseMoveEvent(self, event) -> None:
        point = event.position() if hasattr(event, "position") else event.localPos()
        hovered_module = next((key for key, rect in self._module_regions if rect.contains(point)), "")
        if hovered_module != self._hovered_module:
            self._hovered_module = hovered_module
            self.update()
        hit = hit_test(self._projected_nodes, (point.x(), point.y()))
        self._set_hovered_path(hit.path if hit else "")
        if hovered_module and not hit:
            self.setCursor(QtCore.Qt.PointingHandCursor)
        super().mouseMoveEvent(event)

    def leaveEvent(self, event) -> None:
        self._set_hovered_path("")
        self._hovered_module = ""
        super().leaveEvent(event)

    def mousePressEvent(self, event) -> None:
        if event.button() == QtCore.Qt.LeftButton:
            point = event.position() if hasattr(event, "position") else event.localPos()
            module_key = next((key for key, rect in self._module_regions if rect.contains(point)), "")
            if module_key:
                self._focused_module = "" if self._focused_module == module_key else module_key
                self.moduleFocused.emit(self._focused_module)
                self.update()
                event.accept()
                return
            hit = hit_test(self._projected_nodes, (point.x(), point.y()))
            if hit:
                self.nodeActivated.emit(hit.path)
                event.accept()
                return
        super().mousePressEvent(event)

    def keyPressEvent(self, event) -> None:
        if event.key() == QtCore.Qt.Key_Escape and self._focused_module:
            self._focused_module = ""
            self.moduleFocused.emit("")
            self.update()
            event.accept()
            return
        super().keyPressEvent(event)

    def _set_hovered_path(self, path: str) -> None:
        if path == self._hovered_path:
            return
        self._hovered_path = path
        self.setCursor(QtCore.Qt.PointingHandCursor if path else QtCore.Qt.ArrowCursor)
        self.nodeHovered.emit(path)
        self.update()

    def _tick(self) -> None:
        if self.isVisible():
            self._phase = (self._phase + 0.018) % 1.0
            self.update()

    def paintEvent(self, _event) -> None:
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect = self.rect()
        gradient = QtGui.QRadialGradient(rect.center(), max(rect.width(), rect.height()) * 0.7)
        gradient.setColorAt(0.0, QtGui.QColor("#192033"))
        gradient.setColorAt(0.48, QtGui.QColor("#0D1019"))
        gradient.setColorAt(1.0, QtGui.QColor("#07080D"))
        painter.fillRect(rect, gradient)

        center = QtCore.QPointF(rect.center().x(), rect.center().y() - 10)
        self._draw_grid(painter, rect)
        self._draw_orbits(painter, center)
        self._draw_avatar(painter, center)
        self._draw_titles(painter, rect)
        self._draw_module_spectrum(painter, rect)
        painter.end()

    def _draw_grid(self, painter, rect) -> None:
        painter.setPen(QtGui.QPen(QtGui.QColor(40, 53, 76, 95), 1))
        horizon = int(rect.height() * 0.68)
        for offset in range(0, rect.height() - horizon + 80, 24):
            y = horizon + offset
            painter.drawLine(0, y, rect.width(), y)
        for x in range(-rect.width(), rect.width() * 2, 46):
            painter.drawLine(rect.center().x(), horizon - 22, x, rect.height())

    def _draw_orbits(self, painter, center) -> None:
        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        primary = "#A7FF6A" if self._snapshot.registered else "#42E8FF"
        for index, (width, color, alpha) in enumerate(((250, primary, 150), (310, "#9D6CFF", 82), (370, "#FF5C7C", 52))):
            orbit = QtCore.QRectF(center.x() - width / 2, center.y() - width * 0.36, width, width * 0.72)
            pen = QtGui.QPen(QtGui.QColor(color))
            pen.setWidthF(1.0 + pulse * 0.8 if index == 0 else 1.0)
            pen.setColor(QtGui.QColor(pen.color().red(), pen.color().green(), pen.color().blue(), alpha))
            painter.setPen(pen)
            painter.setBrush(QtCore.Qt.NoBrush)
            painter.drawEllipse(orbit)
            angle = (self._phase * 360 + index * 117) * math.pi / 180
            dot = QtCore.QPointF(center.x() + math.cos(angle) * width / 2, center.y() + math.sin(angle) * width * 0.36)
            painter.setPen(QtCore.Qt.NoPen)
            painter.setBrush(QtGui.QColor(color))
            painter.drawEllipse(dot, 3.5 + index, 3.5 + index)

    def _draw_avatar(self, painter, center) -> None:
        if self._draw_live_rig(painter, center):
            return
        active = not self._snapshot.is_empty
        signal_color = "#A7FF6A" if self._snapshot.registered else "#42E8FF"
        color = QtGui.QColor(signal_color if active else "#4A5266")
        glow = QtGui.QColor(color)
        glow.setAlpha(35 if active else 16)
        painter.setPen(QtCore.Qt.NoPen)
        painter.setBrush(glow)
        painter.drawEllipse(center, 105, 175)
        painter.setBrush(QtCore.Qt.NoBrush)
        pen = QtGui.QPen(color, 2.1 if active else 1.2)
        painter.setPen(pen)
        points = {
            "head": QtCore.QPointF(center.x(), center.y() - 125),
            "neck": QtCore.QPointF(center.x(), center.y() - 91),
            "chest": QtCore.QPointF(center.x(), center.y() - 45),
            "hips": QtCore.QPointF(center.x(), center.y() + 35),
            "lh": QtCore.QPointF(center.x() - 88, center.y() + 10),
            "rh": QtCore.QPointF(center.x() + 88, center.y() + 10),
            "lf": QtCore.QPointF(center.x() - 46, center.y() + 145),
            "rf": QtCore.QPointF(center.x() + 46, center.y() + 145),
        }
        painter.drawEllipse(points["head"], 18, 22)
        for a, b in (("neck", "chest"), ("chest", "hips"), ("chest", "lh"), ("chest", "rh"), ("hips", "lf"), ("hips", "rf")):
            painter.drawLine(points[a], points[b])
        painter.drawLine(points["head"] + QtCore.QPointF(0, 22), points["neck"])
        for point in points.values():
            painter.setBrush(color)
            painter.setPen(QtCore.Qt.NoPen)
            painter.drawEllipse(point, 3.0, 3.0)

    def _draw_live_rig(self, painter, center) -> bool:
        all_nodes = self._snapshot.rig_nodes
        nodes = focus_rig_nodes(all_nodes, self._health, self._focused_module) if self._focused_module else all_nodes
        projected_nodes = project_rig_nodes(nodes, (center.x(), center.y()), (285.0, 305.0))
        self._projected_nodes = projected_nodes
        if not projected_nodes:
            return False
        screen = {node.path: QtCore.QPointF(node.x, node.y) for node in projected_nodes}
        projected_by_path = {node.path: node for node in projected_nodes}

        line_color = QtGui.QColor("#78FF9D" if self._snapshot.registered else "#42E8FF")
        line_color.setAlpha(155)
        painter.setPen(QtGui.QPen(line_color, 1.35))
        painter.setBrush(QtCore.Qt.NoBrush)
        for source in nodes:
            if source.parent_path in screen:
                painter.drawLine(screen[source.parent_path], screen[source.path])

        pulse = (math.sin(self._phase * math.tau) + 1.0) * 0.5
        side_colors = {"left": "#42E8FF", "right": "#FF5C7C", "center": "#A7FF6A" if self._snapshot.registered else "#D8E6FF"}
        focused_paths = set()
        if self._focused_module:
            module = self._health.module(self._focused_module)
            focused_paths = set(module.node_paths if module else ())
        for node in projected_nodes:
            point = screen[node.path]
            hovered = node.path == self._hovered_path
            color = QtGui.QColor("#FFFFFF" if hovered else ("#FFDB69" if node.selected else side_colors[node.side]))
            if focused_paths and node.path not in focused_paths and not hovered and not node.selected:
                color.setAlpha(70)
            if node.selected or hovered:
                halo = QtGui.QColor(color)
                halo.setAlpha(70 if hovered else 45)
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(halo)
                base_halo = 13 if hovered else 10
                painter.drawEllipse(point, base_halo + pulse * 4, base_halo + pulse * 4)
            radius = 5.0 if hovered else (4.4 if node.selected else (3.2 if node.kind == "joint" else 4.0))
            if node.kind == "control":
                painter.setPen(QtGui.QPen(color, 1.5))
                painter.setBrush(QtCore.Qt.NoBrush)
                painter.drawEllipse(point, radius + 2.0, radius + 2.0)
            else:
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(color)
                painter.drawEllipse(point, radius, radius)
        if self._hovered_path in projected_by_path:
            self._draw_node_hud(painter, projected_by_path[self._hovered_path])
        return True

    def _draw_module_spectrum(self, painter, rect) -> None:
        modules = self._health.modules
        self._module_regions = ()
        if not modules:
            return
        gap = 5.0
        width = min(67.0, (rect.width() - 24.0 - gap * (len(modules) - 1)) / len(modules))
        total = width * len(modules) + gap * (len(modules) - 1)
        x = (rect.width() - total) * 0.5
        regions = []
        state_colors = {"healthy": "#A7FF6A", "watch": "#42E8FF", "risk": "#FFB15C"}
        for module in modules:
            cell = QtCore.QRectF(x, 51.0, width, 22.0)
            regions.append((module.key, cell))
            active = module.key == self._focused_module
            hovered = module.key == self._hovered_module
            color = QtGui.QColor(state_colors[module.state])
            painter.setBrush(QtGui.QColor("#222B3A" if active or hovered else "#111722"))
            painter.setPen(QtGui.QPen(color if active or hovered else QtGui.QColor("#30394E"), 1.1))
            painter.drawRoundedRect(cell, 6, 6)
            painter.setPen(color if active else QtGui.QColor("#AAB5CA"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6, QtGui.QFont.Bold))
            painter.drawText(cell.adjusted(5, 0, -17, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, module.label)
            painter.setPen(color)
            painter.drawText(cell.adjusted(0, 0, -5, 0), QtCore.Qt.AlignVCenter | QtCore.Qt.AlignRight, str(module.score))
            x += width + gap
        self._module_regions = tuple(regions)
        detail_key = self._hovered_module or self._focused_module
        detail = self._health.module(detail_key) if detail_key else None
        if detail:
            finding = detail.findings[0] if detail.findings else "对称与已捕获层级正常"
            painter.setPen(QtGui.QColor("#8791A8"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6))
            painter.drawText(
                QtCore.QRectF(16, 77, rect.width() - 32, 16),
                QtCore.Qt.AlignCenter,
                f"{detail.label} / {len(detail.node_paths)} 个节点 / {finding}",
            )

    def _draw_node_hud(self, painter, node) -> None:
        label = node.name.rsplit(":", 1)[-1]
        font = painter.font()
        font.setPointSize(8)
        font.setBold(True)
        painter.setFont(font)
        metrics = QtGui.QFontMetrics(font)
        width = metrics.horizontalAdvance(label) + 22
        x = min(max(10.0, node.x + 12.0), self.width() - width - 10.0)
        y = min(max(12.0, node.y - 32.0), self.height() - 34.0)
        hud = QtCore.QRectF(x, y, width, 24)
        painter.setPen(QtGui.QPen(QtGui.QColor("#A77CFF"), 1.0))
        painter.setBrush(QtGui.QColor(14, 17, 27, 235))
        painter.drawRoundedRect(hud, 6, 6)
        painter.setPen(QtGui.QColor("#F4F7FF"))
        painter.drawText(hud, QtCore.Qt.AlignCenter, label)

    def _draw_titles(self, painter, rect) -> None:
        painter.setPen(QtGui.QColor("#8791A8"))
        font = painter.font()
        font.setPointSize(8)
        font.setLetterSpacing(QtGui.QFont.AbsoluteSpacing, 2.0)
        painter.setFont(font)
        painter.drawText(QtCore.QRectF(0, 24, rect.width(), 18), QtCore.Qt.AlignCenter, self._snapshot.state_label)
        painter.setPen(QtGui.QColor("#F4F7FF"))
        font.setPointSize(18)
        font.setBold(True)
        font.setLetterSpacing(QtGui.QFont.AbsoluteSpacing, 0.5)
        painter.setFont(font)
        painter.drawText(QtCore.QRectF(20, rect.height() - 76, rect.width() - 40, 30), QtCore.Qt.AlignCenter, self._snapshot.display_name)
        painter.setPen(QtGui.QColor("#42E8FF"))
        font.setPointSize(8)
        font.setBold(False)
        painter.setFont(font)
        identity = f"信号 {self._snapshot.stable_id}" if self._snapshot.stable_id else "从 MAYA 当前选择捕获"
        painter.drawText(QtCore.QRectF(20, rect.height() - 43, rect.width() - 40, 18), QtCore.Qt.AlignCenter, identity)
