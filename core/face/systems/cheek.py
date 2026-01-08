import pymel.core as pm
from core.face.utils import actions
from core.face.utils import control


def puffer_rig(rl, oi):
    JawUp, err = actions.find_node_by_name("JawUp", False)
    JawParent, err = actions.find_node_by_name("JawParent", err)
    SelectionPufferJoint, err = actions.find_node_by_name("SelectionPufferJoint", err)
    if err:
        return
    control_group = actions.create_group("|FaceGroup|FaceControlGroup", init=False)
    joint_group = actions.create_joint("|FaceGroup|FaceJoint", init=False)
    radius = abs(SelectionPufferJoint.tx.get()/20)
    follow = actions.create_group("|FaceGroup|FaceConnectGroup|PufferFollow", True)
    pm.parentConstraint(JawUp, JawParent, follow)
    temp_scale = pm.group(em=1, p=follow)

    for rl, sx in [["Rt", 1], ["Lf", -1]]:
        temp_scale.sx.set(1)
        n = "Puffer{rl}".format(rl=rl)
        offset = pm.group(em=1, p=temp_scale, n=n+"Offset")
        offset.setMatrix(SelectionPufferJoint.getMatrix(ws=1), ws=1)
        temp_scale.sx.set(sx)
        offset.setParent(follow)
        parent = pm.group(em=1, p=offset, n=n+"Parent")
        joint = pm.joint(joint_group, radius=radius, n=n+"Joint")

        second, con = actions.create_second_control(p=control_group, n=n, t=True, r=True)

        control.control_create(con, n=n + "Control", s="ball", c=17, r=radius, l=["sz", "sy", "sx", "v"])
        second.setMatrix(offset.getMatrix(ws=1), ws=1)
        con.t.connect(parent.t)
        con.r.connect(parent.r)
        joint.r.connect(second.r)

        joint.setMatrix(offset.getMatrix(ws=1), ws=1)
        pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)

    pm.delete(temp_scale)


def check_border_follow(n, joint):
    con, err = actions.find_node_by_name(n + "Control", False)
    aim, err = actions.find_node_by_name(n + "Aim", err)
    if err:
        return
    follow = pm.group(em=1, p=aim.getParent(), n=n+"CheckFollow")
    pm.pointConstraint(joint, follow, mo=1)
    pm.transformLimits(follow, ty=(0, 0), ety=(0, 1))
    con.addAttr("follow", max=0, min=1, at="double", k=1, dv=0.4)
    blend = pm.createNode("blendWeighted", n="BrowMdTxBlendWeighted")
    con.ty.connect(blend.input[0])
    follow.ty.connect(blend.input[1])
    blend.weight[0].set(1)
    con.follow.connect(blend.weight[1])
    blend.output.connect(aim.ty, f=1)


def check_lip_follow(n, joint):
    print (n)
    con, err = actions.find_node_by_name(n + "Control", False)
    aim, err = actions.find_node_by_name(n + "Aim", err)
    blend, err = actions.find_node_by_name(n.replace("Dn", "Up") + "TyBlendWeighted", err)
    # temp edit name err
    print (blend)
    if err:
        return
    follow = pm.group(em=1, p=aim.getParent(), n=n+"CheckFollow")
    pm.pointConstraint(joint, follow, mo=1)
    pm.transformLimits(follow, ty=(0, 0), ety=(0, 1))
    con.addAttr("follow", max=0, min=1, at="double", k=1, dv=0.35)
    follow.ty.connect(blend.input[3])
    con.follow.connect(blend.weight[3])


def check(rl, omi, sx, connect_group, joint_group, control_group, radius, **kwargs):
    check_joint = kwargs["SelectionCheek{omi}Joint".format(omi=omi)]
    n = "Check{rl}{omi}".format(rl=rl, omi=omi)
    temp_scale = pm.group(em=1)
    offset = pm.group(em=1, p=temp_scale, n=n + "Offset")
    offset.setMatrix(check_joint.getMatrix(ws=1), ws=1)
    temp_scale.sx.set(sx)
    offset.setParent(connect_group)
    parent = pm.group(em=1, p=offset, n=n + "Parent")
    joint = pm.joint(joint_group, radius=radius, n=n + "Joint")
    second, con = actions.create_second_control(p=control_group, n=n, t=True, r=False)
    control.control_create(con, n=n + "Control", s="ball", c=17, r=radius, l=["sz", "sy", "sx", "v"])
    second.setMatrix(offset.getMatrix(ws=1), ws=1)
    con.t.connect(parent.t)
    con.r.connect(parent.r)
    joint.setMatrix(offset.getMatrix(ws=1), ws=1)
    pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)
    pm.delete(temp_scale)
    if omi != "Md":
        return
    control.control_create(con, c=13)
    bulge_joint = kwargs["Bulge{rl}03Joint".format(rl=rl)]
    follow = pm.group(em=1, p=offset)
    parent.setParent(follow)
    pm.transformLimits(follow, ty=(0, 0), ety=(1, 0))

    blend = pm.createNode("blendWeighted", n="BrowMdTxBlendWeighted")
    blend.input[0].set(-bulge_joint.ty.get())
    bulge_joint.ty.connect(blend.input[1])

    con.addAttr("follow", max=0, min=1, at="double", k=1, dv=0.5)
    con.follow.connect(blend.weight[0])
    con.follow.connect(blend.weight[1])
    blend.output.connect(follow.ty)
    check_border_follow(n="EyeBorder{rl}Dn".format(rl=rl), joint=joint)
    check_lip_follow(n="Eyelid{rl}DnMd".format(rl=rl), joint=joint)
    # for omi, dv in zip(["Ot", "", "In"], [0.2, 0.4, 0.2]):
    #     check_follow(n="EyeBorder{rl}{omi}Dn".format(rl=rl, omi=omi), joint=joint, dv=dv)
    # check_follow(n="Eyelid{rl}Dn".format(rl=rl), joint=joint, dv=0.3)


def check_rig():
    SelectionCheekOtJoint, err = actions.find_node_by_name("SelectionCheekOtJoint", False)
    SelectionCheekMdJoint, err = actions.find_node_by_name("SelectionCheekMdJoint", err)
    SelectionCheekInJoint, err = actions.find_node_by_name("SelectionCheekInJoint", err)
    BulgeRt03Joint, err = actions.find_node_by_name("BulgeRt03Joint", err)
    BulgeLf03Joint, err = actions.find_node_by_name("BulgeLf03Joint", err)
    if err:
        return
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|CheekJointGroup", init=True)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup|CheekConnectGroup", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|CheekControlGroup", init=True)
    radius = (SelectionCheekOtJoint.t.get() - SelectionCheekInJoint.t.get()).length()/30
    for rl, sx in [["Rt", 1], ["Lf", -1]]:
        for omi in ["Ot", "Md", "In"]:
            check(**locals())


