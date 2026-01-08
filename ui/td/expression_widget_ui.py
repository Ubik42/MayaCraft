# -*- coding: utf-8 -*-
from PySide6 import QtWidgets, QtCore
from core.logic.td import expression_widget_logic as logic
from ui.collapsible_widget import CollapsibleWidget


class ExpressionWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("1. 表达式管理 | Expression Manager", parent)
        layout = QtWidgets.QVBoxLayout()
        self._create_content(layout)
        self.set_content_layout(layout)
        self._connect_signals()
        self._on_refresh()

    def _create_content(self, layout):
        tool_layout = QtWidgets.QHBoxLayout()
        self.refresh_btn = QtWidgets.QPushButton("刷新列表")
        self.jump_btn = QtWidgets.QPushButton("打开表达式管理器")
        self.jump_btn.setStyleSheet("background-color: #3d5a6d; height: 25px;")

        tool_layout.addWidget(self.refresh_btn)
        tool_layout.addWidget(self.jump_btn)

        splitter = QtWidgets.QSplitter(QtCore.Qt.Horizontal)
        self.list_widget = QtWidgets.QListWidget()
        self.list_widget.setFixedWidth(180)

        self.code_view = QtWidgets.QTextBrowser()
        self.code_view.setOpenLinks(False)
        self.code_view.setStyleSheet("background-color: #1e1e1e; padding: 10px;")

        splitter.addWidget(self.list_widget)
        splitter.addWidget(self.code_view)

        layout.addLayout(tool_layout)
        layout.addWidget(splitter)

    def _connect_signals(self):
        self.refresh_btn.clicked.connect(self._on_refresh)
        self.jump_btn.clicked.connect(self._on_jump_to_editor)
        self.list_widget.itemClicked.connect(self._on_item_selected)
        self.code_view.anchorClicked.connect(self._on_obj_clicked)

    def _on_refresh(self):
        self.list_widget.clear()
        self.list_widget.addItems(logic.get_all_expressions())

    def _on_item_selected(self, item):
        raw_code = logic.get_expression_code(item.text())
        self.code_view.setHtml(logic.format_code_to_html(raw_code))

    def _on_obj_clicked(self, url):
        # 此时 url 仅包含对象名
        logic.select_obj(url.toString())

    def _on_jump_to_editor(self):
        selected = self.list_widget.selectedItems()
        if selected:
            logic.jump_to_expression_editor(selected[0].text())