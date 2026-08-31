"""Versioned, host-independent Rig Graph specification and incremental diff compiler."""

from __future__ import annotations

from dataclasses import dataclass, field, replace
import math
from typing import Iterable, Tuple


@dataclass(frozen=True)
class RigSocketSpec:
    socket_id: str
    data_type: str
    direction: str


@dataclass(frozen=True)
class RigConnectionSpec:
    source_module: str
    source_socket: str
    target_module: str
    target_socket: str


@dataclass(frozen=True)
class RigBehaviorSpec:
    """A host-independent declaration of a physical rig relationship.

    Nodes describe ownership and hierarchy.  Behaviors describe how those nodes
    actually work together in Maya.  Keeping this separate prevents a control
    named ``*_IK_CTRL`` from being mistaken for a functioning IK system.
    """

    stable_id: str
    behavior_type: str
    owner_module: str
    sources: Tuple[str, ...]
    targets: Tuple[str, ...]
    settings: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)

    @property
    def signature(self):
        return (
            ("sources", "|".join(self.sources)),
            ("targets", "|".join(self.targets)),
            *tuple(sorted(self.settings)),
        )


@dataclass(frozen=True)
class RigNodeSpec:
    stable_id: str
    maya_name: str
    node_type: str
    owner_module: str
    layer: str
    parent_id: str = ""
    attributes: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)

    @property
    def signature(self):
        return tuple(sorted(self.attributes))


@dataclass(frozen=True)
class RigModuleSpec:
    module_id: str
    module_type: str
    display_name: str
    side: str = "center"
    depends_on: Tuple[str, ...] = field(default_factory=tuple)
    sockets: Tuple[RigSocketSpec, ...] = field(default_factory=tuple)
    nodes: Tuple[RigNodeSpec, ...] = field(default_factory=tuple)
    behaviors: Tuple[RigBehaviorSpec, ...] = field(default_factory=tuple)
    settings: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)

    def socket(self, socket_id):
        return next((socket for socket in self.sockets if socket.socket_id == socket_id), None)


@dataclass(frozen=True)
class RigGraphSpec:
    graph_id: str
    display_name: str
    modules: Tuple[RigModuleSpec, ...]
    connections: Tuple[RigConnectionSpec, ...] = field(default_factory=tuple)
    schema_version: int = 1

    @property
    def nodes(self):
        return tuple(node for module in self.modules for node in module.nodes)

    @property
    def behaviors(self):
        return tuple(behavior for module in self.modules for behavior in module.behaviors)


@dataclass(frozen=True)
class ObservedRigNode:
    stable_id: str
    maya_name: str
    node_type: str
    owner_module: str
    layer: str
    parent_id: str = ""
    signature: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class ObservedRigBehavior:
    stable_id: str
    behavior_type: str
    owner_module: str
    sources: Tuple[str, ...] = field(default_factory=tuple)
    targets: Tuple[str, ...] = field(default_factory=tuple)
    signature: Tuple[Tuple[str, str], ...] = field(default_factory=tuple)


@dataclass(frozen=True)
class RigGraphIssue:
    code: str
    message: str
    subject_id: str = ""


@dataclass(frozen=True)
class RigBuildChange:
    action: str
    stable_id: str
    owner_module: str
    summary: str
    risk: str = "safe"
    entity_kind: str = "node"


@dataclass(frozen=True)
class RigBuildPlan:
    graph_id: str
    module_order: Tuple[str, ...] = field(default_factory=tuple)
    changes: Tuple[RigBuildChange, ...] = field(default_factory=tuple)
    behavior_changes: Tuple[RigBuildChange, ...] = field(default_factory=tuple)
    blockers: Tuple[RigGraphIssue, ...] = field(default_factory=tuple)
    observed_fingerprint: Tuple[Tuple, ...] = field(default_factory=tuple)
    observed_behavior_fingerprint: Tuple[Tuple, ...] = field(default_factory=tuple)

    @property
    def can_apply(self):
        return any(change.action != "PRESERVE" for change in self.all_changes) and not self.blockers

    @property
    def is_noop(self):
        return not self.blockers and all(change.action == "PRESERVE" for change in self.all_changes)

    @property
    def all_changes(self):
        return self.changes + self.behavior_changes

    @property
    def destructive_count(self):
        return sum(change.action in {"REMOVE", "REBUILD"} for change in self.all_changes)


@dataclass(frozen=True)
class RigBuildReceipt:
    graph_id: str
    verified: bool
    applied_count: int
    previous: Tuple[ObservedRigNode, ...]
    message: str
    previous_behaviors: Tuple[ObservedRigBehavior, ...] = field(default_factory=tuple)


def validate_rig_graph(graph: RigGraphSpec) -> Tuple[RigGraphIssue, ...]:
    issues = []
    if graph.schema_version != 1:
        issues.append(RigGraphIssue("schema", f"不支持的绑定图架构版本 {graph.schema_version}", graph.graph_id))
    modules = {module.module_id: module for module in graph.modules}
    if len(modules) != len(graph.modules):
        issues.append(RigGraphIssue("duplicate_module", "模块 ID 必须唯一", graph.graph_id))
    node_ids = [node.stable_id for node in graph.nodes]
    if len(set(node_ids)) != len(node_ids):
        issues.append(RigGraphIssue("duplicate_node", "节点稳定 ID 必须唯一", graph.graph_id))
    node_map = {node.stable_id: node for node in graph.nodes}
    behavior_ids = [behavior.stable_id for behavior in graph.behaviors]
    if len(set(behavior_ids)) != len(behavior_ids):
        issues.append(RigGraphIssue("duplicate_behavior", "行为稳定 ID 必须唯一", graph.graph_id))
    allowed_behaviors = {
        "bendy_curve", "matrix_drive", "matrix_blend", "rp_ik",
        "space_switch", "twist_distribution",
    }
    for module in graph.modules:
        for dependency in module.depends_on:
            if dependency not in modules:
                issues.append(RigGraphIssue("missing_dependency", f"缺少模块依赖 {dependency}", module.module_id))
        for node in module.nodes:
            if node.owner_module != module.module_id:
                issues.append(RigGraphIssue("owner_mismatch", f"节点 {node.stable_id} 的归属与模块不一致", node.stable_id))
            if node.layer not in {"control", "deform", "delivery", "meta"}:
                issues.append(RigGraphIssue("invalid_layer", f"未知绑定层 {node.layer}", node.stable_id))
            if node.parent_id and node.parent_id not in node_map:
                issues.append(RigGraphIssue("missing_parent", f"缺少父节点 {node.parent_id}", node.stable_id))
        for behavior in module.behaviors:
            if behavior.owner_module != module.module_id:
                issues.append(RigGraphIssue("behavior_owner", f"行为 {behavior.stable_id} 的归属与模块不一致", behavior.stable_id))
            if behavior.behavior_type not in allowed_behaviors:
                issues.append(RigGraphIssue("behavior_type", f"未知绑定行为 {behavior.behavior_type}", behavior.stable_id))
            if not behavior.sources or not behavior.targets:
                issues.append(RigGraphIssue("behavior_endpoint", f"行为 {behavior.stable_id} 缺少输入或输出", behavior.stable_id))
            for stable_id in behavior.sources + behavior.targets:
                if stable_id not in node_map:
                    issues.append(RigGraphIssue("behavior_node", f"行为 {behavior.stable_id} 引用了缺失节点 {stable_id}", behavior.stable_id))
            if behavior.behavior_type == "matrix_drive" and (len(behavior.sources) != 1 or len(behavior.targets) != 1):
                issues.append(RigGraphIssue("matrix_drive_arity", f"矩阵驱动 {behavior.stable_id} 必须是一对一", behavior.stable_id))
            if behavior.behavior_type == "matrix_blend" and (len(behavior.sources) != 3 or len(behavior.targets) != 1):
                issues.append(RigGraphIssue("matrix_blend_arity", f"矩阵混合 {behavior.stable_id} 必须包含 FK、IK、权重控制和一个结果", behavior.stable_id))
            if behavior.behavior_type == "rp_ik" and (len(behavior.sources) != 2 or len(behavior.targets) != 3):
                issues.append(RigGraphIssue("rp_ik_arity", f"RP IK {behavior.stable_id} 必须包含末端、Pole 和三段关节", behavior.stable_id))
            if behavior.behavior_type == "space_switch" and (len(behavior.sources) < 3 or len(behavior.targets) != 1):
                issues.append(RigGraphIssue("space_switch_arity", f"空间切换 {behavior.stable_id} 至少需要两个空间、一个选择器和一个目标", behavior.stable_id))
            if behavior.behavior_type == "twist_distribution" and (len(behavior.sources) != 2 or len(behavior.targets) < 1):
                issues.append(RigGraphIssue("twist_distribution_arity", f"Twist 分配 {behavior.stable_id} 必须包含起止驱动和至少一个扭转关节", behavior.stable_id))
            if behavior.behavior_type == "bendy_curve" and (len(behavior.sources) != 4 or len(behavior.targets) < 2):
                issues.append(RigGraphIssue(
                    "bendy_curve_arity",
                    f"Bendy 弧线 {behavior.stable_id} 必须包含起点、两枚切线控制器、终点和至少两个形变关节",
                    behavior.stable_id,
                ))
    _order, cycle = _topological_order(graph.modules)
    if cycle:
        issues.append(RigGraphIssue("module_cycle", "模块依赖图存在循环", cycle))
    if _node_cycle(graph.nodes):
        issues.append(RigGraphIssue("node_cycle", "绑定节点层级存在循环", graph.graph_id))
    for connection in graph.connections:
        source_module = modules.get(connection.source_module)
        target_module = modules.get(connection.target_module)
        if not source_module or not target_module:
            issues.append(RigGraphIssue("connection_module", "连接引用了缺失模块", connection.target_module))
            continue
        source = source_module.socket(connection.source_socket)
        target = target_module.socket(connection.target_socket)
        if not source or not target:
            issues.append(RigGraphIssue("connection_socket", "连接引用了缺失接口", connection.target_module))
        elif source.direction != "out" or target.direction != "in" or source.data_type != target.data_type:
            issues.append(RigGraphIssue("socket_type", "接口方向或数据类型不兼容", connection.target_module))
    return tuple(issues)


def module_build_order(graph: RigGraphSpec) -> Tuple[str, ...]:
    order, cycle = _topological_order(graph.modules)
    if cycle:
        raise ValueError(f"Module dependency cycle at {cycle}")
    return order


def _topological_order(modules: Iterable[RigModuleSpec]):
    values = tuple(modules)
    dependencies = {module.module_id: set(module.depends_on) for module in values}
    order = []
    while dependencies:
        ready = sorted(module_id for module_id, required in dependencies.items() if not required)
        if not ready:
            return tuple(order), sorted(dependencies)[0]
        for module_id in ready:
            order.append(module_id)
            dependencies.pop(module_id)
        for required in dependencies.values():
            required.difference_update(ready)
    return tuple(order), ""


def _node_cycle(nodes):
    parents = {node.stable_id: node.parent_id for node in nodes if node.parent_id}
    for node_id in parents:
        seen = set()
        cursor = node_id
        while cursor in parents:
            if cursor in seen:
                return True
            seen.add(cursor)
            cursor = parents[cursor]
    return False


def compile_incremental_rig(
    graph: RigGraphSpec,
    observed: Iterable[ObservedRigNode],
    observed_behaviors: Iterable[ObservedRigBehavior] = (),
) -> RigBuildPlan:
    current_values = tuple(observed)
    observed_fingerprint = tuple(sorted(
        (item.stable_id, item.maya_name, item.node_type, item.owner_module, item.layer, item.parent_id, tuple(sorted(item.signature)))
        for item in current_values
    ))
    blockers = validate_rig_graph(graph)
    current_behavior_values = tuple(observed_behaviors)
    observed_behavior_fingerprint = tuple(sorted(
        (item.stable_id, item.behavior_type, item.owner_module, item.sources, item.targets, tuple(sorted(item.signature)))
        for item in current_behavior_values
    ))
    if blockers:
        return RigBuildPlan(
            graph.graph_id,
            blockers=blockers,
            observed_fingerprint=observed_fingerprint,
            observed_behavior_fingerprint=observed_behavior_fingerprint,
        )
    order = module_build_order(graph)
    desired = {node.stable_id: node for node in graph.nodes}
    current = {node.stable_id: node for node in current_values}
    changes = []
    node_order = {node.stable_id: index for index, node in enumerate(_ordered_nodes(graph.nodes))}
    for stable_id in sorted(desired, key=lambda item: node_order[item]):
        target = desired[stable_id]
        source = current.get(stable_id)
        if source is None:
            changes.append(RigBuildChange("CREATE", stable_id, target.owner_module, f"创建 {target.node_type} {target.maya_name}"))
        elif source.node_type != target.node_type:
            changes.append(RigBuildChange("REBUILD", stable_id, target.owner_module, f"重建类型 {source.node_type} → {target.node_type}", "destructive"))
        elif source.parent_id != target.parent_id:
            changes.append(RigBuildChange("REPARENT", stable_id, target.owner_module, f"父级 {source.parent_id or '世界'} → {target.parent_id or '世界'}", "review"))
        elif source.maya_name != target.maya_name:
            changes.append(RigBuildChange("RENAME", stable_id, target.owner_module, f"重命名 {source.maya_name} → {target.maya_name}", "review"))
        elif tuple(sorted(source.signature)) != target.signature:
            changes.append(RigBuildChange("UPDATE", stable_id, target.owner_module, "更新声明属性"))
        else:
            changes.append(RigBuildChange("PRESERVE", stable_id, target.owner_module, "已经符合声明"))
    for source in sorted(current_values, key=lambda item: item.stable_id):
        if source.stable_id not in desired and source.owner_module:
            changes.append(RigBuildChange("REMOVE", source.stable_id, source.owner_module, f"移除过期自有节点 {source.maya_name}", "destructive"))
    desired_behaviors = {item.stable_id: item for item in graph.behaviors}
    current_behaviors = {item.stable_id: item for item in current_behavior_values}
    behavior_changes = []
    for stable_id in sorted(desired_behaviors):
        target = desired_behaviors[stable_id]
        source = current_behaviors.get(stable_id)
        if source is None:
            behavior_changes.append(RigBuildChange(
                "CREATE", stable_id, target.owner_module,
                f"创建 {target.behavior_type} 行为", entity_kind="behavior",
            ))
        elif source.behavior_type != target.behavior_type:
            behavior_changes.append(RigBuildChange(
                "REBUILD", stable_id, target.owner_module,
                f"重建行为类型 {source.behavior_type} → {target.behavior_type}", "destructive", "behavior",
            ))
        elif (
            source.owner_module != target.owner_module
            or source.sources != target.sources
            or source.targets != target.targets
            or tuple(sorted(source.signature)) != tuple(sorted(target.signature))
        ):
            behavior_changes.append(RigBuildChange(
                "UPDATE", stable_id, target.owner_module,
                "修复行为连接或设置", "review", "behavior",
            ))
        else:
            behavior_changes.append(RigBuildChange(
                "PRESERVE", stable_id, target.owner_module,
                "行为连接已经符合声明", entity_kind="behavior",
            ))
    for source in sorted(current_behavior_values, key=lambda item: item.stable_id):
        if source.stable_id not in desired_behaviors and source.owner_module:
            behavior_changes.append(RigBuildChange(
                "REMOVE", source.stable_id, source.owner_module,
                f"移除过期行为 {source.stable_id}", "destructive", "behavior",
            ))
    return RigBuildPlan(
        graph.graph_id,
        order,
        tuple(changes),
        tuple(behavior_changes),
        observed_fingerprint=observed_fingerprint,
        observed_behavior_fingerprint=observed_behavior_fingerprint,
    )


def _ordered_nodes(nodes):
    values = {node.stable_id: node for node in nodes}
    result = []
    remaining = set(values)
    while remaining:
        ready = sorted(node_id for node_id in remaining if not values[node_id].parent_id or values[node_id].parent_id in {item.stable_id for item in result})
        if not ready:
            return tuple(values[node_id] for node_id in sorted(values))
        for node_id in ready:
            result.append(values[node_id])
            remaining.remove(node_id)
    return tuple(result)


def compute_pole_vector_position(start, middle, end, distance_scale=0.65):
    """Return a deterministic pole position, including a collinear fallback."""
    if distance_scale <= 0.0:
        raise ValueError("Pole 距离比例必须大于零")
    start = tuple(float(value) for value in start)
    middle = tuple(float(value) for value in middle)
    end = tuple(float(value) for value in end)
    if any(len(value) != 3 for value in (start, middle, end)):
        raise ValueError("Pole 输入必须是三个三维位置")

    def subtract(a, b):
        return tuple(a[index] - b[index] for index in range(3))

    def add(a, b):
        return tuple(a[index] + b[index] for index in range(3))

    def scale(value, amount):
        return tuple(item * amount for item in value)

    def dot(a, b):
        return sum(a[index] * b[index] for index in range(3))

    def length(value):
        return math.sqrt(dot(value, value))

    chain = subtract(end, start)
    chain_length_sq = dot(chain, chain)
    first_length = length(subtract(middle, start))
    second_length = length(subtract(end, middle))
    total_length = first_length + second_length
    if total_length <= 1e-8 or chain_length_sq <= 1e-12:
        raise ValueError("IK 链长度为零，无法计算 Pole")
    projection = add(start, scale(chain, dot(subtract(middle, start), chain) / chain_length_sq))
    bend = subtract(middle, projection)
    bend_length = length(bend)
    if bend_length <= total_length * 1e-5:
        direction = scale(chain, 1.0 / math.sqrt(chain_length_sq))
        axes = ((1.0, 0.0, 0.0), (0.0, 1.0, 0.0), (0.0, 0.0, 1.0))
        fallback = min(axes, key=lambda axis: abs(dot(direction, axis)))
        bend = (
            direction[1] * fallback[2] - direction[2] * fallback[1],
            direction[2] * fallback[0] - direction[0] * fallback[2],
            direction[0] * fallback[1] - direction[1] * fallback[0],
        )
        bend_length = length(bend)
    direction = scale(bend, 1.0 / max(bend_length, 1e-12))
    return add(middle, scale(direction, total_length * distance_scale))


def golden_biped_graph(graph_id="mayaCraftBiped") -> RigGraphSpec:
    socket_in = lambda name, kind="transform": RigSocketSpec(name, kind, "in")
    socket_out = lambda name, kind="transform": RigSocketSpec(name, kind, "out")
    modules = []
    root_nodes = (
        RigNodeSpec("rig.root", "MC_RIG", "transform", "root", "meta"),
        RigNodeSpec("rig.controls", "MC_CONTROLS", "transform", "root", "control", "rig.root"),
        RigNodeSpec("rig.deform", "MC_DEFORM", "transform", "root", "deform", "rig.root"),
        RigNodeSpec("rig.delivery", "MC_DELIVERY", "transform", "root", "delivery", "rig.root"),
    )
    modules.append(RigModuleSpec("root", "root", "角色根", sockets=(socket_out("body"),), nodes=root_nodes))
    spine_nodes = (
        RigNodeSpec("spine.module", "C_spine_MOD", "transform", "spine", "meta", "rig.controls"),
        RigNodeSpec("spine.ctrl", "C_chest_FK_CTRL", "transform", "spine", "control", "spine.module", (("controlShape", "circle"), ("semanticRole", "chest"))),
        RigNodeSpec("spine.deform", "C_chest_DRV_JNT", "joint", "spine", "deform", "rig.deform", (("semanticRole", "chest"),)),
    )
    modules.append(RigModuleSpec(
        "spine", "fk_chain", "脊柱 FK", depends_on=("root",),
        sockets=(socket_in("root"), socket_out("chest")), nodes=spine_nodes,
        behaviors=(RigBehaviorSpec("spine.drive", "matrix_drive", "spine", ("spine.ctrl",), ("spine.deform",)),),
    ))
    head_nodes = (
        RigNodeSpec("head.ctrl", "C_head_FK_CTRL", "transform", "head", "control", "spine.ctrl", (("controlShape", "circle"), ("semanticRole", "head"))),
        RigNodeSpec("head.deform", "C_head_DRV_JNT", "joint", "head", "deform", "spine.deform", (("semanticRole", "head"),)),
    )
    modules.append(RigModuleSpec(
        "head", "fk_chain", "头部 FK", depends_on=("spine",), sockets=(socket_in("neck"),), nodes=head_nodes,
        behaviors=(RigBehaviorSpec("head.drive", "matrix_drive", "head", ("head.ctrl",), ("head.deform",)),),
    ))
    def limb_module(module_id, side, label, roles, parts, dependency, input_socket, output_socket):
        nodes = [RigNodeSpec(f"{module_id}.module", f"{side}_{label}_MOD", "transform", module_id, "meta", "rig.controls")]
        behaviors = []
        for index, (part, role) in enumerate(zip(parts, roles)):
            ctrl_id = f"{module_id}.fk.{index}"
            result_id = f"{module_id}.deform.{index}"
            fk_joint_id = f"{module_id}.fk_joint.{index}"
            ik_joint_id = f"{module_id}.ik_joint.{index}"
            ctrl_parent = f"{module_id}.module" if index == 0 else f"{module_id}.fk.{index - 1}"
            result_parent = "rig.delivery" if index == 0 else f"{module_id}.deform.{index - 1}"
            fk_parent = "rig.deform" if index == 0 else f"{module_id}.fk_joint.{index - 1}"
            ik_parent = "rig.deform" if index == 0 else f"{module_id}.ik_joint.{index - 1}"
            nodes.extend((
                RigNodeSpec(ctrl_id, f"{side}_{part}_FK_CTRL", "transform", module_id, "control", ctrl_parent, (("controlShape", "circle"), ("semanticRole", role))),
                RigNodeSpec(result_id, f"{side}_{part}_RESULT_JNT", "joint", module_id, "delivery", result_parent, (("semanticRole", role),)),
                RigNodeSpec(fk_joint_id, f"{side}_{part}_FK_DRV_JNT", "joint", module_id, "deform", fk_parent, (("semanticRole", role),)),
                RigNodeSpec(ik_joint_id, f"{side}_{part}_IK_DRV_JNT", "joint", module_id, "deform", ik_parent, (("semanticRole", role),)),
            ))
            behaviors.extend((
                RigBehaviorSpec(f"{module_id}.drive.{index}", "matrix_drive", module_id, (ctrl_id,), (fk_joint_id,)),
                RigBehaviorSpec(
                    f"{module_id}.blend.{index}", "matrix_blend", module_id,
                    (fk_joint_id, ik_joint_id, f"{module_id}.ik.ctrl"), (result_id,),
                    (("weightAttribute", "ikFk"),),
                ),
            ))
        end_role = roles[-1]
        nodes.extend((
            RigNodeSpec(f"{module_id}.ik.space", f"{side}_{label}_IK_SPACE", "transform", module_id, "control", f"{module_id}.module"),
            RigNodeSpec(
                f"{module_id}.ik.ctrl", f"{side}_{parts[-1]}_IK_CTRL", "transform", module_id, "control", f"{module_id}.ik.space",
                (
                    ("controlShape", "circle"),
                    ("customEnum:space", "全局:胸口|0"),
                    ("customFloat:ikFk", "0|0|1"),
                    ("customFloat:twist", "0|-180|180"),
                    ("semanticRole", end_role),
                ),
            ),
            RigNodeSpec(
                f"{module_id}.pole.ctrl", f"{side}_{label}_POLE_CTRL", "transform", module_id, "control", f"{module_id}.module",
                (("controlShape", "diamond"), ("poleRoles", "|".join(roles))),
            ),
        ))
        behaviors.append(RigBehaviorSpec(
            f"{module_id}.rp_ik", "rp_ik", module_id,
            (f"{module_id}.ik.ctrl", f"{module_id}.pole.ctrl"),
            tuple(f"{module_id}.ik_joint.{index}" for index in range(3)),
            (("solver", "ikRPsolver"),),
        ))
        behaviors.append(RigBehaviorSpec(
            f"{module_id}.space", "space_switch", module_id,
            ("rig.controls", "spine.ctrl", f"{module_id}.ik.ctrl"),
            (f"{module_id}.ik.space",),
            (("selectorAttribute", "space"), ("spaceLabels", "全局|胸口")),
        ))
        for segment_index in range(2):
            bendy_ids = []
            start_role, end_role = roles[segment_index:segment_index + 2]
            for handle_name, fraction in (("in", 0.33), ("out", 0.67)):
                handle_id = f"{module_id}.bendy.{segment_index}.{handle_name}"
                attributes = [
                    ("controlShape", "circle"),
                    ("bendyStartRole", start_role),
                    ("bendyEndRole", end_role),
                    ("bendyFraction", f"{fraction:.2f}"),
                ]
                if handle_name == "in":
                    attributes.append(("customFloat:volume", "0.65|0|1"))
                nodes.append(RigNodeSpec(
                    handle_id,
                    f"{side}_{parts[segment_index]}_BENDY_{handle_name.upper()}_CTRL",
                    "transform", module_id, "control", f"{module_id}.module",
                    tuple(attributes),
                ))
            for bendy_index, fraction in enumerate((0.25, 0.5, 0.75)):
                bendy_id = f"{module_id}.bendy.{segment_index}.{bendy_index}"
                bendy_ids.append(bendy_id)
                nodes.append(RigNodeSpec(
                    bendy_id,
                    f"{side}_{parts[segment_index]}_BENDY_{bendy_index + 1:02d}_JNT",
                    "joint", module_id, "deform", "rig.delivery",
                    (
                        ("bendyStartRole", start_role),
                        ("bendyEndRole", end_role),
                        ("bendyFraction", f"{fraction:.2f}"),
                    ),
                ))
            behaviors.append(RigBehaviorSpec(
                f"{module_id}.bendy.{segment_index}", "bendy_curve", module_id,
                (
                    f"{module_id}.deform.{segment_index}",
                    f"{module_id}.bendy.{segment_index}.in",
                    f"{module_id}.bendy.{segment_index}.out",
                    f"{module_id}.deform.{segment_index + 1}",
                ),
                tuple(bendy_ids),
                (
                    ("aimAxis", "1,0,0"),
                    ("fractions", "0.25|0.5|0.75"),
                    ("startRole", start_role),
                    ("endRole", end_role),
                    ("volumeAttribute", "volume"),
                ),
            ))
            twist_ids = []
            for twist_index, fraction in enumerate((0.25, 0.5, 0.75)):
                twist_id = f"{module_id}.twist.{segment_index}.{twist_index}"
                twist_ids.append(twist_id)
                nodes.append(RigNodeSpec(
                    twist_id,
                    f"{side}_{parts[segment_index]}_TWIST_{twist_index + 1:02d}_JNT",
                    "joint", module_id, "deform", bendy_ids[twist_index],
                    (
                        ("twistStartRole", roles[segment_index]),
                        ("twistEndRole", roles[segment_index + 1]),
                        ("twistFraction", f"{fraction:.2f}"),
                    ),
                ))
            behaviors.append(RigBehaviorSpec(
                f"{module_id}.twist.{segment_index}", "twist_distribution", module_id,
                (f"{module_id}.deform.{segment_index}", f"{module_id}.deform.{segment_index + 1}"),
                tuple(twist_ids),
                (
                    ("aimAxis", "1,0,0"),
                    ("startRole", roles[segment_index]),
                    ("endRole", roles[segment_index + 1]),
                    ("weights", "0.25|0.5|0.75"),
                ),
            ))
        dependencies = dependency if isinstance(dependency, tuple) else (dependency,)
        return RigModuleSpec(
            module_id, "ikfk_limb", label, side="left" if side == "L" else "right",
            depends_on=dependencies, sockets=(socket_in(input_socket), socket_out(output_socket)),
            nodes=tuple(nodes), behaviors=tuple(behaviors),
        )

    for side in ("L", "R"):
        prefix = "left" if side == "L" else "right"
        side_name = "左" if side == "L" else "右"
        modules.append(limb_module(
            f"{side.lower()}_arm", side, "arm",
            (f"{prefix}_upper_arm", f"{prefix}_lower_arm", f"{prefix}_hand"),
            ("upperArm", "forearm", "hand"), "spine", "shoulder", "wrist",
        ))
        modules.append(limb_module(
            f"{side.lower()}_leg", side, "leg",
            (f"{prefix}_upper_leg", f"{prefix}_lower_leg", f"{prefix}_foot"),
            ("thigh", "calf", "foot"), ("root", "spine"), "hip", "ankle",
        ))
        modules[-2] = replace(modules[-2], display_name=f"{side_name}臂 FK/IK")
        modules[-1] = replace(modules[-1], display_name=f"{side_name}腿 FK/IK")
    connections = (
        RigConnectionSpec("root", "body", "spine", "root"),
        RigConnectionSpec("spine", "chest", "head", "neck"),
        RigConnectionSpec("spine", "chest", "l_arm", "shoulder"),
        RigConnectionSpec("spine", "chest", "r_arm", "shoulder"),
        RigConnectionSpec("root", "body", "l_leg", "hip"),
        RigConnectionSpec("root", "body", "r_leg", "hip"),
    )
    return RigGraphSpec(graph_id, "MayaCraft 黄金双足", tuple(modules), connections)


def bind_graph_to_skeleton(graph: RigGraphSpec, analysis) -> RigGraphSpec:
    """Embed verified semantic joint transforms into a graph declaration."""
    if not analysis or not analysis.is_usable:
        raise ValueError("A usable semantic skeleton analysis is required")
    observations = {item.path: item for item in analysis.joints}
    semantic_by_role = {item.role: item for item in analysis.semantics}
    required_roles = sorted({
        dict(node.attributes).get("semanticRole", "")
        for node in graph.nodes
        if dict(node.attributes).get("semanticRole", "")
    })
    missing_roles = tuple(role for role in required_roles if role not in semantic_by_role)
    if missing_roles:
        raise ValueError("黄金双足模板缺少必要骨架语义：" + "、".join(missing_roles))
    modules = []

    def world_to_local_vector(vector, quaternion):
        x, y, z, w = (float(value) for value in quaternion)
        length = math.sqrt(x * x + y * y + z * z + w * w)
        if length <= 1e-12:
            raise ValueError("骨架关节方向四元数长度为零")
        x, y, z, w = x / length, y / length, z / length, w / length
        vx, vy, vz = (float(value) for value in vector)
        # q^-1 * v * q, expanded to avoid host-specific math types.
        tx = 2.0 * (-y * vz + z * vy)
        ty = 2.0 * (-z * vx + x * vz)
        tz = 2.0 * (-x * vy + y * vx)
        return (
            vx + w * tx + (-y * tz + z * ty),
            vy + w * ty + (-z * tx + x * tz),
            vz + w * tz + (-x * ty + y * tx),
        )

    for module in graph.modules:
        nodes = []
        for node in module.nodes:
            declared = dict(node.attributes)
            role = declared.get("semanticRole", "")
            semantic = semantic_by_role.get(role, None)
            observed = observations.get(semantic.path, None) if semantic else None
            if observed:
                declared.update({
                    "sourceJoint": observed.path,
                    "semanticRole": role,
                    "worldPosition": ",".join(f"{value:.9g}" for value in observed.position),
                    "worldQuaternion": ",".join(f"{value:.9g}" for value in observed.orientation),
                })
                node = replace(node, attributes=tuple(sorted(declared.items())))
            pole_roles = tuple(item for item in declared.get("poleRoles", "").split("|") if item)
            if len(pole_roles) == 3:
                pole_semantics = tuple(semantic_by_role.get(item) for item in pole_roles)
                pole_joints = tuple(
                    observations.get(item.path) if item else None for item in pole_semantics
                )
                if all(pole_joints):
                    pole_position = compute_pole_vector_position(
                        pole_joints[0].position,
                        pole_joints[1].position,
                        pole_joints[2].position,
                    )
                    declared.update({
                        "sourceJoint": pole_joints[1].path,
                        "worldPosition": ",".join(f"{value:.9g}" for value in pole_position),
                        "worldQuaternion": "0,0,0,1",
                    })
                    node = replace(node, attributes=tuple(sorted(declared.items())))
            segment_start = declared.get("twistStartRole", "") or declared.get("bendyStartRole", "")
            segment_end = declared.get("twistEndRole", "") or declared.get("bendyEndRole", "")
            if segment_start and segment_end:
                start_semantic = semantic_by_role.get(segment_start)
                end_semantic = semantic_by_role.get(segment_end)
                start_joint = observations.get(start_semantic.path) if start_semantic else None
                end_joint = observations.get(end_semantic.path) if end_semantic else None
                if start_joint and end_joint:
                    fraction = float(declared.get("twistFraction", declared.get("bendyFraction", "0.5")))
                    position = tuple(
                        start_joint.position[index] +
                        (end_joint.position[index] - start_joint.position[index]) * fraction
                        for index in range(3)
                    )
                    declared.update({
                        "sourceJoint": start_joint.path,
                        "worldPosition": ",".join(f"{value:.9g}" for value in position),
                        "worldQuaternion": ",".join(f"{value:.9g}" for value in start_joint.orientation),
                    })
                    node = replace(node, attributes=tuple(sorted(declared.items())))
            nodes.append(node)
        behaviors = []
        for behavior in module.behaviors:
            if behavior.behavior_type not in {"twist_distribution", "bendy_curve"}:
                behaviors.append(behavior)
                continue
            settings = dict(behavior.settings)
            start_semantic = semantic_by_role.get(settings.get("startRole", ""))
            end_semantic = semantic_by_role.get(settings.get("endRole", ""))
            start_joint = observations.get(start_semantic.path) if start_semantic else None
            end_joint = observations.get(end_semantic.path) if end_semantic else None
            if not start_joint or not end_joint:
                behaviors.append(behavior)
                continue
            world_delta = tuple(
                end_joint.position[index] - start_joint.position[index] for index in range(3)
            )
            local_axis = world_to_local_vector(world_delta, start_joint.orientation)
            axis_length = math.sqrt(sum(value * value for value in local_axis))
            if axis_length <= 1e-8:
                raise ValueError(f"{behavior.stable_id} 的形变骨段长度为零")
            settings["aimAxis"] = ",".join(
                f"{value / axis_length:.9g}" for value in local_axis
            )
            behaviors.append(replace(behavior, settings=tuple(sorted(settings.items()))))
        modules.append(replace(module, nodes=tuple(nodes), behaviors=tuple(behaviors)))
    return replace(graph, modules=tuple(modules))
