# core/rigging/pre_build.py
# -*- coding: utf-8 -*-

import maya.cmds as cmds


class PreBuildSystem:
    """
    预处理系统。
    负责：
    1. 场景组结构初始化
    2. 骨骼复制与处理：
       - [修改] 依据骨骼名字(Scapula/Hip)而非标签来划分 R/M。
       - 对 R 进行镜像生成 L。
    3. 重组构建数据。
    """

    def __init__(self, group_config: dict):
        self.groups = group_config

    def _safe_parent(self, child, parent):
        if child and parent and cmds.objExists(child) and cmds.objExists(parent):
            try:
                curr = cmds.listRelatives(child, p=True)
                if curr and curr[0] == parent: return
                cmds.parent(child, parent)
            except:
                pass

    def _unlock_channels(self, node):
        if not cmds.objExists(node): return
        for attr in ['tx', 'ty', 'tz', 'rx', 'ry', 'rz', 'sx', 'sy', 'sz', 'v']:
            try:
                cmds.setAttr(f"{node}.{attr}", lock=False)
            except:
                pass

    def create_structure(self):
        """创建组结构"""
        if not cmds.objExists(self.groups["main"]):
            cmds.createNode("transform", name=self.groups["main"])

        for key in ["geo", "ctrl"]:
            grp = self.groups[key]
            if not cmds.objExists(grp):
                cmds.createNode("transform", name=grp, parent=self.groups["main"])

        ctrl_grp = self.groups["ctrl"]
        for key in ["main_sys", "module_sys", "fk_sys", "ik_sys"]:
            grp = self.groups[key]
            if not cmds.objExists(grp):
                cmds.createNode("transform", name=grp, parent=ctrl_grp)

    def process_skeleton(self, ui_config: dict) -> dict:
        """
        [核心逻辑]
        1. 复制骨骼。
        2. 隐藏场景中除 Group 外的所有根节点。
        3. [修改] 依据骨骼名字 (scapula/hip) 识别镜像分支 (_R)。
        4. 镜像 _R -> _L。
        5. 重组 Config。
        """
        print(">>> [PreBuild] Processing Skeleton...")

        # 1. 寻找并复制 Root
        original_root = self._find_original_root(ui_config)
        if not original_root:
            cmds.error("Cannot find original root joint.")
            return {}

        new_nodes = cmds.duplicate(original_root, renameChildren=True)
        deform_root = new_nodes[0]

        self._safe_parent(deform_root, self.groups["geo"])

        # 2. 隐藏 Group 之外的一切根节点
        main_grp = self.groups["main"]
        all_assemblies = cmds.ls(assemblies=True)
        for node in all_assemblies:
            if node == main_grp: continue
            if node in ['persp', 'top', 'front', 'side']: continue
            try:
                cmds.setAttr(f"{node}.visibility", lock=False)
                cmds.setAttr(f"{node}.visibility", 0)
            except:
                pass

        # 3. 建立映射: Original_Full_Path -> Deform_Full_Path
        orig_hierarchy = self._get_hierarchy_list(original_root)
        deform_hierarchy = self._get_hierarchy_list(deform_root)

        # 映射表: { "原始骨骼长名": "新骨骼长名" }
        full_path_map = dict(zip(orig_hierarchy, deform_hierarchy))

        # 4. [核心修改] 依据骨骼名字识别镜像根节点
        # 不再通过 ui_config 的标签查找，而是直接扫描骨骼名字
        deform_mirror_roots = []  # 存储新骨骼的长路径，用于判断子孙关系
        mirror_root_short_names = []  # 存储原始短名，用于后续查找重命名后的节点进行镜像

        # 定义关键词 (不区分大小写)
        mirror_keywords = ["scapula", "hip"]

        for orig_full, deform_full in full_path_map.items():
            orig_short = orig_full.split("|")[-1]
            orig_short_lower = orig_short.lower()

            # 只要名字里包含 scapula 或 hip
            for kw in mirror_keywords:
                if kw in orig_short_lower:
                    deform_mirror_roots.append(deform_full)
                    mirror_root_short_names.append(orig_short)
                    break

        # 5. 重命名遍历 (_R / _M)
        short_name_map = {}  # { "原始短名": "新骨骼名" }

        for orig_full, deform_full in zip(reversed(orig_hierarchy), reversed(deform_hierarchy)):

            is_right_side = False
            for root_path in deform_mirror_roots:
                # 判断当前骨骼是否是 镜像根节点 的子孙 (或本身)
                if root_path in deform_full:
                    is_right_side = True
                    break

            suffix = "_R" if is_right_side else "_M"

            orig_short = orig_full.split("|")[-1]
            new_name = f"{orig_short}{suffix}"
            renamed_node = cmds.rename(deform_full, new_name)

            short_name_map[orig_short] = renamed_node
            self._unlock_channels(renamed_node)

        # 6. [核心修改] 镜像操作 (_R -> _L)
        # 直接使用步骤4里找到的那些名字对应的重命名后的节点

        processed_mirror_roots = []  # 去重列表

        for orig_short in mirror_root_short_names:
            if orig_short in short_name_map:
                r_node = short_name_map[orig_short]
                # 只有真正变成了 _R 的才镜像
                if r_node.endswith("_R") and r_node not in processed_mirror_roots:
                    processed_mirror_roots.append(r_node)

        for r_root in processed_mirror_roots:
            if cmds.objExists(r_root):
                print(f"  Mirroring Branch: {r_root} -> _L")
                cmds.mirrorJoint(r_root, mirrorYZ=True, mirrorBehavior=True, searchReplace=("_R", "_L"))

        # 7. 重组 Config
        new_config = {}

        for mod_name, instances in ui_config.items():
            new_instances = []
            for inst in instances:
                inst_r_m = {}
                inst_l = {}
                has_l = False

                for key, orig_long in inst.items():
                    orig_short = orig_long.split("|")[-1]

                    if orig_short in short_name_map:
                        new_name = short_name_map[orig_short]
                        inst_r_m[key] = new_name

                        # 尝试推断 _L 是否存在
                        if new_name.endswith("_R"):
                            l_name = new_name.replace("_R", "_L")
                            if cmds.objExists(l_name):
                                inst_l[key] = l_name
                                has_l = True

                if inst_r_m: new_instances.append(inst_r_m)
                if has_l and inst_l: new_instances.append(inst_l)

            new_config[mod_name] = new_instances

        print(">>> [PreBuild] Skeleton processed successfully.")
        return new_config

    # --- 辅助方法 ---

    def _find_original_root(self, ui_config):
        # 1. 尝试从 UI 数据里找 Root 标签
        if "IK Spine" in ui_config:
            for inst in ui_config["IK Spine"]:
                if "Root" in inst: return inst["Root"]

        # 2. 尝试从场景找顶级骨骼
        roots = [j for j in cmds.ls(type="joint", long=True) if not cmds.listRelatives(j, p=True)]
        if roots: return roots[0]
        return None

    def _get_hierarchy_list(self, root):
        """获取层级全路径列表 (包含 root 自身)"""
        return [cmds.ls(root, long=True)[0]] + (cmds.listRelatives(root, ad=True, fullPath=True) or [])[::-1]