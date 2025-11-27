import os
import ast
import sys
from pathlib import Path

# === 配置 ===
OUTPUT_FILE = "project_structure.md"
INIT_FILE = "__init__.py"

# === 图标定义 ===
ICON_PKG = "📦 "
ICON_FILE = "🐍 "
ICON_CLASS = "ⓒ "
ICON_FUNC = "ⓕ "


def get_ast_structure(file_path: Path):
    """
    解析 py 文件，返回类和函数的结构列表
    """
    structures = []
    try:
        with open(file_path, "r", encoding="utf-8") as f:
            file_content = f.read()

        # 解析语法树
        tree = ast.parse(file_content)

        for node in tree.body:
            # 顶级函数
            if isinstance(node, ast.FunctionDef) or isinstance(node, ast.AsyncFunctionDef):
                structures.append({'type': 'func', 'name': node.name, 'children': []})

            # 类
            elif isinstance(node, ast.ClassDef):
                methods = []
                # 获取类里面的方法
                for item in node.body:
                    if isinstance(item, ast.FunctionDef) or isinstance(item, ast.AsyncFunctionDef):
                        methods.append(item.name)
                structures.append({'type': 'class', 'name': node.name, 'children': methods})

    except Exception as e:
        # 如果解析出错（比如语法错误），仅返回空
        return []

    return structures


def is_python_package(path: Path) -> bool:
    """检查是否为 Python 包 (包含 __init__.py)"""
    return path.is_dir() and (path / INIT_FILE).exists()


def generate_tree(directory: Path, prefix: str = "", mode: int = 0):
    """
    递归生成目录树
    mode 0: 包 + 文件
    mode 1: 包 + 文件 + 类/方法
    """
    lines = []

    # 1. 获取目录内容
    try:
        all_items = sorted([p for p in directory.iterdir() if not p.name.startswith('.')])
    except PermissionError:
        return lines

    # 2. 筛选我们要展示的项目
    # 规则：
    # - 如果是文件夹：必须是 Python Package (包含 __init__.py)
    # - 如果是文件：必须是 .py 文件
    filtered_items = []
    for item in all_items:
        if item.is_dir():
            if is_python_package(item):
                filtered_items.append(item)
        elif item.is_file() and item.suffix == '.py':
            filtered_items.append(item)

    count = len(filtered_items)

    for index, item in enumerate(filtered_items):
        is_last = (index == count - 1)
        connector = "└── " if is_last else "├── "

        # 计算子层级的前缀
        child_prefix = prefix + ("    " if is_last else "│   ")

        # === 处理文件夹 (Package) ===
        if item.is_dir():
            lines.append(f"{prefix}{connector}{ICON_PKG}{item.name}")
            # 递归进入
            lines.extend(generate_tree(item, child_prefix, mode))

        # === 处理文件 (Python File) ===
        else:
            lines.append(f"{prefix}{connector}{ICON_FILE}{item.name}")

            # 如果是模式 1，且是 py 文件，进行深度解析
            if mode == 1:
                symbols = get_ast_structure(item)
                sym_count = len(symbols)

                for s_idx, sym in enumerate(symbols):
                    s_is_last = (s_idx == sym_count - 1)
                    s_connector = "└── " if s_is_last else "├── "

                    # 打印类或函数
                    if sym['type'] == 'func':
                        lines.append(f"{child_prefix}{s_connector}{ICON_FUNC}{sym['name']}()")
                    elif sym['type'] == 'class':
                        lines.append(f"{child_prefix}{s_connector}{ICON_CLASS}{sym['name']}")

                        # 打印类里面的方法
                        methods = sym['children']
                        m_count = len(methods)
                        m_prefix = child_prefix + ("    " if s_is_last else "│   ")

                        for m_idx, m_name in enumerate(methods):
                            m_is_last = (m_idx == m_count - 1)
                            m_connector = "└── " if m_is_last else "├── "
                            lines.append(f"{m_prefix}{m_connector}{ICON_FUNC}{m_name}()")

    return lines


def main():
    current_dir = Path.cwd()
    print(f"当前工作目录: {current_dir}")
    print("-" * 30)
    print("请选择扫描模式：")
    print("【0】 结构模式：仅列出包 (Packages) 和 Python 文件")
    print("【1】 深度模式：列出包、文件，以及文件内的类和函数")

    choice = input("\n请输入数字 (0 或 1): ").strip()

    if choice not in ['0', '1']:
        print("❌ 输入无效，程序退出。")
        return

    mode = int(choice)
    print("\n🔍 正在分析文件结构，请稍候...")

    # 核心逻辑：
    # 如果当前根目录下直接就有 __init__.py，说明根目录本身就是个包，直接扫描内容
    # 如果当前根目录没有 __init__.py，说明它是个容器，我们需要扫描它下面的一级子文件夹看谁是包

    tree_lines = []

    if is_python_package(current_dir):
        # 根目录就是包，直接递归
        tree_lines = generate_tree(current_dir, mode=mode)
    else:
        # 根目录不是包，寻找子包
        sub_dirs = sorted([p for p in current_dir.iterdir() if p.is_dir()])
        packages = [p for p in sub_dirs if is_python_package(p)]

        if not packages:
            tree_lines = []  # 没有找到任何包
        else:
            count = len(packages)
            for index, pkg in enumerate(packages):
                is_last = (index == count - 1)
                connector = "└── " if is_last else "├── "
                tree_lines.append(f"{connector}{ICON_PKG}{pkg.name}")

                next_prefix = "    " if is_last else "│   "
                tree_lines.extend(generate_tree(pkg, next_prefix, mode))

    # 生成最终文本
    if not tree_lines:
        result_text = "> ⚠️ 当前目录下未检测到任何包含 `__init__.py` 的 Python Package。"
    else:
        tree_str = "\n".join(tree_lines)
        mode_str = "深度模式 (类/方法)" if mode == 1 else "结构模式 (仅文件)"
        result_text = f"# Project Structure\n\n- **路径**: `{current_dir}`\n- **模式**: {mode_str}\n\n```text\n.\n{tree_str}\n```\n"

    # 保存
    try:
        with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
            f.write(result_text)

        print("\n" + "=" * 30)
        print(f"✅ 完成！结果已保存至: {OUTPUT_FILE}")
        print("=" * 30)
        # 在控制台预览（截取前20行避免刷屏）
        print("预览:")
        print(".\n" + "\n".join(tree_lines[:20]))
        if len(tree_lines) > 20:
            print(f"... (剩余 {len(tree_lines) - 20} 行见文件)")

    except Exception as e:
        print(f"❌ 写入文件失败: {e}")


if __name__ == "__main__":
    main()