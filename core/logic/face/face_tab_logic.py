# core/logic/face/face_ui_logic.py
# -*- coding: utf-8 -*-
import maya.cmds as cmds

# 导入 MFace 核心模块
# 确保 core/face/__init__.py 存在，且文件夹内包含相应 .py 文件
# try:
from core.face import selection, build
from core.face.utils import actions
from core.face.systems import bulge, brow, cheek, nose, eye, lip, jaw
# except ImportError as e:
#     print(f"MFace Core Import Error: {e}")
#     selection = None
#     build = None
#     actions = None


def create_locator(part, locator_type, name="", side=""):
    """
    根据参数动态构建函数名并执行。
    """
    if not selection:
        cmds.warning("MFace selection ik_label not loaded.")
        return

    # 组合 1: Selection + Part + Name + Type (最常见)
    func_name_1 = f"Selection{part}{name}{locator_type}"

    # 组合 2: Selection + Part + Side + Name + Type
    func_name_2 = f"Selection{part}{side}{name}{locator_type}"

    # 组合 3: Selection + Part + Type
    func_name_3 = f"Selection{part}{locator_type}"

    target_func = None

    if hasattr(selection, func_name_1):
        target_func = func_name_1
    elif hasattr(selection, func_name_2):
        target_func = func_name_2
    elif hasattr(selection, func_name_3):
        target_func = func_name_3

    if target_func:
        print(f"Executing: selection.{target_func}()")
        try:
            getattr(selection, target_func)()
        except Exception as e:
            cmds.warning(f"Error executing {target_func}: {e}")
    else:
        cmds.warning(f"未找到创建函数。尝试了: {func_name_1}, {func_name_2}, {func_name_3}")


def build_selected(part):
    """
    绑定选择的部分 (Single Module Build)。
    """
    module_map = {
        "brow": brow.brow_rig,
        "eye": eye.eye_rig,
        "jaw": jaw.jaw_rig,
        "lip": lip.lip_rig,
        "nose": nose.nose_rig,
        "cheek": cheek.check_rig,  # 注意 cheek.py 对应 cheek
        "bulge": bulge.bulge_rig
    }

    part_key = part.lower()

    if part_key in module_map:
        try:
            print(f"Building {part_key}...")
            module_map[part_key]()
            print(f"{part_key} Build Done.")
        except Exception as e:
            cmds.error(f"Build {part_key} Failed: {e}")
    else:
        cmds.warning(f"不支持单独绑定: {part} (或模块导入失败)")


def run_build_all():
    """
    [修复] 函数名改为 run_build_all 以匹配 UI 调用。
    执行 MFace 的完整构建流程。
    """
    if build:
        try:
            print("Starting MFace Build...")
            build.build()
            print("MFace Build Complete.")
        except Exception as e:
            cmds.error(f"MFace Build Failed: {e}")
    else:
        cmds.error("MFace 'build' ik_label not found.")


def update_second():
    """
    合并驱动 / 更新次级控制器吸附。
    """
    if not actions:
        cmds.warning("MFace 'actions' ik_label not found.")
        return

    # 获取当前选中的面部模型
    sel = cmds.ls(sl=True)
    if sel:
        actions.update_second(sel[0])
        print(f"Updated second for selected: {sel[0]}")
    else:
        # 尝试自动找 FaceSelectionGroup 里的记录
        grp = "FaceSelectionGroup"
        if cmds.objExists(grp) and cmds.attributeQuery("face", node=grp, exists=True):
            face = cmds.getAttr(f"{grp}.face")
            if cmds.objExists(face):
                actions.update_second(face)
                print(f"Updated second for auto-detected face: {face}")
                return

        cmds.warning("请选择面部模型 (Mesh) 后再点击合并驱动。")