# utils/json_handler.py
# -*- coding: utf-8 -*-
"""
json_handler.py
一个用于处理 JSON 文件读写的通用工具模块。
"""

import json
import os
from typing import Dict, Any, Optional


def save_to_json(data: Dict, file_path: str) -> bool:
    """
    将字典数据保存到指定的 JSON 文件中。

    如果文件的父目录不存在，会自动创建。

    Args:
        data (Dict): 需要被序列化为 JSON 的字典。
        file_path (str): 目标文件的完整路径。

    Returns:
        bool: 如果保存成功，返回 True，否则返回 False。
    """
    try:
        # 获取文件所在的目录
        dir_name = os.path.dirname(file_path)
        # 如果目录不存在，则创建它
        if not os.path.exists(dir_name):
            os.makedirs(dir_name)

        # 使用 'with' 语句安全地写入文件
        with open(file_path, 'w', encoding='utf-8') as f:
            # indent=4 使 JSON 文件格式化，更易于人类阅读
            json.dump(data, f, indent=4, ensure_ascii=False)
        print(f"数据成功保存到: {file_path}")
        return True
    except (IOError, TypeError) as e:
        print(f"错误: 无法将数据保存到 '{file_path}'.\n{e}")
        return False


def load_from_json(file_path: str) -> Optional[Dict]:
    """
    从指定的 JSON 文件中加载数据。

    Args:
        file_path (str): 源文件的完整路径。

    Returns:
        Optional[Dict]: 如果加载成功，返回包含文件内容的字典；
                        如果文件不存在或解析失败，返回 None。
    """

    if not os.path.exists(file_path):
        print(f"错误: 文件不存在 '{file_path}'")
        return None

    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        return data
    except (IOError, json.JSONDecodeError) as e:
        print(f"错误: 无法从 '{file_path}' 加载或解析JSON数据。\n{e}")
        return None