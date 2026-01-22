# core/logic/rigging/build_widget_logic.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from typing import Dict, List, Union, Any

# 引入 Attribute 包以获取具体的属性类配置
import core.rigging.attribute as attribute_pkg


# -----------------------------------------------------------------------------
# 核心交互逻辑 (供 UI 直接调用)
# -----------------------------------------------------------------------------

def toggle_configuration(node: str, key: str, is_attribute: bool, force_remove: bool = False) -> None:
    """
    切换配置状态：
    - 如果是骨骼标签：若当前标签一致则清除，否则设置新标签。
    - 如果是属性：若已拥有完整属性则移除，否则添加。
    """
    if not node or not cmds.objExists(node):
        return

    if is_attribute:
        _toggle_attribute(node, key, force_remove)
    else:
        _toggle_joint_label(node, key, force_remove)


def get_scene_data(attr_keys: List[str]) -> Dict[str, Dict[str, List[str]]]:
    """
    一次性获取场景中所有的标签数据和属性数据，供前端刷新 UI。

    Returns:
        {
            'labels': {'Hip': ['Jnt1'], ...},
            'attributes': {'twist': ['Jnt1', 'Jnt2'], ...}
        }
    """
    return {
        'labels': get_all_joint_labels(),
        'attributes': _get_all_attribute_assignments(attr_keys)
    }


# -----------------------------------------------------------------------------
# 内部逻辑实现
# -----------------------------------------------------------------------------

def _toggle_joint_label(node: str, label_key: str, force_remove: bool) -> None:
    """切换骨骼标签逻辑"""
    if cmds.nodeType(node) != 'joint':
        cmds.warning(f"Label '{label_key}' 只能赋予 Joint 类型，'{node}' 是 {cmds.nodeType(node)}")
        return

    current_label = _get_label_from_node(node)

    # 逻辑：如果强制移除，或者当前标签就是目标标签 -> 清除
    if force_remove or current_label == label_key:
        set_joint_label(node, "")  # Clear
        print(f"[Logic] Cleared label from {node}")
    else:
        set_joint_label(node, label_key)  # Assign
        print(f"[Logic] Assigned label '{label_key}' to {node}")


def _toggle_attribute(node: str, key: str, force_remove: bool) -> None:
    """切换属性逻辑 (支持多属性检测)"""
    attr_class = attribute_pkg.get_attribute_class(key)
    if not attr_class:
        cmds.warning(f"[Logic] 未找到属性配置: {key}")
        return

    # 检测节点是否已经完全拥有该 Key 对应的所有属性
    has_all = _node_has_all_attributes(node, key, attr_class)

    if force_remove or has_all:
        # 执行移除
        if hasattr(attr_class, 'remove_from'):
            success = attr_class.remove_from(node)
            if success: print(f"[Logic] Removed attribute '{key}' from {node}")
    else:
        # 执行添加
        if hasattr(attr_class, 'add_to'):
            success = attr_class.add_to(node)
            if success: print(f"[Logic] Added attribute '{key}' to {node}")


def _node_has_all_attributes(node: str, key: str, attr_class: Any) -> bool:
    """
    检测节点是否包含该 Key 定义的所有实际 Maya 属性。
    例如 Key='twist' 可能对应 Maya 属性 ['twist', 'bendy']
    """
    required_attrs = _get_required_attrs_for_key(key, attr_class)

    for attr in required_attrs:
        if not cmds.attributeQuery(attr, node=node, exists=True):
            return False
    return True


def _get_required_attrs_for_key(key: str, attr_class: Any) -> List[str]:
    """
    解析一个 UI Key 对应哪些实际的 Maya Attribute Name。
    优先读取类中的 SLOTS 变量。
    """
    if hasattr(attr_class, 'SLOTS') and attr_class.SLOTS:
        return attr_class.SLOTS
    # Fallback: 默认属性名等于 key
    return [key]


def _get_all_attribute_assignments(config_keys: List[str]) -> Dict[str, List[str]]:
    """
    扫描场景，找出每个 Attribute Key 对应的骨骼列表。
    必须满足 Key 下的所有属性都存在才算匹配。
    """
    all_joints = cmds.ls(type='joint', long=True) or []
    result = {k: [] for k in config_keys}

    # 预先获取每个 Key 对应的类和属性列表，避免循环内重复获取
    key_requirements = {}
    for key in config_keys:
        cls = attribute_pkg.get_attribute_class(key)
        if cls:
            key_requirements[key] = _get_required_attrs_for_key(key, cls)
        else:
            key_requirements[key] = [key]

    for jnt in all_joints:
        # 获取该骨骼上的所有用户属性，用于快速查找
        existing_attrs = set(cmds.listAttr(jnt, userDefined=True) or [])

        for key, req_attrs in key_requirements.items():
            # 检查是否所有必需属性都在骨骼的现有属性中
            # 使用 set.issubset 进行高效判断
            if set(req_attrs).issubset(existing_attrs):
                result[key].append(jnt)

    return result


# -----------------------------------------------------------------------------
# 基础操作 (保留原有底层实现)
# -----------------------------------------------------------------------------

def set_joint_label(joint_name: str, new_label: str) -> bool:
    """底层：设置 Maya 骨骼标签属性"""
    if not cmds.objExists(joint_name): return False

    if not new_label:
        cmds.setAttr(f"{joint_name}.drawLabel", 0)
        cmds.setAttr(f"{joint_name}.type", 0)
        cmds.setAttr(f"{joint_name}.otherType", "", type="string")
        return True

    try:
        cmds.setAttr(f"{joint_name}.type", 18)  # Other
        cmds.setAttr(f"{joint_name}.otherType", new_label, type="string")
        cmds.setAttr(f"{joint_name}.drawLabel", 1)
        return True
    except Exception as e:
        cmds.error(f"标签设置失败: {e}")
        return False


def get_all_joint_labels() -> Dict[str, List[str]]:
    """底层：获取场景所有骨骼标签"""
    all_joints = cmds.ls(type='joint', long=True) or []
    labels_dict = {}

    for joint in all_joints:
        if not cmds.getAttr(f"{joint}.drawLabel"):
            continue

        label_type = cmds.getAttr(f"{joint}.type")
        label = ""

        if label_type == 18:
            label = cmds.getAttr(f"{joint}.otherType")
        elif label_type != 0:
            label = cmds.getAttr(f"{joint}.type", asString=True)

        if label:
            if label not in labels_dict:
                labels_dict[label] = []
            labels_dict[label].append(joint)

    return labels_dict


def _get_label_from_node(node: str) -> str:
    """辅助：获取单个节点的当前标签"""
    if not cmds.getAttr(f"{node}.drawLabel"):
        return ""
    if cmds.getAttr(f"{node}.type") == 18:
        return cmds.getAttr(f"{node}.otherType")
    return ""