# -*- coding: utf-8 -*-
"""
bone.py
Module for representing and managing joint hierarchies in a Maya scene.
Simplified version: Assumes Unique Short Names in the scene.
"""

import maya.cmds as cmds
from typing import List, Tuple, Optional, Dict, TYPE_CHECKING
from .label import label_manager

if TYPE_CHECKING:
    from core.rigging.fk import FkCtl
    from core.rigging.ik import IkCtl


class Bone(object):
    """
    数据类：表示单个骨骼节点及其关系。

    注意：在当前架构下，self.name 存储的是唯一的短名称 (Short Name)。
    """

    def __init__(
            self,
            name: str,
            type: str,
            rotation: Tuple[float, float, float],
            joint_axis: Tuple[float, float, float]
    ):
        self.name = name  # 存储短名 (e.g., "joint1")
        self.type = type
        self.rotation = rotation
        self.joint_axis = joint_axis

        self.parent: Optional[Bone] = None
        self.children: List[Bone] = []

        self.fk_control: Optional['FkCtl'] = None
        self.ik_handles: List[Tuple['IkCtl', int]] = []

    def __repr__(self) -> str:
        parent_name = self.parent.name if self.parent else None
        return (
            f"Bone(name='{self.name}', parent='{parent_name}', "
            f"children={len(self.children)})"
        )


class BoneManager(object):
    """
    管理 Maya 场景中 Bone 对象的扫描、构建和查询。
    基于唯一短名 (Unique Short Name) 假设。
    """

    def __init__(self):
        self.all_bones: List[Bone] = []
        self.bone_map: Dict[str, Bone] = {}  # Key: 短名 (Unique)
        self.root_bones: List[Bone] = []

    def get_bone(self, name: str) -> Optional[Bone]:
        """
        根据名称获取 Bone 对象。
        因为保证了短名唯一，直接查字典即可。
        """
        if not name:
            return None

        # 即使传入的是长路径，也只取短名进行查找
        short_name = name.split("|")[-1]
        return self.bone_map.get(short_name)

    def scan_scene(self) -> List[Bone]:
        """扫描场景并构建 Bone 层级网络。"""

        # 重置数据
        self.all_bones = []
        self.bone_map = {}
        self.root_bones = []

        # 虽然我们存的是短名，但在 Maya 内部查询属性时，使用长路径更安全
        all_joints_long = cmds.ls(type='joint', long=True)
        if not all_joints_long:
            return []

        # Pass 1: 创建对象 (Key 使用短名)
        for long_name in all_joints_long:
            short_name = long_name.split("|")[-1]

            # 获取属性
            try:
                rot = tuple(cmds.getAttr(f"{long_name}.rotate")[0])
                joint_orient = tuple(cmds.getAttr(f"{long_name}.jointOrient")[0])
            except:
                rot = (0.0, 0.0, 0.0)
                joint_orient = (0.0, 0.0, 0.0)

            # 实例化 Bone (存短名)
            new_bone = Bone(
                name=short_name,
                type="",
                rotation=rot,
                joint_axis=joint_orient
            )

            # 存入 Map
            self.bone_map[short_name] = new_bone

        # Pass 2: 构建关系
        for long_name in all_joints_long:
            current_short = long_name.split("|")[-1]
            bone_obj = self.bone_map.get(current_short)

            if not bone_obj: continue

            # A. 查找父级
            parents = cmds.listRelatives(long_name, parent=True, fullPath=True)
            if parents:
                parent_long = parents[0]
                parent_short = parent_long.split("|")[-1]

                # 只有当父级也在我们的 map 中 (即父级也是 joint) 时才链接
                if parent_short in self.bone_map:
                    parent_bone = self.bone_map[parent_short]
                    bone_obj.parent = parent_bone
                    parent_bone.children.append(bone_obj)

            # 如果没有父级骨骼，归为 Root
            if bone_obj.parent is None:
                self.root_bones.append(bone_obj)

            # B. 填充 Label 类型
            # 同样假设 label_manager 里的路径可能包含短名信息
            bone_label = "unknown"
            labels_dict = label_manager.get_all()

            for lbl, path in labels_dict.items():
                # 无论 Label 存的是长是短，都只比对短名
                path_short = path.split("|")[-1]
                if path_short == current_short:
                    bone_label = lbl
                    break

            bone_obj.type = bone_label

        self.all_bones = list(self.bone_map.values())
        return self.all_bones

    def find_bone_hierarchy(self, start_bone: Bone) -> List[Bone]:
        """获取从 start_bone 开始的所有后代"""
        hierarchy = []
        self._traverse_hierarchy(start_bone, hierarchy)
        return hierarchy

    def _traverse_hierarchy(self, current_bone: Bone, hierarchy_list: List[Bone]):
        hierarchy_list.append(current_bone)
        for child in current_bone.children:
            self._traverse_hierarchy(child, hierarchy_list)

    def find_end_of_chain(self, start_bone: Bone) -> Optional[Bone]:
        """寻找单链的末端"""
        current_bone = start_bone
        while len(current_bone.children) == 1:
            current_bone = current_bone.children[0]

        if current_bone is start_bone:
            if not start_bone.children:
                return start_bone
            return None

        return current_bone