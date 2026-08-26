"""Selection navigation for Living Rig Canvas interactions."""

from __future__ import annotations


class MayaSelectionService:
    """Write Maya selection only; never mutates scene data."""

    @staticmethod
    def select_node(path: str) -> str:
        return MayaSelectionService.select_item(path)

    @staticmethod
    def select_item(path: str) -> str:
        import maya.cmds as cmds

        if not path or not cmds.objExists(path):
            raise ValueError(f"Maya item no longer exists: {path}")
        cmds.select(path, replace=True, noExpand=True)
        selected = cmds.ls(selection=True, long=True) or []
        if not selected:
            raise RuntimeError(f"Maya did not select item: {path}")
        return selected[0]

    @staticmethod
    def select_items(paths):
        import maya.cmds as cmds

        values = tuple(path for path in paths if path and cmds.objExists(path))
        if not values:
            raise ValueError("Maya 组件列表已经失效或为空")
        cmds.select(values, replace=True, noExpand=True)
        selected = tuple(cmds.ls(selection=True, long=True, flatten=True) or ())
        if not selected:
            raise RuntimeError("Maya 未能选择局部刷选组件")
        return selected
