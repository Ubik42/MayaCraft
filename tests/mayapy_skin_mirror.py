"""Maya 2025 transactional validation for Skin Mirror."""

from __future__ import annotations

import pathlib
import sys
import maya.standalone

maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds
    sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
    from MayaCraft.adapters.maya.skin_mirror import MayaSkinMirrorService

    root = cmds.joint(name="root_JNT", position=(0, 0, 0))
    cmds.select(clear=True)
    left = cmds.joint(name="L_arm_JNT", position=(2, 4, 0))
    cmds.select(clear=True)
    right = cmds.joint(name="R_arm_JNT", position=(-2, 4, 0))
    mesh = cmds.polyCreateFacet(
        name="mirrorBody",
        point=((1, 0, 0), (1, 1, 0), (-1, 1, 0), (-1, 0, 0)),
        constructionHistory=False,
    )[0]
    skin = cmds.skinCluster((root, left, right), mesh, toSelectedBones=True, normalizeWeights=1)[0]
    influence_order = cmds.skinCluster(skin, query=True, influence=True)

    def set_row(index, root_w, left_w, right_w):
        values = dict(zip((root, left, right), (root_w, left_w, right_w)))
        cmds.skinPercent(skin, f"{mesh}.vtx[{index}]", transformValue=tuple((item, values[item]) for item in influence_order), normalize=False)

    set_row(0, 0.1, 0.9, 0.0)
    set_row(1, 0.2, 0.7, 0.1)
    set_row(2, 0.7, 0.2, 0.1)
    set_row(3, 0.6, 0.2, 0.2)
    cmds.select(mesh)
    service = MayaSkinMirrorService()
    plan = service.plan_selection()
    assert plan.can_apply, plan.blockers
    assert len(plan.changes) == 2, plan.changes
    receipt = service.apply(plan)
    assert receipt.verified
    rows, paths = service._read_rows(plan.mesh_path, plan.skin_cluster, (2, 3))
    path_to_index = {path.rsplit("|", 1)[-1]: index for index, path in enumerate(paths)}
    assert abs(rows[0][path_to_index["R_arm_JNT"]] - 0.7) < 1e-6, rows[0]
    assert abs(rows[1][path_to_index["R_arm_JNT"]] - 0.9) < 1e-6, rows[1]
    assert service.undo(receipt)
    restored, _paths = service._read_rows(plan.mesh_path, plan.skin_cluster, (2, 3))
    expected_before = {change.target_index: change.before for change in plan.changes}
    assert all(abs(a - b) < 1e-6 for a, b in zip(restored[0], expected_before[2]))
    assert all(abs(a - b) < 1e-6 for a, b in zip(restored[1], expected_before[3]))

    stale = service.plan_selection()
    cmds.skinPercent(skin, f"{mesh}.vtx[3]", transformValue=((root, 1.0), (left, 0.0), (right, 0.0)), normalize=False)
    try:
        service.apply(stale)
        raise AssertionError("Expected stale Skin Mirror preview rejection")
    except RuntimeError as exc:
        assert "预览后蒙皮权重或拓扑已经变化" in str(exc), exc

    cmds.setAttr(left + ".liw", True)
    locked = service.plan_selection()
    assert not locked.can_apply
    assert any("已锁定的影响骨骼" in item for item in locked.blockers), locked.blockers
    print("MAYACRAFT_SKIN_MIRROR_OK", len(plan.changes), len(plan.influence_map.pairs), plan.vertex_count)
finally:
    maya.standalone.uninitialize()
