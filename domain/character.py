"""Character context values shared by Maya adapters and presentation code."""

from __future__ import annotations

from dataclasses import dataclass, field
from typing import Tuple


@dataclass(frozen=True)
class NodeSummary:
    """Small immutable identity for a Maya node."""

    name: str
    path: str
    node_type: str


@dataclass(frozen=True)
class RigNode:
    """Small spatial rig-graph node suitable for live canvas projection."""

    name: str
    path: str
    kind: str
    parent_path: str = ""
    position: Tuple[float, float, float] = (0.0, 0.0, 0.0)
    side: str = "center"
    selected: bool = False


@dataclass(frozen=True)
class CharacterSnapshot:
    """Read-only structural scan of the character around the current selection."""

    stable_id: str = ""
    display_name: str = "没有角色"
    root: str = ""
    namespace: str = "ROOT"
    selected: Tuple[NodeSummary, ...] = field(default_factory=tuple)
    rig_nodes: Tuple[RigNode, ...] = field(default_factory=tuple)
    joint_count: int = 0
    mesh_count: int = 0
    control_count: int = 0
    skin_cluster_count: int = 0
    referenced: bool = False
    registered: bool = False
    schema_version: int = 0
    score: int = 0
    message: str = "选择任意关节、网格或控制器以捕获角色。"

    @property
    def is_empty(self) -> bool:
        return not bool(self.root)

    @property
    def state_label(self) -> str:
        if self.is_empty:
            return "等待角色信号"
        if self.registered:
            return "角色已关联"
        if self.score >= 80:
            return "绑定在线"
        if self.score >= 45:
            return "已发现角色"
        return "部分角色信号"

    @classmethod
    def empty(cls, message: str = "选择任意关节、网格或控制器以捕获角色。"):
        return cls(message=message)
