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


############################################
# joint part
############################################


# def orient_joint(joint: str, direction_bool: bool) -> None:
#     """
#     Orient the joint specifically for the rigging system using Pure Matrix Math.
#
#     Args:
#         joint (str): Joint to orient.
#         direction_bool (bool):
#             True (Right/Center) -> X points to Child, Y points to World +X.
#             False (Left)        -> X points Opposite Child, Y points to World -X.
#     """
#     if not cmds.objExists(joint):
#         return
#
#     children = (
#         cmds.listRelatives(joint, children=True, type="transform", fullPath=True) or []
#     )
#
#     # 1. Capture Children World Matrices
#     child_matrices = {}
#     if children:
#         for child in children:
#             child_matrices[child] = cmds.xform(child, q=True, m=True, ws=True)
#
#     try:
#         if children:
#             # --- Vector Calculation ---
#             # Get Positions
#             j_pos = om.MVector(cmds.xform(joint, q=True, t=True, ws=True))
#             # Aim at first child
#             c_pos = om.MVector(cmds.xform(children[0], q=True, t=True, ws=True))
#
#             aim_vec = (c_pos - j_pos).normal()
#
#             if direction_bool:
#                 # Right/Center: X -> Child, Up -> World +X
#                 x_axis = aim_vec
#                 up_vec = om.MVector(1, 0, 0)
#             else:
#                 # Left: X -> -Child, Up -> World -X
#                 x_axis = -aim_vec
#                 up_vec = om.MVector(-1, 0, 0)
#
#             # Orthonormalize
#             # Check parallel
#             if abs(x_axis * up_vec) > 0.99:
#                 # Fallback if Aim is parallel to World X
#                 up_vec = om.MVector(0, 1, 0)
#
#             z_axis = (x_axis ^ up_vec).normal()
#             y_axis = (z_axis ^ x_axis).normal()
#
#             # Construct World Rotation Matrix
#             rot_mat_list = [
#                 x_axis.x,
#                 x_axis.y,
#                 x_axis.z,
#                 0.0,
#                 y_axis.x,
#                 y_axis.y,
#                 y_axis.z,
#                 0.0,
#                 z_axis.x,
#                 z_axis.y,
#                 z_axis.z,
#                 0.0,
#                 0.0,
#                 0.0,
#                 0.0,
#                 1.0,
#             ]
#             world_rot_mat = om.MMatrix(rot_mat_list)
#
#             # Convert to Local Space (Multiply by Parent Inverse)
#             # Find parent matrix
#             parents = cmds.listRelatives(joint, parent=True, fullPath=True)
#             if parents:
#                 parent_mat_list = cmds.xform(parents[0], q=True, m=True, ws=True)
#                 parent_mat = om.MMatrix(parent_mat_list)
#                 local_mat = world_rot_mat * parent_mat.inverse()
#             else:
#                 local_mat = world_rot_mat
#
#             # Extract Euler
#             euler = om.MTransformationMatrix(local_mat).rotation()
#             r_deg = [math.degrees(a) for a in (euler.x, euler.y, euler.z)]
#
#             # Apply
#             cmds.setAttr(f"{joint}.jointOrient", *r_deg, type="double3")
#             cmds.setAttr(f"{joint}.rotate", 0, 0, 0, type="double3")
#
#             print(f"  - Math Orient Success: {joint}")
#
#     except Exception as e:
#         print(f"Warning: Failed to orient {joint}: {e}")
#
#     # 3. Restore Children
#     if child_matrices:
#         for child, matrix in child_matrices.items():
#             cmds.xform(child, m=matrix, ws=True)
