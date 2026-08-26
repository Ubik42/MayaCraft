import pymel.core as pm
from MayaCraft.core.face.utils import actions
from MayaCraft.core.face.utils import weights
from MayaCraft.core.face.utils import control


def bulge_surface(follicles, radius, connect_group, **kwargs):
    curves = []
    temp = pm.group(em=1)
    for i, follicle in enumerate(follicles):
        curve = pm.curve(d=1, p=[[0, 0, -radius/2], [0, 0, radius/2]], n="lipSecondary%02dCUR" % i)
        curve.setMatrix(follicle.getMatrix(ws=1), ws=1)
        curves.append(curve)
        curve.setParent(temp)
    surfaces = []
    for rl, sx in [["Rt", 1], ["Lf", -1]]:
        temp.sx.set(sx)
        surface = pm.loft(curves, ch=0, d=3, ss=1, c=0, u=1)[0]
        surface = pm.reverseSurface(surface, d=3, ch=0, rpo=1)[0]
        surface.setParent(connect_group)
        surface.rename("Bulge{rl}Surface".format(rl=rl))
        surface.v.set(0)
        surface.inheritsTransform.set(0)
        surfaces.append(surface)
    pm.delete(temp)
    return surfaces


def bulge_polygon(connect_group, surfaces, radius, FaceJoint, JawJoint, **kwargs):
    transforms = [actions.make_follicle(g=s, u=0.5, v=0.25 * i, t=1, r=1) for s in surfaces for i in range(1, 4)]
    polygon = actions.create_plane(n="BulgePolygon", p=connect_group, radius=radius, transforms=transforms)
    pm.delete(transforms)
    skin_cluster = pm.skinCluster([FaceJoint, JawJoint], polygon, n="BulgeSK", tsb=1)
    weights.load_weight(skin_cluster, "BulgePolygon")
    return polygon


def bulge_skins(polygon, connect_group, control_group, radius, surfaces, LipUp01Attach, LipDn01Attach, LipUp07Attach,
                LipDn07Attach, JawJoint, NoseRtBulgeJoint, NoseLfBulgeJoint, **kwargs):

    group = pm.group(em=1, p=connect_group, n="BulgeAttachGroup")
    skins = []
    # ws = [[0, 0.5, 1], [0.5, 1, 0.5], [1, 0.5, 0]]

    for i, rl, s, p in([0, "Rt", 1, [LipUp01Attach, LipDn01Attach]],
                       [1, "Lf", -1, [LipUp07Attach, LipDn07Attach]]):
        for j, ety, w, in [[0, (0, 1), [1, 0.5, 0]],
                           [1, (1, 1), [0.5, 1, 0.5]],
                           [2, (1, 0), [0, 0.5, 1]]]:
            n = "Bulge{rl}{i:0>2}".format(i=j+1, rl=rl)
            attach = actions.create_attach(p=group, n=n + "Attach", i=i * 3 + j, plane=polygon)

            follow = pm.group(em=1, p=attach, n=n+"Follow")
            sdk = pm.group(em=1, p=attach, n=n+"sdk")
            volume = pm.group(em=1, p=sdk, n=n+"Volume")
            skin = pm.joint(volume, n=n+"Skin", radius=radius)
            second, con = actions.create_second_control(n=n, p=control_group, t=1, r=0)

            second.sz.set(s)
            attach.sz.set(s)
            pm.scaleConstraint(group, attach, mo=1)
            pm.transformLimits(sdk, ty=(0, 0), ety=ety, tx=(0, 0), etx=(1, 0))
            constraint = pm.pointConstraint(p, follow, mo=1)
            color = pm.createNode("blendColors", n=n+"Color")
            follow.t.connect(color.color1)
            color.color2.set(0, 0, 0)
            color.output.connect(sdk.t)
            follow_mul = pm.createNode("combinationShape", n=n+"FollowMultiply")
            follow_mul.outputWeight.connect(color.blender)
            pm.setDrivenKeyframe(follow_mul.inputWeight[0], cd=follow.tx, dv=0, v=0, itt="linear", ott="linear")
            pm.setDrivenKeyframe(follow_mul.inputWeight[0], cd=follow.tx, dv=constraint.offsetX.get()*0.8, v=1,
                                 itt="linear", ott="linear")
            for v, dv in zip(w, [-1, 0, 1]):
                pm.setDrivenKeyframe(follow_mul.inputWeight[1], cd=follow.ty, dv=radius*dv*15, v=v, itt="linear",
                                     ott="linear")
            con.addAttr("follow", max=0, min=1, at="double", k=1, dv=0.8)
            con.follow.connect(follow_mul.inputWeight[2])

            distance = pm.createNode("distanceBetween", n=n+"Distance")
            sdk.translateX.connect(distance.point1X)
            sdk.translateY.connect(distance.point1Y)
            volume_mul = pm.createNode("multiplyDivide", n=n+"VolumeMultiply")
            distance.distance.connect(volume_mul.input1X)
            con.addAttr("volume", max=0, min=1, at="double", k=1, dv=0.4)
            con.volume.connect(volume_mul.input2X)
            volume_mul.outputX.connect(volume.tz)

            second.setMatrix(attach.getMatrix(), ws=1)
            control.control_create(con, s="ball", c=17, o=[0, 0, radius], r=radius,
                                   l=["sx", "sy", "sz", "rx", "ry", "rz", "v"])

            skin.v.set(0)
            skins.append(skin)
            pm.orientConstraint(attach, second)
            # attach.r.connect(second.r)
            con.t.connect(skin.t)

    for surface in surfaces:
        sk = pm.skinCluster(skins, JawJoint, NoseRtBulgeJoint, NoseLfBulgeJoint, surface, tsb=1, mi=1,
                            n=surface.name().replace("Surface", "SK"))
        weights.load_weight(sk, n=surface.name())


def bulge_joint(surface, joint_group, radius, connect_group, rl, **kwargs):
    group = actions.create_group("|FaceGroup|FaceConnectGroup|BulgeConnectGroup|BulgeFollicleGroup", init=False)
    for i in range(1, 9, 1):
        n = "Bulge{rl}{i:0>2}".format(rl=rl, i=i + 1)
        follicle = actions.make_follicle(g=surface, p=group, u=0.5, t=1, v=1.0 / 8 * i, r=1, n=n + "Follicle")
        # follicle.outRotate.disconnect(follicle.rotate)
        # follicle.outRotateY.connect(follicle.rotateY)
        # follicle.outRotateZ.connect(follicle.rotateZ)
        joint = pm.joint(joint_group, n=n + "Joint")
        joint.radius.set(radius)
        pm.parent(pm.pointConstraint(follicle, joint), follicle)


def puffer_volume(rl="Rt"):
    con, err = actions.find_node_by_name("Puffer{rl}Control".format(rl=rl), False)
    parent, err = actions.find_node_by_name("Puffer{rl}Parent".format(rl=rl), False)
    distance, err = actions.find_node_by_name("Bulge{rl}02Distance".format(rl=rl), False)
    if err:
        return
    volume = pm.group(em=1, p=parent.getParent(), n="Puffer{rl}Volume".format(rl=rl))
    parent.setParent(volume)
    volume_mul = pm.createNode("multiplyDivide", n="Puffer{rl}VolumeMultiply".format(rl=rl))
    distance.distance.connect(volume_mul.input1X)
    con.addAttr("volume", max=0, min=1, at="double", k=1, dv=0.2)
    con.volume.connect(volume_mul.input2X)
    volume_mul.outputX.connect(volume.tz)


def bulge_rig(**kwargs):
    err = False
    follicles = []
    for i in range(5):
        follicle, err = actions.find_node_by_name("SelectionBulge%02dFollicle" % (i + 1), err)
        follicles.append(follicle)
    FaceJoint, err = actions.find_node_by_name("FaceJoint", err)
    JawJoint, err = actions.find_node_by_name("JawJoint", err)
    NoseRtBulgeJoint, err = actions.find_node_by_name("NoseRtBulgeJoint", err)
    NoseLfBulgeJoint, err = actions.find_node_by_name("NoseLfBulgeJoint", err)
    LipUp01Attach, err = actions.find_node_by_name("LipUp01Attach", err)
    LipDn01Attach, err = actions.find_node_by_name("LipDn01Attach", err)
    LipUp07Attach, err = actions.find_node_by_name("LipUp07Attach", err)
    LipDn07Attach, err = actions.find_node_by_name("LipDn07Attach", err)
    if err:
        return
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|BulgeJointGroup", init=True)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup|BulgeConnectGroup", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|BulgeControlGroup", init=True)
    radius = (follicles[0].ty.get()-follicles[-1].ty.get())/40
    surfaces = bulge_surface(**locals())
    polygon = bulge_polygon(**locals())
    bulge_skins(**locals())
    bulge_joint(surface=surfaces[0], rl="Rt", **locals())
    bulge_joint(surface=surfaces[1], rl="Lf", **locals())

    puffer_volume(rl="Rt")
    puffer_volume(rl="Lf")































