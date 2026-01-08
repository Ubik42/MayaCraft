# core/rigging/ik.py
# -*- coding: utf-8 -*-
"""
ik.py
IK 控制器模块。
修改版：
1. 返回数据包含 offset_group，允许外部重组层级。
2. 修复命名逻辑，支持传入长路径骨骼名。
"""

import maya.cmds as cmds
from typing import Optional, List, Literal

# 引入控制器管理模块
from core import controller


class IkCtl(object):
    """
    IK 控制器系统数据容器。
    """

    def __init__(
            self,
            control_curve: str,
            offset_group: str,
            ik_handle: str,
            effector: str,
            ik_type: str,
            start_bone: str,
            end_bone: str,
            pole_vector_control: Optional[str] = None,
            pole_vector_indicator: Optional[str] = None
    ):
        self.control_curve = control_curve  # IK 控制器 (Curve)
        self.offset_group = offset_group  # IK 控制器组 (Group) -> 用于归位
        self.ik_handle = ik_handle  # IK 手柄
        self.effector = effector  # IK 效应器
        self.ik_type = ik_type  # Solver 类型
        self.start_bone = start_bone  # 起始骨骼
        self.end_bone = end_bone  # 末端骨骼
        self.pole_vector_control = pole_vector_control
        self.pole_vector_indicator = pole_vector_indicator

    def __repr__(self) -> str:
        return (f"IkCtl(ctrl='{self.control_curve}', grp='{self.offset_group}', "
                f"type='{self.ik_type}')")


def add_ik(
        ik_type: Literal['RP', 'SC'],
        start_bone: str,
        end_bone: str,
        main_shape_name: str = "Cube",
        pv_shape_name: str = "Cross",
        pv_target_joint: str = None
) -> Optional[IkCtl]:
    """
    创建 IK 系统 (Handle + Control + PV)。
    """
    if not cmds.objExists(start_bone) or not cmds.objExists(end_bone):
        return None

    solver_map = {'RP': 'ikRPsolver', 'SC': 'ikSCsolver'}
    solver = solver_map.get(ik_type)
    if not solver:
        return None

    # 1. 命名处理 (关键修复：使用短名生成新节点名)
    start_short = start_bone.split("|")[-1]
    end_short = end_bone.split("|")[-1]

    handle_name = f"{end_short}_ikHandle"
    effector_name = f"{end_short}_effector"
    ctrl_name = f"{end_short}_ik_ctrl"
    grp_name = f"grp_{ctrl_name}"  # 统一命名规范 grp_...

    if cmds.objExists(handle_name):
        print(f"[IK] Warning: Handle {handle_name} already exists.")
        return None

    # 2. 创建 IK Handle (参数使用传入的原始路径 start_bone/end_bone 以确保准确)
    ik_nodes = cmds.ikHandle(
        name=handle_name,
        startJoint=start_bone,
        endEffector=end_bone,
        solver=solver
    )
    ik_handle = ik_nodes[0]
    effector = cmds.rename(ik_nodes[1], effector_name)

    # 3. 创建主控制器
    ctrl = cmds.circle(name=ctrl_name, normal=(0, 1, 0), radius=2.0, ch=False)[0]
    controller.apply_stored_shape(ctrl, main_shape_name)

    # 创建 Offset Group
    ctrl_grp = cmds.group(empty=True, name=grp_name)

    # 对齐 (使用原始 end_bone 路径)
    cmds.matchTransform(ctrl_grp, end_bone, pos=True, rot=True)
    cmds.matchTransform(ctrl, ctrl_grp, pos=True, rot=True)

    # 层级连接
    cmds.parent(ctrl, ctrl_grp)
    cmds.parent(ik_handle, ctrl)

    # 隐藏 Handle，锁定不用的属性
    cmds.setAttr(f"{ik_handle}.visibility", False)
    for attr in ['sx', 'sy', 'sz', 'v']:
        cmds.setAttr(f"{ctrl}.{attr}", keyable=False, channelBox=False)

    # 4. 创建 Pole Vector (仅 RP solver)
    pv_ctrl_name = None
    indicator_name = None

    if ik_type == 'RP':
        pv_ctrl_name = f"{start_short}_pv_ctrl"  # 使用短名

        pv_ctrl = cmds.circle(name=pv_ctrl_name, normal=(0, 1, 0), radius=0.5, ch=False)[0]
        controller.apply_stored_shape(pv_ctrl, pv_shape_name)

        # 计算位置
        pv_pos = _calculate_pole_vector_position(start_bone, end_bone)
        cmds.xform(pv_ctrl, translation=pv_pos, worldSpace=True)

        # PV 连线
        annotation_shape = cmds.annotate(pv_ctrl, text=" ", point=(0, 0, 0))
        annotation_trans = cmds.listRelatives(annotation_shape, parent=True)[0]

        # 使用短名重命名指示线
        indicator_name = cmds.rename(annotation_trans, f"{start_short}_pv_indicator")

        # 线条起点
        cmds.parent(indicator_name, pv_ctrl)

        # 线条终点
        target_obj = pv_target_joint
        if not target_obj:
            target_obj = _get_mid_joint(end_bone)

        if target_obj and cmds.objExists(target_obj):
            cmds.pointConstraint(target_obj, indicator_name, maintainOffset=False)
        else:
            cmds.pointConstraint(ik_handle, indicator_name, maintainOffset=False)

        # PV 归位 -> 放到 IK 控制器的组里
        # 注意：这里默认放到 ctrl_grp 下，如果调用者想把 PV 拿出来放到别处(如 World)，
        # 可以通过返回值 accessing pole_vector_control 并重新 parent
        cmds.parent(pv_ctrl, ctrl_grp)

        # 约束
        cmds.poleVectorConstraint(pv_ctrl, ik_handle)

        # 清理
        cmds.setAttr(f"{indicator_name}.overrideEnabled", 1)
        cmds.setAttr(f"{indicator_name}.overrideDisplayType", 2)
        for attr in ['rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']:
            cmds.setAttr(f"{pv_ctrl}.{attr}", keyable=False, channelBox=False)

    # 5. 数据封装
    ik_instance = IkCtl(
        control_curve=ctrl,
        offset_group=ctrl_grp,  # [新增] 返回组，方便外部归位
        ik_handle=ik_handle,
        effector=effector,
        ik_type=solver,
        start_bone=start_bone,
        end_bone=end_bone,
        pole_vector_control=pv_ctrl_name,
        pole_vector_indicator=indicator_name
    )

    return ik_instance


def _calculate_pole_vector_position(start_bone: str, end_bone: str) -> List[float]:
    """计算 PV 初始位置"""
    mid_joint = _get_mid_joint(end_bone)

    if not mid_joint:
        start_pos = cmds.xform(start_bone, q=True, ws=True, t=True)
        return [start_pos[0], start_pos[1] + 10, start_pos[2]]

    return cmds.xform(mid_joint, q=True, ws=True, t=True)


def _get_mid_joint(end_bone: str) -> Optional[str]:
    """获取倒数第二个骨骼"""
    parents = cmds.listRelatives(end_bone, parent=True, fullPath=True)
    if parents:
        return parents[0]
    return None