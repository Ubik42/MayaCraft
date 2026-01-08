# core/rigging/fk.py
# -*- coding: utf-8 -*-
"""
fk.py
FK 控制器模块。
修改版：
1. 返回数据包含约束节点。
2. 移除 add_fk 内部的自动父子化逻辑，将控制权交还给调用者。
3. 增加对长路径骨骼名的兼容处理。
"""

import maya.cmds as cmds
from typing import Optional, List
from core import tool # [新增]


class FkCtl(object):
    """
    FK 控制器数据类。
    """

    def __init__(self, name: str, offset_group: str, controlled_bone: str, constraint: str = None):
        self.name = name  # 控制器名称 (Circle)
        self.offset_group = offset_group  # 偏移组名称 (Group)
        self.controlled_bone = controlled_bone  # 受控骨骼
        self.constraint = constraint  # 约束节点名称

    def __repr__(self) -> str:
        return f"FkCtl(ctrl='{self.name}', grp='{self.offset_group}')"


def add_fk(
        target_bone: str,
        radius: float = 1.0
) -> Optional[FkCtl]:
    """
    为单个骨骼创建 FK 控制器 (仅旋转)。

    Args:
        target_bone: 骨骼名称 (支持全路径)。
        radius: 控制器半径。

    Returns:
        FkCtl 对象，包含控制器、组和约束节点。
    """
    if not cmds.objExists(target_bone):
        return None

    # 1. 命名处理 (确保使用短名作为前缀，防止长路径报错)
    bone_short = target_bone.split("|")[-1]

    ctrl_name = f"{bone_short}_fk_ctrl"
    grp_name = f"grp_{ctrl_name}"

    if cmds.objExists(ctrl_name) or cmds.objExists(grp_name):
        print(f"[FK] Warning: Controller {ctrl_name} already exists. Skipping.")
        return None

    # 2. 创建层级
    offset_grp = cmds.group(empty=True, name=grp_name)
    ctrl = cmds.circle(name=ctrl_name, normal=(1, 0, 0), radius=radius, ch=False)[0]
    cmds.parent(ctrl, offset_grp)

    # 3. 对齐 (使用传入的 target_bone，可能是长路径)
    cmds.matchTransform(offset_grp, target_bone, pos=True, rot=True)

    # 4. 同步 Rotate Order
    try:
        ro = cmds.getAttr(f"{target_bone}.rotateOrder")
        cmds.setAttr(f"{ctrl}.rotateOrder", ro)
    except Exception:
        pass

    # 5. 锁定属性 (只留旋转)
    tool.lock_transform(ctrl, translate=True, scale=True, visibility=True, rotate=False)

    # 6. 强制解锁骨骼并创建约束
    tool.unlock_transform(target_bone, rotate=True, translate=False, scale=False, visibility=False)

    constraint_node = None
    try:
        # orientConstraint 返回列表，取第一个
        cons = cmds.orientConstraint(ctrl, target_bone, maintainOffset=True)
        if cons:
            constraint_node = cons[0]
    except Exception as e:
        print(f"[FK] Error constraining {target_bone}: {e}")

    # [修改] 移除了自动父子化逻辑 (Auto-parenting removed)
    # 调用者如果有层级需求，应拿到返回值后自行 parent offset_grp

    return FkCtl(ctrl, offset_grp, target_bone, constraint_node)


def add_fk_to_hierarchy(
        start_bone: str,
        end_bone: Optional[str] = None,
        start_radius: float = 2.0,
        radius_decrement: float = 0.2
) -> List[FkCtl]:
    """
    递归创建 FK 链，并自动处理链条内部的父子关系。
    """

    # 获取骨骼链
    chain = []
    curr = start_bone
    count = 0
    # 处理长路径匹配 end_bone
    end_short = end_bone.split("|")[-1] if end_bone else None

    while curr and count < 100:
        chain.append(curr)

        curr_short = curr.split("|")[-1]
        if end_bone and curr_short == end_short:
            break

        children = cmds.listRelatives(curr, children=True, type='joint', fullPath=True)
        if not children:
            break
        curr = children[0]
        count += 1

    created_controls = []
    prev_ctrl = None

    for i, bone_name in enumerate(chain):
        # 排除未指定的末端 (如果不是 end_bone 且没有子骨骼，通常不需要 FK)
        children = cmds.listRelatives(bone_name, children=True, type='joint')
        is_leaf = not children
        curr_short = bone_name.split("|")[-1]
        is_specified_end = (end_bone and curr_short == end_short)

        if is_leaf and not is_specified_end:
            continue

        # 计算半径
        radius = max(0.5, start_radius - (i * radius_decrement))

        # 创建 FK
        fk_inst = add_fk(bone_name, radius)

        if fk_inst:
            # [新增] 显式处理父子关系
            # 因为 add_fk 不再自动 parent，这里负责把当前组放到上一个控制器下
            if prev_ctrl:
                try:
                    cmds.parent(fk_inst.offset_group, prev_ctrl.name)
                except Exception as e:
                    print(f"[FK] Hierarchy Error: {e}")

            created_controls.append(fk_inst)
            prev_ctrl = fk_inst

    return created_controls