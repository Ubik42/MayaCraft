# -*- coding: utf-8 -*-

from MayaCraft.compat.qt import QtWidgets, QtCore
from MayaCraft.core.logic.skinning import skinning_tab_logic as logic


class SkinningTab(QtWidgets.QWidget):
    """
    蒙皮功能模块的完整UI布局。(不依赖自定义控件的版本)
    """

    def __init__(self, parent=None):
        super().__init__(parent)

        # --- 主布局 ---
        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setAlignment(QtCore.Qt.AlignTop)

        # --- 1. 权重导入/导出部分 ---
        io_group = self._create_weight_io_ui()
        main_layout.addWidget(io_group)

        # --- 2. 权重工具集部分 ---
        utils_group = self._create_weight_utils_ui()
        main_layout.addWidget(utils_group)

        # --- 3. 变形器工具 (占位) ---
        deformer_group = self._create_deformer_tools_ui()
        main_layout.addWidget(deformer_group)

        # --- 连接所有信号 ---
        self.connect_signals()

    # ---------------------------------------------------------------------------
    # UI 创建 (分块)
    # ---------------------------------------------------------------------------
    def _create_weight_io_ui(self):
        """创建权重导入/导出UI"""
        group = QtWidgets.QGroupBox("1. 权重导入与导出")
        layout = QtWidgets.QVBoxLayout(group)

        # --- 使用标准控件替代 FilePathWidget ---
        path_layout = QtWidgets.QHBoxLayout()
        path_label = QtWidgets.QLabel("权重路径:")
        self.weight_path_line_edit = QtWidgets.QLineEdit()
        self.browse_path_btn = QtWidgets.QPushButton("...")
        self.browse_path_btn.setFixedWidth(30)
        path_layout.addWidget(path_label)
        path_layout.addWidget(self.weight_path_line_edit)
        path_layout.addWidget(self.browse_path_btn)
        # --- 替代结束 ---

        # 导出
        self.export_weights_btn = QtWidgets.QPushButton("导出选中模型权重")

        # 导入
        import_sub_layout = QtWidgets.QHBoxLayout()
        import_options_label = QtWidgets.QLabel("导入模式:")
        self.import_by_position_radio = QtWidgets.QRadioButton("按空间位置")
        self.import_by_index_radio = QtWidgets.QRadioButton("按顶点序号")
        self.import_by_position_radio.setChecked(True)
        self.import_weights_btn = QtWidgets.QPushButton("导入权重到选中模型")

        import_sub_layout.addWidget(import_options_label)
        import_sub_layout.addWidget(self.import_by_position_radio)
        import_sub_layout.addWidget(self.import_by_index_radio)
        import_sub_layout.addStretch()

        layout.addLayout(path_layout)
        layout.addWidget(self.export_weights_btn)
        layout.addLayout(import_sub_layout)
        layout.addWidget(self.import_weights_btn)

        return group

    def _create_weight_utils_ui(self):
        """创建权重工具集UI"""
        group = QtWidgets.QGroupBox("2. 权重工具集")
        layout = QtWidgets.QGridLayout(group)

        self.copy_weights_btn = QtWidgets.QPushButton("复制权重")
        self.paste_weights_btn = QtWidgets.QPushButton("粘贴权重")
        self.mirror_weights_btn = QtWidgets.QPushButton("镜像权重")
        self.smooth_weights_btn = QtWidgets.QPushButton("平滑权重")
        self.prune_weights_btn = QtWidgets.QPushButton("删减小权重值")
        self.remove_unused_btn = QtWidgets.QPushButton("移除未使用骨骼")

        layout.addWidget(self.copy_weights_btn, 0, 0)
        layout.addWidget(self.paste_weights_btn, 0, 1)
        layout.addWidget(self.mirror_weights_btn, 1, 0)
        layout.addWidget(self.smooth_weights_btn, 1, 1)
        layout.addWidget(self.prune_weights_btn, 2, 0)
        layout.addWidget(self.remove_unused_btn, 2, 1)

        return group

    def _create_deformer_tools_ui(self):
        """创建变形器工具UI (占位)"""
        group = QtWidgets.QGroupBox("3. 变形器工具")
        layout = QtWidgets.QVBoxLayout(group)

        self.delta_mush_btn = QtWidgets.QPushButton("添加 Delta Mush")
        self.delta_mush_btn.setEnabled(False)

        layout.addWidget(self.delta_mush_btn)

        return group

    # ---------------------------------------------------------------------------
    # 信号连接
    # ---------------------------------------------------------------------------
    def connect_signals(self):
        """连接所有UI控件的信号到对应的槽函数。"""
        # Weight I/O
        self.browse_path_btn.clicked.connect(self._on_browse_weight_path)  # <-- 连接新的浏览按钮
        self.export_weights_btn.clicked.connect(self._on_export_weights)
        self.import_weights_btn.clicked.connect(self._on_import_weights)

        # Weight Utilities
        self.copy_weights_btn.clicked.connect(self._on_copy_weights)
        self.paste_weights_btn.clicked.connect(self._on_paste_weights)
        self.mirror_weights_btn.clicked.connect(self._on_mirror_weights)
        self.smooth_weights_btn.clicked.connect(self._on_smooth_weights)
        self.prune_weights_btn.clicked.connect(self._on_prune_weights)
        self.remove_unused_btn.clicked.connect(self._on_remove_unused)

    # ---------------------------------------------------------------------------
    # 槽函数 (占位符)
    # ---------------------------------------------------------------------------
    def _on_browse_weight_path(self):
        file_path, _ = QtWidgets.QFileDialog.getSaveFileName(
            self, "选择权重文件路径", "", "JSON Files (*.json)")
        if file_path:
            self.weight_path_line_edit.setText(file_path)  # <-- 更新QLineEdit

    def _on_export_weights(self):
        weight_path = self.weight_path_line_edit.text()  # <-- 从QLineEdit获取路径
        logic.export_weights(weight_path)

    def _on_import_weights(self):
        weight_path = self.weight_path_line_edit.text()  # <-- 从QLineEdit获取路径
        mode = "position" if self.import_by_position_radio.isChecked() else "index"
        logic.import_weights(weight_path)

    def _on_copy_weights(self):
        logic.copy_weights()

    def _on_paste_weights(self):
        logic.paste_weights()

    def _on_mirror_weights(self):
        logic.mirror_weights()

    def _on_smooth_weights(self):
        logic.smooth_weights()

    def _on_prune_weights(self):
        logic.prune_weights()

    def _on_remove_unused(self):
        logic.remove_unused_influences()
