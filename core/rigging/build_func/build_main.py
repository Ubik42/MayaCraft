# core/rigging/build_func/build_main.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from MayaCraft.core import tool
from MayaCraft.core import controller  # 引用你新的 controller.py


def create_main_root(groups: dict):
    """
    创建 Main 和 Root 控制器体系。

    Hierarchy Check:
    - MainSystem
        - Main (Controller)
    - RootSystem
        - RootFollowMain (Constrained to Main)
            - RootOffsetX_M (Matched to Joint Position)
                - RootExtraX_M
                    - RootX_M (Controller)
    - GlobalSystem
        - GlobalFollowMain (Constrained to Main)
    """

    # ==========================================
    # 1. Main Controller
    # ==========================================
    main_name = "Main"
    main_sys = groups.get("main_sys", "MainSystem")

    if not cmds.objExists(main_name):
        # 使用 controller 工厂创建，形状设为 "Main_Ctrl" 或默认圆环
        # 半径给大一点，它是总控
        main_ctrl = controller.create_controller(main_name, shape="Main_Ctrl", color=17, radius=20)
        tool.safe_parent(main_ctrl, main_sys)

        # Main 通常不需要被任何东西约束，它是顶层

    # ==========================================
    # 2. Global Follow Setup (辅助系统)
    # ==========================================
    global_sys = groups.get("global_sys", "GlobalSystem")
    global_follow = "GlobalFollowMain"

    if not cmds.objExists(global_follow):
        cmds.createNode("transform", name=global_follow)
        tool.safe_parent(global_follow, global_sys)

        # 这个组时刻跟随 Main，用于给头部/眼睛等做 Space Switching 的 "World" 参考
        cmds.parentConstraint(main_name, global_follow, maintainOffset=True)
        cmds.scaleConstraint(main_name, global_follow, maintainOffset=True)

    # ==========================================
    # 3. Root Controller Setup (核心逻辑)
    # ==========================================
    root_sys = groups.get("root_sys", "RootSystem")

    # 定义层级名称
    root_follow = "RootFollowMain"
    root_offset = "RootOffsetX_M"
    root_extra = "RootExtraX_M"
    root_ctrl_name = "RootX_M"

    # --- A. 寻找场景中的 Root 骨骼 ---
    # 逻辑：在 Geometry_Grp 下找第一个骨骼，通常这就是盆骨/根骨骼
    geo_grp = groups.get("geo", "Geometry_Grp")
    root_jnt = None
    if cmds.objExists(geo_grp):
        children = cmds.listRelatives(geo_grp, children=True, type="joint", fullPath=True)
        if children:
            root_jnt = children[0]

            # 只有找到骨骼才创建 Root 控制器
    if root_jnt and cmds.objExists(root_jnt):

        # --- B. 构建 RootFollowMain ---
        # 这个组也是跟随 Main 的，通常位于世界原点(或Main的位置)
        if not cmds.objExists(root_follow):
            cmds.createNode("transform", name=root_follow)
            tool.safe_parent(root_follow, root_sys)

            # 约束到 Main
            cmds.parentConstraint(main_name, root_follow, maintainOffset=True)
            cmds.scaleConstraint(main_name, root_follow, maintainOffset=True)

        # --- C. 构建 Root 偏移层级 ---

        # 1. RootOffsetX_M
        # 这是定位组，位置应该在骨骼处，但方向通常保持世界方向(0,0,0)方便动画
        if not cmds.objExists(root_offset):
            cmds.createNode("transform", name=root_offset)
            tool.safe_parent(root_offset, root_follow)

            # 【关键】将 Offset 组移动到骨骼位置
            # pos=True (吸附位置), rot=False (不吸附旋转，保持世界水平)
            # 如果你希望 Root 控制器是歪的(对齐骨骼轴向)，这里 rot=True
            cmds.matchTransform(root_offset, root_jnt, pos=True, rot=False)

        # 2. RootExtraX_M
        # 这是一个缓冲组/零组，位置归零相对于 Offset
        if not cmds.objExists(root_extra):
            cmds.createNode("transform", name=root_extra)
            tool.safe_parent(root_extra, root_offset)
            # 归零 (因为父级 Offset 已经对位了)
            tool.reset_transform(root_extra)

        # 3. RootX_M (控制器)
        if not cmds.objExists(root_ctrl_name):
            # 创建控制器，形状 "Root_Ctrl" 或 "Pin"
            root_ctrl = controller.create_controller(root_ctrl_name, shape="Root_Ctrl", color=18,
                                                     radius=12)  # Light Blue
            tool.safe_parent(root_ctrl, root_extra)

            # 归零 (确保控制器数值干净)
            tool.reset_transform(root_ctrl)

            # --- D. 驱动骨骼 ---
            # 解锁骨骼（防止它是锁定的）
            tool.unlock_transform(root_jnt, translate=True, rotate=True, scale=True, visibility=True)

            # 约束骨骼
            cmds.parentConstraint(root_ctrl, root_jnt, maintainOffset=True)
            cmds.scaleConstraint(root_ctrl, root_jnt, maintainOffset=True)

            print(f"[Build] Root Control System Created: {root_ctrl_name} (at {root_jnt})")