# coding:utf-8

import pymel.core as pm
from core.face.utils import control
from core.face.utils import actions


def brow_second_con(n, p, sx, radius, joint_group, SelectionBrowRoll, **kwargs):
    """
    创建单个眉毛次级控制器单元 (Secondary/Tweak Control)。

    核心原理：
    眉毛在额头的运动不是直线平移，而是围绕额头内部某一点（SelectionBrowRoll）进行的旋转滑动。
    这里利用 Aim Constraint 模拟这种机制。

    Args:
        n (str): 组件名称 (Name)
        p (list): 世界坐标位置 (Position)
        sx (int): 镜像缩放值 (1 或 -1)
        radius (float): 骨骼/控制器半径
        joint_group (PyNode): 骨骼存放组
        SelectionBrowRoll (PyNode): 额头旋转中心（球心）
    """
    # 1. 创建组结构
    # BrowControlGroup 用于存放控制器，BrowConnectGroup 用于存放运算节点
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|BrowControlGroup", init=False)
    roll_group = actions.create_group("|FaceGroup|FaceConnectGroup|BrowConnectGroup", init=False)

    # 2. 创建次级控制器 (Tweak Control)
    # create_second_control 通常返回一个组(ZeroGroup)和控制器本身(Control)
    second, con = actions.create_second_control(n=n, p=control_group)
    second.setTranslation(p, space="world")

    # [安全修复] 确保 SelectionBrowRoll 是 PyMel 对象，以便后续操作
    if isinstance(SelectionBrowRoll, str):
        SelectionBrowRoll = pm.PyNode(SelectionBrowRoll)

    # 3. 初始对齐
    # 让控制器的 Z 轴指向额头中心 (SelectionBrowRoll)，确保护额运动方向正确
    # 创建约束后立即删除，仅用于对齐初始旋转
    pm.delete(pm.aimConstraint(SelectionBrowRoll, second, wut="scene", aim=[0, 0, -1], wu=[0, 1, 0], u=[0, 1, 0]))

    # 创建控制器形状 (球形)
    control.control_create(con, s="ball", c=17, r=radius, o=[0, 0, radius * 2],
                           l=["sx", "sy", "sz", "v"])

    # 4. 构建滑动系统 (Surface Sliding Mechanism)
    # 这部分模拟了"眼球"结构：Aim 节点看着控制器，带动 Roll 节点旋转

    # Offset: 位于额头中心 (Roll的位置)，继承控制器的初始矩阵
    offset = pm.group(em=1, n=n + "Offset", p=roll_group)
    offset.setMatrix(con.getMatrix(ws=1), ws=1)
    offset.setTranslation(SelectionBrowRoll.getTranslation(space="world"), space="world")

    # Aim: 位于眉毛表面 (控制器的位置)，作为目标
    aim = pm.group(em=1, n=n + "Aim", p=offset)
    aim.setTranslation(con.getTranslation(space="world"), space="world")

    # Roll: 位于额头中心，它会盯着 Aim 看
    roll = pm.group(em=1, n=n + "Roll", p=offset)
    # 当控制器(con)带动 Aim 移动时，Roll 会旋转以跟随 Aim
    pm.aimConstraint(aim, roll, aim=[0, 0, 1], wut="none")

    # Parent: 位于眉毛表面，它是 Roll 的子级
    # 当 Roll 旋转时，Parent 会在球面表面滑动
    parent = pm.group(em=1, n=n + "Parent", p=roll)
    parent.setTranslation(con.getTranslation(space="world"), space="world")

    # 将控制器的旋转也传递给 Parent (用于微调旋转)
    con.r.connect(parent.r)

    # 5. 设置镜像
    offset.sx.set(sx)
    second.sx.set(sx)

    # 6. 创建最终骨骼
    # 骨骼被约束到 Parent 上，从而获得完美的贴脸滑动效果
    joint = pm.joint(joint_group, n=n + "Joint")
    joint.setMatrix(parent.getMatrix(ws=1), ws=1)
    pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)
    joint.radius.set(radius)

    return aim, con, parent


def create_brow_second_cons(radius, joint_group, SelectionBrowCurve, SelectionBrowRoll, SelectionBrowJoint, **kwargs):
    """
    [修复版] 生成所有眉毛次级控制器。
    负责在曲线上采样，并循环调用 brow_second_con 生成每个点的绑定。
    """
    # 1. 采样：在眉毛曲线 (SelectionBrowCurve) 上获取 5 个均匀分布的点
    points = actions.get_points_by_curve(curve=SelectionBrowCurve, number=5)

    results = []

    # 2. 循环生成左右两侧
    # [核心修复] 将原本的列表推导式改为显式循环
    # 显式传递参数，不再依赖 **locals() 的隐式传递，解决 Python 3 作用域问题
    for rl, sx in zip(["Rt", "Lf"], [1, -1]):  # Rt=右(1), Lf=左(-1)
        for i, t in enumerate(points):
            # 计算位置：根据 sx 进行 X 轴镜像
            pos = [sx * t[0], t[1], t[2]]
            name = "Brow{rl}{i:0>2}".format(rl=rl, i=i + 1)

            # 显式调用单点生成函数
            res = brow_second_con(
                n=name,
                p=pos,
                sx=sx,
                radius=radius,
                joint_group=joint_group,
                SelectionBrowRoll=SelectionBrowRoll
            )
            results.append(res)

    # 3. 创建中间 (Md) 控制器 (印堂位置)
    sx = 1
    # 获取 SelectionBrowJoint 的位置作为中间点
    if isinstance(SelectionBrowJoint, str):
        SelectionBrowJoint = pm.PyNode(SelectionBrowJoint)

    md_pos = SelectionBrowJoint.getTranslation(space="world")

    res_md = brow_second_con(
        n="BrowMd",
        p=md_pos,
        sx=sx,
        radius=radius,
        joint_group=joint_group,
        SelectionBrowRoll=SelectionBrowRoll
    )
    results.append(res_md)

    return results


def set_brow_sdk(results, radius, **kwargs):
    """
    设置驱动关键帧 (Set Driven Key) 和高级层级控制。
    这里构建了 Main 控制器和 Arc (表情形状) 控制器。
    """
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|BrowControlGroup", init=False)

    # [安全检查] 防止 results 为空导致 IndexError
    if not results or len(results) < 5:
        pm.warning("Results not enough to create SDK. Skipping.")
        return

    # 计算眉毛宽度，用于设置控制器移动的极限距离
    width = (results[4][0].getTranslation(space="world")[0] - results[0][0].getTranslation(space="world")[0]) / 2

    # 权重列表：定义了当 Arc 控制器移动时，眉毛从内到外受影响的程度
    # 例如：[1.0, 0.85, 0.5, 0.15, 0.0] 表示内侧动得多，外侧动得少
    weights = [
        [1.0, 0.85, 0.5, 0.15, 0.0],
        [0.05, 0.35, 0.5, 0.35, 0.0],
        [0.0, 0.15, 0.5, 0.85, 1.0],
    ]

    # 循环创建左右两侧的高级控制
    for rl_field, rl_offset, rl_v in zip(["Rt", "Lf"], [1, -1], [0, 1]):
        group = pm.group(em=1, p=control_group, n="Brow{rl}ControlGroup".format(rl=rl_field))
        # 将组放置在眉毛中间位置 (索引2是中间点)
        group.setMatrix(results[2 + 5 * rl_v][0].getMatrix(ws=1), ws=1)

        # 1. 创建 Main 控制器 (整体移动)
        main_con = control.control_create(
            p=group, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="browMain", c=13, r=radius * 6,
            o=[0, 0, radius * 4], n="Brow{rl}MainControl".format(rl=rl_field))

        # 2. 创建 Arc 控制器 (形状控制)
        arc_con = control.control_create(
            p=main_con, l=["rx", "ry", "rz", "sx", "sy", "sz", "v"], s="browArc", c=14, r=radius * 4,
            o=[0, 0, radius * 4], n="Brow{rl}ArcControl".format(rl=rl_field))

        # 添加高级属性：内侧高低、外侧高低、挤压等
        for attr in ["TyOt", "TyMd", "TyIn", "TxOt", "TxIn"]:
            arc_con.addAttr(attr, max=1, min=0, at="double", k=1)

        # 设置驱动关键帧 (SDK)：
        # 当移动 Arc 控制器的 X 轴时，自动触发 TyOt, TyIn 等属性，从而改变眉毛形状
        for attr, dv_v in (
                ["TyOt", [(-1, 1), (1, 0)]], ["TyMd", [(-1, 0), (0, 1), (1, 0)]], ["TyIn", [(-1, 0), (1, 1)]],
                ["TxOt", [(1, 0), (9, 8 * width)]], ["TxIn", [(-1, 0), (-9, -8 * width)]]):
            for dv, v in dv_v:
                pm.setDrivenKeyframe(arc_con.attr(attr), cd=arc_con.tx, dv=dv * width, v=v)

        # 3. 混合权重逻辑 (blendWeighted)
        # 这是一个核心逻辑：每个次级点的位置 = Main位移 + Arc形状位移 + 自身Tweak位移
        for i, (aim, con, parent), wts in zip(range(5), results[rl_v * 5: rl_v * 5 + 5], zip(*weights)):
            # 创建混合节点
            arc = pm.createNode("blendWeighted", n="Brow{rl}{i:0>2}ArcBlendWeighted".format(rl=rl_field, i=i + 1))
            com_y = pm.createNode("blendWeighted", n="Brow{rl}{i:0>2}TyBlendWeighted".format(rl=rl_field, i=i + 1))
            com_z = pm.createNode("blendWeighted", n="Brow{rl}{i:0>2}TzBlendWeighted".format(rl=rl_field, i=i + 1))

            # 将 SDK 计算出的形状值，乘以预设的权重 wts
            for j, (weight, attr) in enumerate(zip(wts, ["TyOt", "TyMd", "TyIn"])):
                con.addAttr(attr, at="double", k=0, dv=weight)
                pm.setAttr(con.attr(attr), cb=1)
                con.attr(attr).connect(arc.weight[j])
                arc_con.attr(attr).inputs(p=1)[0].connect(arc.input[j])

            # 汇总 Y 轴位移
            con.addAttr("MainTy", at="double", k=0, dv=1)
            pm.setAttr(con.MainTy, cb=1)
            arc_con.ty.connect(com_y.input[0])  # Arc控制器的Y
            main_con.ty.connect(com_y.input[1])  # Main控制器的Y
            con.ty.connect(com_y.input[2])  # 次级控制器的Y

            arc.output.connect(com_y.weight[0])  # 形状权重结果
            con.MainTy.connect(com_y.weight[1])
            com_y.weight[2].set(1)
            com_y.output.connect(aim.ty)  # 输出给 Aim 组

            # 汇总 Z 轴位移 (保持贴脸)
            arc_con.tz.connect(com_z.input[0])
            main_con.tz.connect(com_z.input[1])
            con.tz.connect(com_z.input[2])
            com_z.input[3].set(parent.tz.get())
            arc.output.connect(com_z.weight[0])
            con.MainTy.connect(com_z.weight[1])
            com_z.weight[2].set(1)
            com_z.weight[3].set(1)
            com_z.output.connect(parent.tz, f=1)

        # X 轴权重的特殊处理 (用于挤压/扩展)
        tx_weights = [0.2, 0.5, 0.9, 0.95, 1.0], [1.0, 0.95, 0.9, 0.5, 0.2]

        for i, (aim, con, parent), ws in zip(range(5), results[rl_v * 5: rl_v * 5 + 5], zip(*tx_weights)):
            blend = pm.createNode("blendWeighted", n="Brow{rl}{i:0>2}TxBlendWeighted".format(rl=rl_field, i=i + 1))
            for j, attr in enumerate(["TxOt", "TxIn"]):
                con.addAttr(attr, at="double", k=0, dv=ws[j])
                pm.setAttr(con.attr(attr), cb=1)
                con.attr(attr).connect(blend.weight[j])
                arc_con.attr(attr).inputs(p=1)[0].connect(blend.input[j])
            main_con.tx.connect(blend.input[2])
            con.tx.connect(blend.input[3])
            blend.weight[2].set(1)
            blend.weight[3].set(1)
            blend.output.connect(aim.tx)

        # 清理不必要的属性显示
        for attr in ["TyOt", "TyMd", "TyIn", "TxOt", "TxIn"]:
            pm.deleteAttr(arc_con.attr(attr))

    # 4. 中间点 (BrowMd) 的混合
    # 中间点同时受左边最内侧和右边最内侧控制器的影响，取平均值
    ty_blend = pm.createNode("blendWeighted", n="BrowMdTyBlendWeighted")
    results[4][0].ty.connect(ty_blend.input[0])  # 右边内侧 Aim
    results[9][0].ty.connect(ty_blend.input[1])  # 左边内侧 Aim
    results[10][1].ty.connect(ty_blend.input[2])  # 自己的控制器
    ty_blend.weight[0].set(0.5)
    ty_blend.weight[1].set(0.5)
    ty_blend.weight[2].set(1)
    ty_blend.output.connect(results[10][0].ty)  # 结果给 BrowMd 的 Aim

    # X轴和Z轴同理进行混合
    tx_blend = pm.createNode("blendWeighted", n="BrowMdTxBlendWeighted")
    results[4][0].tx.connect(tx_blend.input[0])
    results[9][0].tx.connect(tx_blend.input[1])
    results[10][1].tx.connect(tx_blend.input[2])
    tx_blend.weight[0].set(0.2)
    tx_blend.weight[1].set(-0.2)
    tx_blend.weight[2].set(1)
    tx_blend.output.connect(results[10][0].tx)

    tz_blend = pm.createNode("blendWeighted", n="BrowMdTzBlendWeighted")
    results[4][2].tz.connect(tz_blend.input[0])
    results[9][2].tz.connect(tz_blend.input[1])
    results[10][1].tz.connect(tz_blend.input[2])
    tz_blend.weight[0].set(0.5)
    tz_blend.weight[1].set(0.5)
    tz_blend.weight[2].set(1)
    tz_blend.output.connect(results[10][2].tz)
    return


def brow_nose_rig():
    """
    眉心与鼻子的连接绑定。
    处理皱眉时，眉心积压导致的体积变化。
    """
    # 安全检查
    if not pm.objExists("SelectionBrowNoseJoint") or not pm.objExists("BrowMdJoint") or not pm.objExists("NoseUpJoint"):
        return

    SelectionBrowNoseJoint = pm.PyNode("SelectionBrowNoseJoint")
    BrowMdJoint = pm.PyNode("BrowMdJoint")
    NoseUpJoint = pm.PyNode("NoseUpJoint")

    joint_group = actions.create_joint("|FaceGroup|FaceJoint", init=False)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup", init=False)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup", init=False)

    n = "BrowNose"
    radius = BrowMdJoint.radius.get()

    # 创建偏移组和体积组
    offset = pm.group(em=1, p=connect_group, n=n + "Offset")
    offset.setMatrix(SelectionBrowNoseJoint.getMatrix(ws=1), ws=1)
    volume = pm.group(em=1, p=connect_group, n=n + "Volume")
    parent = pm.group(em=1, p=volume, n=n + "Parent")

    joint = pm.joint(joint_group, radius=radius, n=n + "Joint")
    second, con = actions.create_second_control(p=control_group, n=n, t=True, r=False)
    control.control_create(con, n=n + "Control", s="ball", c=17, r=radius, l=["sz", "sy", "sx", "v"])

    second.setMatrix(offset.getMatrix(ws=1), ws=1)
    con.t.connect(parent.t)
    con.r.connect(parent.r)
    joint.setMatrix(offset.getMatrix(ws=1), ws=1)
    pm.parent(pm.parentConstraint(parent, joint, mo=1), parent)
    pm.transformLimits(volume, tz=(0, 0), etz=(1, 0))  # 限制体积只能向外顶

    # 混合逻辑：当眉心下压 或 鼻子皱起时，触发体积变化
    blend = pm.createNode("blendWeighted", n=n + "BlendWeighted")

    blend.input[0].set(-NoseUpJoint.ty.get())
    NoseUpJoint.ty.connect(blend.input[1])
    con.addAttr("noseVolume", max=0, min=1, at="double", k=1, dv=0.2)
    con.noseVolume.connect(blend.weight[0])
    con.noseVolume.connect(blend.weight[1])

    blend.input[2].set(-BrowMdJoint.ty.get())
    BrowMdJoint.ty.connect(blend.input[3])
    con.addAttr("browVolume", max=0, min=1, at="double", k=1, dv=0.4)

    # 使用 SDK 映射位移值到权重值
    pm.setDrivenKeyframe(blend.weight[2], cd=con.browVolume, dv=0, v=0, itt="linear", ott="linear")
    pm.setDrivenKeyframe(blend.weight[2], cd=con.browVolume, dv=1, v=-1, itt="linear", ott="linear")
    blend.weight[2].inputs(p=1)[0].connect(blend.weight[3])

    # 输出到 Volume 组的 Z 轴（产生向外顶的效果）
    blend.output.connect(volume.tz)


def brow_rig():
    """
    眉毛绑定主入口函数。
    """
    err = False
    # 1. 查找场景中的定位器 (Locators)
    SelectionBrowCurve, err = actions.find_node_by_name("SelectionBrowCurve", err)
    SelectionBrowRoll, err = actions.find_node_by_name("SelectionBrowRoll", err)
    SelectionBrowJoint, err = actions.find_node_by_name("SelectionBrowJoint", err)

    if err:
        return pm.warning("can not find brow object")

    # [安全修复] 转换为 PyNode 对象
    if isinstance(SelectionBrowCurve, str): SelectionBrowCurve = pm.PyNode(SelectionBrowCurve)
    if isinstance(SelectionBrowRoll, str): SelectionBrowRoll = pm.PyNode(SelectionBrowRoll)
    if isinstance(SelectionBrowJoint, str): SelectionBrowJoint = pm.PyNode(SelectionBrowJoint)

    # 2. 初始化主层级组
    joint_group = actions.create_joint("|FaceGroup|FaceJoint|BrowJointGroup", init=True)
    connect_group = actions.create_group("|FaceGroup|FaceConnectGroup|BrowConnectGroup", init=True)
    control_group = actions.create_group("|FaceGroup|FaceControlGroup|BrowControlGroup", init=True)

    # 3. 计算控制器半径 (根据眉毛曲线长度自动适配)
    radius = SelectionBrowCurve.getShape().length() / 4 / 10

    # 4. 创建眉毛次级控制器 (Tweak Controls)
    # [核心修复] 调用修复后的函数，显式传递 locals() 已经不够了，必须依靠函数内部的显式参数传递
    # **locals() 在这里是安全的，因为这是最外层调用，变量都在本地
    # 但为了保险，create_brow_second_cons 内部已经改成了显式循环
    results = create_brow_second_cons(**locals())

    # 5. 设置 SDK 和高级控制
    set_brow_sdk(**locals())

    # 6. 设置眉心连接
    brow_nose_rig()