import pymel.core as pm
from MayaCraft.core.face.utils import actions


# sculptTarget -e -regenerate true -target 3 LipBS


def split_lip_ue():
    pass


def split_lip_targets():
    bs, err = actions.find_node_by_name("LipBS", False)
    base, err = actions.find_node_by_name("LipPolygon", False)
    if err:
        return
    mesh = base.getShape()
    base_points = mesh.getPoints(space="world")
    weights = bs.weight.elements()

    ue_data = {
        "Up": [1, 1, 1, 1, 1, 1, 1,
               0, 0, 0, 0, 0, 0, 0, ],
        "Dn": [0, 0, 0, 0, 0, 0, 0,
               1, 1, 1, 1, 1, 1, 1, ],
        "Lf": [0, 0, 0, 0.5, 1, 1, 1,
               0, 0, 0, 0.5, 1, 1, 1, ],
        "Rt": [1, 1, 1, 0.5, 0, 0, 0,
               1, 1, 1, 0.5, 0, 0, 0, ]
    }

    for ue in "UE":
        polygons = []
        for ud in ["Up", "Dn"]:
            for rl in ["Rt", "Lf"]:
                n = "{rl}{ud}{ue}".format(**locals())
                if n not in weights:
                    continue
                i = weights.index(n)
                target_polygon = pm.PyNode(pm.sculptTarget(bs, e=1, regenerate=True, target=i)[0])
                polygons.append(target_polygon)
        offsets = [sum([p-base_points[i] for p in ps])
                   for i, ps in enumerate(zip(*[polygon.getShape().getPoints(space="world") for polygon in polygons]))]
        i = 0
        for ud in ["Up", "Dn"]:
            for rl in ["Rt", "Lf"]:
                # for ud_w, rl_w, basic, offset in zip(ue_data[ud], ue_data[rl], base_points, offsets):
                #     print basic + offset
                points = [base + offset * ud_w * rl_w
                          for ud_w, rl_w, base, offset in zip(ue_data[ud], ue_data[rl], base_points, offsets)]
                polygons[i].getShape().setPoints(points, space="world")
                i += 1

        pm.delete(polygons)