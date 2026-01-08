# core/tool.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
import re  # [新增] 必须导入正则模块
from typing import List, Union, Tuple, Optional

############################################
#util part
############################################

def safe_parent(child: str, parent: str) -> None:
    """
    [新增] 安全父子约束。
    防止对象不存在、参数为空或已经是父子关系时报错。
    """
    if not child or not parent:
        return
    if not cmds.objExists(child) or not cmds.objExists(parent):
        return

    try:
        # 检查当前父级，如果是同一个就不操作，避免报错
        current_parents = cmds.listRelatives(child, parent=True)
        if current_parents and current_parents[0] == parent:
            return
        cmds.parent(child, parent)
    except Exception as e:
        print(f"Warning: safe_parent failed for {child} -> {parent}: {e}")

############################################
#attribute part
############################################

def set_draw(
        target_nodes: Union[str, List[str]],
        enable_overrides: Optional[bool] = None,
        display_type: Optional[int] = None,
        visible: Optional[bool] = None,
        color: Optional[Union[int, Tuple[float, float, float]]] = None
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

        # 设置 Transform 可见性
        if visible is not None:
            try:
                cmds.setAttr(f"{node}.visibility", visible)
            except:
                pass

        # 设置 Shape 属性
        shape_nodes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
        # 处理 Locator 等自身即 Shape 或无 Shape 的情况
        if not shape_nodes and cmds.nodeType(node) in ['locator', 'camera', 'nurbsCurve', 'mesh']:
             # 如果它本身就是 shape 类型（虽然通常传入 transform）
             pass
        elif not shape_nodes:
             # 有些空组没有 shape
             continue

        for shape in shape_nodes:
            try:
                if enable_overrides is not None:
                    cmds.setAttr(f"{shape}.overrideEnabled", enable_overrides)

                if display_type is not None:
                    cmds.setAttr(f"{shape}.overrideDisplayType", display_type)

                if color is not None:
                    if isinstance(color, int):
                        # Index Color (0-31)
                        cmds.setAttr(f"{shape}.overrideRGBColors", 0)
                        cmds.setAttr(f"{shape}.overrideColor", color)
                    elif isinstance(color, (list, tuple)) and len(color) == 3:
                        # RGB Color
                        cmds.setAttr(f"{shape}.overrideRGBColors", 1)
                        cmds.setAttr(f"{shape}.overrideColorRGB", *color)
            except Exception:
                pass


def unlock_transform(
        target_nodes: Union[str, List[str]],
        translate: bool = True,
        rotate: bool = True,
        scale: bool = True,
        visibility: bool = True,
        keyable: bool = True
) -> None:
    """解锁变换属性。"""
    if isinstance(target_nodes, str):
        target_nodes = [target_nodes]

    attrs_to_process = []
    if translate: attrs_to_process.extend(['tx', 'ty', 'tz'])
    if rotate:    attrs_to_process.extend(['rx', 'ry', 'rz'])
    if scale:     attrs_to_process.extend(['sx', 'sy', 'sz'])
    if visibility: attrs_to_process.append('v')

    for node in target_nodes:
        if not cmds.objExists(node): continue
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
        visibility: bool = True
) -> None:
    """[新增] 锁定变换属性并隐藏 (用于 FK/IK 控制器清理)。"""
    if isinstance(target_nodes, str):
        target_nodes = [target_nodes]

    attrs_to_process = []
    if translate: attrs_to_process.extend(['tx', 'ty', 'tz'])
    if rotate:    attrs_to_process.extend(['rx', 'ry', 'rz'])
    if scale:     attrs_to_process.extend(['sx', 'sy', 'sz'])
    if visibility: attrs_to_process.append('v')

    for node in target_nodes:
        if not cmds.objExists(node): continue
        for attr in attrs_to_process:
            full_attr = f"{node}.{attr}"
            try:
                cmds.setAttr(full_attr, lock=True, keyable=False, channelBox=False)
            except Exception:
                pass

############################################
#name part
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
    name = re.sub(r'[^a-zA-Z0-9_]', '', name)
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
    自下而上重命名层级。
    """
    if not cmds.objExists(root_node):
        return root_node

    full_root = cmds.ls(root_node, long=True)[0]
    descendants = cmds.listRelatives(full_root, allDescendents=True, type='transform', fullPath=True) or []

    nodes_to_rename = []
    nodes_to_rename.extend(descendants)
    if include_root:
        nodes_to_rename.append(full_root)

    # 关键：按路径深度降序排序 (先改子，后改父)
    nodes_to_rename.sort(key=lambda x: x.count('|'), reverse=True)

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