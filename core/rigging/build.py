# core/rigging/build.py
# -*- coding: utf-8 -*-
import traceback
from functools import partial

# Import Factory
import core.rigging.ik_label as rig_module
import core.rigging.attribute as attribute_pkg

# Import Base System
from core.rigging.base import RigTask

# Import Build Functions
import core.rigging.build_func.build_structure as build_structure
import core.rigging.build_func.build_joint as build_joint
import core.rigging.build_func.build_main as build_main
import core.rigging.build_func.build_base_fk as build_base_fk
import core.rigging.build_func.build_utils as build_utils


class RigBuilder:  # Mixin/Inherit RigTask for get_priority helper? Or just add method
    def get_priority(self, key, default):
        from core.rigging.base import PriorityConfig

        return PriorityConfig.get(key, default)

    def __init__(self):

        #暂时还是需要放在这
        self.groups = {}
        self.groups = {
            "main": "Group",
            "geo": "Geometry_Grp",
            "ctrl": "Controls_Grp",
            "main_sys": "MainSystem",
            "root_sys": "RootSystem",
            "global_sys": "GlobalSystem",
            "fk_sys": "FKSystem",
            "ik_sys": "IKSystem",
            "ik_joints": "IKJoints",
            "ik_handle": "IKHandle",
            "ik_pv": "IKPoleVector",
            "fkik_sys": "FKIKSystem",
            "driving_sys": "DrivingSystem",
            "aim_sys": "AimSystem",
            "bend_sys": "BendSystem",
            "twist_sys": "TwistSystem",
            "constraint_sys": "ConstraintSystem",
            "dynamic_sys": "DynamicSystem",
            "build_pose": "buildPose",
        }

        # 存储运行时数据
        self.active_modules = []
        self.active_attributes = []

        # 任务队列
        self.task_queue = []
        self.ui_config_ref = None  # 前端传来的原始数据
        self.processed_config = {} # 处理骨骼后的数据
        #TODO 这个弱智功能后面要完全去掉
        self.node_map = {}  # Source (Short) -> Deform (Long) map


    # --- 核心构建流 ---

    def build_all(self, ui_config=None):
        """主执行流程: Task Based"""
        print("=" * 60)
        print(">>> STARTING BUILD SEQUENCE (TASK BASED)")
        print("=" * 60)

        self.task_queue = []

        self.ui_config_ref = ui_config

        # 1. 场景结构
        self.task_queue.append(
            RigTask(
                self.get_priority("task_structure", 0),
                build_structure.build_scene_structure,
                "Setup Scene Structure",
            )
        )

        # 2. 实例化 RigObject 并收集任务
        self.task_queue.append(
            RigTask(
                self.get_priority("task_instantiate", 5),
                self._task_instantiate_and_collect,
                "Instantiate Modules & Attributes",
            )
        )

        # 3. 骨骼处理
        self.task_queue.append(
            RigTask(
                self.get_priority("task_build_joint", 10),
                partial(build_joint.process_skeleton, self, ui_config),
                "Build Skeleton",
            )
        )

        # 4. Base FK系统
        self.task_queue.append(
            RigTask(
                self.get_priority("task_base_fk", 15),
                partial(build_base_fk.build_base_fk, self.groups),
                "Build Base FK",
            )
        )

        # 5. Controller Set
        self.task_queue.append(
            RigTask(
                self.get_priority("task_controller_set", 999),
                partial(build_utils.create_controller_set, self.groups),
                "Create Controller Sets",
            )
        )

        # 执行循环
        executed_count = 0
        while self.task_queue:
            #健壮但是没效率的写法
            self.task_queue.sort(key=lambda t: t.priority)
            current_task = self.task_queue.pop(0)

            print(f"--- [Task {current_task.priority}] {current_task.name} ---")
            try:
                current_task.run()
                executed_count += 1
            except Exception as e:
                print(f"[ERROR] Task '{current_task.name}' failed: {e}")
                traceback.print_exc()
                pass

        print("=" * 60)
        print(f">>> BUILD COMPLETE ({executed_count} Tasks Executed)")
        print("=" * 60)

    # --- 动态任务生成，生成类实例传参方法不一样，生成后收集任务方法一样的 ---

    def _task_instantiate_and_collect(self):
        """实例化模块和属性，并请求它们的任务"""
        print(">>> Instantiating Rig Objects...")

        # 1. Instantiate Modules & Attributes
        # Unified instantiation from processed_config
        # 1. Instantiate Modules & Attributes
        # Prioritize processed_config (Deform), fallback to ui_config (Source)
        config_source = (
            self.processed_config if self.processed_config else self.ui_config_ref
        )

        if config_source:
            for label_name, instances_list in config_source.items():
                for mapping in instances_list:
                    # Try creating as IK/Rig Module
                    mod = rig_module.create_module(label_name, self, mapping)
                    if mod:
                        if hasattr(mod, "create_tasks"):
                            self.active_modules.append(mod)
                        continue  # Found as module, next instance

                    # Try creating as Attribute
                    attr = attribute_pkg.create_attribute(label_name, self, mapping)
                    if attr:
                        if hasattr(attr, "create_tasks"):
                            self.active_attributes.append(attr)
                        continue  # Found as attribute

                    print(f"[Build] Warning: No factory found for '{label_name}'")

        # 3. Collect Tasks
        for obj in self.active_modules + self.active_attributes:
            new_tasks = obj.create_tasks(self)
            if new_tasks:
                self.task_queue.extend(new_tasks)


# 入口
def run_build_test(ui_data=None):
    builder = RigBuilder()
    builder.build_all(ui_config=ui_data)
