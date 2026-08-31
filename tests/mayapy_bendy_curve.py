"""Maya 2025 transaction proof for Bendy curve, volume and Twist composition."""

from __future__ import annotations

import math
import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    package_parent = pathlib.Path(__file__).resolve().parents[2]
    sys.path.insert(0, str(package_parent))
    from MayaCraft.adapters.maya.bendy_sculpt import MayaBendySculptService
    from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph

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

    cmds.select("L_hand_JNT")
    graph = bind_graph_to_skeleton(
        golden_biped_graph("bendyHeroTest"), MayaSkeletonScanner().capture_selection(),
    )
    service = MayaRigGraphService()
    initial = service.plan(graph)
    assert initial.can_apply, initial.blockers
    build_receipt = service.apply(graph, initial)
    assert build_receipt.verified
    assert service.plan(graph).is_noop
    assert len(service.scan(graph.graph_id)) == 137
    assert len(service.scan_behaviors(graph.graph_id)) == 50
    behavior = next(item for item in service.scan_behaviors(graph.graph_id)
                    if item.stable_id == "l_arm.bendy.0")
    assert behavior.sources == (
        "l_arm.deform.0", "l_arm.bendy.0.in",
        "l_arm.bendy.0.out", "l_arm.deform.1",
    ), behavior.sources
    assert behavior.targets == (
        "l_arm.bendy.0.0", "l_arm.bendy.0.1", "l_arm.bendy.0.2",
    ), behavior.targets

    paths = service._paths_by_id(cmds, graph.graph_id)
    bendy_joints = tuple(paths[f"l_arm.bendy.0.{index}"] for index in range(3))
    twist_joints = tuple(paths[f"l_arm.twist.0.{index}"] for index in range(3))
    for bendy, twist in zip(bendy_joints, twist_joints):
        parent = (cmds.listRelatives(twist, parent=True, fullPath=True) or [""])[0]
        assert parent == bendy, (parent, bendy)

    in_control = paths["l_arm.bendy.0.in"]
    out_control = paths["l_arm.bendy.0.out"]
    sculpt = MayaBendySculptService(service)
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Bendy Locked Probe")
    cmds.setAttr(f"{in_control}.translateY", lock=True)
    blocked = sculpt.plan_sculpt(
        graph, "l_arm", 0, ((2.8, 2.2, 0.0), (7.2, -1.1, 0.0)), 0.82,
    )
    assert not blocked.can_apply
    assert any(item.code == "locked_control" for item in blocked.blockers), blocked.blockers
    cmds.undoInfo(closeChunk=True)
    cmds.undo()
    preview = sculpt.plan_sculpt(
        graph, "l_arm", 0, ((2.8, 2.2, 0.0), (7.2, -1.1, 0.0)), 0.82,
    )
    assert preview.can_apply, preview.blockers
    assert preview.target_arc.arc_length > preview.target_arc.chord_length
    sculpt_receipt = sculpt.apply_sculpt(graph, preview)
    assert sculpt_receipt.verified
    assert sculpt_receipt.maximum_control_error < 1e-6
    assert sculpt_receipt.maximum_joint_error < 2e-3
    positions = tuple(tuple(cmds.xform(
        item, query=True, worldSpace=True, translation=True,
    )) for item in bendy_joints)
    distances = tuple(math.dist(left, right) for left, right in zip(positions, positions[1:]))
    assert max(abs(value) for point in positions for value in point[1:]) > 0.25, positions
    assert max(distances) - min(distances) < 0.15, distances
    scales = tuple(tuple(cmds.getAttr(f"{item}.scale{axis}") for axis in "XYZ")
                   for item in bendy_joints)
    assert all(min(item) < 1.0 for item in scales), scales
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Bendy Twist Composition Probe")
    cmds.setAttr(f"{paths['l_arm.fk.1']}.rotateX", 90.0)
    twist_values = tuple(abs(float(cmds.getAttr(f"{item}.rotateX"))) for item in twist_joints)
    assert max(twist_values) > 20.0, twist_values
    cmds.undoInfo(closeChunk=True)
    cmds.undo()
    assert sculpt.undo_sculpt(graph, sculpt_receipt)

    stale = sculpt.plan_sculpt(
        graph, "l_arm", 0, ((2.8, 1.8, 0.0), (7.2, 1.8, 0.0)), 0.75,
    )
    cmds.move(0.0, 0.2, 0.0, out_control, relative=True, worldSpace=True)
    try:
        sculpt.apply_sculpt(graph, stale)
        raise AssertionError("Expected stale Bendy plan to be rejected")
    except RuntimeError as exc:
        assert "预览后 Bendy" in str(exc), exc
    cmds.undo()

    motion = next(item for item in service._behavior_aux_nodes(cmds, "l_arm.bendy.0")
                  if cmds.nodeType(item) == "motionPath"
                  and cmds.getAttr(f"{item}.mayacraftBendyTargetIndex") == 1)
    target_rotate = f"{bendy_joints[1]}.rotate"
    cmds.undoInfo(openChunk=True, chunkName="MayaCraft Bendy Drift Probe")
    cmds.disconnectAttr(f"{motion}.rotate", target_rotate)
    cmds.undoInfo(closeChunk=True)
    drift = service.plan(graph)
    change = next(item for item in drift.behavior_changes if item.stable_id == "l_arm.bendy.0")
    assert change.action == "UPDATE", change
    repair = service.apply(graph, drift)
    assert service.plan(graph).is_noop
    assert service.undo(graph, repair)
    assert not cmds.isConnected(f"{motion}.rotate", target_rotate)
    cmds.undo()
    assert service.plan(graph).is_noop
    assert service.undo(graph, build_receipt)
    assert not service.scan(graph.graph_id)
    assert not service.scan_behaviors(graph.graph_id)

    print("MAYACRAFT_BENDY_CURVE_OK", positions, scales, twist_values)
finally:
    maya.standalone.uninitialize()
