# -*- coding: utf-8 -*-
"""
bone.py
Module for representing and managing joint hierarchies in a Maya scene.

This module provides:
- Bone: A pure data class representing a single joint and its relationships.
- BoneManager: A class to scan the Maya scene, build a hierarchy of Bone
  objects, and perform queries on that hierarchy.
"""

import maya.cmds as cmds
from typing import List, Tuple, Optional, Dict, TYPE_CHECKING
from .label import label_manager

# Use TYPE_CHECKING to avoid circular import_widget errors at runtime,
# while still allowing type hints for IDEs and static analysis.
if TYPE_CHECKING:
    # Assuming these files are in core.rigging relative to your project root
    from core.rigging.fk import FkCtl
    from core.rigging.ik import IkCtl


class Bone(object):
    """A representation of a Maya joint node within its hierarchy.

    This is a data-only class. Scene interaction and hierarchy building are
    handled by the BoneManager.

    Attributes:
        name (str): The name of the joint transform node.
        type (str): The type label of the joint.
        rotation (Tuple[float, float, float]): The world space rotation.
        joint_axis (Tuple[float, float, float]): The joint orient values.
        parent (Optional[Bone]): Reference to the parent Bone instance.
        children (List[Bone]): List of references to child Bone instances.
        fk_control (Optional['FkCtl']): Instance of the associated FK control.
        ik_handles (List[Tuple['IkCtl', int]]): List of associated IK controls.
    """

    def __init__(
            self,
            name: str,
            type: str,
            rotation: Tuple[float, float, float],
            joint_axis: Tuple[float, float, float]
    ):
        """Initializes the Bone instance."""
        self.name = name
        self.type = type
        self.rotation = rotation
        self.joint_axis = joint_axis

        # Relational attributes, populated by BoneManager
        self.parent: Optional[Bone] = None
        self.children: List[Bone] = []

        # Associated controls (to be populated by other managers)
        self.fk_control: Optional['FkCtl'] = None
        self.ik_handles: List[Tuple['IkCtl', int]] = []

    def __repr__(self) -> str:
        """Provides a developer-friendly string representation."""
        parent_name = self.parent.name if self.parent else None
        return (
            f"Bone(name='{self.name}', parent='{parent_name}', "
            f"children={len(self.children)})"
        )

class BoneManager(object):
    """Manages the collection and querying of Bone objects from a Maya scene."""

    def __init__(self):
        """Initializes the BoneManager."""
        self.all_bones: List[Bone] = []
        self.bone_map: Dict[str, Bone] = {}
        self.root_bones: List[Bone] = []

    def scan_scene(self) -> List[Bone]:
        """Scans the scene for all joints and builds a linked hierarchy of Bone objects."""

        # 清空旧数据
        self.all_bones = []
        self.bone_map = {}
        self.root_bones = []

        all_joints_in_scene = cmds.ls(type='joint', long=True)
        if not all_joints_in_scene:
            return []

        # Pass 1: 创建 Bone 实例
        for joint_name in all_joints_in_scene:
            rot = cmds.getAttr(f"{joint_name}.rotate")[0]
            joint_orient = cmds.getAttr(f"{joint_name}.jointOrient")[0]
            self.bone_map[joint_name] = Bone(name=joint_name, type="", rotation=rot, joint_axis=joint_orient)

        # Pass 2: 链接层级关系并填充骨骼类型
        for joint_name, bone_instance in self.bone_map.items():
            # 填充 bone_type (label)
            # 我们不再需要自己计算，而是可以从 label_manager 反向查询
            label = "unknown"
            for lbl, path in label_manager.get_all().items():
                if path == joint_name:
                    label = lbl
                    break
            bone_instance.type = label

            # ... (链接父级和子级的代码保持不变) ...

        self.all_bones = list(self.bone_map.values())
        return self.all_bones

    def find_bone_hierarchy(self, start_bone: Bone) -> List[Bone]:
        """Returns a list containing the start_bone and all its descendants.

        The traversal is done depth-first.

        Args:
            start_bone: The Bone instance from which to start the traversal.

        Returns:
            A list of Bone instances representing the full hierarchy branch.
        """
        hierarchy = []
        self._traverse_hierarchy(start_bone, hierarchy)
        return hierarchy

    def _traverse_hierarchy(self, current_bone: Bone, hierarchy_list: List[Bone]):
        """A recursive helper function to perform depth-first traversal."""
        hierarchy_list.append(current_bone)
        for child in current_bone.children:
            self._traverse_hierarchy(child, hierarchy_list)

    def find_end_of_chain(self, start_bone: Bone) -> Optional[Bone]:
        """Finds the last bone in a single-child chain starting from start_bone.

        This is useful for automatically identifying the end of a limb like a
        wrist or ankle, before it branches into fingers or toes.

        Args:
            start_bone: The Bone instance to start the search from.

        Returns:
            The last Bone in the un-branched chain, or None if the start_bone
            itself has multiple children or no children.
        """
        current_bone = start_bone
        # Traverse down as long as there is exactly one child
        while len(current_bone.children) == 1:
            current_bone = current_bone.children[0]

        # If we never moved, it means the start_bone was not a valid start
        if current_bone is start_bone:
            # Check if it's a leaf bone (end of a single-bone chain)
            if not start_bone.children:
                return start_bone
            return None  # Not a valid chain start

        return current_bone




### --- 测试代码 / Example Usage --- ###
def run_bone_manager_test():
    """
    Tests the BoneManager class on an existing joint chain in the scene.
    ASSUMES a joint chain already exists.
    """
    # 1. Create a manager and scan the scene
    print("--- 1. INITIALIZING MANAGER AND SCANNING SCENE ---")
    manager = BoneManager()
    manager.scan_scene()

    if not manager.root_bones:
        print("Test failed: No root bones were found in the scene.")
        return

    # 2. Get the first root bone found
    root = manager.root_bones[0]
    print(f"Found root bone: {root.name}")

    # 3. Find the entire hierarchy starting from the root
    print(f"\n--- 2. FINDING HIERARCHY FOR '{root.name}' ---")
    full_chain = manager.find_bone_hierarchy(root)

    print(f"Hierarchy contains {len(full_chain)} bones:")
    for bone_in_chain in full_chain:
        print(f"  - {bone_in_chain.name} (Parent: {bone_in_chain.parent.name if bone_in_chain.parent else 'None'})")

    # 4. Example of finding a specific bone from the manager
    print("\n--- 3. FINDING A SPECIFIC BONE ---")
    # Let's try to find a bone that might exist in the chain
    knee_bone = None
    for name in manager.bone_map.keys():
        if 'knee' in name.lower():
            knee_bone = manager.bone_map[name]
            break

    if knee_bone:
        print(f"Found knee bone: '{knee_bone.name}'")
        knee_hierarchy = manager.find_bone_hierarchy(knee_bone)
        print(f"Hierarchy from knee downwards contains {len(knee_hierarchy)} bones.")
        print([b.name for b in knee_hierarchy])
    else:
        print("Could not find a 'knee' bone to test with.")

    print("\nTest complete.")