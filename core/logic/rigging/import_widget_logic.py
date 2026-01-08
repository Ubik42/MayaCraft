# import_widget_logic.py
# -*- coding: utf-8 -*-
"""
import_widget_logic.py
“预设与导入”功能块的后端逻辑。
"""

import maya.cmds as cmds
import os
from typing import List

# 假设 utils 文件夹与 core 文件夹在同一级
from utils import file_handler


# --- 示例相关 ---
def refresh_example_list() -> List[str]:
    """
    调用文件处理器查找所有可用的【示例】。

    Returns:
        List[str]: 找到的示例名称列表。
    """
    return file_handler.find_examples()


def import_example(example_name: str):
    """
    将指定的【示例】文件 (.mb) 打开到新场景中。

    Args:
        example_name (str): 要导入的示例的名称。
    """
    if not example_name or "未找到" in example_name:
        cmds.warning("没有选择要导入的示例。")
        return

    example_path = file_handler.get_example_path(example_name)
    if not os.path.exists(example_path):
        cmds.warning(f"示例文件不存在: {example_path}")
        return

    # 检查当前场景是否有未保存的更改
    if cmds.file(q=True, modified=True):
        reply = cmds.confirmDialog(
            title='未保存的更改',
            message='当前场景有未保存的更改。要继续并打开新文件吗？',
            button=['是', '否'],
            defaultButton='是',
            cancelButton='否',
            dismissString='否'
        )
        if reply == '否':
            print("导入示例操作已取消。")
            return

    print(f"正在打开示例: {example_name}...")
    try:
        # 使用 open 命令打开 .mb 文件，替换当前场景
        cmds.file(example_path, open=True, force=True)
        print("打开完成。")
    except Exception as e:
        cmds.warning(f"打开文件时发生错误: {e}")


# --- 纯骨骼相关 ---
def refresh_raw_skeleton_list() -> List[str]:
    """
    调用文件处理器查找所有可用的【纯骨骼】。

    Returns:
        List[str]: 找到的纯骨骼文件名称列表。
    """
    return file_handler.find_raw_skeletons()


def import_raw_skeleton(skeleton_name: str):
    """
    将指定的【纯骨骼】文件 (.ma) 导入到当前场景。

    Args:
        skeleton_name (str): 要导入的骨骼的名称。
    """
    if not skeleton_name or "未找到" in skeleton_name:
        cmds.warning("没有选择要导入的骨骼。")
        return

    skeleton_path = file_handler.get_raw_skeleton_path(skeleton_name)
    if not os.path.exists(skeleton_path):
        cmds.warning(f"骨骼文件不存在: {skeleton_path}")
        return

    # 在导入前，可以选择性地清理场景
    existing_joints = cmds.ls(type='joint')
    if existing_joints:
        reply = cmds.confirmDialog(
            title='清理场景',
            message='场景中已存在骨骼。是否要删除它们再导入新的骨骼？',
            button=['是', '否'],
            defaultButton='是',
            cancelButton='否',
            dismissString='否'
        )
        if reply == '是':
            print(f"正在清理场景，删除 {len(existing_joints)} 根已存在的骨骼...")
            cmds.delete(existing_joints)
        else:
            print("导入骨骼操作已取消。")
            return

    print(f"正在导入骨骼: {skeleton_name}...")
    try:
        # 使用 import 命令导入 .ma 文件
        cmds.file(skeleton_path, i=True, groupReference=True, groupName=f"{skeleton_name}_grp")
        print("导入完成。")
    except Exception as e:
        cmds.warning(f"导入文件时发生错误: {e}")


def clear_all_joint_labels():
    """
    遍历场景中所有骨骼，关闭并清除标签属性。
    """
    all_joints = cmds.ls(type="joint")

    if not all_joints:
        cmds.warning("场景中没有骨骼。")
        return

    count = 0
    for jnt in all_joints:
        try:
            # 1. 关闭显示
            if cmds.getAttr(f"{jnt}.drawLabel"):
                cmds.setAttr(f"{jnt}.drawLabel", 0)

            # 2. 重置类型为 None (0)
            if cmds.getAttr(f"{jnt}.type") != 0:
                cmds.setAttr(f"{jnt}.type", 0)

            # 3. 清空文字内容
            current_text = cmds.getAttr(f"{jnt}.otherType")
            if current_text:
                cmds.setAttr(f"{jnt}.otherType", "", type="string")

            count += 1
        except Exception as e:
            print(f"Error clearing label for {jnt}: {e}")

    print(f"已清理 {count} 个骨骼的标签信息。")