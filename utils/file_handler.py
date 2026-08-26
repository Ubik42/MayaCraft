# -*- coding: utf-8 -*-
"""
file_handler.py
处理文件和目录操作的通用工具模块。
"""

from pathlib import Path
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
    return Path(__file__).resolve().parents[1].as_posix()


def _resource_dir(sub_dir: str) -> Path:
    """Resolve a repository resource path without accepting absolute escapes."""
    relative = Path(sub_dir)
    if relative.is_absolute() or ".." in relative.parts:
        raise ValueError(f"Resource directory must be relative: {sub_dir!r}")
    return Path(get_project_root(), relative)


def find_examples(sub_dir: str = "files/Rigged") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【示例成品】文件 (.mb)。

    假设结构为文件夹包裹文件:
    .../files/Rigged/Biped/Biped.mb
    """
    examples_dir = _resource_dir(sub_dir)

    found_examples = []
    if not examples_dir.is_dir():
        # 如果目录不存在，打印警告方便调试，但返回空列表
        print(f"Warning: Examples directory not found: {examples_dir}")
        return found_examples

    for item_folder in examples_dir.iterdir():
        if item_folder.is_dir() and (item_folder / f"{item_folder.name}.mb").is_file():
            found_examples.append(item_folder.name)

    return sorted(found_examples, key=str.casefold)


def get_example_path(example_name: str, sub_dir: str = "files/Rigged") -> str:
    """
    根据示例名称构建其 .mb 文件的完整路径。
    路径: ProjectRoot/files/Rigged/{name}/{name}.mb
    """
    if not example_name or Path(example_name).name != example_name:
        raise ValueError(f"Invalid example name: {example_name!r}")
    return (_resource_dir(sub_dir) / example_name / f"{example_name}.mb").as_posix()


def find_raw_skeletons(sub_dir: str = "files/ma") -> List[str]:
    """
    在项目根目录下的指定子目录中扫描【纯骨骼】文件 (.ma)。

    假设结构为扁平文件:
    .../files/ma/Biped_Skeleton.ma
    """
    skeletons_dir = _resource_dir(sub_dir)

    found_skeletons = []
    if not skeletons_dir.is_dir():
        print(f"Warning: Skeletons directory not found: {skeletons_dir}")
        return found_skeletons

    for path in skeletons_dir.iterdir():
        if path.is_file() and path.suffix.lower() == ".ma":
            found_skeletons.append(path.stem)

    return sorted(found_skeletons, key=str.casefold)


def get_raw_skeleton_path(skeleton_name: str, sub_dir: str = "files/ma") -> str:
    """
    根据纯骨骼名称构建其 .ma 文件的完整路径。
    路径: ProjectRoot/files/ma/{name}.ma
    """
    if not skeleton_name or Path(skeleton_name).name != skeleton_name:
        raise ValueError(f"Invalid skeleton name: {skeleton_name!r}")
    return (_resource_dir(sub_dir) / f"{skeleton_name}.ma").as_posix()
