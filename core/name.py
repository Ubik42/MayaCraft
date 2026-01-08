# -*- coding: utf-8 -*-
"""
name.py
核心命名管理模块。
提供命名检查、唯一化、以及强大的层级批量重命名功能。
"""

import maya.cmds as cmds
import re
from typing import List, Optional


def get_unique_name(name: str) -> str:
    """
    生成一个在场景中唯一的名字。
    如果名字已存在，则在后面添加数字后缀 (e.g., "joint1" -> "joint1_1")。
    """
    if not cmds.objExists(name):
        return name

    i = 1
    new_name = f"{name}_{i}"
    while cmds.objExists(new_name):
        i += 1
        new_name = f"{name}_{i}"
    return new_name


def valid_name(name: str) -> str:
    """
    清理字符串，使其符合 Maya 命名规范。
    1. 替换空格为下划线。
    2. 移除非法字符 (除了字母、数字、下划线以外的字符)。
    3. 确保不以数字开头。
    """
    # 替换空格
    name = name.replace(" ", "_")

    # 使用正则移除非法字符 (保留 字母, 数字, 下划线)
    name = re.sub(r'[^a-zA-Z0-9_]', '', name)

    # 确保不以数字开头 (Maya 不允许)
    if name and name[0].isdigit():
        name = "_" + name

    return name


def rename_hierarchy(
        root_node: str,
        prefix: str = "",
        suffix: str = "",
        replace_list: Optional[List[tuple]] = None,
        include_root: bool = True
) -> str:
    """
    对整个层级进行重命名。

    核心逻辑：
    **自下而上 (Bottom-Up)** 遍历。这是重命名层级的唯一正确方式。
    先改子物体，再改父物体。这样修改父物体名字时，不会破坏子物体的路径引用。

    Args:
        root_node: 根节点名称。
        prefix: 前缀。
        suffix: 后缀。
        replace_list: 查找替换列表，格式为 [("old", "new"), ("_L_", "_R_")]。
        include_root: 是否也重命名根节点。

    Returns:
        str: 重命名后的根节点名称 (因为根节点名字可能变了，返回新的给调用者)。
    """

    # 1. 验证根节点是否存在
    if not cmds.objExists(root_node):
        print(f"[Name] Error: Node '{root_node}' not found.")
        return root_node

    # 获取全路径 (为了准确性)
    full_root = cmds.ls(root_node, long=True)[0]

    # 2. 获取所有后代 (Transforms/Joints)
    # 使用 fullPath=True 确保在重名环境下能找到对象
    descendants = cmds.listRelatives(full_root, allDescendents=True, type='transform', fullPath=True) or []

    # 3. 将根节点加入列表 (根据参数决定是否处理)
    nodes_to_rename = []
    nodes_to_rename.extend(descendants)
    if include_root:
        nodes_to_rename.append(full_root)

    # 4. 【关键步骤】按路径深度降序排序 (长的在前面 -> 子物体在前面)
    # 这样确保我们处理子物体时，父物体名字还没变，路径依然有效
    nodes_to_rename.sort(key=lambda x: x.count('|'), reverse=True)

    new_root_name = root_node  # 默认返回值

    # 5. 开始遍历重命名
    for node_long_name in nodes_to_rename:
        # 获取当前的短名
        short_name = node_long_name.split("|")[-1]

        # --- 构建新名字 ---
        base_name = short_name

        # A. 执行查找替换 (如果有)
        if replace_list:
            for search_str, replace_str in replace_list:
                base_name = base_name.replace(search_str, replace_str)

        # B. 添加前后缀
        final_name = f"{prefix}{base_name}{suffix}"

        # C. 执行重命名
        if final_name != short_name:
            try:
                # rename 命令返回的是新名字 (Maya可能会自动处理冲突)
                renamed = cmds.rename(node_long_name, final_name)

                # 如果当前处理的是根节点，记录新名字用于返回
                if node_long_name == full_root:
                    new_root_name = renamed

            except Exception as e:
                print(f"[Name] Warning: Failed to rename '{short_name}' to '{final_name}': {e}")

    return new_root_name