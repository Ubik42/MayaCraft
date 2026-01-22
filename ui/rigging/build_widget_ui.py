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
    """
    Custom Slot Button with:
    1. Right Click -> Toggle Assignment (Signal)
    2. Left Click -> Select/Jump (Handled via set_active)
    """
    # Signal: Emits self when right clicked
    right_clicked = QtCore.Signal(object)

    def __init__(self, label_name, is_attribute=False, parent=None):
        super().__init__(parent)
        self.label_name = label_name
        self.is_attribute = is_attribute
        self.assigned_node = None
        self.is_active = False  # State for UI highlighting

        self.setSizePolicy(
            QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Preferred
        )
        self.setMinimumHeight(30)
        self.setCursor(QtCore.Qt.PointingHandCursor)

        self.base_style = "border-radius: 4px; font-weight: bold; text-align: left; padding-left: 10px;"
        self.update_appearance()

    def mousePressEvent(self, event):
        """Override to handle clicks."""
        if event.button() == QtCore.Qt.RightButton:
            # Right Click -> Toggle Action
            self.right_clicked.emit(self)
            # Do not call super() to prevent button 'pressed' visual state on right click if undesired,
            # but usually it's fine.
        else:
            # Left Click -> Standard behavior (triggers 'clicked' signal)
            super().mousePressEvent(event)

    def set_active(self, active: bool):
        """Set visual active state (border highlight)."""
        self.is_active = active
        self.update_appearance()

    def set_node(self, node_name):
        self.assigned_node = node_name
        self.update_appearance()

    def update_appearance(self):
        # 1. Text Logic
        text = ""
        if self.assigned_node:
            short_node = self.assigned_node.split("|")[-1]
            if self.is_attribute:
                text = short_node
            else:
                text = f"{self.label_name}:  {short_node}"
        else:
            text = self.label_name

        self.setText(text)

        # 2. Color Logic
        color_empty_bg = "#454545"
        color_filled_bg = "#2E7D32"  # Green

        # Hover colors
        color_empty_hover = "#505050"
        color_filled_hover = "#388E3C"

        bg_color = color_filled_bg if self.assigned_node else color_empty_bg
        hover_color = color_filled_hover if self.assigned_node else color_empty_hover
        text_color = "#FFF" if self.assigned_node else "#AAA"

        # 3. Border Logic (Active State)
        if self.is_active:
            # Bright Blue border when active (clicked)
            border = "2px solid #4FC3F7"
        else:
            border = "1px solid #4CAF50" if self.assigned_node else "1px solid #555"

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


class BuildWidget(CollapsibleWidget):
    def __init__(self, parent=None):
        super().__init__("2. Joints & Modules", parent)

        # Track the currently clicked slot for visual highlighting
        self.current_active_slot = None

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
        self.label_tree.setMinimumHeight(300)  # Increased Height
        self._init_groups_generic(self.label_tree, MODULE_SLOTS, is_attribute=False)
        layout.addWidget(self.label_tree)

        # --- 2. Attributes Section (Single Column) ---
        layout.addWidget(QtWidgets.QLabel("<b>Attributes</b>"))
        self.attr_tree = self._create_tree_widget()
        self.attr_tree.setMinimumHeight(400)  # Increased Height significantly
        layout.addWidget(self.attr_tree)

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

        # Refresh Button
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
        tree.setSelectionMode(QtWidgets.QAbstractItemView.NoSelection)
        tree.setVerticalScrollMode(QtWidgets.QAbstractItemView.ScrollPerPixel)
        # Remove frame for cleaner look
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

            # Left Click: Select/Jump
            slot_btn.clicked.connect(
                lambda checked=False, b=slot_btn: self._on_slot_clicked(b)
            )

            # [CHANGED] Right Click: Toggle Assignment
            slot_btn.right_clicked.connect(self._on_slot_right_clicked)

            row_layout.addWidget(slot_btn)
            slot_buttons.append(slot_btn)

        # Delete Row Button
        del_btn = QtWidgets.QPushButton("×")
        del_btn.setFixedSize(18, 18)
        del_btn.setStyleSheet("color: #666; border: none; font-weight: bold;")
        del_btn.clicked.connect(
            lambda checked=False: self._remove_row(parent_item, row_item)
        )
        row_layout.addWidget(del_btn)

        tree_widget.setItemWidget(row_item, 0, row_widget)
        row_item.setData(0, QtCore.Qt.UserRole, slot_buttons)
        return row_item

    def _remove_row(self, parent, item):
        # Logic to clean up active slot reference if deleting the active row
        if self.current_active_slot:
            buttons = item.data(0, QtCore.Qt.UserRole)
            if buttons and self.current_active_slot in buttons:
                self.current_active_slot = None
        parent.removeChild(item)

    # --- Click Handlers ---

    def _on_slot_clicked(self, btn_obj):
        """
        Left Click:
        1. Set UI visual state to Active (Blue border).
        2. Select the assigned bone in Maya (Jump).
        """
        # 1. Update UI Visuals
        if self.current_active_slot:
            try:
                if self.current_active_slot != btn_obj:
                    self.current_active_slot.set_active(False)
            except RuntimeError:
                pass  # Widget might be deleted

        self.current_active_slot = btn_obj
        self.current_active_slot.set_active(True)

        # 2. Maya Selection (Jump to bone)
        if btn_obj.assigned_node and cmds.objExists(btn_obj.assigned_node):
            cmds.select(btn_obj.assigned_node, replace=True)
            print(f"[UI] Selected: {btn_obj.assigned_node}")

    def _on_slot_right_clicked(self, btn_obj):
        """
        Right Click: Toggle logic.
        1. If selection exists -> Call backend toggle (Assign/Remove).
        2. If no selection -> Call backend force remove.
        """
        selection = cmds.ls(sl=True)
        key = btn_obj.label_name
        is_attr = btn_obj.is_attribute

        if selection:
            target_node = selection[0]
            # Call backend to toggle
            logic.toggle_configuration(target_node, key, is_attr)

        elif btn_obj.assigned_node:
            # Force remove
            logic.toggle_configuration(btn_obj.assigned_node, key, is_attr, force_remove=True)

        self._sync_from_scene()

    # --- Data Collection & Sync ---

    def collect_ui_data(self):
        config_data = {}
        self._parse_tree_to_config(self.label_tree, config_data)
        self._parse_tree_to_config(self.attr_tree, config_data)
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
        self.current_active_slot = None  # Reset active tracking on sync

        # Get structured data from backend
        scene_data = logic.get_scene_data(ATTR_LIST)

        label_data = scene_data.get('labels', {})
        attr_data = scene_data.get('attributes', {})

        # Prepare Attribute Dict (Single Column)
        # Create a dict where key is attribute name, and value is a list containing itself
        # This matches the generic structure expected by _init_groups_generic
        attr_dict = {k: [k] for k in ATTR_LIST}

        # Sync Trees
        # 1. Labels
        self._sync_tree_content(self.label_tree, label_data, is_attribute=False)

        # 2. Attributes (Single Tree)
        self.attr_tree.clear()
        self._init_groups_generic(self.attr_tree, attr_dict, is_attribute=True)
        self._sync_tree_content(self.attr_tree, attr_data, is_attribute=True)

    def _sync_tree_content(self, tree, data_source, is_attribute):
        root = tree.invisibleRootItem()
        for i in range(root.childCount()):
            group_item = root.child(i)
            config = group_item.data(0, QtCore.Qt.UserRole)
            if not config: continue

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