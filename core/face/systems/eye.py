import pymel.core as pm
from MayaCraft.core.face.utils import actions
from MayaCraft.core.face.utils import weights
from MayaCraft.core.face.utils import control


def main_con(joint_group, length, radius, control_group, connect_group, SelectionEyeRoll, SelectionEyeJoint,
             rl="Rt", s=1, **kwargs):
    n = "EyeMain{rl}".format(rl=rl)
    offset = pm.group(em=1, p=connect_group, n=n+"Offset")
    point1 = SelectionEyeRoll.getTranslation(space="world")
    point2 = SelectionEyeJoint.getTranslation(space="world")
    point1[0] = point1[0]*s
    point2[0] = point2[0]*s
    offset.setTranslation(point1, space="world")
    temp = pm.group(em=1)
    temp.setTranslation(point2, space="world")
    pm.delete(pm.aimConstraint(temp, offset, wut="scene", aim=[0, 0, 1], u=[0, 1, 0]))
    pm.delete(temp)

    parent = pm.group(em=1, n=n+"Parent", p=offset)

    group = pm.group(em=1, n=n+"Zero", p=control_group)
    group.setMatrix(offset.getMatrix(ws=1), ws=1)
    con = control.control_create(p=group, n=n + "Control", s="eyeMain", c=13, l=["v", "rx", "ry", "rz", "sx", "sy", "sz"],
                                 r=radius*8, o=[0, 0, length*1.5])
    hand = pm.group(em=1, p=offset, n=n+"Hand")
    con.s.connect(hand.s)
    con.t.connect(parent.t)
    return locals()


def eye_curve(up, md, dn, center, w):
    points = [[pm.datatypes.Point(p) for p in control.get_curve_shape_points(umd.getShape())] for umd in [up, md, dn]]
    md_points = [center+((up-center).length()*(1-w) + (dp-center).length()*w)*(mp-center).normal()
                 for up, mp, dp in zip(*points)]
    liner_temp = pm.curve(p=md_points, d=1)
    smooth_temp = actions.rebuild_curve(curve=liner_temp, n="EyelidRtMdWireCurve", number=5)
    md_points = [smooth_temp.getShape().closestPoint(p) for p in points[1]]
    pm.delete(liner_temp, md, smooth_temp)
    return pm.curve(p=md_points, d=1)


def eye_surface(SelectionLidMainUpCurve, SelectionLidMainDnCurve, SelectionEyeRoll, **kwargs):
    surface_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup|EyeSurfaceGroup", init=False)
    center = SelectionEyeRoll.getTranslation(space="world")
    md = SelectionLidMainUpCurve.duplicate()[0]
    pm.blendShape(SelectionLidMainDnCurve, md, w=(0, 0.5))
    md = eye_curve(SelectionLidMainUpCurve, md, SelectionLidMainDnCurve, center, 0.5)
    surface = pm.loft([SelectionLidMainUpCurve, md, SelectionLidMainDnCurve], ch=0, d=3, ss=1, c=0, u=1)[0]
    up = eye_curve(SelectionLidMainUpCurve, pm.PyNode(pm.duplicateCurve(surface.getShape().u[0.5], ch=0)[0]),
                   SelectionLidMainDnCurve, center, 0.25)
    dn = eye_curve(SelectionLidMainUpCurve, pm.PyNode(pm.duplicateCurve(surface.getShape().u[1.5], ch=0)[0]),
                   SelectionLidMainDnCurve, center, 0.75)
    pm.delete(surface, md)
    surface = pm.loft([SelectionLidMainUpCurve, up, dn, SelectionLidMainDnCurve], ch=0, d=3, ss=1, c=0, u=1)[0]
    md = eye_curve(SelectionLidMainUpCurve, pm.PyNode(pm.duplicateCurve(surface.getShape().u[1.5], ch=0)[0]),
                   SelectionLidMainDnCurve, center, 0.5)
    pm.delete(surface)
    surfaces = []
    for s, rl in [[-1, "Lf"], [1, "Rt"]]:
        for curve in [SelectionLidMainUpCurve, up, md, dn, SelectionLidMainDnCurve]:
            curve.sx.set(s)
        surface = pm.loft([SelectionLidMainUpCurve, up, md, dn, SelectionLidMainDnCurve], ch=0, d=3, ss=1, c=0, u=1)[0]

        surface.rename("Eyelid{rl}Surface".format(rl=rl))
        surface.inheritsTransform.set(0)
        surface.setParent(surface_group)
        surface.v.set(0)
        surfaces.append(surface)
    pm.delete(up, md, dn)
    return surfaces


def lip_skin_control(radius, surface, group, rl, f, ud, u, v, control_group, sx, wuo, **kwargs):
    n = "Eyelid{rl}{ud}{f}".format(rl=rl, f=f, ud=ud)
    sy = dict(Dn=-1).get(ud, 1)
    offset = pm.group(em=1, p=group, n=n + "Offset")
    aim = pm.group(em=1, p=offset, n=n + "Aim")
    roll = pm.group(em=1, p=offset, n=n + "Roll")
    z = pm.group(em=1, p=roll, n=n + "Z")
    skin = pm.joint(z, n=n + "Skin")
    follicle = actions.make_follicle(g=surface, u=u, v=v, t=1, r=1, n="follicle", p=None)
    pm.delete(pm.aimConstraint(follicle, offset, wut="objectrotation", aim=[0, 0, 1], u=[0, 1, 0], wu=[0, 1, 0], wuo=wuo))
    aim.setTranslation(follicle.getTranslation(space="world"), space="world")
    aim.t.set(0, 0, aim.tz.get())
    # pm.transformLimits(aim, ty=(0, 0), ety=(1, 0))
    z.tz.set(aim.tz.get())
    skin.radius.set(radius)
    skin.v.set(0)
    pm.aimConstraint(aim, roll, wut="none", aim=[0, 0, 1])
    second, con = actions.create_second_control(n=n, p=control_group, t=True, r=False)
    second.setMatrix(skin.getMatrix(ws=1), ws=1)
    control.control_create(con, s="ball", c=17, o=[0, 0, 0.5 * radius], r=0.5 * radius,
                           l=["sx", "sy", "sz", "rx", "ry", "rz", "v"])
    con.ty.connect(aim.ty)
    con.tx.connect(aim.tx)
    con.tz.connect(skin.tz)
    offset.sy.set(sy)
    second.sy.set(sy)
    offset.sx.set(sx)
    second.sx.set(sx)
    pm.delete(follicle)
    return locals()


def eyelid_up_dn_follow(src, dst, height):
    n = dst["con"].name().replace("Control", "")

    ty = pm.createNode("blendWeighted", n=n+"TyBlendWeighted")
    src["ty"] = ty
    src["con"].ty.connect(ty.input[0])
    ty.weight[0].set(1)
    pm.setDrivenKeyframe(ty.input[1], cd=dst["con"].ty, dv=-height, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(ty.input[1], cd=dst["con"].ty, dv=-height-1, v=1, itt="linear", ott="linear")
    ty.input[1].inputs()[0].preInfinity.set(4)
    ty.weight[1].set(1)
    src["aim"].ty.inputs(p=1)[0].disconnect(src["aim"].ty)
    pm.setDrivenKeyframe(src["aim"].ty, cd=ty.output, dv=0, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(src["aim"].ty, cd=ty.output, dv=1, v=1, itt="linear", ott="linear")
    src["aim"].ty.inputs()[0].postInfinity.set(4)


def get_height_vs_params(surface):
    shape = surface.getShape()
    num_v = shape.numCVsInV()
    temp_curve = pm.PyNode(pm.duplicateCurve(shape.u[3], ch=0)[0])
    width = temp_curve.getShape().length()
    vs = [temp_curve.getShape().findParamFromLength(width*0.25*i)/(num_v-1) for i in range(1, 4)]
    pm.delete(temp_curve)
    temp_curves = [pm.PyNode(pm.duplicateCurve(shape.v[v*(num_v-1)], ch=0)[0]) for v in vs]
    heights = [temp_curve.getShape().length() for temp_curve in temp_curves]
    pm.delete(temp_curves)
    points = [pm.datatypes.Point(*pm.xform(surface.getShape().cv[4][i], q=1, t=1)) for i in range(num_v)]
    lengths = [(points[i] - point).length() for i, point in enumerate(points[1:])]
    width = sum(lengths)
    params = [sum(lengths[:i])/width for i in range(len(points))]
    # print params
    return heights, vs, params


def eyelid_skin_md_follow(skin1, skin2, skin3, sy):
    n = skin3["aim"].replace("Aim", "")
    sdk = pm.createNode("blendWeighted", n=n+"SdkBlendWeighted")
    skin3["ty"] = sdk
    pm.setDrivenKeyframe(sdk.input[0], cd=skin1["ty"].output, dv=1, v=1, itt="linear", ott="linear")
    pm.setDrivenKeyframe(sdk.input[0], cd=skin1["ty"].output, dv=0, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(sdk.input[0], cd=skin1["ty"].output, dv=-1, v=-1, itt="linear", ott="linear")
    sdk.input[0].inputs()[0].postInfinity.set(4)
    sdk.input[0].inputs()[0].preInfinity.set(4)
    skin3["con"].ty.connect(sdk.input[1])
    sdk.weight[0].set(1)
    sdk.weight[1].set(1.0)

    ty = pm.createNode("blendWeighted", n=n+"TyBlendWeighted")
    skin2["aim"].ty.connect(ty.input[0])
    pm.setDrivenKeyframe(ty.input[1], cd=sdk.output, dv=0, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(ty.input[1], cd=sdk.output, dv=1, v=1, itt="linear", ott="linear")
    ty.input[1].inputs()[0].postInfinity.set(4)
    ty.weight[0].set(0.5*sy)
    ty.weight[1].set(1.0)
    ty.output.connect(skin3["aim"].ty, f=1)

    tx = pm.createNode("blendWeighted", n=n+"TxBlendWeighted")
    skin1["aim"].tx.connect(tx.input[0])
    skin2["aim"].tx.connect(tx.input[1])
    skin3["con"].tx.connect(tx.input[2])
    tx.weight[0].set(0.5)
    tx.weight[1].set(0.5)
    tx.weight[2].set(1.0)
    tx.output.connect(skin3["aim"].tx, f=1)

    tz = pm.createNode("blendWeighted", n=n+"TzBlendWeighted")
    skin1["skin"].tz.connect(tz.input[0])
    skin2["skin"].tz.connect(tz.input[1])
    skin3["con"].tz.connect(tz.input[2])
    tz.weight[0].set(0.5)
    tz.weight[1].set(0.5)
    tz.weight[2].set(1.0)
    tz.output.connect(skin3["skin"].tz, f=1)


def eyelid_skin(main, surface, radius, rl, control_group, sx, heights, vs, params, **kwargs):
    group = pm.group(em=1, n="Eyelid{rl}SkinGroup".format(rl=rl), p=main["parent"])

    temp = actions.make_follicle(g=surface, u=0, v=vs[1], t=1, r=0, n="follicle", p=None)
    wuo = actions.make_follicle(g=surface, u=1, v=vs[1], t=1, r=0, n="follicle", p=None)
    pm.delete(pm.aimConstraint(temp, wuo, wut="none", aim=[0, 1, 0]))
    pm.delete(temp)
    lip_skins = [lip_skin_control(**locals()) for v, f in zip(vs, ["Ot", "Md", "In"])
                 for ud, u, in [["Up", 0], ["Dn", 1]]]
    ud = ""
    lip_skins += [lip_skin_control(**locals()) for v, f in [[0, "Ot"], [1, "In"]]]
    pm.delete(wuo)
    for i in [2, 3, 6, 7]:
        control.control_create(lip_skins[i]["con"], c=13)

    height = heights[1]
    eyelid_up_dn_follow(lip_skins[2], lip_skins[3], height)
    eyelid_up_dn_follow(lip_skins[3], lip_skins[2], height)

    eyelid_skin_md_follow(lip_skins[2], lip_skins[-2], lip_skins[0], 1)
    eyelid_skin_md_follow(lip_skins[3], lip_skins[-2], lip_skins[1], -1)
    eyelid_skin_md_follow(lip_skins[2], lip_skins[-1], lip_skins[4], 1)
    eyelid_skin_md_follow(lip_skins[3], lip_skins[-1], lip_skins[5], -1)

    # edit_up_dn_main(results[1], results[0], "Dn", height, rl, -1, radius)

    skin_cluster = pm.skinCluster([s["skin"] for s in lip_skins], surface, n="Eyelid{rl}SK".format(rl=rl), sm=1)
    wts = []

    for u in range(7):
        w = [0, 0.0833, 0.25, 0.5, 0.75, 0.9167, 1][u]
        wus = [1-w, w, 1-w, w, 1-w, w, 1, 1]
        for p in params:
            wvs = [weights.get_widget(abs(p - j) * 3.5, [0, 0.4, 0.6, 1], [1, 0.8, 0.2, 0])
                   for i, j in enumerate([0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 0, 1])]
            for wu, wv in zip(wus, wvs):
                wts.append(wu*wv)
    skin_cluster.setWeights(skin_cluster.getGeometry()[0], range(8),  wts, normalize=False)
    pm.skinCluster(skin_cluster, e=1, fnw=1)
    return lip_skins


def local_follicle_to_world(follicle):
    pmm = pm.createNode("pointMatrixMult", n=follicle.name() + "PMM")
    follicle.outTranslate.connect(pmm.inPoint)
    follicle.parentInverseMatrix[0].connect(pmm.inMatrix)
    pmm.output.connect(follicle.t, f=1)
    follicle.inheritsTransform.set(1)


def eyelid_up_dn_joint(tys, vs, surface, radius, heights, params, ud, su, eu, rl, main, **kwargs):
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|EyeJointGroup|Eyelid{rl}JointGroup".format(rl=rl),
                                       init=False)
    curve_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup|EyelidCurveGroup", init=False)
    curve_group.inheritsTransform.set(0)
    points = [[x, su, 0] for x in [0, 0.5/3, 0.5, 1-0.5/3, 1]]
    curve = pm.curve(p=points, d=3)
    curve.rename("Eyelid{rl}{ud}Curve".format(rl=rl, ud=ud))
    curve.v.set(0)
    curve.setParent(curve_group)

    locator_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup|EyelidLocatorGroup", init=False)
    locator_group.inheritsTransform.set(0)
    locators = actions.create_locator(curve=curve, prefix="Eyelid{rl}{ud}".format(rl=rl, ud=ud), group=locator_group)
    for i in [0, -1]:
        locator = locators.pop(i)
        locators[i].ty.connect(locator.ty)
        locators[i].localPositionY.connect(locator.localPositionY)
    for i, v, locator in zip(range(3), vs, locators):
        pm.setDrivenKeyframe(locator.localPositionY, cd=tys[i].output, dv=2*heights[1], v=-2*(eu-su), itt="linear", ott="linear")
        pm.setDrivenKeyframe(locator.localPositionY, cd=tys[i].output, dv=-2*heights[1], v=2*(eu-su), itt="linear", ott="linear")

    follicles = []
    follicle_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup|EyelidFollicleGroup", init=False)
    for i in range(1, len(params)-1, 1):
        n = "Eyelid{rl}{ud}{i:0>2}".format(rl=rl, ud=ud, i=i)
        follicle = actions.make_follicle(g=surface, u=1, v=1.0 / (len(params) - 1) * i, t=1, r=0, n=n + "Follicle",
                                         p=follicle_group)
        pnc = pm.createNode("pointOnCurveInfo", n=n+"PointOnCurve")
        curve.worldSpace[0].connect(pnc.inputCurve)
        pnc.parameter.set(params[i]*2)
        pnc.positionY.connect(follicle.parameterU)
        pm.aimConstraint(main["parent"], follicle, wut="none", aim=[0, 0, -1])
        local_follicle_to_world(follicle)
        joint = pm.joint(joint_group, n=n+"Joint", radius=radius/4)
        pm.parent(pm.parentConstraint(follicle, joint), follicle)
        follicles.append(follicle)
    return follicles


def eyelid_collision(up, dn, rl):
    for i, u, d in zip(range(len(up)), up, dn):
        u_attr = u.parameterU.inputs(p=1)[0]
        d_attr = d.parameterU.inputs(p=1)[0]
        n = "Eyelid{rl}{i:0>2}Collision".format(rl=rl, i=i+1)
        average = pm.createNode("plusMinusAverage", n=n + "Average")
        u_attr.connect(average.input1D[0])
        d_attr.connect(average.input1D[1])
        average.operation.set(3)
        cond = pm.createNode("condition", n=n+"Condition")
        u_attr.connect(cond.firstTerm)
        d_attr.connect(cond.secondTerm)
        cond.operation.set(4)
        u_attr.connect(cond.colorIfTrueR)
        d_attr.connect(cond.colorIfTrueG)
        average.output1D.connect(cond.colorIfFalseR)
        average.output1D.connect(cond.colorIfFalseG)
        cond.outColorR.connect(u.parameterU, f=1)
        cond.outColorG.connect(d.parameterU, f=1)


def eyelid_rl_joint(surface, rl, main, io, radius, v, **kwargs):
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|EyeJointGroup|Eyelid{rl}JointGroup".format(rl=rl),
                                       init=False)
    follicle_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup|EyelidFollicleGroup", init=False)
    n = "Eyelid{rl}{io}".format(rl=rl, io=io)

    follicle = actions.make_follicle(g=surface, u=0.5, v=v, t=1, r=0, n=n + "Follicle", p=follicle_group)
    local_follicle_to_world(follicle)
    pm.aimConstraint(main["parent"], follicle, wut="none", aim=[0, 0, -1])
    joint = pm.joint(joint_group, n=n + "Joint", radius=radius / 4)
    pm.parent(pm.parentConstraint(follicle, joint), follicle)


def eyelid_joints(skins, **kwargs):
    up = eyelid_up_dn_joint(tys=[skins[i]["ty"] for i in [0, 2, 4]],  ud="Up", su=0, eu=1, **kwargs)
    dn = eyelid_up_dn_joint(tys=[skins[i]["ty"] for i in [1, 3, 5]],  ud="Dn", su=1, eu=0, **kwargs)
    eyelid_collision(up, dn, rl=kwargs["rl"])
    eyelid_rl_joint(io="Ot", v=0, **kwargs)
    eyelid_rl_joint(io="In", v=1, **kwargs)


def eyelid(SelectionLidMainUpCurve, SelectionLidMainDnCurve, SelectionEyeRoll, SelectionEyeJoint,
           connect_group, joint_group, control_group, r_main, l_main, radius, **kwargs):
    surfaces = eye_surface(**locals())
    heights, vs, params = get_height_vs_params(surfaces[1])
    # print vs, params
    r_skins = eyelid_skin(surface=surfaces[1], main=r_main, rl="Rt", sx=1, **locals())
    l_skins = eyelid_skin(surface=surfaces[0], main=l_main, rl="Lf", sx=-1, **locals())

    eyelid_joints(surface=surfaces[1], rl="Rt", skins=r_skins, main=r_main, **locals())
    eyelid_joints(surface=surfaces[0], rl="Lf", skins=l_skins, main=l_main, **locals())
    return r_skins, l_skins


def border_skin(radius, group, control_group, point, rl, f, sx, wuo, sy):
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|EyeJointGroup|EyeBorder{rl}JointGroup".format(rl=rl),
                                       init=False)
    n = "EyeBorder{rl}{f}".format(rl=rl, f=f)
    offset = pm.group(em=1, p=group, n=n + "Offset")
    aim = pm.group(em=1, p=offset, n=n + "Aim")
    roll = pm.group(em=1, p=offset, n=n + "Roll")
    z = pm.group(em=1, p=roll, n=n + "Z")
    parent = pm.group(em=1, p=z, n=n + "Parent")
    second, con = actions.create_second_control(n=n, p=control_group, t=True, r=False)
    second.setTranslation(point, space="world")
    second.sx.set(sx)
    second.sy.set(sy)
    control.control_create(con, s="ball", c=17, o=[0, 0, 0.5 * radius], r=0.5 * radius,
                           l=["sx", "sy", "sz", "v"])

    pm.delete(pm.aimConstraint(second, offset, wut="none", aim=[0, 0, 1]))
    pm.delete(pm.aimConstraint(second, offset, wut="objectrotation", aim=[0, 0, 1], u=[0, 1, 0], wu=[0, 1, 0], wuo=wuo))
    aim.setTranslation(point, space="world")
    aim.t.set(0, 0, aim.tz.get())
    offset.sx.set(sx)
    offset.sy.set(sy)
    z.tz.set(aim.tz.get())
    pm.aimConstraint(aim, roll, wut="none", aim=[0, 0, 1])
    second.setMatrix(parent.getMatrix(ws=1), ws=1)
    con.ty.connect(aim.ty)
    con.tx.connect(aim.tx)
    con.tz.connect(parent.tz)
    con.r.connect(parent.r)
    joint = pm.joint(joint_group, n=n+"Joint", radius=radius/2)
    joint.setMatrix(parent.getMatrix(ws=1), ws=1)
    pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)
    return locals()


def eye_border_mid(border1, border2, border3, sy):
    n = border3["aim"].replace("Aim", "")
    ty = pm.createNode("blendWeighted", n=n+"TyBlendWeighted")
    border1["aim"].ty.connect(ty.input[0])
    border2["aim"].ty.connect(ty.input[1])
    border3["con"].ty.connect(ty.input[2])
    ty.weight[0].set(0.5*sy)
    ty.weight[1].set(0.5)
    ty.weight[2].set(1)
    ty.output.connect(border3["aim"].ty, f=1)

    tx = pm.createNode("blendWeighted", n=n+"txBlendWeighted")
    border1["aim"].tx.connect(tx.input[0])
    border2["aim"].tx.connect(tx.input[1])
    border3["con"].tx.connect(tx.input[2])
    tx.weight[0].set(0.5)
    tx.weight[1].set(0.5)
    tx.weight[2].set(1)
    tx.output.connect(border3["aim"].tx, f=1)

    tz = pm.createNode("blendWeighted", n=n+"TzBlendWeighted")
    border1["parent"].tz.connect(tz.input[0])
    border2["parent"].tz.connect(tz.input[1])
    border3["con"].tz.connect(tz.input[2])
    tz.weight[0].set(0.5)
    tz.weight[1].set(0.5)
    tz.weight[2].set(1)
    tz.output.connect(border3["parent"].tz, f=1)


def eye_border(SelectionLidOuterUpCurve, SelectionLidOuterDnCurve, control_group, main, rl, radius, sx,
               skins, **kwargs):
    SelectionLidOuterUpCurve.sx.set(sx)
    SelectionLidOuterDnCurve.sx.set(sx)
    wuo = pm.group(em=1)
    wuo.setMatrix(skins[3]["con"].getMatrix(ws=1), ws=1)
    pm.delete(pm.aimConstraint(skins[2]["con"], wuo, wut="none", aim=[0, 1, 0]))
    points = [actions.get_points_by_curve(curve, 5) for curve in
              [SelectionLidOuterUpCurve, SelectionLidOuterDnCurve]]
    group = pm.group(em=1, p=main["parent"], n="EyeBorder{rl}SkinGroup".format(rl=rl))
    borders = [border_skin(radius, group, control_group, point, rl, f, sx, wuo, sy)
               for point, f, sy in zip(points[0][:4]+list(reversed(points[1]))[:4],
                                       ["Ot", "OtUp", "Up", "InUp", "In", "InDn", "Dn", "OtDn"],
                                       [1, 1, 1, 1, 1, -1, -1, -1])]
    pm.delete(wuo)
    for i in [0, 2, 4, 6]:
        control.control_create(borders[i]["con"], c=13)
    eye_border_mid(borders[0], borders[2], borders[1], sy=1)
    eye_border_mid(borders[4], borders[2], borders[3], sy=1)
    eye_border_mid(borders[0], borders[6], borders[7], sy=-1)
    eye_border_mid(borders[4], borders[6], borders[5], sy=-1)
    return borders


def eye_aim(main, rl, sx, length, joint_group, radius, control_group, **kwargs):
    n = "Eye{rl}".format(rl=rl)
    roll = pm.group(em=1, p=main["parent"], n=n+"Aim")
    sdk = pm.group(em=1, p=roll, n=n + "Sdk")
    parent = pm.group(em=1, p=sdk, n=n+"Parent")
    offset = pm.group(em=1, p=main["parent"], n=n+"Offset")
    aim = pm.group(em=1, p=offset, n=n+"Aim")
    joint = pm.joint(joint_group, n=n+"Joint", radius=radius)

    offset.tz.set(length*5)

    pm.parent(pm.parentConstraint(parent, joint), parent)
    pm.aimConstraint(aim, roll, wut="objectrotation", aim=[0, 0, 1], u=[0, 1, 0], wu=[0, 1, 0], wuo=main["parent"])

    group = pm.group(em=1, n=n+"AimZero", p=control_group)
    group.setMatrix(offset.getMatrix(ws=1), ws=1)
    con = control.control_create(p=group, s="locator", c=13, r=radius * 5, l=["sx", "sy", "sz", "v", "rx", "ry", "rz"],
                                 n=n+"AimControl")
    con.t.connect(aim.t)

    sdk_group = pm.group(em=1, p=main["con"], n=n+"SdkZero")
    sdk_group.tz.set(length*1.5)
    con = control.control_create(p=sdk_group, s="circle", c=14, r=radius, l=["sx", "sy", "sz", "v", "rx", "ry", "tz"],
                                 n=n+"SdkControl")
    sdk_group.sx.set(sx)

    unit = pm.createNode("unitConversion", n=n+"RxUnit")
    unit.conversionFactor.set(-1/length)
    unit.output.connect(sdk.rx)
    con.ty.connect(unit.input)

    unit = pm.createNode("unitConversion", n=n+"RyUnit")
    unit.conversionFactor.set(1/length*sx)
    unit.output.connect(sdk.ry)
    con.tx.connect(unit.input)

    unit = pm.createNode("unitConversion", n=n+"RzUnit")
    unit.conversionFactor.set(sx)
    unit.output.connect(parent.rz)
    con.rz.connect(unit.input)
    return locals()


def eye_aims(r_main, l_main, radius, connect_group, control_group, **kwargs):
    kwargs.update(**locals())
    r_aim = eye_aim(main=r_main, rl="Rt", sx=1, **kwargs)
    l_aim = eye_aim(main=l_main, rl="Lf", sx=-1, **kwargs)

    group = pm.group(em=1, n="EyeAimGroup", p=control_group)
    con = control.control_create(p=group, s="locator", c=13, r=radius * 10, l=["sx", "sy", "sz", "v", "rx", "ry", "rz"],
                                 n="EyeAimControl")
    pm.delete(pm.pointConstraint(r_aim["group"], l_aim["group"], group))
    r_aim["group"].setParent(con)
    l_aim["group"].setParent(con)
    r_aim["group"].r.set(0, 0, 0)
    l_aim["group"].r.set(0, 0, 0)

    offset = pm.group(em=1, p=connect_group, n="EyeOffset")
    group.t.connect(offset.t)
    group.r.connect(offset.r)
    aim = pm.group(em=1, p=offset, n="EyeAim")
    con.t.connect(aim.t)
    r_aim["offset"].setParent(aim)
    l_aim["offset"].setParent(aim)
    r_aim["offset"].r.set(0, 0, 0)
    l_aim["offset"].r.set(0, 0, 0)

    follow = pm.group(em=1, n="EyeFollow", p=control_group)
    static = pm.group(em=1, n="EyeStatic", p=control_group)
    follow.setMatrix(group.getMatrix(ws=1), ws=1)
    static.setMatrix(group.getMatrix(ws=1), ws=1)
    constraint = pm.parentConstraint(follow, static, group)
    w1, w2 = pm.parentConstraint(constraint, q=1, wal=1)
    con.addAttr("follow", max=0, min=1, at="double", k=1, dv=1)
    con.follow.connect(w1)
    pm.setDrivenKeyframe(w2, cd=con.follow, dv=1, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(w2, cd=con.follow, dv=0, v=1, itt="linear", ott="linear")
    return r_aim, l_aim


def eye_follow(parent, skin):
    n = skin["aim"].name().replace("Aim", "")
    follow = pm.group(em=1, p=skin["aim"].getParent(), n=skin["con"].name().replace("Control", "EyeFollow"))
    follow.setMatrix(skin["aim"].getMatrix(ws=1), ws=1)
    skin["con"].addAttr("eyeFollow", max=0, min=1, at="double", k=1, dv=0.3)
    pm.parentConstraint(parent, follow, skipRotate=["x", "y", "z"], mo=1)
    follow.ty.connect(skin["ty"].input[2])
    skin["con"].eyeFollow.connect(skin["ty"].weight[2])

    tx = pm.createNode("blendWeighted", n=n+"TxBlendWeighted")
    skin["con"].tx.connect(tx.input[0])
    follow.tx.connect(tx.input[1])
    tx.weight[0].set(1)
    skin["con"].eyeFollow.connect(tx.weight[1])
    tx.output.connect(skin["aim"].tx, f=1)


def eye_rig(**kwargs):
    err = False
    SelectionLidMainUpCurve, err = actions.find_node_by_name("SelectionLidMainUpCurve", err)
    SelectionLidMainDnCurve, err = actions.find_node_by_name("SelectionLidMainDnCurve", err)
    SelectionLidOuterUpCurve, err = actions.find_node_by_name("SelectionLidOuterUpCurve", err)
    SelectionLidOuterDnCurve, err = actions.find_node_by_name("SelectionLidOuterDnCurve", err)
    SelectionEyeRoll, err = actions.find_node_by_name("SelectionEyeRoll", err)
    SelectionEyeJoint, err = actions.find_node_by_name("SelectionEyeJoint", err)
    if err:
        return
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|EyeJointGroup", init=True)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup|EyeConnectGroup", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|EyeControlGroup", init=True)
    radius = SelectionLidMainUpCurve.getShape().length()/20
    length = (SelectionEyeRoll.getTranslation(space="world")-SelectionEyeJoint.getTranslation(space="world")).length()

    r_main = main_con(rl="Rt", s=1, **locals())
    l_main = main_con(rl="Lf", s=-1, **locals())

    r_aim, l_aim = eye_aims(**locals())

    r_skins, l_skins = eyelid(**locals())

    l_border = eye_border(main=l_main, rl="Lf", sx=-1, skins=l_skins, **locals())
    r_border = eye_border(main=r_main, rl="Rt", sx=1, skins=r_skins,  **locals())

    eye_follow(r_aim["parent"], r_skins[2])
    eye_follow(r_aim["parent"], r_skins[3])
    eye_follow(l_aim["parent"], l_skins[2])
    eye_follow(l_aim["parent"], l_skins[3])
