# core/rigging/attribute/seg_scale_comp.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask


class SegScaleCompAttribute(RigObject):
    SLOTS = ["segScaleComp"]
    """
    Control Segment Scale Compensate on joints.
    """

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        return [
            RigTask(
                priority=self.get_priority("attribute_seg_scale_comp", 30),
                run=self.run_logic,
                name=f"Attribute Logic: SegScaleComp ({self._get_node_name()})",
            )
        ]

    def _get_node_name(self):
        return self.mapping.get("segScaleComp", "Unknown")

    def run_logic(self):
        jnt = self.mapping.get("segScaleComp")
        if not jnt or not cmds.objExists(jnt):
            return

        if cmds.attributeQuery("segScaleComp", node=jnt, exists=True):
            val = cmds.getAttr(f"{jnt}.segScaleComp")
            cmds.setAttr(f"{jnt}.segmentScaleCompensate", val)
            print(
                f"  [SegScaleComp] Link: {jnt}.segScaleComp -> {jnt}.segmentScaleCompensate = {val}"
            )

    @staticmethod
    def add_to(node: str) -> bool:
        attr_name = "segScaleComp"
        if not cmds.objExists(node):
            return False
        if cmds.attributeQuery(attr_name, node=node, exists=True):
            return True

        try:
            cmds.addAttr(
                node,
                longName=attr_name,
                attributeType="bool",
                defaultValue=1,
                keyable=True,
            )
            print(f"[Attribute] Added: {node}.{attr_name}")
            return True
        except Exception as e:
            cmds.warning(f"Failed to add {attr_name}: {e}")
            return False

    @staticmethod
    def remove_from(node: str) -> bool:
        attr_name = "segScaleComp"
        if not cmds.objExists(node):
            return False
        if not cmds.attributeQuery(attr_name, node=node, exists=True):
            return False

        try:
            cmds.deleteAttr(node, attribute=attr_name)
            print(f"[Attribute] Removed: {node}.{attr_name}")
            return True
        except Exception as e:
            cmds.warning(f"Failed to remove {attr_name}: {e}")
            return False
