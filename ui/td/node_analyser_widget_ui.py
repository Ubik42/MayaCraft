# -*- coding: utf-8 -*-
import maya.cmds as cmds
import base64
from PySide6 import QtWidgets, QtCore, QtGui, QtNetwork
from ui.collapsible_widget import CollapsibleWidget
from core.logic.td.node_analyser_logic import NodeAnalyserLogic


class NodeAnalyserWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("3. 节点分析器 | Node Analyser", parent)
        self.logic = NodeAnalyserLogic()
        self.network_manager = QtNetwork.QNetworkAccessManager(self)
        self.network_manager.finished.connect(self._on_image_downloaded)

        layout = QtWidgets.QVBoxLayout()
        self._create_content(layout)
        self.set_content_layout(layout)

    def _create_content(self, layout):
        # 1. 选项区 (横排)
        opt_layout = QtWidgets.QHBoxLayout()
        opt_layout.setSpacing(15)

        self.chk_smart = QtWidgets.QCheckBox("🌀 智能追踪")
        self.chk_smart.setChecked(True)
        self.chk_smart.setToolTip("递归追踪数学/矩阵节点，直到遇到Transform或Joint")

        self.chk_in = QtWidgets.QCheckBox("Inputs")
        self.chk_in.setChecked(False)

        self.chk_out = QtWidgets.QCheckBox("Outputs")
        self.chk_out.setChecked(True)

        opt_layout.addWidget(self.chk_smart)
        opt_layout.addWidget(self.chk_in)
        opt_layout.addWidget(self.chk_out)
        opt_layout.addStretch()

        layout.addLayout(opt_layout)

        # 2. 结果显示区 (TabWidget)
        self.tabs = QtWidgets.QTabWidget()
        self.tabs.setStyleSheet("""
            QTabWidget::pane { border: 1px solid #444; background-color: #2b2b2b; }
            QTabBar::tab { background: #333; color: #aaa; padding: 5px 10px; }
            QTabBar::tab:selected { background: #444; color: white; border-bottom: 2px solid #5285a6; }
        """)

        # Tab 1: Markdown
        self.txt_md = QtWidgets.QTextEdit()
        self.txt_md.setReadOnly(True)
        self.txt_md.setStyleSheet("background-color: #1e1e1e; color: #d4d4d4; font-family: Consolas;")

        # Tab 2: Mermaid Code
        self.txt_code = QtWidgets.QTextEdit()
        self.txt_code.setReadOnly(True)
        self.txt_code.setStyleSheet("background-color: #1e1e1e; color: #aaddff; font-family: Consolas;")

        # Tab 3: Mermaid Image (Label inside ScrollArea)
        self.scroll_img = QtWidgets.QScrollArea()
        self.scroll_img.setWidgetResizable(True)
        self.lbl_img = QtWidgets.QLabel("点击 '开始分析' 生成预览")
        self.lbl_img.setAlignment(QtCore.Qt.AlignCenter)
        self.lbl_img.setStyleSheet("background-color: #222; color: #666;")
        self.scroll_img.setWidget(self.lbl_img)

        self.tabs.addTab(self.txt_md, "📝 Markdown")
        self.tabs.addTab(self.txt_code, "💻 Mermaid Code")
        self.tabs.addTab(self.scroll_img, "🖼️ Mermaid Image")

        self.tabs.setMinimumHeight(250)
        layout.addWidget(self.tabs)

        # 3. 按钮区
        btn_layout = QtWidgets.QHBoxLayout()

        self.btn_gen = QtWidgets.QPushButton("🚀 开始分析 (Generate)")
        self.btn_gen.setMinimumHeight(30)
        self.btn_gen.setStyleSheet("background-color: #5285a6; color: white; font-weight: bold; border-radius: 4px;")

        self.btn_export = QtWidgets.QPushButton("📋 复制当前页 (Copy)")
        self.btn_export.setMinimumHeight(30)
        self.btn_export.setStyleSheet("background-color: #444; color: white; border-radius: 4px;")

        btn_layout.addWidget(self.btn_gen)
        btn_layout.addWidget(self.btn_export)

        layout.addLayout(btn_layout)

        # 连接信号
        self.btn_gen.clicked.connect(self._on_generate)
        self.btn_export.clicked.connect(self._on_export)
        # 切换Tab时如果当前是图片且没有图片，可以尝试自动刷新（可选，这里保持手动点击生成）

    def _on_generate(self):
        sel = cmds.ls(sl=1, long=True)
        if not sel:
            self.lbl_img.setText("请先选择节点")
            self.txt_md.setText("Please select nodes.")
            return

        # 1. 获取数据
        self.lbl_img.setText("正在分析...")
        QtWidgets.QApplication.processEvents()  # 刷新UI

        nodes = self.logic.get_expanded_selection(sel, smart_trace=self.chk_smart.isChecked())

        # 2. 生成内容
        md_text = self.logic.generate_markdown(nodes, include_trace_info=self.chk_smart.isChecked())
        mm_code = self.logic.generate_mermaid(nodes, show_in=self.chk_in.isChecked(), show_out=self.chk_out.isChecked())

        # 3. 更新UI
        self.txt_md.setText(md_text)
        self.txt_code.setText(mm_code)

        # 4. 处理图片
        self._request_mermaid_image(mm_code)

    def _request_mermaid_image(self, mermaid_code):
        """通过 mermaid.ink API 获取图片"""
        self.lbl_img.setText("正在加载云端预览图...\n(Loading from mermaid.ink)")

        # Base64 编码
        code_bytes = mermaid_code.encode('utf-8')
        base64_bytes = base64.b64encode(code_bytes)
        base64_str = base64_bytes.decode('ascii')

        url = f"https://mermaid.ink/img/{base64_str}"

        # 发送请求
        req = QtNetwork.QNetworkRequest(QtCore.QUrl(url))
        self.network_manager.get(req)

    def _on_image_downloaded(self, reply):
        """图片下载回调"""
        if reply.error() == QtNetwork.QNetworkReply.NoError:
            data = reply.readAll()
            pixmap = QtGui.QPixmap()
            if pixmap.loadFromData(data):
                self.lbl_img.setPixmap(pixmap)
                self.lbl_img.setText("")  # 清除加载文字
            else:
                self.lbl_img.setText("无法解码图片数据")
        else:
            self.lbl_img.setText(f"加载失败 (需要互联网):\n{reply.errorString()}")
        reply.deleteLater()

    def _on_export(self):
        """根据当前Tab复制内容"""
        idx = self.tabs.currentIndex()
        cb = QtWidgets.QApplication.clipboard()

        msg = ""
        if idx == 0:  # Markdown
            cb.setText(self.txt_md.toPlainText())
            msg = "Markdown 文本已复制"
        elif idx == 1:  # Code
            cb.setText(self.txt_code.toPlainText())
            msg = "Mermaid 代码已复制"
        elif idx == 2:  # Image
            pixmap = self.lbl_img.pixmap()
            if pixmap and not pixmap.isNull():
                cb.setPixmap(pixmap)
                msg = "图片已复制到剪贴板"
            else:
                msg = "当前没有可复制的图片"

        cmds.inViewMessage(amg=f'<span style=\"color: #00FF00;\">{msg}</span>', pos='midCenter', fade=True)