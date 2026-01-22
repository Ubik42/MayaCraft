# core/rigging/attribute/twist_bendy.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask


class TwistBendyAttribute(RigObject):
    SLOTS = ["twist", "bendy"]

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
        # We can handle logic for both if they exist on the same node
        # The mapping key usually corresponds to the attribute name found in SLOTS
        # If this class is instantiated, it means one of the slots matched.

        # Typically, the node is the same for both if they are on the same joint.
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

        # print(f"[TwistBendy] Processing {node}: Twist={twist_val}, Bendy={bendy_val}")

        # Placeholder logic implementation
        pass

    @staticmethod
    def add_to(node: str) -> bool:
        if not cmds.objExists(node):
            return False

        success = True

        # Add Twist Joints
        attr_twist = "twist"
        if not cmds.attributeQuery(attr_twist, node=node, exists=True):
            try:
                cmds.addAttr(
                    node,
                    longName=attr_twist,
                    niceName="Twist Joints",
                    attributeType="long",  # Integer for count
                    min=0,
                    defaultValue=0,
                    keyable=True,
                )
                print(f"[Attribute] Added: {node}.{attr_twist} (Twist Joints)")
            except Exception as e:
                cmds.warning(f"Failed to add twist: {e}")
                success = False
        else:
            # If exists, maybe update niceName? typically not needed if existing
            pass

        # Add Bendy Ctrls
        attr_bendy = "bendy"
        if not cmds.attributeQuery(attr_bendy, node=node, exists=True):
            try:
                cmds.addAttr(
                    node,
                    longName=attr_bendy,
                    niceName="Bendy Ctrls",
                    attributeType="long",  # Integer for count/enum logic
                    min=0,
                    defaultValue=0,
                    keyable=True,
                )
                print(f"[Attribute] Added: {node}.{attr_bendy} (Bendy Ctrls)")
            except Exception as e:
                cmds.warning(f"Failed to add bendy: {e}")
                success = False

        return success

    @staticmethod
    def remove_from(node: str) -> bool:
        if not cmds.objExists(node):
            return False

        success = True
        for attr in ["twist", "bendy"]:
            if cmds.attributeQuery(attr, node=node, exists=True):
                try:
                    cmds.deleteAttr(node, attribute=attr)
                    print(f"[Attribute] Removed: {node}.{attr}")
                except Exception as e:
                    cmds.warning(f"Failed to remove {attr}: {e}")
                    success = False
        return success
