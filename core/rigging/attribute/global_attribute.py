# core/rigging/attribute/global_orient.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask
from core import tool


class GlobalOrientAttribute(RigObject):
    SLOTS = ["global"]

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        node_name = self.mapping.get("global", "Unknown")
        return [
            RigTask(
                priority=self.get_priority("attribute_global_post", 200),
                run=self.run_post_process,
                name=f"Attribute Post: Global Orient ({node_name})",
            ),
        ]

    def run_post_process(self):
        """
        Builds the matrix network logic.
        Fixes:
        1. Inserts group dynamically above FK Ctrl (respecting FKExtra).
        2. Aligns GlobalRef to FK Ctrl's orientation to fix axis flipping issues.
        """
        # 1. 获取目标骨骼
        target_bone = self.mapping.get("global")
        if not target_bone or not cmds.objExists(target_bone):
            return

        source_short = tool.get_short_name(target_bone)

        # 2. 寻找 FK 控制器
        fk_ctrl = f"FK_{source_short}"
        if not cmds.objExists(fk_ctrl):
            print(f"[Global] Warning: FK Controller {fk_ctrl} not found. Skipping.")
            return

        # ==========================================
        # 3. 动态插入 FKGlobal 组 (修复层级问题)
        # ==========================================
        # 获取控制器当前的父级 (可能是 FKExtra, 也可能是 FKOffset)
        current_parent_list = cmds.listRelatives(fk_ctrl, parent=True)
        if not current_parent_list:
            print(f"[Global] Error: {fk_ctrl} has no parent.")
            return

        current_parent = current_parent_list[0]  # e.g. FKExtra_Head_M

        fk_global_grp = f"FKGlobal_{source_short}"

        if not cmds.objExists(fk_global_grp):
            cmds.createNode("transform", name=fk_global_grp)
            # 1. 匹配父级位置和旋转 (Zero Out)
            cmds.matchTransform(fk_global_grp, current_parent)

            # 2. 插入层级: Parent -> GlobalGrp -> Ctrl
            tool.safe_parent(fk_global_grp, current_parent)
            tool.safe_parent(fk_ctrl, fk_global_grp)

            # 3. 【关键】同步旋转顺序，防止计算错乱
            # 这一步非常重要，否则 decomposeMatrix 算出来的角度应用到 Transform 上会乱
            ro = cmds.getAttr(f"{fk_ctrl}.rotateOrder")
            cmds.setAttr(f"{fk_global_grp}.rotateOrder", ro)

            print(f"[Global] Inserted {fk_global_grp} under {current_parent}")
        else:
            # 防止重复运行报错
            pass

        # 4. 添加控制属性 (Global 0-10)
        anim_attr = "Global"
        if not cmds.attributeQuery(anim_attr, node=fk_ctrl, exists=True):
            cmds.addAttr(fk_ctrl, ln=anim_attr, at="double", min=0, max=10, dv=0, k=True)

        # ==========================================
        # 5. 创建并对齐参考物 (修复乱转问题)
        # ==========================================
        global_ref = f"GlobalRef_{source_short}"
        if not cmds.objExists(global_ref):
            cmds.createNode("transform", name=global_ref)

            # 放到 GlobalSystem
            parent_sys = self.builder.groups.get("global_sys", "GlobalSystem")
            if cmds.objExists(parent_sys):
                tool.safe_parent(global_ref, parent_sys)

            # 【核心修复】必须吸附到 FK Ctrl 的位置 AND 旋转！
            # 这样 GlobalRef 的轴向就和 FK Ctrl 初始轴向一致了。
            # 当 Main 移动时，GlobalRef 保持这个初始轴向，FKGlobal 就会努力去匹配这个轴向。
            cmds.matchTransform(global_ref, fk_ctrl, pos=True, rot=True)

            # 约束到 Main (只跟随 Main 的整体移动，保持相对静止)
            main_ctrl = "Main"
            if cmds.objExists(main_ctrl):
                # maintainOffset=True 保持我们刚才吸附好的旋转
                cmds.parentConstraint(main_ctrl, global_ref, maintainOffset=True)

        # 6. 构建矩阵网络
        suffix = source_short

        # A. MultMatrix ( Target World * Parent Inverse = Local )
        mm_node = f"FKGlobalMM_{suffix}"
        if not cmds.objExists(mm_node):
            mm_node = cmds.createNode("multMatrix", name=mm_node)

        # In[1]: 目标的世界矩阵 (GlobalRef)
        cmds.connectAttr(f"{global_ref}.worldMatrix[0]", f"{mm_node}.matrixIn[1]", force=True)
        # In[2]: 组父级的逆世界矩阵 (注意：这里用 fk_global_grp 的 parentInverseMatrix)
        # 这样能动态适应任何父级 (FKExtra 或 FKOffset)
        cmds.connectAttr(f"{fk_global_grp}.parentInverseMatrix[0]", f"{mm_node}.matrixIn[2]", force=True)

        # B. PickMatrix (只取旋转)
        pm_node = f"FKGlobalPMRot_{suffix}"
        if not cmds.objExists(pm_node):
            pm_node = cmds.createNode("pickMatrix", name=pm_node)
            cmds.setAttr(f"{pm_node}.useTranslate", 0)
            cmds.setAttr(f"{pm_node}.useScale", 0)
            cmds.setAttr(f"{pm_node}.useShear", 0)

        cmds.connectAttr(f"{mm_node}.matrixSum", f"{pm_node}.inputMatrix", force=True)

        # C. RemapValue (0-10 -> 0-1)
        remap_node = f"GlobalWeight_{suffix}"
        if not cmds.objExists(remap_node):
            remap_node = cmds.createNode("remapValue", name=remap_node)
            cmds.setAttr(f"{remap_node}.inputMin", 0)
            cmds.setAttr(f"{remap_node}.inputMax", 10)
            cmds.setAttr(f"{remap_node}.outputMin", 0)
            cmds.setAttr(f"{remap_node}.outputMax", 1)

        cmds.connectAttr(f"{fk_ctrl}.{anim_attr}", f"{remap_node}.inputValue", force=True)

        # D. BlendMatrix
        bm_node = f"FKGlobalBMRot_{suffix}"
        if not cmds.objExists(bm_node):
            bm_node = cmds.createNode("blendMatrix", name=bm_node)

        # Target[0] = Global Calculation
        cmds.connectAttr(f"{pm_node}.outputMatrix", f"{bm_node}.target[0].targetMatrix", force=True)
        # Weight = Remap Output
        cmds.connectAttr(f"{remap_node}.outValue", f"{bm_node}.target[0].weight", force=True)
        # InputMatrix 留空 = Identity = 跟随父级

        # E. DecomposeMatrix
        dm_node = f"FKGlobalDM_{suffix}"
        if not cmds.objExists(dm_node):
            dm_node = cmds.createNode("decomposeMatrix", name=dm_node)

        # 【关键修复】连接 RotateOrder，告诉解算器用什么顺序计算 Euler 角
        cmds.connectAttr(f"{fk_global_grp}.rotateOrder", f"{dm_node}.inputRotateOrder", force=True)

        cmds.connectAttr(f"{bm_node}.outputMatrix", f"{dm_node}.inputMatrix", force=True)

        # 7. 驱动 FKGlobal 组
        cmds.connectAttr(f"{dm_node}.outputRotate", f"{fk_global_grp}.rotate", force=True)
        cmds.connectAttr(f"{dm_node}.outputShear", f"{fk_global_grp}.shear", force=True)

        print(f"[Global] Setup Complete for {source_short}.")

    @staticmethod
    def add_to(node: str) -> bool:
        tool.add_attribute(
            node,
            long_name="global",
            nice_name="Global",
            attribute_type="bool",
            default_value=1,
            keyable=True,
        )
        return True

    @staticmethod
    def remove_from(node: str) -> bool:
        return tool.remove_attribute(node, "global")