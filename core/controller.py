# -*- coding: utf-8 -*-
import maya.cmds as cmds
import json
import os
import math

# 导入文件处理通用模块
from utils import file_handler

"""
controller.py
用于管理 Maya 控制器形状数据的提取与应用（替换）。
"""


# ==========================================
# 1. 路径与文件管理
# ==========================================

def get_shape_dir():
    root = file_handler.get_project_root()
    shape_dir = os.path.join(root, "files", "shape")
    if not os.path.exists(shape_dir):
        try:
            os.makedirs(shape_dir)
        except OSError as e:
            cmds.error(f"无法创建目录: {shape_dir}. Error: {e}")
            return None
    return shape_dir


# ==========================================
# 2. 核心逻辑 (提取与替换)
# ==========================================

def get_shape_data(node):
    if not cmds.objExists(node): return None
    shapes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
    shapes_data = []
    for shape in shapes:
        if cmds.nodeType(shape) != 'nurbsCurve': continue
        cvs = cmds.getAttr(shape + '.cv[*]')
        if not isinstance(cvs, list): cvs = [cvs]
        points = [list(pt) for pt in cvs]
        degree = cmds.getAttr(shape + '.degree')
        form = cmds.getAttr(shape + '.form')
        color_data = {}
        if cmds.getAttr(shape + '.overrideEnabled'):
            color_data['enabled'] = True
            if cmds.getAttr(shape + '.overrideRGBColors'):
                color_data['rgb'] = cmds.getAttr(shape + '.overrideColorRGB')[0]
                color_data['mode'] = 'rgb'
            else:
                color_data['index'] = cmds.getAttr(shape + '.overrideColor')
                color_data['mode'] = 'index'
        else:
            color_data['enabled'] = False
        shape_info = {'points': points, 'degree': degree, 'form': form, 'color': color_data}
        shapes_data.append(shape_info)
    return shapes_data


# ==========================================
# [新增] 供外部模块调用的高层接口
# ==========================================


def apply_stored_shape(target_node, shape_name):
    """
    高层接口：从库中查找并应用形状。
    供 ik.py 等模块直接调用。
    """
    if not cmds.objExists(target_node): return False

    shape_dir = get_shape_dir()
    if not shape_dir: return False

    # 自动补全后缀
    filename = shape_name if shape_name.endswith(".json") else f"{shape_name}.json"
    file_path = os.path.join(shape_dir, filename)

    if os.path.exists(file_path):
        try:
            with open(file_path, 'r') as f:
                shape_data = json.load(f)
            replace_shape(target_node, shape_data)
            return True
        except:
            pass

    return False
def replace_shape(target_node, shape_data_list):
    """
    将 target_node 的形状替换为数据中的形状。
    也可用于给空 Transform 添加形状。
    """
    if not cmds.objExists(target_node): return

    # 1. 删除旧 Shape (如果有)
    old_shapes = cmds.listRelatives(target_node, shapes=True, fullPath=True)
    if old_shapes:
        cmds.delete(old_shapes)

    # 2. 创建新 Shape
    temp_transforms = []

    for shape_info in shape_data_list:
        points = shape_info['points']
        degree = shape_info['degree']
        form = shape_info['form']

        # 创建临时曲线
        tmp_curve = cmds.curve(p=points, degree=degree)

        # 闭合处理
        if form > 0:
            try:
                cmds.closeCurve(tmp_curve, ch=False, ps=0, rpo=1, bb=0.5, bki=0, p=0.1)
            except:
                pass

        # 颜色处理
        color_info = shape_info.get('color', {})
        tmp_shape = cmds.listRelatives(tmp_curve, shapes=True)[0]

        if color_info.get('enabled'):
            cmds.setAttr(f"{tmp_shape}.overrideEnabled", 1)
            if color_info.get('mode') == 'rgb':
                rgb = color_info['rgb']
                cmds.setAttr(f"{tmp_shape}.overrideRGBColors", 1)
                cmds.setAttr(f"{tmp_shape}.overrideColorRGB", rgb[0], rgb[1], rgb[2])
            elif color_info.get('mode') == 'index':
                idx = color_info['index']
                cmds.setAttr(f"{tmp_shape}.overrideRGBColors", 0)
                cmds.setAttr(f"{tmp_shape}.overrideColor", idx)

        temp_transforms.append(tmp_curve)

    # 3. 将新 Shape Parent 给目标
    for tmp in temp_transforms:
        shapes = cmds.listRelatives(tmp, shapes=True)
        if shapes:
            cmds.parent(shapes[0], target_node, relative=True, shape=True)
        cmds.delete(tmp)

    # 4. 重命名 Shape (清理命名)
    new_shapes = cmds.listRelatives(target_node, shapes=True)
    if new_shapes:
        for i, shp in enumerate(new_shapes):
            suffix = "" if i == 0 else str(i)
            # 获取纯名称，不带路径
            short_target_name = target_node.split("|")[-1]
            desired_name = f"{short_target_name}Shape{suffix}"
            if shp != desired_name:
                try:
                    cmds.rename(shp, desired_name)
                except:
                    pass


def save_curve(filename=None):
    """保存选中控制器的形状"""
    selection = cmds.ls(selection=True)
    if not selection:
        cmds.warning("请先选择一个控制器！")
        return False
    target_node = selection[0]
    data = get_shape_data(target_node)
    if not data:
        cmds.warning("选中的物体没有 NURBS 曲线 Shape。")
        return False
    save_dir = get_shape_dir()
    if not save_dir: return False

    if not filename or filename.strip() == "":
        short_name = target_node.split("|")[-1]
        safe_name = short_name.replace(":", "_")
        filename = f"{safe_name}.json"
    else:
        if not filename.endswith(".json"): filename += ".json"

    file_path = os.path.join(save_dir, filename)
    try:
        with open(file_path, 'w') as f:
            json.dump(data, f, indent=4)
        print(f"成功保存: {file_path}")
        return True
    except Exception as e:
        cmds.error(f"保存失败: {e}")
        return False


# ==========================================
# 3. 库管理 (Import Library)
# ==========================================

def import_all_to_grid():
    """
    【新功能】一键导入所有控制器到场景。
    1. 创建 Shapes 组。
    2. 读取文件夹内所有 JSON。
    3. 创建新物体并应用形状。
    4. 按网格排列。
    """
    directory = get_shape_dir()
    if not directory or not os.path.exists(directory):
        cmds.warning("形状库目录不存在。")
        return 0

    files = [f for f in os.listdir(directory) if f.endswith(".json")]
    if not files:
        cmds.warning("形状库为空。")
        return 0

    files.sort()

    # 1. 准备组
    root_grp = "Shapes"
    if not cmds.objExists(root_grp):
        cmds.createNode("transform", name=root_grp)

    count = 0

    # 2. 网格排布参数
    columns = 10  # 每行放10个
    spacing = 15  # 间距 (根据控制器大小调整)

    for i, f in enumerate(files):
        # 名字处理
        name_base = f.replace(".json", "")

        file_path = os.path.join(directory, f)

        try:
            with open(file_path, 'r') as json_file:
                shape_data = json.load(json_file)

            # 3. 创建新物体
            # 使用 createNode 自动处理重名 (Maya 会自动加数字后缀)
            new_ctrl = cmds.createNode("transform", name=name_base, parent=root_grp)

            # 4. 赋予形状
            replace_shape(new_ctrl, shape_data)

            # 5. 排布位置 (X, Z 平面)
            row = i // columns
            col = i % columns

            x_pos = col * spacing
            z_pos = row * spacing

            cmds.xform(new_ctrl, translation=(x_pos, 0, z_pos))

            count += 1

        except Exception as e:
            print(f"导入 {name_base} 失败: {e}")

    # 选中组，方便用户查看
    cmds.select(root_grp)
    return count


def set_color(rgb_color):
    """设置 RGB 颜色"""
    selection = cmds.ls(selection=True)
    if not selection: return 0
    for node in selection:
        shapes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
        nodes_to_color = [node] + shapes
        for item in nodes_to_color:
            try:
                cmds.setAttr(f"{item}.overrideEnabled", 1)
                cmds.setAttr(f"{item}.overrideRGBColors", 1)
                cmds.setAttr(f"{item}.overrideColorRGB", rgb_color[0], rgb_color[1], rgb_color[2])
            except:
                pass
    return len(selection)