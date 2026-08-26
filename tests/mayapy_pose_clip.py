"""Maya 2025 validation for versioned Pose/Clip capture without timeline mutation."""

from __future__ import annotations

import pathlib
import sys

import maya.standalone


package_parent = pathlib.Path(__file__).resolve().parents[2]
sys.path.insert(0, str(package_parent))
maya.standalone.initialize(name="python")
try:
    import maya.cmds as cmds

    from MayaCraft.adapters.maya.pose_clip import MayaPoseClipCapture
    from MayaCraft.domain.pose_clip import (
        clip_asset_from_dict, clip_asset_to_dict, compare_pose_frames,
        pose_asset_from_dict, pose_asset_to_dict,
    )

    root = cmds.createNode("transform", name="hero:root_CTRL")
    hand = cmds.createNode("transform", name="hero:L_hand_CTRL", parent=root)
    cmds.addAttr(hand, longName="fingerCurl", attributeType="double", keyable=True)
    for frame, root_x, hand_y, curl, rotate_z in (
        (1, 0.0, 1.0, 0.0, 0.0),
        (3, 2.0, 3.0, 0.5, 45.0),
        (5, 5.0, 2.0, 1.0, 90.0),
    ):
        cmds.setKeyframe(root, attribute="translateX", time=frame, value=root_x)
        cmds.setKeyframe(hand, attribute="translateY", time=frame, value=hand_y)
        cmds.setKeyframe(hand, attribute="rotateZ", time=frame, value=rotate_z)
        cmds.setKeyframe(hand, attribute="fingerCurl", time=frame, value=curl)

    cmds.currentTime(3)
    cmds.select(root, hand)
    before_selection = tuple(cmds.ls(selection=True, long=True) or ())
    capture = MayaPoseClipCapture()
    pose = capture.capture_pose(label="手部中间姿态", character_id="HERO-01")
    assert pose.frame.frame == 3.0
    assert tuple(node.key for node in pose.frame.nodes) == ("root_CTRL", "L_hand_CTRL")
    hand_pose = pose.frame.node("L_hand_CTRL")
    assert hand_pose.parent_key == "root_CTRL"
    assert abs(dict(hand_pose.custom_channels)["fingerCurl"] - 0.5) < 1e-6
    assert pose_asset_from_dict(pose_asset_to_dict(pose)).fingerprint == pose.fingerprint
    assert cmds.currentTime(query=True) == 3.0
    assert tuple(cmds.ls(selection=True, long=True) or ()) == before_selection

    clip = capture.capture_clip(start=1, end=5, step=2, label="手部动作", character_id="HERO-01")
    assert tuple(frame.frame for frame in clip.frames) == (1.0, 3.0, 5.0)
    assert clip.channel_keys == ("root_CTRL", "L_hand_CTRL")
    assert clip_asset_from_dict(clip_asset_to_dict(clip)).fingerprint == clip.fingerprint
    assert abs(dict(clip.frames[-1].node("L_hand_CTRL").custom_channels)["fingerCurl"] - 1.0) < 1e-6
    difference = compare_pose_frames(clip.frames[0], clip.frames[-1])
    assert difference.maximum_world_translation > 4.9
    assert difference.maximum_world_rotation_degrees > 89.9
    assert cmds.currentTime(query=True) == 3.0
    assert tuple(cmds.ls(selection=True, long=True) or ()) == before_selection

    duplicate_a = cmds.createNode("transform", name="a:same_CTRL")
    duplicate_b = cmds.createNode("transform", name="b:same_CTRL")
    try:
        capture.capture_pose((duplicate_a, duplicate_b))
    except ValueError as exc:
        assert "节点键重复" in str(exc)
    else:
        raise AssertionError("duplicate portable keys were not blocked")

    print(
        "MAYACRAFT_POSE_CLIP_OK",
        pose.fingerprint[:12],
        len(clip.frames),
        round(difference.maximum_world_translation, 3),
        round(difference.maximum_world_rotation_degrees, 3),
    )
finally:
    maya.standalone.uninitialize()
