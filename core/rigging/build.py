# core/rigging/build.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
import traceback

# 导入模块工厂
import core.rigging.module as rig_module
# 导入新的预处理系统
from core.rigging.pre_build import PreBuildSystem


class RigBuilder:
    def __init__(self):
        # 1. 定义标准组结构
        # 这些组名会传递给 PreBuildSystem 进行创建
        self.groups = {
            "main": "Group",
            "geo": "Geometry_Grp",
            "ctrl": "Controls_Grp",
            "main_sys": "MainSystem",
            "module_sys": "Modules_Grp",
            "fk_sys": "FKSystem_Grp",
            "ik_sys": "IKSystem_Grp"
        }

        # 存储运行时数据
        self.active_modules = []
        self.interfaces = {}

    # --- 基础工具 ---

    def safe_parent(self, child, parent):
        if child and parent and cmds.objExists(child) and cmds.objExists(parent):
            try:
                current_parent = cmds.listRelatives(child, parent=True)
                if current_parent and current_parent[0] == parent:
                    return
                cmds.parent(child, parent)
            except:
                pass

    def register_interface(self, name, node):
        """供子模块调用，注册公共接口 (如 Spine_Chest_Attach)"""
        self.interfaces[name] = node
        print(f"[Interface] Registered: {name} -> {node}")

    def get_interface(self, name):
        """供子模块调用，获取公共接口"""
        return self.interfaces.get(name)

    def _unlock_channels(self, node):
        """本地解锁工具，确保 Root 控制器可以约束骨骼"""
        if not cmds.objExists(node): return
        attrs = ['tx', 'ty', 'tz', 'rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']
        for attr in attrs:
            try:
                cmds.setAttr(f"{node}.{attr}", lock=False)
            except:
                pass

    # --- 构建任务 ---

    def _task_create_main_root(self, processed_config):
        """
        创建 Main 和 Root 控制器。
        注意：此时操作的是已经经过 PreBuild 处理过的 _M/_R 骨骼。
        """
        main_ctrl = "Main_ctrl"
        root_ctrl = "Root_ctrl"

        # 1. Main Ctrl
        if not cmds.objExists(main_ctrl):
            cmds.circle(n=main_ctrl, nr=(0, 1, 0), r=20, ch=False)
            cmds.setAttr(f"{main_ctrl}.overrideEnabled", 1)
            cmds.setAttr(f"{main_ctrl}.overrideColor", 17)  # 黄色

            self.safe_parent(main_ctrl, self.groups["main_sys"])
            self.register_interface("Main_Ctrl", main_ctrl)

            # 让所有系统组跟随 Main Ctrl
            for sys_key in ["fk_sys", "ik_sys", "module_sys"]:
                sys_grp = self.groups[sys_key]
                if cmds.objExists(sys_grp):
                    if not cmds.listConnections(sys_grp, type="parentConstraint"):
                        cmds.parentConstraint(main_ctrl, sys_grp, maintainOffset=True)

        # 2. Root Ctrl
        # 尝试从处理后的配置中找到 Root 骨骼 (通常是 _M 后缀)
        root_jnt = None
        if "IK Spine" in processed_config and processed_config["IK Spine"]:
            # 取脊柱模块的第一个实例的 Root 插槽
            root_jnt = processed_config["IK Spine"][0].get("Root")

        # 备选：如果在 GeoGroup 里找到了新生成的骨骼，取最顶层那个
        if not root_jnt:
            geo_children = cmds.listRelatives(self.groups["geo"], children=True, type="joint")
            if geo_children:
                root_jnt = geo_children[0]

        if root_jnt and cmds.objExists(root_jnt) and not cmds.objExists(root_ctrl):
            cmds.circle(n=root_ctrl, nr=(0, 1, 0), r=15, ch=False)
            cmds.setAttr(f"{root_ctrl}.overrideEnabled", 1)
            cmds.setAttr(f"{root_ctrl}.overrideColor", 18)  # 浅蓝

            # 匹配位置 & 约束
            cmds.matchTransform(root_ctrl, root_jnt, pos=True, rot=False)
            self.safe_parent(root_ctrl, main_ctrl)

            # 确保骨骼解锁 (双重保险)
            self._unlock_channels(root_jnt)

            cmds.parentConstraint(root_ctrl, root_jnt, maintainOffset=True)
            cmds.scaleConstraint(root_ctrl, root_jnt, maintainOffset=True)

            self.register_interface("Root_Ctrl", root_ctrl)
            print(f"[Build] Root Control Created: {root_ctrl} -> {root_jnt}")

    def _instantiate_from_config(self, config_data):
        """
        根据预处理后的配置实例化模块。
        config_data 格式: {"IK Arm": [{"Hand": "Hand_L", ...}, {"Hand": "Hand_R", ...}]}
        """
        print(f"[Build] Instantiating modules from processed config...")

        for module_name, instances_list in config_data.items():
            for mapping in instances_list:
                # 调用工厂创建模块 (不传 side，只传 mapping)
                print("mapping",mapping)
                mod = rig_module.create_module(module_name, self, mapping)
                if mod:
                    self.active_modules.append(mod)

    def build_all(self, ui_config=None):
        """主执行流程"""
        print("=" * 60)
        print(">>> STARTING BUILD SEQUENCE")
        print("=" * 60)

        if not ui_config:
            cmds.error("Build failed: No UI configuration data provided.")
            return

        # 1. 初始化预处理系统
        pre_builder = PreBuildSystem(self.groups)

        # 2. 创建组结构
        pre_builder.create_structure()

        # 3. [关键] 执行骨骼处理 (复制->重命名->镜像->生成新配置)
        # processed_config 包含了 _L, _R, _M 的新骨骼数据
        processed_config = pre_builder.process_skeleton(ui_config)

        if not processed_config:
            cmds.warning("Skeleton processing returned empty config. Build aborted.")
            return

        # 4. 创建全局控制器 (基于新骨骼)
        self._task_create_main_root(processed_config)

        # 5. 实例化各个功能模块
        self._instantiate_from_config(processed_config)

        # 6. 模块排序 (Spine -> Leg/Arm -> Foot/Hand)
        def sort_weight(mod):
            t = str(type(mod))
            if "Spine" in t: return 0
            if "Leg" in t or "Arm" in t: return 10
            return 20

        self.active_modules.sort(key=sort_weight)

        # 7. 构建阶段 (Build Phase)
        print(f"--- Building {len(self.active_modules)} Modules ---")
        for mod in self.active_modules:
            try:
                mod.build()
            except Exception as e:
                print(f"Error building module {mod}: {e}")
                traceback.print_exc()

        # 8. 连接阶段 (Connect Phase)
        print("--- Connecting Modules ---")
        for mod in self.active_modules:
            try:
                mod.connect()
            except Exception as e:
                print(f"Error connecting module {mod}: {e}")
                traceback.print_exc()

        cmds.select(clear=True)
        print("=" * 60)
        print(">>> BUILD COMPLETE")
        print("=" * 60)


# 测试入口
def run_build_test(ui_data=None):
    if ui_data is None:
        print("Test run requires UI data.")
        return
    builder = RigBuilder()
    builder.build_all(ui_config=ui_data)