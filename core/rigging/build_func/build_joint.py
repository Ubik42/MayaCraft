# core/rigging/build_func/build_joint.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool
from core.logic.rigging import build_widget_logic as logic


def process_skeleton(builder, ui_config: dict):
    """
    [核心逻辑] 骨骼处理函数
    负责：
    1. 骨骼复制 (Duplicate)
    2. [NEW] 清理额外属性
    3. 重命名 (_M, _R)
    4. 镜像 (_R -> _L)
    5. 生成适配新骨骼的构建配置
    """

    groups = builder.groups

    if ui_config is None:
        ui_config = {}

    # 1. 寻找原始根骨骼
    original_root = _find_original_root(ui_config)

    if not original_root or not cmds.objExists(original_root):
        print(">>> [JointBuilder] Warning: No joints found in the scene.")
        builder.processed_config = {}
        return

    # 2. 复制骨骼
    new_nodes = cmds.duplicate(original_root, renameChildren=True)
    deform_root = new_nodes[0]
    tool.safe_parent(deform_root, groups["geo"])

    # --- [新增功能] 清理所有复制出来的骨骼的额外属性 ---
    # 获取新骨骼的所有层级节点
    temp_clean_list = _get_hierarchy_list(deform_root)

    print("  [JointBuilder] Cleaning extra attributes from deform skeleton...")
    for node in temp_clean_list:
        # 1. 清除自定义属性
        user_attrs = cmds.listAttr(node, userDefined=True) or []
        for attr in user_attrs:
            try:
                cmds.setAttr(f"{node}.{attr}", lock=False)
                cmds.deleteAttr(node, attribute=attr)
            except Exception:
                pass

        # 2. [新增] 清除骨骼标签 (Label)
        if cmds.nodeType(node) == "joint":
            cmds.setAttr(f"{node}.drawLabel", 0)
            cmds.setAttr(f"{node}.type", 0)  # 0 = None
            cmds.setAttr(f"{node}.otherType", "", type="string")
    # ----------------------------------------------------

    # 3. 隐藏场景中除插件总组外的一切
    main_grp = groups["main"]
    all_assemblies = cmds.ls(assemblies=True)
    for node in all_assemblies:
        if node == main_grp:
            continue
        try:
            tool.unlock_transform(node, visibility=True)
            cmds.setAttr(f"{node}.visibility", 0)
        except:
            pass

    # 4. 处理命名 (_M/_R) 和 镜像准备
    # 获取层级列表 (full path)
    orig_hierarchy = _get_hierarchy_list(original_root)
    deform_hierarchy = _get_hierarchy_list(deform_root)

    # 识别需要镜像的分支根节点 (基于原始骨骼名字包含 scapula 或 hip)
    deform_mirror_roots = []
    mirror_keywords = ["scapula", "hip","eye"]

    # 预先扫描找出镜像根节点在 Deform 层级中的路径
    for orig_full, deform_full in zip(orig_hierarchy, deform_hierarchy):
        orig_short = orig_full.split("|")[-1].lower()
        for kw in mirror_keywords:
            if kw in orig_short:
                deform_mirror_roots.append(deform_full)
                break

    # 用于 Config 转换的局部映射表 (Short Name -> New Deform Name)
    short_name_map = {}

    # 倒序遍历进行重命名 (防止重命名父级后子级路径失效，虽然 deform_hierarchy 存的是快照)
    for orig_full, deform_full in zip(reversed(orig_hierarchy), reversed(deform_hierarchy)):
        # 判断当前节点是否属于右侧 (即路径中是否包含镜像根节点)
        is_right_side = False
        for root_path in deform_mirror_roots:
            if root_path in deform_full:
                is_right_side = True
                break

        suffix = "_R" if is_right_side else "_M"

        # 获取原始短名并重命名新节点
        orig_short = orig_full.split("|")[-1]
        new_name = f"{orig_short}{suffix}"

        # 执行重命名
        renamed_node = cmds.rename(deform_full, new_name)

        # 记录映射供 Config 转换使用
        short_name_map[orig_short] = renamed_node

        tool.unlock_transform(renamed_node)

    # 更新 deform_root 变量为重命名后的名字
    orig_root_short = original_root.split("|")[-1]
    if orig_root_short in short_name_map:
        deform_root = short_name_map[orig_root_short]

    # 执行镜像 (_R -> _L)
    # 只需要对名字以 _R 结尾且是镜像根节点的对应的当前节点执行镜像
    for orig_full, deform_full in zip(orig_hierarchy, deform_hierarchy):
        orig_short = orig_full.split("|")[-1]
        # 检查这是否是一个镜像分支的根
        # 注意：这里需要用原始名字判断是否是 keyword 节点，用 short_name_map 获取当前名字
        is_mirror_root_node = any(kw in orig_short.lower() for kw in mirror_keywords)

        if is_mirror_root_node and orig_short in short_name_map:
            current_node = short_name_map[orig_short]
            if current_node.endswith("_R") and cmds.objExists(current_node):
                print(f"  [JointBuilder] Mirroring Branch: {current_node}")
                cmds.mirrorJoint(
                    current_node,
                    mirrorYZ=True,
                    mirrorBehavior=True,
                    searchReplace=("_R", "_L")
                )

    # 5. 重组构建配置 (将 UI 配置的原始骨骼映射到新的 Deform 骨骼)
    new_config = {}
    if ui_config:
        for mod_name, instances in ui_config.items():
            new_instances = []
            for inst in instances:
                inst_r_m = {}  # 存放 _R 或 _M
                inst_l = {}  # 存放 _L
                has_l = False

                for key, orig_long in inst.items():
                    orig_short = orig_long.split("|")[-1]

                    if orig_short in short_name_map:
                        new_name = short_name_map[orig_short]
                        inst_r_m[key] = new_name

                        # 如果是右侧，尝试查找对应的左侧骨骼
                        if new_name.endswith("_R"):
                            l_name = new_name.replace("_R", "_L")
                            if cmds.objExists(l_name):
                                inst_l[key] = l_name
                                has_l = True

                if inst_r_m:
                    new_instances.append(inst_r_m)
                if has_l and inst_l:
                    new_instances.append(inst_l)

            new_config[mod_name] = new_instances

    # --- Store Result in Builder ---
    builder.processed_config = new_config

    print(">>> [JointBuilder] Skeleton processed successfully.")


# --- 辅助函数 ---


def _find_original_root(ui_config):
    """
    寻找原始骨骼根节点。
    """
    # 1. (最高优先级) 尝试从 UI 数据的 Spine 模块找 Root 标签
    if ui_config and "IK Spine" in ui_config:
        for inst in ui_config["IK Spine"]:
            if "Root" in inst and cmds.objExists(inst["Root"]):
                return inst["Root"]

    # 2. (次高优先级) 如果 UI 配置为空，尝试寻找 FitSkeleton 下的骨骼
    if not ui_config or not ui_config.keys():
        if cmds.objExists("FitSkeleton"):
            children = cmds.listRelatives(
                "FitSkeleton", children=True, type="joint", fullPath=True
            )
            if children:
                return children[0]

    # 3. (备选) 尝试从场景标签查找
    scene_labels = logic.get_all_joint_labels()
    if "Root" in scene_labels and scene_labels["Root"]:
        valid_roots = [r for r in scene_labels["Root"] if cmds.objExists(r)]
        if valid_roots:
            print("[JointBuilder] Found Root via scene labels.")
            return valid_roots[0]

    # 4. (最后兜底) 扫描场景中所有骨骼，找到绝对意义上的最高级骨骼
    all_scene_joints = cmds.ls(type="joint", long=True)
    if all_scene_joints:
        print("[JointBuilder] Found Root via scene scan.")
        return _get_highest_joint(all_scene_joints[0])

    return None


def _get_highest_joint(start_joint):
    """
    沿着骨骼链向上爬，直到父级不是 Joint 为止。
    """
    curr = start_joint
    while True:
        parent = cmds.listRelatives(curr, parent=True, fullPath=True)
        if not parent:
            break
        if cmds.nodeType(parent[0]) != "joint":
            break
        curr = parent[0]
    return curr


def _get_hierarchy_list(root):
    if not root or not cmds.objExists(root):
        return []
    full_root = cmds.ls(root, long=True)[0]
    descendants = cmds.listRelatives(full_root, ad=True, fullPath=True) or []
    hierarchy = [full_root] + descendants[::-1]
    return hierarchy
