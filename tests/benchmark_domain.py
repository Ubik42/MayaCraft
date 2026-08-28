"""Repeatable host-independent interaction and MRI throughput benchmark."""

from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path
from time import perf_counter

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))

from MayaCraft.domain.canvas import hit_test, project_rig_nodes
from MayaCraft.domain.character import RigNode
from MayaCraft.domain.deformation import analyze_weight_rows
from MayaCraft.domain.deformation_space import project_deformation_field
from MayaCraft.domain.pose_clip import ClipAsset, PoseFrame, PoseNode
from MayaCraft.domain.ik import (
    ContactIKSettings, plan_contact_ik_layer, preview_retarget_contact_ik,
)
from MayaCraft.domain.clip_package import ClipPackage, clip_package_to_dict
from MayaCraft.domain.clip_library import filter_clip_library_entries
from MayaCraft.adapters.storage.clip_package import ClipPackageStore
from MayaCraft.domain.retarget import (
    RetargetJointMapping, RetargetProfile, plan_retarget_layer, preview_retarget_clip,
    retarget_axis_templates, with_retarget_axis_template,
)
from MayaCraft.domain.rig_graph import (
    ObservedRigBehavior, ObservedRigNode, RigBehaviorSpec, RigGraphSpec,
    RigModuleSpec, RigNodeSpec, compile_incremental_rig,
)
from MayaCraft.domain.rig_switching import (
    RigTransformSample, plan_fk_ik_match, plan_space_switch,
)


nodes = tuple(
    RigNode(
        name=f"joint_{index}",
        path=f"|rig|joint_{index}",
        kind="joint",
        parent_path=f"|rig|joint_{index - 1}" if index else "",
        position=((index % 20) - 10.0, float(index // 20), float(index % 7)),
        side="left" if index % 3 == 0 else "right" if index % 3 == 1 else "center",
    )
    for index in range(280)
)

iterations = 300
started = perf_counter()
for _ in range(iterations):
    projected = project_rig_nodes(nodes, (300.0, 300.0), (500.0, 500.0))
    hit_test(projected, (300.0, 300.0))
canvas_ms = (perf_counter() - started) * 1000.0 / iterations

rows = tuple(
    (0.50, 0.25, 0.15, 0.08, 0.01, 0.005, 0.003, 0.002)
    if index % 97 == 0
    else (0.70, 0.20, 0.10, 0.0, 0.0, 0.0, 0.0, 0.0)
    for index in range(100_000)
)
started = perf_counter()
report = analyze_weight_rows(rows)
mri_ms = (perf_counter() - started) * 1000.0

grid_width = 320
positions = tuple(
    (float(index % grid_width), float(index // grid_width), float((index % 11) * 0.01))
    for index in range(100_000)
)
triangles = tuple(
    triangle
    for row in range(311)
    for column in range(grid_width - 1)
    for triangle in (
        (row * grid_width + column, row * grid_width + column + 1, (row + 1) * grid_width + column),
        (row * grid_width + column + 1, (row + 1) * grid_width + column + 1, (row + 1) * grid_width + column),
    )
)
started = perf_counter()
projection = project_deformation_field(positions, report.vertices, triangles)
projection_ms = (perf_counter() - started) * 1000.0

retarget_roles = (
    "root", "pelvis", "spine", "chest", "neck", "head",
    "left_clavicle", "left_upper_arm", "left_lower_arm", "left_hand",
    "right_clavicle", "right_upper_arm", "right_lower_arm", "right_hand",
    "left_upper_leg", "left_foot", "right_upper_leg", "right_foot",
)
retarget_profile = RetargetProfile(
    source_root="|source", target_root="|target",
    mappings=tuple(RetargetJointMapping(
        role, f"|source|{role}", f"|target|{role}", 0.9
    ) for role in retarget_roles),
    scale_ratio=1.4, confidence=0.9,
)
retarget_profile = with_retarget_axis_template(
    retarget_profile,
    next(item for item in retarget_axis_templates() if item.template_id == "z_forward_to_x_forward"),
)
source_reference = PoseFrame(0.0, tuple(PoseNode(
    role, f"|source|{role}", world_translation=(0.0, float(index), 0.0)
) for index, role in enumerate(retarget_roles)))
target_reference = PoseFrame(0.0, tuple(PoseNode(
    role, f"|target|{role}", world_translation=(0.0, float(index) * 1.4, 0.0)
) for index, role in enumerate(retarget_roles)))
retarget_source_frames = tuple(PoseFrame(float(frame), tuple(
    PoseNode(
        node.key, node.node_path,
        local_translation=((frame * 0.025), 0.0, 0.0) if node.key == "pelvis" else node.local_translation,
        world_translation=((frame * 0.025), node.world_translation[1], 0.0),
    )
    for node in source_reference.nodes
)) for frame in range(120))
retarget_source_clip = ClipAsset("benchmark", "source", 24.0, retarget_source_frames)
retarget_target_clip = ClipAsset(
    "baseline", "target", 24.0,
    tuple(PoseFrame(float(frame), target_reference.nodes) for frame in range(120)),
)
started = perf_counter()
retarget_preview = preview_retarget_clip(
    retarget_source_clip, source_reference, target_reference, retarget_profile
)
retarget_plan = plan_retarget_layer(
    retarget_source_clip, source_reference, target_reference, retarget_target_clip,
    retarget_profile, "MayaCraft_Retarget_Benchmark",
)
retarget_ms = (perf_counter() - started) * 1000.0

contact_roles = (
    "root", "pelvis",
    "left_upper_leg", "left_lower_leg", "left_foot",
    "right_upper_leg", "right_lower_leg", "right_foot",
)
contact_profile = RetargetProfile(
    source_root="|source|root", target_root="|target|root",
    mappings=tuple(RetargetJointMapping(
        role, f"|source|{role}", f"|target|{role}", 1.0
    ) for role in contact_roles),
    confidence=1.0,
)

def contact_nodes(prefix, offset=0.0):
    values = [PoseNode(
        "root", f"|{prefix}|root",
        local_translation=(offset, 0.0, 0.0),
        world_translation=(offset, 0.0, 0.0),
    ), PoseNode(
        "pelvis", f"|{prefix}|pelvis",
        "root",
        local_translation=(0.0, 4.0, 0.0),
        world_translation=(offset, 4.0, 0.0),
    )]
    for side, sign in (("left", -1.0), ("right", 1.0)):
        values.extend((
            PoseNode(
                f"{side}_upper_leg", f"|{prefix}|{side}_upper_leg", "pelvis",
                world_translation=(sign + offset, 4.0, 0.0),
            ),
            PoseNode(
                f"{side}_lower_leg", f"|{prefix}|{side}_lower_leg", f"{side}_upper_leg",
                local_translation=(0.0, -2.0, 0.0),
                world_translation=(sign + offset, 2.0, 0.0),
            ),
            PoseNode(
                f"{side}_foot", f"|{prefix}|{side}_foot", f"{side}_lower_leg",
                local_translation=(0.0, -2.0, 0.0),
                world_translation=(sign + offset, 0.0, 0.0),
            ),
        ))
    return tuple(values)

contact_source_reference = PoseFrame(0.0, contact_nodes("source"))
contact_target_reference = PoseFrame(0.0, contact_nodes("target"))
contact_source_clip = ClipAsset(
    "contact benchmark", "source", 24.0,
    tuple(PoseFrame(float(frame), contact_source_reference.nodes) for frame in range(120)),
)
contact_actual_clip = ClipAsset(
    "contact actual", "target", 24.0,
    tuple(PoseFrame(float(frame), contact_nodes("target", frame * 0.02)) for frame in range(120)),
)
contact_ghost = preview_retarget_clip(
    contact_source_clip, contact_source_reference, contact_target_reference, contact_profile
)
started = perf_counter()
contact_preview = preview_retarget_contact_ik(
    contact_actual_clip, contact_ghost, contact_profile,
    settings=ContactIKSettings(
        ground_normal=(0.0, 0.984807753, 0.173648178),
        fade_frames=2,
        anchor_offsets=(
            ("left", (0.1, 0.0, 0.0)),
            ("right", (-0.1, 0.0, 0.0)),
        ),
    ),
)
contact_plan = plan_contact_ik_layer(
    contact_actual_clip, contact_preview, contact_profile, "MayaCraft_ContactIK_Benchmark"
)
contact_ms = (perf_counter() - started) * 1000.0

library_package = ClipPackage(
    clip=ClipAsset(
        "资产浏览基准", "source", 24.0, contact_source_clip.frames[:2]
    ),
    reference_pose=contact_source_reference,
    display_name="步行动作",
    tags=("双足", "循环"),
)
library_text = json.dumps(
    clip_package_to_dict(library_package), ensure_ascii=False,
    sort_keys=True, allow_nan=False,
)
with tempfile.TemporaryDirectory() as library_directory:
    library_root = Path(library_directory)
    for index in range(120):
        (library_root / f"步行_{index:03d}.mayaclip").write_text(
            library_text, encoding="utf-8"
        )
    (library_root / "损坏资产.mayaclip").write_text("{not-json", encoding="utf-8")
    started = perf_counter()
    library_scan = ClipPackageStore().scan_directory(library_root)
    library_filtered = filter_clip_library_entries(
        library_scan.entries, query="步行 双足", include_invalid=False
    )
    library_ms = (perf_counter() - started) * 1000.0

rig_modules = []
for index in range(240):
    module_id = f"module_{index:03d}"
    control_id = f"{module_id}.control"
    joint_id = f"{module_id}.joint"
    rig_modules.append(RigModuleSpec(
        module_id=module_id,
        module_type="fk_chain",
        display_name=f"测试链 {index}",
        depends_on=(f"module_{index - 1:03d}",) if index else (),
        nodes=(
            RigNodeSpec(control_id, f"CTRL_{index:03d}", "transform", module_id, "control"),
            RigNodeSpec(joint_id, f"DRV_{index:03d}_JNT", "joint", module_id, "deform"),
        ),
        behaviors=(RigBehaviorSpec(
            f"{module_id}.drive", "matrix_drive", module_id,
            (control_id,), (joint_id,),
        ),),
    ))
rig_scale_graph = RigGraphSpec("scaleBenchmark", "规模基准", tuple(rig_modules))
rig_observed_nodes = tuple(ObservedRigNode(
    item.stable_id, item.maya_name, item.node_type, item.owner_module,
    item.layer, item.parent_id, item.signature,
) for item in rig_scale_graph.nodes)
rig_observed_behaviors = tuple(ObservedRigBehavior(
    item.stable_id, item.behavior_type, item.owner_module,
    item.sources, item.targets, item.signature,
) for item in rig_scale_graph.behaviors)
started = perf_counter()
rig_create_plan = compile_incremental_rig(rig_scale_graph, ())
rig_noop_plan = compile_incremental_rig(
    rig_scale_graph, rig_observed_nodes, rig_observed_behaviors,
)
rig_graph_ms = (perf_counter() - started) * 1000.0

def switch_matrix(x, y, z):
    return (
        1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        float(x), float(y), float(z), 1.0,
    )

switch_results = (
    RigTransformSample("result.0", switch_matrix(0.0, 10.0, 0.0)),
    RigTransformSample("result.1", switch_matrix(4.0, 8.0, 1.0)),
    RigTransformSample("result.2", switch_matrix(8.0, 5.0, 0.0)),
)
switch_fk = tuple(
    RigTransformSample(f"fk.{index}", sample.world_matrix)
    for index, sample in enumerate(switch_results)
)
switch_ik = RigTransformSample("ik", switch_matrix(8.0, 5.0, 0.0))
switch_pole = RigTransformSample("pole", switch_matrix(4.0, 8.0, 5.0))
switch_iterations = 1000
started = perf_counter()
for index in range(switch_iterations):
    match_plan = plan_fk_ik_match(
        "benchmark", "arm.L", "FK_TO_IK", float(index), switch_results,
        switch_fk, switch_ik, switch_pole, 0.0,
    )
    space_plan = plan_space_switch(
        "benchmark", "arm.L", float(index), "ik.space", switch_ik,
        0, 1, ("全局", "胸腔"),
    )
rig_switch_ms = (perf_counter() - started) * 1000.0

result = {
    "canvas_nodes": len(nodes),
    "canvas_project_and_hit_mean_ms": round(canvas_ms, 4),
    "canvas_budget_ms": 8.0,
    "canvas_passed": canvas_ms <= 8.0,
    "mri_vertices": len(rows),
    "mri_influences": len(rows[0]),
    "mri_analysis_ms": round(mri_ms, 3),
    "mri_hotspots": report.hotspot_count,
    "mri_projection_ms": round(projection_ms, 3),
    "mri_projected_vertices": len(projection.vertices),
    "mri_projected_triangles": len(projection.triangles),
    "mri_projection_budget_ms": 850.0,
    "mri_projection_passed": projection_ms <= 850.0 and bool(projection.triangles),
    "retarget_frames": len(retarget_preview.frames),
    "retarget_semantics": len(retarget_profile.mappings),
    "retarget_preview_and_plan_ms": round(retarget_ms, 3),
    "retarget_layer_keys": len(retarget_plan.keys),
    "retarget_axis_angle_degrees": round(retarget_profile.axis_template.angle_degrees, 3),
    "retarget_budget_ms": 120.0,
    "retarget_passed": retarget_ms <= 120.0 and retarget_plan.can_apply,
    "contact_ik_frames": len(contact_actual_clip.frames),
    "contact_ik_chain_frames": len(contact_preview.samples),
    "contact_ik_preview_and_plan_ms": round(contact_ms, 3),
    "contact_ik_layer_keys": len(contact_plan.keys),
    "contact_ik_maximum_pelvis_offset": round(contact_preview.maximum_pelvis_offset, 6),
    "contact_ik_ground_angle_degrees": round(contact_preview.maximum_ground_angle_degrees, 3),
    "contact_ik_budget_ms": 80.0,
    "contact_ik_passed": (
        contact_ms <= 80.0
        and contact_preview.unreachable_count == 0
        and contact_plan.can_apply
    ),
    "clip_library_files": library_scan.scanned_files,
    "clip_library_invalid": library_scan.invalid_files,
    "clip_library_filtered": len(library_filtered),
    "clip_library_scan_and_filter_ms": round(library_ms, 3),
    "clip_library_budget_ms": 250.0,
    "clip_library_passed": (
        library_ms <= 250.0
        and library_scan.invalid_files == 1
        and len(library_filtered) == 120
    ),
    "rig_graph_modules": len(rig_scale_graph.modules),
    "rig_graph_nodes": len(rig_scale_graph.nodes),
    "rig_graph_behaviors": len(rig_scale_graph.behaviors),
    "rig_graph_create_and_noop_ms": round(rig_graph_ms, 3),
    "rig_graph_budget_ms": 50.0,
    "rig_graph_passed": (
        rig_graph_ms <= 50.0
        and rig_create_plan.can_apply
        and rig_noop_plan.is_noop
    ),
    "rig_switch_plan_iterations": switch_iterations * 2,
    "rig_switch_plan_ms": round(rig_switch_ms, 3),
    "rig_switch_plan_budget_ms": 120.0,
    "rig_switch_plan_passed": (
        rig_switch_ms <= 120.0
        and match_plan.can_apply
        and space_plan.can_apply
    ),
}
output = Path(__file__).with_name("artifacts") / "domain_benchmark.json"
output.parent.mkdir(exist_ok=True)
output.write_text(json.dumps(result, indent=2), encoding="utf-8")
print(json.dumps(result, indent=2))
if not result["canvas_passed"]:
    raise SystemExit("Canvas interaction budget exceeded")
if not result["mri_projection_passed"]:
    raise SystemExit("Deformation field projection budget exceeded")
if not result["retarget_passed"]:
    raise SystemExit("Retarget preview/plan budget exceeded")
if not result["contact_ik_passed"]:
    raise SystemExit("Contact IK preview/plan budget exceeded")
if not result["clip_library_passed"]:
    raise SystemExit("Clip library scan/filter budget exceeded")
if not result["rig_graph_passed"]:
    raise SystemExit("Rig Graph compile budget exceeded")
if not result["rig_switch_plan_passed"]:
    raise SystemExit("Rig switching plan budget exceeded")
