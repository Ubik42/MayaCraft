"""Deterministically generate MayaCraft 2.2 demonstration scenes with Maya 2025."""

from __future__ import annotations

import json
import pathlib
import sys

import maya.standalone


PACKAGE_PARENT = pathlib.Path(__file__).resolve().parents[3]
sys.path.insert(0, str(PACKAGE_PARENT))
OUTPUT = pathlib.Path(__file__).resolve().parents[1] / "scenes"


def _joint(cmds, name, position, parent=""):
    cmds.select(clear=True)
    value = cmds.joint(name=name, position=position)
    if parent:
        cmds.parent(value, parent)
    return (cmds.ls(value, long=True) or [value])[0]


def _source_biped(cmds):
    root = _joint(cmds, "root_JNT", (0, 0, 0))
    pelvis = _joint(cmds, "pelvis_JNT", (0, 10, 0), root)
    spine = _joint(cmds, "spine_JNT", (0, 13, 0), pelvis)
    chest = _joint(cmds, "chest_JNT", (0, 17, 0), spine)
    neck = _joint(cmds, "neck_JNT", (0, 20, 0), chest)
    _joint(cmds, "head_JNT", (0, 23, 0), neck)
    for prefix, sign in (("L", 1), ("R", -1)):
        arm = _joint(cmds, f"{prefix}_upperArm_JNT", (4 * sign, 17, 0), chest)
        forearm = _joint(cmds, f"{prefix}_forearm_JNT", (8 * sign, 17, 0), arm)
        _joint(cmds, f"{prefix}_hand_JNT", (11 * sign, 17, 0), forearm)
        thigh = _joint(cmds, f"{prefix}_thigh_JNT", (3 * sign, 9, 0), pelvis)
        calf = _joint(cmds, f"{prefix}_calf_JNT", (3 * sign, 5, 0), thigh)
        _joint(cmds, f"{prefix}_foot_JNT", (3 * sign, 1, 1), calf)
    return root


def _build_graph(cmds, graph_id):
    from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph

    cmds.select("L_hand_JNT")
    skeleton = MayaSkeletonScanner().capture_selection()
    if not skeleton.is_usable:
        raise RuntimeError("合成骨架语义分析失败")
    graph = bind_graph_to_skeleton(golden_biped_graph(graph_id), skeleton)
    service = MayaRigGraphService()
    receipt = service.apply(graph, service.plan(graph))
    if not receipt.verified:
        raise RuntimeError("合成绑定图验证失败")
    return graph


def _tag(cmds, root, scenario, expected):
    for name, value in (("mayacraftDemoScenario", scenario), ("mayacraftExpectedResult", expected)):
        if not cmds.attributeQuery(name, node=root, exists=True):
            cmds.addAttr(root, longName=name, dataType="string")
        cmds.setAttr(f"{root}.{name}", value, type="string")


def _save(cmds, filename):
    path = OUTPUT / filename
    cmds.file(rename=str(path))
    cmds.file(save=True, type="mayaAscii", force=True)
    return path


def generate_success(cmds):
    cmds.file(new=True, force=True)
    root = _source_biped(cmds)
    _build_graph(cmds, "demoMatchSuccess")
    upper = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL"
    lower = upper + "|L_forearm_FK_CTRL"
    for frame, upper_z, lower_z in ((1, 0.0, 0.0), (12, 18.0, -32.0), (24, -10.0, 24.0)):
        cmds.setKeyframe(upper, attribute="rotateZ", time=frame, value=upper_z)
        cmds.setKeyframe(lower, attribute="rotateZ", time=frame, value=lower_z)
    cmds.playbackOptions(minTime=1, maxTime=24)
    cmds.currentTime(12)
    cmds.select(upper)
    _tag(cmds, root, "FK_TO_IK_SUCCESS", "第 12 帧预览 FK→IK 后应用，输出骨架无跳变并生成关键帧")
    return _save(cmds, "mayacraft_match_success.ma")


def generate_locked(cmds):
    cmds.file(new=True, force=True)
    root = _source_biped(cmds)
    _build_graph(cmds, "demoMatchLocked")
    ik = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_IK_SPACE|L_hand_IK_CTRL"
    cmds.setAttr(ik + ".translateX", lock=True)
    cmds.select(ik)
    _tag(cmds, root, "LOCKED_CONTROL_BLOCKER", "预览 FK→IK 时显示控制通道不可写，场景不产生任何修改")
    return _save(cmds, "mayacraft_match_locked.ma")


def generate_space(cmds):
    cmds.file(new=True, force=True)
    root = _source_biped(cmds)
    _build_graph(cmds, "demoSpaceSwitch")
    chest = "|MC_RIG|MC_CONTROLS|C_spine_MOD|C_chest_FK_CTRL"
    ik = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_IK_SPACE|L_hand_IK_CTRL"
    cmds.setKeyframe(chest, attribute="translateY", time=1, value=0.0)
    cmds.setKeyframe(chest, attribute="translateY", time=24, value=4.0)
    cmds.setKeyframe(ik, attribute="ikFk", time=1, value=1.0)
    cmds.setKeyframe(ik, attribute="ikFk", time=24, value=1.0)
    cmds.playbackOptions(minTime=1, maxTime=24)
    cmds.currentTime(12)
    cmds.select(ik)
    _tag(cmds, root, "KEYED_SPACE_SWITCH", "第 12 帧从全局切到胸腔；第 11 帧保护键与第 12 帧补偿键保持手腕世界姿态")
    return _save(cmds, "mayacraft_space_switch.ma")


def generate_twist(cmds):
    cmds.file(new=True, force=True)
    root = _source_biped(cmds)
    _build_graph(cmds, "demoTwistSculpt")
    lower = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL|L_forearm_FK_CTRL"
    for frame, twist in ((1, 0.0), (12, 90.0), (24, -70.0)):
        cmds.setKeyframe(lower, attribute="rotateX", time=frame, value=twist)
    cmds.playbackOptions(minTime=1, maxTime=24)
    cmds.currentTime(12)
    cmds.select(lower)
    _tag(
        cmds, root, "QUATERNION_TWIST_SCULPT",
        "第 12 帧检测 90 度纯 Twist；预览偏置曲线后应用，三枚实时关节按 quaternion slerp 分配并可撤销",
    )
    return _save(cmds, "mayacraft_twist_sculpt.ma")


def generate_blocked_skeleton(cmds):
    cmds.file(new=True, force=True)
    root = _joint(cmds, "root_JNT", (0, 0, 0))
    pelvis = _joint(cmds, "pelvis_JNT", (0, 10, 0), root)
    spine = _joint(cmds, "spine_JNT", (0, 14, 0), pelvis)
    _tag(cmds, root, "INCOMPLETE_SKELETON", "扫描后明确提示缺少胸腔、头部和四肢语义，不允许构建")
    cmds.select(spine)
    return _save(cmds, "mayacraft_skeleton_blocked.ma")


def main():
    import maya.cmds as cmds

    OUTPUT.mkdir(parents=True, exist_ok=True)
    results = tuple(str(function(cmds)) for function in (
        generate_success, generate_locked, generate_space, generate_twist, generate_blocked_skeleton,
    ))
    print(json.dumps({"generated": results, "maya": cmds.about(version=True)}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    maya.standalone.initialize(name="python")
    try:
        main()
    finally:
        maya.standalone.uninitialize()
