# core/rigging/build_func/build_main.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool

def create_main_root(groups: dict):
    """创建 Main 和 Root 控制器"""
    main_ctrl = "Main_ctrl"
    root_ctrl = "Root_ctrl"

    # 1. Main Ctrl
    if not cmds.objExists(main_ctrl):
        cmds.circle(n=main_ctrl, nr=(0, 1, 0), r=20, ch=False)
        cmds.setAttr(f"{main_ctrl}.overrideEnabled", 1)
        cmds.setAttr(f"{main_ctrl}.overrideColor", 17)
        tool.safe_parent(main_ctrl, groups["main_sys"])
        
        # Constraint specific groups
        exclude_grps = [groups["main_sys"], groups["geo"], groups["ctrl"], groups["main"]]
        for key, grp_name in groups.items():
            if grp_name in exclude_grps: continue
            if key in ["ik_joints", "ik_handle", "ik_pv"]: continue
            if cmds.objExists(grp_name):
                if not cmds.listConnections(grp_name, type="parentConstraint"):
                    cmds.parentConstraint(main_ctrl, grp_name, maintainOffset=True)

    # 2. Root Ctrl
    # Try to find root joint provided by Spine or just first Joint in Geometry
    root_jnt = None
    geo_grp = groups["geo"]
    if cmds.objExists(geo_grp):
        children = cmds.listRelatives(geo_grp, children=True, type="joint", fullPath=True)
        if children:
            root_jnt = children[0]

    if root_jnt and cmds.objExists(root_jnt) and not cmds.objExists(root_ctrl):
        cmds.circle(n=root_ctrl, nr=(0, 1, 0), r=15, ch=False)
        cmds.setAttr(f"{root_ctrl}.overrideEnabled", 1)
        cmds.setAttr(f"{root_ctrl}.overrideColor", 18)
        cmds.matchTransform(root_ctrl, root_jnt, pos=True, rot=False)
        tool.safe_parent(root_ctrl, main_ctrl)
        tool.unlock_transform(root_jnt, translate=True, rotate=True, scale=True, visibility=True)
        cmds.parentConstraint(root_ctrl, root_jnt, maintainOffset=True)
        cmds.scaleConstraint(root_ctrl, root_jnt, maintainOffset=True)
        print(f"[Build] Root Control Created: {root_ctrl} -> {root_jnt}")
