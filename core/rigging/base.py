# core/rigging/base.py
# -*- coding: utf-8 -*-
from dataclasses import dataclass
from typing import Callable, List


@dataclass
class RigTask:
    """
    具体的绑定任务。
    由 RigBuilder 的任务管理器统一调度执行。
    """

    priority: float  # 优先级 (0-100)，越小越早执行
    run: Callable  # 执行函数
    name: str = "Unknown Task"  # 任务说明 (用于日志)


class RigObject:
    """
    所有绑定组件的接口。
    """

    def create_tasks(self, builder) -> List[RigTask]:
        """
        生成该对象需要执行的所有任务。
        Args:
            builder: RigBuilder 实例，用于访问场景信息或其他接口。
        Returns:
            List[RigTask]: 任务列表。
        """
        raise NotImplementedError("Subclasses must implement create_tasks")

    @classmethod
    def get_priority(cls, key: str, default: float) -> float:
        """
        从配置获取优先级。
        """
        return PriorityConfig.get(key, default)


class PriorityConfig:
    _data = None

    @classmethod
    def load(cls):
        if cls._data is not None:
            return

        import json
        import os

        # Assume priorities.json is in core/rigging/config/priorities.json
        # This file (base.py) is in core/rigging/base.py
        current_dir = os.path.dirname(os.path.abspath(__file__))
        config_path = os.path.join(current_dir, "config", "priorities.json")

        if os.path.exists(config_path):
            try:
                with open(config_path, "r") as f:
                    content = json.load(f)
                    cls._data = content.get("tasks", {})
            except Exception as e:
                print(f"[PriorityConfig] Error loading json: {e}")
                cls._data = {}
        else:
            print(f"[PriorityConfig] Warning: Config not found at {config_path}")
            cls._data = {}

    @classmethod
    def get(cls, key: str, default: float) -> float:
        cls.load()
        return cls._data.get(key, default)
