# core/rigging/build_joint.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds
from core import tool
from core.logic.rigging import build_widget_logic as logic


class JointBuilder:
    """
    骨骼处理系统。
    负责：
    1. 骨骼复制 (Duplicate)
    2. 重命名 (_M, _R)
    3. 镜像 (_R -> _L)
    4. 生成适配新骨骼的构建配置
    """

    def __init__(self, group_config: dict):
        self.groups = group_config

    def process_skeleton(self, ui_config: dict) -> dict:
        """
        [核心逻辑]
        """
        print(">>> [JointBuilder] Processing Skeleton...")

        # [新增] 如果没有传入 UI 数据，则初始化为空字典
        if ui_config is None:
            ui_config = {}

        # 1. 寻找原始根骨骼
        original_root = self._find_original_root(ui_config)

        # 如果找不到任何骨骼，返回空
        if not original_root or not cmds.objExists(original_root):
            print(">>> [JointBuilder] Warning: No joints found in the scene.")
            return {}

        # 2. 复制骨骼
        new_nodes = cmds.duplicate(original_root, renameChildren=True)
        deform_root = new_nodes[0]
        tool.safe_parent(deform_root, self.groups["geo"])

        # 3. 隐藏场景中除插件总组外的一切
        main_grp = self.groups["main"]
        all_assemblies = cmds.ls(assemblies=True)
        for node in all_assemblies:
            if node == main_grp: continue
            if node in ['persp', 'top', 'front', 'side']: continue
            try:
                tool.unlock_transform(node, visibility=True)
                cmds.setAttr(f"{node}.visibility", 0)
            except:
                pass

        # 4. 建立映射并处理命名/镜像 (以下逻辑保持不变)
        orig_hierarchy = self._get_hierarchy_list(original_root)
        deform_hierarchy = self._get_hierarchy_list(deform_root)
        full_path_map = dict(zip(orig_hierarchy, deform_hierarchy))

        deform_mirror_roots = []
        mirror_root_short_names = []
        mirror_keywords = ["scapula", "hip"]

        for orig_full, deform_full in full_path_map.items():
            orig_short = orig_full.split("|")[-1]
            orig_short_lower = orig_short.lower()
            for kw in mirror_keywords:
                if kw in orig_short_lower:
                    deform_mirror_roots.append(deform_full)
                    mirror_root_short_names.append(orig_short)
                    break

        short_name_map = {}
        for orig_full, deform_full in zip(reversed(orig_hierarchy), reversed(deform_hierarchy)):
            is_right_side = False
            for root_path in deform_mirror_roots:
                if root_path in deform_full:
                    is_right_side = True
                    break
            suffix = "_R" if is_right_side else "_M"
            orig_short = orig_full.split("|")[-1]
            new_name = f"{orig_short}{suffix}"
            renamed_node = cmds.rename(deform_full, new_name)
            short_name_map[orig_short] = renamed_node
            tool.unlock_transform(renamed_node)

        processed_mirror_roots = []
        for orig_short in mirror_root_short_names:
            if orig_short in short_name_map:
                r_node = short_name_map[orig_short]
                if r_node.endswith("_R") and r_node not in processed_mirror_roots:
                    processed_mirror_roots.append(r_node)

        for r_root in processed_mirror_roots:
            if cmds.objExists(r_root):
                print(f"  [JointBuilder] Mirroring Branch: {r_root}")
                cmds.mirrorJoint(r_root, mirrorYZ=True, mirrorBehavior=True, searchReplace=("_R", "_L"))

        # 5. 重组构建配置
        new_config = {}
        # 只有当原始 ui_config 不为空时才需要重组，否则返回空字典
        if ui_config:
            for mod_name, instances in ui_config.items():
                new_instances = []
                for inst in instances:
                    inst_r_m, inst_l = {}, {}
                    has_l = False
                    for key, orig_long in inst.items():
                        orig_short = orig_long.split("|")[-1]
                        if orig_short in short_name_map:
                            new_name = short_name_map[orig_short]
                            inst_r_m[key] = new_name
                            if new_name.endswith("_R"):
                                l_name = new_name.replace("_R", "_L")
                                if cmds.objExists(l_name):
                                    inst_l[key] = l_name
                                    has_l = True
                    if inst_r_m: new_instances.append(inst_r_m)
                    if has_l and inst_l: new_instances.append(inst_l)
                new_config[mod_name] = new_instances

        print(">>> [JointBuilder] Skeleton processed successfully.")
        return new_config

    # --- 辅助方法 ---

    def _find_original_root(self, ui_config):
        """
        寻找原始骨骼根节点。
        """
        # 1. (最高优先级) 尝试从 UI 数据的 Spine 模块找 Root 标签
        if ui_config and "IK Spine" in ui_config:
            for inst in ui_config["IK Spine"]:
                if "Root" in inst and cmds.objExists(inst["Root"]):
                    print("[JointBuilder] Found Root via UI Config.")
                    return inst["Root"]

        # 2. (次高优先级) 如果 UI 配置为空，尝试寻找 FitSkeleton 下的骨骼
        if not ui_config or not ui_config.keys():
            if cmds.objExists("FitSkeleton"):
                # 寻找 FitSkeleton 下的第一个 joint 子物体
                children = cmds.listRelatives("FitSkeleton", children=True, type="joint", fullPath=True)
                if children:
                    print("[JointBuilder] Found Root under FitSkeleton.")
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
            return self._get_highest_joint(all_scene_joints[0])

        return None

    def _get_highest_joint(self, start_joint):
        """
        沿着骨骼链向上爬，直到父级不是 Joint 为止。
        """
        curr = start_joint
        while True:
            parent = cmds.listRelatives(curr, parent=True, fullPath=True)
            if not parent: break
            if cmds.nodeType(parent[0]) != "joint": break
            curr = parent[0]
        return curr

    def _get_hierarchy_list(self, root):
        """获取层级全路径列表 (正序: 从父到子)"""
        if not root or not cmds.objExists(root): return []

        full_root = cmds.ls(root, long=True)[0]
        descendants = cmds.listRelatives(full_root, ad=True, fullPath=True) or []

        hierarchy = [full_root] + descendants[::-1]
        return hierarchy