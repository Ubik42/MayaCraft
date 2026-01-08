# core/rigging/module/ik_arm.py
# -*- coding: utf-8 -*-
from .base import BaseRigModule
from ..basic import ikfk
import maya.cmds as cmds


class IKArmModule(BaseRigModule):
    def build(self):
        # 1. 获取全路径
        start_jnt_full = self.get_joint("Shoulder")
        end_jnt_full = self.get_joint("Hand")

        if not start_jnt_full or not end_jnt_full:
            print(f"[IK Arm] Error: Missing joints. Start: {start_jnt_full}, End: {end_jnt_full}")
            return

        # 2. 转换为短名字 (用于底层 IKFK 构建)
        start_jnt_short = start_jnt_full.split("|")[-1]
        end_jnt_short = end_jnt_full.split("|")[-1]

        # [修改] 日志不再打印 self.side，改用骨骼名标识
        print(f"[IK Arm] Building System: {start_jnt_short} -> {end_jnt_short}")

        # 3. 创建 IKFK 系统
        self.system_data = ikfk.create_ikfk_system(
            start_bone_name=start_jnt_short,
            end_bone_name=end_jnt_short,
            ik_suffix="_ik",
            fk_suffix="_fk"
        )

        # 4. 归位逻辑
        if self.system_data:
            # IK 组归位
            if self.system_data.ik_grp and cmds.objExists(self.system_data.ik_grp):
                self.builder.safe_parent(self.system_data.ik_grp, self.builder.groups['ik_sys'])

            # FK 组归位
            if self.system_data.fk_ctrl_grp and cmds.objExists(self.system_data.fk_ctrl_grp):
                self.builder.safe_parent(self.system_data.fk_ctrl_grp, self.builder.groups['fk_sys'])

            # Switch 控制器归位
            if self.system_data.switch_control and cmds.objExists(self.system_data.switch_control):
                self.builder.safe_parent(self.system_data.switch_control, self.builder.groups['module_sys'])

        # 5. [修改] 注册接口
        # 不再使用 self.side ("L"/"R")，而是使用骨骼短名作为唯一后缀，防止多只手臂命名冲突
        # Pin Name 例如: "Arm_Root_Shoulder_L"
        pin_name = f"Arm_Root_{start_jnt_short}"
        self.register_pin(pin_name, start_jnt_full)

    def connect(self):
        """连接到脊柱"""
        # 1. 寻找脊柱接口
        spine_interface = self.builder.get_interface("Spine_Chest_Attach")

        # 获取短名用于日志和查找组
        start_jnt_full = self.get_joint("Shoulder")
        if not start_jnt_full: return
        start_jnt_short = start_jnt_full.split("|")[-1]

        if not spine_interface:
            # [修改] 移除 self.side
            print(f"[IK Arm] Warning: No Spine Interface found for {start_jnt_short}.")
            return

        # 2. 寻找自己系统的 FK 根组
        arm_root_grp = f"grp_{start_jnt_short}_fk_ctrl"

        if cmds.objExists(arm_root_grp):
            # [修改] 移除 self.side
            print(f"[IK Arm] Connecting {arm_root_grp} -> {spine_interface}")

            # 创建 Driver 组
            driver_grp = f"driver_{arm_root_grp}"
            if not cmds.objExists(driver_grp):
                cmds.group(empty=True, name=driver_grp)
                cmds.matchTransform(driver_grp, arm_root_grp)

                # 调整层级
                self.builder.safe_parent(driver_grp, self.builder.groups['fk_sys'])
                self.builder.safe_parent(arm_root_grp, driver_grp)

            # 约束
            cmds.parentConstraint(spine_interface, driver_grp, maintainOffset=True)
        else:
            # [修改] 移除 self.side
            print(f"[IK Arm] Error: FK Root Group not found: {arm_root_grp}")