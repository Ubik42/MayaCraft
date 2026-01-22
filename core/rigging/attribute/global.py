# core/rigging/attribute/global_orient.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
from core.rigging.base import RigObject, RigTask
from core import tool


class GlobalOrientAttribute(RigObject):
    SLOTS = ["global"]
    """
    Adds a 'Global' attribute (0-10) to the FK controller.
    Creates a matrix network to isolate the controller's orientation 
    from its parent hierarchy when Global is set to 10.

    Structure Created:
    FKOffset (Parent) -> FKGlobal (Driven by Matrix) -> FK_Ctrl
    """

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        node_name = self.mapping.get("globalOrient", "Unknown")
        return [
            RigTask(
                priority=self.get_priority("attribute_global_post", 200),  # 优先级略高于 Inbetween，确保层级稳定
                run=self.run_post_process,
                name=f"Attribute Post: Global Orient ({node_name})",
            ),
        ]

    def run_post_process(self):
        """
        Builds the matrix network:
        WorldRef * ParentInverse -> Pick(Rot) -> Blend(Identity) -> Decompose -> FKGlobalGroup
        """
        # 1. 获取源节点
        source_node = self.mapping.get("globalOrient")
        if not source_node or not cmds.objExists(source_node):
            return

        # 属性检查
        if not cmds.attributeQuery("globalOrient", node=source_node, exists=True):
            return

        source_short = tool.get_short_name(source_node)

        # 2. 寻找 FK 控制器
        # 假设命名规范为 FK_{source_short} (例如 FK_Head_M)
        fk_ctrl = f"FK_{source_short}"
        if not cmds.objExists(fk_ctrl):
            print(f"[Global] Warning: FK Controller {fk_ctrl} not found. Skipping.")
            return

        # 3. 寻找 FK 父级组 (Offset)
        # 假设命名规范为 FKOffset_{source_short}
        fk_offset = f"FKOffset_{source_short}"
        if not cmds.objExists(fk_offset):
            print(f"[Global] Warning: FK Offset {fk_offset} not found. Skipping.")
            return

        # 4. 插入 FKGlobal 组 (如果不存在)
        # 结构从: FKOffset -> FK_Ctrl
        # 变为:   FKOffset -> FKGlobal -> FK_Ctrl
        fk_global_grp = f"FKGlobal_{source_short}"

        if not cmds.objExists(fk_global_grp):
            cmds.createNode("transform", name=fk_global_grp)
            # 匹配 Offset 的位置
            cmds.matchTransform(fk_global_grp, fk_offset)
            # 建立层级
            tool.safe_parent(fk_global_grp, fk_offset)
            tool.safe_parent(fk_ctrl, fk_global_grp)
            print(f"[Global] Inserted group: {fk_global_grp}")
        else:
            # 如果组已经存在 (可能多次运行)，确保层级正确
            pass

        # 5. 添加控制属性 (0-10)
        attr_name = "Global"
        if not cmds.attributeQuery(attr_name, node=fk_ctrl, exists=True):
            cmds.addAttr(fk_ctrl, ln=attr_name, at="double", min=0, max=10, dv=0, k=True)

        # 6. 创建全局参考物 (Reference Target)
        # 这是一个始终保持世界方向(或跟随Main)的空组
        global_ref = f"GlobalRef_{source_short}"
        if not cmds.objExists(global_ref):
            cmds.createNode("transform", name=global_ref)
            # 把它扔到 MainSystem 或者 World 下，确保它不跟随身体转动
            # 这里假设有一个 global_sys 组，如果没有就放世界
            parent_sys = self.builder.groups.get("global_sys", None)
            if parent_sys and cmds.objExists(parent_sys):
                tool.safe_parent(global_ref, parent_sys)

            # 将 GlobalRef 移动到控制器的位置，但保持旋转归零(世界方向)
            # 实际上只要位置对就行，旋转通常是 0,0,0 代表世界
            pos = cmds.xform(fk_ctrl, q=True, t=True, ws=True)
            cmds.xform(global_ref, t=pos, ws=True)

            # 加上一个约束让它跟着 Main 走位移，但不走旋转?
            # 或者简单点，直接让它静止在世界空间，只做位置约束
            # 根据提供的图表: GlobalFollowMain (parentConstraint)
            # 我们做一个针对位置的约束，让它跟着角色跑，但保持方向不变
            main_ctrl = "Main"  # 假设主控制器叫 Main
            if cmds.objExists(main_ctrl):
                cmds.pointConstraint(main_ctrl, global_ref, maintainOffset=True)

        # 7. 构建矩阵网络
        # 命名后缀
        suffix = source_short

        # A. MultMatrix (World Target * Parent Inverse = Local)
        mm_node = cmds.createNode("multMatrix", name=f"FKGlobalMM_{suffix}")
        cmds.connectAttr(f"{global_ref}.worldMatrix[0]", f"{mm_node}.matrixIn[1]")
        cmds.connectAttr(f"{fk_offset}.worldInverseMatrix[0]", f"{mm_node}.matrixIn[2]")

        # B. PickMatrix (只取旋转)
        pm_node = cmds.createNode("pickMatrix", name=f"FKGlobalPMRot_{suffix}")
        cmds.setAttr(f"{pm_node}.useTranslate", 0)
        cmds.setAttr(f"{pm_node}.useScale", 0)
        cmds.setAttr(f"{pm_node}.useShear", 0)
        cmds.connectAttr(f"{mm_node}.matrixSum", f"{pm_node}.inputMatrix")

        # C. RemapValue (0-10 -> 0-1)
        # 也就是图表里的 unitConversion，但 remapValue 更通用
        remap_node = cmds.createNode("remapValue", name=f"GlobalWeight_{suffix}")
        cmds.setAttr(f"{remap_node}.inputMin", 0)
        cmds.setAttr(f"{remap_node}.inputMax", 10)
        cmds.setAttr(f"{remap_node}.outputMin", 0)
        cmds.setAttr(f"{remap_node}.outputMax", 1)
        cmds.connectAttr(f"{fk_ctrl}.{attr_name}", f"{remap_node}.inputValue")

        # D. BlendMatrix (混合 Identity 和 计算出的矩阵)
        bm_node = cmds.createNode("blendMatrix", name=f"FKGlobalBMRot_{suffix}")
        # Target 0 是计算出的世界方向
        cmds.connectAttr(f"{pm_node}.outputMatrix", f"{bm_node}.target[0].targetMatrix")
        # Weight 由 Remap 驱动
        cmds.connectAttr(f"{remap_node}.outValue", f"{bm_node}.target[0].weight")
        # InputMatrix 留空，默认就是 Identity Matrix (代表跟随父级/Default)

        # E. DecomposeMatrix (解算回 TRS)
        dm_node = cmds.createNode("decomposeMatrix", name=f"FKGlobalDM_{suffix}")
        cmds.connectAttr(f"{bm_node}.outputMatrix", f"{dm_node}.inputMatrix")

        # 8. 驱动 FKGlobal 组
        # 只驱动旋转和可能的剪切，位移和缩放通常不需要
        cmds.connectAttr(f"{dm_node}.outputRotate", f"{fk_global_grp}.rotate", force=True)
        cmds.connectAttr(f"{dm_node}.outputShear", f"{fk_global_grp}.shear", force=True)  # 防万一

        print(f"[Global] Setup Complete for {source_short}. Ctrl: {fk_ctrl}")

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