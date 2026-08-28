"""Maya 2025 proof for quaternion Twist distribution and profile transactions."""

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
    from MayaCraft.adapters.maya.twist_sculpt import MayaTwistSculptService
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
        golden_biped_graph("twistHeroTest"), MayaSkeletonScanner().capture_selection()
    )
    graph_service = MayaRigGraphService()
    build_receipt = graph_service.apply(graph, graph_service.plan(graph))
    assert build_receipt.verified
    assert graph_service.plan(graph).is_noop
    paths = graph_service._paths_by_id(cmds, graph.graph_id)
    cmds.setAttr(f"{paths['l_arm.fk.1']}.rotateY", 45.0)
    swing_only = tuple(
        abs(float(cmds.getAttr(f"{paths[f'l_arm.twist.0.{index}']}.rotateX")))
        + abs(float(cmds.getAttr(f"{paths[f'l_arm.twist.0.{index}']}.rotateY")))
        + abs(float(cmds.getAttr(f"{paths[f'l_arm.twist.0.{index}']}.rotateZ")))
        for index in range(3)
    )
    assert max(swing_only) < 1e-4, swing_only
    cmds.setAttr(f"{paths['l_arm.fk.1']}.rotateY", 0.0)
    cmds.setAttr(f"{paths['l_arm.fk.1']}.rotateX", 90.0)

    service = MayaTwistSculptService(graph_service)
    angle = service.probe_twist_angle(graph, "l_arm", 0)
    rotations = tuple(
        float(cmds.getAttr(f"{paths[f'l_arm.twist.0.{index}']}.rotateX"))
        for index in range(3)
    )
    assert abs(abs(angle) - 90.0) < 1e-4, angle
    assert all(abs(abs(value) - expected) < 1e-3 for value, expected in zip(rotations, (22.5, 45.0, 67.5))), rotations

    preview = service.plan_profile(graph, "l_arm", 0, -0.65, 0.85, 0.9)
    assert preview.can_apply, preview.blockers
    receipt = service.apply_profile(graph, preview)
    assert receipt.verified and receipt.maximum_weight_error < 1e-8
    shaped_rotations = tuple(
        abs(float(cmds.getAttr(f"{paths[f'l_arm.twist.0.{index}']}.rotateX")))
        for index in range(3)
    )
    assert shaped_rotations[0] > abs(rotations[0]), (rotations, shaped_rotations)
    assert service.undo_profile(graph, receipt)

    nodes = service._slerp_nodes(cmds, "l_arm.twist.0")
    cmds.setAttr(f"{nodes[0]}.inputT", lock=True)
    blocked = service.plan_profile(graph, "l_arm", 0, 0.0, 0.65, 0.8)
    assert not blocked.can_apply
    assert any(item.code == "locked_weight" for item in blocked.blockers), blocked.blockers
    cmds.setAttr(f"{nodes[0]}.inputT", lock=False)

    print("MAYACRAFT_TWIST_SCULPT_OK", round(angle, 6), swing_only, rotations, shaped_rotations)
finally:
    maya.standalone.uninitialize()
