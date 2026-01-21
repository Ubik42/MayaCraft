# core/rigging/build_func/build_utils.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds

def create_controller_set(groups: dict):
    """扫描场景中的控制器并添加到 Set"""
    set_name = "Rig_Controls_Set"
    target_roots = [groups['ctrl'], groups['main_sys']]
    valid_roots = [r for r in target_roots if cmds.objExists(r)]
    found_ctrls = set()
    
    if valid_roots:
        descendants = cmds.listRelatives(valid_roots, allDescendents=True, fullPath=True) or []
        descendants.extend(cmds.ls(valid_roots, long=True))
        for obj in descendants:
            if not cmds.objExists(obj): continue
            if cmds.nodeType(obj) != 'transform': continue
            shapes = cmds.listRelatives(obj, shapes=True, fullPath=True) or []
            has_curve = False
            for shp in shapes:
                if cmds.nodeType(shp) == 'nurbsCurve' and not cmds.getAttr(f"{shp}.intermediateObject"):
                    has_curve = True
                    break
            if has_curve:
                found_ctrls.add(obj)
    
    if cmds.objExists(set_name): cmds.delete(set_name)
    cmds.sets(name=set_name, empty=True)
    if found_ctrls:
        cmds.sets(list(found_ctrls), addElement=set_name)
    print(f"[Set] Added {len(found_ctrls)} controllers to {set_name}.")

