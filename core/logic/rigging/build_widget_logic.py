# core/logic/rigging/build_widget_logic.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from typing import Dict, List


# -----------------------------------------------------------------------------
# 骨骼标签逻辑
# -----------------------------------------------------------------------------

def set_joint_label(joint_name: str, new_label: str) -> bool:
    """设置骨骼标签"""
    if not cmds.objExists(joint_name) or cmds.nodeType(joint_name) != 'joint':
        if not new_label: return True
        cmds.warning(f"'{joint_name}' 不是骨骼。")
        return False

    if not new_label:
        # 清除
        cmds.setAttr(f"{joint_name}.drawLabel", 0)
        cmds.setAttr(f"{joint_name}.type", 0)
        cmds.setAttr(f"{joint_name}.otherType", "", type="string")
        return True

    try:
        cmds.setAttr(f"{joint_name}.type", 18)  # Other
        cmds.setAttr(f"{joint_name}.otherType", new_label, type="string")
        cmds.setAttr(f"{joint_name}.drawLabel", 1)
        print(f"[Logic] 骨骼标签设定: {joint_name} -> {new_label}")
        return True
    except Exception as e:
        cmds.error(f"标签设置失败: {e}")
        return False


def get_all_joint_labels() -> Dict[str, List[str]]:
    """
    获取场景所有骨骼标签。
    返回格式: {'Hand': ['L_Hand', 'R_Hand'], 'Shoulder': [...]}
    """
    all_joints = cmds.ls(type='joint', long=True) or []
    labels_dict = {}

    for joint in all_joints:
        # 只要有 otherType 属性值，即使 drawLabel=0 也视为存在数据
        label_type = cmds.getAttr(f"{joint}.type")
        label = ""

        if label_type == 18:  # Other
            label = cmds.getAttr(f"{joint}.otherType")
        elif label_type != 0:  # 其他预设类型
            label = cmds.getAttr(f"{joint}.type", asString=True)

        if label:
            if label not in labels_dict:
                labels_dict[label] = []
            labels_dict[label].append(joint)

    return labels_dict


# -----------------------------------------------------------------------------
# 属性设置逻辑
# -----------------------------------------------------------------------------

def add_attribute_to_node(node_name: str, attr_name: str) -> bool:
    """添加属性 (double 0-1)"""
    if not cmds.objExists(node_name): return False

    if cmds.attributeQuery(attr_name, node=node_name, exists=True):
        print(f"[Logic] 属性已存在: {node_name}.{attr_name}")
        return True

    try:
        cmds.addAttr(node_name, longName=attr_name, attributeType='double', min=0, max=1, defaultValue=0, keyable=True)
        print(f"[Logic] 添加属性成功: {node_name}.{attr_name}")
        return True
    except Exception as e:
        cmds.error(f"添加属性出错: {e}")
        return False


def remove_attribute_from_node(node_name: str, attr_name: str) -> bool:
    """移除属性"""
    if not cmds.objExists(node_name): return False
    if not cmds.attributeQuery(attr_name, node=node_name, exists=True): return False

    try:
        cmds.deleteAttr(node_name, attribute=attr_name)
        print(f"[Logic] 移除属性成功: {node_name}.{attr_name}")
        return True
    except Exception as e:
        cmds.error(f"移除属性出错: {e}")
        return False


def get_scene_attributes(target_attrs: List[str]) -> Dict[str, List[str]]:
    """
    扫描场景中拥有特定属性名的节点。
    Returns: {'twist': ['nodeA', 'nodeB'], ...}
    """
    result = {}
    for attr in target_attrs:
        # 查找所有拥有此属性的 plug (e.g., node.attr)
        # recursive=True 有助于在复杂层级中查找，但 ls *.attr 是全局查找
        found_plugs = cmds.ls(f"*.{attr}", recursive=True) or []

        nodes = []
        for plug in found_plugs:
            node = plug.split('.')[0]
            # 去重
            if node not in nodes:
                nodes.append(node)

        if nodes:
            result[attr] = nodes

    return result


# -----------------------------------------------------------------------------
# 辅助
# -----------------------------------------------------------------------------
def select_joint_by_label(labels_dict, label_to_select):
    """(兼容旧接口) 选中特定标签的骨骼"""
    joints = labels_dict.get(label_to_select, [])
    valid = [j for j in joints if cmds.objExists(j)]
    if valid:
        cmds.select(valid, replace=True)
    else:
        cmds.warning(f"未找到标签 '{label_to_select}' 对应的骨骼。")