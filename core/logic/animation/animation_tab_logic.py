# -*- coding: utf-8 -*-
"""
animation_tab_logic.py
处理动画模块的后端逻辑，包括Pose库管理、Pose应用算法以及动画辅助工具。
"""

import maya.cmds as cmds
import json
import os
import shutil
from utils import file_handler


# ========================================================
# 1. 路径管理
# ========================================================

def get_pose_dir():
    """获取 Pose 文件存储目录 (files/poses)。"""
    root = file_handler.get_project_root()
    pose_dir = os.path.join(root, "files", "poses")

    if not os.path.exists(pose_dir):
        try:
            os.makedirs(pose_dir)
        except OSError:
            return None
    return pose_dir


def get_pose_list():
    """获取所有已保存的 Pose 名称列表。"""
    pose_dir = get_pose_dir()
    if not pose_dir:
        return []

    # 查找所有 .json 文件
    files = [f.replace(".json", "") for f in os.listdir(pose_dir) if f.endswith(".json")]
    files.sort()
    return files


def get_icon_path(pose_name):
    """获取 Pose 对应的缩略图路径 (如果有)。"""
    pose_dir = get_pose_dir()
    if not pose_dir: return None

    # 支持 jpg 或 png
    jpg_path = os.path.join(pose_dir, f"{pose_name}.jpg")
    png_path = os.path.join(pose_dir, f"{pose_name}.png")

    if os.path.exists(jpg_path): return jpg_path
    if os.path.exists(png_path): return png_path
    return None


# ========================================================
# 2. Pose 库核心逻辑
# ========================================================

def save_pose(pose_name):
    """
    保存当前选中控制器的 Pose 数据 (T/R/S 和自定义属性) 以及缩略图。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择要保存 Pose 的控制器！")
        return False

    pose_dir = get_pose_dir()
    if not pose_dir: return False

    data = {}

    # 1. 采集数据
    for node in selection:
        # 获取所有 keyable 属性
        attrs = cmds.listAttr(node, keyable=True, unlocked=True) or []
        node_data = {}

        # 只记录 Transform 和自定义属性，忽略 Visibility 通常比较安全
        valid_attrs = [a for a in attrs if not a.startswith("visibility")]

        for attr in valid_attrs:
            try:
                val = cmds.getAttr(f"{node}.{attr}")
                node_data[attr] = val
            except:
                pass

        if node_data:
            # 存储时移除命名空间，方便跨文件复用
            short_name = node.split(":")[-1]
            data[short_name] = node_data

    if not data:
        return False

    # 2. 保存 JSON
    json_path = os.path.join(pose_dir, f"{pose_name}.json")
    try:
        with open(json_path, 'w') as f:
            json.dump(data, f, indent=4)
    except Exception as e:
        cmds.error(f"Pose 保存失败: {e}")
        return False

    # 3. 截取缩略图 (使用 Playblast 截取当前帧)
    img_path = os.path.join(pose_dir, f"{pose_name}.jpg")

    # 临时取消选中以获得干净的截图
    cmds.select(clear=True)

    try:
        # 使用 playblast 截取单帧
        # format='image', compression='jpg', frame=current
        cmds.playblast(
            frame=cmds.currentTime(q=True),
            format="image",
            compression="jpg",
            completeFilename=img_path,
            showOrnaments=False,  # 隐藏 HUD
            viewer=False,
            percent=100,
            widthHeight=(200, 200)  # 小缩略图
        )
    except:
        print("缩略图生成失败，但数据已保存。")

    # 恢复选中
    cmds.select(selection)

    print(f"Pose '{pose_name}' 已保存。")
    return True


def delete_pose(pose_name):
    """删除指定的 Pose 文件和缩略图。"""
    pose_dir = get_pose_dir()
    if not pose_dir: return

    json_path = os.path.join(pose_dir, f"{pose_name}.json")
    jpg_path = os.path.join(pose_dir, f"{pose_name}.jpg")
    png_path = os.path.join(pose_dir, f"{pose_name}.png")

    if os.path.exists(json_path): os.remove(json_path)
    if os.path.exists(jpg_path): os.remove(jpg_path)
    if os.path.exists(png_path): os.remove(png_path)

    print(f"Pose '{pose_name}' 已删除。")


def apply_pose(pose_name, blend_percent=100.0):
    """
    应用 Pose。
    blend_percent: 0-100，支持混合应用 (0=不变, 100=完全覆盖)。
    """
    pose_dir = get_pose_dir()
    json_path = os.path.join(pose_dir, f"{pose_name}.json")

    if not os.path.exists(json_path):
        cmds.warning(f"Pose 文件不存在: {json_path}")
        return

    # 读取数据
    with open(json_path, 'r') as f:
        pose_data = json.load(f)

    # 获取当前选中物体
    selection = cmds.ls(sl=True)

    # 如果没有选中物体，尝试按名字匹配场景中所有物体 (Namespace 处理)
    targets = []
    if not selection:
        # 简单策略：如果在场景里找不到完全匹配的，就跳过
        # 这里为了安全，通常建议用户选中控制器再应用
        cmds.warning("请选择要应用 Pose 的控制器。")
        return
    else:
        targets = selection

    # 开始应用
    # 将 blend 转换为 0.0 - 1.0
    weight = blend_percent / 100.0

    cmds.undoInfo(openChunk=True)
    try:
        for node in targets:
            # 处理命名空间: 假设 JSON 里存的是无 Namespace 的名字
            short_name = node.split(":")[-1]

            if short_name in pose_data:
                attrs_map = pose_data[short_name]

                for attr, target_val in attrs_map.items():
                    full_attr = f"{node}.{attr}"

                    if cmds.objExists(full_attr) and not cmds.getAttr(full_attr, lock=True):
                        try:
                            # 混合计算
                            current_val = cmds.getAttr(full_attr)

                            # 处理不同类型的属性 (float/int/bool)
                            # bool 通常不混合，直接覆盖
                            attr_type = cmds.getAttr(full_attr, type=True)

                            if attr_type in ['double', 'doubleLinear', 'doubleAngle', 'float']:
                                final_val = current_val + (target_val - current_val) * weight
                            else:
                                # 非数值类型，只要权重 > 50% 就直接应用
                                final_val = target_val if weight > 0.5 else current_val

                            cmds.setAttr(full_attr, final_val)
                        except:
                            pass
    finally:
        cmds.undoInfo(closeChunk=True)
        print(f"Pose '{pose_name}' 已应用 (混合: {blend_percent}%)")


def mirror_pose(selection=None):
    """
    简单的镜像 Pose 逻辑。
    交换 L_ 和 R_ 控制器的值。
    注意：这是基于世界空间或特定轴向取反的简化版。
    标准行为：Translate X 取反，Rotate Y/Z 取反 (根据绑定轴向不同而不同)。
    """
    if not selection:
        selection = cmds.ls(sl=True)

    if not selection:
        cmds.warning("请选择要镜像的控制器！")
        return

    # 简单的名称映射
    # 假设命名规范为 L_Name / R_Name
    mapping = {}
    for node in selection:
        short_name = node.split(":")[-1]
        namespace = node.rpartition(":")[0]
        prefix = namespace + ":" if namespace else ""

        target_name = ""
        if short_name.startswith("L_"):
            target_name = prefix + short_name.replace("L_", "R_", 1)
        elif short_name.startswith("R_"):
            target_name = prefix + short_name.replace("R_", "L_", 1)

        if target_name and cmds.objExists(target_name):
            mapping[node] = target_name

    if not mapping:
        cmds.warning("未找到可镜像的对称控制器 (需 L_/R_ 前缀)。")
        return

    # 开始镜像
    cmds.undoInfo(openChunk=True)
    try:
        # 1. 读取所有源数据
        source_data = {}
        attrs_to_mirror = ['tx', 'ty', 'tz', 'rx', 'ry', 'rz', 'sx', 'sy', 'sz']

        for src in mapping.keys():
            source_data[src] = {}
            for attr in attrs_to_mirror:
                if cmds.attributeQuery(attr, node=src, exists=True):
                    source_data[src][attr] = cmds.getAttr(f"{src}.{attr}")

        # 2. 应用到目标 (带轴向取反)
        # 常见镜像轴向规则 (根据绑定系统可能需要调整):
        # TX -> -TX
        # TY -> TY
        # TZ -> TZ
        # RX -> RX
        # RY -> -RY
        # RZ -> -RZ

        mirror_rules = {
            'tx': -1, 'ty': 1, 'tz': 1,
            'rx': 1, 'ry': -1, 'rz': -1,
            'sx': 1, 'sy': 1, 'sz': 1
        }

        for src, tgt in mapping.items():
            if src not in source_data: continue

            for attr, val in source_data[src].items():
                if cmds.getAttr(f"{tgt}.{attr}", lock=True): continue

                # 应用镜像规则
                mult = mirror_rules.get(attr, 1)
                final_val = val * mult

                cmds.setAttr(f"{tgt}.{attr}", final_val)

    finally:
        cmds.undoInfo(closeChunk=True)
        print("Pose 镜像完成。")


# ========================================================
# 3. 动画工具集逻辑
# ========================================================

def bake_animation():
    """
    烘焙选中物体的动画 (Simulation Bake)。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择要烘焙的对象！")
        return

    start = cmds.playbackOptions(q=True, min=True)
    end = cmds.playbackOptions(q=True, max=True)

    cmds.bakeResults(
        selection,
        simulation=True,
        t=(start, end),
        sampleBy=1,
        disableImplicitControl=True,
        preserveOutsideKeys=True,
        sparseAnimCurveBake=False,
        removeBakedAttributeFromLayer=False,
        bakeOnOverrideLayer=False,
        controlPoints=False,
        shape=True
    )
    print(f"已烘焙动画: {start} - {end}")


def create_motion_trail():
    """
    为选中物体创建运动轨迹。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择要创建轨迹的物体！")
        return

    # Maya 现代版运动轨迹
    # snapshot -motionTrail 1
    for node in selection:
        cmds.snapshot(node, motionTrail=True, increment=1, startTime=cmds.playbackOptions(q=True, min=True),
                      endTime=cmds.playbackOptions(q=True, max=True))

    print("运动轨迹已创建。")


def tween_machine(bias=0.5):
    """
    简单的中间帧计算工具 (Tween Machine)。
    bias: 0.0 (上一帧) <-> 0.5 (中间) <-> 1.0 (下一帧)
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择控制器！")
        return

    current_time = cmds.currentTime(q=True)

    cmds.undoInfo(openChunk=True)
    try:
        for node in selection:
            attrs = cmds.listAttr(node, keyable=True, unlocked=True) or []
            valid_attrs = [a for a in attrs if cmds.keyframe(f"{node}.{a}", q=True, keyframeCount=True)]

            for attr in valid_attrs:
                full_attr = f"{node}.{attr}"

                # 找前后关键帧
                prev_key = cmds.findKeyframe(full_attr, time=(current_time,), which="previous")
                next_key = cmds.findKeyframe(full_attr, time=(current_time,), which="next")

                # 如果没有前后帧，跳过
                if prev_key == current_time or next_key == current_time:
                    continue

                val_prev = cmds.keyframe(full_attr, time=(prev_key,), q=True, value=True)[0]
                val_next = cmds.keyframe(full_attr, time=(next_key,), q=True, value=True)[0]

                # 线性插值计算
                new_val = val_prev + (val_next - val_prev) * bias

                cmds.setKeyframe(full_attr, time=current_time, value=new_val)

    except Exception as e:
        print(f"Tween Error: {e}")
    finally:
        cmds.undoInfo(closeChunk=True)
        print(f"Tween 应用完成 (Bias: {bias})")