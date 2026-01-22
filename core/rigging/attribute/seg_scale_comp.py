# core/rigging/attribute/seg_scale_comp.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask
from core import tool


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
        tool.add_attribute(
            node,
            long_name="segScaleComp",
            attribute_type="bool",
            default_value=1,
            keyable=True,
        )

    @staticmethod
    def remove_from(node: str) -> bool:
        tool.remove_attribute(node, "segScaleComp")
