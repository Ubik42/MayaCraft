# -*- coding: utf-8 -*-
"""
skinning_tab_logic.py
处理蒙皮模块的后端逻辑，包括权重读写、复制粘贴、镜像等操作。
"""

import maya.cmds as cmds
import maya.mel as mel
import json
import os

# 用于内存中临时存储复制的权重
_WEIGHT_CLIPBOARD = {}


def get_skin_cluster(node):
    """
    获取节点的 SkinCluster。
    """
    if not cmds.objExists(node):
        return None

    history = cmds.listHistory(node, pruneDagObjects=True) or []
    for hist in history:
        if cmds.nodeType(hist) == "skinCluster":
            return hist
    return None


# ========================================================
# 1. 权重 I/O (JSON)
# ========================================================

def export_weights(file_path):
    """
    将当前选中模型的权重导出为 JSON 文件。
    数据包含：骨骼列表、顶点坐标(用于位置匹配)、权重数据。
    """
    if not file_path:
        cmds.warning("请指定导出路径！")
        return False

    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择一个带有蒙皮的模型！")
        return False

    mesh = selection[0]
    sc = get_skin_cluster(mesh)
    if not sc:
        cmds.warning(f"对象 {mesh} 没有蒙皮 (SkinCluster)。")
        return False

    # 获取所有影响关节
    joints = cmds.skinCluster(sc, query=True, influence=True)

    # 获取顶点数量
    # 假设是 Mesh，如果是 NURBS 需要稍微调整
    vtx_count = cmds.polyEvaluate(mesh, vertex=True)

    weights_data = {}

    # 开始导出
    # 注意：为了性能，这里使用较为基础的遍历。
    # 对于超高模，建议使用 OpenMaya API 进行优化，这里演示 cmds 标准做法。
    try:
        cmds.waitCursor(state=True)

        # 批量获取所有权重 (返回一个巨大的列表 [j1_v1, j2_v1, ..., j1_v2, ...])
        # 这比逐个顶点查询要快得多
        # format: list of weights for all influences for all components
        flat_weights = cmds.getAttr(f"{sc}.weightList[0:{vtx_count - 1}].weights")

        # 获取顶点位置 (用于按位置导入)
        # flatten=True 返回 [x1, y1, z1, x2, y2, z2...]
        points = cmds.xform(f"{mesh}.vtx[*]", query=True, worldSpace=True, translation=True)

        num_joints = len(joints)

        export_data = {
            "source_mesh": mesh,
            "joints": joints,
            "vertex_count": vtx_count,
            "vertices": []
        }

        # 组装数据
        for i in range(vtx_count):
            # 获取当前顶点的坐标
            pt = [points[i * 3], points[i * 3 + 1], points[i * 3 + 2]]

            # 获取当前顶点的权重字典 {joint_name: value}
            # flat_weights 可能会省略 0 值，但在 cmds.getAttr 中通常是规整的
            # getAttr 返回的结构可能比较复杂，这取决于 Maya 版本，
            # 更稳妥的方式是使用 skinPercent (慢) 或者 skinCluster -q -w (慢)
            # 这里为了演示稳定性，我们用 skinPercent 查询非零权重

            # 优化：仅存储非零权重以减小文件体积
            # 这里的逻辑如果用 Python 循环 getAttr 会慢，
            # 生产环境通常用 OpenMaya MFnSkinCluster.getWeights

            # --- 简易版实现 (逐个查询，速度较慢但逻辑简单) ---
            vtx_str = f"{mesh}.vtx[{i}]"
            val_list = cmds.skinPercent(sc, vtx_str, query=True, value=True)

            w_dict = {}
            for j_idx, w in enumerate(val_list):
                if w > 0.001:  # 忽略极小值
                    w_dict[joints[j_idx]] = w

            export_data["vertices"].append({
                "index": i,
                "pos": pt,
                "weights": w_dict
            })

        # 写入文件
        # 自动补全 .json
        if not file_path.endswith(".json"):
            file_path += ".json"

        with open(file_path, 'w') as f:
            json.dump(export_data, f, indent=None)  # indent=None 减小体积

        print(f"成功导出权重至: {file_path}")
        return True

    except Exception as e:
        cmds.error(f"导出失败: {e}")
        return False
    finally:
        cmds.waitCursor(state=False)


def import_weights(file_path, mode="index"):
    """
    从 JSON 导入权重。
    mode: "index" (按顶点序号) | "position" (按空间位置)
    """
    if not file_path or not os.path.exists(file_path):
        cmds.warning("文件路径无效或不存在。")
        return False

    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择要导入权重的目标模型！")
        return False

    target_mesh = selection[0]

    # 1. 读取数据
    try:
        with open(file_path, 'r') as f:
            data = json.load(f)
    except Exception as e:
        cmds.error(f"读取文件失败: {e}")
        return False

    joints = data.get("joints", [])
    if not joints:
        cmds.warning("文件中未找到骨骼信息。")
        return False

    # 2. 确保目标有 SkinCluster，并且骨骼匹配
    sc = get_skin_cluster(target_mesh)
    if not sc:
        # 如果没有蒙皮，尝试自动蒙皮
        # 检查场景中是否存在这些骨骼
        missing_joints = [j for j in joints if not cmds.objExists(j)]
        if missing_joints:
            cmds.error(f"场景中缺少以下骨骼，无法创建蒙皮: {missing_joints}")
            return False

        # 创建蒙皮
        sc = cmds.skinCluster(joints, target_mesh, toSelectedBones=True, maximumInfluences=4)[0]
    else:
        # 如果已有蒙皮，添加缺失的骨骼影响
        existing_infls = cmds.skinCluster(sc, query=True, influence=True)
        for j in joints:
            if j not in existing_infls and cmds.objExists(j):
                cmds.skinCluster(sc, edit=True, addInfluence=j, weight=0)

    # 3. 应用权重
    try:
        cmds.waitCursor(state=True)
        # 关闭蒙皮的归一化，防止设置过程中权重乱跳
        cmds.setAttr(f"{sc}.normalizeWeights", 0)

        # 预先清理权重：将所有权重设为0 (或者我们在设置时覆盖)

        vertices_data = data.get("vertices", [])

        if mode == "index":
            for v_data in vertices_data:
                idx = v_data["index"]
                weights = v_data["weights"]  # {joint: value}

                # 组装 transformValue 列表 [(joint, val), (joint, val)...]
                tv_list = []
                for jnt, val in weights.items():
                    if cmds.objExists(jnt):
                        tv_list.append((jnt, val))

                if tv_list:
                    cmds.skinPercent(sc, f"{target_mesh}.vtx[{idx}]", transformValue=tv_list)

        elif mode == "position":
            # 位置匹配 (简单的最近点查找 - 速度较慢，适用于低模)
            # 对于生产级高模，通常使用 k-d tree 算法加速，或者使用 Maya API
            target_vtx_count = cmds.polyEvaluate(target_mesh, vertex=True)
            target_positions = cmds.xform(f"{target_mesh}.vtx[*]", query=True, worldSpace=True, translation=True)

            # 构建源数据的简单查找结构 (这里简单遍历，O(N^2)，慎用)
            # 优化：我们假设用户至少位置大致重合
            # 为了演示，这里只写简单逻辑：

            print("正在按位置匹配权重 (速度较慢)...")

            # 将源数据转为 list 以便遍历
            source_points = []
            source_weights = []
            for v in vertices_data:
                source_points.append(v["pos"])
                source_weights.append(v["weights"])

            for i in range(target_vtx_count):
                t_pt = (target_positions[i * 3], target_positions[i * 3 + 1], target_positions[i * 3 + 2])

                # 寻找最近的源点 (简单的距离比较)
                closest_dist = 999999999.0
                closest_idx = -1

                for src_i, s_pt in enumerate(source_points):
                    # dist squared
                    dist = (t_pt[0] - s_pt[0]) ** 2 + (t_pt[1] - s_pt[1]) ** 2 + (t_pt[2] - s_pt[2]) ** 2
                    if dist < closest_dist:
                        closest_dist = dist
                        closest_idx = src_i
                        if dist < 0.0001:  # 足够近，直接跳出
                            break

                if closest_idx != -1:
                    weights = source_weights[closest_idx]
                    tv_list = [(j, w) for j, w in weights.items() if cmds.objExists(j)]
                    if tv_list:
                        cmds.skinPercent(sc, f"{target_mesh}.vtx[{i}]", transformValue=tv_list)

        # 恢复归一化
        cmds.setAttr(f"{sc}.normalizeWeights", 1)
        cmds.skinCluster(sc, edit=True, forceNormalizeWeights=True)

        print("权重导入完成。")
        return True

    except Exception as e:
        cmds.error(f"导入失败: {e}")
        return False
    finally:
        cmds.waitCursor(state=False)


# ========================================================
# 2. 权重工具集
# ========================================================

def copy_weights():
    """复制选中组件的权重到内存"""
    global _WEIGHT_CLIPBOARD

    selection = cmds.ls(sl=True, fl=True)  # fl=True 展开顶点
    if not selection:
        cmds.warning("请选择要复制权重的顶点！")
        return

    # 只取第一个选中的顶点作为源
    source_vtx = selection[0]
    mesh = source_vtx.split(".")[0]
    sc = get_skin_cluster(mesh)

    if not sc:
        cmds.warning("选中的对象没有蒙皮。")
        return

    # 获取权重值列表
    weights = cmds.skinPercent(sc, source_vtx, query=True, value=True)
    # 获取影响骨骼列表
    influences = cmds.skinCluster(sc, query=True, influence=True)

    # 存入剪贴板 {joint: value}
    _WEIGHT_CLIPBOARD = dict(zip(influences, weights))

    print(f"已复制顶点 {source_vtx} 的权重。")


def paste_weights():
    """将内存中的权重应用到选中的组件"""
    global _WEIGHT_CLIPBOARD
    if not _WEIGHT_CLIPBOARD:
        cmds.warning("剪贴板为空，请先复制权重。")
        return

    selection = cmds.ls(sl=True, fl=True)
    if not selection:
        cmds.warning("请选择要粘贴权重的顶点！")
        return

    # 检查目标是否有 skinCluster
    # 假设所有选中点属于同一个 mesh，或者分开处理
    # 为了稳健，我们逐个 mesh 处理 (虽然通常选中点都在一个 mesh 上)

    meshes_processed = set()

    cmds.waitCursor(state=True)
    try:
        tv_list = []  # Transform Value List

        # 预先检查所有骨骼是否存在于场景
        valid_clipboard = [(j, w) for j, w in _WEIGHT_CLIPBOARD.items() if cmds.objExists(j)]

        if not valid_clipboard:
            cmds.warning("剪贴板中的骨骼在场景中不存在。")
            return

        for item in selection:
            mesh = item.split(".")[0]
            if mesh not in meshes_processed:
                sc = get_skin_cluster(mesh)
                if not sc:
                    print(f"跳过 {mesh}: 没有蒙皮。")
                    continue

                # 确保所有影响骨骼都在目标的 skinCluster 里
                current_infls = cmds.skinCluster(sc, query=True, influence=True)
                for jnt, val in valid_clipboard:
                    if jnt not in current_infls and val > 0:
                        cmds.skinCluster(sc, edit=True, addInfluence=jnt, weight=0)

                meshes_processed.add(mesh)

            # 粘贴
            # 这是一个比较慢的操作，如果点很多建议用 API
            # 这里简单调用 cmds
            if sc:
                cmds.skinPercent(sc, item, transformValue=valid_clipboard)

        print("权重已粘贴。")

    finally:
        cmds.waitCursor(state=False)


def mirror_weights():
    """
    镜像权重 (X轴镜像: +X -> -X)。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择要镜像权重的模型！")
        return

    for mesh in selection:
        sc = get_skin_cluster(mesh)
        if not sc: continue

        # 使用 Maya 内置的 Copy Skin Weights 进行镜像
        # 这里的参数是典型的：YZ平面镜像 (Mirror across X), 方向正向负
        cmds.copySkinWeights(
            ss=sc, ds=sc,
            mirrorMode='YZ',
            surfaceAssociation='closestPoint',
            influenceAssociation=['label', 'oneToOne', 'name']
        )
    print("镜像权重完成 (YZ Plane, +X to -X)。")


def smooth_weights():
    """
    平滑选中顶点的权重。
    使用 Maya Paint Skin Weights Tool 的 Smooth Flood 功能。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择模型或顶点进行平滑！")
        return

    # 1. 确保进入组件模式或选中了模型
    # 2. 调用平滑命令
    # Maya 没有直接的 "smooth skin on selection" 命令，
    # 最接近的是通过 mel 调用 ArtPaintSkinWeightsTool 的 Flood

    # 简单实现：使用 polyAverageVertex 虽然是平滑模型，但我们是要平滑权重
    # 正确做法是使用 skinCluster 的 smoothWeights (Maya 2023+ API?)
    # 或者用比较传统的 mel trick

    try:
        # 获取当前上下文
        current_ctx = cmds.currentCtx()

        # 激活蒙皮绘制工具
        mel.eval("artAttrSkinToolScript 4;")  # 4 = Smooth

        # 设置为 Smooth 模式
        cmds.artAttrSkinPaintCtx('artAttrSkinContext', edit=True, selectedattroper='smooth')

        # 执行 Flood (淹没)
        cmds.artAttrSkinPaintCtx('artAttrSkinContext', edit=True, clear=True)

        print("已执行平滑 (Smooth Flood)。")

        # 恢复之前的工具 (可选，有时用户希望留在绘制工具里)
        # cmds.setToolTo(current_ctx)

    except Exception as e:
        print(f"平滑失败: {e}")


def prune_weights(threshold=0.01):
    """
    移除小于阈值的微小权重。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择模型！")
        return

    for item in selection:
        # 如果选的是顶点，找到对应的 mesh
        if ".vtx" in item:
            mesh = item.split(".")[0]
        else:
            mesh = item

        sc = get_skin_cluster(mesh)
        if sc:
            cmds.skinPercent(sc, item, pruneWeights=threshold)

    print(f"已移除小于 {threshold} 的权重。")


def remove_unused_influences():
    """
    从 SkinCluster 中移除未使用的骨骼 (权重全为0的骨骼)。
    """
    selection = cmds.ls(sl=True)
    if not selection:
        cmds.warning("请选择模型！")
        return

    count = 0
    for node in selection:
        # 确保选中的是物体
        if ".vtx" in node:
            node = node.split(".")[0]

        sc = get_skin_cluster(node)
        if sc:
            # 这是一个简单的内置命令
            # 找到所有影响
            joints = cmds.skinCluster(sc, query=True, influence=True)
            weighted_joints = cmds.skinCluster(sc, query=True, weightedInfluence=True)

            unused = list(set(joints) - set(weighted_joints))

            if unused:
                cmds.skinCluster(sc, edit=True, removeInfluence=unused)
                count += len(unused)
                print(f"从 {node} 移除了 {len(unused)} 个未使用骨骼。")
            else:
                print(f"{node} 没有未使用的骨骼。")

    cmds.inViewMessage(amg=f'<span style=\"color: #00FF00;\">清理完成，移除了 {count} 个影响物体。</span>',
                       pos='midCenter', fade=True)