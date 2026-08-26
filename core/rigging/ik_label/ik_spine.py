# core/rigging/ik_label/ik_spine.py
# -*- coding: utf-8 -*-

from MayaCraft.core.rigging.base import RigObject, RigTask
class IKSpineModule(RigObject):
    SLOTS = ["Root", "Spine", "Chest"]
    def __init__(self, builder, mapping_data: dict):
        pass

    def create_tasks(self, builder) -> list[RigTask]:
        return []
