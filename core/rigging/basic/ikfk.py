# core/rigging/basic/ikfk.py
# -*- coding: utf-8 -*-
"""
ikfk.py
IK/FK 切换系统模块。

修改版：
1. 移除 IKFKSystem 类，改用字典返回。
2. 移除 Stretchy 功能。
3. 支持 IK 组件的自定义父级 (IKJoints, IKHandle, IKPoleVector)。
"""

import maya.cmds as cmds
from typing import Optional, List, Dict

from core.rigging.basic import ik


def _get_bind_chain_names(start_name: str, end_name: str) -> List[str]:
    """获取从 start 到 end 的所有骨骼名称列表"""
    chain = []
    curr = end_name
    safeguard = 0
    start_short = start_name.split('|')[-1]

    while safeguard < 100:
        # [修改] 过滤 Inbetween Parts
        if not cmds.attributeQuery("isInbetweenPart", node=curr, exists=True):
            chain.append(curr)
        
        if curr.split('|')[-1] == start_short:
            break
        parents = cmds.listRelatives(curr, parent=True, fullPath=True)
        if parents:
            curr = parents[0]
        else:
            break
        safeguard += 1
    return list(reversed(chain))


def _create_ikfk_switch_network(
        start_bone: str,
        end_bone: str,
        ikx_chain: List[str],
        ik_grp_obj: str,
        fk_grp_obj: str,
        pv_ctrl_name: str = None
) -> Dict:
    """创建控制器、约束混合及可见性网络"""

    # 1. 创建 Switch 控制器
    start_short = start_bone.split('|')[-1]
    switch_name = f"IKFK_{start_short}"

    if cmds.objExists(switch_name):
        switch_ctrl = switch_name
    else:
        switch_ctrl = cmds.circle(name=switch_name, normal=(0, 1, 0), radius=1.0, ch=False)[0]
        # controller.apply_stored_shape(switch_ctrl, switch_shape_name) # Logic Removed

        if cmds.objExists(end_bone):
            cmds.matchTransform(switch_ctrl, end_bone, pos=True)
        cmds.move(0, 2.5, 0, switch_ctrl, relative=True, objectSpace=True)

    for attr in ['IKFK_Blend', 'Auto_Vis', 'IK_Vis', 'FK_Vis']:
        if not cmds.attributeQuery(attr, node=switch_ctrl, exists=True):
            if attr == 'IKFK_Blend':
                cmds.addAttr(switch_ctrl, ln=attr, at='float', min=0, max=10, dv=0, k=True)
            else:
                cmds.addAttr(switch_ctrl, ln=attr, at='bool', dv=1, k=True)

    # 2. 获取链条对象
    bind_chain = _get_bind_chain_names(start_bone, end_bone)
    
    # 推导 FKX 链
    fkx_chain = []
    for b in bind_chain:
        short = b.split('|')[-1]
        fkx_chain.append(f"FKX_{short}")

    # 3. 创建约束混合网络
    range_node = cmds.createNode('setRange', name=f"{start_short}_blend_range")
    cmds.setAttr(f"{range_node}.oldMaxX", 10)
    cmds.setAttr(f"{range_node}.maxX", 1)
    cmds.connectAttr(f"{switch_ctrl}.IKFK_Blend", f"{range_node}.valueX")

    rev_node = cmds.createNode('reverse', name=f"{start_short}_blend_rev")
    cmds.connectAttr(f"{range_node}.outValueX", f"{rev_node}.inputX")

    for i, bind_b in enumerate(bind_chain):
        if i >= len(ikx_chain) or i >= len(fkx_chain): break

        ik_b = ikx_chain[i]
        fkx_b = fkx_chain[i]
        
        if not (cmds.objExists(ik_b) and cmds.objExists(fkx_b)):
             print(f"[IKFK] Warning: Missing driver joint. IKX:{ik_b}, FKX:{fkx_b}")
             continue

        try:
             # 获取 Bind 骨骼上的约束
             pc_list = cmds.listConnections(bind_b, type="parentConstraint")
             sc_list = cmds.listConnections(bind_b, type="scaleConstraint")
             
             pc = pc_list[0] if pc_list else None
             sc = sc_list[0] if sc_list else None
             
             # 连接权重
             if pc:
                 pc_targets = cmds.parentConstraint(pc, q=True, weightAliasList=True)
                 if pc_targets:
                     ik_attr = next((x for x in pc_targets if ik_b in x), None)
                     fkx_attr = next((x for x in pc_targets if fkx_b in x), None)
                     
                     if ik_attr and fkx_attr:
                         cmds.connectAttr(f"{range_node}.outValueX", f"{pc}.{ik_attr}", f=True)
                         cmds.connectAttr(f"{rev_node}.outputX", f"{pc}.{fkx_attr}", f=True)

             if sc:
                 sc_targets = cmds.scaleConstraint(sc, q=True, weightAliasList=True)
                 if sc_targets:
                     ik_attr = next((x for x in sc_targets if ik_b in x), None)
                     fkx_attr = next((x for x in sc_targets if fkx_b in x), None)
                     
                     if ik_attr and fkx_attr:
                         cmds.connectAttr(f"{range_node}.outValueX", f"{sc}.{ik_attr}", f=True)
                         cmds.connectAttr(f"{rev_node}.outputX", f"{sc}.{fkx_attr}", f=True)

        except Exception as e:
            print(f"[IKFK] Constraint Blend Error on {bind_b}: {e}")

    # 4. 可见性网络
    # 4. 可见性网络 (使用 Condition 节点实现更稳健的显示逻辑)
    if ik_grp_obj and fk_grp_obj:
        # 逻辑: 只要 Blend > 0，IK 显示；只要 Blend < 10，FK 显示。
        # 这样在中间状态(1-9)两者都显示，方便对位。
        
        # IK Vis Condition: Blend > 0
        ik_cond = cmds.createNode('condition', n=f"{start_short}_ik_vis_cond")
        cmds.connectAttr(f"{switch_ctrl}.IKFK_Blend", f"{ik_cond}.firstTerm")
        cmds.setAttr(f"{ik_cond}.secondTerm", 0)
        cmds.setAttr(f"{ik_cond}.operation", 2) # Greater Than
        cmds.setAttr(f"{ik_cond}.colorIfTrueR", 1)
        cmds.setAttr(f"{ik_cond}.colorIfFalseR", 0)
        
        # FK Vis Condition: Blend < 10
        fk_cond = cmds.createNode('condition', n=f"{start_short}_fk_vis_cond")
        cmds.connectAttr(f"{switch_ctrl}.IKFK_Blend", f"{fk_cond}.firstTerm")
        cmds.setAttr(f"{fk_cond}.secondTerm", 10)
        cmds.setAttr(f"{fk_cond}.operation", 4) # Less Than
        cmds.setAttr(f"{fk_cond}.colorIfTrueR", 1)
        cmds.setAttr(f"{fk_cond}.colorIfFalseR", 0)

        # 把 Auto_Vis 考虑进去 (Auto_Vis * Result)
        # 用 multiplyDivide
        ik_vis_mult = cmds.createNode('multDoubleLinear', n=f"{start_short}_ik_vis_final")
        cmds.connectAttr(f"{ik_cond}.outColorR", f"{ik_vis_mult}.input1")
        cmds.connectAttr(f"{switch_ctrl}.Auto_Vis", f"{ik_vis_mult}.input2")
        cmds.connectAttr(f"{ik_vis_mult}.output", f"{ik_grp_obj}.visibility")
        
        # PV Vis 跟随 IK
        pv_ctrl = pv_ctrl_name
        if not pv_ctrl and ikx_chain:
             ik_root_short = ikx_chain[0].split('|')[-1]
             pv_base_name = ik_root_short
             if pv_base_name.startswith("IKX_"): pv_base_name = pv_base_name[4:]
             if pv_base_name.startswith("IKX"): pv_base_name = pv_base_name[3:]
             pv_ctrl = f"Pole{pv_base_name}" 
        
        if pv_ctrl and cmds.objExists(pv_ctrl):
            cmds.connectAttr(f"{ik_vis_mult}.output", f"{pv_ctrl}.visibility")

        fk_vis_mult = cmds.createNode('multDoubleLinear', n=f"{start_short}_fk_vis_final")
        cmds.connectAttr(f"{fk_cond}.outColorR", f"{fk_vis_mult}.input1")
        cmds.connectAttr(f"{switch_ctrl}.Auto_Vis", f"{fk_vis_mult}.input2")
        cmds.connectAttr(f"{fk_vis_mult}.output", f"{fk_grp_obj}.visibility")

    return {
        "switch_ctrl": switch_ctrl,
        "ik_grp": ik_grp_obj,
        "fk_grp": fk_grp_obj
    }


def create_ikfk_system(
        start_bone_name: str,
        end_bone_name: str,
        existing_fk_sys: str = None,
) -> Optional[Dict]:
    """
    主构建入口。
    """
    if not (cmds.objExists(start_bone_name) and cmds.objExists(end_bone_name)):
        print(f"[IKFK] Error: Bones not found: {start_bone_name}, {end_bone_name}")
        return None

    bind_chain = _get_bind_chain_names(start_bone_name, end_bone_name)

    # 1. 创建 IK 系统
    ik_data = ik.build_ik_system(
        start_jnt=start_bone_name,
        end_jnt=end_bone_name,
        ik_type='RP',
    )
    
    if not ik_data:
        print("[IKFK] Error: Failed to create IK system.")
        return None
        
    ikx_chain = ik_data.get('ikx_joints', [])
    ikx_end = ikx_chain[-1] if ikx_chain else None
    
    ik_offset = ik_data.get('ik_offset')
    ik_ctrl = ik_data.get('ik_ctrl')
    pv_ctrl = ik_data.get('pv_ctrl')

    # 2. 处理 FK 部分
    fk_root_grp = existing_fk_sys
    if not fk_root_grp:
        print(f"[IKFK] Warning: No existing FK provided for {start_bone_name}.")

    # 3. 构建网络
    # ik_grp_obj 用于可见性控制，通常是控制器组(ik_offset)
    system_data = _create_ikfk_switch_network(
        start_bone_name,
        end_bone_name,
        ikx_chain=ikx_chain,
        ik_grp_obj=ik_offset, 
        fk_grp_obj=fk_root_grp,
        pv_ctrl_name=pv_ctrl 
    )
        
    # 4. 修正手腕/脚踝旋转跟随问题
    if ik_ctrl and ikx_end:
         cmds.orientConstraint(ik_ctrl, ikx_end, maintainOffset=True)

    # 合并数据
    system_data.update(ik_data)
    system_data['bind_chain'] = bind_chain
    return system_data