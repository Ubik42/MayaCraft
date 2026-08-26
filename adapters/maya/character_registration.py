"""Transactional Maya implementation of character registration."""

from __future__ import annotations

from typing import Any, Dict, Tuple

from MayaCraft.domain.change import AttributeChange, ChangeReceipt, CharacterRegistrationPlan
from MayaCraft.domain.character import CharacterSnapshot


CHARACTER_ATTR = "mayacraftCharacter"
ID_ATTR = "mayacraftCharacterId"
SCHEMA_ATTR = "mayacraftSchemaVersion"
SCHEMA_VERSION = 1

ATTRIBUTE_SCHEMA: Tuple[Tuple[str, str, Any, str], ...] = (
    (CHARACTER_ATTR, "角色标记", True, "bool"),
    (ID_ATTR, "稳定角色 ID", "", "string"),
    (SCHEMA_ATTR, "架构版本", SCHEMA_VERSION, "long"),
)


def _maya_cmds():
    import maya.cmds as cmds

    return cmds


def _attribute_value(cmds, root: str, attribute: str):
    if not cmds.attributeQuery(attribute, node=root, exists=True):
        return None
    return cmds.getAttr(f"{root}.{attribute}")


class CharacterRegistrationService:
    """Build, apply, and independently verify an idempotent registration plan."""

    def plan(self, snapshot: CharacterSnapshot) -> CharacterRegistrationPlan:
        if snapshot.is_empty:
            return CharacterRegistrationPlan("", "", blockers=("请先捕获角色再进行关联。",))
        if snapshot.referenced:
            return CharacterRegistrationPlan(
                snapshot.root,
                snapshot.stable_id,
                blockers=("引用角色根节点为只读，请改为关联源资产。",),
            )

        cmds = _maya_cmds()
        if not cmds.objExists(snapshot.root):
            return CharacterRegistrationPlan(
                snapshot.root,
                snapshot.stable_id,
                blockers=("已捕获的角色根节点已不存在。",),
            )

        changes = []
        blockers = []
        target_values: Dict[str, Any] = {
            CHARACTER_ATTR: True,
            ID_ATTR: snapshot.stable_id,
            SCHEMA_ATTR: SCHEMA_VERSION,
        }
        labels = {name: label for name, label, _default, _kind in ATTRIBUTE_SCHEMA}
        kinds = {name: kind for name, _label, _default, kind in ATTRIBUTE_SCHEMA}
        for attribute, target in target_values.items():
            current = _attribute_value(cmds, snapshot.root, attribute)
            if attribute == ID_ATTR and current not in (None, "", target):
                blockers.append(f"现有角色 ID {current!r} 与捕获 ID {target!r} 冲突。")
                continue
            if current != target:
                changes.append(AttributeChange(attribute, labels[attribute], current, target, kinds[attribute]))

        return CharacterRegistrationPlan(
            snapshot.root,
            snapshot.stable_id,
            changes=tuple(changes),
            blockers=tuple(blockers),
        )

    def apply(self, plan: CharacterRegistrationPlan) -> ChangeReceipt:
        if not plan.can_apply:
            raise ValueError("当前角色关联计划不可应用。")

        cmds = _maya_cmds()
        if not cmds.objExists(plan.target_root):
            raise RuntimeError(f"角色根节点已消失：{plan.target_root}")

        opened = False
        mutated = False
        try:
            cmds.undoInfo(openChunk=True, chunkName="MayaCraft Register Character")
            opened = True
            for change in plan.changes:
                plug = f"{plan.target_root}.{change.attribute}"
                if not cmds.attributeQuery(change.attribute, node=plan.target_root, exists=True):
                    if change.data_type == "string":
                        cmds.addAttr(plan.target_root, longName=change.attribute, dataType="string")
                    else:
                        cmds.addAttr(plan.target_root, longName=change.attribute, attributeType=change.data_type)
                if change.data_type == "string":
                    cmds.setAttr(plug, str(change.target_value), type="string")
                else:
                    cmds.setAttr(plug, change.target_value)
                mutated = True
        except Exception:
            if opened:
                cmds.undoInfo(closeChunk=True)
                opened = False
            if mutated:
                cmds.undo()
            raise
        finally:
            if opened:
                cmds.undoInfo(closeChunk=True)

        verified = self.verify(plan.target_root, plan.stable_id)
        if not verified:
            cmds.undo()
            raise RuntimeError("MayaCraft 角色关联验证失败，事务已撤销。")
        return ChangeReceipt(
            operation="register_character",
            target_root=plan.target_root,
            applied_count=len(plan.changes),
            verified=True,
            message=f"角色关联完成，已验证 {len(plan.changes)} 项元数据变更。",
        )

    @staticmethod
    def verify(root: str, stable_id: str) -> bool:
        cmds = _maya_cmds()
        if not cmds.objExists(root):
            return False
        expected = {
            CHARACTER_ATTR: True,
            ID_ATTR: stable_id,
            SCHEMA_ATTR: SCHEMA_VERSION,
        }
        try:
            return all(_attribute_value(cmds, root, attr) == value for attr, value in expected.items())
        except Exception:
            return False
