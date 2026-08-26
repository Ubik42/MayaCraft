# core/rigging/attribute/twist_bendy.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from MayaCraft.core.rigging.base import RigObject, RigTask
from MayaCraft.core import tool


class TwistBendyAttribute(RigObject):
    SLOTS = ["twistJoints", "bendyCtrls"]

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        return [
            RigTask(
                priority=self.get_priority("attribute_twist_bendy", 30),
                run=self.run_logic,
                name=f"Attribute Logic: Twist/Bendy ({self._get_node_name()})",
            )
        ]

    def _get_node_name(self):
        # Mapping might have 'twist' or 'bendy' or both depending on how it was created
        # But usually the key in mapping comes from the slot name.
        # Since we registered SLOTS=["twist", "bendy"], we check both.
        return self.mapping.get("twist") or self.mapping.get("bendy") or "Unknown"

    def run_logic(self):
        node = self._get_node_name()
        if not node or not cmds.objExists(node):
            return

        twist_val = (
            cmds.getAttr(f"{node}.twist")
            if cmds.attributeQuery("twist", node=node, exists=True)
            else 0
        )
        bendy_val = (
            cmds.getAttr(f"{node}.bendy")
            if cmds.attributeQuery("bendy", node=node, exists=True)
            else 0
        )


        pass

    @staticmethod
    def add_to(node: str) -> bool:
        s1 = tool.add_attribute(
            node,
            long_name="twistJoints",
            nice_name="Twist Joints",
            attribute_type="long",  # Integer
            min_value=0,
            default_value=2,
            keyable=True,
        )
        s2 = tool.add_attribute(
            node,
            long_name="bendyCtrls",
            nice_name="Bendy Ctrls",
            attribute_type="long",  # Integer
            min_value=0,
            default_value=0,
            keyable=True,
        )
    @staticmethod
    def remove_from(node: str) -> bool:
        tool.remove_attribute(node, "twistJoints")
        tool.remove_attribute(node, "bendyCtrls")
