# core/rigging/build_fk.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool


def build(builder):
    """
    构建基础 FK 系统。

    层级分工：
    1. 驱动结构 (FKOffset -> FKExtra -> FK -> FKX) 放在 FKSystem 组下。
    2. 约束节点 (parentConstraint / scaleConstraint) 放在 ConstraintSystem 组下。
    """

    # 获取目标组
    geo_grp = builder.groups["geo"]
    fk_sys_grp = builder.groups["fk_sys"]  # 控制器驱动链的家
    constraint_sys_grp = builder.groups["constraint_sys"]  # 约束节点的家

    # 查找变形骨骼根节点
    roots = cmds.listRelatives(geo_grp, children=True, type="joint")
    if not roots:
        print("[Build FK] Warning: No skeleton found in Geometry_Grp.")
        return

    deform_root = roots[0]
    print(f">>> [Build FK] Building chain for: {deform_root}")

    # 递归处理
    _process_hierarchy(deform_root, None, fk_sys_grp, constraint_sys_grp)


def _process_hierarchy(current_joint, parent_fkx_joint, fk_sys_grp, const_sys_grp):
    """
    递归构建 FK 节点并整理层级。
    """

    short_name = current_joint.split("|")[-1]

    # 命名规范
    offset_name = f"FKOffset_{short_name}"
    extra_name = f"FKExtra_{short_name}"
    ctrl_name = f"FK_{short_name}"
    fkx_name = f"FKX_{short_name}"

    current_fkx = None

    # 1. 检查控制器是否已存在
    if cmds.objExists(ctrl_name):
        if cmds.objExists(fkx_name):
            current_fkx = fkx_name
    else:
        # --- A. 创建驱动链结构 ---

        # 1. FKOffset (Group)
        offset_node = cmds.createNode("transform", name=offset_name)
        cmds.matchTransform(offset_node, current_joint, pos=True, rot=True)

        # 2. FKExtra (Group)
        extra_node = cmds.createNode("transform", name=extra_name, parent=offset_node)
        cmds.setAttr(f"{extra_node}.t", 0, 0, 0)
        cmds.setAttr(f"{extra_node}.r", 0, 0, 0)

        # 3. FK Control (Curve)
        ctrl_node = cmds.circle(name=ctrl_name, normal=(1, 0, 0), radius=1.5, ch=False)[0]
        cmds.parent(ctrl_node, extra_node)
        cmds.setAttr(f"{ctrl_node}.t", 0, 0, 0)
        cmds.setAttr(f"{ctrl_node}.r", 0, 0, 0)
        tool.set_draw(ctrl_node, color=17)  # 黄色

        # 4. FKX Shadow Joint
        cmds.select(clear=True)
        fkx_node = cmds.joint(name=fkx_name)
        cmds.parent(fkx_node, ctrl_node)
        cmds.setAttr(f"{fkx_node}.t", 0, 0, 0)
        cmds.setAttr(f"{fkx_node}.r", 0, 0, 0)
        cmds.setAttr(f"{fkx_node}.drawStyle", 2)  # None

        # --- B. 驱动链层级整理 ---
        if parent_fkx_joint and cmds.objExists(parent_fkx_joint):
            # 挂在上一级的影子骨骼下
            tool.safe_parent(offset_node, parent_fkx_joint)
        else:
            # 顶级节点挂在 FKSystem 组下
            tool.safe_parent(offset_node, fk_sys_grp)

        # --- C. 执行约束并移动约束节点 ---

        tool.unlock_transform(current_joint)

        try:
            # 创建位移/旋转约束
            p_cons = cmds.parentConstraint(fkx_node, current_joint, maintainOffset=True)[0]
            # 创建缩放约束
            s_cons = cmds.scaleConstraint(fkx_node, current_joint, maintainOffset=True)[0]

            # [核心修改] 将约束节点从骨骼层级移动到 ConstraintSystem 组下
            # Maya 允许这样做，且约束关系依然保持
            if cmds.objExists(const_sys_grp):
                tool.safe_parent(p_cons, const_sys_grp)
                tool.safe_parent(s_cons, const_sys_grp)

        except Exception as e:
            print(f"[Build FK] Constraint error on {current_joint}: {e}")

        current_fkx = fkx_node

    # --- 2. 递归子级 ---
    children = cmds.listRelatives(current_joint, children=True, type="joint", fullPath=True) or []
    for child in children:
        _process_hierarchy(child, current_fkx, fk_sys_grp, const_sys_grp)