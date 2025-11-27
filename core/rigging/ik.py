# -*- coding: utf-8 -*-
"""
ik.py
Module for creating and managing IK systems for a Bone hierarchy.

This manager operates on Bone instances provided by the bone.py module to
create IK handles, user-facing controls, and pole vectors.
"""

import maya.cmds as cmds
from typing import Optional, List, Literal

from core.rigging import bone


class IkCtl(object):
    """Represents a single IK control system.

    This class is a data container for all Maya nodes and data associated with
    one IK setup (e.g., a leg IK).

    Attributes:
        name (str): The name of the IK Handle node in Maya.
        ik_type (Literal['ikRPsolver', 'ikSCsolver']): The solver type used.
        start_bone (bone.Bone): The start Bone instance of the IK chain.
        end_bone (bone.Bone): The end Bone instance of the IK chain (effector).
        control_curve (str): The name of the main IK control curve.
        pole_vector_control (Optional[str]): The name of the pole vector control.
        pole_vector_indicator (Optional[str]): The name of the annotation node
            used as a visual guide for the pole vector.
        color_index (Optional[int]): The drawing override color for the controls.
    """

    def __init__(
            self,
            name: str,
            ik_type: Literal['ikRPsolver', 'ikSCsolver'],
            start_bone: bone.Bone,
            end_bone: bone.Bone,
            control_curve: str,
            pole_vector_control: Optional[str] = None,
            pole_vector_indicator: Optional[str] = None,
            color_index: Optional[int] = None
    ):
        """Initializes the IkCtl instance."""
        self.name = name
        self.ik_type = ik_type
        self.start_bone = start_bone
        self.end_bone = end_bone
        self.control_curve = control_curve
        self.pole_vector_control = pole_vector_control
        self.pole_vector_indicator = pole_vector_indicator
        self.color_index = color_index

    def __repr__(self) -> str:
        """Provides a developer-friendly string representation."""
        return (f"IkCtl(name='{self.name}', type='{self.ik_type}', "
                f"chain='{self.start_bone.name}' -> '{self.end_bone.name}')")


def add_ik(
        ik_type: Literal['RP', 'SC'],
        start_bone: bone.Bone,
        end_bone: bone.Bone,
        color_index: Optional[int] = None
) -> Optional[IkCtl]:
    """Creates an IK system between two Bone instances."""
    solver_map = {'RP': 'ikRPsolver', 'SC': 'ikSCsolver'}
    solver = solver_map.get(ik_type)
    if not solver:
        cmds.warning(f"Invalid ik_type '{ik_type}'. Use 'RP' or 'SC'.")
        return None

    handle_name = f"{end_bone.name}_ikHandle"
    if cmds.objExists(handle_name):
        cmds.warning(f"IK handle '{handle_name}' already exists.")
        return None

    ik_handle, effector = cmds.ikHandle(
        name=handle_name,
        startJoint=start_bone.name,
        endEffector=end_bone.name,
        solver=solver
    )
    effector = cmds.rename(effector, f"{end_bone.name}_effector")

    ctrl_name = f"{end_bone.name}_ik_ctrl"
    ctrl = cmds.circle(name=ctrl_name, normal=(0, 1, 0), radius=2.0, ch=False)[0]
    ctrl_grp = cmds.group(empty=True, name=f"{ctrl_name}_grp")

    cmds.matchTransform(ctrl_grp, end_bone.name, pos=True, rot=True)
    cmds.matchTransform(ctrl, ctrl_grp, pos=True, rot=True)

    cmds.parent(ctrl, ctrl_grp)
    cmds.parent(ik_handle, ctrl)
    cmds.setAttr(f"{ik_handle}.visibility", False)

    for attr in ['sx', 'sy', 'sz', 'v']:
        cmds.setAttr(f"{ctrl}.{attr}",keyable=False, channelBox=False)

    pv_ctrl_name = None
    indicator_name = None
    if ik_type == 'RP':
        # 1. Create a geometric shape for the Pole Vector control
        pv_ctrl_name = f"{start_bone.name}_pv_ctrl"
        pv_ctrl = cmds.curve(
            name=pv_ctrl_name,
            d=1,
            p=[(0, 1, 0), (0, 0, 1), (0, -1, 0), (0, 0, -1), (0, 1, 0), (1, 0, 0), (-1, 0, 0), (0, -1, 0), (1, 0, 0),
               (0, 0, -1), (-1, 0, 0), (0, 0, 1), (0, 1, 0)]
        )
        cmds.setAttr(f"{pv_ctrl}.scale", 0.5, 0.5, 0.5)
        cmds.makeIdentity(pv_ctrl, apply=True, s=1)

        pv_pos = _calculate_pole_vector_position(start_bone, end_bone)
        cmds.xform(pv_ctrl, translation=pv_pos, worldSpace=True)

        # --- BUG FIX APPLIED HERE ---
        # 2. Create annotation and correctly get its TRANSFORM node
        # cmds.annotate returns the SHAPE node name
        annotation_shape = cmds.annotate(pv_ctrl, text=" ", point=(0, 0, 0))
        # We need to get the parent TRANSFORM of that shape to constrain it
        annotation_transform = cmds.listRelatives(annotation_shape, parent=True)[0]
        indicator_name = cmds.rename(annotation_transform, f"{start_bone.name}_pv_indicator")

        # This parenting order is from your provided code
        cmds.parent(indicator_name, pv_ctrl)
        cmds.parent(pv_ctrl, ctrl)

        # 3. Constrain the annotation's transform node to the IK handle.
        cmds.pointConstraint(ik_handle, indicator_name, maintainOffset=False)

        # 4. Finalize pole vector constraint
        cmds.poleVectorConstraint(pv_ctrl, ik_handle)

        # 5. Clean up attributes and visibility
        cmds.setAttr(f"{indicator_name}.overrideEnabled", 1)
        cmds.setAttr(f"{indicator_name}.overrideDisplayType", 2)  # Reference (unselectable)
        for attr in ['rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']:
            cmds.setAttr(f"{pv_ctrl}.{attr}", keyable=False, channelBox=False)

    if color_index is not None:
        cmds.setAttr(f"{ctrl}.overrideEnabled", 1)
        cmds.setAttr(f"{ctrl}.overrideColor", color_index)
        if pv_ctrl_name:
            cmds.setAttr(f"{pv_ctrl_name}.overrideEnabled", 1)
            cmds.setAttr(f"{pv_ctrl_name}.overrideColor", color_index)

    ik_instance = IkCtl(
        name=ik_handle,
        ik_type=solver,
        start_bone=start_bone,
        end_bone=end_bone,
        control_curve=ctrl,
        pole_vector_control=pv_ctrl_name,
        pole_vector_indicator=indicator_name,
        color_index=color_index
    )

    chain = []
    current_bone = end_bone
    while current_bone and current_bone is not start_bone.parent:
        chain.append(current_bone)
        if current_bone is start_bone:
            break
        current_bone = current_bone.parent
    chain.reverse()

    for i, bone_in_chain in enumerate(chain):
        bone_in_chain.ik_handles.append((ik_instance, i))

    return ik_instance


#暂时使用极为简单的算法
def _calculate_pole_vector_position(start_bone: bone.Bone, end_bone: bone.Bone) -> List[float]:
    """Returns the world space position of the end_bone's parent."""
    if not end_bone.parent:
        start_pos = cmds.xform(start_bone.name, q=True, ws=True, t=True)
        return [start_pos[0], start_pos[1] + 10, start_pos[2]]

    return cmds.xform(end_bone.parent.name, q=True, ws=True, t=True)


### --- 测试代码 / Example Usage --- ###
def run_ik_creation_test():
    """
    Tests the IK creation by automatically finding all valid limb chains in
    the scene and applying an IK rig to them.

    A valid limb is defined as a root joint that has a clear, un-branched
    path to an end effector (e.g., shoulder to wrist).
    """
    cmds.file(new=True, force=True)
    # Create two sample limbs to test on
    # Limb 1: Arm
    cmds.select(cl=True)
    cmds.joint(n='L_shoulder_jnt', p=(2, 15, 0))
    cmds.joint(n='L_elbow_jnt', p=(6, 15, 1))
    cmds.joint(n='L_wrist_jnt', p=(10, 15, 0))
    # Add fingers to test branching logic
    cmds.select('L_wrist_jnt')
    cmds.joint(n='L_middle_finger_01_jnt', p=(11, 15, 0))
    cmds.select('L_wrist_jnt')
    cmds.joint(n='L_thumb_01_jnt', p=(10.5, 14.5, 0))

    # Limb 2: Leg
    cmds.select(cl=True)
    cmds.joint(n='R_hip_jnt', p=(-2, 12, 0))
    cmds.joint(n='R_knee_jnt', p=(-2, 7, -1))
    cmds.joint(n='R_ankle_jnt', p=(-2, 2, 0))

    print("--- 1. SCANNING SCENE ---")
    manager = bone.BoneManager()
    manager.scan_scene()

    if not manager.root_bones:
        print("No root bones found in the scene.")
        return

    print(f"Found {len(manager.root_bones)} root bone(s): {[b.name for b in manager.root_bones]}")

    print("\n--- 2. AUTOMATICALLY CREATING IK FOR ALL LIMBS ---")
    for root_bone in manager.root_bones:
        print(f"\nProcessing chain starting from '{root_bone.name}'...")

        # Automatically find the end of the main limb
        end_bone = manager.find_end_of_chain(root_bone)

        if not end_bone:
            print(f"  -> Could not find a valid un-branched chain from '{root_bone.name}'. Skipping.")
            continue

        # Ensure we have at least one joint between start and end for a valid IK
        if end_bone is root_bone or end_bone.parent is root_bone:
            print(f"  -> Chain from '{root_bone.name}' to '{end_bone.name}' is too short for an RP IK. Skipping.")
            continue

        print(f"  -> Found valid chain: '{root_bone.name}' -> '{end_bone.name}'")
        add_ik(ik_type='RP', start_bone=root_bone, end_bone=end_bone, color_index=18)

    print("\nTest complete. Check the scene for IK rigs on the arm and leg.")