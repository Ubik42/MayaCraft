"""Animated multi-character navigator for the MayaCraft top bar."""

from __future__ import annotations

import math

from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.session import CharacterSession
from MayaCraft.ui.theme import ensure_ui_font

UI_FONT_FAMILY = ensure_ui_font()


class CharacterOrbit(QtWidgets.QWidget):
    characterActivated = QtCore.Signal(str)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._session = CharacterSession()
        self._hovered_id = ""
        self._phase = 0.0
        self._hit_regions = []
        self.setMouseTracking(True)
        self.setMinimumSize(120, 38)
        self.setMaximumHeight(44)
        self.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Fixed)
        self.setToolTip("在已关联或已固定的角色之间切换")
        self._timer = QtCore.QTimer(self)
        self._timer.setInterval(32)
        self._timer.timeout.connect(self._advance)
        self._timer.start()

    def set_session(self, session: CharacterSession) -> None:
        self._session = session
        self.update()

    def hit_point(self, stable_id: str):
        for item_id, rect in self._hit_regions:
            if item_id == stable_id:
                return rect.center().toPoint()
        return None

    def _advance(self):
        self._phase = (self._phase + 0.075) % (math.pi * 2.0)
        if self._session.characters:
            self.update()

    def _position(self, event):
        return event.position() if hasattr(event, "position") else event.localPos()

    def mouseMoveEvent(self, event):
        point = self._position(event)
        hovered = next((item_id for item_id, rect in self._hit_regions if rect.contains(point)), "")
        if hovered != self._hovered_id:
            self._hovered_id = hovered
            self.setCursor(QtCore.Qt.PointingHandCursor if hovered else QtCore.Qt.ArrowCursor)
            self.update()
        super().mouseMoveEvent(event)

    def leaveEvent(self, event):
        self._hovered_id = ""
        self.setCursor(QtCore.Qt.ArrowCursor)
        self.update()
        super().leaveEvent(event)

    def mousePressEvent(self, event):
        if event.button() == QtCore.Qt.LeftButton:
            point = self._position(event)
            item_id = next((item_id for item_id, rect in self._hit_regions if rect.contains(point)), "")
            if item_id:
                self.characterActivated.emit(item_id)
                event.accept()
                return
        super().mousePressEvent(event)

    def paintEvent(self, _event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        self._hit_regions = []
        characters = self._session.characters[:5]
        if not characters:
            painter.setPen(QtGui.QColor("#586277"))
            painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 7, QtGui.QFont.DemiBold))
            painter.drawText(self.rect(), QtCore.Qt.AlignCenter, "没有角色信号")
            return

        gap = 6.0
        duplicate_names = {
            item.display_name.casefold()
            for item in characters
            if sum(other.display_name.casefold() == item.display_name.casefold() for other in characters) > 1
        }
        available = max(60.0, float(self.width()) - gap * (len(characters) - 1))
        cell_width = min(118.0, available / len(characters))
        total = cell_width * len(characters) + gap * (len(characters) - 1)
        x = max(0.0, (self.width() - total) * 0.5)
        for index, item in enumerate(characters):
            rect = QtCore.QRectF(x, 4.0, cell_width, max(28.0, self.height() - 8.0))
            self._hit_regions.append((item.stable_id, rect))
            active = item.stable_id == self._session.active_id
            hovered = item.stable_id == self._hovered_id
            accent = QtGui.QColor("#A7FF6A" if active else "#42E8FF" if item.registered else "#9D6CFF")
            fill = QtGui.QColor("#1B2430" if active else "#151A25")
            if hovered:
                fill = QtGui.QColor("#222C3D")
            painter.setBrush(fill)
            pen = QtGui.QPen(accent if active or hovered else QtGui.QColor("#30394E"))
            pen.setWidthF(1.2 if active or hovered else 0.8)
            painter.setPen(pen)
            painter.drawRoundedRect(rect, 9.0, 9.0)

            pulse = 2.0 + (math.sin(self._phase + index * 0.7) + 1.0) * 1.2 if active else 2.2
            center = QtCore.QPointF(rect.left() + 13.0, rect.center().y())
            if active:
                glow = QtGui.QColor(accent)
                glow.setAlpha(42)
                painter.setPen(QtCore.Qt.NoPen)
                painter.setBrush(glow)
                painter.drawEllipse(center, pulse + 4.0, pulse + 4.0)
            painter.setBrush(accent)
            painter.setPen(QtCore.Qt.NoPen)
            painter.drawEllipse(center, pulse, pulse)

            font = QtGui.QFont(UI_FONT_FAMILY, 8, QtGui.QFont.Bold)
            painter.setFont(font)
            painter.setPen(QtGui.QColor("#F4F7FF" if active or hovered else "#B3BDD2"))
            text_rect = rect.adjusted(24.0, 1.0, -7.0, -1.0)
            label = item.display_name.upper()
            if item.display_name.casefold() in duplicate_names:
                label = f"{item.namespace.upper()} · {label}"
            text = QtGui.QFontMetrics(font).elidedText(label, QtCore.Qt.ElideRight, int(text_rect.width()))
            painter.drawText(text_rect, QtCore.Qt.AlignVCenter | QtCore.Qt.AlignLeft, text)

            if item.pinned:
                painter.setPen(accent)
                painter.setFont(QtGui.QFont(UI_FONT_FAMILY, 6, QtGui.QFont.Bold))
                painter.drawText(rect.adjusted(0, 0, -5, -2), QtCore.Qt.AlignRight | QtCore.Qt.AlignBottom, "◆")
            x += cell_width + gap
