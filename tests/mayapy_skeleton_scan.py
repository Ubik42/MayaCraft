"""Maya 2025 read-only skeleton semantic capture against a golden scene."""

from __future__ import annotations

import pathlib
import sys
import maya.standalone

maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds
    sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner

    def joint(name, position, parent=""):
        cmds.select(clear=True)
        value = cmds.joint(name=name, position=position)
        if parent:
            cmds.parent(value, parent)
        return (cmds.ls(value, long=True) or [value])[0]

    root = joint("root_JNT", (0, 0, 0))
    pelvis = joint("pelvis_JNT", (0, 10, 0), root)
    spine = joint("spine_JNT", (0, 13, 0), pelvis)
    chest = joint("chest_JNT", (0, 17, 0), spine)
    neck = joint("neck_JNT", (0, 20, 0), chest)
    joint("head_JNT", (0, 23, 0), neck)
    for prefix, sign in (("L", 1), ("R", -1)):
        arm = joint(f"{prefix}_upperArm_JNT", (4 * sign, 17, 0), chest)
        forearm = joint(f"{prefix}_forearm_JNT", (8 * sign, 17, 0), arm)
        joint(f"{prefix}_hand_JNT", (11 * sign, 17, 0), forearm)
        thigh = joint(f"{prefix}_thigh_JNT", (3 * sign, 9, 0), pelvis)
        calf = joint(f"{prefix}_calf_JNT", (3 * sign, 5, 0), thigh)
        joint(f"{prefix}_foot_JNT", (3 * sign, 1, 1), calf)
    cmds.currentTime(7)
    cmds.select("L_hand_JNT")
    selection_before = tuple(cmds.ls(selection=True, long=True) or [])
    result = MayaSkeletonScanner().capture_selection()
    assert result.is_usable, result.issues
    assert len(result.joints) == 18, len(result.joints)
    assert result.semantic("left_hand").path.endswith("|L_hand_JNT")
    assert result.semantic("right_foot").path.endswith("|R_foot_JNT")
    assert result.symmetry_score == 100, result.symmetry_score
    assert cmds.currentTime(query=True) == 7
    assert tuple(cmds.ls(selection=True, long=True) or []) == selection_before
    print("MAYACRAFT_SKELETON_OK", len(result.joints), len(result.semantics), result.symmetry_score)
finally:
    maya.standalone.uninitialize()
