# ui/rigging/build_widget_ui.py
# -*- coding: utf-8 -*-

from PySide6 import QtWidgets, QtCore, QtGui
from maya import cmds

# Backend Logic (Will be updated later)
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
    """
    Custom Slot Button with Double Click support.
    """
    # Signal: Emits self when double clicked
    double_clicked = QtCore.Signal(object)

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
        # Allow text to elide if too long
        self.update_appearance()

    def mouseDoubleClickEvent(self, event):
        """Override to handle double click."""
        if event.button() == QtCore.Qt.LeftButton:
            self.double_clicked.emit(self)
        super().mouseDoubleClickEvent(event)

    def update_appearance(self):
        text = ""
        if self.assigned_node:
            short_node = self.assigned_node.split("|")[-1]
            if self.is_attribute:
                text = short_node
            else:
                text = f"{self.label_name}:  {short_node}"
        else:
            text = self.label_name if not self.is_attribute else self.label_name

        self.setText(text)

        # Style Logic
        color_empty_bg = "#454545"
        color_filled_bg = "#2E7D32"  # Green for filled

        # Hover colors
        color_empty_hover = "#505050"
        color_filled_hover = "#388E3C"

        bg_color = color_filled_bg if self.assigned_node else color_empty_bg
        hover_color = color_filled_hover if self.assigned_node else color_empty_hover

        border = "1px solid #4CAF50" if self.assigned_node else "1px solid #555"
        text_color = "#FFF" if self.assigned_node else "#AAA"

        style_sheet = f"""
            QPushButton {{
                {self.base_style}
                background-color: {bg_color};
                color: {text_color};
                border: {border};
            }}
            QPushButton:hover {{
                background-color: {hover_color};
            }}
        """
        self.setStyleSheet(style_sheet)

    def set_node(self, node_name):
        self.assigned_node = node_name
        self.update_appearance()


class BuildWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("2. Joints & Modules", parent)

        main_layout = QtWidgets.QVBoxLayout()
        main_layout.setSpacing(8)
        self._create_content(main_layout)
        self.set_content_layout(main_layout)

        # Auto sync on load
        QtCore.QTimer.singleShot(200, self._sync_from_scene)

    def _create_content(self, layout):
        # --- 1. Joint Labels Section ---
        layout.addWidget(QtWidgets.QLabel("<b>Joint Labels (Modules)</b>"))
        self.label_tree = self._create_tree_widget()
        self.label_tree.setMinimumHeight(200)
        self._init_groups_generic(self.label_tree, MODULE_SLOTS, is_attribute=False)
        layout.addWidget(self.label_tree)

        # --- 2. Attributes Section ---
        attr_main_layout = QtWidgets.QVBoxLayout()
        attr_main_layout.setContentsMargins(0, 10, 0, 0)
        attr_main_layout.addWidget(QtWidgets.QLabel("<b>Attributes</b>"))

        # Two columns for attributes
        attr_container = QtWidgets.QWidget()
        attr_layout = QtWidgets.QHBoxLayout(attr_container)
        attr_layout.setContentsMargins(0, 0, 0, 0)
        attr_layout.setSpacing(4)

        self.attr_tree_left = self._create_tree_widget()
        self.attr_tree_right = self._create_tree_widget()

        attr_layout.addWidget(self.attr_tree_left)
        attr_layout.addWidget(self.attr_tree_right)

        attr_main_layout.addWidget(attr_container)
        layout.addLayout(attr_main_layout)

        # --- 3. Action Area (Bottom) ---
        bottom_layout = QtWidgets.QHBoxLayout()
        bottom_layout.setContentsMargins(0, 10, 0, 0)

        # Build Button
        self.run_build_btn = QtWidgets.QPushButton("RUN BUILD")
        self.run_build_btn.setMinimumHeight(40)
        self.run_build_btn.setStyleSheet(
            "background-color: #5D4037; color: white; font-weight: bold; font-size: 14px; border-radius: 4px;"
        )
        self.run_build_btn.clicked.connect(self._on_run_build)

        # Refresh Button (Moved next to Build)
        self.btn_refresh = QtWidgets.QPushButton("Refresh")
        self.btn_refresh.setMinimumHeight(40)
        self.btn_refresh.setFixedWidth(80)
        self.btn_refresh.setStyleSheet(
            "background-color: #42A5F5; color: white; font-weight: bold; border-radius: 4px;"
        )
        self.btn_refresh.clicked.connect(self._sync_from_scene)

        bottom_layout.addWidget(self.run_build_btn)
        bottom_layout.addWidget(self.btn_refresh)

        layout.addLayout(bottom_layout)

    def _create_tree_widget(self):
        tree = QtWidgets.QTreeWidget()
        tree.setHeaderHidden(True)
        tree.setIndentation(10)
        tree.setMinimumHeight(200)  # Balanced height
        tree.setSelectionMode(QtWidgets.QAbstractItemView.NoSelection)
        tree.setVerticalScrollMode(QtWidgets.QAbstractItemView.ScrollPerPixel)
        # Remove frame for cleaner look in columns
        tree.setFrameShape(QtWidgets.QFrame.NoFrame)
        return tree

    def _init_groups_generic(self, tree_widget, data_dict, is_attribute):
        tree_widget.clear()
        for group_name, slots in data_dict.items():
            group_item = QtWidgets.QTreeWidgetItem(tree_widget)

            header_widget = QtWidgets.QWidget()
            header_layout = QtWidgets.QHBoxLayout(header_widget)
            header_layout.setContentsMargins(0, 5, 0, 5)

            lbl = QtWidgets.QLabel(group_name)
            lbl.setStyleSheet("font-weight: bold; color: #BBB;")

            # Add Row Button
            add_btn = QtWidgets.QPushButton("+")
            add_btn.setFixedSize(20, 20)
            add_btn.setStyleSheet(
                "QPushButton{ border: 1px solid #555; border-radius: 10px; background: #333; color: #AAA; } QPushButton:hover{ background: #555; color: #FFF; }"
            )

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
        row_layout.setContentsMargins(0, 2, 0, 2)
        row_layout.setSpacing(4)

        # Index Label
        index = parent_item.childCount()
        idx_label = QtWidgets.QLabel(f"{index}")
        idx_label.setFixedWidth(15)
        idx_label.setAlignment(QtCore.Qt.AlignCenter)
        idx_label.setStyleSheet("color: #666; font-size: 10px;")
        row_layout.addWidget(idx_label)

        slot_buttons = []
        for name in slot_names:
            slot_btn = SlotButton(name, is_attribute=is_attribute)
            # Connect Double Click Signal
            slot_btn.double_clicked.connect(self._on_slot_double_clicked)

            row_layout.addWidget(slot_btn)
            slot_buttons.append(slot_btn)

        # Delete Row Button
        del_btn = QtWidgets.QPushButton("×")
        del_btn.setFixedSize(18, 18)
        del_btn.setStyleSheet("color: #666; border: none; font-weight: bold;")
        del_btn.clicked.connect(
            lambda checked=False: parent_item.removeChild(row_item)
        )
        row_layout.addWidget(del_btn)

        tree_widget.setItemWidget(row_item, 0, row_widget)
        row_item.setData(0, QtCore.Qt.UserRole, slot_buttons)
        return row_item

    def _on_slot_double_clicked(self, btn_obj):
        """
        Handle double click on a slot button.
        Logic:
        1. If selection exists -> Toggle (Add if new, Remove if exists).
        2. If no selection but button has node -> Clear that slot.
        """
        selection = cmds.ls(sl=True)
        key = btn_obj.label_name
        is_attr = btn_obj.is_attribute

        # Case 1: Active Selection in Maya
        if selection:
            target_node = selection[0]
            # Call backend to toggle configuration
            # Note: Backend should handle "if has attribute -> remove, else -> add"
            logic.toggle_configuration(target_node, key, is_attr)

        # Case 2: No Selection, but want to clear existing assignment
        elif btn_obj.assigned_node:
            # Remove configuration from the assigned node
            # Backend should handle force remove
            logic.toggle_configuration(btn_obj.assigned_node, key, is_attr, force_remove=True)

        # Refresh UI
        self._sync_from_scene()

    def collect_ui_data(self):
        """Collect data for building."""
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
            print("[UI] Build process initiated.")
        except Exception as e:
            import traceback
            traceback.print_exc()
            cmds.error(f"Build Error: {e}")

    def _sync_from_scene(self):
        """Fetch data from backend and update UI."""
        # 1. Get structured data from backend
        # Expected format:
        # {
        #   'labels': {'Hip': ['Jnt1'], 'Knee': ['Jnt2']},
        #   'attributes': {'twist': ['Jnt1', 'Jnt2']}
        # }
        scene_data = logic.get_scene_data(ATTR_LIST)

        label_data = scene_data.get('labels', {})
        attr_data = scene_data.get('attributes', {})

        # Split attribute keys for two columns UI
        all_keys = list(ATTR_LIST)
        left_keys = all_keys[0::2]
        right_keys = all_keys[1::2]

        left_dict = {k: [k] for k in left_keys}
        right_dict = {k: [k] for k in right_keys}

        # 2. Sync Trees
        # Labels
        self._sync_tree_content(self.label_tree, label_data, is_attribute=False)

        # Attributes Left
        self.attr_tree_left.clear()
        self._init_groups_generic(self.attr_tree_left, left_dict, is_attribute=True)
        self._sync_tree_content(self.attr_tree_left, attr_data, is_attribute=True)

        # Attributes Right
        self.attr_tree_right.clear()
        self._init_groups_generic(self.attr_tree_right, right_dict, is_attribute=True)
        self._sync_tree_content(self.attr_tree_right, attr_data, is_attribute=True)

    def _sync_tree_content(self, tree, data_source, is_attribute):
        """Helper to fill tree rows based on data."""
        root = tree.invisibleRootItem()
        for i in range(root.childCount()):
            group_item = root.child(i)
            config = group_item.data(0, QtCore.Qt.UserRole)
            if not config: continue

            slots = config["slots"]

            # Determine how many rows needed
            max_rows = 0
            for s_name in slots:
                found_items = data_source.get(s_name, [])
                if len(found_items) > max_rows:
                    max_rows = len(found_items)
            max_rows = max(max_rows, 1)  # At least one empty row

            # Clear existing rows and rebuild
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