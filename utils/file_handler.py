# utils/file_handler.py
# -*- coding: utf-8 -*-
"""
file_handler.py
处理文件和目录操作的通用工具模块。
"""

import os
import maya.cmds as cmds
from typing import List

PROJECT_ROOT = 'F:/05 3D/Maya/Python/MyWork/MayaCraft'

def get_project_root() -> str:
    """
    获取当前Maya项目的工作区根目录。

    Returns:
        str: 项目根目录的绝对路径。
    """
    return PROJECT_ROOT


def find_examples(sub_dir: str = "files") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【示例成品】文件 (.mb)。
    结构: .../files/Biped/Biped.mb
    """
    project_root = get_project_root()
    examples_dir = os.path.join(project_root, sub_dir)

    found_examples = []
    if not os.path.isdir(examples_dir):
        return found_examples

    for item_name in os.listdir(examples_dir):
        item_folder_path = os.path.join(examples_dir, item_name)
        if os.path.isdir(item_folder_path):
            expected_file_path = os.path.join(item_folder_path, f"{item_name}.mb")
            if os.path.isfile(expected_file_path):
                found_examples.append(item_name)

    return found_examples


def get_example_path(example_name: str, sub_dir: str = "files") -> str:
    """根据示例名称构建其 .mb 文件的完整路径。"""
    project_root = get_project_root()
    return os.path.join(project_root, sub_dir, example_name, f"{example_name}.mb")


# --- 新增函数 ---
def find_raw_skeletons(sub_dir: str = "files") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【纯骨骼】文件 (.ma)。
    结构: .../files/Biped_Skeleton.ma
    """
    project_root = get_project_root()
    skeletons_dir = os.path.join(project_root, sub_dir)

    found_skeletons = []
    if not os.path.isdir(skeletons_dir):
        return found_skeletons

    for file_name in os.listdir(skeletons_dir):
        # 检查文件是否以 .ma 结尾
        if file_name.lower().endswith(".ma"):
            # 添加不带扩展名的文件名
            found_skeletons.append(os.path.splitext(file_name)[0])

    return found_skeletons


def get_raw_skeleton_path(skeleton_name: str, sub_dir: str = "files") -> str:
    """根据纯骨骼名称构建其 .ma 文件的完整路径。"""
    project_root = get_project_root()
    return os.path.join(project_root, sub_dir, f"{skeleton_name}.ma")