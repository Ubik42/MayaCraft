"""
core/rigging/build.py

自动绑定构建逻辑的主入口 (Auto Rig Orchestrator)。
负责编排整个骨架的构建过程，利用 BoneManager 查找骨骼，
并调用 fk/ik/ikfk 模块生成组件，最后整理层级。

前提：场景中的骨骼名称必须是唯一的 (Short Name Unique)。
"""

import maya.cmds as cmds
from typing import List, Dict, Optional
import traceback

# 导入核心模块
from core.rigging import bone
from core.rigging import fk
from core.rigging import ikfk
from core import name

class RigBuilder:
    """
    自动绑定构建器。
    """

    def __init__(self):
        # 1. 初始化并扫描骨骼
        # 基于简化版 BoneManager，这里建立的是 短名 -> Bone 映射
        self.bone_manager = bone.BoneManager()
        self.bone_manager.scan_scene()

        # 2. 定义标准组结构
        self.rig_groups = {
            "main": "Rig_Grp",
            "geometry": "Geometry_Grp",
            "skeleton": "Skeleton_Grp",
            "controls": "Controls_Grp",
            "extras": "Extras_Grp"
        }

        # 运行时缓存
        self.master_ctrl: Optional[str] = None

    def _safe_parent(self, child: str, parent: str):
        """
        安全的父子约束：防止重复约束或对象不存在导致的报错。
        """
        if not child or not parent:
            return

        if not cmds.objExists(child) or not cmds.objExists(parent):
            # 只有当关键对象缺失时才打印警告
            # print(f"[Build] Warning: Cannot parent '{child}' to '{parent}'. Object missing.")
            return

        # 检查 child 是否已经是 parent 的直接子物体
        current_parents = cmds.listRelatives(child, parent=True)
        if current_parents and current_parents[0] == parent:
            return # 已经是了，跳过

        try:
            cmds.parent(child, parent)
        except Exception as e:
            # 忽略一些良性的 Maya 错误
            print(f"[Build] Warning: Parenting failed ({child} -> {parent}): {e}")

    def prepare_scene(self):
        """
        初始化场景组结构。
        """
        # 创建主组
        if not cmds.objExists(self.rig_groups["main"]):
            cmds.createNode("transform", name=self.rig_groups["main"])

        # 创建子组
        for key, grp_name in self.rig_groups.items():
            if key == "main": continue
            if not cmds.objExists(grp_name):
                cmds.createNode("transform", name=grp_name, parent=self.rig_groups["main"])

                # 锁定 Skeleton_Grp，防止误操作
                if key == "skeleton":
                    cmds.setAttr(f"{grp_name}.overrideEnabled", 1)
                    cmds.setAttr(f"{grp_name}.overrideDisplayType", 2) # Reference mode

    def create_master_control(self):
        """
        创建全局主控制器 (Master/Global)。
        """
        self.master_ctrl = "Master_Ctrl"

        if not cmds.objExists(self.master_ctrl):
            # 创建一个简单的圆圈作为 Master
            ctl = cmds.circle(n=self.master_ctrl, nr=(0, 1, 0), r=10, ch=False)[0]

            # 标记颜色 (黄色)
            cmds.setAttr(f"{ctl}.overrideEnabled", 1)
            cmds.setAttr(f"{ctl}.overrideColor", 17)

            # 将 Master 放入 Controls_Grp
            if cmds.objExists(self.rig_groups["controls"]):
                self._safe_parent(ctl, self.rig_groups["controls"])

        return self.master_ctrl

    def build_spine(self, joint_names: List[str]):
        """
        构建脊柱 (FK Chain)。
        Args:
            joint_names: 有序的骨骼名称列表 (e.g. ['Root', 'Spine1', ...])
        """
        print(f"[Build] Generating Spine FK for: {joint_names}")

        parent_ctl_transform = None
        current_parent = self.master_ctrl

        for i, jnt_name in enumerate(joint_names):
            # 使用 BoneManager 查找骨骼 (传入短名即可)
            bone_obj = self.bone_manager.get_bone(jnt_name)

            if not bone_obj:
                print(f"[Build] Error: Bone '{jnt_name}' not found. Stopping Spine build at this node.")
                break

            # 生成 FK 控制器
            # radius=3.0 让脊柱控制器稍微大一点
            fk_ctl_obj = fk.add_fk(bone_obj, radius=3.0, color_index=17)

            if fk_ctl_obj:
                ctl_grp = fk_ctl_obj.offset_group
                ctl_name = fk_ctl_obj.name

                # 处理层级连接
                if i == 0:
                    # 根部连到 Master
                    self._safe_parent(ctl_grp, current_parent)
                else:
                    # 后续连到上一个控制器
                    self._safe_parent(ctl_grp, parent_ctl_transform)

                parent_ctl_transform = ctl_name

    def build_limb(self, start_joint: str, end_joint: str, side: str = "L"):
        """
        构建四肢 (IK/FK 自动切换系统)。
        """
        print(f"[Build] Generating Limb ({side}) for: {start_joint} -> {end_joint}")

        # 1. 验证骨骼是否存在
        bone_start = self.bone_manager.get_bone(start_joint)
        bone_end = self.bone_manager.get_bone(end_joint)

        if not bone_start or not bone_end:
            print(f"[Build] Error: Cannot find start bone '{start_joint}' or end bone '{end_joint}'. Skipping.")
            return

        # 2. 调用 ikfk 核心逻辑
        try:
            # 关键：直接传入 bone_start.name (现在它是短名，例如 "joint1")
            # ikfk.py 会用它拼接字符串 "joint1_ik"，不会再有非法字符错误
            system = ikfk.create_ikfk_system(
                start_bone_name=bone_start.name,
                end_bone_name=bone_end.name,
                ik_suffix="_ik",
                fk_suffix="_fk"
            )

            if system:
                # 成功后，将 Switch 控制器归组
                if hasattr(system, 'switch_control') and system.switch_control:
                    if cmds.objExists(system.switch_control):
                        # 通常放在 Extras 或 Controls 组
                        self._safe_parent(system.switch_control, self.rig_groups["extras"])

                print(f"[Build] Success: Created IK/FK system for {side} limb.")
            else:
                print(f"[Build] Failed: ikfk.create_ikfk_system returned None.")

        except Exception as e:
            print(f"[Build] Critical Error building limb {side}: {str(e)}")
            traceback.print_exc()

    def build_all(self, config: Dict):
        """
        执行完整构建流程。

        Config 格式示例:
        {
            "spine": ["Root", "Spine1", "Spine2", "Chest"],
            "l_arm": {"start": "L_Shoulder", "end": "L_Wrist"},
            "r_arm": {"start": "R_Shoulder", "end": "R_Wrist"},
            ...
        }
        """
        print("="*60)
        print(">>> STARTING AUTO RIG BUILD")
        print("="*60)

        # 1. 准备环境
        self.prepare_scene()
        self.create_master_control()

        # 2. 构建脊柱 (FK)
        if "spine" in config:
            self.build_spine(config["spine"])

        # 3. 构建四肢 (IK/FK)
        limb_keys = ["l_arm", "r_arm", "l_leg", "r_leg"]

        for key in limb_keys:
            if key in config:
                data = config[key]
                # 简单的判断左右侧逻辑 (根据Key名称)
                side = "L" if key.startswith("l") else "R"

                self.build_limb(
                    start_joint=data["start"],
                    end_joint=data["end"],
                    side=side
                )

        # 4. 最终清理
        cmds.select(clear=True)
        print("="*60)
        print(">>> RIG BUILD COMPLETE")
        print("="*60)


# ========================================================
# 开发测试入口
# ========================================================
def run_build_test():
    """
    测试函数。
    """
    # 示例配置：请确保场景中存在这些名字的骨骼（短名唯一）
    rig_config = {
        "spine": ["joint1", "joint2", "joint3"],
        "l_arm": {"start": "joint4", "end": "joint6"},
    }

    builder = RigBuilder()
    builder.build_all(rig_config)

if __name__ == "__main__":
    run_build_test()