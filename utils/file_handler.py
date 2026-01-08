# -*- coding: utf-8 -*-
"""
file_handler.py
处理文件和目录操作的通用工具模块。
"""

import os
import maya.cmds as cmds
from typing import List


def get_project_root() -> str:
    """
    获取当前Maya项目的工作区根目录。
    通过当前脚本文件的位置自动推断，不再依赖硬编码路径。

    假设结构:
    ProjectRoot/
      ├── utils/
      │    └── file_handler.py
      ├── files/
      └── ...
    """
    # 获取当前脚本 (file_handler.py) 的绝对路径
    current_script_path = os.path.abspath(__file__)

    # 获取 utils 目录
    utils_dir = os.path.dirname(current_script_path)

    # 获取项目根目录 (utils 的上一级)
    project_root = os.path.dirname(utils_dir)

    return project_root.replace('\\', '/')  # 统一使用正斜杠，避免Maya路径问题


def find_examples(sub_dir: str = "files/Rigged") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【示例成品】文件 (.mb)。

    假设结构为文件夹包裹文件:
    .../files/Rigged/Biped/Biped.mb
    """
    project_root = get_project_root()
    # 构建完整路径: ProjectRoot/files/Rigged
    examples_dir = os.path.join(project_root, sub_dir)

    found_examples = []
    if not os.path.isdir(examples_dir):
        # 如果目录不存在，打印警告方便调试，但返回空列表
        print(f"Warning: Examples directory not found: {examples_dir}")
        return found_examples

    for item_name in os.listdir(examples_dir):
        item_folder_path = os.path.join(examples_dir, item_name)

        # 逻辑：示例通常是一个文件夹，里面包含同名的 .mb 文件
        if os.path.isdir(item_folder_path):
            expected_file_path = os.path.join(item_folder_path, f"{item_name}.mb")
            if os.path.isfile(expected_file_path):
                found_examples.append(item_name)

    return found_examples


def get_example_path(example_name: str, sub_dir: str = "files/Rigged") -> str:
    """
    根据示例名称构建其 .mb 文件的完整路径。
    路径: ProjectRoot/files/Rigged/{name}/{name}.mb
    """
    project_root = get_project_root()
    return os.path.join(project_root, sub_dir, example_name, f"{example_name}.mb").replace('\\', '/')


def find_raw_skeletons(sub_dir: str = "files/ma") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【纯骨骼】文件 (.ma)。

    假设结构为扁平文件:
    .../files/ma/Biped_Skeleton.ma
    """
    project_root = get_project_root()
    # 构建完整路径: ProjectRoot/files/ma
    skeletons_dir = os.path.join(project_root, sub_dir)

    found_skeletons = []
    if not os.path.isdir(skeletons_dir):
        print(f"Warning: Skeletons directory not found: {skeletons_dir}")
        return found_skeletons

    for file_name in os.listdir(skeletons_dir):
        # 检查文件是否以 .ma 结尾 (忽略大小写)
        if file_name.lower().endswith(".ma"):
            # 添加不带扩展名的文件名
            found_skeletons.append(os.path.splitext(file_name)[0])

    return found_skeletons


def get_raw_skeleton_path(skeleton_name: str, sub_dir: str = "files/ma") -> str:
    """
    根据纯骨骼名称构建其 .ma 文件的完整路径。
    路径: ProjectRoot/files/ma/{name}.ma
    """
    project_root = get_project_root()
    return os.path.join(project_root, sub_dir, f"{skeleton_name}.ma").replace('\\', '/')