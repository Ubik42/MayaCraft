"""Mayapy smoke test for the live character scanner."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    package_parent = pathlib.Path(__file__).resolve().parents[2]
    sys.path.insert(0, str(package_parent))
    from MayaCraft.adapters.maya.character_context import MayaCharacterScanner, MayaSelectionWatcher
    from MayaCraft.adapters.maya.character_registration import CharacterRegistrationService
    from MayaCraft.adapters.maya.selection import MayaSelectionService
    from MayaCraft.adapters.maya.character_session import MayaCharacterSessionScanner
    from MayaCraft.adapters.maya.deformation_mri import MayaDeformationRepairService, MayaDeformationScanner

    world = cmds.createNode("transform", name="ASSET_CONTAINER")
    root = cmds.createNode("transform", name="hero:CHARACTER", parent=world)
    hip = cmds.createNode("joint", name="hero:hip_JNT", parent=root)
    spine = cmds.createNode("joint", name="hero:spine_JNT", parent=hip)
    cmds.setAttr(spine + ".translateY", 5)
    mesh = cmds.polyCube(name="hero:body_GEO", constructionHistory=False)[0]
    cmds.parent(mesh, root)
    control = cmds.circle(name="hero:main_CTRL", constructionHistory=False)[0]
    cmds.parent(control, root)
    skin = cmds.skinCluster(hip, spine, mesh, toSelectedBones=True, normalizeWeights=0)[0]
    cmds.setAttr(skin + ".normalizeWeights", 0)
    cmds.skinPercent(
        skin,
        mesh + ".vtx[0]",
        transformValue=((hip, 0.25), (spine, 0.25)),
        normalize=False,
    )
    cmds.select(hip)

    snapshot = MayaCharacterScanner().capture_selection()
    assert snapshot.root == "|ASSET_CONTAINER|hero:CHARACTER", snapshot
    assert snapshot.namespace == "hero", snapshot
    assert snapshot.joint_count == 2, snapshot
    assert snapshot.mesh_count == 1, snapshot
    assert snapshot.control_count == 1, snapshot
    assert snapshot.skin_cluster_count == 1, snapshot
    assert len(snapshot.rig_nodes) == 3, snapshot.rig_nodes
    assert MayaSelectionService().select_node(spine) == cmds.ls(spine, long=True)[0]
    mri = MayaDeformationScanner().scan_character(snapshot, batch_size=3)
    assert len(mri) == 1 and len(mri[0].report.vertices) == 8, mri
    assert mri[0].report.normalization_count >= 1, mri[0].report
    repair = MayaDeformationRepairService()
    repair_plan = repair.plan(mri[0])
    assert repair_plan.can_apply and repair_plan.changes[0].vertex_index == 0, repair_plan
    repair_receipt = repair.apply(repair_plan)
    assert repair_receipt.verified
    repaired = MayaDeformationScanner().scan_character(snapshot)[0]
    assert repaired.report.normalization_count == 0, repaired.report
    assert repair.undo(repair_receipt)
    restored = MayaDeformationScanner().scan_character(snapshot)[0]
    restored_v0 = next(item for item in restored.report.vertices if item.index == 0)
    assert abs(restored_v0.weight_sum - 0.5) < 1e-6, restored_v0
    assert snapshot.stable_id, snapshot
    assert not snapshot.registered, snapshot
    registration = CharacterRegistrationService()
    plan = registration.plan(snapshot)
    assert plan.can_apply and len(plan.changes) == 3, plan
    receipt = registration.apply(plan)
    assert receipt.verified and receipt.applied_count == 3, receipt
    linked = MayaCharacterScanner().capture_selection()
    assert linked.registered and linked.stable_id == snapshot.stable_id, linked
    discovered = MayaCharacterSessionScanner().discover()
    assert len(discovered) == 1 and discovered[0].root == snapshot.root, discovered
    assert cmds.ls(selection=True, long=True)[0] == linked.selected[0].path
    assert registration.plan(linked).is_noop
    cmds.undo()
    assert not registration.verify(snapshot.root, snapshot.stable_id)
    cmds.addAttr(snapshot.root, longName="mayacraftCharacterId", dataType="string")
    cmds.setAttr(snapshot.root + ".mayacraftCharacterId", "FOREIGN-ID", type="string")
    conflict_snapshot = MayaCharacterScanner().capture_selection()
    conflict_plan = registration.plan(conflict_snapshot)
    assert not conflict_plan.can_apply and conflict_plan.blockers, conflict_plan
    watcher = MayaSelectionWatcher(lambda: None)
    watcher.start()
    watcher.start()
    watcher.stop()
    watcher.stop()
    print("MAYACRAFT_SCAN_OK", snapshot)
finally:
    maya.standalone.uninitialize()
