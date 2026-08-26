"""Maya 2025 offscreen Chinese UI validation for Skin Mirror."""

from __future__ import annotations

import pathlib
import sys
import maya.standalone
from PySide6 import QtGui, QtWidgets

app = QtWidgets.QApplication.instance() or QtWidgets.QApplication(sys.argv)
QtGui.QFontDatabase.addApplicationFont("C:/Windows/Fonts/msyh.ttc")
maya.standalone.initialize(name="python")
window = None
try:
    import maya.cmds as cmds
    sys.path.insert(0, str(pathlib.Path(__file__).resolve().parents[2]))
    from MayaCraft.ui.main_window import MayaCraftMainWindow

    character = cmds.createNode("transform", name="skinHero:CHARACTER")
    cmds.select(clear=True)
    root_joint = cmds.joint(name="skinHero:root_JNT", position=(0, 0, 0))
    cmds.select(clear=True)
    left = cmds.joint(name="skinHero:L_arm_JNT", position=(2, 4, 0))
    cmds.select(clear=True)
    right = cmds.joint(name="skinHero:R_arm_JNT", position=(-2, 4, 0))
    cmds.parent((root_joint, left, right), character)
    mesh = cmds.polyCreateFacet(
        name="skinHero:body_GEO",
        point=((1, 0, 0), (1, 1, 0), (-1, 1, 0), (-1, 0, 0)),
        constructionHistory=False,
    )[0]
    cmds.parent(mesh, character)
    skin = cmds.skinCluster((root_joint, left, right), mesh, toSelectedBones=True, normalizeWeights=1)[0]
    influence_order = cmds.skinCluster(skin, query=True, influence=True)

    def set_row(index, root_w, left_w, right_w):
        values = dict(zip((root_joint, left, right), (root_w, left_w, right_w)))
        cmds.skinPercent(
            skin, f"{mesh}.vtx[{index}]",
            transformValue=tuple((item, values[item]) for item in influence_order), normalize=False,
        )

    set_row(0, 0.1, 0.9, 0.0)
    set_row(1, 0.2, 0.7, 0.1)
    set_row(2, 0.7, 0.2, 0.1)
    set_row(3, 0.6, 0.2, 0.2)
    cmds.select(mesh)

    window = MayaCraftMainWindow()
    window.resize(1040, 760)
    window.show()
    window.show_deformation()
    window.deformation_workspace.scan()
    window.deformation_workspace.preview_mirror()
    app.processEvents()
    workspace = window.deformation_workspace
    assert workspace._mirror_plan.can_apply, workspace._mirror_plan.blockers
    assert "零写入" in workspace.mirror_status.text()
    artifacts = pathlib.Path(__file__).with_name("artifacts")
    artifacts.mkdir(exist_ok=True)
    preview = artifacts / "mayacraft_skin_mirror_preview_cn.png"
    assert window.grab().save(str(preview))
    workspace.apply_mirror()
    app.processEvents()
    assert workspace._mirror_receipt and workspace._mirror_receipt.verified
    assert "验证通过" in workspace.mirror_status.text()
    verified = artifacts / "mayacraft_skin_mirror_verified_cn.png"
    assert window.grab().save(str(verified))
    workspace.undo_mirror()
    assert "撤销验证通过" in workspace.mirror_status.text()
    print("MAYACRAFT_SKIN_MIRROR_UI_CN_OK", preview, verified)
finally:
    if window is not None:
        window.shutdown()
        window.close()
    maya.standalone.uninitialize()
