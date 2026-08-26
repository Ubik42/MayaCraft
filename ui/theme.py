"""MayaCraft's kinetic holographic visual language."""

from pathlib import Path

from MayaCraft.compat.qt import QtGui, QtWidgets


UI_FONT_FAMILY = "Microsoft YaHei UI"
_FONT_READY = False


def ensure_ui_font() -> str:
    """Register a CJK-capable UI font for Maya and headless mayapy alike."""
    global _FONT_READY, UI_FONT_FAMILY
    if _FONT_READY:
        return UI_FONT_FAMILY
    # QFontDatabase can hard-crash Qt 6 when a module is imported before the
    # host (or a mayapy test) has created QApplication. Defer registration;
    # stylesheet() will call us again once the UI actually exists.
    if QtWidgets.QApplication.instance() is None:
        return UI_FONT_FAMILY
    candidates = (
        Path("C:/Windows/Fonts/msyh.ttc"),
        Path("C:/Windows/Fonts/msyhl.ttc"),
        Path("C:/Windows/Fonts/simhei.ttf"),
    )
    for path in candidates:
        if not path.is_file():
            continue
        font_id = QtGui.QFontDatabase.addApplicationFont(str(path))
        families = QtGui.QFontDatabase.applicationFontFamilies(font_id) if font_id >= 0 else ()
        if families:
            UI_FONT_FAMILY = families[0]
            break
    _FONT_READY = True
    return UI_FONT_FAMILY

COLORS = {
    "void": "#07080D",
    "panel": "#10131C",
    "panel_soft": "#171B27",
    "line": "#2A3142",
    "text": "#F4F7FF",
    "muted": "#8791A8",
    "cyan": "#42E8FF",
    "violet": "#9D6CFF",
    "coral": "#FF5C7C",
    "lime": "#A7FF6A",
}


def stylesheet() -> str:
    family = ensure_ui_font()
    return """
    QWidget#MayaCraftMainWindow { background: #07080D; color: #F4F7FF; font-family: "__FONT__"; }
    QLabel { color: #F4F7FF; background: transparent; }
    QLabel[muted="true"] { color: #8791A8; }
    QFrame#TopBar, QFrame#Inspector, QFrame#StatusStrip { background: #10131C; border: 1px solid #242B3A; }
    QFrame#Inspector { border-radius: 14px; }
    QScrollArea#InspectorScroll { background: transparent; border: 0; }
    QScrollArea#InspectorScroll > QWidget > QWidget { background: transparent; }
    QScrollBar:vertical { width: 7px; background: #0D1018; margin: 4px 0; }
    QScrollBar::handle:vertical { min-height: 28px; background: #39445B; border-radius: 3px; }
    QScrollBar::add-line:vertical, QScrollBar::sub-line:vertical { height: 0; }
    QPushButton { min-height: 34px; padding: 0 14px; color: #DCE5FA; background: #171B27; border: 1px solid #30394E; border-radius: 8px; font-weight: 600; }
    QPushButton:hover { color: white; border-color: #42E8FF; background: #1C2432; }
    QPushButton:focus { border: 2px solid #F4F7FF; }
    QPushButton:pressed { background: #242C40; padding-top: 2px; }
    QPushButton:disabled { color: #596176; border-color: #252B39; background: #10131A; }
    QPushButton#RegisterButton { min-height: 39px; color: #F8F4FF; background: #6F45D9; border: 1px solid #A77CFF; border-radius: 9px; font-weight: 800; }
    QPushButton#RegisterButton:hover { background: #895CF0; border-color: #C5A9FF; }
    QPushButton#CaptureSecondaryButton { min-height: 38px; color: #071015; background: #42E8FF; border: 0; border-radius: 9px; font-weight: 800; }
    QPushButton#CaptureSecondaryButton:hover { background: #8AF2FF; }
    QPushButton#PinCharacterButton { min-width: 58px; min-height: 28px; padding: 0 9px; color: #9D6CFF; background: #151A25; border-color: #3A3154; font-size: 8px; font-weight: 900; }
    QPushButton#PinCharacterButton:hover { color: #F4F7FF; border-color: #9D6CFF; background: #221C35; }
    QPushButton#PinCharacterButton:disabled { color: #A7FF6A; border-color: #3F6542; background: #15221A; }
    QPushButton#MRIScanButton { min-height: 38px; color: #090B12; background: #FF5C7C; border: 0; border-radius: 10px; font-size: 9px; font-weight: 900; }
    QPushButton#MRIScanButton:hover { background: #FF86A0; }
    QFrame#MRIMetric { background: #111722; border: 1px solid #2A3348; border-radius: 9px; }
    QFrame#MRIRepairCapsule { background: #111923; border: 1px solid #315142; border-radius: 9px; }
    QPushButton#MRIApplyButton { color: #08110B; background: #A7FF6A; border: 0; font-size: 8px; font-weight: 900; }
    QFrame#MRIMirrorCapsule { background: #101824; border: 1px solid #28536A; border-radius: 9px; }
    QComboBox#MRIMirrorDirection { min-height: 32px; padding: 0 9px; color: #42E8FF; background: #0B111B; border: 1px solid #2E6178; border-radius: 7px; font-weight: 900; }
    QComboBox#MRIMirrorDirection::drop-down { border: 0; width: 16px; }
    QPushButton#MRIMirrorApply { color: #071015; background: #42E8FF; border: 0; font-size: 8px; font-weight: 900; }
    QPushButton#MotionCaptureButton { min-height: 38px; color: #090B12; background: #42E8FF; border: 0; border-radius: 9px; font-size: 9px; font-weight: 900; }
    QPushButton#MotionCaptureButton:hover { background: #91F4FF; }
    QPushButton#MotionBaselineButton { min-height: 38px; color: #D8C9FF; background: #1A1528; border-color: #614A8F; font-size: 8px; font-weight: 900; }
    QPushButton#MotionBaselineButton:hover { border-color: #9D6CFF; background: #251D3A; }
    QFrame#MotionInstrument { background: #10141E; border-top: 1px solid #2C3448; border-bottom: 1px solid #2C3448; }
    QFrame#MotionAnchorCapsule { background: #111923; border: 1px solid #344E45; border-radius: 8px; }
    QFrame#ContactTuningStrip { background: #0D1720; border: 1px solid #28536A; border-radius: 8px; }
    QComboBox#AxisTemplateCombo { min-height: 28px; min-width: 176px; padding: 0 28px 0 9px; color: #E7DCFF; background: #141126; border: 1px solid #5D4790; border-radius: 6px; font-size: 8px; font-weight: 850; }
    QComboBox#AxisTemplateCombo:hover, QComboBox#AxisTemplateCombo:focus { border-color: #9D6CFF; background: #1C1631; }
    QComboBox#AxisTemplateCombo:disabled { color: #667087; border-color: #2D3140; background: #0D1119; }
    QComboBox#AxisTemplateCombo::drop-down { width: 24px; border: 0; }
    QComboBox#AxisTemplateCombo QAbstractItemView { color: #F4F7FF; background: #121624; border: 1px solid #5D4790; selection-background-color: #36245D; selection-color: #FFFFFF; padding: 5px; outline: 0; }
    QSpinBox#ContactTuningField, QDoubleSpinBox#ContactTuningField { min-height: 28px; padding: 0 7px; color: #BFF8FF; background: #09121A; border: 1px solid #2E6178; border-radius: 6px; font-size: 8px; font-weight: 800; }
    QSpinBox#ContactTuningField:focus, QDoubleSpinBox#ContactTuningField:focus { border: 1px solid #A7FF6A; }
    QSpinBox#ContactTuningField::up-button, QSpinBox#ContactTuningField::down-button, QDoubleSpinBox#ContactTuningField::up-button, QDoubleSpinBox#ContactTuningField::down-button { width: 13px; background: #142432; border: 0; }
    QPushButton#ContactResetButton { min-height: 28px; color: #A7FF6A; border-color: #3F6542; padding: 0 9px; font-size: 8px; }
    QFrame#ClipLibraryPanel { background: #090C15; border: 1px solid #594089; border-radius: 10px; }
    QLabel#ClipLibraryTitle { color: #E7DCFF; font-size: 13px; font-weight: 900; }
    QLineEdit#ClipLibrarySearch { min-height: 30px; color: #F4F7FF; background: #111625; border: 1px solid #35415A; border-radius: 7px; padding: 0 10px; selection-background-color: #6B45AD; }
    QLineEdit#ClipLibrarySearch:focus { border-color: #9D6CFF; }
    QListWidget#ClipLibraryList { color: #DDE7FF; background: #080B12; border: 1px solid #252E42; border-radius: 8px; outline: 0; padding: 4px; font-size: 8px; }
    QListWidget#ClipLibraryList::item { color: #AAB8D0; border: 1px solid transparent; border-bottom-color: #20283A; border-radius: 7px; padding: 5px 8px; }
    QListWidget#ClipLibraryList::item:hover { color: #FFFFFF; background: #13182A; border-color: #4E3B75; }
    QListWidget#ClipLibraryList::item:selected { color: #FFFFFF; background: #251A3D; border-color: #9D6CFF; }
    QFrame#ClipLibraryDetail { background: #0F1720; border: 1px solid #28536A; border-radius: 8px; }
    QPushButton#ClipLibraryLoad { min-height: 32px; color: #07110B; background: #A7FF6A; border: 0; font-weight: 900; }
    QPushButton#ClipLibraryLoad:disabled { color: #616A77; background: #171C25; }
    QPushButton#MotionAnchorApply { color: #08110B; background: #A7FF6A; border: 0; font-size: 8px; font-weight: 900; }
    QFrame#RigGraphInspector { background: #10131C; border: 1px solid #2A3142; border-radius: 14px; }
    QLabel#RigGraphSignal { color: #CFC2FF; background: #171426; border: 1px solid #493B68; border-radius: 9px; padding: 10px; font-size: 8px; font-weight: 800; }
    QLabel#RigGraphDiff { color: #B8C4DC; background: #0C111A; border-left: 2px solid #42E8FF; padding: 10px; font-family: Consolas; font-size: 8px; }
    QPushButton#RigGraphCapture { color: #080A10; background: #9D6CFF; border: 0; font-size: 8px; font-weight: 900; }
    QPushButton#RigGraphCapture:hover { background: #B89AFF; }
    QPushButton#RigGraphApply { color: #071015; background: #42E8FF; border: 0; font-size: 8px; font-weight: 900; }
    QFrame#ChangeCapsule { background: #131A27; border: 1px solid #394863; border-radius: 9px; }
    QPushButton#CapsuleApply { min-height: 30px; color: #071015; background: #A7FF6A; border: 0; font-size: 9px; font-weight: 900; }
    QPushButton#CapsuleCancel { min-height: 30px; padding: 0 9px; font-size: 9px; }
    QPushButton#RailButton { min-width: 42px; max-width: 42px; min-height: 42px; padding: 0; border-radius: 12px; font-size: 15px; }
    QPushButton#RailButton:checked { color: #07080D; background: #9D6CFF; border-color: #BCA0FF; }
    QProgressBar { height: 5px; background: #1C2130; border: 0; border-radius: 2px; }
    QProgressBar::chunk { background: #42E8FF; border-radius: 2px; }
    QTabWidget::pane { border: 1px solid #2A3142; background: #10131C; }
    QTabBar::tab { background: #131722; color: #8791A8; padding: 9px 15px; border: 0; }
    QTabBar::tab:selected { color: #42E8FF; background: #1A2130; }
    QToolTip { color: #F4F7FF; background: #171B27; border: 1px solid #42E8FF; padding: 6px; }
    """.replace("__FONT__", family)
