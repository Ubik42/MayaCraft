"""Maya 2025 transactional validation for the declarative Rig Graph compiler."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    package_parent = pathlib.Path(__file__).resolve().parents[2]
    sys.path.insert(0, str(package_parent))
    from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
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
    assert skeleton.is_usable

    graph = bind_graph_to_skeleton(golden_biped_graph("goldenBipedTest"), skeleton)
    service = MayaRigGraphService()
    initial = service.plan(graph)
    assert initial.can_apply
    assert all(change.action == "CREATE" for change in initial.changes), initial
    receipt = service.apply(graph, initial)
    assert receipt.verified and receipt.applied_count == len(graph.nodes) + len(graph.behaviors), receipt
    assert len(service.scan(graph.graph_id)) == len(graph.nodes)
    assert len(service.scan_behaviors(graph.graph_id)) == len(graph.behaviors)
    assert service.plan(graph).is_noop
    hand_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL|L_forearm_FK_CTRL|L_hand_FK_CTRL"
    fk_hand_joint = "|MC_RIG|MC_DEFORM|L_upperArm_FK_DRV_JNT|L_forearm_FK_DRV_JNT|L_hand_FK_DRV_JNT"
    result_hand_joint = "|MC_RIG|MC_DELIVERY|L_upperArm_RESULT_JNT|L_forearm_RESULT_JNT|L_hand_RESULT_JNT"
    ik_control = "|MC_RIG|MC_CONTROLS|L_arm_MOD|L_arm_IK_SPACE|L_hand_IK_CTRL"
    assert cmds.objExists(hand_control)
    assert cmds.getAttr(hand_control + ".mayacraftRigNodeId") == "l_arm.fk.2"
    assert cmds.nodeType((cmds.listRelatives(hand_control, shapes=True, fullPath=True) or [""])[0]) == "nurbsCurve"
    cmds.setAttr("|MC_RIG|MC_CONTROLS|L_arm_MOD|L_upperArm_FK_CTRL.rotateZ", 27.0)
    driven_rotation = cmds.xform("|MC_RIG|MC_DELIVERY|L_upperArm_RESULT_JNT", query=True, worldSpace=True, rotation=True)
    assert abs(driven_rotation[2] - 27.0) < 1e-5, driven_rotation
    assert cmds.isConnected("l_arm_drive_2_MMX.matrixSum", fk_hand_joint + ".offsetParentMatrix")
    assert cmds.isConnected("l_arm_blend_2_LOCAL_MMX.matrixSum", result_hand_joint + ".offsetParentMatrix")
    cmds.undo()  # Only undo the interaction probe; the next undo owns the build transaction.
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft IK Interaction Probe")
    cmds.setAttr(ik_control + ".ikFk", 1.0)
    ik_target = (10.0, 18.0, 2.0)
    cmds.xform(ik_control, worldSpace=True, translation=ik_target)
    cmds.undoInfo(closeChunk=True)
    ik_result = cmds.xform(result_hand_joint, query=True, worldSpace=True, translation=True)
    assert sum((value - expected) ** 2 for value, expected in zip(ik_result, ik_target)) ** 0.5 < 1e-4, (ik_result, ik_target)
    assert cmds.objExists(ik_control + "|l_arm_rp_ik_IKH")
    cmds.undo()  # Undo the complete IK interaction probe.
    rest_space_position = cmds.xform(ik_control, query=True, worldSpace=True, translation=True)
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Space Interaction Probe")
    cmds.setAttr(ik_control + ".space", 1)
    switched_position = cmds.xform(ik_control, query=True, worldSpace=True, translation=True)
    chest_control = "|MC_RIG|MC_CONTROLS|C_spine_MOD|C_chest_FK_CTRL"
    cmds.setAttr(chest_control + ".translateY", cmds.getAttr(chest_control + ".translateY") + 2.0)
    followed_position = cmds.xform(ik_control, query=True, worldSpace=True, translation=True)
    cmds.undoInfo(closeChunk=True)
    assert sum((value - expected) ** 2 for value, expected in zip(switched_position, rest_space_position)) ** 0.5 < 1e-5
    assert abs((followed_position[1] - switched_position[1]) - 2.0) < 1e-5, (switched_position, followed_position)
    cmds.undo()
    assert service.undo(graph, receipt)
    assert not service.scan(graph.graph_id)
    assert not service.scan_behaviors(graph.graph_id)

    second_receipt = service.apply(graph, service.plan(graph))
    head = "|MC_RIG|MC_CONTROLS|C_spine_MOD|C_chest_FK_CTRL|C_head_FK_CTRL"
    root = "|MC_RIG"
    cmds.parent(head, root)
    reparent_plan = service.plan(graph)
    head_change = next(change for change in reparent_plan.changes if change.stable_id == "head.ctrl")
    assert head_change.action == "REPARENT", head_change
    reparent_receipt = service.apply(graph, reparent_plan)
    assert service.plan(graph).is_noop
    assert service.undo(graph, reparent_receipt)
    assert next(item for item in service.scan(graph.graph_id) if item.stable_id == "head.ctrl").parent_id == "rig.root"

    # A severed physical connection is detected even when metadata is intact.
    matrix_node = "l_arm_drive_2_MMX"
    target_plug = "|MC_RIG|MC_DEFORM|L_upperArm_FK_DRV_JNT|L_forearm_FK_DRV_JNT|L_hand_FK_DRV_JNT.offsetParentMatrix"
    cmds.disconnectAttr(matrix_node + ".matrixSum", target_plug)
    drift_plan = service.plan(graph)
    behavior_change = next(item for item in drift_plan.behavior_changes if item.stable_id == "l_arm.drive.2")
    assert behavior_change.action == "UPDATE", behavior_change
    drift_receipt = service.apply(graph, drift_plan)
    assert service.plan(graph).is_noop
    assert cmds.isConnected(matrix_node + ".matrixSum", target_plug)
    assert service.undo(graph, drift_receipt)
    assert not cmds.isConnected(matrix_node + ".matrixSum", target_plug)
    service.apply(graph, service.plan(graph))

    stale_head = "|MC_RIG|MC_CONTROLS|C_spine_MOD|C_chest_FK_CTRL|C_head_FK_CTRL"
    stale_head = cmds.parent(stale_head, "|MC_RIG")[0]
    stale_plan = service.plan(graph)
    assert stale_plan.can_apply
    cmds.rename(stale_head, "C_head_CHANGED")
    try:
        service.apply(graph, stale_plan)
        raise AssertionError("Expected stale Rig Graph plan to be rejected")
    except RuntimeError as exc:
        assert "预览后绑定图已经变化" in str(exc), exc
    assert not service.plan(graph).is_noop
    print("MAYACRAFT_RIG_GRAPH_OK", len(graph.modules), len(graph.nodes), second_receipt.applied_count)
finally:
    maya.standalone.uninitialize()
