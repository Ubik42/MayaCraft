"""Maya 2025 transactional proof for no-pop FK/IK and keyed space switching."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
    from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
    from MayaCraft.adapters.maya.rig_switching import MayaRigSwitchService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph

    def joint(name, position, parent=""):
        cmds.select(clear=True)
        value = cmds.joint(name=name, position=position)
        if parent:
            cmds.parent(value, parent)
        return (cmds.ls(value, long=True) or [value])[0]

    source_root = joint("root_JNT", (0, 0, 0))
    pelvis = joint("pelvis_JNT", (0, 10, 0), source_root)
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

    cmds.select("L_hand_JNT")
    skeleton = MayaSkeletonScanner().capture_selection()
    graph = bind_graph_to_skeleton(golden_biped_graph("switchingTest"), skeleton)
    rig_service = MayaRigGraphService()
    build_receipt = rig_service.apply(graph, rig_service.plan(graph))
    switch_service = MayaRigSwitchService(rig_service)

    upper = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL"
    lower = upper + "|L_forearm_FK_CTRL"
    ik_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_IK_SPACE|L_hand_IK_CTRL"
    result_end = "|MC_RIG|MC_DELIVERY|L_upperArm_RESULT_JNT|L_forearm_RESULT_JNT|L_hand_RESULT_JNT"

    # FK -> IK: bend the FK chain, preview, key, verify and undo the whole transaction.
    cmds.currentTime(12)
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Match FK Setup")
    cmds.setAttr(upper + ".rotateZ", 18.0)
    cmds.setAttr(lower + ".rotateZ", -32.0)
    cmds.undoInfo(closeChunk=True)
    result_before = tuple(cmds.xform(result_end, query=True, worldSpace=True, matrix=True))
    fk_to_ik = switch_service.plan_match(graph, "l_arm", "FK_TO_IK")
    assert fk_to_ik.can_apply, fk_to_ik.blockers
    fk_receipt = switch_service.apply_match(graph, fk_to_ik, key=True)
    assert fk_receipt.verified and fk_receipt.maximum_position_error < 1e-4, fk_receipt
    assert max(abs(a - b) for a, b in zip(cmds.xform(result_end, query=True, worldSpace=True, matrix=True), result_before)) < 1e-4
    assert abs(cmds.getAttr(ik_control + ".ikFk") - 1.0) < 1e-8
    assert switch_service.undo_match(graph, fk_receipt)
    assert abs(cmds.getAttr(ik_control + ".ikFk")) < 1e-8
    cmds.undo()  # FK setup

    # IK -> FK: move the IK target, match every FK control in hierarchy order and undo.
    cmds.currentTime(20)
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Match IK Setup")
    cmds.setAttr(ik_control + ".ikFk", 1.0)
    cmds.xform(ik_control, worldSpace=True, translation=(10.0, 18.0, 2.0))
    cmds.undoInfo(closeChunk=True)
    ik_result_before = tuple(cmds.xform(result_end, query=True, worldSpace=True, matrix=True))
    ik_to_fk = switch_service.plan_match(graph, "l_arm", "IK_TO_FK")
    assert ik_to_fk.can_apply, ik_to_fk.blockers
    ik_receipt = switch_service.apply_match(graph, ik_to_fk, key=True)
    assert ik_receipt.verified and ik_receipt.maximum_matrix_error < 1e-3, ik_receipt
    assert max(abs(a - b) for a, b in zip(cmds.xform(result_end, query=True, worldSpace=True, matrix=True), ik_result_before)) < 1e-4
    assert abs(cmds.getAttr(ik_control + ".ikFk")) < 1e-8
    assert switch_service.undo_match(graph, ik_receipt)
    assert abs(cmds.getAttr(ik_control + ".ikFk") - 1.0) < 1e-8
    cmds.undo()  # IK setup

    # Keyed space switch: guard old space on the previous frame and preserve world pose.
    cmds.currentTime(30)
    space_before = tuple(cmds.xform(ik_control, query=True, worldSpace=True, matrix=True))
    space_plan = switch_service.plan_space(graph, "l_arm", 1, create_guard_key=True)
    assert space_plan.can_apply, space_plan.blockers
    space_receipt = switch_service.apply_space(graph, space_plan, key=True)
    assert space_receipt.verified and space_receipt.maximum_matrix_error < 1e-4, space_receipt
    assert max(abs(a - b) for a, b in zip(cmds.xform(ik_control, query=True, worldSpace=True, matrix=True), space_before)) < 1e-4
    assert cmds.getAttr(ik_control + ".space") == 1
    assert cmds.keyframe(ik_control + ".space", query=True, time=(29, 30), keyframeCount=True) == 2
    assert switch_service.undo_space(graph, space_receipt)
    assert cmds.getAttr(ik_control + ".space") == 0

    # Failure path: a locked target is blocked during preview and writes nothing.
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Locked Preview Probe")
    cmds.setAttr(ik_control + ".translateX", lock=True)
    blocked = switch_service.plan_match(graph, "l_arm", "FK_TO_IK")
    assert not blocked.can_apply
    assert any(item.code == "locked_channel" for item in blocked.blockers), blocked.blockers
    cmds.setAttr(ik_control + ".translateX", lock=False)
    cmds.undoInfo(closeChunk=True)
    cmds.undo()

    assert rig_service.plan(graph).is_noop
    print(
        "MAYACRAFT_RIG_SWITCHING_OK",
        fk_receipt.maximum_position_error,
        fk_receipt.maximum_matrix_error,
        ik_receipt.maximum_position_error,
        space_receipt.maximum_matrix_error,
    )
finally:
    maya.standalone.uninitialize()
