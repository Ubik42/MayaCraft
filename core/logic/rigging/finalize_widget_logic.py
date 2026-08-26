# finalize_widget_logic.py
# -*- coding: utf-8 -*-
"""
finalize_widget_logic.py
“完成与工具”功能块的后端逻辑。
"""

import maya.cmds as cmds
from typing import Dict, List, Any

# --- 控制器形状数据库 ---
# 预定义常用控制器形状的创建信息
CONTROLLER_SHAPES_DB: Dict[str, Dict[str, Any]] = {
    "Cube": {
        "command": cmds.curve,
        "kwargs": {
            "d": 1,
            "p": [(-1, 1, 1), (1, 1, 1), (1, 1, -1), (-1, 1, -1),
                  (-1, 1, 1), (-1, -1, 1), (1, -1, 1), (1, 1, 1),
                  (1, -1, 1), (1, -1, -1), (1, 1, -1), (1, -1, -1),
                  (-1, -1, -1), (-1, 1, -1), (-1, -1, -1), (-1, -1, 1)]
        }
    },
    "Sphere": {
        "command": cmds.circle,  # 主体是一个圆
        "kwargs": {"nr": (0, 1, 0), "ch": False},
        "extras": [  # 额外创建两个圆来构成球体
            {"command": cmds.circle, "kwargs": {"nr": (1, 0, 0), "ch": False}},
            {"command": cmds.circle, "kwargs": {"nr": (0, 0, 1), "ch": False}},
        ]
    },
    "Circle_X": {"command": cmds.circle, "kwargs": {"nr": (1, 0, 0), "ch": False}},
    "Circle_Y": {"command": cmds.circle, "kwargs": {"nr": (0, 1, 0), "ch": False}},
    "Circle_Z": {"command": cmds.circle, "kwargs": {"nr": (0, 0, 1), "ch": False}},
    "Arrow": {
        "command": cmds.curve,
        "kwargs": {
            "d": 1,
            "p": [(0, 0, -2), (2, 0, -2), (2, 0, -4), (4, 0, 0),
                  (2, 0, 4), (2, 0, 2), (0, 0, 2), (0, 0, -2)]
        }
    }
}


def apply_controller_shape(shape_name: str):
    """
    将当前选中的控制器（曲线）替换为指定的预设形状。

    Args:
        shape_name (str): 形状数据库中的键名。
    """
    selection = cmds.ls(sl=True, type='transform')
    if not selection:
        cmds.warning("请先选中要替换形状的控制器。")
        return

    if shape_name not in CONTROLLER_SHAPES_DB:
        cmds.warning(f"未知的控制器形状: '{shape_name}'")
        return

    shape_data = CONTROLLER_SHAPES_DB[shape_name]

    for target_ctrl in selection:
        # 记录原始变换
        matrix = cmds.xform(target_ctrl, q=True, ws=True, matrix=True)

        # 删除旧的形状节点
        old_shapes = cmds.listRelatives(target_ctrl, shapes=True, fullPath=True)
        if old_shapes:
            cmds.delete(old_shapes)

        # 创建新的形状
        cmd = shape_data["command"]
        kwargs = shape_data.get("kwargs", {})
        temp_transform = cmd(**kwargs)[0]

        # 如果有额外的形状（例如球体），也创建它们并合并
        if "extras" in shape_data:
            for extra in shape_data["extras"]:
                extra_cmd = extra["command"]
                extra_kwargs = extra.get("kwargs", {})
                extra_curve = extra_cmd(**extra_kwargs)[0]

                extra_shape = cmds.listRelatives(extra_curve, s=True, f=True)[0]
                cmds.parent(extra_shape, temp_transform, r=True, s=True)
                cmds.delete(extra_curve)

        # 将新形状父化到目标控制器下，然后删除临时变换节点
        new_shapes = cmds.listRelatives(temp_transform, shapes=True, fullPath=True)
        if new_shapes:
            cmds.parent(new_shapes, target_ctrl, relative=True, shape=True)

        cmds.delete(temp_transform)

        # 恢复原始变换
        cmds.xform(target_ctrl, ws=True, matrix=matrix)

    print(f"已将 {len(selection)} 个控制器的形状替换为 '{shape_name}'。")


def mirror_controller_shapes():
    """
    镜像选中的左侧控制器的形状到右侧对应的控制器。
    """
    selection = cmds.ls(sl=True, type='transform')
    if not selection:
        cmds.warning("请先选中要镜像形状的源控制器 (例如 _L_ctrl)。")
        return

    mirrored_count = 0
    for src_ctrl in selection:
        if '_L' not in src_ctrl:
            print(f"Info: '{src_ctrl}' 不是一个左侧控制器，已跳过。")
            continue

        dest_ctrl = src_ctrl.replace('_L', '_R')
        if not cmds.objExists(dest_ctrl):
            print(f"Info: 找不到对应的右侧控制器 '{dest_ctrl}'，已跳过。")
            continue

        # 复制形状
        temp_duplicate = cmds.duplicate(src_ctrl, name=f"{dest_ctrl}_tempShapeHolder")[0]
        new_shapes = cmds.listRelatives(temp_duplicate, s=True, f=True)

        if not new_shapes:
            cmds.delete(temp_duplicate)
            continue

        # 删除目标控制器上的旧形状
        old_dest_shapes = cmds.listRelatives(dest_ctrl, s=True, f=True)
        if old_dest_shapes:
            cmds.delete(old_dest_shapes)

        # 父化新形状
        cmds.parent(new_shapes, dest_ctrl, r=True, s=True)

        # 删除临时物体
        cmds.delete(temp_duplicate)

        # 对镜像后的形状进行反向缩放
        # 通过连接一个反向的scaleX来实现
        cmds.setAttr(f"{dest_ctrl}.scaleX", -1)
        cmds.setAttr(f"{dest_ctrl}.scaleY", 1)
        cmds.setAttr(f"{dest_ctrl}.scaleZ", 1)

        mirrored_count += 1

    if mirrored_count > 0:
        print(f"成功镜像了 {mirrored_count} 个控制器的形状。")
    else:
        cmds.warning("没有执行任何有效的镜像操作。")


def finalize_rig():
    """
    清理和锁定最终的绑定骨架。
    这是一个危险操作，会锁定和隐藏所有控制器的非关键属性。
    """
    print("--- 正在执行最终化操作 ---")

    # 找到所有控制器 (一个简单的假设：名字以 _ctrl 结尾)
    all_controllers = cmds.ls("*_ctrl", type='transform')

    locked_count = 0
    for ctrl in all_controllers:
        # 锁定并隐藏非动画关键属性
        # 这里是一个通用列表，可以根据需要扩展
        attrs_to_lock = ['sx', 'sy', 'sz', 'v']

        # 根据控制器类型决定要保留哪些属性
        is_ik = 'ik' in ctrl
        is_pv = 'pv' in ctrl
        is_fk = 'fk' in ctrl

        if is_ik:  # IK控制器保留位移和旋转
            pass
        elif is_pv:  # Pole Vector 只保留位移
            attrs_to_lock.extend(['rx', 'ry', 'rz'])
        elif is_fk:  # FK 控制器只保留旋转
            attrs_to_lock.extend(['tx', 'ty', 'tz'])
        else:  # 其他通用控制器，默认保留位移和旋转
            pass

        for attr in set(attrs_to_lock):  # 使用 set 去重
            try:
                full_attr = f"{ctrl}.{attr}"
                if cmds.getAttr(full_attr, settable=True):
                    cmds.setAttr(full_attr, lock=True, keyable=False, channelBox=False)
            except Exception:
                pass  # 忽略已锁定或不存在的属性

        locked_count += 1

    print(f"已清理和锁定 {locked_count} 个控制器的属性。")

    # 隐藏所有驱动骨骼链 (IK, FK)
    ik_joints = cmds.ls("*_ik", type='joint')
    fk_joints = cmds.ls("*_fk", type='joint')

    hidden_chains = 0
    for jnt in ik_joints + fk_joints:
        # 只隐藏根节点
        if not cmds.listRelatives(jnt, parent=True, type='joint'):
            cmds.setAttr(f"{jnt}.visibility", False)
            hidden_chains += 1

    print(f"已隐藏 {hidden_chains} 条驱动骨骼链。")
    print("最终化完成。")