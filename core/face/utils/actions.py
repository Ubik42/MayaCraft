# coding:utf-8
from core.face.utils import control
import pymel.core as pm


def create_group(name="|FaceGroup|SkeletonGroup", init=False):
    u"""
    :param name: 组名称
    :param init: 当组存在时，是否删除
    :return: 组
    根据长名称创建层级
    """
    if init:
        if pm.objExists(name):
            pm.delete(name)
    if pm.objExists(name):
        return pm.PyNode(name)
    fields = name.split("|")
    n = fields.pop(-1)
    if name.count("|") > 1:
        return pm.group(em=1, n=n, p=create_group("|".join(fields)))
    return pm.group(em=1, n=n)


def assert_geometry(geometry=None, shape_type="mesh"):
    u"""
    :param geometry: 几何体
    :param shape_type: 形节点类型
    :return:
    判断物体是否为集合体
    """
    if geometry is None:
        selected = pm.selected(o=1)
        if len(selected) == 0:
            return pm.warning("please select a " + shape_type)
        geometry = selected[0]
    if geometry.type() == shape_type:
        return geometry.getParent()
    if geometry.type() != "transform":
        return pm.warning("please select a " + shape_type)
    shape = geometry.getShape()
    if not shape:
        return pm.warning("please select a " + shape_type)
    if shape.type() != shape_type:
        return pm.warning("please select a " + shape_type)
    return geometry


def find_node_by_name(name="name", err=False):
    u"""
    :param name: 物体名称
    :param err: 是否报错
    :return: 物体
    查找maya内唯一命名的物体
    """
    nodes = pm.ls(name)
    if len(nodes) == 1:
        return nodes[0], err
    else:
        return pm.warning("can not find " + name), True


def create_second_control(n="", p=None, t=True, r=False):
    u"""
    :param n: 前缀
    :param p: 父对象
    :param t: 链接位移
    :param r: 链接旋转
    :return: 控制器
    创建次级控制器
    """
    second = pm.group(em=1, p=p, n=n+"Second")
    inverse = pm.group(em=1, p=second, n=n + "Inverse")
    con = pm.group(em=1, p=inverse, n=n + "Control")
    if r:
        decompose = pm.createNode("decomposeMatrix", n=n + "InverseDecompose")
        con.inverseMatrix.connect(decompose.inputMatrix)
        decompose.outputRotate.connect(inverse.r)
        decompose.outputTranslate.connect(inverse.t)
    else:
        multiply = pm.createNode("multiplyDivide", n=n + "InverseMultiply")
        multiply.input1.set(-1, -1, -1)
        con.t.connect(multiply.input2)
        multiply.output.connect(inverse.t)
    return second, con


def curve_group(group, curve, parm):
    u"""
    :param n: 名称
    :param group: 父对象
    :param curve: 曲线
    :param parm: 曲线上位置
    :return: 曲线
    沿曲线方向创建组
    """
    shape = curve.getShape()
    length = shape.length()
    point = shape.getPointAtParam(shape.findParamFromLength(length * parm), space="world")
    group.setTranslation(point, space="world")
    plus_parm = max(min(parm + 0.01, 1), 0)
    plus_point = shape.getPointAtParam(shape.findParamFromLength(length * plus_parm), space="world")
    minus_parm = max(min(parm - 0.01, 1), 0)
    minus_point = shape.getPointAtParam(shape.findParamFromLength(length * minus_parm), space="world")
    up_temp = pm.group(em=1)
    up_point = point + plus_point - minus_point
    up_temp.setTranslation(up_point, space="world")
    point[1] = point[1] + 1
    aim_temp = pm.group(em=1)
    aim_temp.setTranslation(point, space="world")
    pm.delete(pm.aimConstraint(aim_temp, group, aim=[0, 1, 0], u=[1, 0, 0], wuo=up_temp, wut="object"))
    pm.delete(up_temp, aim_temp)


def get_points_by_curve(curve=None, number=0):
    u"""
    :param curve: 曲线
    :param number: 点数
    :return:
    获取曲线上点
    """
    curve_shape = curve.getShape()
    step = curve.getShape().length() / (number - 1)
    return [curve_shape.getPointAtParam(curve_shape.findParamFromLength(step * i), space="world") for i in
            range(number)]


def create_surface_by_points(n="surface", p=None, c=False, points=list(), liner_point=((0, 0, -0.1), (0, 0, 0.1))):
    u"""
    :param n: 名称
    :param p: 父对象
    :param c: 是否关闭
    :param points: 点坐标
    :param liner_point: 线坐标
    :return: 曲面
    """
    curves = []
    for i, point in enumerate(points):
        curve = pm.curve(d=1, p=liner_point, n="lip%02dCUR" % i)
        curve.setTranslation(point, space="world")
        curves.append(curve)
    surface = pm.loft(curves, ch=0, d=3, ss=1, c=c, u=1)[0]
    surface.rename(n)
    if p is not None:
        surface.setParent(p)
    surface.v.set(0)
    surface.inheritsTransform.set(0)
    pm.delete(curves)
    return surface


def create_attach(p, n, i, plane):
    u"""
    :param p: 父对象
    :param n: 名称
    :param i: 序号
    :param plane: 面片
    :return:
    """
    if p:
        msa = pm.group(p=p, em=1, n=n)
    else:
        msa = pm.group(em=1, n=n)
    pm.createNode("cMuscleSurfAttach", p=msa, n=n+"Shape")
    plane.worldMesh.connect(msa.surfIn)
    msa.rotateOrder.connect(msa.inRotOrder)
    msa.outTranslate.connect(msa.translate)
    msa.outRotate.connect(msa.rotate)
    msa.edgeIdx1.set(i * 4 + 0)
    msa.edgeIdx2.set(i * 4 + 3)
    msa.uLoc.set(0.5)
    msa.vLoc.set(0.5)
    msa.getShape().v.set(0)
    msa.inheritsTransform.set(0)
    return msa


def create_curve_by_points(points, n=None, p=None):
    surface = create_surface_by_points(points=points, c=False)
    curve = pm.PyNode(pm.duplicateCurve(surface.getShape().v[0.5], ch=0, rn=0, local=0)[0])
    pm.delete(surface)
    if p is not None:
        curve.setParent(p)
    if n:
        curve.rename(n)
    curve.inheritsTransform.set(0)
    curve.v.set(0)
    return curve


def rebuild_curve(n="", p=None, curve=None, number=0):
    u"""
    :param n: 名称
    :param p: 父对象
    :param curve: 曲线
    :param number: 数字
    :return: 曲线
    """
    if curve is None:
        curve = assert_geometry(shape_type="nurbsCurve")
    curve_shape = curve.getShape()
    if not number:
        number = len(curve_shape.ep)
    if not n:
        n = curve.name()
    if not p:
        p = curve.getParent()
    points = get_points_by_curve(curve, number)
    return create_curve_by_points(points, n=n, p=p)


def create_plane(n, p, transforms, radius):
    u"""
    :param n: 名称
    :param p: 父节点
    :param transforms: 空组
    :param radius: 半径
    :return: 面片模型
    """
    plane = pm.polyPlane(w=1, h=1, sx=1, sy=1, ch=1)[0]
    plane.r.set(90, 0, 90)
    plane.s.set(radius, radius, radius)
    pm.makeIdentity(apply=1, r=1, s=1)
    planes = []
    for transform in transforms:
        duplicate_plane = plane.duplicate()[0]
        duplicate_plane.setMatrix(transform.getMatrix(ws=1), ws=1)
        planes.append(duplicate_plane)
    pm.delete(plane)
    plane = pm.polyUnite(planes, ch=0)[0]
    plane.v.set(0)
    plane.inheritsTransform.set(0)
    plane.setParent(p)
    plane.rename(n)
    plane.v.set(0)
    plane.inheritsTransform.set(0)
    return plane


def create_joint(name, init=False):
    if pm.objExists(name) and init:
        pm.delete(name)
    if pm.objExists(name):
        return pm.PyNode(name)
    fields = name.split("|")
    n = fields.pop(-1)
    joint = pm.joint(create_joint("|".join(fields)), n=n)
    joint.drawStyle.set(2)
    return joint


def make_follicle(p="", n="follicle", g=None, u=0.0, v=0.0, t=False, r=False):
    if g is None:
        g = pm.selected()[0]
    if p:
        follicle = pm.createNode("transform", p=p, n=n)
    else:
        follicle = pm.createNode("transform", n=n)
    pm.createNode("follicle", n=n + "Shape", p=follicle)
    follicle.parameterU.set(u)
    follicle.parameterV.set(v)
    follicle.getShape().v.set(0)
    if g.getShape().type() == "mesh":
        g.outMesh.connect(follicle.inputMesh)
    else:
        g.local.connect(follicle.inputSurface)
        g.worldMatrix.connect(follicle.inputWorldMatrix)
    if t:
        follicle.outTranslate.connect(follicle.translate)
    if r:
        follicle.outRotate.connect(follicle.rotate)
    follicle.inheritsTransform.set(0)
    return follicle


def polygon_point_connect():
    selected = pm.selected()
    if len(selected) <= 1:
        return
    if not selected[0].getShape():
        return
    if selected[0].getShape().type() != "mesh":
        return
    polygon, transforms = selected[0], selected[1:]
    mesh = polygon.getShape()
    for transform in transforms:
        point = transform.getTranslation(space="world")
        _, face_id = mesh.getClosestPoint(point, space="world")
        face = mesh.f[face_id]
        length_map = {(mesh.vtx[vId].getPosition(space="world") - point).length(): mesh.vtx[vId] for vId in
                      face.getVertices()}
        vtx = length_map[min(length_map.keys())]
        id_uv = {i:(u, v) for u, v, i in zip(*vtx.getUVs())}
        u, v = id_uv.get(face_id, id_uv.values()[0])
        follicle = make_follicle(g=polygon, p=transform, n=transform.name()+"FOL", u=u, v=v, t=True)
        pm.pointConstraint(follicle, transform, n=transform.name()+"PFC", mo=True)


def create_locator(prefix, group, curve):
    u"""
    :param prefix: 前缀
    :param group: 所在组
    :param curve: 曲线
    :return:
    """
    curve_shape = curve.getShape()
    locators = []
    for i, cv in enumerate(curve_shape.cv):
        loc = pm.spaceLocator()
        locators.append(loc)
        loc.v.set(0)
        point = pm.xform(cv, q=1, t=1, ws=1)
        pm.xform(loc,  t=point, ws=1)
        loc.setParent(group)
        loc.rename(prefix + "%02dLOC" % (i + 1))
        loc.worldPosition[0].connect(curve_shape.controlPoints[i])
    return locators


def update_second(face=None):
    if face is None:
        face = assert_geometry(shape_type="mesh")
    mesh = face.getShape()
    for inverse in pm.ls("*Inverse", type="transform"):
        second = inverse.getParent()
        if second.name() != inverse.name().replace("Inverse", "Second"):
            continue
        n = second.name()[:-6]
        if "|" in n:
            continue

        point = second.getTranslation(space="world")
        _, face_id = mesh.getClosestPoint(point, space="world")
        face = mesh.f[face_id]
        length_map = {(mesh.vtx[vId].getPosition(space="world") - point).length(): mesh.vtx[vId] for vId in
                      face.getVertices()}
        vtx = length_map[min(length_map.keys())]
        id_uv = {i:(u, v) for u, v, i in zip(*vtx.getUVs())}
        u, v = id_uv.get(face_id, id_uv.values()[0])
        if not second.getShape():
            follicle = pm.createNode("follicle", n=n + "Shape", p=second)
            follicle.v.set(0)
        else:
            follicle = second.getShape()
        follicle.parameterU.set(u)
        follicle.parameterV.set(v)
        mesh.outMesh.connect(follicle.inputMesh, f=1)

        if second.t.inputs(type="plusMinusAverage"):
            plus = second.t.inputs(type="plusMinusAverage")[0]
            pm.delete(plus)
        if pm.objExists(n+"Second_pointConstraint1"):
            pm.delete(n+"Second_pointConstraint1")
        temp = pm.group(em=1)
        temp.t.set(follicle.outTranslate.get())
        constraint = pm.pointConstraint(temp, second, mo=1)
        follicle.outTranslate.connect(constraint.target[0].targetTranslate, f=1)
        pm.delete(temp)


def update_vis():
    vis_con = assert_geometry(shape_type="nurbsCurve")
    if not vis_con:
        return
    for attr, dv in zip(["FaceMainVis", "faceSdkVis", "FaceSecondVis", "FaceThirdlyVis"], [True, True, False, False]):
        if not vis_con.hasAttr(attr):
            vis_con.addAttr(attr, at="bool", k=1, dv=dv)
    for con in pm.ls("*Control", type="transform"):
        if "FaceControlGroup" not in con.fullPath():
            continue
        con = assert_geometry(con, shape_type="nurbsCurve")
        if not con:
            continue
        for shape in con.getShapes():
            color = con.getShape().overrideColor.get()
            if color == 13:
                vis_con.FaceMainVis.connect(shape.v, f=1)
            elif color == 14:
                vis_con.faceSdkVis.connect(shape.v, f=1)
            elif color == 17:
                vis_con.FaceSecondVis.connect(shape.v, f=1)
            elif color == 6:
                vis_con.FaceThirdlyVis.connect(shape.v, f=1)


def get_curve_params(curve):
    points = [pm.datatypes.Point(p) for p in control.get_curve_shape_points(curve.getShape())]
    lengths = [(points[i]-p).length() for i, p in enumerate(points[1:])]
    length = sum(lengths)
    params = [sum(lengths[:i])/length for i in range(len(points))]
    return params


def pop_connect_param(params, step):
    for i, param in enumerate(params[1:]):
        if param["umd"] == "md":
            continue
        if params[i]["umd"] == "md":
            continue
        if params[i]["umd"] == param["umd"]:
            continue
        if abs(params[i]["md"] - param["md"]) > step:
            continue
        umd = params[i + 1]["umd"]
        params[i][umd] = params[i + 1][umd]
        params[i]["umd"] = "md"
        params.pop(i+1)
        return True


def loft_eyelid():
    up, dn = pm.selected()
    params = [dict(md=param, up=param, dn=param, umd="up") for param in get_curve_params(curve=up)]
    params += [dict(md=param, up=param, dn=param, umd="dn") for param in get_curve_params(curve=dn)]

    def key(elem):
        return elem["md"]
    params.sort(key=key)

    step = pm.softSelect(q=1, ssd=1)/up.getShape().length()
    print (step)
    for _ in range(40):
        if not pop_connect_param(params, step):
            break
    for parm in params:
        print (parm)

    shape = up.getShape()
    length = shape.length()
    points = [shape.getPointAtParam(shape.findParamFromLength(length*param["up"]), space="world")  for param in params]
    _up = pm.curve(p=points, d=1)

    shape = dn.getShape()
    length = shape.length()
    points = [shape.getPointAtParam(shape.findParamFromLength(length*param["dn"]), space="world")  for param in params]
    _dn = pm.curve(p=points, d=1)
    pm.loft(_up, _dn, ch=0, d=1, ss=1, c=0, u=1)
