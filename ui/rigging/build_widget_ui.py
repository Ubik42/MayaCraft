# ui/rigging/build_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore, QtGui
from maya import cmds

# 导入后端逻辑
from core.logic.rigging import build_widget_logic as logic
from core.rigging import build
from ui.collapsible_widget import CollapsibleWidget

# --- 配置定义 ---
MODULE_SLOTS = {
    "IK Arm": ["Hand", "Shoulder"],
    "IK Spine": ["Root", "Chest", "Mid"],
    "IK Leg": ["Hip", "Foot", "LegAim"],
    "Foot Roll": ["Heel", "Toes", "ToesEnd"],
    "Foot Rock": ["BigToe", "PinkyToe"],
    "Spline Chain": ["Start", "End", "Mid_01", "Mid_02"]
}

ATTR_LIST = [
    "twist", "bendy", "global", "aim", "ikLocal", "ikFollow",
    "worldOrient", "flipOrient", "noSkin", "noControl", "inbetween",
    "segScaleComp", "rollingBall", "freeOrient", "hipSwinger",
    "geoAttach", "proximityPin", "rootOptions", "curveGuide", "cog",
    "childOfPart", "control", "footPivots"
]


class SlotButton(QtWidgets.QPushButton):
    """自定义插槽按钮"""

    def __init__(self, label_name, is_attribute=False, parent=None):
        super().__init__(parent)
        self.label_name = label_name
        self.is_attribute = is_attribute
        self.assigned_node = None

        self.setSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Preferred)
        self.setMinimumHeight(30)
        self.setCursor(QtCore.Qt.PointingHandCursor)

        # 基础样式
        self.base_style = """
            border-radius: 4px;
            font-weight: bold;
            text-align: left; 
            padding-left: 10px;
        """
        self.is_active = False
        self.update_appearance()

    def update_appearance(self):
        # 1. 文字显示
        if self.is_attribute:
            # 属性：只显示填入的对象名
            if self.assigned_node:
                short_name = self.assigned_node.split('|')[-1]
                self.setText(f"{short_name}")
            else:
                self.setText("")
        else:
            # 骨骼：显示 "Label: BoneName"
            if self.assigned_node:
                short_name = self.assigned_node.split('|')[-1]
                self.setText(f"{self.label_name}:  {short_name}")
            else:
                self.setText(f"{self.label_name}")

        # 2. 颜色样式
        color_empty_bg = "#454545"
        color_filled_bg = "#2E7D32"
        color_active_border = "#4FC3F7"

        style_sheet = "QPushButton {" + self.base_style

        if self.assigned_node:
            style_sheet += f"background-color: {color_filled_bg}; color: #FFF;"
            style_sheet += "border: 1px solid #4CAF50;"
        else:
            style_sheet += f"background-color: {color_empty_bg}; color: #AAA;"
            style_sheet += "border: 1px solid #555;"

        if self.is_active:
            style_sheet += f"border: 2px solid {color_active_border};"

        style_sheet += "} QPushButton:hover { background-color: #505050; }"
        if self.assigned_node:
            style_sheet += "QPushButton:hover { background-color: #388E3C; }"

        self.setStyleSheet(style_sheet)
        self.style().unpolish(self)
        self.style().polish(self)

    def set_active(self, active):
        self.is_active = active
        self.update_appearance()

    def set_node(self, node_name):
        self.assigned_node = node_name
        self.update_appearance()


class BuildWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("2. 骨骼与模块 | Joints & Modules", parent)
        self.current_active_slot = None

        main_layout = QtWidgets.QVBoxLayout()
        main_layout.setSpacing(8)
        self._create_content(main_layout)
        self.set_content_layout(main_layout)

        QtCore.QTimer.singleShot(200, self._sync_from_scene)

    def _create_content(self, layout):
        # 1. 操作按钮组
        action_layout = QtWidgets.QHBoxLayout()

        self.btn_assign = QtWidgets.QPushButton("填入 (Assign)")
        self.btn_assign.setMinimumHeight(30)
        self.btn_assign.setStyleSheet("background-color: #4CAF50; font-weight: bold; color: white;")

        self.btn_clear = QtWidgets.QPushButton("清空 (Clear)")
        self.btn_clear.setMinimumHeight(30)
        self.btn_clear.setStyleSheet("background-color: #EF5350; font-weight: bold; color: white;")

        # [新增] 刷新按钮
        self.btn_refresh = QtWidgets.QPushButton("刷新检测 (Refresh)")
        self.btn_refresh.setMinimumHeight(30)
        self.btn_refresh.setStyleSheet("background-color: #42A5F5; font-weight: bold; color: white;")

        action_layout.addWidget(self.btn_assign)
        action_layout.addWidget(self.btn_clear)
        action_layout.addWidget(self.btn_refresh)  # 添加到布局

        layout.addLayout(action_layout)

        # 2. 骨骼标签
        layout.addWidget(QtWidgets.QLabel("<b>骨骼标签配置 (Joint Labels)</b>"))
        self.label_tree = self._create_tree_widget()
        self._init_groups_generic(self.label_tree, MODULE_SLOTS, is_attribute=False)
        layout.addWidget(self.label_tree)

        # 3. 属性配置
        layout.addWidget(QtWidgets.QLabel("<b>属性配置 (Attributes)</b>"))
        attr_container = QtWidgets.QWidget()
        attr_layout = QtWidgets.QHBoxLayout(attr_container)
        attr_layout.setContentsMargins(0, 0, 0, 0)

        self.attr_tree_left = self._create_tree_widget()
        self.attr_tree_right = self._create_tree_widget()

        mid_index = (len(ATTR_LIST) + 1) // 2
        left_dict = {attr: [attr] for attr in ATTR_LIST[:mid_index]}
        right_dict = {attr: [attr] for attr in ATTR_LIST[mid_index:]}

        self._init_groups_generic(self.attr_tree_left, left_dict, is_attribute=True)
        self._init_groups_generic(self.attr_tree_right, right_dict, is_attribute=True)

        attr_layout.addWidget(self.attr_tree_left)
        attr_layout.addWidget(self.attr_tree_right)
        layout.addWidget(attr_container)

        # 4. 底部按钮
        self.run_build_btn = QtWidgets.QPushButton("运行构建 (RUN BUILD)")
        self.run_build_btn.setMinimumHeight(45)
        self.run_build_btn.setStyleSheet("""
            QPushButton { background-color: #5D4037; font-weight: bold; font-size: 14px; margin-top: 10px;}
            QPushButton:hover { background-color: #6D4C41; }
        """)
        layout.addWidget(self.run_build_btn)

        # 信号连接
        self.btn_assign.clicked.connect(self._on_assign_clicked)
        self.btn_clear.clicked.connect(self._on_clear_clicked)
        self.btn_refresh.clicked.connect(self._sync_from_scene)  # [新增] 连接刷新信号
        self.run_build_btn.clicked.connect(self._on_run_build)

    def _create_tree_widget(self):
        tree = QtWidgets.QTreeWidget()
        tree.setHeaderHidden(True)
        tree.setIndentation(15)
        tree.setMinimumHeight(250)
        tree.setSelectionMode(QtWidgets.QAbstractItemView.NoSelection)
        tree.setVerticalScrollMode(QtWidgets.QAbstractItemView.ScrollPerPixel)
        return tree

    def _init_groups_generic(self, tree_widget, data_dict, is_attribute):
        tree_widget.clear()
        for group_name, slots in data_dict.items():
            group_item = QtWidgets.QTreeWidgetItem(tree_widget)

            header_widget = QtWidgets.QWidget()
            header_layout = QtWidgets.QHBoxLayout(header_widget)
            header_layout.setContentsMargins(5, 5, 5, 5)
            lbl = QtWidgets.QLabel(group_name)
            lbl.setStyleSheet("font-weight: bold; color: #BBB;")
            add_btn = QtWidgets.QPushButton("+")
            add_btn.setFixedSize(24, 24)
            add_btn.setStyleSheet("QPushButton{ border: 1px solid #666; border-radius: 12px; background: #333; }")

            header_layout.addWidget(lbl)
            header_layout.addStretch()
            header_layout.addWidget(add_btn)
            tree_widget.setItemWidget(group_item, 0, header_widget)
            group_item.setExpanded(True)

            group_item.setData(0, QtCore.Qt.UserRole, {
                "name": group_name,
                "slots": slots,
                "is_attr": is_attribute
            })

            add_btn.clicked.connect(lambda checked=False, p=group_item, s=slots, t=tree_widget, attr=is_attribute:
                                    self._add_row(t, p, s, attr))

    def _add_row(self, tree_widget, parent_item, slot_names, is_attribute):
        row_item = QtWidgets.QTreeWidgetItem(parent_item)
        row_widget = QtWidgets.QWidget()
        row_layout = QtWidgets.QHBoxLayout(row_widget)
        row_layout.setContentsMargins(2, 2, 2, 2)
        row_layout.setSpacing(4)

        index = parent_item.childCount()
        idx_label = QtWidgets.QLabel(f"{index}")
        idx_label.setFixedWidth(20)
        idx_label.setAlignment(QtCore.Qt.AlignCenter)
        idx_label.setStyleSheet("color: #666;")
        row_layout.addWidget(idx_label)

        slot_buttons = []
        for name in slot_names:
            slot_btn = SlotButton(name, is_attribute=is_attribute)
            slot_btn.clicked.connect(lambda checked=False, b=slot_btn: self._set_active_slot(b))
            row_layout.addWidget(slot_btn)
            slot_buttons.append(slot_btn)

        del_btn = QtWidgets.QPushButton("×")
        del_btn.setFixedSize(20, 20)
        del_btn.setStyleSheet("color: #888; border: none; font-weight: bold;")
        del_btn.clicked.connect(lambda checked=False: self._remove_row(parent_item, row_item))
        row_layout.addWidget(del_btn)

        tree_widget.setItemWidget(row_item, 0, row_widget)
        row_item.setData(0, QtCore.Qt.UserRole, slot_buttons)
        return row_item

    def _remove_row(self, parent, item):
        if self.current_active_slot:
            buttons = item.data(0, QtCore.Qt.UserRole)
            if buttons and self.current_active_slot in buttons:
                self.current_active_slot = None
        parent.removeChild(item)

    def _set_active_slot(self, btn_obj):
        if self.current_active_slot:
            try:
                if self.current_active_slot != btn_obj:
                    self.current_active_slot.set_active(False)
            except RuntimeError:
                pass

        self.current_active_slot = btn_obj
        self.current_active_slot.set_active(True)

        if btn_obj.assigned_node and cmds.objExists(btn_obj.assigned_node):
            cmds.select(btn_obj.assigned_node, replace=True)

    # --- 数据收集与传递 ---

    def collect_ui_data(self):
        """遍历 UI 树，收集配置"""
        config_data = {}

        # 只遍历骨骼标签树
        root = self.label_tree.invisibleRootItem()
        for i in range(root.childCount()):
            group_item = root.child(i)
            group_conf = group_item.data(0, QtCore.Qt.UserRole)

            # [安全校验]
            if not group_conf or "name" not in group_conf:
                continue

            module_name = group_conf["name"]

            module_instances = []
            for j in range(group_item.childCount()):
                row_item = group_item.child(j)
                buttons = row_item.data(0, QtCore.Qt.UserRole)

                row_mapping = {}
                is_valid_row = False

                if buttons:
                    for btn in buttons:
                        if btn.assigned_node and cmds.objExists(btn.assigned_node):
                            row_mapping[btn.label_name] = btn.assigned_node
                            is_valid_row = True

                if is_valid_row:
                    module_instances.append(row_mapping)

            if module_instances:
                config_data[module_name] = module_instances

        return config_data

    def _on_run_build(self):
        """执行构建"""
        # 1. 收集当前 UI 面板上的数据
        ui_data = self.collect_ui_data()

        final_data = ui_data

        # 2. 如果 UI 是空的，询问是否执行自动扫描
        if not ui_data:
            result = QtWidgets.QMessageBox.question(
                self,
                "自动扫描模式",
                "检测到 UI 面板未填入数据。\n\n是否使用后台自动扫描 (Auto-Scan) 模式进行绑定？\n(程序将自动根据场景中的标签进行匹配)",
                QtWidgets.QMessageBox.Yes | QtWidgets.QMessageBox.No
            )
            if result == QtWidgets.QMessageBox.No:
                return

            # 传入 None，告诉 build.py 使用自动扫描
            final_data = None

            # 3. 发送给后台
        try:
            build.run_build_test(final_data)
            print("Build Test 执行完毕。")
        except Exception as e:
            import traceback
            traceback.print_exc()
            cmds.error(f"Build Test 错误: {e}")

    # --- 场景同步 ---

    def _sync_from_scene(self):
        """手动刷新场景数据"""
        print("[UI] 正在刷新场景标签检测...")
        self.current_active_slot = None
        scene_labels = logic.get_all_joint_labels()
        scene_attrs = logic.get_scene_attributes(ATTR_LIST)

        self._sync_tree_generic(self.label_tree, scene_labels)
        self._sync_tree_generic(self.attr_tree_left, scene_attrs)
        self._sync_tree_generic(self.attr_tree_right, scene_attrs)

    def _sync_tree_generic(self, tree, data_source):
        root = tree.invisibleRootItem()
        for i in range(root.childCount()):
            group_item = root.child(i)
            config = group_item.data(0, QtCore.Qt.UserRole)
            if config:
                slots = config["slots"]

                max_rows = 0
                for s_name in slots:
                    found_items = data_source.get(s_name, [])
                    if len(found_items) > max_rows:
                        max_rows = len(found_items)
                max_rows = max(max_rows, 1)

                group_item.takeChildren()
                for r in range(max_rows):
                    row_item = self._add_row(tree, group_item, slots, config["is_attr"])
                    slot_buttons = row_item.data(0, QtCore.Qt.UserRole)

                    for btn in slot_buttons:
                        key = btn.label_name
                        nodes = data_source.get(key, [])
                        if r < len(nodes):
                            btn.set_node(nodes[r])
                        else:
                            btn.set_node(None)

    def _on_assign_clicked(self):
        if not self.current_active_slot:
            return
        selection = cmds.ls(sl=True)
        if not selection:
            return

        key = self.current_active_slot.label_name
        node = selection[0]

        if self.current_active_slot.is_attribute:
            logic.add_attribute_to_node(node, key)
        else:
            logic.set_joint_label(node, key)

        self._sync_from_scene()

    def _on_clear_clicked(self):
        if not self.current_active_slot: return
        node = self.current_active_slot.assigned_node
        key = self.current_active_slot.label_name

        if node:
            if self.current_active_slot.is_attribute:
                logic.remove_attribute_from_node(node, key)
            else:
                logic.set_joint_label(node, "")
        self._sync_from_scene()