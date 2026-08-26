"""Offline tests that do not require an Autodesk Maya installation."""

from __future__ import annotations

import math
import json
import hashlib
import tempfile
import unittest
from pathlib import Path

import MayaCraft
from MayaCraft import launch
from MayaCraft.domain.character import CharacterSnapshot
from MayaCraft.domain.character import RigNode
from MayaCraft.domain.canvas import hit_test, project_rig_nodes
from MayaCraft.domain.change import AttributeChange, CharacterRegistrationPlan
from MayaCraft.domain.session import CharacterSession
from MayaCraft.domain.rig_health import analyze_rig, focus_rig_nodes
from MayaCraft.domain.deformation import (
    analyze_influence_rows, analyze_weight_rows, merge_influence_reports,
    merge_reports, plan_normalization_repair,
)
from MayaCraft.domain.motion import MotionCapture, MotionSample, analyze_motion, compare_motion, plan_contact_anchor
from MayaCraft.domain.rig_graph import (
    ObservedRigBehavior,
    ObservedRigNode,
    RigGraphSpec,
    RigModuleSpec,
    compile_incremental_rig,
    compute_pole_vector_position,
    bind_graph_to_skeleton,
    golden_biped_graph,
    module_build_order,
    validate_rig_graph,
)
from MayaCraft.domain.skeleton import JointObservation, SemanticJoint, SkeletonAnalysis, analyze_skeleton
from MayaCraft.domain.skin_mirror import (
    InfluenceObservation, SkinVertexObservation, build_influence_mirror_map, plan_skin_mirror,
)
from MayaCraft.domain.deformation_space import hit_test_spatial, project_deformation_field, vertices_in_brush
from MayaCraft.domain.pose_clip import (
    ClipAsset, PoseAsset, PoseFrame, PoseNode, blend_pose_frames,
    clip_asset_from_dict, clip_asset_to_dict, compare_pose_frames,
    pose_asset_from_dict, pose_asset_to_dict, validate_clip,
)
from MayaCraft.domain.retarget import (
    RetargetAxisTemplate, RetargetJointMapping, RetargetProfile, build_retarget_profile,
    plan_retarget_layer, preview_retarget_clip, preview_retarget_pose,
    retarget_axis_templates, validate_retarget_result, with_retarget_axis_template,
)
from MayaCraft.domain.ik import (
    ContactIKSettings, plan_contact_ik_layer, preview_retarget_contact_ik, solve_fabrik,
)
from MayaCraft.domain.clip_package import (
    ClipPackage, clip_package_from_dict, clip_package_to_dict,
    remap_clip_package_paths,
)
from MayaCraft.domain.clip_library import (
    filter_clip_library_entries, preflight_clip_package,
)
from MayaCraft.adapters.storage.clip_package import ClipPackageStore
from MayaCraft.adapters.maya.character_registration import CharacterRegistrationService
from MayaCraft.utils import file_handler, reload_handler


class PackageTests(unittest.TestCase):
    def test_public_entry_point_imports_without_maya(self) -> None:
        self.assertEqual(launch.WORKSPACE_CONTROL, "MayaCraftWorkspaceControl")
        self.assertTrue(callable(launch.run))

    def test_resource_root_is_repository(self) -> None:
        root = Path(file_handler.get_project_root())
        self.assertEqual(root.name, "MayaCraft")
        self.assertTrue((root / "files" / "ma").is_dir())

    def test_resources_are_stable_and_sorted(self) -> None:
        skeletons = file_handler.find_raw_skeletons()
        examples = file_handler.find_examples()
        self.assertEqual(skeletons, sorted(skeletons, key=str.casefold))
        self.assertEqual(examples, sorted(examples, key=str.casefold))
        self.assertIn("UE5", skeletons)
        self.assertIn("blaze", examples)

    def test_resource_paths_reject_escape(self) -> None:
        with self.assertRaises(ValueError):
            file_handler.find_raw_skeletons("../outside")
        with self.assertRaises(ValueError):
            file_handler.get_example_path("../outside")

    def test_reload_discovery_uses_package_namespace(self) -> None:
        names = reload_handler.loaded_module_names("MayaCraft")
        self.assertIn("MayaCraft", names)
        self.assertNotIn("core", names)

    def test_version_is_exposed(self) -> None:
        self.assertRegex(MayaCraft.__version__, r"^\d+\.\d+\.\d+")

    def test_empty_character_snapshot_has_actionable_state(self) -> None:
        snapshot = CharacterSnapshot.empty()
        self.assertTrue(snapshot.is_empty)
        self.assertEqual(snapshot.state_label, "等待角色信号")
        self.assertIn("选择", snapshot.message)

    def test_character_state_thresholds_are_stable(self) -> None:
        partial = CharacterSnapshot(root="|hero", score=20)
        found = CharacterSnapshot(root="|hero", score=60)
        online = CharacterSnapshot(root="|hero", score=90)
        linked = CharacterSnapshot(root="|hero", score=90, registered=True)
        self.assertEqual(partial.state_label, "部分角色信号")
        self.assertEqual(found.state_label, "已发现角色")
        self.assertEqual(online.state_label, "绑定在线")
        self.assertEqual(linked.state_label, "角色已关联")

    def test_registration_plan_requires_changes_and_no_blockers(self) -> None:
        change = AttributeChange("id", "Stable ID", None, "ABC", "string")
        ready = CharacterRegistrationPlan("|hero", "ABC", changes=(change,))
        blocked = CharacterRegistrationPlan("|hero", "ABC", changes=(change,), blockers=("read only",))
        noop = CharacterRegistrationPlan("|hero", "ABC")
        self.assertTrue(ready.can_apply)
        self.assertFalse(blocked.can_apply)
        self.assertFalse(noop.can_apply)
        self.assertTrue(noop.is_noop)

    def test_referenced_character_registration_is_blocked_without_maya_import(self) -> None:
        snapshot = CharacterSnapshot(root="|hero", stable_id="ABC", referenced=True)
        plan = CharacterRegistrationService().plan(snapshot)
        self.assertFalse(plan.can_apply)
        self.assertIn("引用角色", plan.blockers[0])

    def test_canvas_projection_and_nearest_hit_are_host_independent(self) -> None:
        nodes = (
            RigNode("root", "|root", "joint", position=(0.0, 0.0, 0.0)),
            RigNode("L_hand", "|root|L_hand", "joint", parent_path="|root", position=(-5.0, 10.0, 0.0), side="left"),
            RigNode("R_hand", "|root|R_hand", "joint", parent_path="|root", position=(5.0, 10.0, 0.0), side="right"),
        )
        projected = project_rig_nodes(nodes, center=(200.0, 200.0), extent=(240.0, 300.0))
        self.assertEqual(len(projected), 3)
        left = next(node for node in projected if node.name == "L_hand")
        right = next(node for node in projected if node.name == "R_hand")
        self.assertLess(left.x, right.x)
        self.assertEqual(hit_test(projected, (left.x + 1, left.y + 1)).path, left.path)
        self.assertIsNone(hit_test(projected, (-1000.0, -1000.0)))

    def test_character_session_reconciles_discovered_active_and_pinned(self) -> None:
        linked = CharacterSnapshot(stable_id="LINKED", display_name="Linked", root="|linked", registered=True)
        transient = CharacterSnapshot(stable_id="TEMP", display_name="Temp", root="|temp")
        session = CharacterSession().reconcile((linked,), transient)
        self.assertEqual(session.active_id, "TEMP")
        self.assertEqual({item.stable_id for item in session.characters}, {"LINKED", "TEMP"})
        session = session.pin("TEMP").reconcile((linked,), CharacterSnapshot.empty())
        self.assertEqual({item.stable_id for item in session.characters}, {"LINKED", "TEMP"})
        self.assertEqual(session.root_for("LINKED"), "|linked")

    def test_unpinned_transient_character_leaves_session(self) -> None:
        transient = CharacterSnapshot(stable_id="TEMP", display_name="Temp", root="|temp")
        session = CharacterSession().reconcile((), transient)
        self.assertEqual(len(session.characters), 1)
        self.assertFalse(session.reconcile((), CharacterSnapshot.empty()).characters)

    def test_rig_health_detects_side_imbalance_and_focus_preserves_ancestors(self) -> None:
        nodes = (
            RigNode("root_JNT", "|root", "joint"),
            RigNode("spine_JNT", "|root|spine", "joint", parent_path="|root"),
            RigNode("L_shoulder_JNT", "|root|spine|L_shoulder", "joint", parent_path="|root|spine", side="left"),
            RigNode("L_wrist_JNT", "|root|spine|L_shoulder|L_wrist", "joint", parent_path="|root|spine|L_shoulder", side="left"),
        )
        report = analyze_rig(nodes)
        arm = report.module("arm")
        self.assertEqual(arm.state, "risk")
        self.assertIn("L2/R0", arm.findings[0])
        focused = focus_rig_nodes(nodes, report, "arm")
        self.assertEqual({node.path for node in focused}, {node.path for node in nodes})

    def test_balanced_rig_module_is_healthy(self) -> None:
        nodes = (
            RigNode("L_knee_JNT", "|L_knee", "joint", side="left"),
            RigNode("R_knee_JNT", "|R_knee", "joint", side="right"),
        )
        report = analyze_rig(nodes)
        self.assertEqual(report.module("leg").score, 100)
        self.assertEqual(report.issue_count, 0)

    def test_deformation_mri_scores_normalization_influences_and_fragments(self) -> None:
        report = analyze_weight_rows((
            (1.0, 0.0, 0.0, 0.0, 0.0),
            (0.5, 0.3, 0.1, 0.05, 0.05),
            (0.7, 0.2, 0.009, 0.0, 0.0),
            (0.0, 0.0, 0.0, 0.0, 0.0),
        ))
        self.assertEqual(report.unbound_count, 1)
        self.assertEqual(report.excess_influence_count, 1)
        self.assertEqual(report.fragment_count, 1)
        self.assertGreaterEqual(report.hotspot_count, 2)
        self.assertEqual(report.hottest[0].index, 3)

    def test_deformation_mri_batch_merge_preserves_vertex_indices(self) -> None:
        first = analyze_weight_rows(((1.0, 0.0),), start_index=0)
        second = analyze_weight_rows(((0.5, 0.5),), start_index=1)
        merged = merge_reports((first, second))
        self.assertEqual(tuple(item.index for item in merged.vertices), (0, 1))
        self.assertEqual(merged.score, 100)

    def test_normalization_repair_plan_is_exact_and_skips_unbound_vertices(self) -> None:
        plan = plan_normalization_repair(
            "|mesh|shape",
            "skinCluster1",
            ("|j1", "|j2"),
            ((3, (0.2, 0.3)), (4, (0.0, 0.0))),
        )
        self.assertTrue(plan.can_apply)
        self.assertEqual(len(plan.changes), 1)
        self.assertAlmostEqual(sum(plan.changes[0].after), 1.0)
        self.assertEqual(plan.changes[0].before, (0.2, 0.3))

    def test_normalization_repair_safety_limit_blocks_large_preview(self) -> None:
        plan = plan_normalization_repair(
            "|mesh|shape",
            "skinCluster1",
            ("|j1",),
            ((index, (0.5,)) for index in range(3)),
            maximum_changes=2,
        )
        self.assertFalse(plan.can_apply)
        self.assertIn("安全上限", plan.blockers[0])

    def test_motion_analysis_supports_non_uniform_time_and_arc_length(self) -> None:
        samples = (
            MotionSample(1.0, 0.0, (0.0, 0.0, 0.0)),
            MotionSample(2.0, 0.25, (0.5, 0.0, 0.0)),
            MotionSample(4.0, 1.0, (2.0, 0.0, 0.0)),
        )
        analysis = analyze_motion(samples)
        self.assertAlmostEqual(analysis.total_arc_length, 2.0)
        for signal in analysis.signals:
            self.assertAlmostEqual(signal.speed, 2.0)
        self.assertAlmostEqual(analysis.maximum_acceleration, 0.0)

    def test_motion_contact_intervals_have_anchor_and_confidence(self) -> None:
        positions = (
            (0.0, 0.0, 0.0),
            (0.0, 0.0, 0.0),
            (0.0, 0.0, 0.0),
            (0.0, 0.0, 0.0),
            (2.0, 2.0, 0.0),
            (4.0, 2.0, 0.0),
        )
        samples = tuple(MotionSample(index, float(index), position) for index, position in enumerate(positions))
        analysis = analyze_motion(
            samples,
            contact_speed_threshold=0.25,
            contact_height_threshold=0.1,
            minimum_contact_samples=3,
        )
        self.assertEqual(len(analysis.contacts), 1)
        contact = analysis.contacts[0]
        self.assertEqual((contact.start_frame, contact.end_frame), (0, 2))
        self.assertEqual(contact.anchor_position, (0.0, 0.0, 0.0))
        self.assertGreater(contact.confidence, 0.8)

    def test_quaternion_sign_flip_is_continuous_but_real_jump_is_reported(self) -> None:
        samples = (
            MotionSample(0, 0.0, (0.0, 0.0, 0.0), (0.0, 0.0, 0.0, 1.0)),
            MotionSample(1, 1.0, (0.0, 0.0, 0.0), (0.0, 0.0, 0.0, -1.0)),
            MotionSample(2, 2.0, (0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0)),
        )
        analysis = analyze_motion(samples, rotation_jump_degrees=90.0)
        self.assertFalse(analysis.signals[1].rotation_jump)
        self.assertTrue(analysis.signals[2].rotation_jump)
        self.assertEqual(analysis.rotation_jump_count, 1)

    def test_motion_rejects_duplicate_times(self) -> None:
        with self.assertRaises(ValueError):
            analyze_motion((
                MotionSample(1, 0.0, (0.0, 0.0, 0.0)),
                MotionSample(2, 0.0, (1.0, 0.0, 0.0)),
            ))

    def test_motion_comparison_quantifies_error_and_contact_preservation(self) -> None:
        baseline_samples = tuple(
            MotionSample(index, float(index), (0.0, 0.0, 0.0))
            for index in range(5)
        )
        candidate_samples = tuple(
            MotionSample(index, float(index), (0.0 if index < 3 else 1.0, 0.0, 0.0))
            for index in range(5)
        )
        baseline = analyze_motion(
            baseline_samples,
            contact_speed_threshold=0.25,
            minimum_contact_samples=3,
        )
        candidate = analyze_motion(candidate_samples)
        comparison = compare_motion(baseline, candidate, contact_position_tolerance=0.25)
        self.assertAlmostEqual(comparison.maximum_position_error, 1.0)
        self.assertGreater(comparison.rms_velocity_error, 0.0)
        self.assertAlmostEqual(comparison.contact_preservation, 3.0 / 5.0)
        self.assertFalse(comparison.signals[-1].contact_preserved)

    def test_motion_comparison_rejects_mismatched_frames(self) -> None:
        first = analyze_motion((
            MotionSample(1, 0.0, (0.0, 0.0, 0.0)),
            MotionSample(2, 1.0, (0.0, 0.0, 0.0)),
        ))
        second = analyze_motion((
            MotionSample(1, 0.0, (0.0, 0.0, 0.0)),
            MotionSample(3, 1.0, (0.0, 0.0, 0.0)),
        ))
        with self.assertRaises(ValueError):
            compare_motion(first, second)

    def test_contact_anchor_plan_preserves_contact_with_temporal_falloff(self) -> None:
        baseline_samples = tuple(
            MotionSample(index, float(index), (0.0, 0.0 if 2 <= index <= 4 else 2.0, 0.0))
            for index in range(7)
        )
        candidate_samples = tuple(
            MotionSample(sample.frame, sample.time_seconds, (sample.position[0] + 1.0, sample.position[1], 0.0))
            for sample in baseline_samples
        )
        baseline = MotionCapture("|hand_CTRL", baseline_samples, analyze_motion(baseline_samples), 1.0)
        candidate = MotionCapture("|hand_CTRL", candidate_samples, analyze_motion(candidate_samples), 1.0)
        plan = plan_contact_anchor(baseline, candidate, 0, blend_samples=2)
        self.assertTrue(plan.can_apply)
        self.assertEqual(plan.layer_name, "MayaCraft_Anchor_hand_CTRL")
        contact_changes = [
            change for change in plan.corrections
            if plan.contact_start_frame <= change.frame <= plan.contact_end_frame
        ]
        self.assertTrue(contact_changes)
        self.assertTrue(all(change.influence == 1.0 for change in contact_changes))
        self.assertTrue(any(0.0 < change.influence < 1.0 for change in plan.corrections))

    def test_contact_anchor_plan_blocks_different_nodes(self) -> None:
        samples = tuple(MotionSample(index, float(index), (0.0, 0.0, 0.0)) for index in range(4))
        analysis = analyze_motion(samples, minimum_contact_samples=1)
        baseline = MotionCapture("|left", samples, analysis, 1.0)
        candidate = MotionCapture("|right", samples, analysis, 1.0)
        plan = plan_contact_anchor(baseline, candidate, 0)
        self.assertFalse(plan.can_apply)
        self.assertIn("同一个 Maya 节点", plan.blockers[0])

    def test_golden_biped_rig_graph_is_versioned_connected_and_ordered(self) -> None:
        graph = golden_biped_graph()
        self.assertEqual(graph.schema_version, 1)
        self.assertFalse(validate_rig_graph(graph))
        order = module_build_order(graph)
        self.assertLess(order.index("root"), order.index("spine"))
        self.assertLess(order.index("spine"), order.index("l_arm"))
        self.assertEqual(len(graph.modules), 7)
        self.assertEqual(len(graph.nodes), 73)
        self.assertEqual(len(graph.behaviors), 34)
        behavior_types = {item.behavior_type for item in graph.behaviors}
        self.assertEqual(behavior_types, {"matrix_drive", "matrix_blend", "rp_ik", "space_switch"})

    def test_rig_graph_empty_scene_compiles_to_deterministic_creates(self) -> None:
        graph = golden_biped_graph()
        plan = compile_incremental_rig(graph, ())
        self.assertTrue(plan.can_apply)
        self.assertEqual(len(plan.changes), len(graph.nodes))
        self.assertEqual(len(plan.behavior_changes), len(graph.behaviors))
        self.assertTrue(all(change.action == "CREATE" for change in plan.changes))
        self.assertTrue(all(change.action == "CREATE" for change in plan.behavior_changes))
        self.assertEqual(plan.changes[0].stable_id, "rig.root")

    def test_rig_graph_matching_scene_is_noop(self) -> None:
        graph = golden_biped_graph()
        observed = tuple(
            ObservedRigNode(
                node.stable_id,
                node.maya_name,
                node.node_type,
                node.owner_module,
                node.layer,
                node.parent_id,
                node.signature,
            )
            for node in graph.nodes
        )
        observed_behaviors = tuple(
            ObservedRigBehavior(
                item.stable_id,
                item.behavior_type,
                item.owner_module,
                item.sources,
                item.targets,
                item.signature,
            )
            for item in graph.behaviors
        )
        plan = compile_incremental_rig(graph, observed, observed_behaviors)
        self.assertTrue(plan.is_noop)
        self.assertFalse(plan.can_apply)
        self.assertTrue(all(change.action == "PRESERVE" for change in plan.changes))
        self.assertTrue(all(change.action == "PRESERVE" for change in plan.behavior_changes))

    def test_rig_graph_diff_classifies_rebuild_reparent_update_and_remove(self) -> None:
        graph = golden_biped_graph()
        desired = {node.stable_id: node for node in graph.nodes}
        observed = (
            ObservedRigNode("rig.root", "MC_RIG", "joint", "root", "meta"),
            ObservedRigNode("spine.ctrl", desired["spine.ctrl"].maya_name, "transform", "spine", "control", "rig.root", desired["spine.ctrl"].signature),
            ObservedRigNode("head.ctrl", desired["head.ctrl"].maya_name, "transform", "head", "control", "spine.ctrl", (("controlShape", "circle"),)),
            ObservedRigNode("stale.node", "old_CTRL", "transform", "spine", "control"),
        )
        plan = compile_incremental_rig(graph, observed)
        actions = {change.stable_id: change.action for change in plan.changes}
        self.assertEqual(actions["rig.root"], "REBUILD")
        self.assertEqual(actions["spine.ctrl"], "REPARENT")
        self.assertEqual(actions["head.ctrl"], "UPDATE")
        self.assertEqual(actions["stale.node"], "REMOVE")
        self.assertGreaterEqual(plan.destructive_count, 2)

    def test_rig_graph_behavior_drift_is_a_physical_update(self) -> None:
        graph = golden_biped_graph()
        target = graph.behaviors[0]
        observed = ObservedRigBehavior(
            target.stable_id,
            target.behavior_type,
            target.owner_module,
            target.sources,
            (),
            (("sources", "|".join(target.sources)), ("targets", "")),
        )
        plan = compile_incremental_rig(graph, (), (observed,))
        change = next(item for item in plan.behavior_changes if item.stable_id == target.stable_id)
        self.assertEqual(change.action, "UPDATE")
        self.assertEqual(change.entity_kind, "behavior")

    def test_pole_vector_position_handles_bent_and_collinear_chains(self) -> None:
        bent = compute_pole_vector_position((0, 0, 0), (1, 1, 0), (2, 0, 0))
        self.assertGreater(bent[1], 1.0)
        self.assertAlmostEqual(bent[0], 1.0)
        collinear = compute_pole_vector_position((0, 0, 0), (1, 0, 0), (2, 0, 0))
        self.assertGreater(abs(collinear[2]), 1.0)
        with self.assertRaises(ValueError):
            compute_pole_vector_position((0, 0, 0), (0, 0, 0), (0, 0, 0))

    def test_rig_graph_cycle_blocks_incremental_compile(self) -> None:
        first = RigModuleSpec("first", "test", "First", depends_on=("second",))
        second = RigModuleSpec("second", "test", "Second", depends_on=("first",))
        graph = RigGraphSpec("cycle", "Cycle", (first, second))
        plan = compile_incremental_rig(graph, ())
        self.assertFalse(plan.can_apply)
        self.assertTrue(any(issue.code == "module_cycle" for issue in plan.blockers))

    def test_skeleton_semantics_resolve_golden_biped_with_symmetry(self) -> None:
        joints = (
            JointObservation("|root", "root_JNT", position=(0, 0, 0)),
            JointObservation("|root|pelvis", "pelvis_JNT", "|root", (0, 10, 0)),
            JointObservation("|root|pelvis|spine", "spine_JNT", "|root|pelvis", (0, 13, 0)),
            JointObservation("|root|pelvis|spine|chest", "chest_JNT", "|root|pelvis|spine", (0, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|neck", "neck_JNT", "|root|pelvis|spine|chest", (0, 20, 0)),
            JointObservation("|root|pelvis|spine|chest|neck|head", "head_JNT", "|root|pelvis|spine|chest|neck", (0, 23, 0)),
            JointObservation("|root|pelvis|spine|chest|L_arm", "L_upperArm_JNT", "|root|pelvis|spine|chest", (4, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|L_arm|L_forearm", "L_forearm_JNT", "|root|pelvis|spine|chest|L_arm", (8, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|L_arm|L_forearm|L_hand", "L_hand_JNT", "|root|pelvis|spine|chest|L_arm|L_forearm", (11, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|R_arm", "R_upperArm_JNT", "|root|pelvis|spine|chest", (-4, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|R_arm|R_forearm", "R_forearm_JNT", "|root|pelvis|spine|chest|R_arm", (-8, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|R_arm|R_forearm|R_hand", "R_hand_JNT", "|root|pelvis|spine|chest|R_arm|R_forearm", (-11, 17, 0)),
            JointObservation("|root|pelvis|L_thigh", "L_thigh_JNT", "|root|pelvis", (3, 9, 0)),
            JointObservation("|root|pelvis|L_thigh|L_calf", "L_calf_JNT", "|root|pelvis|L_thigh", (3, 5, 0)),
            JointObservation("|root|pelvis|L_thigh|L_calf|L_foot", "L_foot_JNT", "|root|pelvis|L_thigh|L_calf", (3, 1, 1)),
            JointObservation("|root|pelvis|R_thigh", "R_thigh_JNT", "|root|pelvis", (-3, 9, 0)),
            JointObservation("|root|pelvis|R_thigh|R_calf", "R_calf_JNT", "|root|pelvis|R_thigh", (-3, 5, 0)),
            JointObservation("|root|pelvis|R_thigh|R_calf|R_foot", "R_foot_JNT", "|root|pelvis|R_thigh|R_calf", (-3, 1, 1)),
        )
        result = analyze_skeleton(joints)
        self.assertTrue(result.is_usable)
        self.assertEqual(result.semantic("left_upper_arm").path, "|root|pelvis|spine|chest|L_arm")
        self.assertEqual(result.semantic("left_lower_arm").path, "|root|pelvis|spine|chest|L_arm|L_forearm")
        self.assertEqual(result.semantic("left_hand").path, "|root|pelvis|spine|chest|L_arm|L_forearm|L_hand")
        self.assertEqual(result.semantic("right_lower_leg").path, "|root|pelvis|R_thigh|R_calf")
        self.assertEqual(result.symmetry_score, 100)
        self.assertGreater(result.confidence, 0.65)

    def test_skeleton_semantics_block_multiple_roots(self) -> None:
        result = analyze_skeleton((
            JointObservation("|one", "root_JNT"),
            JointObservation("|two", "other_root_JNT"),
        ))
        self.assertFalse(result.is_usable)
        self.assertTrue(any(issue.code == "multiple_roots" for issue in result.issues))

    def test_semantic_skeleton_binds_control_transforms_into_graph_signature(self) -> None:
        joints = (
            JointObservation("|root", "root_JNT", position=(0, 0, 0)),
            JointObservation("|root|pelvis", "pelvis_JNT", "|root", (0, 10, 0)),
            JointObservation("|root|pelvis|spine", "spine_JNT", "|root|pelvis", (0, 13, 0)),
            JointObservation("|root|pelvis|spine|chest", "chest_JNT", "|root|pelvis|spine", (0, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|neck", "neck_JNT", "|root|pelvis|spine|chest", (0, 20, 0)),
            JointObservation("|root|pelvis|spine|chest|neck|head", "head_JNT", "|root|pelvis|spine|chest|neck", (0, 23, 0)),
            JointObservation("|root|pelvis|spine|chest|L_arm", "L_upperArm_JNT", "|root|pelvis|spine|chest", (4, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|L_arm|L_hand", "L_hand_JNT", "|root|pelvis|spine|chest|L_arm", (11, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|R_arm", "R_upperArm_JNT", "|root|pelvis|spine|chest", (-4, 17, 0)),
            JointObservation("|root|pelvis|spine|chest|R_arm|R_hand", "R_hand_JNT", "|root|pelvis|spine|chest|R_arm", (-11, 17, 0)),
            JointObservation("|root|pelvis|L_thigh", "L_thigh_JNT", "|root|pelvis", (3, 9, 0)),
            JointObservation("|root|pelvis|L_thigh|L_foot", "L_foot_JNT", "|root|pelvis|L_thigh", (3, 1, 1)),
            JointObservation("|root|pelvis|R_thigh", "R_thigh_JNT", "|root|pelvis", (-3, 9, 0)),
            JointObservation("|root|pelvis|R_thigh|R_foot", "R_foot_JNT", "|root|pelvis|R_thigh", (-3, 1, 1)),
        )
        analysis = analyze_skeleton(joints)
        graph = bind_graph_to_skeleton(golden_biped_graph(), analysis)
        hand = next(node for node in graph.nodes if node.stable_id == "l_arm.fk.2")
        self.assertEqual(dict(hand.attributes)["semanticRole"], "left_hand")
        self.assertEqual(dict(hand.attributes)["worldPosition"], "11,17,0")
        self.assertIn("sourceJoint", dict(hand.attributes))

    def test_influence_mirror_map_prefers_names_and_preserves_center(self) -> None:
        result = build_influence_mirror_map((
            InfluenceObservation(0, "|root_JNT", (0, 0, 0)),
            InfluenceObservation(1, "|L_upperArm_JNT", (4, 12, 0)),
            InfluenceObservation(2, "|R_upperArm_JNT", (-4, 12, 0)),
            InfluenceObservation(3, "|mysteryA", (8, 7, 1)),
            InfluenceObservation(4, "|mysteryB", (-8.01, 7, 1)),
        ))
        self.assertEqual(result.centers, (0,))
        self.assertEqual(result.mirrored_index(1), 2)
        self.assertEqual(result.mirrored_index(3), 4)
        self.assertEqual(result.mirrored_index(0), 0)
        self.assertEqual(result.pairs[0].method, "name+geometry")
        self.assertGreater(result.confidence, 0.75)

    def test_influence_mirror_map_reports_unpaired_and_duplicate_indices(self) -> None:
        unpaired = build_influence_mirror_map((InfluenceObservation(4, "|L_hand", (2, 2, 0)),))
        self.assertEqual(unpaired.unpaired, (4,))
        self.assertTrue(any(issue.code == "unpaired" for issue in unpaired.issues))
        duplicate = build_influence_mirror_map((
            InfluenceObservation(1, "|a", (1, 0, 0)),
            InfluenceObservation(1, "|b", (-1, 0, 0)),
        ))
        self.assertTrue(any(issue.severity == "blocker" for issue in duplicate.issues))

    def test_skin_mirror_plan_pairs_vertices_and_remaps_influence_vector(self) -> None:
        influences = (
            InfluenceObservation(0, "|root_JNT", (0, 0, 0)),
            InfluenceObservation(1, "|L_arm_JNT", (2, 4, 0)),
            InfluenceObservation(2, "|R_arm_JNT", (-2, 4, 0)),
        )
        vertices = (
            SkinVertexObservation(0, (1, 0, 0), (0.1, 0.9, 0.0)),
            SkinVertexObservation(1, (-1, 0, 0), (0.7, 0.1, 0.2)),
            SkinVertexObservation(2, (1, 1, 0), (0.2, 0.7, 0.1)),
            SkinVertexObservation(3, (-1, 1.0002, 0), (0.2, 0.6, 0.2)),
        )
        plan = plan_skin_mirror("|mesh", "skin1", influences, vertices, position_tolerance=0.001)
        self.assertTrue(plan.can_apply)
        self.assertEqual(tuple(item.target_index for item in plan.changes), (1, 3))
        self.assertEqual(plan.changes[0].after, (0.1, 0.0, 0.9))
        self.assertEqual(plan.changes[1].after, (0.2, 0.1, 0.7))

    def test_skin_mirror_plan_blocks_weighted_unpaired_influence_and_bad_topology(self) -> None:
        influence_block = plan_skin_mirror(
            "|mesh", "skin1",
            (InfluenceObservation(0, "|L_arm_JNT", (2, 4, 0)),),
            (SkinVertexObservation(0, (1, 0, 0), (1.0,)),),
        )
        self.assertFalse(influence_block.can_apply)
        self.assertIn("没有安全镜像配对", influence_block.blockers[0])
        topology_block = plan_skin_mirror(
            "|mesh", "skin1",
            (
                InfluenceObservation(0, "|L_arm_JNT", (2, 4, 0)),
                InfluenceObservation(1, "|R_arm_JNT", (-2, 4, 0)),
            ),
            (
                SkinVertexObservation(0, (1, 0, 0), (1.0, 0.0)),
                SkinVertexObservation(1, (2, 0, 0), (1.0, 0.0)),
                SkinVertexObservation(2, (-1, 0, 0), (0.0, 1.0)),
            ),
        )
        self.assertFalse(topology_block.can_apply)
        self.assertTrue(any("拓扑对称性" in item for item in topology_block.blockers))

    def test_deformation_space_pca_projects_rotated_mesh_and_preserves_topology(self) -> None:
        report = analyze_weight_rows(((1.0, 0.0), (0.5, 0.5), (0.0, 1.0), (0.25, 0.75)))
        positions = ((0, 0, 0), (1, 1, 0), (0, 2, 2), (-1, 1, 2))
        projection = project_deformation_field(positions, report.vertices, ((0, 1, 2), (0, 2, 3)))
        self.assertEqual(len(projection.vertices), 4)
        self.assertEqual(projection.triangles, ((0, 1, 2), (0, 2, 3)))
        self.assertTrue(all(-1.000001 <= item.x <= 1.000001 for item in projection.vertices))
        self.assertTrue(all(-1.000001 <= item.y <= 1.000001 for item in projection.vertices))
        first = projection.vertex(0)
        self.assertEqual(hit_test_spatial(projection, (first.x, first.y)).index, 0)
        self.assertIn(0, vertices_in_brush(projection, (first.x, first.y), radius=0.01))

    def test_deformation_space_decimation_always_keeps_hotspots(self) -> None:
        rows = tuple((0.5, 0.0) if index == 17 else (1.0, 0.0) for index in range(100))
        report = analyze_weight_rows(rows)
        projection = project_deformation_field(
            ((float(index), float(index % 7), 0.0) for index in range(100)),
            report.vertices,
            maximum_vertices=10,
        )
        self.assertLess(len(projection.vertices), 20)
        self.assertIsNotNone(projection.vertex(17))

    def test_deformation_space_large_mesh_sampling_keeps_complete_faces(self) -> None:
        positions = tuple((float(index % 20), float(index // 20), 0.0) for index in range(400))
        report = analyze_weight_rows(tuple((1.0, 0.0) for _index in range(400)))
        triangles = tuple(
            triangle
            for row in range(19)
            for column in range(19)
            for triangle in (
                (row * 20 + column, row * 20 + column + 1, (row + 1) * 20 + column),
                (row * 20 + column + 1, (row + 1) * 20 + column + 1, (row + 1) * 20 + column),
            )
        )
        projection = project_deformation_field(
            positions, report.vertices, triangles, maximum_vertices=90
        )
        self.assertLessEqual(len(projection.vertices), 90)
        self.assertGreater(len(projection.triangles), 10)

    def test_deformation_space_axis_aligned_plane_does_not_collapse(self) -> None:
        positions = tuple(
            (float(column), 0.0, float(row))
            for row in range(5)
            for column in range(7)
        )
        report = analyze_weight_rows(tuple((1.0, 0.0) for _position in positions))
        projection = project_deformation_field(positions, report.vertices)
        x_span = max(item.x for item in projection.vertices) - min(item.x for item in projection.vertices)
        y_span = max(item.y for item in projection.vertices) - min(item.y for item in projection.vertices)
        self.assertGreater(x_span, 1.9)
        self.assertGreater(y_span, 1.9)

    def test_influence_inspector_merges_streamed_batches_and_locked_vertices(self) -> None:
        paths = ("|root|L_arm_JNT", "|root|R_arm_JNT", "|root|spine_JNT")
        first_rows = ((0.8, 0.0, 0.2), (0.4, 0.4, 0.2))
        second_rows = ((0.0, 0.9, 0.1), (0.2, 0.2, 0.6))
        deformation = merge_reports((
            analyze_weight_rows(first_rows, start_index=0),
            analyze_weight_rows(second_rows, start_index=2),
        ))
        inspector = merge_influence_reports(
            (
                analyze_influence_rows(first_rows, paths, locked_indices=(0,), start_index=0),
                analyze_influence_rows(second_rows, paths, locked_indices=(0,), start_index=2),
            ),
            deformation,
            missing_influences=("matrix[7]",),
        )
        self.assertEqual(inspector.locked_vertices, (0, 1, 3))
        self.assertEqual(inspector.influences[0].affected_vertex_count, 3)
        self.assertEqual(inspector.influences[1].dominant_vertex_count, 1)
        self.assertIn(1, inspector.low_dominance_vertices)
        self.assertEqual(inspector.missing_influences, ("matrix[7]",))

    def test_pose_blend_uses_shortest_quaternion_arc_and_world_metrics(self) -> None:
        identity = PoseNode(key="hand", node_path="|rig|hand")
        half_turn = PoseNode(
            key="hand",
            node_path="|rig|hand",
            local_translation=(10.0, 0.0, 0.0),
            local_rotation=(0.0, 0.0, 1.0, 0.0),
            world_translation=(10.0, 0.0, 0.0),
            world_rotation=(0.0, 0.0, -1.0, 0.0),
        )
        start = PoseFrame(1.0, (identity,))
        end = PoseFrame(9.0, (half_turn,))
        middle = blend_pose_frames(start, end, 0.5)
        self.assertAlmostEqual(middle.frame, 5.0)
        self.assertEqual(middle.nodes[0].local_translation, (5.0, 0.0, 0.0))
        self.assertAlmostEqual(abs(middle.nodes[0].local_rotation[2]), 2 ** -0.5, places=6)
        difference = compare_pose_frames(start, end)
        self.assertAlmostEqual(difference.maximum_world_translation, 10.0)
        self.assertAlmostEqual(difference.maximum_world_rotation_degrees, 180.0)

    def test_pose_schema_roundtrip_is_versioned_and_fingerprint_stable(self) -> None:
        asset = PoseAsset(
            label="起跳准备",
            character_id="HERO-A",
            frame=PoseFrame(12.0, (PoseNode(
                key="L_hand_CTRL",
                node_path="|hero|L_hand_CTRL",
                custom_channels=(("fingerCurl", 0.35),),
            ),)),
        )
        restored = pose_asset_from_dict(pose_asset_to_dict(asset))
        self.assertEqual(restored, asset)
        self.assertEqual(restored.fingerprint, asset.fingerprint)
        with self.assertRaisesRegex(ValueError, "schema 版本"):
            pose_asset_from_dict({**pose_asset_to_dict(asset), "version": 99})

    def test_clip_validation_rejects_channel_topology_drift(self) -> None:
        clip = ClipAsset(
            label="步态",
            character_id="HERO-A",
            frames_per_second=24.0,
            frames=(
                PoseFrame(1.0, (PoseNode("root", "|root"), PoseNode("foot", "|root|foot", "root"))),
                PoseFrame(2.0, (PoseNode("root", "|root"),)),
            ),
        )
        self.assertTrue(any("通道拓扑" in issue for issue in validate_clip(clip)))

    def test_clip_schema_roundtrip_and_custom_channel_topology(self) -> None:
        nodes = (
            PoseNode("root", "|root"),
            PoseNode("hand", "|root|hand", "root", custom_channels=(("curl", 0.0),)),
        )
        clip = ClipAsset(
            label="挥手",
            character_id="HERO-A",
            frames_per_second=24.0,
            frames=(PoseFrame(1.0, nodes), PoseFrame(2.0, nodes)),
        )
        restored = clip_asset_from_dict(clip_asset_to_dict(clip))
        self.assertEqual(restored, clip)
        self.assertEqual(restored.fingerprint, clip.fingerprint)
        drift = ClipAsset(
            label=clip.label,
            character_id=clip.character_id,
            frames_per_second=clip.frames_per_second,
            frames=(clip.frames[0], PoseFrame(2.0, (
                PoseNode("root", "|root"),
                PoseNode("hand", "|root|hand", "root", custom_channels=(("spread", 0.0),)),
            ))),
        )
        self.assertTrue(any("通道拓扑" in issue for issue in validate_clip(drift)))

    def test_semantic_retarget_profile_scales_translation_and_transfers_rotation_delta(self) -> None:
        roles = (
            "pelvis", "spine", "chest", "head",
            "left_hand", "right_hand", "left_foot", "right_foot",
        )
        source_joints = tuple(
            JointObservation(f"|source|{role}", role, position=(0.0, float(index), 0.0))
            for index, role in enumerate(roles)
        )
        target_joints = tuple(
            JointObservation(f"|target|{role}", role, position=(0.0, float(index * 2), 0.0))
            for index, role in enumerate(roles)
        )
        source = SkeletonAnalysis(
            root_path="|source",
            joints=source_joints,
            semantics=tuple(SemanticJoint(role, joint.path, "center", 0.9) for role, joint in zip(roles, source_joints)),
            confidence=0.9,
        )
        target = SkeletonAnalysis(
            root_path="|target",
            joints=target_joints,
            semantics=tuple(SemanticJoint(role, joint.path, "center", 0.8) for role, joint in zip(roles, target_joints)),
            confidence=0.8,
        )
        profile = build_retarget_profile(source, target)
        self.assertTrue(profile.can_preview)
        self.assertAlmostEqual(profile.scale_ratio, 2.0)
        source_reference = PoseFrame(0.0, tuple(
            PoseNode(role, joint.path, world_translation=joint.position)
            for role, joint in zip(roles, source_joints)
        ))
        target_reference = PoseFrame(0.0, tuple(
            PoseNode(role, joint.path, world_translation=joint.position)
            for role, joint in zip(roles, target_joints)
        ))
        source_pose_nodes = list(source_reference.nodes)
        source_pose_nodes[0] = PoseNode(
            "pelvis", source_joints[0].path,
            world_translation=(1.0, 0.0, 0.0),
            world_rotation=(0.0, 0.0, 2 ** -0.5, 2 ** -0.5),
        )
        preview = preview_retarget_pose(
            PoseFrame(12.0, tuple(source_pose_nodes)), source_reference, target_reference, profile
        )
        pelvis = next(node for node in preview.frame.nodes if node.node_path == target_joints[0].path)
        self.assertEqual(pelvis.world_translation, (2.0, 0.0, 0.0))
        self.assertAlmostEqual(abs(pelvis.world_rotation[2]), 2 ** -0.5, places=6)
        pelvis_signal = next(item for item in preview.signals if item.semantic_role == "pelvis")
        self.assertAlmostEqual(pelvis_signal.rotation_delta_degrees, 90.0, places=5)

    def test_retarget_clip_preview_and_layer_plan_preserve_bone_translations(self) -> None:
        roles = ("pelvis", "left_hand", "left_foot", "right_foot")
        mappings = tuple(RetargetJointMapping(
            role, f"|source|{role}", f"|target|{role}", 0.9
        ) for role in roles)
        profile = RetargetProfile(
            source_root="|source", target_root="|target", mappings=mappings,
            scale_ratio=2.0, confidence=0.9,
        )
        source_reference = PoseFrame(0.0, tuple(PoseNode(
            role, f"|source|{role}",
            local_translation=(0.0, 0.0 if role == "pelvis" else 1.0, 0.0),
            world_translation=(0.0, 0.0 if role == "pelvis" else 1.0, 0.0),
        ) for role in roles))
        target_reference = PoseFrame(0.0, tuple(PoseNode(
            role, f"|target|{role}",
            local_translation=(0.0, 0.0 if role == "pelvis" else 2.0, 0.0),
            world_translation=(0.0, 0.0 if role == "pelvis" else 2.0, 0.0),
        ) for role in roles))
        source_frames = []
        for frame in range(4):
            nodes = []
            for node in source_reference.nodes:
                if node.key == "pelvis":
                    nodes.append(PoseNode(
                        node.key, node.node_path,
                        local_translation=(float(frame), 0.0, 0.0),
                        world_translation=(float(frame), 0.0, 0.0),
                    ))
                elif node.key == "left_hand":
                    angle = frame * 15.0
                    radians = angle * 3.141592653589793 / 180.0 * 0.5
                    quaternion = (0.0, 0.0, math.sin(radians), math.cos(radians))
                    nodes.append(PoseNode(
                        node.key, node.node_path,
                        local_translation=node.local_translation,
                        local_rotation=quaternion,
                        world_translation=node.world_translation,
                        world_rotation=quaternion,
                    ))
                else:
                    nodes.append(node)
            source_frames.append(PoseFrame(float(frame), tuple(nodes)))
        source_clip = ClipAsset("源动作", "SOURCE", 24.0, tuple(source_frames))
        target_baseline = ClipAsset(
            "目标基线", "TARGET", 24.0,
            tuple(PoseFrame(float(frame), target_reference.nodes) for frame in range(4)),
        )
        preview = preview_retarget_clip(source_clip, source_reference, target_reference, profile)
        self.assertEqual(len(preview.frames), 4)
        self.assertAlmostEqual(preview.maximum_root_motion, 6.0)
        self.assertTrue(preview.contacts)
        self.assertEqual(preview.contact_preservation, 1.0)
        plan = plan_retarget_layer(
            source_clip, source_reference, target_reference, target_baseline,
            profile, "MayaCraft_Retarget_TARGET",
        )
        self.assertTrue(plan.can_apply)
        pelvis_last = next(
            key for key in plan.keys if key.semantic_role == "pelvis" and key.frame == 3.0
        )
        self.assertEqual(pelvis_last.desired_translation, (6.0, 0.0, 0.0))
        foot_keys = tuple(key for key in plan.keys if key.semantic_role.endswith("foot"))
        self.assertFalse(foot_keys)
        hand_frames = tuple(
            key.frame for key in plan.keys if key.semantic_role == "left_hand"
        )
        self.assertEqual(hand_frames, (0.0, 1.0, 2.0, 3.0))

    def test_retarget_layer_calibrates_different_target_joint_axes(self) -> None:
        half = 2 ** -0.5
        source_reference = PoseFrame(0.0, (
            PoseNode("root", "|source|root"),
            PoseNode("hand", "|source|hand", "root"),
        ))
        target_reference = PoseFrame(0.0, (
            PoseNode("root", "|target|root"),
            PoseNode(
                "hand", "|target|hand", "root",
                local_rotation=(0.0, 0.0, 0.0, 1.0),
                world_rotation=(0.0, half, 0.0, half),
            ),
        ))
        source_pose = PoseFrame(1.0, (
            source_reference.nodes[0],
            PoseNode(
                "hand", "|source|hand", "root",
                local_rotation=(0.0, 0.0, half, half),
                world_rotation=(0.0, 0.0, half, half),
            ),
        ))
        source_clip = ClipAsset("轴向测试", "SOURCE", 24.0, (source_pose,))
        target_baseline = ClipAsset(
            "目标基线", "TARGET", 24.0,
            (PoseFrame(1.0, target_reference.nodes),),
        )
        profile = RetargetProfile(
            source_root="|source|root",
            target_root="|target|root",
            mappings=(RetargetJointMapping(
                "left_hand", "|source|hand", "|target|hand", 1.0
            ),),
            confidence=1.0,
        )
        plan = plan_retarget_layer(
            source_clip, source_reference, target_reference, target_baseline,
            profile, "MayaCraft_Retarget_Axis",
        )
        self.assertTrue(plan.can_apply)
        desired = plan.keys[0].desired_rotation
        source_delta = source_pose.nodes[1].local_rotation
        self.assertLess(abs(sum(a * b for a, b in zip(desired, source_delta))), 0.999)
        target_axis = target_reference.nodes[1].world_rotation

        def multiply(left, right):
            ax, ay, az, aw = left
            bx, by, bz, bw = right
            return (
                aw * bx + ax * bw + ay * bz - az * by,
                aw * by - ax * bz + ay * bw + az * bx,
                aw * bz + ax * by - ay * bx + az * bw,
                aw * bw - ax * bx - ay * by - az * bz,
            )

        reconstructed_world = multiply(target_axis, desired)
        expected_world = multiply(source_delta, target_axis)
        self.assertAlmostEqual(abs(sum(a * b for a, b in zip(reconstructed_world, expected_world))), 1.0, places=6)

    def test_retarget_axis_template_transforms_translation_and_rotation_basis(self) -> None:
        half = 2 ** -0.5
        source_reference = PoseFrame(0.0, (
            PoseNode("pelvis", "|source|pelvis"),
        ))
        target_reference = PoseFrame(0.0, (
            PoseNode("pelvis", "|target|pelvis"),
        ))
        source_pose = PoseFrame(1.0, (
            PoseNode(
                "pelvis", "|source|pelvis",
                local_translation=(0.0, 0.0, 1.0),
                local_rotation=(0.0, 0.0, half, half),
                world_translation=(0.0, 0.0, 1.0),
                world_rotation=(0.0, 0.0, half, half),
            ),
        ))
        profile = RetargetProfile(
            source_root="|source|pelvis", target_root="|target|pelvis",
            mappings=(RetargetJointMapping(
                "pelvis", "|source|pelvis", "|target|pelvis", 1.0,
            ),),
            scale_ratio=2.0, confidence=1.0,
        )
        template = next(
            item for item in retarget_axis_templates()
            if item.template_id == "z_forward_to_x_forward"
        )
        profile = with_retarget_axis_template(profile, template)
        preview = preview_retarget_pose(
            source_pose, source_reference, target_reference, profile
        )
        target = preview.frame.nodes[0]
        self.assertAlmostEqual(target.world_translation[0], 2.0, places=6)
        self.assertAlmostEqual(target.world_translation[1], 0.0, places=6)
        self.assertAlmostEqual(target.world_translation[2], 0.0, places=6)
        self.assertAlmostEqual(abs(target.world_rotation[0]), half, places=6)
        self.assertAlmostEqual(abs(target.world_rotation[3]), half, places=6)
        self.assertAlmostEqual(template.angle_degrees, 90.0, places=6)
        invalid = RetargetAxisTemplate(
            "invalid", "无效模板", "+Y", "-Y", "+Z", "+Y",
        )
        with self.assertRaisesRegex(ValueError, "源向前轴与向上轴不能平行"):
            with_retarget_axis_template(profile, invalid)

    def test_retarget_result_validation_quantifies_world_and_contact_error(self) -> None:
        mapping = RetargetJointMapping("left_foot", "|source|foot", "|target|foot", 1.0)
        profile = RetargetProfile(
            source_root="|source", target_root="|target",
            mappings=(mapping,), confidence=1.0,
        )
        source_reference = PoseFrame(0.0, (PoseNode(
            "foot", "|source|foot", world_translation=(0.0, 0.0, 0.0)
        ),))
        target_reference = PoseFrame(0.0, (PoseNode(
            "foot", "|target|foot", world_translation=(0.0, 0.0, 0.0)
        ),))
        source_clip = ClipAsset(
            "接触", "SOURCE", 24.0,
            tuple(PoseFrame(float(frame), source_reference.nodes) for frame in range(3)),
        )
        preview = preview_retarget_clip(source_clip, source_reference, target_reference, profile)
        actual = ClipAsset(
            "结果", "TARGET", 24.0,
            tuple(PoseFrame(float(frame), (PoseNode(
                "foot", "|target|foot", world_translation=(0.2 * frame, 0.0, 0.0)
            ),)) for frame in range(3)),
        )
        validation = validate_retarget_result(actual, preview, profile, contact_tolerance=0.05)
        self.assertAlmostEqual(validation.maximum_position_error, 0.4)
        self.assertEqual(validation.maximum_rotation_error_degrees, 0.0)
        self.assertEqual(validation.contact_preservation, 0.0)

    def test_fabrik_preserves_lengths_uses_pole_and_reports_unreachable_target(self) -> None:
        result = solve_fabrik(
            ((0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (2.0, 0.0, 0.0)),
            (1.2, 0.6, 0.0),
            pole=(0.0, 0.0, 2.0),
        )
        self.assertTrue(result.reached)
        self.assertGreater(result.positions[1][2], 0.0)
        self.assertAlmostEqual(math.dist(result.positions[0], result.positions[1]), 1.0, places=6)
        self.assertAlmostEqual(math.dist(result.positions[1], result.positions[2]), 1.0, places=6)
        unreachable = solve_fabrik(
            ((0.0, 0.0, 0.0), (1.0, 0.0, 0.0), (2.0, 0.0, 0.0)),
            (5.0, 0.0, 0.0),
            pole=(0.0, 1.0, 0.0),
        )
        self.assertFalse(unreachable.reached)
        self.assertTrue(unreachable.stretched)
        self.assertAlmostEqual(unreachable.error, 3.0)

    def test_retarget_contact_ik_solves_failed_actual_foot_contact(self) -> None:
        roles = (
            "left_upper_leg", "left_lower_leg", "left_foot",
            "right_upper_leg", "right_lower_leg", "right_foot",
        )
        profile = RetargetProfile(
            source_root="|source", target_root="|target",
            mappings=tuple(RetargetJointMapping(
                role, f"|source|{role}", f"|target|{role}", 1.0
            ) for role in roles),
            confidence=1.0,
        )
        def nodes(prefix, foot_offset=0.0):
            values = []
            for side_sign, side in ((-1.0, "left"), (1.0, "right")):
                values.extend((
                    PoseNode(f"{side}_upper_leg", f"|{prefix}|{side}_upper_leg", world_translation=(side_sign, 2.0, 0.0)),
                    PoseNode(f"{side}_lower_leg", f"|{prefix}|{side}_lower_leg", world_translation=(side_sign, 1.0, 0.2)),
                    PoseNode(f"{side}_foot", f"|{prefix}|{side}_foot", world_translation=(side_sign + foot_offset, 0.0, 0.0)),
                ))
            return tuple(values)
        source_reference = PoseFrame(0.0, nodes("source"))
        target_reference = PoseFrame(0.0, nodes("target"))
        source_clip = ClipAsset(
            "静止接触", "SOURCE", 24.0,
            tuple(PoseFrame(float(frame), source_reference.nodes) for frame in range(3)),
        )
        preview = preview_retarget_clip(source_clip, source_reference, target_reference, profile)
        self.assertEqual(len(preview.contacts), 2)
        actual_clip = ClipAsset(
            "脚滑结果", "TARGET", 24.0,
            tuple(PoseFrame(float(frame), nodes("target", foot_offset=0.2 * frame)) for frame in range(3)),
        )
        ik_preview = preview_retarget_contact_ik(actual_clip, preview, profile)
        self.assertEqual(len(ik_preview.samples), 6)
        self.assertEqual(ik_preview.unreachable_count, 0)
        self.assertLess(ik_preview.maximum_error, 1e-5)
        self.assertTrue(all(
            math.dist(sample.solved_positions[-1], sample.anchor_position) < 1e-5
            for sample in ik_preview.samples
        ))

    def test_contact_ik_uses_minimum_pelvis_compensation_and_builds_rotation_layer(self) -> None:
        roles = ("pelvis", "left_upper_leg", "left_lower_leg", "left_foot")
        profile = RetargetProfile(
            source_root="|source|pelvis", target_root="|target|pelvis",
            mappings=tuple(RetargetJointMapping(
                role, f"|source|{role}", f"|target|{role}", 1.0
            ) for role in roles),
            confidence=1.0,
        )

        def frame_nodes(prefix, offset=0.0):
            return (
                PoseNode(
                    "pelvis", f"|{prefix}|pelvis",
                    local_translation=(offset, 4.0, 0.0),
                    world_translation=(offset, 4.0, 0.0),
                ),
                PoseNode(
                    "left_upper_leg", f"|{prefix}|left_upper_leg", "pelvis",
                    local_translation=(0.0, 0.0, 0.0),
                    world_translation=(offset, 4.0, 0.0),
                ),
                PoseNode(
                    "left_lower_leg", f"|{prefix}|left_lower_leg", "left_upper_leg",
                    local_translation=(0.0, -2.0, 0.0),
                    world_translation=(offset, 2.0, 0.0),
                ),
                PoseNode(
                    "left_foot", f"|{prefix}|left_foot", "left_lower_leg",
                    local_translation=(0.0, -2.0, 0.0),
                    world_translation=(offset, 0.0, 0.0),
                ),
            )

        source_reference = PoseFrame(0.0, frame_nodes("source"))
        target_reference = PoseFrame(0.0, frame_nodes("target"))
        source_clip = ClipAsset(
            "静止脚底", "SOURCE", 24.0,
            tuple(PoseFrame(float(frame), source_reference.nodes) for frame in range(3)),
        )
        ghost = preview_retarget_clip(
            source_clip, source_reference, target_reference, profile
        )
        actual = ClipAsset(
            "横移目标", "TARGET", 24.0,
            tuple(PoseFrame(float(frame), frame_nodes("target", 2.0)) for frame in range(3)),
        )
        correction = preview_retarget_contact_ik(actual, ghost, profile)
        self.assertEqual(correction.unreachable_count, 0)
        self.assertEqual(correction.solved_count, 3)
        self.assertGreater(correction.maximum_pelvis_offset, 0.4)
        self.assertLess(correction.maximum_pelvis_offset, 0.6)
        self.assertLess(correction.maximum_error, 1e-4)
        self.assertTrue(all(item.world_offset[0] < 0.0 for item in correction.pelvis_compensations))
        plan = plan_contact_ik_layer(
            actual, correction, profile, "MayaCraft_ContactIK_target"
        )
        self.assertTrue(plan.can_apply, plan.blockers)
        self.assertEqual({key.semantic_role for key in plan.keys}, {
            "pelvis", "left_upper_leg", "left_lower_leg", "left_foot",
        })
        self.assertEqual(len(plan.keys), 12)
        self.assertTrue(all(
            key.write_translation == (key.semantic_role == "pelvis") for key in plan.keys
        ))

    def test_clip_package_atomic_roundtrip_fingerprint_migration_and_remap(self) -> None:
        reference = PoseFrame(0.0, (
            PoseNode("root", "|source|root"),
            PoseNode(
                "hand", "|source|hand", "root",
                local_translation=(1.0, 0.0, 0.0),
                world_translation=(1.0, 0.0, 0.0),
            ),
        ))
        animated = PoseFrame(1.0, (
            reference.nodes[0],
            PoseNode(
                "hand", "|source|hand", "root",
                local_translation=(2.0, 0.0, 0.0),
                world_translation=(2.0, 0.0, 0.0),
            ),
        ))
        clip = ClipAsset("挥手", "SOURCE", 24.0, (reference, animated))
        package = ClipPackage(
            clip=clip,
            reference_pose=reference,
            display_name="英雄挥手",
            tags=("上半身", "循环候选"),
            coordinate_forward="+X",
            coordinate_up="+Y",
            metadata=(("作者", "MayaCraft"), ("用途", "重定向回归")),
        )
        payload = clip_package_to_dict(package)
        self.assertEqual(payload["version"], 2)
        self.assertEqual(payload["asset"]["name"], "英雄挥手")
        self.assertEqual(payload["asset"]["coordinate"]["forward"], "+X")
        restored = clip_package_from_dict(payload)
        self.assertEqual(restored.fingerprint, package.fingerprint)
        self.assertEqual(restored.tags, ("上半身", "循环候选"))
        axis_template = next(
            item for item in retarget_axis_templates()
            if item.template_id == "x_forward_to_z_forward"
        )
        preflight = preflight_clip_package(restored, reference, axis_template)
        self.assertTrue(preflight.can_load, preflight.blockers)
        wrong_axis = preflight_clip_package(
            restored, reference, retarget_axis_templates()[0]
        )
        self.assertFalse(wrong_axis.can_load)
        self.assertTrue(any("轴空间" in item for item in wrong_axis.blockers))
        missing_target = PoseFrame(0.0, (reference.nodes[0],))
        missing = preflight_clip_package(restored, missing_target, axis_template)
        self.assertEqual(missing.missing_keys, ("hand",))
        remapped = remap_clip_package_paths(restored, {
            "root": "|targetNS:root_JNT",
            "hand": "|targetNS:root_JNT|targetNS:L_hand_CTRL",
        })
        self.assertEqual(
            remapped.clip.frames[1].nodes[1].node_path,
            "|targetNS:root_JNT|targetNS:L_hand_CTRL",
        )
        with tempfile.TemporaryDirectory() as directory:
            target = Path(directory) / "挥手.mayaclip"
            store = ClipPackageStore()
            receipt = store.write(target, package)
            self.assertTrue(receipt.verified)
            self.assertEqual(store.read(target).fingerprint, package.fingerprint)
            invalid_path = Path(directory) / "损坏资产.mayaclip"
            invalid_path.write_text("{not-json", encoding="utf-8")
            scan = store.scan_directory(directory)
            self.assertEqual(scan.scanned_files, 2)
            self.assertEqual(scan.invalid_files, 1)
            ready = filter_clip_library_entries(
                scan.entries, query="英雄 上半身", include_invalid=False
            )
            self.assertEqual(len(ready), 1)
            self.assertEqual(ready[0].name, "英雄挥手")
            with self.assertRaises(FileExistsError):
                store.write(target, package)
            damaged = json.loads(target.read_text(encoding="utf-8"))
            damaged["clip"]["label"] = "被修改"
            target.write_text(json.dumps(damaged, ensure_ascii=False), encoding="utf-8")
            with self.assertRaisesRegex(ValueError, "fingerprint"):
                store.read(target)

            legacy = Path(directory) / "旧版.json"
            legacy.write_text(
                json.dumps(clip_asset_to_dict(clip), ensure_ascii=False), encoding="utf-8"
            )
            migrated = store.read(legacy)
            self.assertEqual(
                migrated.migrated_from, "mayacraft.clip/v1:first-frame-reference"
            )
            self.assertEqual(migrated.reference_pose, clip.frames[0])

        v1_payload = {
            "schema": "mayacraft.clip.package",
            "version": 1,
            "clip": clip_asset_to_dict(clip),
            "reference_pose": payload["reference_pose"],
            "metadata": {"作者": "旧版工具"},
            "migrated_from": "",
        }
        v1_payload["fingerprint"] = hashlib.sha256(json.dumps(
            v1_payload, ensure_ascii=False, sort_keys=True,
            separators=(",", ":"), allow_nan=False,
        ).encode("utf-8")).hexdigest()
        migrated_v1 = clip_package_from_dict(v1_payload)
        self.assertEqual(migrated_v1.package_version, 2)
        self.assertEqual(migrated_v1.display_name, "挥手")
        self.assertEqual(migrated_v1.migrated_from, "mayacraft.clip.package/v1")
        with self.assertRaisesRegex(ValueError, "不允许读取"):
            clip_package_from_dict(v1_payload, allow_legacy=False)
        damaged_v1 = dict(v1_payload)
        damaged_v1["metadata"] = {"作者": "已篡改"}
        with self.assertRaisesRegex(ValueError, "fingerprint"):
            clip_package_from_dict(damaged_v1)

    def test_contact_ik_ground_normal_anchor_offset_and_smooth_envelope(self) -> None:
        roles = ("root", "pelvis", "left_upper_leg", "left_lower_leg", "left_foot")
        profile = RetargetProfile(
            source_root="|source|root", target_root="|target|root",
            mappings=tuple(RetargetJointMapping(
                role, f"|source|{role}", f"|target|{role}", 1.0
            ) for role in roles),
            confidence=1.0,
        )

        def nodes(prefix, foot_x=0.0, body_x=0.0):
            return (
                PoseNode("root", f"|{prefix}|root", world_translation=(0.0, 0.0, 0.0)),
                PoseNode(
                    "pelvis", f"|{prefix}|pelvis", "root",
                    local_translation=(body_x, 4.0, 0.0),
                    world_translation=(body_x, 4.0, 0.0),
                ),
                PoseNode(
                    "left_upper_leg", f"|{prefix}|left_upper_leg", "pelvis",
                    world_translation=(body_x, 4.0, 0.0),
                ),
                PoseNode(
                    "left_lower_leg", f"|{prefix}|left_lower_leg", "left_upper_leg",
                    local_translation=(0.0, -2.0, 0.0),
                    world_translation=(body_x, 2.0, 0.0),
                ),
                PoseNode(
                    "left_foot", f"|{prefix}|left_foot", "left_lower_leg",
                    local_translation=(foot_x - body_x, -2.0, 0.0),
                    world_translation=(foot_x, 0.0, 0.0),
                ),
            )

        reference_source = PoseFrame(0.0, nodes("source"))
        reference_target = PoseFrame(0.0, nodes("target"))
        foot_motion = (-1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 2.0)
        source_clip = ClipAsset(
            "局部接触", "SOURCE", 24.0,
            tuple(PoseFrame(float(frame), nodes("source", foot_x=value))
                  for frame, value in enumerate(foot_motion)),
        )
        ghost = preview_retarget_clip(
            source_clip, reference_source, reference_target, profile
        )
        self.assertEqual(len(ghost.contacts), 1)
        self.assertEqual((ghost.contacts[0].start_frame, ghost.contacts[0].end_frame), (2.0, 4.0))
        actual = ClipAsset(
            "脚滑", "TARGET", 24.0,
            tuple(PoseFrame(float(frame), nodes("target", foot_x=0.5, body_x=0.5))
                  for frame in range(7)),
        )
        half = 2 ** -0.5
        settings = ContactIKSettings(
            ground_normal=(0.0, half, half),
            fade_frames=2,
            anchor_offsets=(("left", (0.25, 0.0, 0.0)),),
        )
        correction = preview_retarget_contact_ik(actual, ghost, profile, settings=settings)
        self.assertEqual(tuple(sample.frame for sample in correction.samples), (1.0, 2.0, 3.0, 4.0, 5.0))
        self.assertEqual(tuple(round(sample.weight, 3) for sample in correction.samples), (0.5, 1.0, 1.0, 1.0, 0.5))
        self.assertAlmostEqual(correction.maximum_ground_angle_degrees, 45.0, places=4)
        self.assertTrue(all(sample.anchor_position[0] == 0.25 for sample in correction.samples))
        self.assertTrue(all(sample.reached for sample in correction.samples))
        full_root = next(item for item in correction.root_corrections if item.frame == 3.0)
        fade_root = next(item for item in correction.root_corrections if item.frame == 1.0)
        self.assertAlmostEqual(full_root.angle_degrees, 45.0, places=4)
        self.assertAlmostEqual(fade_root.angle_degrees, 22.5, places=4)
        plan = plan_contact_ik_layer(
            actual, correction, profile, "MayaCraft_ContactIK_Ground"
        )
        self.assertTrue(plan.can_apply, plan.blockers)
        self.assertIn("root", {key.semantic_role for key in plan.keys})
        self.assertTrue(any(key.frame == 0.0 and key.semantic_role == "root" for key in plan.keys))
        self.assertTrue(all(
            math.dist(anchor.world_position, sample.target_position) < 1e-8
            for anchor, sample in zip(plan.anchors, correction.samples)
        ))
        with self.assertRaisesRegex(ValueError, "地面法线"):
            preview_retarget_contact_ik(
                actual, ghost, profile,
                settings=ContactIKSettings(ground_normal=(0.0, 0.0, 0.0)),
            )


if __name__ == "__main__":
    unittest.main()
