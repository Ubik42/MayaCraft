# -*- coding: utf-8 -*-
"""
ikfk_switcher.py
本模块用于创建一套完整的、无缝的 IK/FK 切换系统。

它使用三条平行的骨骼链（Bind, IK, FK）来确保最大的稳定性和灵活性，
并提供一个高级函数，以自动化地完成骨骼链复制、控制器创建和混合逻辑的搭建。
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
    此类仅持有对切换控制器和三条并行链的引用，不包含任何主动操作的方法。
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
    此函数依赖一个只重命名子级的外部 utils.rename_hierarchy 函数。
    """

    # --- IK 链处理流程 ---

    # 1. 复制骨骼链 (不重命名子级)
    # 副本的根节点会自动获得数字后缀 (e.g., 'shoulder1')，而子节点保持原名。
    ik_root_raw = cmds.duplicate(start_bone_name, renameChildren=False)[0]

    # 2. 删除末端骨骼多余的子骨骼 (截断)
    def find_and_truncate(root_node: str, end_node_base_name: str):
        """内部辅助函数，用于在名字混乱的副本中找到末端骨骼并删除其子级。"""
        # 必须使用长路径来唯一识别节点
        root_path = cmds.ls(root_node, long=True)[0]
        descendants = cmds.listRelatives(root_path, allDescendents=True, type='joint', fullPath=True) or []

        end_node_in_chain = None
        for desc in descendants:
            # 因为子级未被重命名，所以可以直接匹配基础名称
            if desc.split('|')[-1] == end_node_base_name:
                end_node_in_chain = desc
                break

        if not end_node_in_chain:
            print(f"Warning: Could not find end bone '{end_node_base_name}' in hierarchy of '{root_node}'.")
            return

        children_to_delete = cmds.listRelatives(end_node_in_chain, children=True, type='joint', fullPath=True)
        if children_to_delete:
            cmds.delete(children_to_delete)

    find_and_truncate(ik_root_raw, end_bone_name)

    # 3. 重命名
    # 3a. 先单独重命名根骨骼
    ik_root_name = cmds.rename(ik_root_raw, f"{start_bone_name}{ik_suffix}")

    # 3b. 再使用外部函数，为新命名的根骨骼的【子骨骼】添加后缀
    name.rename_hierarchy(ik_root_name, suffix=ik_suffix)

    # --- FK 链处理流程 (重复以上步骤) ---

    # 1. 复制
    fk_root_raw = cmds.duplicate(start_bone_name, renameChildren=False)[0]

    # 2. 截断
    find_and_truncate(fk_root_raw, end_bone_name)

    # 3. 重命名
    fk_root_name = cmds.rename(fk_root_raw, f"{start_bone_name}{fk_suffix}")
    name.rename_hierarchy(fk_root_name, suffix=fk_suffix)

    # --- 4. 最终父子化 ---
    parent = cmds.listRelatives(start_bone_name, parent=True)
    if parent:
        cmds.parent(ik_root_name, parent[0])
        cmds.parent(fk_root_name, parent[0])

    return ik_root_name, fk_root_name


def _create_ikfk_switch_network(
        bone_manager: bone.BoneManager,
        start_bone: bone.Bone,
        end_bone: bone.Bone,
        ik_suffix: str,
        fk_suffix: str
) -> Optional[IKFKSystem]:
    """Internal function to create the switch controller and connect the three chains."""

    # --- 部分 1, 2, 3: 创建控制器, 获取骨骼链, 创建约束网络 - 这些都是正确的，保持不变 ---
    switch_control_name = f"IKFK_{start_bone.name}"
    switch_host = cmds.curve(name=switch_control_name, d=1,
                             p=[(1, 0, -1), (-1, 0, -1), (-1, 0, 1), (1, 0, 1), (1, 0, -1), (1, 0, 1), (-1, 0, 1),
                                (-1, 0, -1)])
    cmds.matchTransform(switch_host, end_bone.name, pos=True)
    cmds.move(0, 2.5, 0, switch_host, relative=True, objectSpace=True)

    attr_blend = 'IKFK_Blend'
    attr_auto_vis = 'Auto_Vis'
    attr_ik_vis = 'IK_Vis'
    attr_fk_vis = 'FK_Vis'
    cmds.addAttr(switch_host, ln=attr_blend, at='float', min=0, max=10, dv=0, k=True)
    cmds.addAttr(switch_host, ln=attr_auto_vis, at='bool', dv=1, k=True)
    cmds.addAttr(switch_host, ln=attr_ik_vis, at='bool', dv=1, k=True)
    cmds.addAttr(switch_host, ln=attr_fk_vis, at='bool', dv=1, k=True)

    bind_chain = bone_manager.find_bone_hierarchy(start_bone)
    try:
        end_index = bind_chain.index(end_bone)
    except ValueError:
        return None
    bind_chain = bind_chain[:end_index + 1]

    ik_chain = [bone_manager.bone_map.get(b.name + ik_suffix) for b in bind_chain]
    fk_chain = [bone_manager.bone_map.get(b.name + fk_suffix) for b in bind_chain]
    if not all(ik_chain) or not all(fk_chain): return None

    range_node = cmds.createNode('setRange', name=f"{start_bone.name}_blend_range")
    cmds.setAttr(f"{range_node}.oldMaxX", 10)
    cmds.setAttr(f"{range_node}.maxX", 1)
    cmds.connectAttr(f"{switch_host}.{attr_blend}", f"{range_node}.valueX")

    reverse_node_constraints = cmds.createNode('reverse', name=f"{start_bone.name}_blend_reverse")
    cmds.connectAttr(f"{range_node}.outValueX", f"{reverse_node_constraints}.inputX")

    for i, bind_b in enumerate(bind_chain):
        ik_b = ik_chain[i]
        fk_b = fk_chain[i]
        orient_constraint = cmds.orientConstraint(ik_b.name, fk_b.name, bind_b.name, maintainOffset=True)[0]
        weight_aliases = cmds.orientConstraint(orient_constraint, q=True, weightAliasList=True)
        cmds.connectAttr(f"{reverse_node_constraints}.outputX", f"{orient_constraint}.{weight_aliases[0]}")
        cmds.connectAttr(f"{range_node}.outValueX", f"{orient_constraint}.{weight_aliases[1]}")

        point_constraint = cmds.pointConstraint(ik_b.name, fk_b.name, bind_b.name, maintainOffset=True)[0]
        weight_aliases = cmds.pointConstraint(point_constraint, q=True, weightAliasList=True)
        cmds.connectAttr(f"{reverse_node_constraints}.outputX", f"{point_constraint}.{weight_aliases[0]}")
        cmds.connectAttr(f"{range_node}.outValueX", f"{point_constraint}.{weight_aliases[1]}")

    # --- 4. 构建控制器可见性网络 (最终修正版) ---
    ik_system = ik_chain[-1].ik_handles[0][0]
    ik_ctrl_grp = cmds.listRelatives(ik_system.control_curve, parent=True)[0]
    fk_ctrl_grp = fk_chain[0].fk_control.offset_group

    # --- 核心修正: 严格遵循正确的 blendColors 逻辑 ---

    # IK 可见性混合器
    ik_vis_blend = cmds.createNode('blendColors', n=f"{start_bone.name}_ik_vis_blend")
    cmds.connectAttr(f"{switch_host}.{attr_auto_vis}", f"{ik_vis_blend}.blender")
    cmds.connectAttr(f"{switch_host}.{attr_ik_vis}", f"{ik_vis_blend}.color2R")
    cmds.connectAttr(f"{reverse_node_constraints}.outputX", f"{ik_vis_blend}.color1R")

    # FK 可见性混合器
    fk_vis_blend = cmds.createNode('blendColors', n=f"{start_bone.name}_fk_vis_blend")
    cmds.connectAttr(f"{switch_host}.{attr_auto_vis}", f"{fk_vis_blend}.blender")
    cmds.connectAttr(f"{switch_host}.{attr_fk_vis}", f"{fk_vis_blend}.color2R")
    cmds.connectAttr(f"{range_node}.outValueX", f"{fk_vis_blend}.color1R")

    # 连接最终的可见性输出
    cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_ctrl_grp}.visibility")
    cmds.connectAttr(f"{fk_vis_blend}.outputR", f"{fk_ctrl_grp}.visibility")

    # 同时连接 Pole Vector 的可见性
    if ik_system.pole_vector_control:
        cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_system.pole_vector_control}.visibility")
    if ik_system.pole_vector_indicator:
        cmds.connectAttr(f"{ik_vis_blend}.outputR", f"{ik_system.pole_vector_indicator}.visibility")
    # --- 修正结束 ---

    return IKFKSystem(switch_host, bind_chain, ik_chain, fk_chain)


def create_ikfk_system(
        start_bone_name: str,
        end_bone_name: str,
        ik_suffix: str = '_ik',
        fk_suffix: str = '_fk'
) -> Optional[IKFKSystem]:
    """
    高级函数，用于为指定的肢体构建一整套IK/FK系统。
    这是用户应该调用的主要入口函数。
    """
    # 步骤1: 初始扫描场景，并验证输入的Bind骨骼是否存在
    manager = bone.BoneManager()
    manager.scan_scene()

    start_bone = manager.bone_map.get(start_bone_name)
    end_bone = manager.bone_map.get(end_bone_name)
    if not (start_bone and end_bone):
        cmds.warning(f"错误: 找不到Bind骨骼 '{start_bone_name}' 或 '{end_bone_name}'。")
        return None

    # 步骤2: 调用已修正的内部函数，创建并准备好IK和FK骨骼链
    # 这一步现在会正确地处理复制、截断和重命名
    print("--- 正在创建并准备 IK/FK 骨骼链 ---")
    ik_root_name, fk_root_name = _create_ikfk_chains(start_bone_name, end_bone_name, ik_suffix, fk_suffix)

    # 步骤3: 重新扫描场景，确保管理器能识别新创建的骨骼
    print("--- 正在重新扫描场景以包含新骨骼链 ---")
    manager.scan_scene()

    # 步骤4: 为IK和FK链添加控制器
    # 此时，管理器中应该已经包含了正确的、已重命名的骨骼
    print("--- 正在添加 IK 和 FK 控制器 ---")
    ik_start_bone = manager.bone_map.get(ik_root_name)
    ik_end_bone = manager.bone_map.get(f"{end_bone_name}{ik_suffix}")

    if not (ik_start_bone and ik_end_bone):
        cmds.warning(f"致命错误: 创建后找不到必要的IK骨骼 ('{ik_root_name}', '{f'{end_bone_name}{ik_suffix}'}')。")
        return None

    ik_system = ik.add_ik('RP', ik_start_bone, ik_end_bone, color_index=18)
    if not ik_system:
        cmds.warning("致命错误: 创建IK控制器失败。")
        return None

    fk_start_bone = manager.bone_map.get(fk_root_name)
    if not fk_start_bone:
        cmds.warning(f"致命错误: 创建后找不到FK根骨骼 '{fk_root_name}'。")
        return None

    fk.add_fk_to_hierarchy(manager, fk_start_bone)

    # 步骤5: 创建总开关控制器并连接所有系统
    print("--- 正在创建总开关控制器和驱动网络 ---")
    ikfk_system = _create_ikfk_switch_network(manager, start_bone, end_bone, ik_suffix, fk_suffix)

    if not ikfk_system:
        return None

    # 步骤6: 最终清理，隐藏IK和FK骨骼链
    cmds.setAttr(f"{ik_root_name}.visibility", False)
    cmds.setAttr(f"{fk_root_name}.visibility", False)

    print("IK/FK 系统创建成功。")
    return ikfk_system


### --- 测试代码 / Example Usage --- ###
def run_full_system_creation_test():
    """测试高级函数 create_ikfk_system 的功能。"""
    cmds.file(new=True, force=True)
    cmds.select(cl=True)
    # 仅需要创建一条Bind链，脚本会自动处理其他所有部分
    cmds.joint(n='L_arm_shoulder_jnt', p=(2, 15, 0))
    cmds.joint(n='L_arm_elbow_jnt', p=(6, 15, 1))
    cmds.joint(n='L_arm_wrist_jnt', p=(10, 15, 0))
    # Bind链可以有自己的子级（如手指），IK/FK系统会自动忽略它们
    cmds.select('L_arm_wrist_jnt')
    cmds.joint(n='L_arm_middleFinger_jnt')

    print("\n--- 正在为手臂创建完整的 IK/FK 系统 ---")
    arm_system = create_ikfk_system(
        start_bone_name='L_arm_shoulder_jnt',
        end_bone_name='L_arm_wrist_jnt'
    )

    if not arm_system:
        print("测试失败: 系统创建失败。")
        return

    print("\n--- 验证 ---")
    print(f"总开关控制器是: '{arm_system.switch_control}'")
    print("请选中它，并在通道盒中查看新增的属性。")
    print("IK 和 FK 骨骼链现在应该在大纲视图中被隐藏。")