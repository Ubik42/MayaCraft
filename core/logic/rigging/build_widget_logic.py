# core/logic/rigging/build_widget_logic.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from typing import Dict, List, Union, Tuple


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


def get_scene_attributes(config_attrs: List[str], include_extra: bool = False) -> Union[Dict, Tuple[Dict, Dict]]:
    """
    [重写] 扫描场景中拥有特定属性名的骨骼。

    Args:
        config_attrs (List[str]): 配置中定义的属性列表 (例如 ATTR_LIST)。
        include_extra (bool): 如果为 True，则额外扫描并返回不在 config_attrs 中的其他自定义属性。

    Returns:
        - 如果 include_extra=False: 返回一个字典 {'twist': ['jnt1'], ...}
        - 如果 include_extra=True: 返回一个元组 (config_results, extra_results)
          - config_results: 匹配 config_attrs 的字典
          - extra_results: 场景中存在但不在 config_attrs 中的其他属性字典
    """

    all_joints = cmds.ls(type='joint', long=True) or []
    if not all_joints:
        # 如果没有骨骼，根据请求返回空字典或空元组
        return {} if not include_extra else ({}, {})

    config_results = {}
    extra_results = {}

    # 将配置列表转为集合，可以极大地提高查找效率
    config_set = set(config_attrs)

    for jnt in all_joints:
        # 获取骨骼上所有用户自定义的、可 key 的属性
        user_attrs = cmds.listAttr(jnt, userDefined=True, keyable=True) or []

        for attr in user_attrs:
            # 判断属性属于“预设”还是“额外”
            if attr in config_set:
                # 放入预设结果字典
                if attr not in config_results:
                    config_results[attr] = []
                config_results[attr].append(jnt)
            elif include_extra:
                # 如果开启了 extra 扫描，放入额外结果字典
                if attr not in extra_results:
                    extra_results[attr] = []
                extra_results[attr].append(jnt)

    # 根据请求的模式返回不同格式的数据
    if include_extra:
        return config_results, extra_results
    else:
        return config_results

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


