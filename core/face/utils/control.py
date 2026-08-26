# coding:utf-8
import json
import os
import pymel.core as pm

# ==========================================
# 路径配置修复
# ==========================================
# 当前文件所在目录 (.../core/face/utils)
UTILS_DIR = os.path.dirname(os.path.abspath(__file__))
# 上一级目录 (.../core/face)
FACE_DIR = os.path.dirname(UTILS_DIR)
# 目标控件目录 (.../core/face/controls)
CONTROLS_DIR = os.path.join(FACE_DIR, "controls")

# 确保目录存在，防止写入时报错
if not os.path.exists(CONTROLS_DIR):
    try:
        os.makedirs(CONTROLS_DIR)
    except OSError:
        pass


# ==========================================
# 辅助函数
# ==========================================

def get_selected_curves():
    selected = pm.selected(o=1, type="transform")
    if not len(selected):
        pm.warning("you should select curve")
        return []
    curves = []
    for curve in selected:
        curve_shape = curve.getShape()
        if not curve_shape:
            continue
        # 兼容性：检查是否为 NurbsCurve
        if hasattr(curve_shape, 'type') and curve_shape.type() != "nurbsCurve":
            continue
        curves.append(curve)
    if not curves:
        pm.warning("you should select curve")
        return []
    return curves


def get_selected_curve():
    curves = get_selected_curves()
    if len(curves) != 1:
        return pm.warning("you should select curve")
    return curves[0]


def get_curve_shape_points(shape):
    if not shape: return []
    points = pm.xform(shape.cv, q=1, t=1)
    return [points[i: i + 3] for i in range(0, len(points), 3)]


def set_curve_shape_points(shape, points):
    for i, point in enumerate(points):
        pm.xform(shape.cv[i], t=point)


def get_curve_data(curve):
    return [dict(points=get_curve_shape_points(shape),
                 degree=shape.degree(),
                 periodic=curve.form() == 3,
                 knot=shape.getKnots())
            for shape in curve.getShapes()]


def control_upload(curve=None, n=None, f=True):
    """
    保存控制器形状到 /face/controls/ 文件夹
    """
    if curve is None:
        curve = get_selected_curve()
    if curve is None:
        return
    if n is None:
        n = curve.name().split("|")[-1].split(":")[0]

    # 使用修正后的路径
    path = os.path.join(CONTROLS_DIR, n + ".json")

    if os.path.isfile(path) and not f:
        return

    with open(path, "w") as write:
        write.write(json.dumps(get_curve_data(curve), indent=4))
    print(f"Control shape saved: {path}")


def set_curve_shape_scale(shape, scale):
    points = get_curve_shape_points(shape)
    points = [[xyz * scale for xyz in point] for point in points]
    set_curve_shape_points(shape, points)


def set_curve_radius(curve=None, radius=None):
    """
    [安全版] 设置控制器半径，防止空Shape报错
    """
    if curve is None:
        curve = get_selected_curve()
    if curve is None:
        return

    shapes = curve.getShapes()
    if not shapes:
        # 没有任何形状，直接返回，防止 max() 报错
        return

    if radius is None:
        try:
            radius = pm.softSelect(q=1, ssd=1)
        except Exception:
            radius = 1.0

    distances = []
    for shape in shapes:
        points = get_curve_shape_points(shape)
        for point in points:
            dist = (sum([xyz ** 2 for xyz in point])) ** 0.5
            distances.append(dist)

    if not distances:
        return

    max_dist = max(distances)
    if max_dist <= 0.0001:
        return

    scale = radius / max_dist
    for shape in curve.getShapes():
        set_curve_shape_scale(shape, scale)


def set_curve_name(curve, n):
    if curve is None:
        curve = get_selected_curve()
    if curve is None:
        return
    curve.rename(n)
    for i, shape in enumerate(curve.getShapes()):
        if i:
            shape.rename(n + "Shape" + str(i))
        else:
            shape.rename(n + "Shape")


def set_curve_color(curve, c):
    for shape in curve.getShapes():
        shape.overrideEnabled.set(1)
        shape.overrideColor.set(c)


def set_curve_parent(curve, p):
    try:
        curve.setParent(p)
        curve.t.set(0, 0, 0)
        curve.r.set(0, 0, 0)
        curve.s.set(1, 1, 1)
    except Exception as e:
        print(f"Parent warning: {e}")


def set_curve_locked(curve, l):
    for attr in l:
        if curve.hasAttr(attr):
            curve.attr(attr).setLocked(True)
            curve.attr(attr).setKeyable(False)


def _create_internal_shape(curve, shape_type):
    """
    [新增] 备用方案：当JSON文件找不到时，用代码直接画。
    这能防止 'ball.json' 缺失导致的崩溃。
    """
    temp_curve = None

    if shape_type == "ball":
        # 球体：3个圆环
        c1 = pm.circle(nr=(1, 0, 0), ch=0)[0]
        c2 = pm.circle(nr=(0, 1, 0), ch=0)[0]
        c3 = pm.circle(nr=(0, 0, 1), ch=0)[0]
        pm.parent(c2.getShape(), c1, r=True, s=True)
        pm.parent(c3.getShape(), c1, r=True, s=True)
        pm.delete(c2, c3)
        temp_curve = c1

    elif shape_type == "square":
        pts = [(-1, 0, -1), (1, 0, -1), (1, 0, 1), (-1, 0, 1), (-1, 0, -1)]
        temp_curve = pm.curve(d=1, p=pts)

    elif shape_type == "cube":
        p = 0.5
        pts = [
            (-p, -p, -p), (p, -p, -p), (p, -p, p), (-p, -p, p), (-p, -p, -p),
            (-p, p, -p), (p, p, -p), (p, p, p), (-p, p, p), (-p, p, -p),
            (-p, p, -p), (p, p, -p), (p, -p, -p), (p, -p, p), (p, p, p),
            (-p, p, p), (-p, -p, p)
        ]
        temp_curve = pm.curve(d=1, p=pts)

    if temp_curve:
        # 删除旧Shape
        pm.delete(curve.getShapes())
        # 转移新Shape
        for shp in temp_curve.getShapes():
            pm.parent(shp, curve, r=True, s=True)
        pm.delete(temp_curve)

        # 重命名
        base_name = curve.name().split("|")[-1]
        for i, s in enumerate(curve.getShapes()):
            s.rename(f"{base_name}Shape{i + 1}" if i > 0 else f"{base_name}Shape")
        return True
    return False


def set_curve_shape(curve, s):
    # 使用修正后的 CONTROLS_DIR 路径
    path = os.path.join(CONTROLS_DIR, s + ".json")

    # 1. 尝试从文件加载
    if os.path.isfile(path):
        try:
            with open(path, "r") as read:
                data = json.loads(read.read())

            pm.delete(curve.getShapes())
            for i, shape in enumerate(data):
                p = shape["points"]
                if shape["periodic"]:
                    p = p + p[:shape["degree"]]
                temp = pm.curve(p=p, d=shape["degree"], periodic=shape["periodic"], k=shape["knot"])
                temp.getShape().setParent(curve, s=1, add=1)
                pm.delete(temp)

            for i, shp in enumerate(curve.getShapes()):
                shp.rename(shp.rename(curve.name().split("|")[-1] + "Shape"))
            return  # 成功加载，直接返回
        except Exception as e:
            pm.warning(f"Failed to load JSON {path}: {e}")
            # 如果加载失败，继续执行下方的 fallback

    # 2. 如果文件不存在或加载失败，使用内置 fallback
    # print(f"DEBUG: JSON not found at {path}, using internal fallback for '{s}'.")
    success = _create_internal_shape(curve, s)
    if not success:
        pm.warning(f"Control shape '{s}' not found (JSON missing and no internal fallback).")


def set_curve_offset(curve, o):
    for shape in curve.getShapes():
        points = get_curve_shape_points(shape)
        # o 是 [x, y, z]
        points = [[xyz + offset for xyz, offset in zip(point, o)] for point in points]
        set_curve_shape_points(shape, points)


def control_create(curve=None, s=None, n=None, p=None, r=None, c=None, l=None, o=None):
    if curve is None:
        curve = pm.circle(ch=0)[0]

    if isinstance(curve, str):
        curve = pm.PyNode(curve)

    if s is not None:
        set_curve_shape(curve, s)
    if n is not None:
        set_curve_name(curve, n)
    if p is not None:
        set_curve_parent(curve, p)
    if r is not None:
        set_curve_radius(curve, r)
    if c is not None:
        set_curve_color(curve, c)
    if l is not None:
        set_curve_locked(curve, l)
    if o is not None:
        set_curve_offset(curve, o)

    return curve