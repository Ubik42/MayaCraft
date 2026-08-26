# core/rigging/ik_label/ik_leg.py
# -*- coding: utf-8 -*-

from MayaCraft.core.rigging.basic import ikfk
from MayaCraft.core import controller
from MayaCraft.core import tool
import maya.cmds as cmds
from MayaCraft.core.rigging.base import RigObject, RigTask


class IKLegModule(RigObject):
    SLOTS = ["Hip", "Foot"]

    def __init__(self, builder, mapping_data: dict):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        return [
            RigTask(
                priority=self.get_priority("module_ik_leg", 50),
                run=self.run_module,
                name="Build Module: IK Leg",
            )
        ]

    def get_joint(self, label_key: str) -> str:
        return self.mapping.get(label_key)

    def run_module(self):
        # --- Build Logic ---
        start_jnt_full = self.get_joint("Hip")
        end_jnt_full = self.get_joint("Foot")

        if not start_jnt_full or not end_jnt_full:
            print(
                f"[IK Leg] Error: Missing joints. Start: {start_jnt_full}, End: {end_jnt_full}"
            )
            return

        start_jnt_short = tool.get_short_name(start_jnt_full)
        end_jnt_short = tool.get_short_name(end_jnt_full)

        fk_offset_name = f"FKOffset_{start_jnt_short}"
        if not cmds.objExists(fk_offset_name):
            fk_offset_name = None

        print(
            f"[IK Leg] Building System: {start_jnt_short} -> {end_jnt_short}. FK: {fk_offset_name}"
        )

        #############################
        # 设置控制器
        #############################

        self.system_data = ikfk.create_ikfk_system(
            start_bone_name=start_jnt_short,
            end_bone_name=end_jnt_short,
            existing_fk_sys=fk_offset_name,
        )

        if self.system_data:
            if self.system_data.get("ik_ctrl"):
                controller.apply_stored_shape(self.system_data["ik_ctrl"], "Cube")
            if self.system_data.get("pv_ctrl"):
                controller.apply_stored_shape(self.system_data["pv_ctrl"], "FourArrows")
            if self.system_data.get("switch_ctrl"):
                controller.apply_stored_shape(self.system_data["switch_ctrl"], "Switch")

        # Homing
        if self.system_data:
            switch_ctrl = self.system_data.get("switch_ctrl")
            if switch_ctrl and cmds.objExists(switch_ctrl):
                tool.safe_parent(switch_ctrl, self.builder.groups["fkik_sys"])

        # --- Follow End (Child Connect) ---
        fkx_end = f"FKX_{end_jnt_short}"
        if cmds.objExists(fkx_end) and cmds.objExists(end_jnt_full):
            hook_end_name = f"Hook_{end_jnt_short}_End"
            if not cmds.objExists(hook_end_name):
                cmds.createNode("transform", name=hook_end_name)
                tool.safe_parent(hook_end_name, self.builder.groups["fk_sys"])

                cmds.parentConstraint(end_jnt_full, hook_end_name, maintainOffset=True)
                cmds.scaleConstraint(end_jnt_full, hook_end_name, maintainOffset=True)

            children = cmds.listRelatives(fkx_end, children=True) or []
            for child in children:
                if child.startswith("FKOffset_"):
                    # print(f"[IK Leg] Moving child {child} to {hook_end_name}")
                    tool.safe_parent(child, hook_end_name)

        # --- Connect Logic (To Parent) ---
        parents = cmds.listRelatives(start_jnt_full, parent=True, fullPath=True)
        if not parents:
            # If no parent (e.g. Root), verify if we are root? Usually Leg has parent (Pelvis)
            # If no parent, we do nothing or connect to Global
            print(
                f"[IK Leg] Warning: {start_jnt_short} has no parent. Hooking to Global/Root system might be needed if not top level."
            )
            return

        parent_jnt_full = parents[0]
        parent_jnt_short = tool.get_short_name(parent_jnt_full)

        # Define Connect Target
        connect_target = parent_jnt_full
        potential_fk_offset = f"FKOffset_{parent_jnt_short}"
        if cmds.objExists(potential_fk_offset):
            connect_target = potential_fk_offset

        # Hook Group for Parent
        hook_parent_name = f"Hook_{parent_jnt_short}"
        if not cmds.objExists(hook_parent_name):
            cmds.createNode("transform", name=hook_parent_name)
            tool.safe_parent(hook_parent_name, self.builder.groups["fk_sys"])

            cmds.parentConstraint(connect_target, hook_parent_name, maintainOffset=True)
            cmds.scaleConstraint(connect_target, hook_parent_name, maintainOffset=True)

        # Connect Module Root to Hook
        leg_root_grp = f"FKOffset_{start_jnt_short}"
        if cmds.objExists(leg_root_grp):
            tool.safe_parent(leg_root_grp, hook_parent_name)
        else:
            print(f"[IK Leg] Error: FK Root Group not found: {leg_root_grp}")
