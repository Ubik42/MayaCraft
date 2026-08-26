import pymel.core as pm
from MayaCraft.core.face.utils import actions
from MayaCraft.core.face.utils import control


def nose_con(point, f, roll, joint_group, radius, control_group, **kwargs):
    offset = pm.group(em=1, p=roll, n="Nose{field}Offset".format(field=f))
    offset.setTranslation(point, space="world")
    sdk = pm.group(em=1, p=offset, n="Nose{field}Sdk".format(field=f))
    parent = pm.group(em=1, p=sdk, n="Nose{field}Parent".format(field=f))
    joint = pm.joint(joint_group, n="Nose{field}Joint".format(field=f), radius=radius)
    pm.parent(pm.parentConstraint(parent, joint), parent)
    second, con = actions.create_second_control(n="Nose{field}".format(field=f), p=control_group, r=1, t=1)
    control.control_create(con, s="ball", c=17, r=radius, l=["v"])
    second.setMatrix(joint.getMatrix(ws=1), ws=1)
    joint.r.connect(second.r)

    con.t.connect(parent.t)
    con.r.connect(parent.r)
    con.s.connect(joint.s)
    return locals()


def nose_rig(**kwargs):
    err = False
    SelectionNoseRoll, err = actions.find_node_by_name("SelectionNoseRoll", err)
    SelectionNoseJoint, err = actions.find_node_by_name("SelectionNoseJoint", err)
    SelectionNoseCurve, err = actions.find_node_by_name("SelectionNoseCurve", err)
    SelectionBulge01Follicle, err = actions.find_node_by_name("SelectionBulge01Follicle", err)
    SelectionNoseUpJoint, err = actions.find_node_by_name("SelectionNoseUpJoint", err)
    LipUp01Attach, err = actions.find_node_by_name("LipUp01Attach", err)
    LipUp04Attach, err = actions.find_node_by_name("LipUp04Attach", err)
    LipUp07Attach, err = actions.find_node_by_name("LipUp07Attach", err)
    if err:
        return
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|NoseJointGroup", init=True)
    offset = actions.create_group("|FaceGroup|FaceConnectGroup|NoseOffset", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|NoseControlGroup", init=True)

    radius = (SelectionNoseJoint.getTranslation(space="world") -
              SelectionNoseRoll.getTranslation(space="world")).length()/20

    offset.setTranslation(SelectionNoseRoll.getTranslation(space="world"), space="world")
    offset.tx.set(0)
    pm.delete(pm.aimConstraint(SelectionNoseJoint, offset, wut="scene", aim=[0, -1, 0], skip=("y", "z")))

    roll = pm.group(em=1, p=offset, n="NoseRoll")
    # pm.parentConstraint()

    points = actions.get_points_by_curve(SelectionNoseCurve, 5)
    for i in range(len(points) / 2):
        points[-i - 1][0] = -points[i][0]
        points[-i - 1][1] = points[i][1]
        points[-i - 1][2] = points[i][2]
    points[2][0] = 0
    points.append(SelectionNoseJoint.getTranslation(space="world"))
    points[-1][0] = 0

    points.append(SelectionBulge01Follicle.getTranslation(space="world"))
    points.append(pm.datatypes.Point(-points[-1][0], points[-1][1], points[-1][2]))

    points.append(SelectionNoseUpJoint.getTranslation(space="world"))
    points[-1][0] = 0
    results = []

    for point, f in zip(points, ["Rt", "RtMd", "Md", "LfMd", "Lf", "Dn", "RtBulge", "LfBulge", "Up"]):
        results.append(nose_con(**locals()))

    nose_main_group = pm.group(em=1, p=control_group, n="NoseMainGroup")
    nose_main_group.setMatrix(results[2]["joint"].getMatrix(ws=1), ws=1)
    main_con = control.control_create(p=nose_main_group, r=radius * 5, o=[0, 0, radius * 3], n="NoseMainControl",
                                      s="nose", c=13, l=["tz", "sx", "sy", "sz", "rx", "ry", "rz", "v"])

    main_con.addAttr("follow", max=0, min=1, at="double", k=1, dv=0.4)
    md_follow = pm.group(em=1, p=offset, n="NoseMdFollow")
    pm.transformLimits(md_follow, ty=(0, 0), ety=(1, 0))
    pm.pointConstraint(LipUp04Attach, md_follow, mo=1)
    blend = pm.createNode("blendWeighted", n="NoseMainTyBlendWeight")
    main_con.ty.connect(blend.input[0])
    md_follow.ty.connect(blend.input[1])
    blend.weight[0].set(1)
    main_con.follow.connect(blend.weight[1])
    multiply = pm.createNode("multiplyDivide", n="NoseMainTyMultiply")
    blend.output.connect(multiply.input1X)
    blend.output.connect(multiply.input1Y)
    multiply.input2X.set(0.6)
    multiply.input2Y.set(0.4)
    multiply.outputX.connect(roll.ty)

    blend = pm.createNode("blendWeighted", n="NoseMainTxBlendWeight")
    main_con.tx.connect(blend.input[0])
    md_follow.tx.connect(blend.input[1])
    blend.weight[0].set(1)
    main_con.follow.connect(blend.weight[1])
    unit = pm.createNode("unitConversion", n="NoseMainRzUnit")
    unit.conversionFactor.set(1/(radius*20))
    blend.output.connect(unit.input)
    unit.output.connect(roll.rz)

    multiply.outputY.connect(results[5]["sdk"].ty)
    pm.transformLimits(results[5]["sdk"], ty=(0, 0), ety=(1, 0))

    follow = pm.group(em=1, p=md_follow, n="NoseRtFollow")
    pm.transformLimits(follow, ty=(0, 0), ety=(1, 0), tx=(0, 0), etx=(0, 1), etz=(1, 1), tz=(0, 0))
    pm.pointConstraint(LipUp01Attach, follow, mo=1)
    results[0]["con"].addAttr("follow", max=0, min=1, at="double", k=1, dv=0.2)
    color = pm.createNode("blendColors", n="NoseRtFollowBlendColors")
    follow.t.connect(color.color1)
    color.color2.set(0, 0, 0)
    color.outputR.connect(results[0]["sdk"].tx)
    results[0]["con"].follow.connect(color.blender)
    plus = pm.createNode("plusMinusAverage", n="NoseRtTyPlus")
    color.outputG.connect(plus.input1D[0])
    multiply.outputY.connect(plus.input1D[1])
    plus.output1D.connect(results[0]["sdk"].ty)

    follow = pm.group(em=1, p=md_follow, n="NoseLfFollow")
    pm.transformLimits(follow, ty=(0, 0), ety=(1, 0), tx=(0, 0), etx=(1, 0), etz=(1, 1), tz=(0, 0))
    pm.pointConstraint(LipUp07Attach, follow, mo=1)
    results[4]["con"].addAttr("follow", max=0, min=1, at="double", k=1, dv=0.2)
    color = pm.createNode("blendColors", n="NoseRtFollowBlendColors")
    follow.t.connect(color.color1)
    color.color2.set(0, 0, 0)
    color.outputR.connect(results[4]["sdk"].tx)
    results[4]["con"].follow.connect(color.blender)
    plus = pm.createNode("plusMinusAverage", n="NoseLfTyPlus")
    color.outputG.connect(plus.input1D[0])
    multiply.outputY.connect(plus.input1D[1])
    plus.output1D.connect(results[4]["sdk"].ty)

    pm.pointConstraint(results[0]["parent"], results[2]["parent"], results[1]["sdk"], mo=1)
    pm.pointConstraint(results[4]["parent"], results[2]["parent"], results[3]["sdk"], mo=1)

    results[6]["con"].addAttr("volume", max=0, min=1, at="double", k=1, dv=0.2)
    pm.transformLimits(results[6]["sdk"], tz=(0, 0), etz=(1, 0))
    blend = pm.createNode("blendWeighted", n="NoseBulgeRtBlendWeight")
    results[0]["parent"].ty.connect(blend.input[0])
    results[0]["sdk"].ty.connect(blend.input[1])
    roll.ty.connect(blend.input[2])
    results[6]["con"].volume.connect(blend.weight[0])
    results[6]["con"].volume.connect(blend.weight[1])
    results[6]["con"].volume.connect(blend.weight[2])
    blend.output.connect(results[6]["sdk"].tz)

    results[7]["con"].addAttr("volume", max=0, min=1, at="double", k=1, dv=0.2)
    pm.transformLimits(results[7]["sdk"], tz=(0, 0), etz=(1, 0))
    blend = pm.createNode("blendWeighted", n="NoseBulgeLfBlendWeight")
    results[4]["parent"].ty.connect(blend.input[0])
    results[4]["sdk"].ty.connect(blend.input[1])
    roll.ty.connect(blend.input[2])
    results[7]["con"].volume.connect(blend.weight[0])
    results[7]["con"].volume.connect(blend.weight[1])
    results[7]["con"].volume.connect(blend.weight[2])
    blend.output.connect(results[7]["sdk"].tz)

    results[8]["con"].addAttr("volume", max=0, min=1, at="double", k=1, dv=0.2)
    pm.transformLimits(results[8]["sdk"], tz=(0, 0), etz=(1, 0))
    blend = pm.createNode("blendWeighted", n="NoseBulgeMdBlendWeight")
    roll.ty.connect(blend.input[0])
    results[8]["con"].volume.connect(blend.weight[0])
    blend.output.connect(results[8]["sdk"].tz)


















