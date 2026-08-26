import pymel.core as pm

from MayaCraft.core.face.utils import control
from MayaCraft.core.face.utils import actions
from MayaCraft.core.face.utils import weights


def lip_surface(SelectionLipUpCurve, SelectionLipDnCurve, connect_group, radius, **kwargs):
    group = pm.group(em=1, n="LipSurfaceGroup", p=connect_group)
    up_points = actions.get_points_by_curve(SelectionLipUpCurve, 5)
    dn_points = actions.get_points_by_curve(SelectionLipDnCurve, 5)
    mid_points = [(up+dn)/2 for up, dn in zip(up_points, dn_points)]
    temp_curve = actions.create_curve_by_points(mid_points, n="temp", p=None)
    mid_points = actions.get_points_by_curve(temp_curve, 5)
    pm.delete(temp_curve)
    surfaces = []
    for ud, points in zip(["Up", "Dn"], [up_points, dn_points]):
        temp_curve = actions.create_curve_by_points(points)
        points = actions.get_points_by_curve(temp_curve, 5)
        pm.delete(temp_curve)
        points = [pm.datatypes.Point(m[0], p[1], p[2]) for p, m in zip(points, mid_points)]
        for i in range(len(points)/2):
            points[-i - 1][0] = -points[i][0]
            points[-i - 1][1] = points[i][1]
            points[-i - 1][2] = points[i][2]
        points[2][0] = 0
        surface = actions.create_surface_by_points(n="Lip{ud}PointSurface".format(ud=ud), p=group, points=points,
                                                   liner_point=((0.0, 0.5*radius, 0.0), (0.0, -0.5*radius, 0.0)))
        surface = pm.reverseSurface(surface, d=3, ch=0, rpo=1)[0]
        surfaces.append(surface)
    surfaces.append(surfaces[0].duplicate()[0])
    surfaces[-1].rename("LipUpRotateSurface")
    surfaces.append(surfaces[1].duplicate()[0])
    surfaces[-1].rename("LipDnRotateSurface")
    return surfaces


def surface_transform(surface, i, v):
    follicle = actions.make_follicle(g=surface, u=0.5, v=v, t=1, r=1, n="follicle", p=None)
    group = pm.group(em=1)
    group.setMatrix(follicle.getMatrix())
    p1 = pm.datatypes.Point(*pm.xform(surface.getShape().cv[0][i], q=1, t=1))
    p2 = pm.datatypes.Point(*pm.xform(surface.getShape().cv[1][i], q=1, t=1))
    group.setTranslation((p1+p2)/2)
    pm.delete(follicle)
    return group


def lip_polygon(surfaces, connect_group, radius, **kwargs):
    transforms = [surface_transform(surface, i, v) for ud, surface in zip(["Up", "Dn"], surfaces[:2])
                  for i, v in enumerate([0, 0.08333, 0.25, 0.5, 0.75, 0.91667, 1])]
    polygon = actions.create_plane(n="LipPolygon", p=connect_group, radius=radius, transforms=transforms)
    pm.delete(transforms)
    return polygon


def lip_surface_con(n, i, g, o, r):
    group = actions.create_group("|FaceGroup|FaceConnectGroup|LipConnectGroup|LipAttachGroup", init=False)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|LipControlGroup", init=False)
    attach = actions.create_attach(p=group, n=n + "Attach", i=i, plane=g)
    second, con = actions.create_second_control(p=control_group, n=n, t=True, r=False)
    second.setMatrix(attach.getMatrix(ws=1), ws=1)
    control.control_create(con, s="cube", r=r, o=[o * 1.5 * r, 0, r * 2], c=17, l=["rx", "sx", "sy", "sz", "v"])
    skin = pm.joint(attach, n=n+"Skin")
    skin.v.set(0)
    con.t.connect(skin.t)
    con.r.connect(skin.r)
    pm.orientConstraint(attach, second)
    # attach.r.connect(second.r)
    point_skin = pm.joint(group, n=n+"PointSkin")
    point_skin.setMatrix(skin.getMatrix(ws=1), ws=1)
    pm.pointConstraint(skin, point_skin)
    point_skin.v.set(0)
    rotate_skin = pm.joint(group, n=n+"RotateSkin")
    rotate_skin.setMatrix(skin.getMatrix(ws=1), ws=1)
    pm.orientConstraint(skin, rotate_skin)
    rotate_skin.v.set(0)
    return point_skin, rotate_skin


def lip_surface_cons(polygon, radius, surfaces, **kwargs):
    skins = [lip_surface_con("Lip{ud}{i:0>2}".format(ud=ud, i=j+1), i*7+j, polygon, o, radius)
             for i, ud, o in zip([0, 1], ["Up", "Dn"], [-1, 1]) for j in range(7)]
    for joints, surface in zip([skins[:7], skins[7:]], surfaces[:2]):
        joints = [joint[0] for joint in joints]
        sk = pm.skinCluster(joints, surface, tsb=1, mi=1, n=surface.name().replace("Surface", "SK"))
        weights.load_weight(sk, n=surface.name().replace("Point", ""))
    for joints, surface in zip([skins[:7], skins[7:]], surfaces[2:]):
        joints = [joint[1] for joint in joints]
        sk = pm.skinCluster(joints, surface, tsb=1, mi=1, n=surface.name().replace("Surface", "SK"))
        weights.load_weight(sk, n=surface.name().replace("Rotate", ""))


def joint_con(n, p, c, r, o, f):
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|LipControlGroup", init=False)
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|LipJointGroup", init=False)
    joint = pm.joint(joint_group, n=n+"Joint")
    joint.radius.set(r)
    pm.parent(pm.parentConstraint(p, joint), p)

    second, con = actions.create_second_control(n=n + "Se", p=control_group, t=1, r=False)
    control.control_create(con, s="ball", r=r * 0.5, o=[o * r, 0, r], c=6, l=["v"])
    second.setMatrix(joint.getMatrix(ws=1), ws=1)

    con.t.connect(c.t)
    con.r.connect(c.r)
    con.s.connect(joint.s)

    pm.orientConstraint(f, second)
    # f.r.connect(second.r)
    return joint


def lip_joint_cons(surfaces, rl_con, radius, **kwargs):
    group = actions.create_group("|FaceGroup|FaceConnectGroup|LipConnectGroup|LipFollicleGroup", init=False)
    parents = []
    zips = []
    surfaces = [[surfaces[0], surfaces[2]], [surfaces[1], surfaces[3]]]
    for surface, ud, o, u in zip(surfaces, ["Up", "Dn"], [-1, 1], [0.55, 0.45]):
        for i in range(13):
            n = "Lip{ud}{i:0>2}".format(ud=ud, i=i + 1)
            follicle = actions.make_follicle(g=surface[0], p=group, u=u, t=1, v=1.0 / 12 * i, r=0, n=n + "PointFollicle")
            ro = actions.make_follicle(g=surface[1], p=group, u=u, t=1, v=1.0 / 12 * i, r=1, n=n + "RotateFollicle")
            ro.r.connect(follicle.r)
            z = pm.group(em=1, p=follicle, n=n+"Zip")
            parent = pm.group(em=1, p=z, n=n+"Parent")
            joint_con(n, parent, z, radius, o, follicle)
            parents.append(parent)
            zips.append(z)

    rl_con[0].addAttr("zip", max=0, min=10, at="double", k=1)
    rl_con[1].addAttr("zip", max=0, min=10, at="double", k=1)
    for i in range(13):
        for ud, j, k in zip(["Up", "Dn"], [i, i+13], [i+13, i]):

            close_group = pm.group(em=1, p=parents[j], n="Lip{ud}{i:0>2}Close".format(ud=ud, i=i + 1))
            close_group.setParent(zips[k])
            # close_group = pm.group(em=1, p=zips[k], n="Lip{ud}{i:0>2}Close".format(ud=ud, i=i + 1))
            constraint = pm.pointConstraint(zips[j], close_group, parents[j])
            _, close = pm.pointConstraint(constraint, q=1, wal=1)
            close.set(0)
            for con, x in zip(rl_con, [i, 12-i]):
                dv0 = 10.0/14*x
                dv1 = 10.0/14*(x + 2)
                set_lip_sdk(close, con.zip, dv0, dv1)
    return


def get_plane_value(polygon, i, attr):
    attach = actions.create_attach(p=None, n="Attach", i=i, plane=polygon)
    value = attach.attr(attr).get()
    pm.delete(attach)
    return value


def get_rl_wt(polygon, i, j, attr):
    v1 = get_plane_value(polygon, i*7+j, attr)
    v2 = get_plane_value(polygon, i*7, attr)
    v3 = get_plane_value(polygon, i*7+3, attr)
    return (v1-v3)/(v2-v3)


def get_rl_wts(polygon, rl, attr):
    if attr == "ty":
        w1289 = [0.6, 0.2, 0.6, 0.2]
    else:
        w1289 = [get_rl_wt(polygon, i, j, attr) for i in range(2) for j in [1, 2]]
    wts = [1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0]
    for i, j in enumerate([1, 2, 8, 9]):
        wts[j] = w1289[i]
    if rl == "Lf":
        wts.reverse()
    return wts


def lip_rl(connect_group, polygon, control_group, radius, **kwargs):
    rl_con = []
    for rl, i, scale in zip(["Rt", "Lf"], [0, 6], [1, -1]):
        offset = pm.group(em=1, p=connect_group, n="Lip{rl}Offset".format(rl=rl))
        offset.inheritsTransform.set(0)
        up_attach = "LipUp{i:0>2}Attach".format(i=i+1)
        dn_attach = "LipDn{i:0>2}Attach".format(i=i+1)
        pm.delete(pm.parentConstraint(up_attach, dn_attach, offset))
        offset.sy.set(scale)
        pre = pm.group(em=1, p=connect_group, n="Lip{rl}Pre".format(rl=rl))
        pre.setParent(offset)
        pre.t.set(0, 0, 0)
        sdk = pm.group(em=1, p=offset, n="Lip{rl}Sdk".format(rl=rl))
        for xyz in "xyz":
            hand = pm.group(em=1, p=pre, n="Lip{rl}T{xyz}Hand".format(rl=rl, xyz=xyz))
            pm.select(polygon)
            cluster, _ = pm.cluster(n="Lip{rl}T{xyz}Cluster".format(rl=rl, xyz=xyz), wn=(hand, hand))
            pre.worldInverseMatrix[0].connect(cluster.bindPreMatrix)
            skip = ["x", "y", "z"]
            skip.remove(xyz)
            pm.pointConstraint(sdk, hand, skip=skip)
            ws = get_rl_wts(polygon, rl, "t"+xyz)
            for j, w in enumerate(ws):
                for k in range(4):
                    cluster.weightList[0].weights[j*4+k].set(w)
        second, con = actions.create_second_control(p=control_group, n="Lip{rl}".format(rl=rl), t=True, r=False)
        control.control_create(con, s="LipLfRt", r=radius * 3, o=[0, 0, radius * 4], c=13,
                               l=["rx", "ry", "rz", "sx", "sy", "sz", "v"])
        second.setMatrix(offset.getMatrix(ws=1), ws=1)
        con.t.connect(sdk.t)
        rl_con.append(con)
        constraint = pm.orientConstraint(up_attach, dn_attach, second, mo=1)
        constraint.setParent(offset)
        connect_group.worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
    return rl_con


def lip_jaw_skins(parents, parent, f, radius, polygon, i):
    follow = pm.group(n="LipJaw{f}Follow".format(f=f), em=1, p=parent)
    constraint = pm.parentConstraint(parents, follow)
    skin = pm.joint(follow, n="LipJaw{f}Skin".format(f=f))
    skin.radius.set(radius)
    skin.v.set(0)
    attaches = [actions.create_attach(p=None, n="Attach", i=j, plane=polygon) for j in i]
    pm.delete(pm.parentConstraint(attaches, skin))
    pm.delete(attaches)
    return locals()


def set_follow_sdk(constraint, attr, values):
    w1, w2 = pm.parentConstraint(constraint, q=1, wal=1)
    pm.setDrivenKeyframe(w1, cd=attr, dv=values[0], v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(w1, cd=attr, dv=values[1], v=1, itt="linear", ott="linear")
    pm.setDrivenKeyframe(w2, cd=attr, dv=values[1], v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(w2, cd=attr, dv=values[0], v=1, itt="linear", ott="linear")


def lip_jaw(JawParent, JawTwist, JawUp, radius, polygon, rl_con, **kwargs):
    group = actions.create_group("|FaceGroup|FaceConnectGroup|LipConnectGroup|LipJawGroup", init=False)
    results = []
    for rl, con, i, j, k in [["Rt", rl_con[0], [0, 7], [1], [8]], ["Lf", rl_con[1], [6, 13], [5], [12]]]:
        results.append(lip_jaw_skins([JawTwist, JawParent], group, rl, radius, polygon, i))
        pm.setDrivenKeyframe(results[-1]["skin"].tx, cd=JawParent.rx, dv=0, v=results[-1]["skin"].tx.get(),
                             itt="linear", ott="linear")
        pm.setDrivenKeyframe(results[-1]["skin"].tx, cd=JawParent.rx, dv=90, v=0, itt="linear", ott="linear")

        con.addAttr("follow", max=5, min=-5, at="double", k=1)
        set_follow_sdk(results[-1]["constraint"], con.attr("follow"), [-5, 5])
        con.addAttr("smooth", max=-5, min=5, at="double", k=1)
        results.append(lip_jaw_skins([JawUp, results[-1]["follow"]], group, rl+"Up", radius, polygon, j))
        set_follow_sdk(results[-1]["constraint"], con.attr("smooth"), [-5, 5])
        results.append(lip_jaw_skins([JawParent, results[-2]["follow"]], group, rl+"Dn", radius, polygon, k))
        set_follow_sdk(results[-1]["constraint"], con.attr("smooth"), [-5, 5])

    results.append(lip_jaw_skins(JawUp, group, "Up", radius, polygon, [3]))
    results.append(lip_jaw_skins(JawParent, group, "Dn", radius, polygon, [10]))
    skin_cluster = pm.skinCluster([res["skin"] for res in results], polygon, n="LipSK")

    weights.load_weight(skin_cluster, "LipPolygon")
    for cluster_shape in pm.ls("clusterHandleShape", type="clusterHandle"):
        cluster_shape.rename(cluster_shape.getParent().name() + "Shape")


def lip_main(control_group, radius, connect_group, polygon, SelectionLipRoll, SelectionLipJoint, JawParent, JawTwist,
             **kwargs):
    err = False
    if err:
        return pm.warning("can not find jaw object")
    length = (SelectionLipRoll.getTranslation(space="world")-SelectionLipJoint.getTranslation(space="world")).length()
    pre = pm.group(em=1, n="LipMainPre", p=connect_group)
    pre.setTranslation(SelectionLipRoll.getTranslation(space="world"), space="world")
    pre.tx.set(0)
    hand = pm.group(em=1, n="LipMainHand", p=pre)
    hand.rotateOrder.set(2)
    pm.select(polygon)
    cluster, _ = pm.cluster(n="LipMainCluster", wn=(hand, hand))
    pre.worldInverseMatrix[0].connect(cluster.bindPreMatrix)

    follow = pm.group(n="LipMainFollow", em=1, p=connect_group)
    pm.parentConstraint(JawTwist, JawParent, follow)

    zero = pm.group(em=1, p=control_group, n="LipMainZero")
    zero.setTranslation(SelectionLipJoint.getTranslation(space="world"), space="world")
    zero.tx.set(0)

    constraint = pm.parentConstraint(follow, zero, mo=1)
    connect_group.worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
    constraint.setParent(follow)
    con = control.control_create(p=zero, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="LipMain", c=13, r=radius * 4.2,
                                 o=[0, 0, radius*8], n="LipMainControl")

    # unit = pm.createNode("unitConversion", n="LipMainRyUnit")
    # unit.conversionFactor.set(1/length)
    # con.tx.connect(unit.input)
    # unit.output.connect(hand.ry)

    # unit = pm.createNode("unitConversion", n="LipMainRxUnit")
    # unit.conversionFactor.set(-1/length)
    # con.ty.connect(unit.input)
    # unit.output.connect(hand.rx)
    # con.rz.connect(hand.rz)
    con.t.connect(hand.t)
    return con


def set_lip_sdk(attr, cd, dv0, dv1):
    if not attr.inputs():
        sum_node = pm.createNode("plusMinusAverage", n="LipSdk{attr}Sum".format(attr=attr.name(includeNode=True)))
        pm.setDrivenKeyframe(attr, cd=sum_node.output1D, dv=0, v=0, itt="linear", ott="linear")
        pm.setDrivenKeyframe(attr, cd=sum_node.output1D, dv=1, v=1, itt="linear", ott="linear")
    else:
        sum_node = attr.inputs()[-1].inputs()[-1]
    i = sum_node.input1D.getNumElements()
    pm.setDrivenKeyframe(sum_node.input1D[i], cd=cd, dv=dv0, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(sum_node.input1D[i], cd=cd, dv=dv1, v=1, itt="linear", ott="linear")


def lip_sdk(SelectionNoseJoint, SelectionLipUpCurve, SelectionLipDnCurve, radius, polygon, **kwargs):
    group = pm.group(em=1, p="LipMainControl", n="LipMdGroup")
    group.tz.set(radius*8)
    group.s.set(radius/2, radius/2, radius/2)

    con = control.control_create(p=group, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="lipCentre",
                                 c=14, r=2.8, n="LipSdkControl")
    pm.transformLimits(con, tx=[-10, 10], etx=(True, True),
                       ty=[-10, 10], ety=(True, True), tz=[-10, 10], etz=(True, True))

    group = pm.group(em=1, p=con, n="LipSdkUpGroup")
    group.ty.set(4)
    up_con = control.control_create(p=group, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="circle",
                                    c=14, r=2, n="LipSdkUpControl")
    pm.transformLimits(up_con, tx=[-10, 10], etx=(True, True),
                       ty=[0, 10], ety=(True, True), tz=[-10, 10], etz=(True, True))

    group = pm.group(em=1, p=con, n="LipSdkDnGroup")
    group.ty.set(-4)
    group.sy.set(-1)
    dn_con = control.control_create(p=group, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="circle",
                                    c=14, r=2, n="LipSdkDnControl")
    pm.transformLimits(dn_con, tx=[-10, 10], etx=(True, True),
                       ty=[0, 10], ety=(True, True), tz=[-10, 10], etz=(True, True))

    group = pm.group(em=1, p=con, n="LipSdkLfGroup")
    group.tx.set(4)
    lf_con = control.control_create(p=group, l=["tz", "rx", "ry", "rz", "sx", "sy", "sz", "v"], s="circle",
                                    c=14, r=2, n="LipSdkLfControl")
    pm.transformLimits(lf_con, tx=[-10, 10], etx=(True, True), ty=[-10, 10], ety=(True, True))

    group = pm.group(em=1, p=con, n="LipSdkRtGroup")
    group.tx.set(-4)
    group.sx.set(-1)
    rt_con = control.control_create(p=group, l=["tz", "rx", "ry", "rz", "sx", "sy", "sz", "v"], s="circle",
                                    c=14, r=2, n="LipSdkRtControl")
    pm.transformLimits(rt_con, tx=[-10, 10], etx=(True, True), ty=[-10, 10], ety=(True, True))
    attributes = [
        "LfUp", "LfDn", "LfOt", "LfIn", # "LfUpOt", "LfDnOt",
        "RtUp", "RtDn", "RtOt", "RtIn", # "RtUpOt", "RtDnOt",
        "LfUpU", "LfDnU", "RtUpU", "RtDnU",
        "LfUpE", "LfDnE", "RtUpE", "RtDnE",
        "MdUp", "MdDn", "MdLf", "MdRt",
        "UpLf", "UpRt", "DnLf", "DnRt",
    ]
    bs = pm.blendShape(polygon, n="LipBS", automatic=1)[0]
    for i, attr in enumerate(attributes):
        target = polygon.duplicate()[0]
        target.rename(attr)
        pm.blendShape(bs, e=1, tc=1, t=(polygon, i, target, 1))
        pm.delete(target)

    set_lip_sdk(bs.LfUp, lf_con.ty, 0, 10)
    set_lip_sdk(bs.LfDn, lf_con.ty, 0, -10)
    set_lip_sdk(bs.LfOt, lf_con.tx, 0, 10)
    set_lip_sdk(bs.LfIn, lf_con.tx, 0, -10)

    set_lip_sdk(bs.LfUpE, lf_con.tx, 0, 10)
    set_lip_sdk(bs.LfDnE, lf_con.tx, 0, 10)
    set_lip_sdk(bs.LfUpU, lf_con.tx, 0, -10)
    set_lip_sdk(bs.LfDnU, lf_con.tx, 0, -10)

    set_lip_sdk(bs.RtUp, rt_con.ty, 0, 10)
    set_lip_sdk(bs.RtDn, rt_con.ty, 0, -10)
    set_lip_sdk(bs.RtOt, rt_con.tx, 0, 10)
    set_lip_sdk(bs.RtIn, rt_con.tx, 0, -10)

    set_lip_sdk(bs.RtUpE, rt_con.tx, 0, 10)
    set_lip_sdk(bs.RtDnE, rt_con.tx, 0, 10)
    set_lip_sdk(bs.RtUpU, rt_con.tx, 0, -10)
    set_lip_sdk(bs.RtDnU, rt_con.tx, 0, -10)

    set_lip_sdk(bs.LfIn, con.tz, 0, 10)
    set_lip_sdk(bs.RtIn, con.tz, 0, 10)
    set_lip_sdk(bs.LfOt, con.tz, 0, -10)
    set_lip_sdk(bs.RtOt, con.tz, 0, -10)

    set_lip_sdk(bs.LfUpU, con.tz, 0, 10)
    set_lip_sdk(bs.LfDnU, con.tz, 0, 10)
    set_lip_sdk(bs.RtUpU, con.tz, 0, 10)
    set_lip_sdk(bs.RtDnU, con.tz, 0, 10)

    set_lip_sdk(bs.LfUpE, con.tz, 0, -10)
    set_lip_sdk(bs.LfDnE, con.tz, 0, -10)
    set_lip_sdk(bs.RtUpE, con.tz, 0, -10)
    set_lip_sdk(bs.RtDnE, con.tz, 0, -10)

    set_lip_sdk(bs.MdUp, con.ty, 0, 10)
    set_lip_sdk(bs.MdDn, con.ty, 0, -10)
    set_lip_sdk(bs.MdLf, con.tx, 0, 10)
    set_lip_sdk(bs.MdRt, con.tx, 0, -10)

    set_lip_sdk(bs.RtUpU, up_con.tz, 0, 10)
    set_lip_sdk(bs.LfUpU, up_con.tz, 0, 10)
    set_lip_sdk(bs.RtUpE, up_con.tz, 0, -10)
    set_lip_sdk(bs.LfUpE, up_con.tz, 0, -10)

    set_lip_sdk(bs.RtDnU, dn_con.tz, 0, 10)
    set_lip_sdk(bs.LfDnU, dn_con.tz, 0, 10)
    set_lip_sdk(bs.RtDnE, dn_con.tz, 0, -10)
    set_lip_sdk(bs.LfDnE, dn_con.tz, 0, -10)

    for ud, ud_con in zip(["Up", "Dn"], [up_con, dn_con]):
        for rl, dv in zip(["Rt", "Lf"], [-10, 10]):
            multiply = pm.createNode("multiplyDivide", n="Lip{ud}{rl}SdkMultiply".format(rl=rl, ud=ud))
            pm.setDrivenKeyframe(multiply.input1X, cd=ud_con.tx, dv=0, v=1, itt="linear", ott="linear")
            pm.setDrivenKeyframe(multiply.input1X, cd=ud_con.tx, dv=dv, v=0, itt="linear", ott="linear")
            ud_con.ty.connect(multiply.input2X)
            pm.setDrivenKeyframe(bs.attr(ud+rl), cd=multiply.outputX, dv=0, v=0, itt="linear", ott="linear")
            pm.setDrivenKeyframe(bs.attr(ud+rl), cd=multiply.outputX, dv=10, v=1, itt="linear", ott="linear")
            # multiply = pm.createNode("multiplyDivide", n="Lip{rl}{ud}OtSdkMultiply".format(rl=rl, ud=ud))
            # bs.attr(rl + "Ot").connect(multiply.input1X)
            # bs.attr(rl + ud).connect(multiply.input2X)
            # multiply.outputX.connect(bs.attr(rl+ud+"Ot"))

    temp = pm.group(em=1)
    groups = []
    for i in range(14):
        attach = actions.create_attach(p=temp, n="LipRtAttach", i=i, plane=polygon)
        group = pm.group(em=1, p=temp)
        group.setMatrix(attach.getMatrix(ws=1), ws=1)
        pm.delete(attach)
        groups.append(group)
    height = SelectionNoseJoint.getTranslation(space="world")[1] - groups[3].getTranslation(space="world")[1]
    liner = [[0, -height, 0], [0, height, 0]]
    up_points = actions.get_points_by_curve(SelectionLipUpCurve, 5)
    dn_points = actions.get_points_by_curve(SelectionLipDnCurve, 5)
    points = [(up+dn)/2 for up, dn in zip(up_points, dn_points)]
    temp_curve = actions.create_curve_by_points(points, n="temp", p=temp)
    points = actions.get_points_by_curve(temp_curve, 5)
    points.insert(0, points[0] + points[0] - points[1])
    points.append(points[-1] + points[-1] - points[-2])
    for i in range(len(points) / 2):
        points[-i - 1][0] = -points[i][0]
        points[-i - 1][1] = points[i][1]
        points[-i - 1][2] = points[i][2]
    surface = actions.create_surface_by_points(points=points, liner_point=liner, p=temp)
    us = [1.0/6*u for u in [1, 1+1.0/3, 2, 3, 4, 4+2.0/3, 5, 1, 1+1.0/3, 2, 3, 4, 4+2.0/3, 5]]
    follicles = []
    for u, group in zip(us, groups):
        follicle = actions.make_follicle(g=surface, p=temp, u=u, t=1, v=0.5, r=0, n="follicle")
        offset = pm.group(em=1, p=group)
        offset.setParent(follicle)
        group.setParent(offset)
        follicles.append(follicle)
    uv_data = dict(
        RtUp=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [1, 0.6, 0.2, 0, 0, 0, 0,
               1, 0.6, 0.2, 0, 0, 0, 0, ], ],
        RtDn=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [-1, -0.6, -0.2, 0, 0, 0, 0,
               -1, -0.6, -0.2, 0, 0, 0, 0, ], ],
        RtIn=[[1, 0.85, 0.5, 0, 0, 0, 0,
               1, 0.85, 0.5, 0, 0, 0, 0, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        RtOt=[[-1, -0.85, -0.5, 0, 0, 0, 0,
               -1, -0.85, -0.5, 0, 0, 0, 0, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        LfUp=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0, 0, 0.2, 0.6, 1,
               0, 0, 0, 0, 0.2, 0.6, 1, ], ],
        LfDn=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0, 0, -0.2, -0.6, -1,
               0, 0, 0, 0, -0.2, -0.6, -1, ], ],
        LfOt=[[0, 0, 0, 0, 0.5, 0.85, 1,
               0, 0, 0, 0, 0.5, 0.85, 1, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        LfIn=[[0, 0, 0, 0, -0.5, -0.85, -1,
               0, 0, 0, 0, -0.5, -0.85, -1, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        MdUp=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0.5, 0.6, 0.9, 1, 0.9, 0.6, 0.5,
               0.5, 0.6, 0.9, 1, 0.9, 0.6, 0.50, ], ],
        MdDn=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [-0.5, -0.6, -0.9, -1, -0.9, -0.6, -0.5,
               -0.5, -0.6, -0.9, -1, -0.9, -0.6, -0.50, ], ],
        MdRt=[[-0.5, -0.6, -0.9, -1, -0.9, -0.6, -0.5,
               -0.5, -0.6, -0.9, -1, -0.9, -0.6, -0.50, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        MdLf=[[0.5, 0.6, 0.9, 1, 0.9, 0.6, 0.5,
               0.5, 0.6, 0.9, 1, 0.9, 0.6, 0.50, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        DnLf=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, -0.3, -1, -0.5, 0, 0, 0, ], ],
        DnRt=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, -0.5, -1, -0.3, 0, ], ],
        UpLf=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0.3, 1, 0.5, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        UpRt=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0, 0.5, 1, 0.3, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        RtUpU=[[0, 0, 0, 0, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ],
              [0, 0, 0.16, 0.09, 0, 0, 0,
               0, 0, 0, 0, 0, 0, 0, ], ],
        LfUpU=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, 0.09, 0.16, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ], ],
        RtDnU=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, -0.16, -0.09, 0, 0, 0, ], ],
        LfDnU=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, -0.09, -0.16, 0, 0, ], ],
        RtUpE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, -0.02, -0.08, -0.04, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ], ],
        LfUpE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, -0.04, -0.08, -0.02, 0,
                0, 0, 0, 0, 0, 0, 0, ], ],
        RtDnE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0.02, 0.08, 0.04, 0, 0, 0, ], ],
        LfDnE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0, ],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0.08, 0.08, 0.02, 0, ], ],
    )
    zero_offset_rolls = [[0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, ],
                         [0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, ]]
    offset_rolls = dict(
        RtUpU=[[0, 0, 0.3, 0.25, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0],
               [0, 0, -35, -30, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0]],
        LfUpU=[[0, 0, 0, 0.25, 0.3, 0, 0,
                0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, -30, -35, 0, 0,
                0, 0, 0, 0, 0, 0, 0]],
        RtDnU=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0.3, 0.25, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, 35, 30, 0, 0, 0]],
        LfDnU=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 0.25, 0.3, 0, 0],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, 30, 35, 0, 0]],

        RtUpE=[[0, 0, -0.2, -0.1, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0],
               [0, 0, 20, 10, 0, 0, 0,
                0, 0, 0, 0, 0, 0, 0]],
        LfUpE=[[0, 0, 0, -0.1, -0.2, 0, 0,
                0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 10, 20, 0, 0,
                0, 0, 0, 0, 0, 0, 0]],
        RtDnE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, -0.2, -0.1, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, -20, -10, 0, 0, 0]],
        LfDnE=[[0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, -0.1, -0.2, 0, 0],
               [0, 0, 0, 0, 0, 0, 0,
                0, 0, 0, -10, -20, 0, 0]],
    )
    for attr, uvs in uv_data.items():
        for follicle, u, v, o in zip(follicles, uvs[0], uvs[1], us):
            follicle.parameterV.set(0.5+v*0.5)
            follicle.parameterU.set(1.0/6*u+o)
        offset_roll = offset_rolls.get(attr, zero_offset_rolls)
        for group, offset, roll in zip(groups, offset_roll[0], offset_roll[1]):
            group.tz.set(offset*height)
            group.ry.set(roll)
        target = actions.create_plane(n=attr, p=temp, radius=radius, transforms=groups)
        pm.blendShape(bs, e=1, ib=1, t=(polygon, attributes.index(attr), target, 1))
        bs.attr(attr).connect(target.v)
    pm.delete(temp)


def lip_rig(**kwargs):
    err = False
    SelectionLipUpCurve, err = actions.find_node_by_name("SelectionLipUpCurve", err)
    SelectionLipDnCurve, err = actions.find_node_by_name("SelectionLipDnCurve", err)
    SelectionNoseJoint, err = actions.find_node_by_name("SelectionNoseJoint", err)
    SelectionLipJoint, err = actions.find_node_by_name("SelectionLipJoint", err)
    JawParent, err = actions.find_node_by_name("JawParent", err)
    JawTwist, err = actions.find_node_by_name("JawTwist", err)
    JawUp, err = actions.find_node_by_name("JawUp", err)
    SelectionLipJoint, err = actions.find_node_by_name("SelectionLipJoint", err)
    SelectionLipRoll, err = actions.find_node_by_name("SelectionLipRoll", err)

    if err:
        return
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|LipJointGroup", init=True)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup|LipConnectGroup", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|LipControlGroup", init=True)
    radius = SelectionLipDnCurve.getShape().length()/40

    surfaces = lip_surface(**locals())
    polygon = lip_polygon(**locals())
    lip_surface_cons(**locals())
    rl_con = lip_rl(**locals())
    lip_joint_cons(**locals())
    main_con = lip_main(**locals())
    lip_sdk(**locals())
    lip_jaw(**locals())


