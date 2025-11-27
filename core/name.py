import maya.cmds as cmds
from typing import List, Union, Tuple, Optional
import re


def get_unique_name(name):
    """
    生成一个在场景中唯一的名字。
    如果名字已存在，则在后面添加数字后缀。
    """
    i = 1
    new_name = name
    while cmds.objExists(new_name):
        new_name = f"{name}_{i}"
        i += 1
    return new_name

    cmds.pathAnimation()

# 检查命名能否作为maya大纲里的名字
def valid_name(name):
    return

def rename_hierarchy_with_root(root_node: str, suffix: str = "", prefix: str = "") -> None:
    """
    使用从子到父的遍历方法，为层级中的每个节点（包括根节点）直接添加前缀或后缀。
    此版本不进行任何智能名称清理，只是简单地附加字符串。

    Args:
        root_node (str): 需要重命名的层级的顶层节点 (必须是唯一的短名称或长名称)。
        suffix (str): 添加到每个节点名称末尾的后缀。
        prefix (str): 添加到每个节点名称开头的'前缀。
    """

    # 1. 获取包括根节点在内的所有节点的长路径
    try:
        root_path = cmds.ls(root_node, long=True)[0]
    except IndexError:
        print(f"Error: Node '{root_node}' does not exist. Cannot start renaming.")
        return

    nodes_in_hierarchy = cmds.listRelatives(root_path, allDescendents=True, type='transform', fullPath=True) or []
    nodes_in_hierarchy.append(root_path)

    # 2. 按路径深度降序排序，确保从子到父进行操作
    nodes_in_hierarchy.sort(key=lambda x: x.count('|'), reverse=True)

    # 3. 遍历并直接添加后缀/前缀
    for node_path in nodes_in_hierarchy:
        short_name = node_path.split('|')[-1]

        # --- 核心简化点 ---
        # 不做任何检测，直接使用当前短名称进行拼接
        new_name = f"{prefix}{short_name}{suffix}"

        try:
            # 只有在名字确实需要改变时才执行重命名
            if short_name != new_name and cmds.objExists(node_path):
                cmds.rename(node_path, new_name)
        except RuntimeError as e:
            # 捕获异常，以防目标名称已存在
            print(f"Warning: Could not rename '{short_name}' to '{new_name}'. Error: {e}")
def rename_hierarchy(root_node: str, suffix: str = "", prefix: str = "") -> None:
    """
    使用从子到父的遍历方法，为层级中的每个节点（包括根节点）直接添加前缀或后缀。
    此版本不进行任何智能名称清理，只是简单地附加字符串。

    Args:
        root_node (str): 需要重命名的层级的顶层节点 (必须是唯一的短名称或长名称)。
        suffix (str): 添加到每个节点名称末尾的后缀。
        prefix (str): 添加到每个节点名称开头的'前缀。
    """

    # 1. 获取包括根节点在内的所有节点的长路径
    try:
        root_path = cmds.ls(root_node, long=True)[0]
    except IndexError:
        print(f"Error: Node '{root_node}' does not exist. Cannot start renaming.")
        return

    nodes_in_hierarchy = cmds.listRelatives(root_path, allDescendents=True, type='transform', fullPath=True) or []

    # 2. 按路径深度降序排序，确保从子到父进行操作
    nodes_in_hierarchy.sort(key=lambda x: x.count('|'), reverse=True)

    # 3. 遍历并直接添加后缀/前缀
    for node_path in nodes_in_hierarchy:
        short_name = node_path.split('|')[-1]

        # --- 核心简化点 ---
        # 不做任何检测，直接使用当前短名称进行拼接
        new_name = f"{prefix}{short_name}{suffix}"

        try:
            # 只有在名字确实需要改变时才执行重命名
            if short_name != new_name and cmds.objExists(node_path):
                cmds.rename(node_path, new_name)
        except RuntimeError as e:
            # 捕获异常，以防目标名称已存在
            print(f"Warning: Could not rename '{short_name}' to '{new_name}'. Error: {e}")