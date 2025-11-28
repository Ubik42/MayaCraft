# -*- coding: utf-8 -*-
"""
ikfk.py
本模块用于创建一套完整的、无缝的 IK/FK 切换系统。
"""

import maya.cmds as cmds
from typing import Optional, List, Tuple

# 导入项目中的其他绑定模块
from core.rigging import bone
from core.rigging import ik, fk
from core import name


class IKFKSystem(object):
    """
    一个数据容器，用于存储与一套 IK/FK 切换系统相关的所有节点和信息。
    """

    def __init__(
            self,
            switch_control: str,
            bind_chain: List[bone.Bone],
            ik_chain: List[bone.Bone],
            fk_chain: List[bone.Bone]
    ):
        self.switch_control = switch_control
        self.bind_chain = bind_chain
        self.ik_chain = ik_chain
        self.fk_chain = fk_chain


def _create_ikfk_chains(
        start_bone_name: str,
        end_bone_name: str,
        ik_suffix: str = '_ik',
        fk_suffix: str = '_fk'
) -> Tuple[str, str]:
    """
    严格按照“复制 -> 截断 -> 分步重命名”的顺序，创建 IK 和 FK 骨骼链。
    """

    # --- IK 链处理流程 ---
    # 1. 复制骨骼链
    ik_root_raw = cmds.duplicate(start_bone_name, renameChildren=False)[0]

    # 2. 截断 (删除多余子物体)
    def find_and_truncate(root_node: str, end_node_base_name: str):
        root_path = cmds.ls(root_node, long=True)[0]
        descendants = cmds.listRelatives(root_path, allDescendents=True, type='joint', fullPath=True) or []

        end_node_in_chain = None
        for desc in descendants:
            # 匹配基础名称
            if desc.split('|')[-1] == end_node_base_name:
                end_node_in_chain = desc
                break

        if not end_node_in_chain:
            print(f"Warning: Could not find end bone '{end_node_base_name}' in hierarchy of '{root_node}'.")
            return

        children_to_delete = cmds.listRelatives(end_node_in_chain, children=True, type='joint', fullPath=True)
        if children_to_delete:
            cmds.delete(children_to_delete)

    # 由于我们传入的是短名，这里使用 short name 匹配
    end_short_name = end_bone_name.split("|")[-1]
    find_and_truncate(ik_root_raw, end_short_name)

    # 3. 重命名
    ik_root_name = cmds.rename(ik_root_raw, f"{start_bone_name}{ik_suffix}")
    # 递归重命名子级
    name.rename_hierarchy(ik_root_name, suffix=ik_suffix)

    # --- FK 链处理流程 ---
    fk_root_raw = cmds.duplicate(start_bone_name, renameChildren=False)[0]
    find_and_truncate(fk_root_raw, end_short_name)

    fk_root_name = cmds.rename(fk_root_raw, f"{start_bone_name}{fk_suffix}")
    name.rename_hierarchy(fk_root_name, suffix=fk_suffix)

    # --- 4. 最终父子化 (修复崩溃点) ---
    parent = cmds.listRelatives(start_bone_name, parent=True)
    if parent:
        target_parent = parent[0]

        # 定义一个安全的内部函数
        def safe_parent_to(child, parent_node):
            try:
                # 检查当前父级
                current = cmds.listRelatives(child, parent=True)
                # 只有当当前没有父级，或者父级不是目标时，才执行 parent
                if not current or current[0] != parent_node:
                    cmds.parent(child, parent_node)
            except Exception as e:
                # 捕获错误防止崩溃，通常是因为已经是子物体了
                print(f"Warning: Safe parent skipped for {child} -> {parent_node}: {e}")

        safe_parent_to(ik_root_name, target_parent)
        safe_parent_to(fk_root_name, target_parent)

    return ik_root_name, fk_root_name


def _create_ikfk_switch_network(
        bone_manager: bone.BoneManager,
        start_bone: bone.Bone,
        end_bone: bone.Bone,
        ik_suffix: str,
        fk_suffix: str
) -> Optional[IKFKSystem]:
    """创建控制器和混合网络"""

    # --- 1. 创建控制器 ---
    switch_control_name = f"IKFK_{start_bone.name}"  # start_bone.name 现在是短名

    if cmds.objExists(switch_control_name):
        switch_host = switch_control_name
    else:
        # 创建曲线
        switch_host = cmds.curve(name=switch_control_name, d=1,
                                 p=[(1, 0, -1), (-1, 0, -1), (-1, 0, 1), (1, 0, 1),
                                    (1, 0, -1), (1, 0, 1), (-1, 0, 1), (-1, 0, -1)])
        # 匹配位置到末端
        # end_bone.name 是短名，如果场景唯一可以直接用
        if cmds.objExists(end_bone.name):
            cmds.matchTransform(switch_host, end_bone.name, pos=True)
        cmds.move(0, 2.5, 0, switch_host, relative=True, objectSpace=True)

    # 添加属性
    attr_blend = 'IKFK_Blend'
    attr_auto_vis = 'Auto_Vis'
    attr_ik_vis = 'IK_Vis'
    attr_fk_vis = 'FK_Vis'

    if not cmds.attributeQuery(attr_blend, node=switch_host, exists=True):
        cmds.addAttr(switch_host, ln=attr_blend, at='float', min=0, max=10, dv=0, k=True)
        cmds.addAttr(switch_host, ln=attr_auto_vis, at='bool', dv=1, k=True)
        cmds.addAttr(switch_host, ln=attr_ik_vis, at='bool', dv=1, k=True)
        cmds.addAttr(switch_host, ln=attr_fk_vis, at='bool', dv=1, k=True)

    # --- 2. 获取骨骼链 ---
    bind_chain = bone_manager.find_bone_hierarchy(start_bone)
    try:
        # 查找 end_bone 在链条中的位置
        # 注意：这里对比的是 Bone 对象或者名字
        end_index = -1
        for i, b in enumerate(bind_chain):
            if b.name == end_bone.name:
                end_index = i
                break

        if end_index == -1: return None
        bind_chain = bind_chain[:end_index + 1]
    except ValueError:
        return None

    ik_chain = [bone_manager.get_bone(b.name + ik_suffix) for b in bind_chain]
    fk_chain = [bone_manager.get_bone(b.name + fk_suffix) for b in bind_chain]

    if not all(ik_chain) or not all(fk_chain):
        print("Error: IK or FK chains not found in BoneManager.")
        return None

    # --- 3. 约束网络 ---
    range_node = cmds.createNode('setRange', name=f"{start_bone.name}_blend_range")
    cmds.setAttr(f"{range_node}.oldMaxX", 10)
    cmds.setAttr(f"{range_node}.maxX", 1)
    cmds.connectAttr(f"{switch_host}.{attr_blend}", f"{range_node}.valueX")

    reverse_node_constraints = cmds.createNode('reverse', name=f"{start_bone.name}_blend_reverse")
    cmds.connectAttr(f"{range_node}.outValueX", f"{reverse_node_constraints}.inputX")

    for i, bind_b in enumerate(bind_chain):
        ik_b = ik_chain[i]
        fk_b = fk_chain[i]

        # 安全检查对象是否存在
        if not (cmds.objExists(ik_b.name) and cmds.objExists(fk_b.name) and cmds.objExists(bind_b.name)):
            continue

        try:
            orient_constraint = cmds.orientConstraint(ik_b.name, fk_b.name, bind_b.name, maintainOffset=True)[0]
            weight_aliases = cmds.orientConstraint(orient_constraint, q=True, weightAliasList=True)
            cmds.connectAttr(f"{reverse_node_constraints}.outputX", f"{orient_constraint}.{weight_aliases[0]}")
            cmds.connectAttr(f"{range_node}.outValueX", f"{orient_constraint}.{weight_aliases[1]}")

            # Point Constraint (可选)
            # point_constraint = cmds.pointConstraint(ik_b.name, fk_b.name, bind_b.name, maintainOffset=True)[0]
            # ...
        except Exception as e:
            print(f"Constraint skipped for {bind_b.name}: {e}")

    # --- 4. 可见性网络 ---
    # 尝试找到 IK 控制器组
    ik_ctrl_grp = None
    if ik_chain[-1].ik_handles:
        ik_ctl = ik_chain[-1].ik_handles[0][0]
        if ik_ctl and cmds.objExists(ik_ctl.control_curve):
            parents = cmds.listRelatives(ik_ctl.control_curve, parent=True)
            if parents: ik_ctrl_grp = parents[0]

    # 尝试找到 FK 控制器组
    fk_ctrl_grp = None
    if fk_chain[0].fk_control:
        fk_ctrl_grp = fk_chain[0].fk_control.offset_group

    if ik_ctrl_grp and fk_ctrl_grp:
        ik_vis_blend = cmds.createNode('blendColors', n=f"{start_bone.name}_ik_vis_blend")
        cmds.connectAttr(f"{switch_host}.{attr_auto_vis}", f"{ik_vis_blend}.blender")
        cmds.connectAttr(f"{switch_host}.{attr_ik_vis}", f"{ik_vis_blend}.color2R")
        cmds.connectAttr(f"{range_node}.outValueX", f"{ik_vis_blend}.color1R")  # IK mode=1 -> Visible

        fk_vis_blend = cmds.createNode('blendColors', n=f"{start_bone.name}_fk_vis_blend")
        cmds.connectAttr(f"{switch_host}.{attr_auto_vis}", f"{fk_vis_blend}.blender")
        cmds.connectAttr(f"{switch_host}.{attr_fk_vis}", f"{fk_vis_blend}.color2R")
        cmds.connectAttr(f"{reverse_node_constraints}.outputX",
                         f"{fk_vis_blend}.color1R")  # FK mode=0 (Rev=1) -> Visible

        cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_ctrl_grp}.visibility")
        cmds.connectAttr(f"{fk_vis_blend}.outputR", f"{fk_ctrl_grp}.visibility")

        # PV 可见性
        if ik_chain[-1].ik_handles:
            ik_sys_obj = ik_chain[-1].ik_handles[0][0]
            if ik_sys_obj.pole_vector_control:
                cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_sys_obj.pole_vector_control}.visibility")
            if ik_sys_obj.pole_vector_indicator:
                cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_sys_obj.pole_vector_indicator}.visibility")

    return IKFKSystem(switch_host, bind_chain, ik_chain, fk_chain)


def create_ikfk_system(
        start_bone_name: str,
        end_bone_name: str,
        ik_suffix: str = '_ik',
        fk_suffix: str = '_fk'
) -> Optional[IKFKSystem]:
    """主入口函数"""

    # 1. 扫描
    manager = bone.BoneManager()
    manager.scan_scene()

    start_bone = manager.get_bone(start_bone_name)
    end_bone = manager.get_bone(end_bone_name)
    if not (start_bone and end_bone):
        print(f"Error: Bind bones not found: {start_bone_name}, {end_bone_name}")
        return None

    # 2. 创建链 (调用修复后的函数)
    ik_root_name, fk_root_name = _create_ikfk_chains(start_bone_name, end_bone_name, ik_suffix, fk_suffix)

    # 3. 重扫
    manager.scan_scene()

    # 4. 获取新对象
    ik_start_bone = manager.get_bone(ik_root_name)
    fk_start_bone = manager.get_bone(fk_root_name)

    # 拼装 IK 末端名
    end_short = end_bone_name.split("|")[-1]
    ik_end_name = f"{end_short}{ik_suffix}"
    ik_end_bone = manager.get_bone(ik_end_name)

    if not (ik_start_bone and ik_end_bone and fk_start_bone):
        print("Error: Could not find generated chains in manager.")
        return None

    # 5. 添加控制器
    ik.add_ik('RP', ik_start_bone, ik_end_bone, color_index=18)
    fk.add_fk_to_hierarchy(manager, fk_start_bone)

    # 6. Switch 网络
    ikfk_sys = _create_ikfk_switch_network(manager, start_bone, end_bone, ik_suffix, fk_suffix)

    # 7. 隐藏骨骼
    if cmds.objExists(ik_root_name): cmds.setAttr(f"{ik_root_name}.visibility", 0)
    if cmds.objExists(fk_root_name): cmds.setAttr(f"{fk_root_name}.visibility", 0)

    return ikfk_sys