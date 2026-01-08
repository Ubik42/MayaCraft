# coding:utf-8
from functools import partial
import pymel.core as pm

# 依然要做安全检查
try:
    from core.face.utils import actions
except ImportError:
    actions = None


# ==========================================
# 1. 基础工具函数 (保持不变)
# ==========================================

def polygon_to_curve(loop):
    edges = [e for e in pm.selected(fl=1) if isinstance(e, pm.general.MeshEdge)]
    if len(edges) < 2:
        return pm.warning("please select edge")

    sides = []
    for edge in edges:
        connected = edge.connectedEdges()
        count = sum(1 for c in connected if c in edges)
        if count == 1:
            sides.append(edge)

    sides_length = len(sides)

    if loop and sides_length not in [0, 2]:
        return pm.warning("please select loop edge")
    if (not loop) and (sides_length != 2):
        return pm.warning("please select line edge (Continuous edges)")

    try:
        return pm.PyNode(pm.polyToCurve(degree=1, ch=0)[0])
    except RuntimeError:
        return pm.warning("please select edge")


def init_curve(name="curve", loop=False):
    if not actions: return
    mesh = actions.assert_geometry(shape_type="mesh")
    curve = polygon_to_curve(loop)
    if curve is None:
        return
    if name == "SelectionBrowCurve":
        group = actions.create_group(name="|FaceGroup|FaceSelectionGroup", init=False)
        if not group.hasAttr("face"):
            group.addAttr("face", dt="string")
        if mesh:
            group.face.set(mesh.fullPath())
    curve_shape = curve.getShape()

    # 逻辑优化：Python 3 兼容性保持
    if curve_shape.form().key == 'periodic' and loop:  # PyMel form返回枚举
        points = [cv.getPosition(space="world") for cv in curve_shape.cv]
        xs = [p[0] for p in points]
        index = xs.index(min(xs))
        points = points[index:] + points[:index]
        xs = [p[0] for p in points]
        index = xs.index(max(xs))

        p1 = points[int(index / 2)]
        p2 = points[int(index + (len(points) - index + 1) / 2)]

        if p1[1] < p2[1]:
            points = list(reversed(points[1:] + points[:1]))
        for i, point in enumerate(points):
            pm.xform(curve_shape.cv[i], t=point)
        xs = [p[0] for p in points]
        index = xs.index(max(xs))
        curve1 = pm.curve(d=1, p=points[:index + 1])
        curve2 = pm.curve(d=1, p=points[index:] + [points[0]])
        curves = [curve1, curve2]
        names = [name.replace("Up", "Up").replace("Dn", "Up"), name.replace("Up", "Dn").replace("Dn", "Dn")]
        pm.delete(curve)
    else:
        curves = [curve]
        names = [name]
    for curve, name in zip(curves, names):
        cvs = curve.getShape().cv
        p1 = pm.xform(cvs[0], q=1, ws=1, t=1)[0]
        p2 = pm.xform(cvs[len(cvs) - 1], q=1, ws=1, t=1)[0]
        if p1 > p2:
            pm.reverseCurve(curve)

        group = actions.create_group(name="|FaceGroup|FaceSelectionGroup|FSCurveGroup", init=False)
        path = "|FaceGroup|FaceSelectionGroup|FSCurveGroup|" + name
        if pm.objExists(path):
            pm.delete(path)
        curve.setParent(group)
        curve.rename(name)
    pm.select(curves)


def init_joint(name):
    vertexes = [e for e in pm.selected(fl=1) if isinstance(e, pm.general.MeshVertex)]
    if not vertexes:
        return pm.warning("please select mesh vertex")
    positions = [vtx.getPosition(space="world") for vtx in vertexes]
    position = sum(positions) / len(positions)
    group = actions.create_group(name="|FaceGroup|FaceSelectionGroup|FSJointGroup", init=False)
    if pm.objExists("|FaceGroup|FaceSelectionGroup|FSJointGroup|" + name):
        pm.delete("|FaceGroup|FaceSelectionGroup|FSJointGroup|" + name)
    joint = pm.joint(group, n=name)
    joint.setTranslation(position, space="world")
    joint.radius.set(0.1)
    pm.toggle(joint, la=1)

    locator = pm.group(em=1, n=name.replace("Joint", "Locator"), p=joint)
    pm.createNode("locator", p=locator, n=name.replace("Joint", "LocatorShape"))
    locator.overrideEnabled.set(True)
    locator.overrideDisplayType.set(1)
    joint.radius.connect(locator.localScaleX)
    joint.radius.connect(locator.localScaleY)
    joint.radius.connect(locator.localScaleZ)


def SelectionBulgeCurve():
    # 保持你之前的 SelectionBulgeCurve 逻辑不变
    if not actions: return
    polygon = actions.assert_geometry(shape_type="mesh")
    curve = polygon_to_curve(False)
    if curve is None:
        return
    points = actions.get_points_by_curve(curve, 5)
    radius = curve.getShape().length() / 40.0
    if points[0][1] < points[-1][1]:
        points.reverse()
    group = actions.create_group("|FaceGroup|FaceSelectionGroup|FSBulgeGroup", init=True)
    curve.rename("SelectionBulgeCurve")
    curve.setParent(group)
    curves = []
    joint = None
    for i, point in enumerate(points):
        n = "SelectionBulge{i:0>2}Joint".format(i=i + 1)
        joint = pm.joint(group, n=n)
        curve_seg = pm.curve(d=1, p=[[0, 0, -1], [0, 0, 1]], n="lipSecondary%02dCUR" % i)
        curve_seg.setParent(joint)
        joint.setTranslation(point, space="world")
        joint.radius.connect(curve_seg.sz)
        pm.geometryConstraint(polygon, joint)
        joint.radius.set(radius)
        curves.append(curve_seg)
    surface = pm.loft(curves, ch=1, d=3, ss=1, u=1)[0]
    surface.setParent(group)
    surface.rename("FSBulgeSurface")
    for i in range(5):
        n = "SelectionBulge{i:0>2}".format(i=i + 1)
        follicle = actions.make_follicle(r=1, t=1, p=group, g=surface, v=0.5, u=1.0 / 4 * i, n=n + "Follicle")
        locator = pm.group(em=1, n=n + "Locator", p=follicle)
        pm.createNode("locator", p=locator, n=n + "LocatorShape")
        locator.overrideEnabled.set(True)
        locator.overrideDisplayType.set(1)
        if joint:
            joint.radius.connect(locator.localScaleX)
            joint.radius.connect(locator.localScaleY)
            joint.radius.connect(locator.localScaleZ)
        pm.toggle(follicle, la=1)


# ==========================================
# 2. 核心改进: 智能 Roll 初始化
# ==========================================

def init_roll(arg_name="SelectionBrowJoint"):
    """
    智能处理 Roll 的创建。
    arg_name 可以是 'SelectionBrowJoint' 也可以是 'SelectionBrowRoll'。
    函数会自动计算出两个名字。
    """
    vertexes = [e for e in pm.selected(fl=1) if isinstance(e, pm.general.MeshVertex)]
    if not vertexes:
        return pm.warning("please select mesh vertex")

    # --- 改进点：名称自动推导 ---
    if "Roll" in arg_name:
        roll_name = arg_name
        joint_name = arg_name.replace("Roll", "Joint")
    elif "Joint" in arg_name:
        joint_name = arg_name
        roll_name = arg_name.replace("Joint", "Roll")
    else:
        # 默认回退
        roll_name = arg_name + "Roll"
        joint_name = arg_name + "Joint"
    # ---------------------------

    positions = [vtx.getPosition(space="world") for vtx in vertexes]
    end_position = sum(positions) / len(positions)
    position = pm.datatypes.Point(end_position)
    position[2] = position[2] - 1

    group = actions.create_group(name="|FaceGroup|FaceSelectionGroup|FSRollGroup", init=False)

    # 清理旧的
    if pm.objExists("|FaceGroup|FaceSelectionGroup|FSRollGroup|" + roll_name):
        pm.delete("|FaceGroup|FaceSelectionGroup|FSRollGroup|" + roll_name)

    roll = pm.joint(group, n=roll_name)
    roll.setTranslation(position, space="world")
    roll.radius.set(0.1)

    joint = pm.joint(roll, n=joint_name)
    joint.setTranslation(end_position, space="world")
    joint.radius.set(0.1)

    polygon = pm.polySphere(ch=0)[0]
    polygon.rx.set(90)
    pm.makeIdentity(polygon, apply=1, r=1)
    polygon.setParent(roll)
    polygon.rename("{name}Polygon".format(name=joint_name))
    polygon.overrideEnabled.set(True)
    polygon.overrideDisplayType.set(1)

    # 这里的命名逻辑也改用推导出的 joint_name
    locator1 = pm.group(em=1, p=roll, n=joint_name.replace("Joint", "Locator1"))
    pm.createNode("locator", p=locator1, n=joint_name.replace("Joint", "Locator1") + "Shape")
    locator1.v.set(0)

    locator2 = pm.group(em=1, p=roll, n=joint_name.replace("Joint", "Locator2"))
    pm.createNode("locator", p=locator2, n=joint_name.replace("Joint", "Locator2") + "Shape")
    locator2.v.set(0)

    pm.pointConstraint(roll, locator1)
    pm.pointConstraint(joint, locator2)
    pm.pointConstraint(roll, polygon)
    pm.aimConstraint(joint, polygon, aimVector=[0, 0, 1], wut="none")

    distance = pm.createNode("distanceBetween", n=joint_name.replace("Joint", "Distance"))
    locator1.worldPosition[0].connect(distance.point1)
    locator2.worldPosition[0].connect(distance.point2)
    distance.distance.connect(polygon.scaleX)
    distance.distance.connect(polygon.scaleY)
    distance.distance.connect(polygon.scaleZ)
    pm.select(roll)


# ==========================================
# 3. 接口绑定 (Partials)
# ==========================================
# 现在的定义更加自然，不需要硬映射别名了

# Curves
SelectionBrowCurve = partial(init_curve, "SelectionBrowCurve", False)
SelectionNoseCurve = partial(init_curve, "SelectionNoseCurve", False)
SelectionLidMainUpCurve = partial(init_curve, "SelectionLidMainUpCurve", True)
SelectionLidMainDnCurve = partial(init_curve, "SelectionLidMainDnCurve", True)
SelectionLidOuterUpCurve = partial(init_curve, "SelectionLidOuterUpCurve", True)
SelectionLidOuterDnCurve = partial(init_curve, "SelectionLidOuterDnCurve", True)
SelectionLipUpCurve = partial(init_curve, "SelectionLipUpCurve", True)
SelectionLipDnCurve = partial(init_curve, "SelectionLipDnCurve", True)

SelectionTongueUpCurve = partial(init_curve, "SelectionTongueUpCurve", False)
SelectionTongueDnCurve = partial(init_curve, "SelectionTongueDnCurve", False)

# Rolls - 直接使用 UI 期望的名称
# 因为 init_roll 现在很聪明，给它 SelectionBrowRoll 它也能处理
SelectionBrowRoll = partial(init_roll, "SelectionBrowRoll")
SelectionEyeRoll = partial(init_roll, "SelectionEyeRoll")
SelectionJawRoll = partial(init_roll, "SelectionJawRoll")
SelectionLipRoll = partial(init_roll, "SelectionLipRoll")
SelectionNoseRoll = partial(init_roll, "SelectionNoseRoll")

# Joints
# 注意：如果旧代码里有 SelectionBrowJoint 这种调用，也可以保留，它们会生成相同的结果
SelectionBrowJoint = partial(init_roll, "SelectionBrowJoint")
SelectionEyeJoint = partial(init_roll, "SelectionEyeJoint")
SelectionJawJoint = partial(init_roll, "SelectionJawJoint")
SelectionLipJoint = partial(init_roll, "SelectionLipJoint")
SelectionNoseJoint = partial(init_roll, "SelectionNoseJoint")

# Simple Joints
SelectionCheekOtJoint = partial(init_joint, "SelectionCheekOtJoint")
SelectionCheekMdJoint = partial(init_joint, "SelectionCheekMdJoint")
SelectionCheekInJoint = partial(init_joint, "SelectionCheekInJoint")
SelectionNoseUpJoint = partial(init_joint, "SelectionNoseUpJoint")
SelectionBrowNoseJoint = partial(init_joint, "SelectionBrowNoseJoint")
SelectionPufferJoint = partial(init_joint, "SelectionPufferJoint")
SelectionTeethUpJoint = partial(init_joint, "SelectionTeethUpJoint")
SelectionTeethDnJoint = partial(init_joint, "SelectionTeethDnJoint")

# 已经不需要底部的 SelectionBrowRoll = SelectionBrowJoint 了