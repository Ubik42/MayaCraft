"""Read-only Maya 2025 joint hierarchy capture and semantic analysis."""

from __future__ import annotations

from MayaCraft.domain.skeleton import JointObservation, analyze_skeleton


def _cmds():
    import maya.cmds as cmds
    return cmds


class MayaSkeletonScanner:
    MAX_JOINTS = 512

    def capture_selection(self):
        cmds = _cmds()
        selection = cmds.ls(selection=True, objectsOnly=True, long=True) or []
        joint = next((item for item in selection if cmds.nodeType(item) == "joint"), "")
        if not joint:
            return analyze_skeleton(())
        return self.capture_joint(joint)

    def capture_joint(self, joint):
        cmds = _cmds()
        matches = cmds.ls(joint, type="joint", long=True) or []
        if not matches:
            return analyze_skeleton(())
        root = matches[0]
        while True:
            parents = cmds.listRelatives(root, parent=True, type="joint", fullPath=True) or []
            if not parents:
                break
            root = parents[0]
        paths = [root] + (cmds.listRelatives(root, allDescendents=True, type="joint", fullPath=True) or [])
        paths = tuple(sorted(set(paths), key=lambda item: (item.count("|"), item.casefold())))
        if len(paths) > self.MAX_JOINTS:
            raise RuntimeError(f"Skeleton safety limit exceeded: {len(paths)} joints")
        observations = []
        for path in paths:
            parent = cmds.listRelatives(path, parent=True, type="joint", fullPath=True) or []
            matrix = cmds.xform(path, query=True, worldSpace=True, matrix=True)
            # Maya's world matrix is row-major; translation occupies 12..14.
            position = tuple(float(matrix[index]) for index in (12, 13, 14))
            rotation = cmds.xform(path, query=True, worldSpace=True, rotation=True)
            import maya.api.OpenMaya as om
            euler = om.MEulerRotation(*(om.MAngle(float(value), om.MAngle.kDegrees).asRadians() for value in rotation))
            quaternion = euler.asQuaternion()
            children = cmds.listRelatives(path, children=True, type="joint", fullPath=True) or []
            observations.append(JointObservation(
                path=path,
                name=path.rsplit("|", 1)[-1],
                parent_path=parent[0] if parent else "",
                position=position,
                orientation=(quaternion.x, quaternion.y, quaternion.z, quaternion.w),
                child_count=len(children),
            ))
        return analyze_skeleton(observations)


__all__ = ["MayaSkeletonScanner"]
