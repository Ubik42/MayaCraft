# core/rigging/stretchy.py
# -*- coding: utf-8 -*-
"""
stretchy.py
模块用于为【单条】IK骨骼链创建带开关和体积保持功能的可拉伸效果。
修复版：
1. 移除 SSC 修改。
2. 将缩放直接应用到 Bind Chain (原始骨骼) 上，而非 IK 驱动骨骼。
"""

import maya.cmds as cmds
import math
from typing import Optional, List


def get_distance(obj_a, obj_b):
    """计算两点世界空间距离"""
    p1 = cmds.xform(obj_a, q=True, ws=True, t=True)
    p2 = cmds.xform(obj_b, q=True, ws=True, t=True)
    return math.sqrt(pow(p1[0] - p2[0], 2) + pow(p1[1] - p2[1], 2) + pow(p1[2] - p2[2], 2))


def get_primary_axis(joint):
    """检测骨骼的主轴"""
    children = cmds.listRelatives(joint, children=True, type='joint')
    if not children:
        return 'x', ['y', 'z']

    child = children[0]
    tx = abs(cmds.getAttr(f"{child}.tx"))
    ty = abs(cmds.getAttr(f"{child}.ty"))
    tz = abs(cmds.getAttr(f"{child}.tz"))

    if tx >= ty and tx >= tz:
        return 'x', ['y', 'z']
    elif ty >= tx and ty >= tz:
        return 'y', ['x', 'z']
    else:
        return 'z', ['x', 'y']


def create_stretchy_ik(
        start_bone: str,
        end_bone: str,
        stretch_control: str,
        bind_chain: List[str] = None  # [新增] 接收原始骨骼链列表
) -> bool:
    """
    创建拉伸系统。
    """
    # 1. 获取 IK 链条 (用于计算原始长度)
    if bind_chain:
        ik_chain = bind_chain
    else:
        # 回退到自动查找 (仅当没传 bind_chain 时)
        ik_chain = []
        curr = end_bone
        count = 0
        while curr and count < 100:
            ik_chain.append(curr)
            if curr == start_bone: break
            p = cmds.listRelatives(curr, p=True)
            if p:
                curr = p[0]
            else:
                break
            count += 1
        ik_chain.reverse()

        if not ik_chain or ik_chain[0] != start_bone:
            return False

    # 2. 计算原始总长度
    original_length = 0.0
    for i in range(len(ik_chain) - 1):
        original_length += get_distance(ik_chain[i], ik_chain[i + 1])

    if original_length < 0.001:
        return False

    # 3. 创建距离测量
    # 注意: Locators 需要跟随 StartBone 和 Control
    # start_bone 参数在这里作为 Locator 的约束目标
    start_loc = cmds.spaceLocator(n=f"{start_bone}_measure_start")[0]
    end_loc = cmds.spaceLocator(n=f"{end_bone}_measure_end")[0]
    cmds.hide(start_loc, end_loc)

    cmds.pointConstraint(start_bone, start_loc, mo=False)
    cmds.pointConstraint(stretch_control, end_loc, mo=False)

    dist_node = cmds.createNode('distanceBetween', n=f"{start_bone}_dist")
    cmds.connectAttr(f"{start_loc}.worldPosition[0]", f"{dist_node}.point1")
    cmds.connectAttr(f"{end_loc}.worldPosition[0]", f"{dist_node}.point2")

    # 4. 计算比率
    ratio = cmds.createNode('multiplyDivide', n=f"{start_bone}_ratio")
    cmds.setAttr(f"{ratio}.operation", 2)  # Divide
    cmds.connectAttr(f"{dist_node}.distance", f"{ratio}.input1X")
    cmds.setAttr(f"{ratio}.input2X", original_length)

    # 5. 条件节点
    cond = cmds.createNode('condition', n=f"{start_bone}_cond")
    cmds.setAttr(f"{cond}.operation", 2)  # Greater Than
    cmds.connectAttr(f"{dist_node}.distance", f"{cond}.firstTerm")
    cmds.setAttr(f"{cond}.secondTerm", original_length)
    cmds.connectAttr(f"{ratio}.outputX", f"{cond}.colorIfTrueR")
    cmds.setAttr(f"{cond}.colorIfFalseR", 1.0)

    # 6. 开关 Blend (改为 Bool 类型)
    attr = "Stretchy"
    if not cmds.attributeQuery(attr, node=stretch_control, exists=True):
        cmds.addAttr(stretch_control, ln=attr, at='bool', dv=1, k=True)

    blend = cmds.createNode('blendColors', n=f"{start_bone}_stretchy_blend")
    cmds.connectAttr(f"{stretch_control}.{attr}", f"{blend}.blender")
    cmds.connectAttr(f"{cond}.outColorR", f"{blend}.color1R")
    cmds.setAttr(f"{blend}.color2R", 1.0)

    final_scale = f"{blend}.outputR"

    # 7. 体积保持
    vol_node = cmds.createNode('multiplyDivide', n=f"{start_bone}_vol_calc")
    cmds.setAttr(f"{vol_node}.operation", 3)  # Power
    cmds.connectAttr(final_scale, f"{vol_node}.input1X")
    cmds.setAttr(f"{vol_node}.input2X", -0.5)
    final_vol = f"{vol_node}.outputX"

    # 8. 驱动骨骼 - [核心修改] 驱动 Bind Chain 而不是 IK Chain
    # 如果没有传入 bind_chain，则回退到驱动 ik_chain (兼容性)
    target_chain = bind_chain if bind_chain else ik_chain

    # 遍历除了末端以外的骨骼
    for jnt in target_chain[:-1]:
        # [已移除] segmentScaleCompensate 修改逻辑

        # 自动判断轴向 (如果 Bind Chain 的轴向和 IK Chain 一致)
        primary, others = get_primary_axis(jnt)

        scale_map = {'x': 'scaleX', 'y': 'scaleY', 'z': 'scaleZ'}

        # 连接拉伸 (Length)
        cmds.connectAttr(final_scale, f"{jnt}.{scale_map[primary]}", f=True)

        # 连接体积 (Volume)
        for axis in others:
            cmds.connectAttr(final_vol, f"{jnt}.{scale_map[axis]}", f=True)

    # 9. 整理
    grp = cmds.group(empty=True, n=f"{start_bone}_stretchy_utils")
    cmds.parent(start_loc, end_loc, grp)
    cmds.hide(grp)

    parents = cmds.listRelatives(stretch_control, p=True)
    if parents:
        try:
            cmds.parent(grp, parents[0])
        except Exception:
            pass

    return True