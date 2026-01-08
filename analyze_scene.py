# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
from PySide6 import QtWidgets, QtGui, QtCore


class MayaHierarchyInspectorExportMod(QtWidgets.QDialog):
    def __init__(self, parent=None):
        if not parent:
            parent = self.get_maya_window()
        super().__init__(parent)

        self.setWindowTitle("Hierarchy Inspector (Export Mod)")
        self.resize(1400, 800)
        self.setWindowFlags(QtCore.Qt.WindowType.Window)

        self.init_ui()
        self.refresh_tree()

    def get_maya_window(self):
        for widget in QtWidgets.QApplication.topLevelWidgets():
            if widget.objectName() == "MayaWindow":
                return widget
        return None

    def init_ui(self):
        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setContentsMargins(10, 10, 10, 10)
        main_layout.setSpacing(10)

        # --- Toolbar ---
        toolbar_layout = QtWidgets.QHBoxLayout()
        app_style = QtWidgets.QApplication.style()
        refresh_icon = app_style.standardIcon(QtWidgets.QStyle.StandardPixmap.SP_BrowserReload)

        self.btn_refresh = QtWidgets.QPushButton("Refresh")
        self.btn_refresh.setIcon(refresh_icon)
        self.btn_refresh.clicked.connect(self.refresh_tree)

        self.btn_expand = QtWidgets.QPushButton("Expand All")
        self.btn_expand.clicked.connect(self.expand_all)

        self.btn_collapse = QtWidgets.QPushButton("Collapse All")
        self.btn_collapse.clicked.connect(self.collapse_all)

        toolbar_layout.addWidget(self.btn_refresh)
        toolbar_layout.addWidget(self.btn_expand)
        toolbar_layout.addWidget(self.btn_collapse)

        # --- Tree Widget ---
        self.tree_widget = QtWidgets.QTreeWidget()
        self.tree_widget.setColumnCount(4)
        self.tree_widget.setHeaderLabels([
            "Name",
            "Type",
            "Locked Attrs",
            "Driven By / Input"
        ])

        self.tree_widget.setColumnWidth(0, 350)
        self.tree_widget.setColumnWidth(1, 100)
        self.tree_widget.setColumnWidth(2, 200)
        self.tree_widget.setColumnWidth(3, 500)

        self.tree_widget.setSelectionMode(QtWidgets.QAbstractItemView.SelectionMode.ExtendedSelection)
        self.tree_widget.setAlternatingRowColors(True)
        self.tree_widget.itemClicked.connect(self.on_item_clicked)

        # --- Bottom Buttons ---
        bottom_layout = QtWidgets.QHBoxLayout()

        # Export Option Checkbox
        self.chk_export_simple = QtWidgets.QCheckBox("Simple Export (Name & Type Only)")
        self.chk_export_simple.setToolTip(
            "Checked: Export Name + Type\nUnchecked: Export Name + Type + Locked + Driven")
        self.chk_export_simple.setChecked(True)  # Default Checked

        self.btn_copy_all = QtWidgets.QPushButton("Copy All (Notion)")
        self.btn_copy_all.setMinimumHeight(40)
        self.btn_copy_all.clicked.connect(lambda: self.copy_for_notion(only_selected=False))

        self.btn_copy_selected = QtWidgets.QPushButton("Copy Selected (Notion)")
        self.btn_copy_selected.setMinimumHeight(40)
        self.btn_copy_selected.setStyleSheet(
            "background-color: #5285a6; color: white; font-weight: bold; border-radius: 4px;")
        self.btn_copy_selected.clicked.connect(lambda: self.copy_for_notion(only_selected=True))

        bottom_layout.addWidget(self.chk_export_simple)
        bottom_layout.addWidget(self.btn_copy_all)
        bottom_layout.addWidget(self.btn_copy_selected)

        main_layout.addLayout(toolbar_layout)
        main_layout.addWidget(self.tree_widget)
        main_layout.addLayout(bottom_layout)

    def sync_outliner(self):
        try:
            mel.eval('if (`runTimeCommand -exists showSelectedInOutliner`) showSelectedInOutliner;')
        except Exception:
            pass

    # =========================================================================
    # Core Driver Analysis Logic
    # =========================================================================

    def get_immediate_driver(self, node_attr):
        connections = cmds.listConnections(node_attr, source=True, destination=False, plugs=True)
        if not connections:
            return None, None

        driver_plug = connections[0]
        driver_node = driver_plug.split(".")[0]
        driver_node_full = driver_node
        ls = cmds.ls(driver_node, long=True)
        if ls: driver_full_path = ls[0]

        node_type = cmds.nodeType(driver_node)

        if node_type == 'unitConversion':
            return self.get_immediate_driver(f"{driver_node}.input")

        return driver_full_path, driver_node

    def get_constraint_targets(self, constraint_node):
        targets = cmds.listConnections(f"{constraint_node}.target", source=True, destination=False) or []
        targets = list(set(targets))

        target_info = []
        constraint_short_name = constraint_node.split("|")[-1]

        for t in targets:
            ls_t = cmds.ls(t, long=True)
            full_path = ls_t[0] if ls_t else t
            short_name = full_path.split("|")[-1]

            if short_name == constraint_short_name:
                continue

            target_info.append((full_path, short_name))

        return target_info

    def get_driven_data(self, node):
        node_type = cmds.nodeType(node)
        display_list = []
        driver_data_list = []

        if "constraint" in node_type.lower():
            target_info = self.get_constraint_targets(node)
            if target_info:
                target_names = [t[1] for t in target_info]
                display_list.append(f"<- {', '.join(target_names)}")
                for full_path, short_name in target_info:
                    driver_data_list.append({
                        'label': short_name,
                        'driver_path': full_path
                    })
        else:
            aggregator = {}
            attrs_to_check = ['tx', 'ty', 'tz', 'rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']

            for attr in attrs_to_check:
                if cmds.attributeQuery(attr, node=node, exists=True):
                    driver_path, driver_name = self.get_immediate_driver(f"{node}.{attr}")
                    if driver_path:
                        if driver_path not in aggregator:
                            aggregator[driver_path] = {'short_name': driver_name, 'attrs': []}
                        aggregator[driver_path]['attrs'].append(attr)

            for driver_path, data in aggregator.items():
                attrs_str = ", ".join(data['attrs'])
                driver_name = data['short_name']
                driver_type = cmds.nodeType(driver_path)

                if "constraint" in driver_type.lower():
                    targets = self.get_constraint_targets(driver_path)
                    if targets:
                        target_names = [t[1] for t in targets]
                        display_text = f"{attrs_str} <- {driver_name}, {', '.join(target_names)}"
                        display_list.append(display_text)

                        for t_path, t_name in targets:
                            menu_label = f"{attrs_str} <- {t_name} ({driver_name})"
                            driver_data_list.append({
                                'label': menu_label,
                                'driver_path': t_path
                            })
                    else:
                        display_text = f"{attrs_str} <- {driver_name} (No Target)"
                        display_list.append(display_text)
                        driver_data_list.append({
                            'label': f"{attrs_str} <- {driver_name} (Broken)",
                            'driver_path': driver_path
                        })
                else:
                    display_text = f"{attrs_str} <- {driver_name}"
                    display_list.append(display_text)
                    driver_data_list.append({
                        'label': display_text,
                        'driver_path': driver_path
                    })

        return " ; ".join(display_list), driver_data_list

    # =========================================================================
    # UI Building Helpers
    # =========================================================================

    def get_short_name(self, full_path):
        return full_path.split("|")[-1]

    def get_locked_attrs(self, node):
        locked = []
        for attr in ['tx', 'ty', 'tz', 'rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']:
            if cmds.attributeQuery(attr, node=node, exists=True):
                if cmds.getAttr(f"{node}.{attr}", lock=True):
                    locked.append(attr)
        return ", ".join(locked) if locked else ""

    def build_tree_recursive(self, maya_node, parent_item):
        short_name = self.get_short_name(maya_node)
        node_type = cmds.nodeType(maya_node)
        locked_str = self.get_locked_attrs(maya_node)
        driven_str, driven_data = self.get_driven_data(maya_node)

        item = QtWidgets.QTreeWidgetItem(parent_item)
        item.setText(0, short_name)
        item.setText(1, node_type)
        item.setText(2, locked_str)
        item.setText(3, driven_str)

        item.setData(0, QtCore.Qt.ItemDataRole.UserRole, maya_node)
        item.setData(3, QtCore.Qt.ItemDataRole.UserRole, driven_data)

        if "constraint" in node_type.lower():
            item.setForeground(1, QtGui.QColor("#d4a5ff"))  # Purple for constraints
            item.setForeground(0, QtGui.QColor("#d4a5ff"))
        elif node_type == "joint":
            item.setForeground(0, QtGui.QColor("#85c9e0"))  # Blue for joints
        elif node_type == "transform":
            item.setForeground(0, QtGui.QColor("#cccccc"))  # Grey for transforms

        if locked_str: item.setForeground(2, QtGui.QColor("#ff6b6b"))  # Red for locked
        if driven_str: item.setForeground(3, QtGui.QColor("#ffb86c"))  # Orange for driven

        children = cmds.listRelatives(maya_node, children=True, fullPath=True)
        if children:
            for child in children:
                self.build_tree_recursive(child, item)

    def refresh_tree(self):
        self.tree_widget.clear()
        self.tree_widget.setSortingEnabled(False)

        selection = cmds.ls(sl=True, long=True)
        nodes = selection if selection else [x for x in cmds.ls(assemblies=True, long=True) if
                                             x not in ['|persp', '|top', '|front', '|side']]

        title_suffix = "Selected" if selection else "All"
        self.setWindowTitle(f"Hierarchy Inspector - [{title_suffix}]")

        for node in nodes:
            self.build_tree_recursive(node, self.tree_widget)
        if selection: self.tree_widget.expandAll()

    def expand_all(self):
        self.tree_widget.expandAll()

    def collapse_all(self):
        self.tree_widget.collapseAll()

    def on_item_clicked(self, item, column):
        node_path = item.data(0, QtCore.Qt.ItemDataRole.UserRole)

        if column == 3:
            driver_data = item.data(3, QtCore.Qt.ItemDataRole.UserRole)
            if driver_data:
                self.show_driver_menu(driver_data)
                return

        if node_path and cmds.objExists(node_path):
            selected_items = self.tree_widget.selectedItems()
            if item not in selected_items: selected_items.append(item)
            paths = [i.data(0, QtCore.Qt.ItemDataRole.UserRole) for i in selected_items]
            paths = [p for p in paths if p]
            if paths:
                cmds.select(paths)
                self.sync_outliner()

    def show_driver_menu(self, driver_data):
        menu = QtWidgets.QMenu(self)
        menu.setStyleSheet("QMenu { padding: 5px; font-weight: bold; }")

        header = QtGui.QAction("Jump To Driver:", self)
        header.setEnabled(False)
        menu.addAction(header)
        menu.addSeparator()

        for data in driver_data:
            action = QtGui.QAction(data['label'], self)
            action.triggered.connect(lambda c=False, p=data['driver_path']: self.select_driver(p))
            menu.addAction(action)

        menu.exec(QtGui.QCursor.pos())

    def select_driver(self, full_path):
        if cmds.objExists(full_path):
            cmds.select(full_path)
            self.sync_outliner()
            cmds.inViewMessage(amg=f'<span style=\"color: #00FF00;\">Jumped to: {full_path.split("|")[-1]}</span>',
                               pos='midCenter', fade=True)

    def copy_for_notion(self, only_selected=False):
        """
        Export Logic:
        Checked: Export Name + Type
        Unchecked: Export Name + Type + Locked + Driven
        """
        result_text = ""
        items = self.tree_widget.selectedItems() if only_selected else QtWidgets.QTreeWidgetItemIterator(
            self.tree_widget)

        item_list = []
        if only_selected:
            item_list = items
        else:
            while items.value():
                item_list.append(items.value())
                items += 1

        if not item_list: return

        is_simple = self.chk_export_simple.isChecked()

        for item in item_list:
            depth = 0
            p = item.parent()
            while p:
                depth += 1
                p = p.parent()

            indent = "\t" * depth
            name = item.text(0)
            typ = item.text(1)

            type_part = f" ({typ})"

            if is_simple:
                result_text += f"{indent}- {name}{type_part}\n"
            else:
                locked = item.text(2)
                driven = item.text(3)

                l_part = f" 🔒`{locked}`" if locked else ""
                d_part = f" 🔗{driven}" if driven else ""

                result_text += f"{indent}- {name}{type_part}{l_part}{d_part}\n"

        QtWidgets.QApplication.clipboard().setText(result_text)
        cmds.inViewMessage(amg='<span style=\"color: #00FF00;\">Notion format copied!</span>', pos='midCenter',
                           fade=True)


# Startup
inspector_mod_win = None


def show_tool():
    global inspector_mod_win
    if inspector_mod_win:
        try:
            inspector_mod_win.close(); inspector_mod_win.deleteLater()
        except:
            pass
    inspector_mod_win = MayaHierarchyInspectorExportMod()
    inspector_mod_win.show()


if __name__ == "__main__":
    show_tool()