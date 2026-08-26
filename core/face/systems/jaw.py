import pymel.core as pm

from MayaCraft.core.face.utils import control
from MayaCraft.core.face.utils import actions


def tooth_rig(name, follow, radius, **kwargs):
    n = name[9:-5]
    selection, err = actions.find_node_by_name(name, False)
    follow, err = actions.find_node_by_name(follow, err)
    if err:
        return
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup")
    zero = actions.create_group("|FaceGroup|FaceControlGroup|{n}Zero".format(n=n), init=True)
    con = control.control_create(n=n + "Control", s="tooth", c=17, r=radius, l=["v"], p=zero)
    joint = actions.create_joint("|FaceGroup|FaceJoint|{n}Joint".format(n=n), init=True)
    joint.drawStyle.set(0)
    joint.radius.set(radius/4)
    zero.setMatrix(selection.getMatrix(ws=1), ws=1)
    constraint = pm.parentConstraint(follow, zero, mo=1)
    constraint.setParent(follow)
    connect_group.worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
    constraint = pm.parentConstraint(con, joint)
    constraint.setParent(follow)
    zero.getParent().worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)


def follow_rig(n, follow, matrix, s, radius):
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup")
    zero = actions.create_group("|FaceGroup|FaceControlGroup|{n}Zero".format(n=n), init=True)
    con = control.control_create(n=n + "Control", s=s, c=17, r=radius, l=["v"], p=zero)
    joint = actions.create_joint("|FaceGroup|FaceJoint|{n}Joint".format(n=n), init=True)
    joint.drawStyle.set(0)
    joint.radius.set(radius/2)
    zero.setMatrix(matrix, ws=1)
    constraint = pm.parentConstraint(follow, zero, mo=1)
    constraint.setParent(follow)
    connect_group.worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
    constraint = pm.parentConstraint(con, joint)
    constraint.setParent(follow)
    zero.getParent().worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)


def puffer_rig():
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

        control.control_create(con, n=n + "Control", s="ball", c=13, r=radius, l=["sz", "sy", "sx", "v"])
        second.setMatrix(offset.getMatrix(ws=1), ws=1)
        con.t.connect(parent.t)
        con.r.connect(parent.r)
        joint.r.connect(second.r)

        joint.setMatrix(offset.getMatrix(ws=1), ws=1)
        pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)

    pm.delete(temp_scale)


def tongue_rig():
    JawParent, err = actions.find_node_by_name("JawParent", False)
    SelectionTongueUpCurve, err = actions.find_node_by_name("SelectionTongueUpCurve", err)
    SelectionTongueDnCurve, err = actions.find_node_by_name("SelectionTongueDnCurve", err)
    if err:
        return
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup")
    up_points = actions.get_points_by_curve(SelectionTongueUpCurve, number=5)
    dn_points = actions.get_points_by_curve(SelectionTongueDnCurve, number=5)
    for points in [up_points, dn_points]:
        if points[0][2] > points[-1][2]:
            points.reverse()
    points = [(p1+p2)/2 for p1, p2 in zip(up_points, dn_points)]
    for point in points:
        point[0] = 0
    temp1 = actions.create_curve_by_points(points=points)
    temp2 = actions.rebuild_curve(temp1)
    pm.delete(temp1)
    joints = []
    radius = temp2.getShape().length()/40
    joint = actions.create_joint("|FaceGroup|FaceJoint", init=False)
    for i, point in enumerate(actions.get_points_by_curve(temp2, 10)):
        joint = pm.joint(joint, n="Tongue%02dJoint" % (i+1),  radius=radius)
        joint.setTranslation(point, space="world")
        joints.append(joint)
    pm.delete(temp2)
    pm.makeIdentity(joints, apply=True, r=True)
    pm.joint(joints[0], e=1, oj="xyz", secondaryAxisOrient="yup", ch=1, zso=1)
    joints[-1].rotate.set(0, 0, 0)
    joints[-1].jointOrient.set(0, 0, 0)
    con = actions.create_group("|FaceGroup|FaceControlGroup", init=False)
    for i, joint in enumerate(joints):
        n = "Tongue{i:0>2}".format(i=i)
        zero = pm.group(em=1, p=con, n=n+"Zero")
        zero.setMatrix(joint.getMatrix(ws=1), ws=1)
        if i == 0:
            constraint = pm.parentConstraint(JawParent, zero, mo=1)
            constraint.setParent(JawParent)
            connect_group.worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
        con = control.control_create(n=n + "Control", s="tongue", c=17, r=radius * 15, l=["sx", "sy", "sz", "v"], p=zero)
        constraint = pm.parentConstraint(con, joint)
        constraint.setParent(JawParent)
        zero.getParent().worldInverseMatrix[0].connect(constraint.constraintParentInverseMatrix, f=1)
    return joints


def jaw_rig():
    SelectionJawRoll, err = actions.find_node_by_name("SelectionJawRoll", False)
    SelectionJawJoint, err = actions.find_node_by_name("SelectionJawJoint", err)
    if err:
        return
    offset = actions.create_group("|FaceGroup|FaceConnectGroup|JawOffset", init=True)
    zero = actions.create_group("|FaceGroup|FaceControlGroup|JawZero", init=True)
    length = (SelectionJawJoint.getTranslation(space="world")-SelectionJawRoll.getTranslation(space="world")).length()
    offset.setMatrix(SelectionJawRoll.getMatrix(ws=1), ws=1)
    offset.tx.set(0)
    pm.delete(pm.aimConstraint(SelectionJawJoint, offset, wut="scene", aim=[0, 0, 1], skip=("y", "z")))
    zero.setTranslation(SelectionJawJoint.getTranslation(space="world"), space="world")
    zero.tx.set(0)
    con = control.control_create(n="JawControl", s="jaw", c=13, r=length / 5, l=["rx", "ry", "sx", "sy", "sz", "v"],
                                 o=[0, 0, length/5], p=zero)

    parent = pm.group(em=1, p=offset, n="JawParent")
    parent.rotateOrder.set(2)

    unit = pm.createNode("unitConversion", n="JawRyUnit")
    unit.conversionFactor.set(1/length)
    con.tx.connect(unit.input)
    unit.output.connect(parent.ry)
    unit = pm.createNode("unitConversion", n="JawRxUnit")
    unit.conversionFactor.set(-1/length)
    con.ty.connect(unit.input)
    unit.output.connect(parent.rx)
    con.rz.connect(parent.rz)
    con.tz.connect(parent.tz)

    jaw_up_parent = pm.group(em=1, p=offset, n="JawUp")
    jaw_up_parent.rotateOrder.set(2)
    parent.rx.connect(jaw_up_parent.rx)
    pm.transformLimits(jaw_up_parent, rx=[-45, 0], erx=[0, 1])
    unit = pm.createNode("unitConversion", n="JawHalfRyUnit")
    unit.conversionFactor.set(1/length/2)
    con.tx.connect(unit.input)
    unit.output.connect(jaw_up_parent.ry)

    jaw_twist_parent = pm.group(em=1, p=offset, n="JawTwist")
    jaw_twist_parent.rotateOrder.set(2)
    unit.output.connect(jaw_twist_parent.ry)

    joint = actions.create_joint("|FaceGroup|FaceJoint|JawJoint", init=True)
    joint.drawStyle.set(0)
    joint.radius.set(length/20)
    pm.parent(pm.parentConstraint(parent, joint), parent)

    tooth_rig(name="SelectionTeethDnJoint", follow="JawParent", radius=length/5, **locals())
    tooth_rig(name="SelectionTeethUpJoint", follow="JawUp", radius=length/5, **locals())
    tongue_rig()
    puffer_rig()
