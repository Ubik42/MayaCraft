# core/rigging/label_manager.py
# -*- coding: utf-8 -*-
"""
label_manager.py
提供一个单例类 LabelManager 来全局管理场景中骨骼标签与骨骼名称的映射。
"""

import maya.cmds as cmds
from typing import Dict, Optional


class LabelManager:
    """
    一个单例类，用于在整个Maya会话中管理骨骼标签的中央数据库。
    """
    _instance = None

    def __new__(cls):
        """实现单例模式。"""
        if cls._instance is None:
            cls._instance = super(LabelManager, cls).__new__(cls)
            cls._instance._label_map: Dict[str, str] = {}
            cls._instance.scan()  # 首次实例化时自动扫描一次场景
        return cls._instance

    def scan(self) -> None:
        """
        （查）扫描整个场景，用最新的标签数据完全重建内部的映射字典。
        这是主要的刷新方法。
        """
        self._label_map.clear()
        all_joints = cmds.ls(type='joint', long=True)
        for joint in all_joints:
            label_type_str = cmds.getAttr(f"{joint}.type", asString=True)
            label = ""
            if label_type_str == 'Other':
                label = cmds.getAttr(f"{joint}.otherType")
            elif label_type_str != 'None':
                label = label_type_str

            if label:
                if label in self._label_map:
                    cmds.warning(f"发现重复标签 '{label}'。管理器将只记录第一个找到的骨骼 '{self._label_map[label]}'")
                else:
                    self._label_map[label] = joint
        print("标签管理器: 场景扫描完成。")

    def add(self, joint_name: str, label: str) -> bool:
        """
        （增）为一个骨骼设置新标签，并更新内部映射。
        """
        if not cmds.objExists(joint_name) or cmds.nodeType(joint_name) != 'joint':
            cmds.warning(f"'{joint_name}' 不是一个有效的骨骼。")
            return False
        if not label:
            cmds.warning("标签不能为空。")
            return False

        joint_path = cmds.ls(joint_name, long=True)[0]
        if label in self._label_map and self._label_map[label] != joint_path:
            cmds.warning(f"标签 '{label}' 已被 '{self._label_map[label]}' 使用。")
            return False

        self.remove_by_joint(joint_name)

        cmds.setAttr(f"{joint_path}.type", 18)  # Other
        cmds.setAttr(f"{joint_path}.otherType", label, type="string")
        self._label_map[label] = joint_path
        print(f"标签管理器: 已添加 '{joint_name}' -> '{label}'")
        return True

    def remove(self, label: str) -> bool:
        """
        （删）根据标签移除一个骨骼的标签信息。
        """
        joint_name = self._label_map.get(label)
        if joint_name and cmds.objExists(joint_name):
            cmds.setAttr(f"{joint_name}.type", 0)  # None
            cmds.setAttr(f"{joint_name}.otherType", "", type="string")
            del self._label_map[label]
            print(f"标签管理器: 已移除标签 '{label}'")
            return True
        elif label in self._label_map:
            del self._label_map[label]
        return False

    def remove_by_joint(self, joint_name: str) -> bool:
        """根据骨骼名称移除其标签信息。"""
        joint_path = cmds.ls(joint_name, long=True)
        if not joint_path: return False

        label_to_remove = None
        for label, path in self._label_map.items():
            if path == joint_path[0]:
                label_to_remove = label
                break

        if label_to_remove:
            return self.remove(label_to_remove)
        return False

    def update(self, old_label: str, new_label: str) -> bool:
        """
        （改）更新一个已存在的标签。
        """
        joint_name = self._label_map.get(old_label)
        if not joint_name:
            cmds.warning(f"找不到旧标签 '{old_label}'。")
            return False

        return self.add(joint_name, new_label)

    def get(self, label: str) -> Optional[str]:
        """
        （查）根据标签获取对应的骨骼长名称。
        """
        joint_name = self._label_map.get(label)
        if joint_name and cmds.objExists(joint_name):
            return joint_name
        elif label in self._label_map:
            del self._label_map[label]
        return None

    def get_all(self) -> Dict[str, str]:
        """（查）返回整个标签映射字典的副本。"""
        return self._label_map.copy()


# 方便在其他模块中直接导入单例实例
label_manager = LabelManager()