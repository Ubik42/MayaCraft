# core/rigging/attribute/inbetween.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
import math
from core.rigging.base import RigObject, RigTask
from core import tool


class InbetweenAttribute(RigObject):
    SLOTS = ["inbetween"]
    """
    Splits a joint into multiple segments and distributes FK rotation.
    Segments are created in local space along the X-axis of the parent.
    Rotation drive is restricted to Rotate X.
    """

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data
        self._processed_data = None  # Store specific data for this instance

    def create_tasks(self, builder) -> list[RigTask]:
        node_name = self.mapping.get("inbetween", "Unknown")
        return [
            RigTask(
                priority=self.get_priority("attribute_inbetween_process", 6),
                run=self.run_process_nodes,
                name=f"Attribute Process: Inbetween ({node_name})",
            ),
            RigTask(
                priority=self.get_priority("attribute_inbetween_post", 190),
                run=self.run_post_process,
                name=f"Attribute Post: Inbetween ({node_name})",
            ),
        ]

    def run_process_nodes(self):
        """Split joints along the vector length (X-axis relative)."""
        node = self.mapping.get("inbetween")
        short_name = tool.get_short_name(node)

        if not node or not cmds.objExists(node):
            return

        if not cmds.attributeQuery("inbetween", node=node, exists=True):
            return

        n_segments = cmds.getAttr(f"{node}.inbetween")
        if n_segments <= 1:
            return

        # Check children
        children = cmds.listRelatives(node, children=True, type="joint", fullPath=True)
        if not children:
            print(f"[Inbetween] Warning: {node} has no joint children, cannot split.")
            return

        child_node = children[0]

        # Calculate Distance (Length)
        # TODO 要求之前骨骼有批量朝向子骨骼过
        p_start = cmds.xform(node, q=True, t=True, ws=True)
        p_end = cmds.xform(child_node, q=True, t=True, ws=True)

        dist = math.sqrt(sum([(e - s) ** 2 for s, e in zip(p_start, p_end)]))
        seg_len = dist / n_segments

        parts = []
        current_parent = node

        for i in range(1, n_segments):
            part_name = f"{short_name}_Part{i}"
            cmds.select(clear=True)
            part_joint = cmds.joint(name=part_name)

            # Parent first to inherit frame
            cmds.parent(part_joint, current_parent)

            # Zero out orientation/rotation to align perfectly with parent X-axis
            cmds.setAttr(f"{part_joint}.jointOrient", 0, 0, 0, type="double3")
            cmds.setAttr(f"{part_joint}.rotate", 0, 0, 0, type="double3")

            # Set Translation: Only X has value (Segment Length)
            cmds.setAttr(f"{part_joint}.translate", seg_len, 0, 0, type="double3")

            # NO isInbetweenPart attribute! Treat as normal bone.

            parts.append(part_joint)
            current_parent = part_joint

        cmds.parent(child_node, current_parent)

        self._processed_data = {
            "n": n_segments,
            "parts": parts,  # Source Parts
            "short_name": short_name,  # Source Short Name
            "target_node": node,  # Source Node
        }
        print(
            f"[Inbetween] Split {short_name} into {n_segments} segments along local X."
        )

    def run_post_process(self):
        """
        基于严格命名规则连接属性 (无侧边推断逻辑)：
        Driver: FK_{source_short}.rotateX
        Driven: FKX_{source_short}.rotateX, FKOffset_{part_short}.rotateX
        """
        if not self._processed_data:
            return

        data = self._processed_data
        n = data["n"]
        source_parts = data["parts"]
        source_short = data["short_name"]  # 假定此处已包含侧边，如 "Hip_L"

        # 1. 查找驱动控制器
        fk_ctrl = f"FK_{source_short}"

        if not cmds.objExists(fk_ctrl):
            print(f"[Inbetween] Warning: Driver Controller {fk_ctrl} not found.")
            return

        # 2. 创建平均值计算节点
        md_node = cmds.createNode(
            "multiplyDivide", name=f"Inbetween_Div_{source_short}"
        )
        cmds.setAttr(f"{md_node}.operation", 1)  # Multiply
        cmds.setAttr(f"{md_node}.input2X", 1.0 / n)  # 平均系数

        # 连接控制器输入
        cmds.connectAttr(f"{fk_ctrl}.rotateX", f"{md_node}.input1X", force=True)

        # 3. 驱动主 FKX 骨骼
        fkx_bone = f"FKX_{source_short}"
        if cmds.objExists(fkx_bone):
            cmds.connectAttr(f"{md_node}.outputX", f"{fkx_bone}.rotateX", force=True)
        else:
            print(f"[Inbetween] Warning: Target {fkx_bone} not found.")

        # 4. 驱动分段骨骼的 Offset 组
        for part in source_parts:
            part_short = tool.get_short_name(part)  # e.g. "Hip_L_Part1"
            fk_offset_grp = f"FKOffset_{part_short}"

            if cmds.objExists(fk_offset_grp):
                cmds.connectAttr(
                    f"{md_node}.outputX", f"{fk_offset_grp}.rotateX", force=True
                )
            else:
                print(f"[Inbetween] Warning: Offset {fk_offset_grp} not found.")

        print(f"[Inbetween] Setup Redirection (RotX Only) for {source_short}.")

    @staticmethod
    def add_to(node: str) -> bool:
        return tool.add_attribute(
            node,
            long_name="inbetween joints",
            attribute_type="long",
            min_value=1,
            default_value=1,
            keyable=True,
        )
        return tool.add_attribute(
            node,
            long_name="unTwister",
            attribute_type="bool",
            default_value=0,
            keyable=True,
        )

    @staticmethod
    def remove_from(node: str) -> bool:
        return tool.remove_attribute(node, "inbetween joints")
        return tool.remove_attribute(node, "unTwister")
