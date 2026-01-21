# core/rigging/attribute/bendy.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask


class BendyAttribute(RigObject):
    SLOTS = ["bendy"]

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        return [
            RigTask(
                priority=self.get_priority("attribute_bendy", 30),
                run=self.run_logic,
                name=f"Attribute Logic: Bendy ({self._get_node_name()})",
            )
        ]

    def _get_node_name(self):
        return self.mapping.get("bendy", "Unknown")

    def run_logic(self):
        node = self.mapping.get("bendy")
        if not node or not cmds.objExists(node):
            return

        # Placeholder logic
        pass

    @staticmethod
    def add_to(node: str) -> bool:
        attr_name = "bendy"
        if not cmds.objExists(node):
            return False
        if cmds.attributeQuery(attr_name, node=node, exists=True):
            return True

        try:
            cmds.addAttr(
                node,
                longName=attr_name,
                attributeType="double",
                min=0,
                max=1,
                defaultValue=0,
                keyable=True,
            )
            print(f"[Attribute] Added: {node}.{attr_name}")
            return True
        except Exception as e:
            cmds.warning(f"Failed to add bendy: {e}")
            return False

    @staticmethod
    def remove_from(node: str) -> bool:
        attr_name = "bendy"
        if not cmds.objExists(node):
            return False
        if not cmds.attributeQuery(attr_name, node=node, exists=True):
            return False

        try:
            cmds.deleteAttr(node, attribute=attr_name)
            print(f"[Attribute] Removed: {node}.{attr_name}")
            return True
        except Exception as e:
            cmds.warning(f"Failed to remove bendy: {e}")
            return False
