"""Qt surface for MayaCraft's single supported host: Maya 2025 / PySide6."""

from __future__ import annotations

from PySide6 import QtCore, QtGui, QtWidgets
from shiboken6 import wrapInstance as wrap_instance

QT_API = "PySide6"


Qt = QtCore.Qt
QWidget = QtWidgets.QWidget
QVBoxLayout = QtWidgets.QVBoxLayout
QHBoxLayout = QtWidgets.QHBoxLayout
QPushButton = QtWidgets.QPushButton
QLineEdit = QtWidgets.QLineEdit
QListWidget = QtWidgets.QListWidget
QGroupBox = QtWidgets.QGroupBox
QComboBox = QtWidgets.QComboBox
QSlider = QtWidgets.QSlider
QLabel = QtWidgets.QLabel
QCheckBox = QtWidgets.QCheckBox
QFormLayout = QtWidgets.QFormLayout
QListWidgetItem = QtWidgets.QListWidgetItem

__all__ = [
    "QT_API",
    "Qt",
    "QtCore",
    "QtGui",
    "QtWidgets",
    "wrap_instance",
]
