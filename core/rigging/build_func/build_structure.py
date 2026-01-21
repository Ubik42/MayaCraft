# core/rigging/build_func/build_structure.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool

def build_scene_structure(groups: dict):
    """建立完整的场景组结构"""
    # 1. Main Group
    if not cmds.objExists(groups["main"]):
        cmds.createNode("transform", name=groups["main"])

    for key in ["geo", "ctrl"]:
        grp_name = groups[key]
        if not cmds.objExists(grp_name):
            cmds.createNode("transform", name=grp_name)
        tool.safe_parent(grp_name, groups["main"])

    ctrl_grp = groups["ctrl"]
    special_keys = ["main", "geo", "ctrl", "ik_joints", "ik_handle", "ik_pv"]
    
    for key, grp_name in groups.items():
        if key in special_keys: continue
        if not cmds.objExists(grp_name):
            cmds.createNode("transform", name=grp_name)
        tool.safe_parent(grp_name, ctrl_grp)
        
    ik_sys = groups["ik_sys"]
    for key in ["ik_joints", "ik_handle", "ik_pv"]:
        grp_name = groups[key]
        if not cmds.objExists(grp_name):
            cmds.createNode("transform", name=grp_name)
        tool.safe_parent(grp_name, ik_sys)
