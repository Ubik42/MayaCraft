# -*- coding: utf-8 -*-
"""
general_tab_logic.py
通用功能标签页的后端逻辑。
此模块包含所有与 Maya 场景交互的函数。
"""

import maya.cmds as cmds
from typing import List

# --- 控制器形状数据 ---
# 预先定义好不同形状曲线的 CV 点坐标
CONTROLLER_SHAPES = {
    "circle": {
        "points": [(0, 1, 0), (0.707, 0.707, 0), (1, 0, 0), (0.707, -0.707, 0),
                   (0, -1, 0), (-0.707, -0.707, 0), (-1, 0, 0), (-0.707, 0.707, 0)],
        "degree": 3,
        "knots": [0, 0, 0, 1, 2, 3, 4, 5, 5, 5]
    },
    "cube": {
        "points": [(-1, 1, 1), (1, 1, 1), (1, 1, -1), (-1, 1, -1),
                   (-1, 1, 1), (-1, -1, 1), (1, -1, 1), (1, 1, 1),
                   (1, -1, 1), (1, -1, -1), (1, 1, -1), (1, -1, -1),
                   (-1, -1, -1), (-1, 1, -1), (-1, -1, -1), (-1, -1, 1)],
        "degree": 1,
        "knots": list(range(16))
    },
    "sphere": {
        "points": [(0, 1, 0), (0.707, 0.707, 0), (1, 0, 0), (0.707, -0.707, 0),
                   (0, -1, 0), (-0.707, -0.707, 0), (-1, 0, 0), (-0.707, 0.707, 0), (0, 1, 0)],
        "degree": 3,
        "knots": [0, 0, 0, 1, 2, 3, 4, 5, 6, 6, 6]
    }
}
# 为球体额外创建两个圆形
SPHERE_EXTRA_CURVES = [
    {"normal": (1, 0, 0)},
    {"normal": (0, 0, 1)}
]


def get_first_selected() -> str:
    """获取当前选中的第一个对象。"""
    selection = cmds.ls(selection=True, type='transform')
    return selection[0] if selection else ""


def get_all_selected() -> List[str]:
    """获取所有选中的对象。"""
    return cmds.ls(selection=True, type='transform')


def align_transform(target: str, sources: List[str]):
    """将目标对象的变换设置为源对象变换的平均值。"""
    if not target or not sources:
        cmds.warning("目标或源未指定。")
        return

    if not cmds.objExists(target):
        cmds.warning(f"目标对象 '{target}' 不存在。")
        return

    avg_pos = [0.0, 0.0, 0.0]
    num_sources = len(sources)

    for src in sources:
        if not cmds.objExists(src):
            cmds.warning(f"源对象 '{src}' 不存在，已跳过。")
            num_sources -= 1
            continue
        pos = cmds.xform(src, query=True, worldSpace=True, translation=True)
        avg_pos[0] += pos[0]
        avg_pos[1] += pos[1]
        avg_pos[2] += pos[2]

    if num_sources > 0:
        avg_pos = [val / num_sources for val in avg_pos]
        cmds.xform(target, worldSpace=True, translation=avg_pos)
        print(f"已将 '{target}' 定位到 {len(sources)} 个源的平均位置。")


def replace_selected_controllers(shape_type: str):
    """将选中的曲线控制器替换为指定形状。"""
    if shape_type not in CONTROLLER_SHAPES:
        cmds.warning(f"未知的控制器形状: {shape_type}")
        return

    selection = cmds.ls(selection=True, type='transform')
    if not selection:
        cmds.warning("请先选中要替换的控制器。")
        return

    shape_data = CONTROLLER_SHAPES[shape_type]

    for sel_obj in selection:
        old_shapes = cmds.listRelatives(sel_obj, shapes=True, fullPath=True)
        if not old_shapes:
            print(f"'{sel_obj}' 没有曲线形状可替换，已跳过。")
            continue

        cmds.delete(old_shapes)

        new_shape_transform = cmds.curve(
            p=shape_data["points"],
            d=shape_data["degree"],
            k=shape_data["knots"]
        )

        # 特殊处理球体，额外创建两个圆环
        if shape_type == "sphere":
            for extra_data in SPHERE_EXTRA_CURVES:
                extra_curve = cmds.circle(normal=extra_data["normal"], ch=False)[0]
                extra_shape = cmds.listRelatives(extra_curve, s=True, f=True)[0]
                cmds.parent(extra_shape, new_shape_transform, r=True, s=True)
                cmds.delete(extra_curve)

        new_shape = cmds.listRelatives(new_shape_transform, shapes=True, fullPath=True)[0]
        cmds.parent(new_shape, sel_obj, relative=True, shape=True)
        cmds.delete(new_shape_transform)

    print(f"已将 {len(selection)} 个控制器替换为 '{shape_type}' 形状。")


def freeze_transform_to_parent_group():
    """为选中对象创建父组，并将变换转移到父组上。"""
    selection = cmds.ls(selection=True, type='transform')
    if not selection:
        cmds.warning("请先选中要操作的对象。")
        return

    for obj in selection:
        matrix = cmds.xform(obj, query=True, worldSpace=True, matrix=True)
        grp_name = f"grp_{obj.split('|')[-1]}"
        parent = cmds.listRelatives(obj, parent=True, fullPath=True)

        grp = cmds.group(empty=True, name=grp_name)

        if parent:
            cmds.parent(grp, parent[0])

        cmds.xform(grp, worldSpace=True, matrix=matrix)
        cmds.parent(obj, grp)

        # 将子对象的局部变换归零
        cmds.makeIdentity(obj, apply=True, translate=True, rotate=True, scale=True, normal=False)


def set_all_joint_radius(radius: float):
    """设置场景中所有骨骼的半径。"""
    all_joints = cmds.ls(type='joint')
    for joint in all_joints:
        try:
            cmds.setAttr(f"{joint}.radius", radius)
        except Exception as e:
            print(f"无法设置 '{joint}' 的半径: {e}")


def toggle_joint_axis_display(state: bool):
    """切换场景中所有骨骼的局部坐标轴显示。"""
    all_joints = cmds.ls(type='joint')
    for joint in all_joints:
        try:
            cmds.setAttr(f"{joint}.displayLocalAxis", state)
        except Exception as e:
            print(f"无法设置 '{joint}' 的 displayLocalAxis: {e}")


def quick_align(translate: bool, rotate: bool, scale: bool):
    """快速对齐。将选中的前N-1个物体对齐到最后一个物体。"""
    selection = cmds.ls(sl=True, type='transform')
    if len(selection) < 2:
        cmds.warning("请至少选中两个对象。最后一个将被视为目标。")
        return

    target = selection[-1]
    sources = selection[:-1]

    for src in sources:
        cmds.matchTransform(src, target, pos=translate, rot=rotate, scl=scale)
    print(f"已将 {len(sources)} 个对象对齐到 '{target}'。")



def create_joint_at_selection_center():
    """
    在当前选中项（物体或点线面）的中心创建一个骨骼，
    并确保骨骼位于大纲视图顶层。
    """
    # 获取选择（展开组件，例如选了多个点）
    sel = cmds.ls(sl=True, flatten=True)
    if not sel:
        cmds.warning("请先选择物体或点、线、面组件。")
        return

    try:
        # --- 核心算法：使用 Cluster（簇）快速获取中心 ---
        # 1. 对当前选择创建临时簇 (Maya会自动将簇手柄放在几何中心)
        # result 返回 [clusterNode, clusterHandle]
        cluster_result = cmds.cluster(sel)
        cluster_handle = cluster_result[1]

        # 2. 获取簇手柄的世界坐标 (Rotate Pivot)
        pos = cmds.xform(cluster_handle, query=True, worldSpace=True, rotatePivot=True)

        # 3. 删除临时簇
        cmds.delete(cluster_result)

        # --- 创建骨骼 ---
        # 4. 清除选择，防止骨骼被创建到选中的物体层级下
        cmds.select(clear=True)

        # 5. 在计算出的位置创建骨骼
        jnt = cmds.joint(p=pos, name="center_Jnt_01")

        # 6. 双重保险：确保骨骼在大纲顶层（World Parent）
        if cmds.listRelatives(jnt, parent=True):
            cmds.parent(jnt, world=True)

        cmds.select(jnt)
        print(f"已在中心创建骨骼: {jnt} 位置: {pos}")
        return jnt

    except Exception as e:
        cmds.error(f"创建中心骨骼失败: {e}")