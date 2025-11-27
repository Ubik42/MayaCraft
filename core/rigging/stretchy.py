# core/rigging/stretchy.py
# -*- coding: utf-8 -*-
"""
stretchy.py
模块用于为【单条】IK骨骼链创建带开关和体积保持功能的可拉伸效果。
"""

import maya.cmds as cmds
from typing import Optional, List

from . import bone
from . import ik


class StretchyRig(object):
    """一个数据容器，用于存储与一套可拉伸绑定相关的所有节点和信息。"""

    def __init__(
            self,
            stretch_attr_holder: str,
            stretch_attr_name: str,
            affected_joints: List[str]
    ):
        self.stretch_attr_holder = stretch_attr_holder
        self.stretch_attr_name = stretch_attr_name
        self.affected_joints = affected_joints

    def __repr__(self) -> str:
        return (f"StretchyRig(attribute='{self.stretch_attr_holder}.{self.stretch_attr_name}')")


def create_stretchy_ik(
        bone_manager: bone.BoneManager,
        start_bone: bone.Bone,
        end_bone: bone.Bone,
        stretch_control: str,  # 开关属性将添加到这个控制器上
) -> Optional[StretchyRig]:
    """
    为指定的【单条】IK链创建一个带开关和体积保持的可拉伸设置。
    """
    # --- 1. 获取骨骼链并计算原始长度 ---
    chain = bone_manager.find_bone_hierarchy(start_bone)
    try:
        end_index = chain.index(end_bone)
    except ValueError:
        cmds.warning(f"末端骨骼 '{end_bone.name}' 不在起始骨骼 '{start_bone.name}' 的层级下。")
        return None
    chain = chain[:end_index + 1]

    original_length = sum(abs(cmds.getAttr(f"{b.children[0].name}.tx")) for b in chain if b is not end_bone)
    if original_length < 0.001:
        cmds.warning("骨骼链长度为0，无法创建拉伸系统。")
        return None

    print(f"骨骼链的原始长度为: {original_length}")

    # --- 2. 验证并获取IK系统信息 ---
    if not (end_bone.ik_handles and isinstance(end_bone.ik_handles, list) and len(end_bone.ik_handles) > 0):
        cmds.warning(f"找不到 '{end_bone.name}' 上的IK控制器信息。")
        return None
    ik_system = end_bone.ik_handles[0][0]
    if not (ik_system and ik_system.control_curve and cmds.objExists(ik_system.control_curve)):
        cmds.warning(f"找不到 '{end_bone.name}' 上的IK控制器。")
        return None

    # --- 3. 创建用于距离测量的节点 ---
    start_loc = cmds.spaceLocator(name=f"{start_bone.name}_measure_start_loc")[0]
    end_loc = cmds.spaceLocator(name=f"{end_bone.name}_measure_end_loc")[0]
    cmds.pointConstraint(start_bone.name, start_loc, mo=False)
    cmds.pointConstraint(ik_system.control_curve, end_loc, mo=False)
    cmds.hide(start_loc, end_loc)

    dist_node = cmds.createNode('distanceBetween', name=f"{start_bone.name}_stretch_distance")
    cmds.connectAttr(f"{start_loc}.worldPosition[0]", f"{dist_node}.point1")
    cmds.connectAttr(f"{end_loc}.worldPosition[0]", f"{dist_node}.point2")

    # --- 4. 创建计算拉伸比例的节点网络 ---
    # a. 计算原始拉伸比率
    ratio_node = cmds.createNode('multiplyDivide', name=f"{start_bone.name}_stretch_ratio")
    cmds.setAttr(f"{ratio_node}.operation", 2)  # 除法
    cmds.connectAttr(f"{dist_node}.distance", f"{ratio_node}.input1X")
    cmds.setAttr(f"{ratio_node}.input2X", original_length)

    # b. 添加“只拉伸不压缩”的条件
    raw_stretch_cond = cmds.createNode('condition', name=f"{start_bone.name}_raw_stretch_cond")
    cmds.setAttr(f"{raw_stretch_cond}.operation", 2)  # 大于
    cmds.connectAttr(f"{dist_node}.distance", f"{raw_stretch_cond}.firstTerm")
    cmds.setAttr(f"{raw_stretch_cond}.secondTerm", original_length)
    cmds.connectAttr(f"{ratio_node}.outputX", f"{raw_stretch_cond}.colorIfTrueR")
    cmds.setAttr(f"{raw_stretch_cond}.colorIfFalseR", 1.0)

    # c. 创建 Stretchy 开关属性
    attr_name = "Stretchy"
    if not cmds.attributeQuery(attr_name, node=stretch_control, exists=True):
        cmds.addAttr(stretch_control, ln=attr_name, at='float', min=0, max=1, dv=1, k=True)
    stretch_attr_path = f"{stretch_control}.{attr_name}"

    # d. 创建混合节点，混合“开关”和“拉伸值”
    final_blend_node = cmds.createNode('blendColors', name=f"{start_bone.name}_final_stretch_blend")
    cmds.connectAttr(stretch_attr_path, f"{final_blend_node}.blender")
    cmds.setAttr(f"{final_blend_node}.color1R", 1.0)  # Stretchy=0时，输出1
    cmds.connectAttr(f"{raw_stretch_cond}.outColorR", f"{final_blend_node}.color2R")  # Stretchy=1时，输出计算结果

    # 最终的 scaleX 值从此节点输出
    final_scale_x_attr = f"{final_blend_node}.outputR"

    # --- 5. 创建体积保持节点网络 ---
    volume_node = cmds.createNode('multiplyDivide', name=f"{start_bone.name}_volume_comp")
    cmds.setAttr(f"{volume_node}.operation", 3)  # 幂运算 (Power)
    cmds.setAttr(f"{volume_node}.input2X", -0.5)  # x ^ -0.5  ==  1 / sqrt(x)
    cmds.connectAttr(final_scale_x_attr, f"{volume_node}.input1X")

    final_scale_yz_attr = f"{volume_node}.outputX"

    # --- 6. 将最终的缩放比例连接到骨骼上 ---
    affected_joints = []
    for jnt_bone in [b for b in chain if b is not end_bone]:
        node_name = jnt_bone.name
        if cmds.getAttr(f"{node_name}.scaleX", settable=True):
            cmds.connectAttr(final_scale_x_attr, f"{node_name}.scaleX")
            cmds.connectAttr(final_scale_yz_attr, f"{node_name}.scaleY")
            cmds.connectAttr(final_scale_yz_attr, f"{node_name}.scaleZ")
            affected_joints.append(node_name)

    # --- 7. 清理场景 ---
    util_grp = cmds.group(empty=True, name=f"{start_bone.name}_stretchy_utils_grp")
    cmds.hide(util_grp)
    cmds.parent(start_loc, end_loc, util_grp)

    # ... (隐藏工具节点) ...

    # --- 8. 创建并返回 StretchyRig 实例 ---
    stretchy_system = StretchyRig(
        stretch_attr_holder=stretch_control,
        stretch_attr_name=attr_name,
        affected_joints=affected_joints
    )

    print("可拉伸IK系统（带开关和体积保持）创建成功。")
    return stretchy_system


### --- 测试代码 / Example Usage --- ###
def run_stretchy_ik_test():
    """测试 create_stretchy_ik 函数的功能。"""
    cmds.file(new=True, force=True)

    cmds.joint(n='L_arm_shoulder_ik', p=(0, 15, 0));
    cmds.joint(n='L_arm_elbow_ik', p=(4, 15, 1));
    cmds.joint(n='L_arm_wrist_ik', p=(8, 15, 0))

    test_manager = bone.BoneManager();
    test_manager.scan_scene()
    start_b = test_manager.bone_map.get('L_arm_shoulder_ik')
    end_b = test_manager.bone_map.get('L_arm_wrist_ik')

    ik_system_instance = ik.add_ik('RP', start_b, end_b)
    if not ik_system_instance: return

    print("\n--- 正在为IK链创建可拉伸系统 ---")

    stretch_attr_host = ik_system_instance.control_curve

    stretchy_system = create_stretchy_ik(test_manager, start_b, end_b, stretch_attr_host)
    if not stretchy_system: return

    print("\n--- 验证 ---")
    print(f"请选中控制器 '{stretch_attr_host}' 查看 'Stretchy' 属性。")
    print("拖动IK控制器，骨骼应拉伸并保持体积。将'Stretchy'设为0可关闭效果。")