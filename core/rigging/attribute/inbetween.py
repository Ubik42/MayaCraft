# core/rigging/attribute/inbetween.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.api.OpenMaya as om
import math
from core.rigging.base import RigObject, RigTask
from core import tool


class InbetweenAttribute(RigObject):
    SLOTS = ["inbetweenJoints", "unTwister"]
    """
    Splits a joint into multiple segments and distributes FK rotation.
    Segments are created in local space along the X-axis of the parent.
    Rotation drive:
      - If unTwister is OFF: Restricted to Rotate X.
      - If unTwister is ON:  Applies to Rotate X, Y, Z.
    """

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data
        self._processed_data = None

    def create_tasks(self, builder) -> list[RigTask]:
        node_name = self.mapping.get("inbetweenJoints", "Unknown")
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
        # 1. Get Node
        node = self.mapping.get("inbetweenJoints")
        if not node:
            node = self.mapping.get("inbetween")

        if not node or not cmds.objExists(node):
            return

        # 2. Get Attribute
        attr_name = "inbetweenJoints"
        if not cmds.attributeQuery(attr_name, node=node, exists=True):
            attr_name = "inbetween"
            if not cmds.attributeQuery(attr_name, node=node, exists=True):
                return

        # 3. Get Segment Count
        n_segments = cmds.getAttr(f"{node}.{attr_name}")
        if n_segments <= 1:
            return

        short_name = tool.get_short_name(node)

        # 4. Check Children
        children = cmds.listRelatives(node, children=True, type="joint", fullPath=True)
        if not children:
            print(f"[Inbetween] Warning: {node} has no joint children, cannot split.")
            return

        child_node = children[0]

        # 5. Calculate Local Direction (Fix for Mirror/Negative Scale)
        # Use Matrix math to get the child's position in parent's local space
        parent_world_matrix = om.MMatrix(cmds.getAttr(f"{node}.worldMatrix[0]"))
        parent_inverse_matrix = parent_world_matrix.inverse()
        child_world_pos = om.MPoint(cmds.xform(child_node, q=True, t=True, ws=True))

        # Transform world pos to local pos
        child_local_pos = child_world_pos * parent_inverse_matrix

        # Calculate step vector (Assuming X-Axis aim)
        step_x = child_local_pos.x / n_segments

        parts = []
        current_parent = node

        # Unparent child temporarily (Update variable with new path)
        if cmds.listRelatives(child_node, parent=True):
            result = cmds.parent(child_node, world=True)
            if result:
                child_node = result[0]

        # 6. Create Segments
        for i in range(1, n_segments):
            part_name = f"{short_name}_Part{i}"

            if cmds.objExists(part_name):
                part_joint = part_name
                # Ensure hierarchy is correct if re-running
                curr_p_check = cmds.listRelatives(part_name, parent=True)
                if not curr_p_check or tool.get_short_name(curr_p_check[0]) != tool.get_short_name(current_parent):
                    try:
                        cmds.parent(part_joint, current_parent)
                    except:
                        pass
            else:
                cmds.select(clear=True)
                part_joint = cmds.joint(name=part_name)
                cmds.parent(part_joint, current_parent)

                # Zero out orientation/rotation
                cmds.setAttr(f"{part_joint}.jointOrient", 0, 0, 0, type="double3")
                cmds.setAttr(f"{part_joint}.rotate", 0, 0, 0, type="double3")

                # Set Translation with correct direction
                cmds.setAttr(f"{part_joint}.translate", step_x, 0, 0, type="double3")

            parts.append(part_joint)
            current_parent = part_joint

        # 7. Re-parent original child
        try:
            cmds.parent(child_node, current_parent)
        except Exception as e:
            print(f"[Inbetween] Warning re-parenting child: {e}")

        self._processed_data = {
            "n": n_segments,
            "parts": parts,
            "short_name": short_name,
            "target_node": node,
        }
        print(f"[Inbetween] Split {short_name} into {n_segments} segments.")

    def run_post_process(self):
        """
        Setup connections based on naming conventions.
        Driver: FK_{source_short}.rotate
        Driven: FKX_{source_short}.rotate, FKOffset_{part}.rotate
        """
        if not self._processed_data:
            return

        data = self._processed_data
        n = data["n"]
        source_parts = data["parts"]
        source_short = data["short_name"]
        target_node = data["target_node"]

        # 1. Find Driver Controller
        fk_ctrl = f"FK_{source_short}"

        if not cmds.objExists(fk_ctrl):
            # Only warn if it's likely a user error, otherwise silent skip
            return

        # 2. Check unTwister Mode
        un_twister = False
        if cmds.attributeQuery("unTwister", node=target_node, exists=True):
            un_twister = cmds.getAttr(f"{target_node}.unTwister")

        axes_to_connect = ["X"]
        if un_twister:
            axes_to_connect = ["X", "Y", "Z"]

        # 3. Create Math Node
        md_node_name = f"Inbetween_Div_{source_short}"
        if not cmds.objExists(md_node_name):
            md_node = cmds.createNode("multiplyDivide", name=md_node_name)
        else:
            md_node = md_node_name

        cmds.setAttr(f"{md_node}.operation", 1)  # Multiply

        # 4. Connect Inputs
        factor = 1.0 / n
        for axis in axes_to_connect:
            cmds.setAttr(f"{md_node}.input2{axis}", factor)
            cmds.connectAttr(f"{fk_ctrl}.rotate{axis}", f"{md_node}.input1{axis}", force=True)

        # 5. Drive Main FKX Bone
        fkx_bone = f"FKX_{source_short}"
        if cmds.objExists(fkx_bone):
            for axis in axes_to_connect:
                cmds.connectAttr(f"{md_node}.output{axis}", f"{fkx_bone}.rotate{axis}", force=True)
        else:
            print(f"[Inbetween] Warning: Target bone {fkx_bone} not found.")

        # 6. Drive Segment Offsets
        for part in source_parts:
            part_short = tool.get_short_name(part)
            fk_offset_grp = f"FKOffset_{part_short}"

            if cmds.objExists(fk_offset_grp):
                for axis in axes_to_connect:
                    cmds.connectAttr(f"{md_node}.output{axis}", f"{fk_offset_grp}.rotate{axis}", force=True)
            else:
                print(f"[Inbetween] Warning: Offset group {fk_offset_grp} not found.")

        mode_str = "XYZ" if un_twister else "X Only"
        print(f"[Inbetween] Setup Redirection ({mode_str}) for {source_short}.")

    @staticmethod
    def add_to(node: str) -> bool:
        tool.add_attribute(
            node,
            long_name="inbetweenJoints",
            nice_name="Inbetween Joints",
            attribute_type="long",
            min_value=1,
            default_value=2,
            keyable=True,
        )
        tool.add_attribute(
            node,
            long_name="unTwister",
            nice_name="unTwister",
            attribute_type="bool",
            default_value=0,
            keyable=True,
        )
        return True

    @staticmethod
    def remove_from(node: str) -> bool:
        success = True
        if not tool.remove_attribute(node, "inbetweenJoints"):
            success = False
        if not tool.remove_attribute(node, "unTwister"):
            success = False
        return success