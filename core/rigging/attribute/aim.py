# core/rigging/attribute/aim.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.api.OpenMaya as om
from core.rigging.base import RigObject, RigTask
from core import tool
from core import controller


class AimAttribute(RigObject):
    SLOTS = ["aim"]

    def __init__(self, builder, mapping_data):
        self.builder = builder
        self.mapping = mapping_data

    def create_tasks(self, builder) -> list[RigTask]:
        node_name = self.mapping.get("aim", "Unknown")
        return [
            RigTask(
                priority=self.get_priority("attribute_aim_post", 210),
                run=self.run_post_process,
                name=f"Attribute Post: Aim Setup ({node_name})",
            ),
        ]

    def run_post_process(self):
        """
        Builds the Eye Aim system.
        Fixes:
        1. AimOffsetEye is physically moved forward (Z+ 30).
        2. AimEye_M and Follow group are zeroed out under Offset.
        3. Matrix logic calculates offset based on this forward position.
        """
        target_bone = self.mapping.get("aim")
        if not target_bone or not cmds.objExists(target_bone):
            return

        source_short = tool.get_short_name(target_bone)
        base_name = source_short.replace("_L", "").replace("_R", "").replace("_M", "")
        side = "_R" if "_R" in source_short else "_L" if "_L" in source_short else "_M"

        print(f"[Aim] Processing Aim for: {source_short}")

        # ---------------------------------------------------------
        # Part A: 构建公共层级 (单例模式)
        # ---------------------------------------------------------

        aim_sys = self.builder.groups.get("aim_sys", "AimSystem")
        if not cmds.objExists(aim_sys):
            cmds.createNode("transform", name=aim_sys)
            tool.safe_parent(aim_sys, self.builder.groups["ctrl"])

        aim_eye_grp = f"Aim{base_name}"
        if not cmds.objExists(aim_eye_grp):
            cmds.createNode("transform", name=aim_eye_grp)
            tool.safe_parent(aim_eye_grp, aim_sys)

        # 1. AimOffsetEye (静态根组) - 核心位置定义
        aim_offset_grp = f"AimOffset{base_name}"
        head_jnt = cmds.listRelatives(target_bone, parent=True)[0]

        if not cmds.objExists(aim_offset_grp):
            cmds.createNode("transform", name=aim_offset_grp)
            tool.safe_parent(aim_offset_grp, aim_eye_grp)

            # 【位置修复】
            if head_jnt:
                # 1. 吸附到 Head 位置 (中心)
                cmds.matchTransform(aim_offset_grp, head_jnt, pos=True, rot=False)
                # 2. 沿世界 Z 轴向前推 (假设 Z+ 是前)
                # 这样 Offset 组本身就在脸前面了
                cmds.move(0, 0, 30.0, aim_offset_grp, relative=True, worldSpace=True)

        # 2. AimFollowEye (运动组) & AimEye_M
        aim_follow_grp = f"AimFollow{base_name}"
        aim_main_ctrl = f"Aim{base_name}_M"

        if not cmds.objExists(aim_main_ctrl):
            if not cmds.objExists(aim_follow_grp):
                cmds.createNode("transform", name=aim_follow_grp)
                tool.safe_parent(aim_follow_grp, aim_offset_grp)
                # 因为父级已经在前方，这里直接归零即可
                tool.reset_transform(aim_follow_grp)

            # 创建 Main 控制器
            ctrl = controller.create_controller(aim_main_ctrl, shape="Square", color=17, radius=5)
            tool.safe_parent(ctrl, aim_follow_grp)
            # 归零 (位于 Offset/Follow 的位置)
            tool.reset_transform(ctrl)

            # 【属性】0-10
            cmds.addAttr(ctrl, ln="follow", at="double", min=0, max=10, dv=10, k=True)

            # 构建 Follow 矩阵网络
            main_ctrl = "Main"
            if cmds.objExists(main_ctrl) and head_jnt:
                self._build_clean_matrix_network(
                    ctrl_node=aim_main_ctrl,
                    driven_node=aim_follow_grp,
                    parent_node=aim_offset_grp,
                    target_head=head_jnt,
                    target_main=main_ctrl
                )

        # ---------------------------------------------------------
        # Part B: 构建单侧层级
        # ---------------------------------------------------------

        # Side Offset
        side_offset = f"AimOffset{source_short}"
        if not cmds.objExists(side_offset):
            cmds.createNode("transform", name=side_offset)
            tool.safe_parent(side_offset, aim_main_ctrl)

            # 位置计算：
            # X, Y: 对齐各自眼球 (高度和左右)
            eye_pos = cmds.xform(target_bone, q=True, t=True, ws=True)
            # Z: 对齐 AimOffsetEye (平面齐平)
            offset_pos = cmds.xform(aim_offset_grp, q=True, t=True, ws=True)

            # 假设 Z 是前后轴，设置位置
            cmds.xform(side_offset, t=(eye_pos[0], eye_pos[1], offset_pos[2]), ws=True)

        # Side Controller
        side_ctrl = f"Aim{source_short}"
        if not cmds.objExists(side_ctrl):
            color = 6 if side == "_R" else 13 if side == "_L" else 17
            ctrl = controller.create_controller(side_ctrl, shape="Circle", color=color, radius=1.5)
            tool.safe_parent(ctrl, side_offset)

            # 归零 (位于 SideOffset 位置)
            tool.reset_transform(ctrl)

            # 【微调】根据骨骼局部轴向做一点点偏移，防止完全重合，但主要位置由 Offset 决定
            # 1. 临时吸附旋转以匹配骨骼轴向
            cmds.matchTransform(ctrl, target_bone, rot=True)
            # 2. 稍微向上(Y)一点，或者不做偏移，看需求。这里只做旋转归零，位置保持在平面上。
            cmds.rotate(0, 0, 0, ctrl, ws=True)

            # 如果需要"骨骼X轴正方向偏上一点"，因为 Offset 已经推到前面了 (Z+)，
            # 这里如果不动，就是正前方。

            cmds.makeIdentity(ctrl, apply=True, t=1, r=1, s=1, n=0)

        # ---------------------------------------------------------
        # Part C: FK 层级插入
        # ---------------------------------------------------------

        fk_ctrl = f"FK_{source_short}"
        fk_offset = f"FKOffset_{source_short}"

        if cmds.objExists(fk_ctrl) and cmds.objExists(fk_offset):
            current_parent_list = cmds.listRelatives(fk_ctrl, parent=True)
            if current_parent_list:
                current_parent = current_parent_list[0]

                fk_aim_grp = f"FKAim{source_short}"
                if not cmds.objExists(fk_aim_grp):
                    cmds.createNode("transform", name=fk_aim_grp)
                    cmds.matchTransform(fk_aim_grp, current_parent)
                    tool.safe_parent(fk_aim_grp, current_parent)
                    tool.safe_parent(fk_ctrl, fk_aim_grp)

                # Aim 约束
                if not cmds.listConnections(fk_aim_grp, type="aimConstraint"):
                    cmds.aimConstraint(
                        side_ctrl, fk_aim_grp,
                        maintainOffset=True,
                        aimVector=(0, 0, 1),  # Z轴 指向目标 (假设骨骼Z轴向前)
                        upVector=(0, 1, 0),  # Y轴 向上
                        worldUpType="object",
                        worldUpObject=aim_main_ctrl
                    )

    def _build_clean_matrix_network(self, ctrl_node, driven_node, parent_node, target_head, target_main):
        """
        构建矩阵网络。
        关键点：aim_world_mat 现在获取的是已经推到前方的位置。
        """
        suffix = driven_node.replace("AimFollow", "")

        # 0. 获取当前 driven_node 的世界位置 (这就是我们的目标位置: Head前方30单位)
        aim_world_mat = om.MMatrix(cmds.getAttr(f"{driven_node}.worldMatrix[0]"))

        # --- 1. Static Branch (Main) ---
        main_world_mat = om.MMatrix(cmds.getAttr(f"{target_main}.worldMatrix[0]"))
        # Offset = Aim(Forward) * Main_Inv
        static_offset_mat = aim_world_mat * main_world_mat.inverse()

        mm_static = cmds.createNode("multMatrix", name=f"AimFollow{suffix}MMStatic")
        cmds.setAttr(f"{mm_static}.matrixIn[0]", list(static_offset_mat), type="matrix")
        cmds.connectAttr(f"{target_main}.worldMatrix[0]", f"{mm_static}.matrixIn[1]")
        cmds.connectAttr(f"{parent_node}.worldInverseMatrix[0]", f"{mm_static}.matrixIn[2]")

        # --- 2. Follow Branch (Head) ---
        head_world_mat = om.MMatrix(cmds.getAttr(f"{target_head}.worldMatrix[0]"))
        # Offset = Aim(Forward) * Head_Inv
        # 这样当 Follow=1 时，它会保持在 Head 的相对前方，而不是跳回 Head 中心
        follow_offset_mat = aim_world_mat * head_world_mat.inverse()

        mm_follow = cmds.createNode("multMatrix", name=f"AimFollow{suffix}MMFollow")
        cmds.setAttr(f"{mm_follow}.matrixIn[0]", list(follow_offset_mat), type="matrix")
        cmds.connectAttr(f"{target_head}.worldMatrix[0]", f"{mm_follow}.matrixIn[1]")
        cmds.connectAttr(f"{parent_node}.worldInverseMatrix[0]", f"{mm_follow}.matrixIn[2]")

        # --- 3. Blend & Drive ---
        remap_node = cmds.createNode("remapValue", name=f"AimFollow{suffix}Remap")
        cmds.setAttr(f"{remap_node}.inputMin", 0)
        cmds.setAttr(f"{remap_node}.inputMax", 10)
        cmds.setAttr(f"{remap_node}.outputMin", 0)
        cmds.setAttr(f"{remap_node}.outputMax", 1)

        cmds.connectAttr(f"{ctrl_node}.follow", f"{remap_node}.inputValue")

        bm_node = cmds.createNode("blendMatrix", name=f"AimFollow{suffix}BM")

        # Base = Static (Main)
        cmds.connectAttr(f"{mm_static}.matrixSum", f"{bm_node}.inputMatrix")

        # Target = Follow (Head)
        cmds.connectAttr(f"{mm_follow}.matrixSum", f"{bm_node}.target[0].targetMatrix")

        # Connect Weight
        cmds.connectAttr(f"{remap_node}.outValue", f"{bm_node}.target[0].weight")

        # 4. Decompose
        dm_node = cmds.createNode("decomposeMatrix", name=f"AimFollow{suffix}DM")
        cmds.connectAttr(f"{bm_node}.outputMatrix", f"{dm_node}.inputMatrix")

        # 强制同步 Rotate Order，防止混合时翻转
        ro = cmds.getAttr(f"{driven_node}.rotateOrder")
        cmds.setAttr(f"{dm_node}.inputRotateOrder", ro)

        cmds.connectAttr(f"{dm_node}.outputTranslate", f"{driven_node}.translate")
        cmds.connectAttr(f"{dm_node}.outputRotate", f"{driven_node}.rotate")
        cmds.connectAttr(f"{dm_node}.outputScale", f"{driven_node}.scale")
        cmds.connectAttr(f"{dm_node}.outputShear", f"{driven_node}.shear")

        print(f"[Aim] Matrix Network (Double Offset Corrected) built for {driven_node}")

    @staticmethod
    def add_to(node: str) -> bool:
        tool.add_attribute(node, ln="aim", at="bool", dv=1, k=True)
        return True

    @staticmethod
    def remove_from(node: str) -> bool:
        return tool.remove_attribute(node, "aim")