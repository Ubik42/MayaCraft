# core/rigging/module/base.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds


class BaseRigModule:
    """
    所有绑定模块的基类 (无 Side 版)。
    """

    def __init__(self, builder, mapping_data: dict):
        """
        Args:
            builder: 主 RigBuilder 实例 (提供全局接口、组结构访问)
            mapping_data: 字典 {'Hand': '|Long|Path|To|L_Hand', 'Shoulder': ...}
        """
        self.builder = builder
        self.mapping = mapping_data

        # 模块内部产生的关键对象，用于给其他模块连接
        self.pins = {}

    def get_joint(self, label_key: str) -> str:
        """
        快捷获取当前模块对应的骨骼名 (长路径)。
        """
        return self.mapping.get(label_key)

    def get_short_name(self, label_key: str) -> str:
        """
        [新增] 快捷获取骨骼短名 (用于日志打印或命名)。
        例如: 获取 'Shoulder' -> 返回 'L_Shoulder_Jnt'
        """
        full_name = self.mapping.get(label_key)
        if full_name:
            return full_name.split('|')[-1]
        return "Unknown"

    def validate(self):
        """
        (可选) 检查骨骼是否齐全。
        """
        return True

    def build(self):
        """
        [阶段1] 构建系统内部逻辑。
        创建 IK 手柄、控制器、内部约束。
        """
        pass

    def connect(self):
        """
        [阶段2] 外部连接。
        例如：手臂寻找脊柱接口进行连接。
        此阶段在所有模块 build() 完成后执行。
        """
        pass

    # --- 辅助 ---

    def register_pin(self, pin_alias: str, node: str):
        """
        将模块内的某个节点注册为公共接口。
        建议 pin_alias 包含骨骼名以保证唯一性。
        """
        self.builder.register_interface(pin_alias, node)