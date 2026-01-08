"""
core/rigging/build.py

自动绑定构建逻辑的主入口 (Auto Rig Orchestrator)。
功能：
1. 自动标准化骨骼命名 (R_Prefix)。
2. 自动镜像骨骼 (R -> L)。
3. 构建 FK 脊柱。
4. 构建四肢 IK/FK 系统 (支持双侧自动补全)。
5. 创建 Main_ctrl 并处理 Root 约束冲突。
6. 连接四肢与脊柱 (Driver Group)。
"""

import maya.cmds as cmds
import importlib
from typing import List, Dict, Optional
import traceback
import os
import json

# 导入核心模块
from core.rigging import fk
from core.rigging import ikfk
from core import name
from core import attribute

class RigBuilder:
    def __init__(self):
        # 定义标准组结构
        self.groups = {
            "main": "Group",              # 根组
            "geo": "Geometry_Grp",        # 模型组
            "ctrl": "Controls_Grp",       # 控制器总组

            # Controls_Grp 下的子系统
            "main_sys": "MainSystem",
            "fk_sys": "FKSystem",
            "ik_sys": "IKSystem",
            "fkik_sys": "FKIKSystem"
        }

    def _safe_parent(self, child: str, parent: str):
        """安全的父子约束"""
        if not child or not parent: return
        if not cmds.objExists(child) or not cmds.objExists(parent): return

        current_parents = cmds.listRelatives(child, parent=True)
        if current_parents and current_parents[0] == parent:
            return

        try:
            cmds.parent(child, parent)
        except Exception:
            pass

    def prepare_scene(self):
        """初始化场景组结构"""
        # 1. 创建根组
        if not cmds.objExists(self.groups["main"]):
            cmds.createNode("transform", name=self.groups["main"])

        root_grp = self.groups["main"]

        # 2. 创建一级子组
        for key in ["geo", "ctrl"]:
            grp_name = self.groups[key]
            if not cmds.objExists(grp_name):
                cmds.createNode("transform", name=grp_name, parent=root_grp)
            else:
                self._safe_parent(grp_name, root_grp)

        # 3. 创建二级子组
        ctrl_grp = self.groups["ctrl"]
        sub_systems = ["main_sys", "fk_sys", "ik_sys", "fkik_sys"]

        for key in sub_systems:
            grp_name = self.groups[key]
            if not cmds.objExists(grp_name):
                cmds.createNode("transform", name=grp_name, parent=ctrl_grp)
            else:
                self._safe_parent(grp_name, ctrl_grp)

    def _expand_config_to_both_sides(self, config: Dict) -> Dict:
        """
        [预处理] 自动补全双侧配置。
        如果 config 只有 l_arm，自动添加 r_arm。
        """
        new_config = config.copy()

        pairs = [("l_arm", "r_arm"), ("l_leg", "r_leg")]

        for side_a, side_b in pairs:
            # A -> B
            if side_a in new_config and side_b not in new_config:
                print(f"[Build] Auto-generating config for {side_b} based on {side_a}")
                new_config[side_b] = new_config[side_a].copy()

            # B -> A
            elif side_b in new_config and side_a not in new_config:
                print(f"[Build] Auto-generating config for {side_a} based on {side_b}")
                new_config[side_a] = new_config[side_b].copy()

        return new_config

    def standardize_source_skeleton(self, config: Dict):
        """
        [步骤1] 标准化源骨骼命名。
        将无前缀的右侧骨骼 (如 Shoulder) 重命名为 R_Shoulder。
        """
        print("[Build] Standardizing Source Skeleton (Right Side)...")

        for key in config.keys():
            if "arm" in key or "leg" in key:
                data = config[key]
                base_start = data["start"]

                # 目标名字
                r_target = f"R_{base_start}"

                # 如果已经规范化，跳过
                if cmds.objExists(r_target):
                    continue

                # 如果存在原始无前缀骨骼，重命名
                if cmds.objExists(base_start):
                    print(f"  -> Renaming source hierarchy: {base_start} -> {r_target}")
                    name.rename_hierarchy(base_start, prefix="R_")

    def mirror_setup(self, config: Dict):
        """
        [步骤2] 镜像骨骼 (R -> L)。
        """
        print("[Build] Mirroring Skeleton (R -> L)...")

        targets = []
        for key in config.keys():
            if "arm" in key or "leg" in key:
                # 此时场景里应该是 R_...
                raw_name = config[key]["start"]
                if raw_name.startswith("R_"):
                    targets.append(raw_name)
                else:
                    targets.append(f"R_{raw_name}")

        targets = list(set(targets))

        for r_name in targets:
            if r_name.startswith("R_"):
                l_name = r_name.replace("R_", "L_", 1)
            else:
                continue

            # 如果右侧存在且左侧不存在，则镜像
            if cmds.objExists(r_name) and not cmds.objExists(l_name):
                print(f"  -> Mirroring {r_name} to {l_name}")
                new_joints = cmds.mirrorJoint(r_name, mirrorYZ=True, mirrorBehavior=True, searchReplace=("R_", "L_"))
                # 修正镜像后的根骨骼命名 (Maya 有时会出错)
                if new_joints and new_joints[0] != l_name:
                    try: cmds.rename(new_joints[0], l_name)
                    except: pass

    def create_main_system(self, root_joint_name: str):
        """
        [步骤4] MainSystem 构建。
        """
        print(f"[Build] Creating Main System for Root: {root_joint_name}")

        main_ctrl = "Main_ctrl"
        main_sys_grp = self.groups["main_sys"]
        fk_sys_grp = self.groups["fk_sys"]

        # 1. 创建控制器
        if not cmds.objExists(main_ctrl):
            cmds.circle(n=main_ctrl, nr=(0, 1, 0), r=15, ch=False)
            cmds.setAttr(f"{main_ctrl}.overrideEnabled", 1)
            cmds.setAttr(f"{main_ctrl}.overrideColor", 17)
            self._safe_parent(main_ctrl, main_sys_grp)

        # 2. 约束 Root 骨骼
        if cmds.objExists(root_joint_name):
            # 强制解锁
            attribute.unlock_transform(root_joint_name)

            # 检查是否已有约束 (防止与 FK 冲突)
            has_constraints = cmds.listConnections(root_joint_name, type="constraint", source=True, destination=False)
            skip_rot = ["x", "y", "z"] if has_constraints else []

            try:
                cmds.parentConstraint(main_ctrl, root_joint_name, maintainOffset=True, skipRotate=skip_rot)
            except Exception as e:
                print(f"  Warning: Main -> Root constraint issue: {e}")

        # 3. 约束 FKSystem (让全身 FK 跟随 Main 移动)
        if cmds.objExists(fk_sys_grp):
            try:
                cmds.parentConstraint(main_ctrl, fk_sys_grp, maintainOffset=True)
            except Exception as e:
                print(f"  Warning: Main -> FKSystem constraint issue: {e}")

    def build_spine(self, joint_names: List[str]):
        """
        [步骤3] 构建脊柱 FK。
        """
        print(f"[Build] Generating Spine FK for: {joint_names}")

        parent_ctl_transform = None
        current_parent = self.groups["fk_sys"]

        for i, jnt_name in enumerate(joint_names):
            fk_ctl_obj = fk.add_fk(jnt_name, radius=3.0)

            if fk_ctl_obj:
                ctl_grp = fk_ctl_obj.offset_group
                ctl_name = fk_ctl_obj.name

                if i == 0:
                    self._safe_parent(ctl_grp, current_parent)
                else:
                    self._safe_parent(ctl_grp, parent_ctl_transform)

                parent_ctl_transform = ctl_name

    def build_limb(self, start_joint: str, end_joint: str, side: str = "L", config_data: Dict = None):
        """
        [步骤5] 构建四肢 (IK/FK)。
        """
        print(f"[Build] Generating Limb ({side}) for: {start_joint} -> {end_joint}")

        if not cmds.objExists(start_joint) or not cmds.objExists(end_joint):
            print(f"  Error: Joints not found {start_joint}, {end_joint}")
            return

        # 读取拉伸选项
        enable_stretchy = False
        if config_data and "stretchy" in config_data:
            enable_stretchy = config_data["stretchy"]

        try:
            # 创建系统
            system = ikfk.create_ikfk_system(
                start_bone_name=start_joint,
                end_bone_name=end_joint,
                ik_suffix="_ik",
                fk_suffix="_fk",
                enable_stretchy=enable_stretchy
            )

            if not system: return

            # --- 归位逻辑 ---

            # FK 归位 -> FKSystem
            fk_root_bone = system.fk_chain[0]
            fk_root_ctrl_grp = f"grp_{fk_root_bone}_fk_ctrl"
            if cmds.objExists(fk_root_ctrl_grp):
                self._safe_parent(fk_root_ctrl_grp, self.groups["fk_sys"])

            # IK 归位 -> IKSystem
            ik_end_bone = system.ik_chain[-1]
            ik_ctrl = f"{ik_end_bone}_ik_ctrl"
            if cmds.objExists(ik_ctrl):
                parents = cmds.listRelatives(ik_ctrl, parent=True)
                if parents:
                    self._safe_parent(parents[0], self.groups["ik_sys"])

            # Switch 归位 -> FKIKSystem
            if system.switch_control:
                self._safe_parent(system.switch_control, self.groups["fkik_sys"])

            print(f"[Build] Success: {side} limb built.")

        except Exception as e:
            print(f"[Build] Error: {e}")
            traceback.print_exc()

    def connect_limbs_to_spine(self, config: Dict):
        """
        [步骤6] 连接四肢到脊柱。
        """
        print("[Build] Connecting Limbs to Spine...")

        if "spine" not in config or not config["spine"]: return
        chest_bone = config["spine"][-1]
        chest_ctrl = f"{chest_bone}_fk_ctrl"

        if not cmds.objExists(chest_ctrl): return

        for key in config.keys():
            if "arm" in key:
                data = config[key]
                base_start = data["start"]
                is_left = key.lower().startswith("l")

                # 解析实际骨骼名 (R_Shoulder / L_Shoulder)
                real_start = self._resolve_name(base_start, is_left)

                # 推断 FK Offset 组名
                # ikfk 生成: L_Shoulder_fk
                # fk 生成: grp_L_Shoulder_fk_fk_ctrl
                fk_bone_name = f"{real_start}_fk"
                fk_offset_grp = f"grp_{fk_bone_name}_fk_ctrl"

                if not cmds.objExists(fk_offset_grp):
                    # Fallback 尝试
                    fk_offset_grp = f"grp_{real_start}_fk_ctrl"

                if cmds.objExists(fk_offset_grp):
                    # 创建 Driver Group 层级
                    driver_grp = f"driver_{fk_offset_grp}"
                    if not cmds.objExists(driver_grp):
                        cmds.group(empty=True, name=driver_grp)
                        cmds.matchTransform(driver_grp, fk_offset_grp)

                        self._safe_parent(driver_grp, self.groups["fk_sys"])
                        self._safe_parent(fk_offset_grp, driver_grp)

                        try:
                            cmds.parentConstraint(chest_ctrl, driver_grp, maintainOffset=True)
                            print(f"  Connected: {chest_ctrl} -> {driver_grp}")
                        except: pass

    def _resolve_name(self, name, is_left):
        """名称解析辅助函数"""
        prefix = "L_" if is_left else "R_"

        if name.startswith("R_") or name.startswith("L_"):
            if is_left: return name.replace("R_", "L_")
            else: return name.replace("L_", "R_")

        return f"{prefix}{name}"

    def build_all(self, config: Dict):
        """主执行流程"""
        print("="*60)
        print(">>> STARTING AUTO RIG BUILD")
        print("="*60)

        # 0. 补全配置
        full_config = self._expand_config_to_both_sides(config)

        # 1. 场景 & 骨骼准备
        self.prepare_scene()
        self.standardize_source_skeleton(full_config)
        self.mirror_setup(full_config)

        # 2. 脊柱
        if "spine" in full_config:
            self.build_spine(full_config["spine"])

        # 3. Main
        if "spine" in full_config and len(full_config["spine"]) > 0:
            self.create_main_system(full_config["spine"][0])

        # 4. 四肢
        for key in ["l_arm", "r_arm", "l_leg", "r_leg"]:
            if key in full_config:
                data = full_config[key]
                side_str = "L" if key.lower().startswith("l") else "R"

                real_start = self._resolve_name(data["start"], side_str == "L")
                real_end = self._resolve_name(data["end"], side_str == "L")

                self.build_limb(real_start, real_end, side_str, config_data=data)

        # 5. 连接
        self.connect_limbs_to_spine(full_config)

        # 6. 整理
        if cmds.objExists("Geometry") and cmds.objExists(self.groups["geo"]):
             self._safe_parent("Geometry", self.groups["geo"])

        cmds.select(clear=True)
        print("="*60)
        print(">>> RIG BUILD COMPLETE")
        print("="*60)

# 测试入口
def run_build_test():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    json_path = os.path.join(current_dir, 'rig_config.json')

    if not os.path.exists(json_path):
        cmds.error(f"Config file not found: {json_path}")
        return

    try:
        with open(json_path, 'r', encoding='utf-8') as f:
            rig_config = json.load(f)
    except Exception as e:
        cmds.error(f"Failed to load JSON: {e}")
        return

    builder = RigBuilder()
    builder.build_all(rig_config)

if __name__ == "__main__":
    run_build_test()