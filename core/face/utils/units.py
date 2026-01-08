# coding:utf-8

import pymel.core as pm


def bezier_v(p, t):
    return p[0]*(1-t)**3 + 3*p[1]*t*(1-t)**2 + 3*p[2]*t**2*(1-t) + p[3]*t**3


def bezier_t(p, v):
    min_t = 0.0
    max_t = 1.0
    while True:
        t = (min_t+max_t)/2
        error_range = bezier_v(p, t) - v
        if error_range > 0.0001:
            max_t = t
        elif error_range < -0.0001:
            min_t = t
        else:
            return t


def get_widget(x):
    if x <= 0:
        return 0
    elif x >= 1:
        return 1
    t = bezier_t([0, 0.2, 0.8, 1], x)
    return bezier_v([0, 0, 1, 1], t)


def paint_brow():
    selected = pm.selected(type="transform")
    if len(selected) != 1:
        return
    polygon = selected[0]
    mesh = polygon.getShape()
    skin_clusters = mesh.listHistory(type="skinCluster")
    if len(skin_clusters) != 1:
        return
    skin_cluster = skin_clusters[0]
    influences = skin_cluster.getInfluence()
    joints = [joint for joint in influences if not joint.liw.get()]

    def key(jnt):
        return jnt.tx.get()
    joints.sort(key=key)
    joint_ids = [influences.index(joint) for joint in joints]
    old_weight_matrix = [list(skin_cluster.getWeights(mesh, i)) for i in joint_ids]
    max_weights = [sum(ws) for ws in zip(*old_weight_matrix)]
    points = mesh.getPoints()
    up_temp = pm.group(em=1)
    origin_temp = pm.group(em=1)
    weight_matrix = [[1 for _ in points]]
    for i, joint in enumerate(joints[1:]):
        origin_point = joint.getTranslation(space="world")
        aim_point = joints[i].getTranslation(space="world")
        up_point = pm.datatypes.Point(origin_point[0], origin_point[1]+1, origin_point[2])
        radius = (origin_point - aim_point).length()
        up_temp.setTranslation(up_point, space="world")
        origin_temp.setTranslation(origin_point, space="world")
        pm.delete(pm.aimConstraint(up_temp, origin_temp, aimVector=[0, 1, 0], wut="object", wuo=joints[i]))
        origin_temp.setTranslation((origin_point+aim_point)/2, space="world")
        inverse = origin_temp.getMatrix(ws=1).inverse()
        weights = [get_widget(((p * inverse)[0] + radius) / radius / 2) for p in points]
        weights = [min(w1, w2) for w1, w2 in zip(weight_matrix[-1], weights)]
        weight_matrix.append(weights)
        weight_matrix[-2] = [w2 - w1 for w1, w2 in zip(weight_matrix[-1], weight_matrix[-2])]
    weight_matrix = [[w*m for w, m in zip(ws, max_weights)]for ws in weight_matrix ]
    weights = sum([list(ws) for ws in zip(*weight_matrix)], [])
    skin_cluster.setWeights(mesh, joint_ids, weights)
    pm.select(polygon)
    pm.delete(up_temp, origin_temp)