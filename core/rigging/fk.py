# -*- coding: utf-8 -*-
"""
fk.py
Module for creating and managing FK controls for a Bone hierarchy.

This manager operates on Bone instances provided by the bone.py module.
It creates a standard offset group hierarchy for each control and handles
bones with locked attributes gracefully.
"""

import maya.cmds as cmds
from typing import Optional, List

from core.rigging import bone


class FkCtl(object):
    """Represents a single FK control object.

    This class acts as a data container for an FK control, linking the Maya
    node name back to the Bone instance it drives.

    Attributes:
        name (str): The name of the control curve's transform node in Maya.
        offset_group (str): The name of the parent group used to zero out transforms.
        controlled_bone (bone.Bone): The Bone instance that this control manipulates.
        color_index (Optional[int]): The drawing override color index used.
    """

    def __init__(self, name: str, offset_group: str, controlled_bone: bone.Bone, color_index: Optional[int] = None):
        """Initializes the FkCtl instance."""
        self.name = name
        self.offset_group = offset_group
        self.controlled_bone = controlled_bone
        self.color_index = color_index

    def __repr__(self) -> str:
        """Provides a developer-friendly string representation."""
        return f"FkCtl(name='{self.name}', controls='{self.controlled_bone.name}')"


def add_fk(
        target_bone: bone.Bone,
        radius: float = 1.0,
        color_index: Optional[int] = None
) -> Optional[FkCtl]:
    """Creates an FK control with an offset group for a given Bone instance. (Low-level)

    This function creates the core nodes and constraints for a single bone. It is
    typically called by higher-level functions like add_fk_to_hierarchy.

    Args:
        target_bone: The Bone instance for which to create the control.
        radius: The radius of the NURBS circle control.
        color_index: The drawing override color index for the control.

    Returns:
        The newly created FkCtl instance, or None if creation failed.
    """
    ctrl_name = f"{target_bone.name}_fk_ctrl"
    grp_name = f"grp_{ctrl_name}"

    if cmds.objExists(ctrl_name) or cmds.objExists(grp_name):
        print(f"FK control or its group for '{target_bone.name}' already exists.")
        return None

    # --- 1. Create Hierarchy: Group -> Control ---
    offset_grp = cmds.group(empty=True, name=grp_name)
    ctrl = cmds.circle(name=ctrl_name, normal=(1, 0, 0), radius=radius, constructionHistory=False)[0]
    cmds.parent(ctrl, offset_grp)

    # --- 2. Align the Group to the Bone ---
    cmds.matchTransform(offset_grp, target_bone.name, pos=True, rot=True)

    # Apply color to the visible control shape
    if color_index is not None:
        cmds.setAttr(f"{ctrl}.overrideEnabled", 1)
        cmds.setAttr(f"{ctrl}.overrideColor", color_index)

    # --- MODIFICATION START ---
    # --- Lock and Hide Unused Attributes ---
    # Lock and hide Translate, Scale, and Visibility attributes on the control
    # to provide a cleaner interface for the animator, leaving only Rotate.
    for attr in ['tx', 'ty', 'tz', 'sx', 'sy', 'sz', 'v']:
        cmds.setAttr(f"{ctrl}.{attr}", lock=True, keyable=False, channelBox=False)
    # --- MODIFICATION END ---

    # --- 3. Constrain the Bone to the Control (with lock check) ---
    is_locked = any(cmds.getAttr(f"{target_bone.name}.rotate{axis}", lock=True) for axis in 'XYZ')

    if not is_locked:
        cmds.orientConstraint(ctrl, target_bone.name, maintainOffset=True)
    else:
        print(f"Info: Skipped orient constraint on '{target_bone.name}' because its rotate attributes are locked.")

    # --- 4. Hierarchical Parenting of the Group ---
    if target_bone.parent and target_bone.parent.fk_control:
        parent_ctrl_name = target_bone.parent.fk_control.name
        if cmds.objExists(parent_ctrl_name):
            cmds.parent(offset_grp, parent_ctrl_name)

    # --- 5. Link instances together ---
    fk_instance = FkCtl(
        name=ctrl,
        offset_group=offset_grp,
        controlled_bone=target_bone,
        color_index=color_index
    )
    target_bone.fk_control = fk_instance

    return fk_instance


def add_fk_to_hierarchy(
    bone_manager: bone.BoneManager,
    start_bone: bone.Bone,
    start_radius: float = 2.0,
    radius_decrement: float = 0.2,
    colors: Optional[List[int]] = None
) -> List[FkCtl]:
    """Creates FK controls for a bone and all of its non-leaf descendants.

    This function uses the BoneManager to find the entire hierarchy from the
    start_bone and applies an FK control to each bone in the chain, skipping
    any bone that does not have children (a "leaf" bone).

    Args:
        bone_manager: An initialized BoneManager instance that has scanned the scene.
        start_bone: The first Bone instance in the chain to receive an FK control.
        start_radius: The radius of the first control in the chain.
        radius_decrement: Amount to shrink the radius for each subsequent control.
        colors: A list of color indices to cycle through for the controls.

    Returns:
        A list of all the FkCtl instances that were successfully created.
    """
    if colors is None:
        colors = [17, 13, 6, 18, 20]  # Default: Yellow, Red, Blue, Cyan, Green

    chain = bone_manager.find_bone_hierarchy(start_bone)
    created_controls = []

    print(f"--- Creating FK hierarchy for chain starting at '{start_bone.name}' ---")
    for i, bone_in_chain in enumerate(chain):
        # --- MODIFICATION START ---
        # Check if the current bone has no children (is a leaf bone)
        if not bone_in_chain.children:
            print(f"Info: Skipping FK on leaf bone '{bone_in_chain.name}'.")
            continue  # Skip to the next bone in the chain
        # --- MODIFICATION END ---

        current_radius = max(0.1, start_radius - (i * radius_decrement))
        current_color = colors[i % len(colors)]  # Cycle through colors

        print(f"Creating FK for: {bone_in_chain.name}")
        fk_instance = add_fk(
            target_bone=bone_in_chain,
            radius=current_radius,
            color_index=current_color
        )
        if fk_instance:
            created_controls.append(fk_instance)

    return created_controls


### --- 测试代码 / Example Usage --- ###
def run_fk_creation_test():
    """
    Tests the high-level FK creation process on an existing joint chain.
    ASSUMES a joint chain already exists in the scene.
    """
    cmds.joint(n='L_arm_shoulder_jnt', p=(2, 15, 0))
    cmds.joint(n='L_arm_elbow_jnt', p=(6, 15, 1))
    cmds.joint(n='L_arm_wrist_jnt', p=(10, 15, 0))

    print("--- 1. INITIALIZING BONE MANAGER AND SCANNING SCENE ---")
    manager = bone.BoneManager()
    manager.scan_scene()

    if not manager.root_bones:
        print("Test failed: No root bones found in the scene.")
        return

    # Use the first root bone found as the starting point for the rig
    root_bone = manager.root_bones[0]
    print(f"Found root bone: '{root_bone.name}'. This will be the start of the FK chain.")

    print("\n--- 2. CREATING FK HIERARCHY WITH A SINGLE COMMAND ---")
    add_fk_to_hierarchy(manager, root_bone)

    print("\n--- 3. VERIFICATION ---")
    # We can re-fetch the hierarchy to verify the .fk_control attribute was set
    chain_to_verify = manager.find_bone_hierarchy(root_bone)
    for bone_in_chain in chain_to_verify:
        print(f"Bone: {bone_in_chain.name}, Has FK Control: {bone_in_chain.fk_control is not None}")
        if bone_in_chain.fk_control:
            is_linked_correctly = bone_in_chain.fk_control.controlled_bone is bone_in_chain
            print(f"  -> FK Control: {bone_in_chain.fk_control.name}")
            print(f"  -> Offset Group: {bone_in_chain.fk_control.offset_group}")
            print(f"  -> Control correctly linked back to bone: {is_linked_correctly}")

    print("\nTest complete. Check Outliner for the 'grp_...' hierarchy and viewport for colors.")