# core/tool.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.api.OpenMaya as om
import math
import re
from typing import List, Union, Tuple, Optional

############################################
# connect part
############################################


def safe_parent(child: str, parent: str) -> None:
    """
    Safely parent child to parent.
    Checks if parent is already correct to avoid warnings.
    Checks if child/parent exist.
    """
    if not cmds.objExists(child) or not cmds.objExists(parent):
        # print(f"[Safe Parent] Warning: Not found {child} or {parent}")
        return

    # Check current parent
    parents = cmds.listRelatives(child, parent=True)
    if parents:
        if parents[0] == parent:
            return  # Already parented

    # Check for cycles (Basic check: parent cannot be child of child)
    try:
        cmds.parent(child, parent)
    except Exception as e:
        print(f"[Safe Parent] Error parenting {child} to {parent}: {e}")


def safe_constraint(prefix: str, target: str, constraint_type: int = 0) -> str:
    """
    根据前缀和目标对象创建组，并将组约束到目标对象。
    """
    if not cmds.objExists(target):
        print(f"[Safe Constraint] Error: Target {target} not found.")
        return ""

    target_short = target.split("|")[-1]

    grp_name = f"{prefix}ParentConstraintTo{target_short}"

    if not cmds.objExists(grp_name):
        grp = cmds.group(empty=True, name=grp_name)
        cmds.matchTransform(grp, target, pos=True, rot=True)
    else:
        grp = grp_name

    if constraint_type == 0:
        if not cmds.listConnections(grp, type="parentConstraint"):
            cmds.parentConstraint(target, grp, maintainOffset=True)

    elif constraint_type == 1:
        if not cmds.listConnections(grp, type="parentConstraint"):
            cmds.parentConstraint(target, grp, maintainOffset=True)
        if not cmds.listConnections(grp, type="orientConstraint"):
            cmds.orientConstraint(target, grp, maintainOffset=True)

    return grp


############################################
# attribute part
############################################


def set_draw(
    target_nodes: Union[str, List[str]],
    enable_overrides: Optional[bool] = None,
    display_type: Optional[int] = None,
    visible: Optional[bool] = None,
    color: Optional[Union[int, Tuple[float, float, float]]] = None,
) -> None:
    """
    设置绘图覆盖 (Drawing Overrides)、颜色和可见性。
    """
    if isinstance(target_nodes, str):
        nodes = [target_nodes]
    else:
        nodes = target_nodes

    if not nodes:
        return

    for node in nodes:
        if not cmds.objExists(node):
            continue

        if visible is not None:
            try:
                cmds.setAttr(f"{node}.visibility", visible)
            except:
                pass

        shape_nodes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
        if not shape_nodes and cmds.nodeType(node) in [
            "locator",
            "camera",
            "nurbsCurve",
            "mesh",
        ]:
            pass
        elif not shape_nodes:
            continue

        for shape in shape_nodes:
            try:
                if enable_overrides is not None:
                    cmds.setAttr(f"{shape}.overrideEnabled", enable_overrides)

                if display_type is not None:
                    cmds.setAttr(f"{shape}.overrideDisplayType", display_type)

                if color is not None:
                    if isinstance(color, int):
                        cmds.setAttr(f"{shape}.overrideRGBColors", 0)
                        cmds.setAttr(f"{shape}.overrideColor", color)
                    elif isinstance(color, (list, tuple)) and len(color) == 3:
                        cmds.setAttr(f"{shape}.overrideRGBColors", 1)
                        cmds.setAttr(f"{shape}.overrideColorRGB", *color)
            except Exception:
                pass


def add_attribute(
        node: str,
        long_name: str,
        nice_name: str = None,
        attribute_type: str = "double",  # 默认数值类型
        is_data_type: bool = False,  # 新增：标记是否为复杂数据类型(string, matrix等)
        enum_names: List[str] = None,  # 新增：枚举名称列表
        min_value: Union[float, int] = None,
        max_value: Union[float, int] = None,
        default_value: Union[float, int, str] = None,  # 默认值可能为字符串
        keyable: bool = True,
        channel_box: bool = False,
        multi: bool = False  # 新增：是否为数组
) -> bool:
    """
    增强版属性添加函数，支持 double, float, long, short, bool 以及 message String, Enum, Numeric 等。
    """
    if not cmds.objExists(node):
        return False

    if cmds.attributeQuery(long_name, node=node, exists=True):
        return True

    kwargs = {
        "longName": long_name,
    }

    # 1. 区分 -at 和 -dt
    if is_data_type or attribute_type in ["string", "matrix", "stringArray"]:
        kwargs["dataType"] = attribute_type
    else:
        kwargs["attributeType"] = attribute_type

    # 2. 处理 Enum
    if attribute_type == "enum":
        if enum_names:
            # Maya enum 格式为 "A:B:C"
            kwargs["enumName"] = ":".join(enum_names)
        else:
            # 给一个默认值防止报错
            kwargs["enumName"] = "Default"

    if nice_name:
        kwargs["niceName"] = nice_name

    # 3. 处理多重属性
    if multi:
        kwargs["multi"] = True
        kwargs["indexMatters"] = True

    # 4. 数值限制 (仅对非数据类型有效)
    if not is_data_type and attribute_type != "string":
        if min_value is not None:
            kwargs["min"] = min_value
        if max_value is not None:
            kwargs["max"] = max_value

    # 5. 默认值处理
    if default_value is not None:
        if attribute_type == "string":
            # 字符串类型的默认值通常需要在创建后通过 setAttr 设置
            pass
        else:
            kwargs["defaultValue"] = default_value

    if keyable:
        kwargs["keyable"] = True

    try:
        cmds.addAttr(node, **kwargs)

        # 后处理：字符串默认值需要单独设置
        if attribute_type == "string" and default_value:
            cmds.setAttr(f"{node}.{long_name}", default_value, type="string")

        if channel_box and not keyable:
            cmds.setAttr(f"{node}.{long_name}", channelBox=True)

        print(f"[Attribute] Added: {node}.{long_name} ({attribute_type})")
        return True

    except Exception as e:
        cmds.warning(f"Failed to add {long_name} to {node}: {e}")
        return False


def remove_attribute(node: str, attr_name: str) -> bool:
    """
    增强版属性移除函数。
    会自动处理锁定状态，并防止尝试删除原生静态属性。
    """
    if not cmds.objExists(node):
        return False

    # 1. 检查属性是否存在
    if not cmds.attributeQuery(attr_name, node=node, exists=True):
        # 如果属性本来就不存在，视为“移除成功”，这在自动化脚本中更安全
        # 避免脚本因为"没找到要删的东西"而中断
        return True

    full_name = f"{node}.{attr_name}"

    # 2. 检查是否为 Maya 原生(静态)属性
    # 原生属性（如 translateX, visibility）是无法被 deleteAttr 删除的
    # 我们只尝试删除 "用户定义 (Dynamic)" 的属性
    # 注意：extension attributes 也可以被删除，这里主要过滤 standard attributes
    is_dynamic = cmds.addAttr(full_name, query=True, usedAsFilename=False)
    # 注：Maya没有直接查"isDynamic"的简单标志，但在查询 addAttr 时，
    # 如果是静态属性，通常会报错或行为不同。
    # 更准确的方法是列表检查：
    user_attrs = cmds.listAttr(node, userDefined=True) or []
    if attr_name not in user_attrs:
        # 有一种特殊情况：Extension Attributes 也是可以删的，但很难区分。
        # 这里做一个简单的 try-check 机制更保险，或者直接跳过标准属性。
        # 如果属性不在 userDefined 里，通常意味着它是核心属性，删不掉。
        cmds.warning(f"Cannot remove '{attr_name}': It is a static/default Maya attribute.")
        return False

    # 3. 处理锁定状态 (Locked Attributes)
    if cmds.getAttr(full_name, lock=True):
        try:
            cmds.setAttr(full_name, lock=False)
            print(f"  [Remove] Unlocked: {full_name}")
        except Exception as e:
            cmds.warning(f"Failed to unlock {full_name}, cannot remove: {e}")
            return False

    # 4. 执行删除
    try:
        cmds.deleteAttr(node, attribute=attr_name)
        print(f"[Attribute] Removed: {full_name}")
        return True
    except Exception as e:
        # 捕获可能的引用节点(Referenced Node)错误
        # 如果节点是引用的，且属性也是引用文件里定义的，则无法删除
        if cmds.referenceQuery(node, isNodeReferenced=True):
             cmds.warning(f"Failed to remove {attr_name}: Node is referenced (attribute might belong to reference source).")
        else:
             cmds.warning(f"Failed to remove {attr_name} from {node}: {e}")
        return False


def unlock_transform(
    target_nodes: Union[str, List[str]],
    translate: bool = True,
    rotate: bool = True,
    scale: bool = True,
    visibility: bool = True,
    keyable: bool = True,
) -> None:
    """解锁变换属性。"""
    if isinstance(target_nodes, str):
        target_nodes = [target_nodes]

    attrs_to_process = []
    if translate:
        attrs_to_process.extend(["tx", "ty", "tz"])
    if rotate:
        attrs_to_process.extend(["rx", "ry", "rz"])
    if scale:
        attrs_to_process.extend(["sx", "sy", "sz"])
    if visibility:
        attrs_to_process.append("v")

    for node in target_nodes:
        if not cmds.objExists(node):
            continue
        for attr in attrs_to_process:
            full_attr = f"{node}.{attr}"
            try:
                cmds.setAttr(full_attr, lock=False)
                if keyable:
                    cmds.setAttr(full_attr, keyable=True, channelBox=True)
            except Exception:
                pass


def lock_transform(
    target_nodes: Union[str, List[str]],
    translate: bool = True,
    rotate: bool = True,
    scale: bool = True,
    visibility: bool = True,
) -> None:
    """锁定变换属性并隐藏。"""
    if isinstance(target_nodes, str):
        target_nodes = [target_nodes]

    attrs_to_process = []
    if translate:
        attrs_to_process.extend(["tx", "ty", "tz"])
    if rotate:
        attrs_to_process.extend(["rx", "ry", "rz"])
    if scale:
        attrs_to_process.extend(["sx", "sy", "sz"])
    if visibility:
        attrs_to_process.append("v")

    for node in target_nodes:
        if not cmds.objExists(node):
            continue
        for attr in attrs_to_process:
            full_attr = f"{node}.{attr}"
            try:
                cmds.setAttr(full_attr, lock=True, keyable=False, channelBox=False)
            except Exception:
                pass


def reset_transform(target_node: str) -> None:
    """
    [新增] 重置变换属性 (T=0, R=0, S=1) 并清空 freezeTransform。
    这里仅简单地将属性设为默认值，不做 MakeIdentity。
    """
    if not cmds.objExists(target_node):
        return

    try:
        cmds.setAttr(f"{target_node}.translate", 0, 0, 0)
        cmds.setAttr(f"{target_node}.rotate", 0, 0, 0)
        cmds.setAttr(f"{target_node}.scale", 1, 1, 1)
    except Exception as e:
        print(f"[Tool] Reset Transform Error {target_node}: {e}")


############################################
# name part
############################################


def get_unique_name(name: str) -> str:
    """生成唯一名称。"""
    if not cmds.objExists(name):
        return name
    i = 1
    new_name = f"{name}_{i}"
    while cmds.objExists(new_name):
        i += 1
        new_name = f"{name}_{i}"
    return new_name


def valid_name(name: str) -> str:
    """清理字符串为合法 Maya 名称。"""
    name = str(name).replace(" ", "_")
    name = re.sub(r"[^a-zA-Z0-9_]", "", name)
    if name and name[0].isdigit():
        name = "_" + name
    return name


def rename_hierarchy(
    root_node: str,
    prefix: str = "",
    suffix: str = "",
    replace_list: Optional[List[tuple]] = None,
    include_root: bool = True,
) -> str:
    """
    自下而上重命名层级。
    """
    if not cmds.objExists(root_node):
        return root_node

    full_root = cmds.ls(root_node, long=True)[0]
    descendants = (
        cmds.listRelatives(
            full_root, allDescendents=True, type="transform", fullPath=True
        )
        or []
    )

    nodes_to_rename = []
    nodes_to_rename.extend(descendants)
    if include_root:
        nodes_to_rename.append(full_root)

    nodes_to_rename.sort(key=lambda x: x.count("|"), reverse=True)

    new_root_name = root_node

    for node_long_name in nodes_to_rename:
        short_name = node_long_name.split("|")[-1]
        base_name = short_name

        if replace_list:
            for search_str, replace_str in replace_list:
                base_name = base_name.replace(search_str, replace_str)

        final_name = f"{prefix}{base_name}{suffix}"

        if final_name != short_name:
            try:
                renamed = cmds.rename(node_long_name, final_name)
                if node_long_name == full_root:
                    new_root_name = renamed
            except Exception as e:
                print(f"Warning: Rename failed {short_name} -> {final_name}: {e}")

    return new_root_name


def get_short_name(path: str) -> str:
    """
    Get the short name from a full DAG path.
    """
    if not path:
        return ""
    return path.split("|")[-1]
