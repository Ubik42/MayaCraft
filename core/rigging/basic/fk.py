# core/rigging/basic/fk.py
# -*- coding: utf-8 -*-
"""
fk.py
FK 控制器模块。

功能：
1. 递归构建 FK 层级 (Offset -> Extra -> Ctrl -> FKX)。
2. 自动将其置于 FKSystem 组下。
"""

import maya.cmds as cmds
import math
from typing import Optional, List
from MayaCraft.core import tool

fk_sys = "FKSystem"


def build_fk_hierarchy(start_joint: str):
    """
    递归构建 FK 层级系统。
    """
    _process_hierarchy_recursive(start_joint, fk_sys)


def _process_hierarchy_recursive(current_joint, parent_output):
    """
    内部递归函数。
    """
    # 0. 获取子骨骼
    # [修改] 获取下一个"真实"子骨骼 (跳过 Inbetween Parts)
    # 原逻辑: children = cmds.listRelatives(current_joint, children=True, type="joint", fullPath=True) or []

    children = (
        cmds.listRelatives(current_joint, children=True, type="joint", fullPath=True)
        or []
    )

    # [Common] 如果是叶子骨骼且无子级，通常跳过 (可根据需求调整)
    if not children:
        return

    # [Common] 计算半径 (基于与首个子骨骼的距离)
    radius = 2.0
    if children:
        child_joint = children[0]
        p1 = cmds.xform(current_joint, q=True, t=True, ws=True)
        p2 = cmds.xform(child_joint, q=True, t=True, ws=True)
        dist = math.sqrt(sum([(a - b) ** 2 for a, b in zip(p1, p2)]))
        if dist > 0.001:
            radius = dist * 0.25

    # 1. 创建节点
    # parent_output 在这里是 parent_fkx_joint
    current_output = _create_fk_unit(current_joint, radius, parent_output)

    # 2. 递归
    for child in children:
        _process_hierarchy_recursive(child, current_output)


def _create_fk_unit(
    current_joint: str, radius: float, parent_fkx: Optional[str]
) -> Optional[str]:
    """
    创建单节 FK 单元: Scale Constraint + Parent Constraint
    Structure: FKOffset -> FKExtra -> FK -> FKX
    Returns: FKX 影子骨骼名
    """
    short_name = current_joint.split("|")[-1]

    offset_name = f"FKOffset_{short_name}"
    extra_name = f"FKExtra_{short_name}"
    ctrl_name = f"FK_{short_name}"
    fkx_name = f"FKX_{short_name}"

    if cmds.objExists(ctrl_name) and cmds.objExists(fkx_name):
        return fkx_name

    # 1. 创建结构
    # A. Offset Group (Matches Joint Data)
    offset_node = cmds.createNode("transform", name=offset_name)

    # Sync RotateOrder to avoid Gimbal mismatch (Crucial for "Consistent Axis" feel)
    ro = cmds.getAttr(f"{current_joint}.rotateOrder")
    cmds.setAttr(f"{offset_node}.rotateOrder", ro)

    # Match Transform (Aligns Offset LRA with Joint LRA in World Space)
    # Since offset has same RO, values should be cleaner.
    cmds.matchTransform(offset_node, current_joint, pos=True, rot=True)

    # B. Extra & Ctrl
    extra_node = cmds.createNode("transform", name=extra_name, parent=offset_node)
    tool.reset_transform(extra_node)
    cmds.setAttr(f"{extra_node}.rotateOrder", ro)

    ctrl_node = cmds.circle(name=ctrl_name, nr=(1, 0, 0), r=radius, ch=False)[0]
    cmds.parent(ctrl_node, extra_node)
    tool.reset_transform(ctrl_node)
    cmds.setAttr(f"{ctrl_node}.rotateOrder", ro)
    tool.set_draw(ctrl_node, color=17)  # 黄色

    # C. FKX Joint (Use Duplicate to keep properties)
    cmds.select(clear=True)
    # Duplicate parentOnly ensures we get the node settings but no children
    fkx_node = cmds.duplicate(current_joint, parentOnly=True, name=fkx_name)[0]

    # Parent to Control
    if cmds.listRelatives(fkx_node, parent=True) != [ctrl_node]:
        cmds.parent(fkx_node, ctrl_node)

    # Reset Transforms & Orientation
    # Why? Because Offset/Ctrl is ALREADY aligned to the Joint's World Orientation.
    # If FKX retains jointOrient, it Double Rotates (OffsetRot + JointOrient).
    # We must Zero it out so it aligns 1:1 with Control, which aligns 1:1 with Joint.
    cmds.setAttr(f"{fkx_node}.translate", 0, 0, 0)
    cmds.setAttr(f"{fkx_node}.rotate", 0, 0, 0)
    cmds.setAttr(f"{fkx_node}.scale", 1, 1, 1)
    cmds.setAttr(f"{fkx_node}.jointOrient", 0, 0, 0)
    cmds.setAttr(f"{fkx_node}.rotateAxis", 0, 0, 0)

    cmds.setAttr(f"{fkx_node}.drawStyle", 2)  # None
    # Ensure FKX visible? Inherits from parent.

    # 2. 层级连接
    # 如果有上级 FKX，则 Parent 到上级 FKX (实现 FK 链式行为)
    # 如果没有上级 (链根)，则 Parent 到 FKSystem
    if parent_fkx and cmds.objExists(parent_fkx):
        tool.safe_parent(offset_node, parent_fkx)
    else:
        print(f"[FK] Root detected for {short_name}")
        # Normally parented to FKSystem by caller or outside loop

    # 3. 约束 Bind 骨骼
    tool.unlock_transform(current_joint)
    try:
        # 约束前先确保 FKX 确实在位置上 (Should be perfect due to Reset + Match)
        cmds.parentConstraint(fkx_node, current_joint, maintainOffset=True)
        # Scale might need offset maintenance if Bind joint has weird scale
        cmds.scaleConstraint(fkx_node, current_joint, maintainOffset=True)
    except Exception as e:
        print(f"[FK] Error constraining {current_joint}: {e}")

    return fkx_node
