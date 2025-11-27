# core/rigging/build_plan.py
# -*- coding: utf-8 -*-
"""
build_plan.py
定义了 BuildPlan 和 BuildAction 的数据结构，以及它们的序列化/反序列化逻辑。
"""

from __future__ import annotations  # 允许在类内部使用自身的类型提示
from typing import List, Dict, Optional, Any
import os

# 导入我们的文件处理器
from utils import json_handler


class BuildAction(object):
    """
    一个数据类，代表一个独立的绑定构建步骤。
    例如：创建一个IKFK系统，从'L_Arm_Shoulder'到'L_Arm_Wrist'。
    """

    def __init__(self, build_type: str, label1: str, label2: Optional[str] = None):
        """
        初始化一个构建动作。

        Args:
            build_type (str): 构建的类型 (例如: 'ikfk', 'stretchy', 'fk')。
            label1 (str): 第一个关键骨骼的标签 (例如: 起始骨骼)。
            label2 (Optional[str]): 第二个关键骨骼的标签 (例如: 末端骨骼)，对于某些类型是可选的。
        """
        self.build_type = build_type
        self.label1 = label1
        self.label2 = label2

    def __repr__(self) -> str:
        """提供一个清晰的字符串表示形式，用于调试。"""
        return f"BuildAction(type='{self.build_type}', labels=('{self.label1}', '{self.label2}'))"

    def to_dict(self) -> Dict[str, Any]:
        """将此对象实例转换为一个可以被JSON序列化的字典。"""
        return {
            "build_type": self.build_type,
            "label1": self.label1,
            "label2": self.label2,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> BuildAction:
        """从字典数据创建一个 BuildAction 实例。"""
        return cls(
            build_type=data.get("build_type", "Unknown"),
            label1=data.get("label1"),
            label2=data.get("label2"),
        )


class BuildPlan(object):
    """
    一个数据类，代表一个完整的绑定构建方案。
    它包含一个名称和一系列的 BuildAction。
    """

    def __init__(self, name: str, file_path: Optional[str] = None):
        """
        初始化一个构建方案。

        Args:
            name (str): 此构建方案的名称 (例如: 'Biped_Standard')。
            file_path (Optional[str]): 此方案关联的文件路径。
        """
        self.name = name
        self.file_path = file_path
        self.build_actions: List[BuildAction] = []

    def __repr__(self) -> str:
        return f"BuildPlan(name='{self.name}', actions={len(self.build_actions)})"

    def add_action(self, build_type: str, label1: str, label2: Optional[str] = None):
        """向方案中添加一个新的构建动作。"""
        action = BuildAction(build_type, label1, label2)
        self.build_actions.append(action)
        print(f"已添加动作: {action}")

    def to_dict(self) -> Dict[str, Any]:
        """将整个 BuildPlan 对象（包括所有子Action）转换为一个字典。"""
        return {
            "plan_name": self.name,
            "build_actions": [action.to_dict() for action in self.build_actions]
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any], file_path: Optional[str] = None) -> BuildPlan:
        """从字典数据创建一个完整的 BuildPlan 实例。"""
        plan = cls(
            name=data.get("plan_name", "Unnamed Plan"),
            file_path=file_path
        )
        actions_data = data.get("build_actions", [])
        plan.build_actions = [BuildAction.from_dict(action_data) for action_data in actions_data]
        return plan

    def save(self, file_path: str) -> bool:
        """
        将当前的构建方案保存到指定的JSON文件中。

        Args:
            file_path (str): 目标文件的完整路径。

        Returns:
            bool: 是否保存成功。
        """
        data = self.to_dict()
        success = json_handler.save_to_json(data, file_path)
        if success:
            self.file_path = file_path
        return success

    @classmethod
    def load(cls, file_path: str) -> Optional[BuildPlan]:
        """
        从一个JSON文件加载并创建一个 BuildPlan 实例。

        Args:
            file_path (str): 源文件的完整路径。

        Returns:
            Optional[BuildPlan]: 如果加载成功，返回一个 BuildPlan 实例，否则返回 None。
        """
        data = json_handler.load_from_json(file_path)
        if data:
            return cls.from_dict(data, file_path=file_path)
        return None


### --- 独立测试代码 / Independent Test Usage --- ###
def run_build_plan_test():
    """一个独立的函数，用于测试 BuildPlan 的创建、保存和加载功能。"""
    print("--- 1. 正在创建一个新的 BuildPlan ---")
    my_plan = BuildPlan(name="Humanoid_Default")

    print("\n--- 2. 正在向方案中添加构建动作 ---")
    my_plan.add_action(build_type="ikfk", label1="L_Arm_Shoulder", label2="L_Arm_Wrist")
    my_plan.add_action(build_type="ikfk", label1="R_Arm_Shoulder", label2="R_Arm_Wrist")
    my_plan.add_action(build_type="stretchy", label1="C_Spine_01", label2="C_Spine_05")
    my_plan.add_action(build_type="fk", label1="C_Head")  # 示例：一个只需要一个label的动作

    print(f"\n当前方案: {my_plan}")

    # --- 3. 保存方案到文件 ---
    # 定义一个临时文件路径用于测试
    test_dir = os.path.join(os.path.expanduser("~"), "maya_build_plan_test")
    test_file_path = os.path.join(test_dir, f"{my_plan.name}.json")

    print(f"\n--- 3. 正在将方案保存到: {test_file_path} ---")
    save_success = my_plan.save(test_file_path)

    if not save_success:
        print("测试失败: 保存文件时出错。")
        return

    # --- 4. 从文件加载方案 ---
    print(f"\n--- 4. 正在从文件加载方案 ---")
    loaded_plan = BuildPlan.load(test_file_path)

    # --- 5. 验证加载的数据 ---
    print("\n--- 5. 验证加载的数据 ---")
    if not loaded_plan:
        print("测试失败: 加载返回了 None。")
        return

    print(f"加载的方案: {loaded_plan}")

    # 验证名称
    if loaded_plan.name == my_plan.name:
        print("  - 名称验证: 成功")
    else:
        print(f"  - 名称验证: 失败 (期望: {my_plan.name}, 得到: {loaded_plan.name})")

    # 验证动作数量
    if len(loaded_plan.build_actions) == len(my_plan.build_actions):
        print("  - 动作数量验证: 成功")
    else:
        print(f"  - 动作数量验证: 失败 (期望: {len(my_plan.build_actions)}, 得到: {len(loaded_plan.build_actions)})")

    # 验证其中一个动作的内容
    if loaded_plan.build_actions[0].build_type == "ikfk" and loaded_plan.build_actions[0].label2 == "L_Arm_Wrist":
        print("  - 动作内容验证: 成功")
    else:
        print(f"  - 动作内容验证: 失败 (检查第一个动作的内容)")

    print("\n测试完成。")
