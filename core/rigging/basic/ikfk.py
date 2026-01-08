# core/rigging/ikfk.py
# -*- coding: utf-8 -*-
"""
ikfk.py
IK/FK 切换系统模块。
最终重构版：
1. 集成 core.controller。
2. 返回完整的 IK/FK 组结构，支持外部重组。
"""

import maya.cmds as cmds
from typing import Optional, List, Tuple

# 导入核心模块
from core.rigging.basic import fk, ik
from core import controller


class IKFKSystem(object):
    """IK/FK 系统数据容器"""

    def __init__(
            self,
            switch_control: str,
            bind_chain: List[str],
            ik_chain: List[str],
            fk_chain: List[str],
            ik_grp: str = None,  # [新增] IK 系统总组
            fk_ctrl_grp: str = None,  # [新增] FK 系统总组
            stretchy_system=None
    ):
        self.switch_control = switch_control
        self.bind_chain = bind_chain
        self.ik_chain = ik_chain
        self.fk_chain = fk_chain
        self.ik_grp = ik_grp
        self.fk_ctrl_grp = fk_ctrl_grp
        self.stretchy_system = stretchy_system


def _get_bind_chain_names(start_name: str, end_name: str) -> List[str]:
    """获取从 start 到 end 的所有骨骼名称列表"""
    chain = []
    curr = end_name
    safeguard = 0
    # 增加全路径判断防止同名错误
    start_short = start_name.split('|')[-1]

    while safeguard < 100:
        chain.append(curr)
        # 比较短名
        if curr.split('|')[-1] == start_short:
            break
        parents = cmds.listRelatives(curr, parent=True, fullPath=True)
        if parents:
            curr = parents[0]
        else:
            break
        safeguard += 1
    return list(reversed(chain))


def _create_ikfk_chains(
        start_bone_name: str,
        end_bone_name: str,
        ik_suffix: str = '_ik',
        fk_suffix: str = '_fk'
) -> Tuple[str, str]:
    """创建 IK 和 FK 骨骼链"""
    bind_names_full = _get_bind_chain_names(start_bone_name, end_bone_name)
    chain_len = len(bind_names_full)

    if chain_len == 0:
        print("[IKFK] Error: Could not verify bind chain path.")
        return "", ""

    def generate_chain(suffix):
        # 复制骨骼链
        temp_root = cmds.duplicate(start_bone_name, renameChildren=True)[0]

        # 遍历复制出的层级，找到需要保留的链条
        new_chain_nodes = []
        curr_node = temp_root

        for _ in range(chain_len):
            new_chain_nodes.append(curr_node)
            children = cmds.listRelatives(curr_node, children=True, fullPath=True, type='joint')
            if children:
                curr_node = children[0]
            else:
                break

        # 删除多余的子骨骼
        last_kept_node = new_chain_nodes[-1]
        children_to_delete = cmds.listRelatives(last_kept_node, children=True, fullPath=True)
        if children_to_delete:
            try:
                cmds.delete(children_to_delete)
            except:
                pass

        # 重命名 (使用原始短名 + 后缀)
        for bind_full, node_path in zip(reversed(bind_names_full), reversed(new_chain_nodes)):
            bind_short = bind_full.split('|')[-1]
            target_name = f"{bind_short}{suffix}"
            try:
                # rename 返回的是新名字(短名)
                cmds.rename(node_path, target_name)
            except:
                pass

        # 返回重命名后的根节点短名
        root_short = bind_names_full[0].split('|')[-1]
        return f"{root_short}{suffix}"

    ik_root_name = generate_chain(ik_suffix)
    fk_root_name = generate_chain(fk_suffix)

    # 将新链条归位到原始父级 (或者世界)
    original_parent = cmds.listRelatives(start_bone_name, parent=True)
    if original_parent:
        target_parent = original_parent[0]
        for child in [ik_root_name, fk_root_name]:
            try:
                if cmds.objExists(child):
                    current = cmds.listRelatives(child, parent=True)
                    if not current or current[0] != target_parent:
                        cmds.parent(child, target_parent)
            except:
                pass
    else:
        # 如果原始骨骼没有父级，把生成的也放到世界
        for child in [ik_root_name, fk_root_name]:
            if cmds.listRelatives(child, parent=True):
                cmds.parent(child, world=True)

    return ik_root_name, fk_root_name


def _create_ikfk_switch_network(
        start_bone: str,
        end_bone: str,
        ik_suffix: str,
        fk_suffix: str,
        switch_shape_name: str,
        ik_grp_obj: str,  # [新增] 传入确定的组对象
        fk_grp_obj: str  # [新增] 传入确定的组对象
) -> Optional[IKFKSystem]:
    """创建控制器、约束混合及可见性网络"""

    # 1. 创建 Switch 控制器
    start_short = start_bone.split('|')[-1]
    switch_name = f"IKFK_{start_short}"

    if cmds.objExists(switch_name):
        switch_ctrl = switch_name
    else:
        switch_ctrl = cmds.circle(name=switch_name, normal=(0, 1, 0), radius=1.0, ch=False)[0]
        controller.apply_stored_shape(switch_ctrl, switch_shape_name)

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

    # 重新推导 IK/FK 链名 (注意这里假设 generate_chain 逻辑正确)
    ik_chain = []
    fk_chain = []
    for b in bind_chain:
        short = b.split('|')[-1]
        ik_chain.append(f"{short}{ik_suffix}")
        fk_chain.append(f"{short}{fk_suffix}")

    # 3. 创建约束混合网络
    range_node = cmds.createNode('setRange', name=f"{start_short}_blend_range")
    cmds.setAttr(f"{range_node}.oldMaxX", 10)
    cmds.setAttr(f"{range_node}.maxX", 1)
    cmds.connectAttr(f"{switch_ctrl}.IKFK_Blend", f"{range_node}.valueX")

    rev_node = cmds.createNode('reverse', name=f"{start_short}_blend_rev")
    cmds.connectAttr(f"{range_node}.outValueX", f"{rev_node}.inputX")

    for i, bind_b in enumerate(bind_chain):
        ik_b = ik_chain[i]
        fk_b = fk_chain[i]
        try:
            if cmds.objExists(ik_b) and cmds.objExists(fk_b):
                oc = cmds.orientConstraint(ik_b, fk_b, bind_b, maintainOffset=True)[0]
                w = cmds.orientConstraint(oc, q=True, weightAliasList=True)
                cmds.connectAttr(f"{range_node}.outValueX", f"{oc}.{w[0]}")
                cmds.connectAttr(f"{rev_node}.outputX", f"{oc}.{w[1]}")
        except:
            pass

    # 4. 可见性网络
    # [修改] 直接使用传入的组，不再反查
    if ik_grp_obj and fk_grp_obj:
        ik_blend = cmds.createNode('blendColors', n=f"{start_short}_ik_vis")
        cmds.connectAttr(f"{switch_ctrl}.Auto_Vis", f"{ik_blend}.blender")
        cmds.connectAttr(f"{switch_ctrl}.IK_Vis", f"{ik_blend}.color2R")
        cmds.connectAttr(f"{range_node}.outValueX", f"{ik_blend}.color1R")
        cmds.connectAttr(f"{ik_blend}.outputR", f"{ik_grp_obj}.visibility")

        # PV Vis (如果 PV 在 IK 组里，其实不用单独连，但为了保险还是连一下)
        ik_root_short = ik_chain[0].split('|')[-1]
        pv_ctrl = f"{ik_root_short}_pv_ctrl"
        pv_indicator = f"{ik_root_short}_pv_indicator"

        if cmds.objExists(pv_ctrl):
            cmds.connectAttr(f"{ik_blend}.outputR", f"{pv_ctrl}.visibility")
        if cmds.objExists(pv_indicator):
            cmds.connectAttr(f"{ik_blend}.outputR", f"{pv_indicator}.visibility")

        fk_blend = cmds.createNode('blendColors', n=f"{start_short}_fk_vis")
        cmds.connectAttr(f"{switch_ctrl}.Auto_Vis", f"{fk_blend}.blender")
        cmds.connectAttr(f"{switch_ctrl}.FK_Vis", f"{fk_blend}.color2R")
        cmds.connectAttr(f"{rev_node}.outputX", f"{fk_blend}.color1R")
        cmds.connectAttr(f"{fk_blend}.outputR", f"{fk_grp_obj}.visibility")

    return IKFKSystem(switch_ctrl, bind_chain, ik_chain, fk_chain, ik_grp_obj, fk_grp_obj)


def create_ikfk_system(
        start_bone_name: str,
        end_bone_name: str,
        ik_suffix: str = '_ik',
        fk_suffix: str = '_fk',
        switch_shape_name: str = "Switch",
        ik_shape_name: str = "Box",
        pv_shape_name: str = "FourArrows",
        enable_stretchy: bool = False
) -> Optional[IKFKSystem]:
    """
    主构建入口。
    """
    if not (cmds.objExists(start_bone_name) and cmds.objExists(end_bone_name)):
        print(f"[IKFK] Error: Bones not found: {start_bone_name}, {end_bone_name}")
        return None

    # 1. 创建骨骼链
    ik_root, fk_root = _create_ikfk_chains(start_bone_name, end_bone_name, ik_suffix, fk_suffix)

    # 2. 准备名称
    # _create_ikfk_chains 返回的是短名
    ik_start = ik_root
    fk_start = fk_root

    end_short = end_bone_name.split('|')[-1]
    ik_end = f"{end_short}{ik_suffix}"

    bind_chain = _get_bind_chain_names(start_bone_name, end_bone_name)
    bind_mid_joint = bind_chain[-2] if len(bind_chain) >= 2 else None

    # 3. 添加 IK 控制器
    ik_ctl = ik.add_ik(
        'RP',
        ik_start,
        ik_end,
        main_shape_name=ik_shape_name,
        pv_shape_name=pv_shape_name,
        pv_target_joint=bind_mid_joint
    )

    # 4. 添加 FK 控制器链
    fk_ctls = fk.add_fk_to_hierarchy(fk_start)

    # [关键] 获取 FK 根组 (第一个控制器的 Offset Group)
    fk_root_grp = fk_ctls[0].offset_group if fk_ctls else None

    # [关键] 获取 IK 根组
    ik_root_grp = ik_ctl.offset_group if ik_ctl else None

    # 5. 构建网络
    system = _create_ikfk_switch_network(
        start_bone_name,
        end_bone_name,
        ik_suffix,
        fk_suffix,
        switch_shape_name,
        ik_grp_obj=ik_root_grp,
        fk_grp_obj=fk_root_grp
    )

    # 6. 拉伸系统
    if enable_stretchy and ik_ctl:
        from core.rigging.attribute import stretchy
        stretchy.create_stretchy_ik(
            start_bone=ik_start,
            end_bone=ik_end,
            stretch_control=ik_ctl.control_curve,
            bind_chain=bind_chain
        )

    # 7. 隐藏驱动骨骼
    if cmds.objExists(ik_root): cmds.setAttr(f"{ik_root}.visibility", 0)
    if cmds.objExists(fk_root): cmds.setAttr(f"{fk_root}.visibility", 0)

    return system