import pymel.core as pm

from core.face.utils import actions
from core.face.systems import bulge, brow, cheek, nose, eye, lip, jaw


def build():
    if not pm.pluginInfo("matrixNodes", q=1, l=1):
        pm.loadPlugin("matrixNodes")
    if not pm.pluginInfo("MayaMuscle", q=1, l=1):
        pm.loadPlugin("MayaMuscle")
    FaceSelectionGroup, err = actions.find_node_by_name("FaceSelectionGroup", False)
    if err:
        return
    if not FaceSelectionGroup.hasAttr("face"):
        return pm.warning("can not find head. please build brow curve")
    print (FaceSelectionGroup.face.get())
    face, err = actions.find_node_by_name(FaceSelectionGroup.face.get(), False)
    if err:
        return pm.warning("can not find head. please build brow curve")

    actions.create_group("|FaceGroup|FaceConnectGroup", init=True)
    actions.create_group("|FaceGroup|FaceControlGroup", init=True)
    actions.create_joint("|FaceGroup|FaceJoint", init=True)
    jaw.jaw_rig()
    lip.lip_rig()
    nose.nose_rig()
    bulge.bulge_rig()
    eye.eye_rig()
    cheek.check_rig()
    brow.brow_rig()
    actions.update_second(face)
