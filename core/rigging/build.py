# core/rigging/build.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
import traceback

# 导入模块工厂
import core.rigging.module as rig_module
# 导入骨骼处理模块
import core.rigging.build_joint as build_joint
# 导入基础 FK 构建逻辑
import core.rigging.build_fk as build_fk

from core import tool


class RigBuilder:
    def __init__(self):
        # 1. 定义标准组结构配置
        self.groups = {
            "main": "Group",
            "geo": "Geometry_Grp",
            "ctrl": "Controls_Grp",
            "main_sys": "MainSystem",
            "root_sys": "RootSystem",
            "global_sys": "GlobalSystem",
            "fk_sys": "FKSystem",
            "ik_sys": "IKSystem",
            "fkik_sys": "FKIKSystem",
            "driving_sys": "DrivingSystem",
            "aim_sys": "AimSystem",
            "bend_sys": "BendSystem",
            "twist_sys": "TwistSystem",
            "constraint_sys": "ConstraintSystem",
            "dynamic_sys": "DynamicSystem",
            "build_pose": "buildPose"
        }

        # 存储运行时数据
        self.active_modules = []
        self.interfaces = {}

    # --- 基础接口 ---

    def register_interface(self, name, node):
        """供子模块调用，注册公共接口"""
        self.interfaces[name] = node
        print(f"[Interface] Registered: {name} -> {node}")

    def get_interface(self, name):
        """供子模块调用，获取公共接口"""
        return self.interfaces.get(name)

    # --- 构建任务 ---

    def _task_setup_scene_structure(self):
        """建立完整的场景组结构"""
        print(">>> Setting up scene structure...")

        if not cmds.objExists(self.groups["main"]):
            cmds.createNode("transform", name=self.groups["main"])

        for key in ["geo", "ctrl"]:
            grp_name = self.groups[key]
            if not cmds.objExists(grp_name):
                cmds.createNode("transform", name=grp_name)
            tool.safe_parent(grp_name, self.groups["main"])

        exclude_keys = ["main", "geo", "ctrl"]
        ctrl_grp = self.groups["ctrl"]

        for key, grp_name in self.groups.items():
            if key in exclude_keys:
                continue
            if not cmds.objExists(grp_name):
                cmds.createNode("transform", name=grp_name)
            tool.safe_parent(grp_name, ctrl_grp)

    def _task_create_main_root(self, processed_config):
        """创建 Main 和 Root 控制器"""
        main_ctrl = "Main_ctrl"
        root_ctrl = "Root_ctrl"

        # 1. Main Ctrl
        if not cmds.objExists(main_ctrl):
            cmds.circle(n=main_ctrl, nr=(0, 1, 0), r=20, ch=False)
            cmds.setAttr(f"{main_ctrl}.overrideEnabled", 1)
            cmds.setAttr(f"{main_ctrl}.overrideColor", 17)  # 黄色

            tool.safe_parent(main_ctrl, self.groups["main_sys"])
            self.register_interface("Main_Ctrl", main_ctrl)

            exclude_grps = [self.groups["main_sys"], self.groups["geo"], self.groups["ctrl"], self.groups["main"]]
            for key, grp_name in self.groups.items():
                if grp_name in exclude_grps:
                    continue
                if cmds.objExists(grp_name):
                    if not cmds.listConnections(grp_name, type="parentConstraint"):
                        cmds.parentConstraint(main_ctrl, grp_name, maintainOffset=True)

        # 2. Root Ctrl
        root_jnt = None
        # 尝试从处理后的配置找
        if processed_config and "IK Spine" in processed_config and processed_config["IK Spine"]:
            root_jnt = processed_config["IK Spine"][0].get("Root")

        # 备选：如果在 Geometry_Grp 发现了新生成的骨骼，则取最顶层
        if not root_jnt or not cmds.objExists(root_jnt):
            geo_children = cmds.listRelatives(self.groups["geo"], children=True, type="joint", fullPath=True)
            if geo_children:
                root_jnt = geo_children[0]

        if root_jnt and cmds.objExists(root_jnt) and not cmds.objExists(root_ctrl):
            cmds.circle(n=root_ctrl, nr=(0, 1, 0), r=15, ch=False)
            cmds.setAttr(f"{root_ctrl}.overrideEnabled", 1)
            cmds.setAttr(f"{root_ctrl}.overrideColor", 18)  # 浅蓝

            cmds.matchTransform(root_ctrl, root_jnt, pos=True, rot=False)
            tool.safe_parent(root_ctrl, main_ctrl)

            tool.unlock_transform(root_jnt, translate=True, rotate=True, scale=True, visibility=True)

            cmds.parentConstraint(root_ctrl, root_jnt, maintainOffset=True)
            cmds.scaleConstraint(root_ctrl, root_jnt, maintainOffset=True)

            self.register_interface("Root_Ctrl", root_ctrl)
            print(f"[Build] Root Control Created: {root_ctrl} -> {root_jnt}")

    def _task_build_base_fk(self):
        """调用 build_fk 生成基础 FK 系统"""
        print(">>> Building Base FK System...")
        try:
            build_fk.build(self)
        except Exception as e:
            print(f"Error building base FK: {e}")
            traceback.print_exc()

    def _instantiate_from_config(self, config_data):
        """根据配置实例化模块"""
        if not config_data:
            return

        print(f"[Build] Instantiating modules from processed config...")
        for module_name, instances_list in config_data.items():
            for mapping in instances_list:
                mod = rig_module.create_module(module_name, self, mapping)
                if mod:
                    self.active_modules.append(mod)

    def build_all(self, ui_config=None):
        """主执行流程"""
        print("=" * 60)
        print(">>> STARTING BUILD SEQUENCE")
        print("=" * 60)

        # 如果没有传入配置，初始化为空字典，确保 JointBuilder 能运行基础逻辑
        if ui_config is None:
            ui_config = {}

        # 1. 创建组结构 (无论是否有配置都执行)
        self._task_setup_scene_structure()

        # 2. 调用 JointBuilder 处理骨骼
        # 注意：即便 ui_config 为空，JointBuilder 也会复制骨骼并进行基础命名处理
        joint_builder = build_joint.JointBuilder(self.groups)
        processed_config = joint_builder.process_skeleton(ui_config)

        # 3. 创建全局控制器 (即使没有配置，也会尝试通过扫描 Geometry_Grp 寻找 Root)
        self._task_create_main_root(processed_config)

        # 4. 构建基础 FK 系统 (基于 Geometry_Grp 里的骨骼生成，不依赖配置)
        self._task_build_base_fk()

        # 5. 实例化模块 (如果有配置数据则执行)
        if processed_config:
            self._instantiate_from_config(processed_config)

        # 6. 模块排序与执行
        if self.active_modules:
            def sort_weight(mod):
                t = str(type(mod))
                if "Spine" in t: return 0
                if "Leg" in t or "Arm" in t: return 10
                return 20
            self.active_modules.sort(key=sort_weight)

            print(f"--- Building {len(self.active_modules)} Modules ---")
            for mod in self.active_modules:
                try:
                    mod.build()
                except Exception as e:
                    print(f"Error building module {mod}: {e}")
                    traceback.print_exc()

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
    # 现在 ui_data 为 None 时不再退出，而是继续执行基础构建
    builder = RigBuilder()
    builder.build_all(ui_config=ui_data)