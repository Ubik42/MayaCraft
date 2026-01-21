# core/rigging/build_func/build_base_fk.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
import traceback
import core.rigging.basic.fk as basic_fk

def build_base_fk(groups: dict):
    """调用 basic_fk 生成基础 FK 系统"""
    geo_grp = groups["geo"]
    if not cmds.objExists(geo_grp): return
    roots = cmds.listRelatives(geo_grp, children=True, type="joint")
    if not roots:
        print("[Build FK] Warning: No skeleton found in Geometry_Grp.")
        return

    deform_root = roots[0]
    try:
        basic_fk.build_fk_hierarchy(start_joint=deform_root)
    except Exception as e:
        print(f"Error building base FK: {e}")
        traceback.print_exc()
