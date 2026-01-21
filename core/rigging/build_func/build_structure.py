# core/rigging/build_func/build_structure.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool


def build_scene_structure():
    """建立完整的场景组结构"""

    # --- 1. 顶层结构 ---
    # 既然名字都定死了，直接用字符串
    if not cmds.objExists("Group"):
        cmds.createNode("transform", name="Group")

    # --- 2. 第二层级 (Geo & Ctrl) ---
    for name in ["Geometry_Grp", "Controls_Grp"]:
        if not cmds.objExists(name):
            cmds.createNode("transform", name=name)
        tool.safe_parent(name, "Group")

    # --- 3. 系统组 (全部都在 Controls_Grp 下面) ---
    system_list = [
        "MainSystem",
        "RootSystem",
        "GlobalSystem",
        "FKSystem",
        "IKSystem",
        "FKIKSystem",
        "DrivingSystem",
        "AimSystem",
        "BendSystem",
        "TwistSystem",
        "ConstraintSystem",
        "DynamicSystem",
        "buildPose"
    ]

    for name in system_list:
        if not cmds.objExists(name):
            cmds.createNode("transform", name=name)
        tool.safe_parent(name, "Controls_Grp")

    # --- 4. IK 子结构 (在 IKSystem 下面) ---
    ik_sub_list = ["IKJoints", "IKHandle", "IKPoleVector"]

    for name in ik_sub_list:
        if not cmds.objExists(name):
            cmds.createNode("transform", name=name)
        tool.safe_parent(name, "IKSystem")