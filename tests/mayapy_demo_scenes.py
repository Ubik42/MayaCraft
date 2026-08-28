"""Validate every distributable MayaCraft demo scene against its documented intent."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    package = pathlib.Path(__file__).resolve().parents[1]
    sys.path.insert(0, str(package.parent))
    from MayaCraft.adapters.maya.rig_graph import MayaRigGraphService
    from MayaCraft.adapters.maya.rig_switching import MayaRigSwitchService
    from MayaCraft.adapters.maya.skeleton import MayaSkeletonScanner
    from MayaCraft.adapters.maya.twist_sculpt import MayaTwistSculptService
    from MayaCraft.domain.rig_graph import bind_graph_to_skeleton, golden_biped_graph

    def load_graph(filename, graph_id):
        cmds.file(str(package / "demo" / "scenes" / filename), open=True, force=True)
        cmds.select("L_hand_JNT")
        skeleton = MayaSkeletonScanner().capture_selection()
        assert skeleton.is_usable
        graph = bind_graph_to_skeleton(golden_biped_graph(graph_id), skeleton)
        service = MayaRigGraphService()
        assert service.plan(graph).is_noop
        return graph, MayaRigSwitchService(service)

    graph, switch = load_graph("mayacraft_match_success.ma", "demoMatchSuccess")
    match = switch.plan_match(graph, "l_arm", "FK_TO_IK")
    assert match.can_apply and match.frame == 12.0
    receipt = switch.apply_match(graph, match, key=True)
    assert receipt.verified and receipt.maximum_matrix_error < 1e-3
    assert switch.undo_match(graph, receipt)

    graph, switch = load_graph("mayacraft_match_locked.ma", "demoMatchLocked")
    blocked = switch.plan_match(graph, "l_arm", "FK_TO_IK")
    assert not blocked.can_apply
    assert any(item.code == "locked_channel" for item in blocked.blockers)

    graph, switch = load_graph("mayacraft_space_switch.ma", "demoSpaceSwitch")
    space = switch.plan_space(graph, "l_arm", 1, True)
    assert space.can_apply and space.frame == 12.0 and space.guard_frame == 11.0
    space_receipt = switch.apply_space(graph, space, key=True)
    assert space_receipt.verified and space_receipt.maximum_matrix_error < 1e-4
    assert switch.undo_space(graph, space_receipt)

    graph, _switch = load_graph("mayacraft_twist_sculpt.ma", "demoTwistSculpt")
    twist = MayaTwistSculptService()
    angle = twist.probe_twist_angle(graph, "l_arm", 0)
    assert abs(abs(angle) - 90.0) < 1e-4, angle
    profile = twist.plan_profile(graph, "l_arm", 0, -0.65, 0.85, 0.9)
    assert profile.can_apply, profile.blockers
    twist_receipt = twist.apply_profile(graph, profile)
    assert twist_receipt.verified and twist_receipt.maximum_weight_error < 1e-8
    assert twist.undo_profile(graph, twist_receipt)

    cmds.file(str(package / "demo" / "scenes" / "mayacraft_skeleton_blocked.ma"), open=True, force=True)
    cmds.select("spine_JNT")
    incomplete = MayaSkeletonScanner().capture_selection()
    assert incomplete.is_usable  # The hierarchy itself is legal, but not a golden biped.
    try:
        bind_graph_to_skeleton(golden_biped_graph("blockedDemo"), incomplete)
    except ValueError as error:
        assert "缺少必要骨架语义" in str(error)
    else:
        raise AssertionError("残缺骨架不应进入黄金双足构建")

    print("MAYACRAFT_DEMO_SCENES_OK", 5)
finally:
    maya.standalone.uninitialize()
