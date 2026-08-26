"""Non-mutating Maya 2025 world-space sampling for Motion Magnetism."""

from __future__ import annotations

from MayaCraft.domain.motion import MotionCapture, MotionSample, analyze_motion


def _maya_modules():
    import maya.api.OpenMaya as om
    import maya.cmds as cmds

    return cmds, om


class MayaMotionCapture:
    MAXIMUM_SAMPLES = 1200

    def capture_selection(self, start=None, end=None, step=1.0):
        cmds, _om = _maya_modules()
        selection = cmds.ls(selection=True, objectsOnly=True, long=True) or []
        if not selection:
            raise ValueError("请选择一个带动画的 transform、关节或控制器")
        node = selection[0]
        if cmds.nodeType(node) not in {"transform", "joint"}:
            parents = cmds.listRelatives(node, parent=True, fullPath=True) or []
            if not parents:
                raise ValueError(f"当前选择没有 transform 运动源：{node}")
            node = parents[0]
        return self.capture_node(node, start=start, end=end, step=step)

    def capture_node(self, node, start=None, end=None, step=1.0):
        cmds, _om = _maya_modules()
        matches = cmds.ls(node, long=True) or []
        if not matches:
            raise ValueError(f"运动源已不存在：{node}")
        node = matches[0]
        start = float(cmds.playbackOptions(query=True, minTime=True) if start is None else start)
        end = float(cmds.playbackOptions(query=True, maxTime=True) if end is None else end)
        step = float(step)
        if step <= 0.0 or end < start:
            raise ValueError("运动范围要求结束帧不小于开始帧，且步长大于 0")
        frames = self._frames(start, end, step)
        if len(frames) > self.MAXIMUM_SAMPLES:
            raise ValueError(
                f"运动范围需要 {len(frames)} 个采样，安全上限为 {self.MAXIMUM_SAMPLES}"
            )
        seconds_per_frame = self._seconds_per_frame()
        samples = tuple(self._sample(node, frame, seconds_per_frame) for frame in frames)
        analysis = analyze_motion(samples)
        return MotionCapture(
            node_path=node,
            samples=samples,
            analysis=analysis,
            frames_per_second=1.0 / seconds_per_frame,
        )

    @staticmethod
    def go_to_frame(frame: float) -> float:
        cmds, _om = _maya_modules()
        cmds.currentTime(float(frame), edit=True)
        current = float(cmds.currentTime(query=True))
        if abs(current - float(frame)) > 1e-6:
            raise RuntimeError(f"Maya 未能定位到第 {frame} 帧")
        return current

    @staticmethod
    def _frames(start, end, step):
        count = int((end - start) / step) + 1
        values = [start + index * step for index in range(count)]
        if not values or values[-1] < end - 1e-8:
            values.append(end)
        return tuple(values)

    @staticmethod
    def _seconds_per_frame():
        _cmds, om = _maya_modules()
        return float(om.MTime(1.0, om.MTime.uiUnit()).asUnits(om.MTime.kSeconds))

    @staticmethod
    def _sample(node, frame, seconds_per_frame):
        cmds, om = _maya_modules()
        raw = cmds.getAttr(node + ".worldMatrix[0]", time=frame)
        values = raw[0] if len(raw) == 1 and hasattr(raw[0], "__len__") else raw
        matrix = om.MMatrix(values)
        transform = om.MTransformationMatrix(matrix)
        translation = transform.translation(om.MSpace.kWorld)
        quaternion = transform.rotation(asQuaternion=True)
        return MotionSample(
            frame=float(frame),
            time_seconds=float(frame) * seconds_per_frame,
            position=(float(translation.x), float(translation.y), float(translation.z)),
            rotation=(float(quaternion.x), float(quaternion.y), float(quaternion.z), float(quaternion.w)),
        )
