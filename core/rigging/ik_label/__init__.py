# core/rigging/ik_label/__init__.py
# -*- coding: utf-8 -*-

from .ik_arm import IKArmModule
from .ik_leg import IKLegModule
from .ik_spine import IKSpineModule

# 手动注册模块
_MODULES = {
    "IK Arm": IKArmModule,
    "IK Leg": IKLegModule,
    "IK Spine": IKSpineModule
}

def get_all_slots():
    """
    获取所有注册模块的插槽配置
    Returns:
        dict: { "Module Name": ["Slot1", "Slot2", ...], ... }
    """
    slots_config = {}
    for name, module_cls in _MODULES.items():
        if hasattr(module_cls, "SLOTS"):
            slots_config[name] = module_cls.SLOTS
        else:
            slots_config[name] = []
    return slots_config

def create_module(label_type, builder, mapping_data):
    """
    工厂函数：根据标签类型实例化模块
    """
    module_class = _MODULES.get(label_type)
    if module_class:
        return module_class(builder, mapping_data)
    else:
        print(f"[Module Factory] Warning: Module class not found for '{label_type}'")
        return None