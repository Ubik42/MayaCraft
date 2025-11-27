# build_widget_logic.py
# -*- coding: utf-8 -*-
"""
build_widget_logic.py
“骨骼与模块”功能块的后端逻辑。
"""

import maya.cmds as cmds
from typing import Dict


def get_all_joint_labels() -> Dict[str, str]:
    """
    扫描场景，获取所有设置了标签的骨骼。

    Returns:
        Dict[str, str]: 一个字典，键是骨骼标签，值是对应的骨骼长名称。
    """
    all_joints = cmds.ls(type='joint', long=True)
    labels_dict = {}

    for joint in all_joints:
        # 骨骼标签存储在 'type' 和 'otherType' 属性中
        label_type_str = cmds.getAttr(f"{joint}.type", asString=True)

        label = ""
        if label_type_str == 'Other':
            label = cmds.getAttr(f"{joint}.otherType")
        elif label_type_str != 'None':
            label = label_type_str

        if label and label not in labels_dict:  # 确保标签的唯一性
            labels_dict[label] = joint
        elif label in labels_dict:
            cmds.warning(f"发现重复的骨骼标签: '{label}'。请确保标签是唯一的。")

    return labels_dict


def set_joint_label(joint_name: str, new_label: str):
    """
    为指定的骨骼设置一个新的标签。

    Args:
        joint_name (str): 要设置标签的骨骼名称。
        new_label (str): 新的标签字符串。
    """
    if not cmds.objExists(joint_name) or cmds.nodeType(joint_name) != 'joint':
        cmds.warning(f"'{joint_name}' 不是一个有效的骨骼。")
        return False

    if not new_label:
        cmds.warning("标签不能为空。")
        return False

    # 检查新标签是否已在场景中存在
    all_labels = get_all_joint_labels()
    if new_label in all_labels and all_labels[new_label] != cmds.ls(joint_name, long=True)[0]:
        cmds.warning(f"标签 '{new_label}' 已被其他骨骼使用。标签必须是唯一的。")
        return False

    # 'type' 属性是一个枚举。18 对应 'Other'。
    cmds.setAttr(f"{joint_name}.type", 18)
    # 将自定义标签字符串设置到 'otherType' 属性中
    cmds.setAttr(f"{joint_name}.otherType", new_label, type="string")
    print(f"已将 '{joint_name}' 的标签设置为 '{new_label}'。")
    return True


def select_joint_by_label(labels_dict: Dict[str, str], label_to_select: str):
    """
    根据给定的标签，在场景中选中对应的骨骼。

    Args:
        labels_dict (Dict[str, str]): 包含标签和骨骼名称的字典。
        label_to_select (str): 要选中的骨骼的标签。
    """
    joint_to_select = labels_dict.get(label_to_select)
    if joint_to_select and cmds.objExists(joint_to_select):
        cmds.select(joint_to_select, replace=True)
    else:
        cmds.warning(f"找不到标签为 '{label_to_select}' 的骨骼，可能已被删除或重命名。")


def mirror_selected_joints():
    """
    对当前选中的骨骼执行镜像操作。

    使用 YZ 平面进行镜像，并自动搜索替换名称中的 '_L' 为 '_R'。
    同时也会镜像并更新骨骼标签。
    """
    selection = cmds.ls(sl=True, type='joint')
    if not selection:
        cmds.warning("请先选中要镜像的骨骼。")
        return

    # 确保选中的都是左侧骨骼
    for jnt in selection:
        if '_L' not in jnt:
            cmds.warning(f"选中的骨骼 '{jnt}' 名称中不包含 '_L' 后缀，无法进行镜像重命名。已跳过。")
            return

    print(f"正在镜像 {len(selection)} 根骨骼...")
    mirrored_joints = cmds.mirrorJoint(
        selection,
        mirrorYZ=True,  # 沿YZ平面镜像 (跨越X轴)
        mirrorBehavior=True,  # 镜像骨骼行为 (旋转方向)
        searchReplace=('_L', '_R')  # 搜索和替换名称
    )

    if not mirrored_joints:
        cmds.warning("镜像操作失败，没有创建新的骨骼。")
        return

    print(f"镜像完成。创建了: {mirrored_joints}")

    # 更新镜像后骨骼的标签
    for original_joint in selection:
        mirrored_joint_name = original_joint.replace('_L', '_R')

        # 确保镜像后的骨骼确实存在
        if mirrored_joint_name in mirrored_joints or cmds.objExists(mirrored_joint_name):
            # 获取原始标签
            original_label = ""
            label_type_str = cmds.getAttr(f"{original_joint}.type", asString=True)
            if label_type_str == 'Other':
                original_label = cmds.getAttr(f"{original_joint}.otherType")
            elif label_type_str != 'None':
                original_label = label_type_str

            if original_label and '_L' in original_label:
                mirrored_label = original_label.replace('_L', '_R')
                set_joint_label(mirrored_joint_name, mirrored_label)

    cmds.select(mirrored_joints, replace=True)  # 选中新创建的骨骼