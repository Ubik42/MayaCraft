# core/rigging/basic/ik.py
# -*- coding: utf-8 -*-
"""
ik.py
IK 控制器模块。

功能：
1. 创建 IKX 影子骨骼链驱动原始骨骼。
2. 生成符合特定层级结构的 IK 控制器组和 PV 控制器组。
"""

import maya.cmds as cmds
from core import controller
from core import tool


def build_ik_system(
        start_jnt: str,
        end_jnt: str,
        name: str = None,
        ik_type: str = 'RP',
):
    """
    创建基于 IKX 影子骨骼的 IK 系统。
    
    Args:
        start_jnt (str): 起始骨骼 (如 Shoulder_R)
        end_jnt (str): 末端骨骼 (如 Wrist_R)
        name (str): 系统名称 (如 Arm_R)，若不提供则默认使用 end_jnt 的短名
    """
    ik_joints_parent = "IKJoints"
    ik_ctrl_parent = "IKHandle"
    ik_pv_parent = "IKPoleVector" 

    # 1. 解析命名
    start_short = start_jnt.split("|")[-1]
    end_short = end_jnt.split("|")[-1]

    # 获取链条骨骼列表 (用于复制)
    bind_chain = _get_chain_between(start_jnt, end_jnt)
    if not bind_chain:
        print(f"[IK] Error: Cannot find chain between {start_jnt} and {end_jnt}")
        return None

    start_jnt_short = bind_chain[0].split("|")[-1]
    mid_jnt_short = bind_chain[1].split("|")[-1] if len(bind_chain) > 1 else None

    # 系统名 (用于控制器)
    # 如果没传 name，使用 end_short (比如 Wrist_R)
    sys_name = name if name else end_short

    # ---------------------------------------------------------
    # 第一组：IKX 骨骼链 (Group 1)
    # ---------------------------------------------------------
    # 重新复制完整层级
    temp_root = cmds.duplicate(start_jnt, renameChildren=True)[0]

    # 收集需要的节点并重命名
    # Helper: 递归或者根据 bind_chain 长度向下找
    ikx_joints = []
    curr = temp_root
    for orig in bind_chain:
        orig_short = orig.split("|")[-1]
        target_name = f"IKX{orig_short}"
        renamed = cmds.rename(curr, target_name)
        ikx_joints.append(renamed)

        # 下一个
        # [修改] 查找下一个非 Part 的子级
        def get_next_real_child(node):
            children = cmds.listRelatives(node, c=True, type='joint', f=True)
            if not children: return None
            for child in children:
                if cmds.attributeQuery("isInbetweenPart", node=child, exists=True):
                     # 递归查找
                     res = get_next_real_child(child)
                     if res: return res
                else:
                    return child
            return None

        curr = get_next_real_child(renamed)
        if not curr:
            break

    # 删除多余子级 (Prune Side Branches)
    # 对于链条中的每一个关节，如果有子级不在链条下一层，则删除 (分支)
    # 删除多余子级 (Prune Side Branches) & Connect Chain (Skip Parts)
    for i in range(len(ikx_joints)):
        # 1. 获取当前骨骼的最新路径 (因为上一步可能移动了它，导致路径变更)
        # 使用 ls 查找，假定 IKX 名字唯一 (Rename 已经保证了 naming convention)
        search = cmds.ls(ikx_joints[i], long=True)
        if not search: continue
        curr_jnt = search[0]
        
        # 2. 获取下一个链条骨骼
        next_jnt_name = ikx_joints[i+1] if i < len(ikx_joints) - 1 else None
        next_jnt_full = None
        
        if next_jnt_name:
            search_next = cmds.ls(next_jnt_name, long=True)
            if search_next:
                next_jnt_full = search_next[0]
                
                # Check parent
                parents = cmds.listRelatives(next_jnt_full, parent=True, fullPath=True)
                current_parent = parents[0] if parents else None
                
                # 如果下一个骨骼的父级不是当前骨骼 (说明中间有 Part 隔开了)
                # 重新 Parent，直接连接 Key Joints
                if current_parent != curr_jnt:
                    # 先解锁 Transform 避免 Offset 错误? IKX 都是 duplicated，应该是干净的
                    # Reparent next to curr
                    cmds.parent(next_jnt_full, curr_jnt)
                    # 更新 next_jnt_full 的路径
                    next_jnt_full = cmds.ls(next_jnt_name, long=True)[0]

        # 3. 清理多余分支 (此时 next_jnt 已经是直接子级了，其他的都是多余的 Part 或杂物)
        children = cmds.listRelatives(curr_jnt, children=True, fullPath=True) or []
        
        for child in children:
            # 比较 child 和 next_jnt_full
            # 注意 Path 比较
            if next_jnt_full and child == next_jnt_full:
                continue # 保留下一个节点
            
            # 删除多余项 (比如 xxx_Part1)
            try:
                cmds.delete(child)
            except:
                pass

    ikx_start = ikx_joints[0]
    ikx_mid = ikx_joints[1] if len(ikx_joints) > 1 else None
    ikx_end = ikx_joints[-1]

    # 创建 IKXOffset
    ikx_offset_name = f"IKXOffset{start_short}"
    ikx_offset = cmds.createNode("transform", name=ikx_offset_name)
    cmds.matchTransform(ikx_offset, start_jnt, pos=True, rot=True)

    # Parent Chain to Offset
    # 首先解绑 ikx_start 的父级 (duplicate 出来可能在世界也可能在原父级下)
    if cmds.listRelatives(ikx_start, p=True):
        cmds.parent(ikx_start, world=True)
    cmds.parent(ikx_start, ikx_offset)

    # [New] Parent Offset to System Group
    if ik_joints_parent and cmds.objExists(ik_joints_parent):
        tool.safe_parent(ikx_offset, ik_joints_parent)

    # 驱动原始骨骼
    for orig, ikx in zip(bind_chain, ikx_joints):
        cmds.parentConstraint(ikx, orig, maintainOffset=True)
        cmds.scaleConstraint(ikx, orig, maintainOffset=True)


    # ---------------------------------------------------------
    # 创建 IK Solver (Handle & Effector)
    # ---------------------------------------------------------
    solver_name = 'ikRPsolver' if ik_type == 'RP' else 'ikSCsolver'
    handle_name = f"IK{sys_name}Handle"

    ik_handle_nodes = cmds.ikHandle(
        name=handle_name,
        startJoint=ikx_start,
        endEffector=ikx_end,
        solver=solver_name
    )
    ik_handle = ik_handle_nodes[0]
    ik_effector = cmds.rename(ik_handle_nodes[1], f"IK{sys_name}Effector")

    cmds.setAttr(f"{ik_handle}.visibility", 0)


    # ---------------------------------------------------------
    # 第二组：IK Control (Group 2)
    # ---------------------------------------------------------
    # 结构: IKOffset -> IKExtra -> IKCtrl -> IKHandle

    ik_offset_name = f"IKOffset{sys_name}"
    ik_extra_name = f"IKExtra{sys_name}"
    ik_ctrl_name = f"IK{sys_name}"

    ik_offset = cmds.createNode("transform", name=ik_offset_name)
    ik_extra = cmds.createNode("transform", name=ik_extra_name)

    # 创建控制器 Curve
    ik_ctrl = cmds.circle(name=ik_ctrl_name, normal=(0, 1, 0), radius=1.0, ch=False)[0]
    # controller.apply_stored_shape(ik_ctrl, main_shape) # Logic Removed

    # 层级
    cmds.parent(ik_ctrl, ik_extra)
    cmds.parent(ik_extra, ik_offset)

    # 归位 (匹配末端)
    cmds.matchTransform(ik_offset, end_jnt, pos=True, rot=True)

    # 将 Handle 放入控制器
    cmds.parent(ik_handle, ik_ctrl)

    # [New] Parent Offset to System Group
    if ik_ctrl_parent and cmds.objExists(ik_ctrl_parent):
        tool.safe_parent(ik_offset, ik_ctrl_parent)

    # ---------------------------------------------------------
    # 第三组 & Helper: Pole Vector (Group 3 + Annotation)
    # ---------------------------------------------------------
    pv_ctrl = None
    pv_offset = None

    if ik_type == 'RP':
        # 结构: PoleOffset -> PoleExtra -> PoleCtrl -> PoleLoc

        pole_offset_name = f"PoleOffset{sys_name}"
        pole_extra_name = f"PoleExtra{sys_name}"
        pole_ctrl_name = f"Pole{sys_name}"
        pole_loc_name = f"PoleLoc{sys_name}"

        pv_offset = cmds.createNode("transform", name=pole_offset_name)
        pv_extra = cmds.createNode("transform", name=pole_extra_name)

        pv_ctrl = cmds.circle(name=pole_ctrl_name, normal=(0, 0, 1), radius=0.5, ch=False)[0]
        # controller.apply_stored_shape(pv_ctrl, pv_shape) # Logic Removed

        pv_loc = cmds.spaceLocator(name=pole_loc_name)[0]
        # Locator 通常只是个视觉点或者用于抓取，这里作为子级
        cmds.parent(pv_loc, pv_ctrl)
        cmds.setAttr(f"{pv_loc}.visibility", 0) # 通常如果不需显示可隐掉，或者改 Shape

        # 层级
        cmds.parent(pv_ctrl, pv_extra)
        cmds.parent(pv_extra, pv_offset)

        # 计算位置
        pv_pos = _calculate_pv_pos(start_jnt, end_jnt)
        cmds.xform(pv_offset, translation=pv_pos, worldSpace=True)

        # 约束 Handle
        cmds.poleVectorConstraint(pv_ctrl, ik_handle)

        # [New] Parent PV Offset to System Group
        if ik_pv_parent and cmds.objExists(ik_pv_parent):
            tool.safe_parent(pv_offset, ik_pv_parent)

        # PoleAnnotation (归属第一组，IKX中段下)
        if ikx_mid:
            # 创建 Annotation
            # annotate指令: cmds.annotate(object_to_point_to, tx="...", p=start_point)
            # 这里的 object_to_point_to 是 pv_ctrl
            annotation_node = cmds.annotate(pv_ctrl, text=" ", point=(0,0,0))
            # annotation_node 是 transform (e.g. annotation1)
            # 它的 shape 是 annotationShape1

            annotation_trans = cmds.listRelatives(annotation_node, parent=True)[0] if cmds.objectType(annotation_node) == 'annotationShape' else annotation_node

            # 重命名
            annot_name = f"PoleAnnotation{sys_name}"
            annotation_trans = cmds.rename(annotation_trans, annot_name)

            # 设置属性
            cmds.setAttr(f"{annotation_trans}.template", 1) # 参考模式，灰色线

            # Parent 到 IKX 中段 (Elbow)
            cmds.parent(annotation_trans, ikx_mid)

            # 归零 (让起点对齐 Elbow)
            cmds.setAttr(f"{annotation_trans}.translate", 0, 0, 0)
            cmds.setAttr(f"{annotation_trans}.rotate", 0, 0, 0)

    # ---------------------------------------------------------
    # 返回字典 (无类)
    # ---------------------------------------------------------
    return {
        "ikx_offset": ikx_offset,
        "ikx_joints": ikx_joints,
        "ik_offset": ik_offset,
        "ik_ctrl": ik_ctrl,
        "ik_handle": ik_handle,
        "pv_offset": pv_offset,
        "pv_ctrl": pv_ctrl
    }


def _get_chain_between(start, end):
    """获取 start 到 end 的骨骼路径列表"""
    chain = []
    curr = end
    start_short = start.split('|')[-1]

    safeguard = 0
    while safeguard < 100:
        # [修改] 过滤 Inbetween Parts
        if not cmds.attributeQuery("isInbetweenPart", node=curr, exists=True):
            chain.append(curr)
            
        if curr.split('|')[-1] == start_short:
            break
        p = cmds.listRelatives(curr, p=True, f=True)
        if p:
            curr = p[0]
        else:
            break
        safeguard += 1

    if len(chain) > 0 and chain[-1].split("|")[-1] != start_short:
        return []

    return list(reversed(chain))

def _get_mid_joint(end):
    p = cmds.listRelatives(end, p=True, f=True)
    return p[0] if p else None

def _calculate_pv_pos(start, end):
    mid = _get_mid_joint(end)
    if not mid:
        pos = cmds.xform(start, q=True, ws=True, t=True)
        return [pos[0], pos[1] + 5, pos[2]]
    return cmds.xform(mid, q=True, ws=True, t=True)