"""Maya 2025 API 2.0 capture adapter for versioned Pose/Clip assets."""

from __future__ import annotations

from MayaCraft.domain.pose_clip import ClipAsset, PoseAsset, PoseFrame, PoseNode, validate_clip, validate_pose_frame


def _maya_modules():
    import maya.api.OpenMaya as om
    import maya.cmds as cmds

    return cmds, om


class MayaPoseClipCapture:
    """Read transforms at explicit DG time contexts without moving Maya's timeline."""

    MAXIMUM_NODES = 512
    MAXIMUM_FRAME_SAMPLES = 120_000

    def capture_pose(self, nodes=None, label="当前姿态", character_id=""):
        cmds, om = _maya_modules()
        paths = self._resolve_nodes(cmds, nodes)
        frame = float(cmds.currentTime(query=True))
        pose_frame = self._capture_frame(paths, frame, om)
        issues = validate_pose_frame(pose_frame)
        if issues:
            raise ValueError("；".join(issues))
        return PoseAsset(
            label=str(label),
            character_id=str(character_id),
            frame=pose_frame,
            source=f"Maya {cmds.about(version=True)} / API 2.0 DG Context",
        )

    def capture_clip(
        self,
        nodes=None,
        start=None,
        end=None,
        step=1.0,
        label="动画片段",
        character_id="",
    ):
        cmds, om = _maya_modules()
        paths = self._resolve_nodes(cmds, nodes)
        start_value = float(cmds.playbackOptions(query=True, minTime=True) if start is None else start)
        end_value = float(cmds.playbackOptions(query=True, maxTime=True) if end is None else end)
        step_value = float(step)
        if step_value <= 0.0 or end_value < start_value:
            raise ValueError("Clip 采样范围或步长无效")
        frame_count = int((end_value - start_value) / step_value + 1e-9) + 1
        if frame_count * len(paths) > self.MAXIMUM_FRAME_SAMPLES:
            raise ValueError(
                f"Clip 需要 {frame_count * len(paths)} 个节点帧采样，交互上限为 {self.MAXIMUM_FRAME_SAMPLES}"
            )
        frames = tuple(
            self._capture_frame(paths, start_value + index * step_value, om)
            for index in range(frame_count)
        )
        seconds_per_frame = om.MTime(1.0, om.MTime.uiUnit()).asUnits(om.MTime.kSeconds)
        clip = ClipAsset(
            label=str(label),
            character_id=str(character_id),
            frames_per_second=1.0 / seconds_per_frame,
            frames=frames,
            source=f"Maya {cmds.about(version=True)} / API 2.0 DG Context",
        )
        issues = validate_clip(clip)
        if issues:
            raise ValueError("；".join(issues))
        return clip

    @classmethod
    def _resolve_nodes(cls, cmds, nodes):
        values = tuple(nodes) if nodes is not None else tuple(cmds.ls(selection=True, long=True) or ())
        resolved = []
        for value in values:
            objects = cmds.ls(value, objectsOnly=True, long=True) or []
            if not objects:
                continue
            path = objects[0]
            if not cmds.objectType(path, isAType="transform"):
                parents = cmds.listRelatives(path, parent=True, fullPath=True) or []
                if not parents or not cmds.objectType(parents[0], isAType="transform"):
                    continue
                path = parents[0]
            if path not in resolved:
                resolved.append(path)
        if not resolved:
            raise ValueError("请选择至少一个控制器、关节或 Transform")
        if len(resolved) > cls.MAXIMUM_NODES:
            raise ValueError(f"一次最多捕获 {cls.MAXIMUM_NODES} 个动画节点")
        resolved.sort(key=lambda path: (path.count("|"), path.casefold()))
        keys = tuple(cls._portable_key(path) for path in resolved)
        duplicates = tuple(sorted({key for key in keys if keys.count(key) > 1}))
        if duplicates:
            raise ValueError("移除命名空间后的节点键重复：" + "，".join(duplicates))
        return tuple(resolved)

    @classmethod
    def _capture_frame(cls, paths, frame, om):
        keys = {path: cls._portable_key(path) for path in paths}
        path_set = set(paths)
        context = om.MDGContext(om.MTime(float(frame), om.MTime.uiUnit()))
        nodes = []
        for path in paths:
            selection = om.MSelectionList()
            selection.add(path)
            dag = selection.getDagPath(0)
            dependency = om.MFnDependencyNode(dag.node())
            parents = dag.fullPathName().rsplit("|", 1)[0]
            parent_path = parents if parents in path_set else ""
            translation = tuple(cls._number(dependency, f"translate{axis}", context) for axis in "XYZ")
            rotation = tuple(cls._angle(dependency, f"rotate{axis}", context, om) for axis in "XYZ")
            rotate_order = int(cls._number(dependency, "rotateOrder", context))
            local_quaternion = om.MEulerRotation(*rotation, rotate_order).asQuaternion()
            scale = tuple(cls._number(dependency, f"scale{axis}", context) for axis in "XYZ")
            world_plug = dependency.findPlug("worldMatrix", False).elementByLogicalIndex(0)
            matrix = om.MFnMatrixData(world_plug.asMObject(context)).matrix()
            world = om.MTransformationMatrix(matrix)
            world_translation = world.translation(om.MSpace.kWorld)
            world_quaternion = world.rotation(asQuaternion=True)
            custom = cls._custom_channels(dependency, context, om)
            nodes.append(PoseNode(
                key=keys[path],
                node_path=dag.fullPathName(),
                parent_key=keys[parent_path] if parent_path else "",
                local_translation=tuple(float(value) for value in translation),
                local_rotation=cls._quaternion_tuple(local_quaternion),
                local_scale=tuple(float(value) for value in scale),
                world_translation=(float(world_translation.x), float(world_translation.y), float(world_translation.z)),
                world_rotation=cls._quaternion_tuple(world_quaternion),
                custom_channels=custom,
            ))
        return PoseFrame(frame=float(frame), nodes=tuple(nodes))

    @staticmethod
    def _number(dependency, name, context):
        plug = dependency.findPlug(name, False)
        try:
            return float(plug.asDouble(context))
        except Exception:
            return float(plug.asInt(context))

    @staticmethod
    def _angle(dependency, name, context, om):
        return float(dependency.findPlug(name, False).asMAngle(context).asRadians())

    @classmethod
    def _custom_channels(cls, dependency, context, om):
        channels = []
        for index in range(dependency.attributeCount()):
            attribute = dependency.attribute(index)
            attribute_fn = om.MFnAttribute(attribute)
            if not attribute_fn.dynamic or not attribute_fn.keyable:
                continue
            name = attribute_fn.name
            try:
                value = cls._number(dependency, name, context)
            except Exception:
                continue
            channels.append((name, value))
        return tuple(sorted(channels))

    @staticmethod
    def _portable_key(path):
        leaf = path.rsplit("|", 1)[-1]
        return leaf.rsplit(":", 1)[-1]

    @staticmethod
    def _quaternion_tuple(value):
        return (float(value.x), float(value.y), float(value.z), float(value.w))


__all__ = ["MayaPoseClipCapture"]
