import maya.cmds as cmds
from typing import List, Union, Tuple, Optional


def set_draw(
        target_nodes: Union[str, List[str]],
        enable_overrides: Optional[bool] = None,
        display_type: Optional[int] = None,
        visible: Optional[bool] = None,
        color: Optional[Union[int, Tuple[float, float, float]]] = None
) -> None:
    """Applies drawing override settings to the specified nodes.

    This function modifies the drawing override attributes on the shape node(s)
    of the given transform nodes.

    Args:
        target_nodes: A single node name or a list of node names to modify.
        enable_overrides: If True, enables drawing overrides. If False,
            disables them.
        display_type: Sets the display mode.
            0: Normal
            1: Template
            2: Reference
        visible: Sets the visibility of the transform node.
        color: Sets the override color. Can be an integer index (0-31)
            or an RGB tuple with values from 0.0 to 1.0, e.g., (1.0, 0.0, 0.0)
            for red.

    Example:
        # Create a sphere
        my_sphere = cmds.polySphere(name="testSphere")[0]

        # Set it to be a red reference object
        set_drawing(
            my_sphere,
            enable_overrides=True,
            display_type=2,
            color=(1.0, 0.0, 0.0)
        )

        # Change its color using an index (e.g., 13 is red in default palette)
        set_drawing(my_sphere, color=13)

        # Turn off overrides
        set_drawing(my_sphere, enable_overrides=False)
    """
    if isinstance(target_nodes, str):
        nodes = [target_nodes]
    else:
        nodes = target_nodes

    if not nodes:
        cmds.warning("No target nodes specified.")
        return

    for node in nodes:
        if not cmds.objExists(node):
            cmds.warning(f"Node '{node}' does not exist. Skipping.")
            continue

        # Visibility is an attribute of the transform node itself
        if visible is not None:
            cmds.setAttr(f"{node}.visibility", visible)

        # Drawing overrides are on the shape node
        shape_nodes = cmds.listRelatives(node, shapes=True, fullPath=True) or []
        if not shape_nodes:
            # Some nodes like locators are their own shape, check that.
            if cmds.nodeType(node) in ['locator', 'camera']:
                shape_nodes = [node]
            else:
                print(f"Node '{node}' has no shape nodes to apply overrides. Skipping shape attributes.")
                continue

        for shape in shape_nodes:
            if enable_overrides is not None:
                cmds.setAttr(f"{shape}.overrideEnabled", enable_overrides)

            if display_type is not None:
                cmds.setAttr(f"{shape}.overrideDisplayType", display_type)

            if color is not None:
                if isinstance(color, int):
                    # Use color index
                    cmds.setAttr(f"{shape}.overrideRGBColors", 0)
                    cmds.setAttr(f"{shape}.overrideColor", color)
                elif isinstance(color, (list, tuple)) and len(color) == 3:
                    # Use RGB color
                    cmds.setAttr(f"{shape}.overrideRGBColors", 1)
                    cmds.setAttr(f"{shape}.overrideColorRGB", *color)
                else:
                    cmds.warning(f"Invalid color format for '{node}'. Use an int or a 3-value tuple/list.")


def unlock_transform(
        target_nodes: Union[str, List[str]],
        translate: bool = True,
        rotate: bool = True,
        scale: bool = True,
        visibility: bool = True,
        keyable: bool = True
) -> None:
    """
    解锁指定节点的变换属性 (T/R/S/V)。

    Args:
        target_nodes: 节点名称或列表。
        translate: 是否解锁位移 (tx, ty, tz)。
        rotate: 是否解锁旋转 (rx, ry, rz)。
        scale: 是否解锁缩放 (sx, sy, sz)。
        visibility: 是否解锁可见性 (v)。
        keyable: 解锁后是否同时设为 Keyable (在通道栏显示)。默认为 True。
    """
    if isinstance(target_nodes, str):
        target_nodes = [target_nodes]

    # 构建需要处理的属性列表
    attrs_to_process = []
    if translate:
        attrs_to_process.extend(['tx', 'ty', 'tz'])
    if rotate:
        attrs_to_process.extend(['rx', 'ry', 'rz'])
    if scale:
        attrs_to_process.extend(['sx', 'sy', 'sz'])
    if visibility:
        attrs_to_process.append('v')

    for node in target_nodes:
        if not cmds.objExists(node):
            continue

        for attr in attrs_to_process:
            full_attr = f"{node}.{attr}"
            try:
                # 1. 解锁
                cmds.setAttr(full_attr, lock=False)

                # 2. 恢复 Keyable (可选，通常解锁就是为了能K帧)
                if keyable:
                    cmds.setAttr(full_attr, keyable=True, channelBox=True)

            except Exception as e:
                # 某些属性如果被连接可能会报错，或者属性不存在
                print(f"Warning: Could not unlock {full_attr}: {e}")