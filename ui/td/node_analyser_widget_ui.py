# -*- coding: utf-8 -*-
import maya.cmds as cmds
import os
from PySide6 import QtWidgets, QtCore, QtGui
from ui.collapsible_widget import CollapsibleWidget
from core.logic.td.node_analyser_logic import NodeAnalyserLogic


# =========================================================================
# Graphics View (Modified for Image Display)
# =========================================================================
class NodeGraphView(QtWidgets.QGraphicsView):
    """
    修改后的视图，不再手动绘制节点，而是直接显示 mmdc 生成的图片。
    保留了缩放和拖拽功能。
    """

    def __init__(self, parent=None):
        super().__init__(parent)
        self.scene = QtWidgets.QGraphicsScene(self)
        self.setScene(self.scene)
        self.setBackgroundBrush(QtGui.QColor("#1e1e1e"))

        # 交互设置
        self.setRenderHints(QtGui.QPainter.Antialiasing | QtGui.QPainter.SmoothPixmapTransform)
        self.setDragMode(QtWidgets.QGraphicsView.ScrollHandDrag)
        self.setTransformationAnchor(QtWidgets.QGraphicsView.AnchorUnderMouse)
        self.setResizeAnchor(QtWidgets.QGraphicsView.AnchorUnderMouse)
        self.setVerticalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.setFrameShape(QtWidgets.QFrame.NoFrame)

        self._current_pixmap_item = None

    def wheelEvent(self, event):
        factor = 1.15
        if event.angleDelta().y() > 0:
            self.scale(factor, factor)
        else:
            self.scale(1 / factor, 1 / factor)

    def display_image(self, image_path):
        """
        加载并显示 mmdc 生成的图片
        """
        self.scene.clear()
        self._current_pixmap_item = None

        if not image_path or not os.path.exists(image_path):
            # 如果没有图片，显示提示文本
            text = self.scene.addText("No Graph Generated", QtGui.QFont("Segoe UI", 12))
            text.setDefaultTextColor(QtGui.QColor("#666"))
            return

        # 加载图片
        pixmap = QtGui.QPixmap(image_path)
        self._current_pixmap_item = self.scene.addPixmap(pixmap)

        # 自动聚焦
        self.scene.setSceneRect(self.scene.itemsBoundingRect())
        QtCore.QTimer.singleShot(0, lambda: self.fitInView(self.scene.sceneRect(), QtCore.Qt.KeepAspectRatio))
        # 稍微缩小一点，留出边距
        self.scale(0.95, 0.95)


# =========================================================================
# Main Widget
# =========================================================================
class NodeAnalyserWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("3. 节点分析器 | Node Analyser", parent)
        self.logic = NodeAnalyserLogic()

        layout = QtWidgets.QVBoxLayout()
        self._create_content(layout)
        self.set_content_layout(layout)

    def _create_content(self, layout):
        # Options
        opt_layout = QtWidgets.QHBoxLayout()
        self.chk_smart = QtWidgets.QCheckBox("🌀 智能追踪")
        self.chk_smart.setChecked(True)
        self.chk_in = QtWidgets.QCheckBox("Inputs")
        self.chk_in.setChecked(False)
        self.chk_out = QtWidgets.QCheckBox("Outputs")
        self.chk_out.setChecked(True)
        opt_layout.addWidget(self.chk_smart)
        opt_layout.addWidget(self.chk_in)
        opt_layout.addWidget(self.chk_out)
        opt_layout.addStretch()
        layout.addLayout(opt_layout)

        # Tabs (Layout Unchanged)
        self.tabs = QtWidgets.QTabWidget()
        self.tabs.setStyleSheet("""
            QTabWidget::pane { border: 1px solid #444; background-color: #1e1e1e; }
            QTabBar::tab { background: #333; color: #aaa; padding: 5px 10px; }
            QTabBar::tab:selected { background: #444; color: white; border-bottom: 2px solid #5285a6; }
        """)

        self.txt_md = QtWidgets.QTextEdit()
        self.txt_md.setReadOnly(True)
        self.txt_md.setStyleSheet("background-color: #1e1e1e; color: #d4d4d4; font-family: Consolas; font-size: 11px;")

        self.txt_mm = QtWidgets.QTextEdit()
        self.txt_mm.setReadOnly(True)
        self.txt_mm.setStyleSheet("background-color: #1e1e1e; color: #aaddff; font-family: Consolas; font-size: 11px;")

        # 将原来的 Native Graph View 替换为 图片查看模式的 View
        self.graph_view = NodeGraphView()

        self.tabs.addTab(self.txt_md, "📝 Markdown")
        self.tabs.addTab(self.txt_mm, "💻 Mermaid")
        self.tabs.addTab(self.graph_view, "📊 Node Graph (MMDC)")
        self.tabs.setCurrentIndex(2)
        self.tabs.setMinimumHeight(400)
        layout.addWidget(self.tabs)

        # Buttons
        btn_layout = QtWidgets.QHBoxLayout()
        self.btn_gen = QtWidgets.QPushButton("🚀 开始分析 (Generate)")
        self.btn_gen.setStyleSheet("background-color: #5285a6; color: white; padding: 6px; font-weight: bold;")
        self.btn_export = QtWidgets.QPushButton("📋 复制/截图 (Export)")
        self.btn_export.setStyleSheet("background-color: #444; color: white; padding: 6px;")

        btn_layout.addWidget(self.btn_gen)
        btn_layout.addWidget(self.btn_export)
        layout.addLayout(btn_layout)

        self.btn_gen.clicked.connect(self._on_generate)
        self.btn_export.clicked.connect(self._on_export)

    def _on_generate(self):
        sel = cmds.ls(sl=1, long=True)
        if not sel:
            self.txt_md.setText("Select nodes first.")
            return

        # 1. 基础数据准备 (所有模式都需要)
        nodes = self.logic.get_expanded_selection(sel, smart_trace=self.chk_smart.isChecked())

        # 2. 获取当前 Tab 索引 (0: Markdown, 1: Mermaid Code, 2: Graph Image)
        current_idx = self.tabs.currentIndex()

        # 3. 按需生成 (只执行当前 Tab 对应的逻辑)
        if current_idx == 0:
            # --- Markdown 模式 ---
            md_text = self.logic.generate_markdown(nodes, self.chk_smart.isChecked())
            self.txt_md.setText(md_text)
            print("Generated Markdown only.")

        elif current_idx == 1:
            # --- Mermaid Text 模式 ---
            mm_text = self.logic.generate_mermaid(nodes, self.chk_in.isChecked(), self.chk_out.isChecked())
            self.txt_mm.setText(mm_text)
            print("Generated Mermaid Text only.")

        elif current_idx == 2:
            # --- Graph Image 模式 ---
            # 图形模式需要先生成 Mermaid 文本，再渲染
            mm_text = self.logic.generate_mermaid(nodes, self.chk_in.isChecked(), self.chk_out.isChecked())
            # 同时更新一下 Mermaid 文本框(可选)，方便用户切回去看
            self.txt_mm.setText(mm_text)

            try:
                # 调用耗时的渲染过程
                image_path = self.logic.render_mermaid_to_image(mm_text)
                self.graph_view.display_image(image_path)
                print(f"Generated Graph Image only: {image_path}")
            except Exception as e:
                cmds.warning(f"Render Failed: {e}")

    def _on_export(self):
        idx = self.tabs.currentIndex()
        cb = QtWidgets.QApplication.clipboard()
        msg = ""

        if idx == 0:
            cb.setText(self.txt_md.toPlainText())
            msg = "Markdown Copied"
        elif idx == 1:
            cb.setText(self.txt_mm.toPlainText())
            msg = "Mermaid Code Copied"
        elif idx == 2:
            # 针对图片的复制逻辑
            scene = self.graph_view.scene
            if scene.items():
                rect = scene.itemsBoundingRect()
                image = QtGui.QImage(rect.size().toSize(), QtGui.QImage.Format_ARGB32)
                image.fill(QtGui.QColor("#1e1e1e"))
                painter = QtGui.QPainter(image)
                painter.setRenderHint(QtGui.QPainter.Antialiasing)
                scene.render(painter, QtCore.QRectF(image.rect()), rect)
                painter.end()
                cb.setImage(image)
                msg = "Graph Image Copied"
            else:
                msg = "No Graph to Copy"

        if msg:
            cmds.inViewMessage(amg=f'<span style=\"color: #00FF00;\">{msg}</span>', pos='midCenter', fade=True)