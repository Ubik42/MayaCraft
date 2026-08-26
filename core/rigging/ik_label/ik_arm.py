# core/rigging/ik_label/ik_arm.py
# -*- coding: utf-8 -*-
from maya import cmds

from MayaCraft.core.rigging.basic import ikfk
from MayaCraft.core import controller
from MayaCraft.core import tool
from MayaCraft.core.rigging.base import RigObject, RigTask
from MayaCraft.core.rigging.attribute import stretchy


class IKArmModule(RigObject):
    SLOTS = ["Shoulder", "Hand"]

    def __init__(self, builder, mapping_data: dict):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        """Single task for build and connect"""
        return [
            RigTask(
                priority=self.get_priority("module_ik_arm", 50),
                run=self.run_module,
                name="Build Module: IK Arm",
            )
        ]

    def get_joint(self, label_key: str) -> str:
        return self.mapping.get(label_key)

    def run_module(self):
        # --- Build Logic ---
        start_jnt_full = self.get_joint("Shoulder")
        end_jnt_full = self.get_joint("Hand")

        if not start_jnt_full or not end_jnt_full:
            print(
                f"[IK Arm] Error: Missing joints. Start: {start_jnt_full}, End: {end_jnt_full}"
            )
            return

        start_jnt_short = tool.get_short_name(start_jnt_full)
        end_jnt_short = tool.get_short_name(end_jnt_full)

        fk_offset_name = f"FKOffset_{start_jnt_short}"
        if not cmds.objExists(fk_offset_name):
            fk_offset_name = None

        print(
            f"[IK Arm] Building System: {start_jnt_short} -> {end_jnt_short}. FK: {fk_offset_name}"
        )

        self.system_data = ikfk.create_ikfk_system(
            start_bone_name=start_jnt_short,
            end_bone_name=end_jnt_short,
            existing_fk_sys=fk_offset_name,
        )

        if self.system_data:
            if self.system_data.get("ik_ctrl"):
                controller.apply_stored_shape(self.system_data["ik_ctrl"], "Box")
            if self.system_data.get("pv_ctrl"):
                controller.apply_stored_shape(self.system_data["pv_ctrl"], "FourArrows")
            if self.system_data.get("switch_ctrl"):
                controller.apply_stored_shape(self.system_data["switch_ctrl"], "Switch")

        # Stretchy
        if self.system_data:
            target_chain = self.system_data.get("ikx_joints")
            ik_ctrl = self.system_data.get("ik_ctrl")
            if target_chain and ik_ctrl:
                stretchy_start = target_chain[0]
                stretchy.create_stretchy_ik(
                    start_bone=stretchy_start,
                    end_bone=end_jnt_short,
                    stretch_control=ik_ctrl,
                    bind_chain=target_chain,
                )

        # Homing
        if self.system_data:
            switch_ctrl = self.system_data.get("switch_ctrl")
            if switch_ctrl and cmds.objExists(switch_ctrl):
                tool.safe_parent(switch_ctrl, self.builder.groups["fkik_sys"])

            stretchy_grp = f"{start_jnt_short}_stretchy_utils"
            if cmds.objExists(stretchy_grp):
                tool.safe_parent(stretchy_grp, self.builder.groups["fkik_sys"])

        # --- Follow End (Child Connect) ---
        fkx_end = f"FKX_{end_jnt_short}"
        if cmds.objExists(fkx_end) and cmds.objExists(end_jnt_full):
            hook_end_name = f"Hook_{end_jnt_short}_End"
            if not cmds.objExists(hook_end_name):
                cmds.createNode("transform", name=hook_end_name)
                # Hook to FK System as requested
                tool.safe_parent(hook_end_name, self.builder.groups["fk_sys"])

                cmds.parentConstraint(end_jnt_full, hook_end_name, maintainOffset=True)
                cmds.scaleConstraint(end_jnt_full, hook_end_name, maintainOffset=True)

            children = cmds.listRelatives(fkx_end, children=True) or []
            for child in children:
                if child.startswith("FKOffset_"):
                    tool.safe_parent(child, hook_end_name)

        # --- Connect Logic (To Parent) ---
        parents = cmds.listRelatives(start_jnt_full, parent=True, fullPath=True)
        if not parents:
            print(f"[IK Arm] Warning: {start_jnt_short} has no parent. Cannot connect.")
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
        arm_root_grp = f"FKOffset_{start_jnt_short}"
        if cmds.objExists(arm_root_grp):
            tool.safe_parent(arm_root_grp, hook_parent_name)
        else:
            print(f"[IK Arm] Error: FK Root Group not found: {arm_root_grp}")
