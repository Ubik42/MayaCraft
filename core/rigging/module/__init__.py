# core/rigging/module/__init__.py
# -*- coding: utf-8 -*-

from .ik_arm import IKArmModule
# from .ik_leg import IKLegModule
# from .ik_spine import IKSpineModule
# from .foot_roll import FootRollModule

# 注册表
MODULE_REGISTRY = {
    "IK Arm": IKArmModule,
    # "Foot Roll": FootRollModule,
}

def create_module(label_type, builder, mapping_data):
    """
    工厂函数：根据标签类型实例化对应模块 (已移除 side 参数)
    """
    module_class = MODULE_REGISTRY.get(label_type)
    if module_class:
        # 直接传入 builder 和 mapping
        return module_class(builder, mapping_data)
    else:
        print(f"[Module Factory] Warning: Module class not found for '{label_type}'")
        return None