# ui/rigging/build_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore, QtGui
from maya import cmds

# Backend Logic
from core.logic.rigging import build_widget_logic as logic
from core.rigging import build
from ui.collapsible_widget import CollapsibleWidget

# Configuration Imports
import core.rigging.ik_label as ik_module
import core.rigging.attribute as attribute_pkg

# Retrieve configurations
MODULE_SLOTS = ik_module.get_all_slots()
ATTR_LIST = attribute_pkg.get_all_slot_names()


class SlotButton(QtWidgets.QPushButton):
    """Custom Slot Button"""

    def __init__(self, label_name, is_attribute=False, parent=None):
        super().__init__(parent)
        self.label_name = label_name
        self.is_attribute = is_attribute
        self.assigned_node = None

        self.setSizePolicy(
            QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Preferred
        )
        self.setMinimumHeight(30)
        self.setCursor(QtCore.Qt.PointingHandCursor)

        self.base_style = "border-radius: 4px; font-weight: bold; text-align: left; padding-left: 10px;"
        self.is_active = False
        self.update_appearance()

    def update_appearance(self):
        if self.is_attribute:
            if self.assigned_node:
                self.setText(self.assigned_node.split("|")[-1])
            else:
                self.setText("")
        else:
            if self.assigned_node:
                self.setText(f"{self.label_name}:  {self.assigned_node.split('|')[-1]}")
            else:
                self.setText(self.label_name)

        color_empty_bg = "#454545"
        color_filled_bg = "#2E7D32"
        color_active_border = "#4FC3F7"
        style_sheet = "QPushButton {" + self.base_style
        if self.assigned_node:
            style_sheet += f"background-color: {color_filled_bg}; color: #FFF; border: 1px solid #4CAF50;"
        else:
            style_sheet += f"background-color: {color_empty_bg}; color: #AAA; border: 1px solid #555;"
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
        super().__init__("2. Joints & Modules", parent)
        self.current_active_slot = None

        main_layout = QtWidgets.QVBoxLayout()
        main_layout.setSpacing(8)
        self._create_content(main_layout)
        self.set_content_layout(main_layout)

        QtCore.QTimer.singleShot(200, self._sync_from_scene)

    def _create_content(self, layout):
        # 1. Action Buttons
        action_layout = QtWidgets.QHBoxLayout()
        self.btn_assign = QtWidgets.QPushButton("Assign")
        self.btn_clear = QtWidgets.QPushButton("Clear")
        self.btn_refresh = QtWidgets.QPushButton("Refresh")
        self.btn_assign.setMinimumHeight(30)
        self.btn_assign.setStyleSheet(
            "background-color: #4CAF50; color: white; font-weight: bold;"
        )
        self.btn_clear.setMinimumHeight(30)
        self.btn_clear.setStyleSheet(
            "background-color: #EF5350; color: white; font-weight: bold;"
        )
        self.btn_refresh.setMinimumHeight(30)
        self.btn_refresh.setStyleSheet(
            "background-color: #42A5F5; color: white; font-weight: bold;"
        )
        action_layout.addWidget(self.btn_assign)
        action_layout.addWidget(self.btn_clear)
        action_layout.addWidget(self.btn_refresh)
        layout.addLayout(action_layout)

        # 2. Joint Labels
        layout.addWidget(QtWidgets.QLabel("<b>Joint Labels</b>"))
        self.label_tree = self._create_tree_widget()
        self.label_tree.setMinimumHeight(250)
        self._init_groups_generic(self.label_tree, MODULE_SLOTS, is_attribute=False)
        layout.addWidget(self.label_tree)

        # 3. Attributes
        attr_main_layout = QtWidgets.QVBoxLayout()
        attr_main_layout.addWidget(QtWidgets.QLabel("<b>Attributes</b>"))

        # Merged Container
        attr_container = QtWidgets.QWidget()
        attr_layout = QtWidgets.QHBoxLayout(attr_container)
        attr_layout.setContentsMargins(0, 0, 0, 0)
        attr_layout.setSpacing(0)

        self.attr_tree_left = self._create_tree_widget()
        self.attr_tree_right = self._create_tree_widget()

        self.attr_tree_left.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.attr_tree_right.setFrameShape(QtWidgets.QFrame.NoFrame)

        attr_layout.addWidget(self.attr_tree_left)
        attr_layout.addWidget(self.attr_tree_right)

        attr_main_layout.addWidget(attr_container)
        layout.addLayout(attr_main_layout)

        # 4. Build Button
        self.run_build_btn = QtWidgets.QPushButton("RUN BUILD")
        self.run_build_btn.setMinimumHeight(45)
        self.run_build_btn.setStyleSheet(
            "background-color: #5D4037; color: white; font-weight: bold; font-size: 14px; margin-top: 10px;"
        )
        layout.addWidget(self.run_build_btn)

        # Signal Connections
        self.btn_assign.clicked.connect(self._on_assign_clicked)
        self.btn_clear.clicked.connect(self._on_clear_clicked)
        self.btn_refresh.clicked.connect(self._sync_from_scene)
        self.run_build_btn.clicked.connect(self._on_run_build)

    def _create_tree_widget(self):
        tree = QtWidgets.QTreeWidget()
        tree.setHeaderHidden(True)
        tree.setIndentation(15)
        tree.setMinimumHeight(300)
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

            # Add Button
            add_btn = QtWidgets.QPushButton("+")
            add_btn.setFixedSize(24, 24)
            add_btn.setStyleSheet(
                "QPushButton{ border: 1px solid #666; border-radius: 12px; background: #333; }"
            )

            # [FIX] X Button REMOVED entirely

            header_layout.addWidget(lbl)
            header_layout.addStretch()
            header_layout.addWidget(add_btn)

            tree_widget.setItemWidget(group_item, 0, header_widget)
            group_item.setExpanded(True)

            group_item.setData(
                0,
                QtCore.Qt.UserRole,
                {"name": group_name, "slots": slots, "is_attr": is_attribute},
            )
            add_btn.clicked.connect(
                lambda checked=False,
                p=group_item,
                s=slots,
                t=tree_widget,
                attr=is_attribute: self._add_row(t, p, s, attr)
            )

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
            slot_btn.clicked.connect(
                lambda checked=False, b=slot_btn: self._set_active_slot(b)
            )
            row_layout.addWidget(slot_btn)
            slot_buttons.append(slot_btn)

        del_btn = QtWidgets.QPushButton("×")
        del_btn.setFixedSize(20, 20)
        del_btn.setStyleSheet("color: #888; border: none; font-weight: bold;")
        del_btn.clicked.connect(
            lambda checked=False: self._remove_row(parent_item, row_item)
        )
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

    # [FIX] _on_delete_group_clicked REMOVED

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

    def collect_ui_data(self):
        config_data = {}

        self._parse_tree_to_config(self.label_tree, config_data)
        self._parse_tree_to_config(self.attr_tree_left, config_data)
        self._parse_tree_to_config(self.attr_tree_right, config_data)

        return config_data

    def _parse_tree_to_config(self, tree, config_data):
        root = tree.invisibleRootItem()
        for i in range(root.childCount()):
            group_item = root.child(i)
            group_conf = group_item.data(0, QtCore.Qt.UserRole)
            if not group_conf or "name" not in group_conf:
                continue

            module_name = group_conf["name"]

            # Ensure list exists
            if module_name not in config_data:
                config_data[module_name] = []

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
                    config_data[module_name].append(row_mapping)

    def _on_run_build(self):
        ui_data = self.collect_ui_data()
        try:
            build.run_build_test(ui_data)
            print("Build Test Execution Complete.")
        except Exception as e:
            import traceback

            traceback.print_exc()
            cmds.error(f"Build Test Error: {e}")

    def _sync_from_scene(self):
        """Sync Data"""
        print("[UI] Syncing scene labels and attributes...")
        self.current_active_slot = None

        # 1. Labels
        scene_labels = logic.get_all_joint_labels()

        # 2. Attributes
        # [FIX] handle return value correctly (Dictionary when include_extra=False)
        config_attrs = logic.get_scene_attributes(ATTR_LIST, include_extra=False)
        # extra_attrs = {} # Not used

        all_attr_data = config_attrs.copy()

        all_keys = list(ATTR_LIST)

        left_keys = all_keys[0::2]
        right_keys = all_keys[1::2]

        left_dict = {k: [k] for k in left_keys}
        right_dict = {k: [k] for k in right_keys}

        # 3. Sync
        self._sync_tree_generic(self.label_tree, scene_labels, is_attribute=False)

        self.attr_tree_left.clear()
        self._init_groups_generic(self.attr_tree_left, left_dict, is_attribute=True)
        self._sync_tree_generic(self.attr_tree_left, all_attr_data, is_attribute=True)

        self.attr_tree_right.clear()
        self._init_groups_generic(self.attr_tree_right, right_dict, is_attribute=True)
        self._sync_tree_generic(self.attr_tree_right, all_attr_data, is_attribute=True)

    def _sync_tree_generic(self, tree, data_source, is_attribute):
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
                    row_item = self._add_row(tree, group_item, slots, is_attribute)
                    slot_buttons = row_item.data(0, QtCore.Qt.UserRole)

                    for btn in slot_buttons:
                        key = btn.label_name
                        nodes = data_source.get(key, [])
                        if r < len(nodes):
                            btn.set_node(nodes[r])
                        else:
                            btn.set_node(None)
                pass

    def _on_assign_clicked(self):
        if not self.current_active_slot:
            return
        selection = cmds.ls(sl=True)
        if not selection:
            return
        key = self.current_active_slot.label_name
        node = selection[0]

        if self.current_active_slot.is_attribute:
            attr_class = attribute_pkg.get_attribute_class(key)
            if attr_class:
                attr_class.add_to(node)
            else:
                logic.add_attribute_to_node(node, key)
        else:
            logic.set_joint_label(node, key)
        self._sync_from_scene()

    def _on_clear_clicked(self):
        if not self.current_active_slot:
            return
        node = self.current_active_slot.assigned_node
        key = self.current_active_slot.label_name
        if node:
            if self.current_active_slot.is_attribute:
                attr_class = attribute_pkg.get_attribute_class(key)
                if attr_class:
                    attr_class.remove_from(node)
                else:
                    logic.remove_attribute_from_node(node, key)
            else:
                logic.set_joint_label(node, "")
        self._sync_from_scene()
