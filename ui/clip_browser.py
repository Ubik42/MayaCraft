"""Native Chinese Clip asset browser for the MayaCraft retarget workspace."""

from __future__ import annotations

from pathlib import Path

from MayaCraft.compat.qt import QtCore, QtGui, QtWidgets
from MayaCraft.domain.clip_library import filter_clip_library_entries


class ClipLibraryPanel(QtWidgets.QFrame):
    assetActivated = QtCore.Signal(str)
    closed = QtCore.Signal()

    def __init__(self, store, preflight_callback, parent=None):
        super().__init__(parent)
        self._store = store
        self._preflight_callback = preflight_callback
        self._directory = ""
        self._entries = ()
        self._visible_entries = ()
        self._selected_preflight = None
        self.last_scan = None
        self.setObjectName("ClipLibraryPanel")
        self._build_ui()

    def _build_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(13, 10, 13, 10)
        layout.setSpacing(7)
        header = QtWidgets.QHBoxLayout()
        title_box = QtWidgets.QVBoxLayout()
        title_box.setSpacing(1)
        title = QtWidgets.QLabel("Clip 资产舱")
        title.setObjectName("ClipLibraryTitle")
        self.scan_status = QtWidgets.QLabel("选择资产目录后建立可搜索索引")
        self.scan_status.setProperty("muted", True)
        self.scan_status.setStyleSheet("font-size:7px;")
        title_box.addWidget(title)
        title_box.addWidget(self.scan_status)
        header.addLayout(title_box, 1)
        self.folder_button = QtWidgets.QPushButton("选择目录")
        self.folder_button.clicked.connect(self.choose_directory)
        self.refresh_button = QtWidgets.QPushButton("刷新索引")
        self.refresh_button.clicked.connect(self.refresh)
        close_button = QtWidgets.QPushButton("返回映射场")
        close_button.clicked.connect(self.close_panel)
        header.addWidget(self.folder_button)
        header.addWidget(self.refresh_button)
        header.addWidget(close_button)
        layout.addLayout(header)

        search_row = QtWidgets.QHBoxLayout()
        self.search = QtWidgets.QLineEdit()
        self.search.setObjectName("ClipLibrarySearch")
        self.search.setPlaceholderText("搜索 Clip 名称、标签或路径")
        self.search.setClearButtonEnabled(True)
        self.search.textChanged.connect(self._render_entries)
        self.show_invalid = QtWidgets.QCheckBox("显示损坏资产")
        self.show_invalid.setChecked(True)
        self.show_invalid.toggled.connect(self._render_entries)
        search_row.addWidget(self.search, 1)
        search_row.addWidget(self.show_invalid)
        layout.addLayout(search_row)

        body = QtWidgets.QHBoxLayout()
        self.asset_list = QtWidgets.QListWidget()
        self.asset_list.setObjectName("ClipLibraryList")
        self.asset_list.setSelectionMode(QtWidgets.QAbstractItemView.SingleSelection)
        self.asset_list.currentRowChanged.connect(self._select_row)
        self.asset_list.itemDoubleClicked.connect(lambda _item: self.activate_selected())
        body.addWidget(self.asset_list, 3)
        detail = QtWidgets.QFrame()
        detail.setObjectName("ClipLibraryDetail")
        detail_layout = QtWidgets.QVBoxLayout(detail)
        detail_layout.setContentsMargins(10, 8, 10, 8)
        self.detail_title = QtWidgets.QLabel("尚未选择资产")
        self.detail_title.setStyleSheet("font-size:10px;font-weight:900;")
        self.detail_status = QtWidgets.QLabel("选择左侧资产后执行节点、尺度、轴空间与采样规模预检。")
        self.detail_status.setWordWrap(True)
        self.detail_status.setProperty("muted", True)
        self.detail_status.setStyleSheet("font-size:8px;")
        self.load_button = QtWidgets.QPushButton("载入并生成零写入 Ghost")
        self.load_button.setObjectName("ClipLibraryLoad")
        self.load_button.setEnabled(False)
        self.load_button.clicked.connect(self.activate_selected)
        detail_layout.addWidget(self.detail_title)
        detail_layout.addWidget(self.detail_status, 1)
        detail_layout.addWidget(self.load_button)
        body.addWidget(detail, 2)
        layout.addLayout(body, 1)

    def load_directory(self, directory):
        self._directory = str(Path(directory))
        self.scan_status.setText("正在读取资产头、版本与指纹…")
        self.refresh_button.setEnabled(False)
        QtWidgets.QApplication.processEvents()
        try:
            scan = self._store.scan_directory(self._directory)
        except Exception as exc:
            self._entries = ()
            self.scan_status.setText(f"资产索引失败：{type(exc).__name__}: {exc}")
            self._render_entries()
            return None
        finally:
            self.refresh_button.setEnabled(True)
        self._entries = scan.entries
        self.last_scan = scan
        suffix = " / 已达到扫描上限" if scan.truncated else ""
        self.scan_status.setText(
            f"已索引 {scan.scanned_files} 个文件 / {scan.invalid_files} 个损坏 / "
            f"目录 {Path(scan.directory).name}{suffix}"
        )
        self._render_entries()
        return scan

    @property
    def directory(self):
        return self._directory

    def choose_directory(self):
        path = QtWidgets.QFileDialog.getExistingDirectory(
            self, "选择 MayaCraft Clip 资产目录", self._directory
        )
        if path:
            self.load_directory(path)

    def refresh(self):
        if self._directory:
            self.load_directory(self._directory)
        else:
            self.choose_directory()

    def _render_entries(self, _value=None):
        self._visible_entries = filter_clip_library_entries(
            self._entries,
            query=self.search.text(),
            include_invalid=self.show_invalid.isChecked(),
        )
        self.asset_list.clear()
        for entry in self._visible_entries:
            if entry.state == "invalid":
                state = "损坏"
            elif entry.state == "migrated":
                state = "待另存 v2"
            else:
                state = "可预检"
            tags = " · ".join(entry.tags[:3]) or "无标签"
            duration = f"{entry.duration_seconds:.2f} 秒" if entry.duration_seconds else "单帧"
            text = (
                f"{entry.name}\n"
                f"{entry.frame_count} 帧 · {entry.frames_per_second:g} fps · {duration} · "
                f"{entry.coordinate_forward} 前 / {entry.coordinate_up} 上\n"
                f"{tags}  ｜  {state}"
            )
            item = QtWidgets.QListWidgetItem(text)
            if entry.state == "invalid":
                item.setForeground(QtGui.QColor("#FF8FA8"))
                item.setBackground(QtGui.QColor("#24121B"))
            elif entry.state == "migrated":
                item.setForeground(QtGui.QColor("#FFD08A"))
            item.setToolTip(entry.path)
            item.setSizeHint(QtCore.QSize(300, 61))
            self.asset_list.addItem(item)
        if self._visible_entries:
            self.asset_list.setCurrentRow(0)
        else:
            self.detail_title.setText("没有匹配资产")
            self.detail_status.setText("修改搜索条件、显示损坏资产，或选择其他目录。")
            self.load_button.setEnabled(False)

    def _select_row(self, row):
        if not 0 <= row < len(self._visible_entries):
            self.load_button.setEnabled(False)
            return
        entry = self._visible_entries[row]
        self.detail_title.setText(entry.name)
        if entry.state == "invalid":
            self._selected_preflight = None
            self.detail_status.setText("资产损坏 / " + " / ".join(entry.issues[:3]))
            self.load_button.setEnabled(False)
            return
        try:
            preflight = self._preflight_callback(entry.path)
        except Exception as exc:
            self._selected_preflight = None
            self.detail_status.setText(f"预检失败：{type(exc).__name__}: {exc}")
            self.load_button.setEnabled(False)
            return
        self._selected_preflight = preflight
        if preflight.blockers:
            self.detail_status.setText("已阻断 / " + " / ".join(preflight.blockers[:3]))
            self.load_button.setEnabled(False)
        else:
            notes = " / ".join(preflight.issues[:2]) or "节点、尺度、轴空间与采样规模全部匹配"
            self.detail_status.setText(
                f"预检通过 / {preflight.frame_samples} 个节点帧 / "
                f"尺度 {preflight.scale_ratio:.3f}× / {notes}"
            )
            self.load_button.setEnabled(True)

    def select_path(self, path):
        wanted = str(Path(path).resolve()).casefold()
        for index, entry in enumerate(self._visible_entries):
            if str(Path(entry.path).resolve()).casefold() == wanted:
                self.asset_list.setCurrentRow(index)
                return True
        return False

    def activate_selected(self):
        row = self.asset_list.currentRow()
        if not self.load_button.isEnabled() or not 0 <= row < len(self._visible_entries):
            return
        self.assetActivated.emit(self._visible_entries[row].path)

    def close_panel(self):
        self.closed.emit()


__all__ = ["ClipLibraryPanel"]
