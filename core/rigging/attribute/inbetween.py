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

        short_name = tool.get_short_name(node)
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
        """用场景中名为FK_{source_short}_L和FK_{source_short}_R的控制器
        让左侧控制器的X轴平均旋转驱动FKX_{source_short}_L的X轴以及data["parts"]里存储的inbetween骨骼的对应FKOffset_{骨骼名}_R组的X轴旋转"""
        if not self._processed_data:
            return

        data = self._processed_data
        source_target_node = data["target_node"]
        n = data["n"]
        source_parts = data["parts"]  # List of Source Part Joints
        source_short = data["short_name"]
        deform_primary = self.builder.find_deform_node(source_target_node)

        targets_to_process = []  # List of real deform nodes to set up

        if deform_primary and cmds.objExists(deform_primary):
            targets_to_process.append(deform_primary)

            # Check for Mirror (L side)
            if deform_primary.endswith("_R"):
                deform_l = deform_primary.replace("_R", "_L")
                if cmds.objExists(deform_l):
                    targets_to_process.append(deform_l)
            # TODO If _M, no mirror usually.

        if not targets_to_process:
            print(
                f"[Inbetween] Warning: Could not find deform/mirrored nodes for {source_short}"
            )
            return

        for target_node in targets_to_process:

            # Create Math Node
            md_node = cmds.createNode(
                "multiplyDivide", name=f"Inbetween_Div_{target_short}"
            )
            cmds.setAttr(f"{md_node}.operation", 1)  # Multiply
            cmds.connectAttr(f"{target_node}.{driver_attr}X", f"{md_node}.input1X")

            factor = 1.0 / n
            cmds.setAttr(f"{md_node}.input2X", factor)
            cmds.connectAttr(f"{md_node}.outputX", f"{target_node}.rotateX", force=True)

            side_suffix = ""
            if target_node.endswith("_R"):
                side_suffix = "_R"
            elif target_node.endswith("_L"):
                side_suffix = "_L"
            elif target_node.endswith("_M"):
                side_suffix = "_M"

            for source_part in source_parts:
                source_part_short = tool.get_short_name(source_part)
                # If we have node_map, we can try to use it.
                # But node_map key is source short name.
                mapped_primary = self.builder.node_map.get(
                    source_part_short, source_part_short
                )

                # Derive specific side name
                # If mapped_primary is "Hip_Part1_R" and we are processing L side.
                target_part_name = mapped_primary
                if side_suffix == "_L" and mapped_primary.endswith("_R"):
                    target_part_name = mapped_primary.replace("_R", "_L")
                elif side_suffix == "_R" and mapped_primary.endswith(
                    "_L"
                ):  # Rare but possible
                    target_part_name = mapped_primary.replace("_L", "_R")

                # Now find the FK Offset.
                # If FK built successfully, there should be "FKOffset_{PartName}".
                # Part Name is target_part_name (short).
                target_part_short = target_part_name.split("|")[-1]
                fk_offset = f"FKOffset_{target_part_short}"

                if cmds.objExists(fk_offset):
                    # Drive it!
                    cmds.connectAttr(
                        f"{md_node}.outputX", f"{fk_offset}.rotateX", force=True
                    )
                else:
                    # Warn?
                    # If FK skipped it (e.g. if we messed up), this will fail.
                    print(
                        f"  [Inbetween] Warning: FKOffset not found for {target_part_short} ({fk_offset})"
                    )

        print(
            f"  [Inbetween] Setup Redirection (RotX Only) for {source_short} and mirrors."
        )

    @staticmethod
    def add_to(node: str) -> bool:
        attr_name = "inbetween"
        if not cmds.objExists(node):
            return False
        if cmds.attributeQuery(attr_name, node=node, exists=True):
            return True

        try:
            cmds.addAttr(
                node,
                longName=attr_name,
                attributeType="long",
                min=1,
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
        attr_name = "inbetween"
        if not cmds.objExists(node):
            return False
        if cmds.attributeQuery(attr_name, node=node, exists=True):
            return False
        try:
            cmds.deleteAttr(node, attribute=attr_name)
            return True
        except:
            return False
