# MayaCraft 当前状态

更新时间：2026-08-30  
当前版本：`2.3.0`
唯一支持环境：Autodesk Maya 2025 / Python 3.11 / PySide6 6.5.3

本文件是 MayaCraft 的当前事实入口。`DEVELOPMENT_PLAN.md` 保留逐批开发记录，早期数字和“下一步”只代表当时的历史快照；`HERO_PROTOTYPE_AUDIT.md` 是 2.2 发布证据，不再承担滚动路线图。

## 已稳定的展示能力

- 中文原生 `workspaceControl`，使用 PySide6 与 QPainter，不包含 Web 前端；
- Character Workspace：角色发现、Session 切换、DAG 投影、双向选择与安全注册；
- Deformation MRI：真实 skinCluster 权重场、PCA 投影、镜像与可撤销归一化修复；
- Motion Magnetism：轨迹微分、接触推断、Ghost 比较和 Contact Anchor；
- Retarget：Pose/Clip、轴空间模板、Clip Package v2、资产浏览、Animation Layer 与 Contact IK；
- Rig Graph：7 个模块、137 个声明对象、50 条物理行为，共 187 项可读回构建结果；
- 动画匹配：当前帧 FK→IK / IK→FK 无跳变匹配与带保护关键帧的 Space Switch；
- Quaternion Twist Hero：24 枚 Twist 关节、8 套真实 DG 分布网络、任意局部轴 swing–twist 分解与安全塑形事务；
- 6 套由 Maya 2025 确定性生成的演示场景，以及宽版、窄版、成功、阻断和 Undo 真实截图；
- 2.3 发布节点的 75 项离线测试、Bendy/旧 Rig Graph/Twist mayapy 组合回归、隐藏 Maya 生命周期和
  `.mod` 安装读回均已通过；隐藏 Maya 使用 `2.3.0 / PySide6`，完成后没有遗留宿主进程。

## 当前产品边界

- MayaCraft 只做绑定、蒙皮、动画和角色制作可视化；通用 TD、节点诊断和场景审计属于独立 MayaScope。
- `domain/`、`adapters/maya/` 与 `ui/` 是继续开发的生产路径。
- 旧 Rigging / Face / Skinning / Animation / General 页只作为迁移期入口，采用 lazy-load 隔离；不把 legacy 按钮数量当作完成度，也不在本轮大规模翻新。
- 当前只支持 Maya 2025。Face PSD/RBF、拓扑变化蒙皮迁移和多 Maya 版本兼容不在本轮范围。

## 当前 Hero

当前 Hero 是 Bendy「形变弧场」。它不是传统的参数表单，而是一张直接表达肢体轮廓的弧线工作区：绑定师拖动弧心和切线意图，先看到零写入形变带，再明确应用到真实 Maya DG。弯曲负责轮廓，Twist 子层负责绕主轴旋转。

核心闭环已经落地：宿主无关层包含弧长均匀采样、Parallel Transport Frame、低曲率参考轴回退和可调体积保持；生产 `BendyArcField` 可拖两个切线把手或肌腹把手塑造 C/S 型轮廓。真实 Rig Graph 为八条骨段新增 40 个对象和 8 条 `bendy_curve` 行为，使用 NURBS、motionPath、curveInfo、distanceBetween 与矩阵节点实时驱动。写入事务包含指纹复核、单一 Undo、控制器/关节读回和失败回滚；断开旋转连接会被定位为行为漂移。Twist 关节作为 Bendy 子层继续得到 `22.5° / 45° / 67.5°` 的 quaternion 分配。

完成标准：真实 DG、零写入预览、漂移阻断、单一 Undo、读回验证、确定性场景、中文宽/窄界面、成功/阻断/撤销证据和一条 60–90 秒录屏路径。

以上完成标准已在 2.3 发布收口中满足。下一轮开发应从本文件重新选择一个明确的 Hero 切片，不再把
Bendy 已完成项写成待办。

## 快速开发规则

普通短切片只做与风险相称的验证：

1. 新增或受影响的离线测试；
2. 一个直接相关的 mayapy 事务测试；
3. 一次目标 Dock 尺寸视觉复核。

不因微小改动重复运行全量回归、隐藏 Maya 生命周期、性能基准或整套截图。只有共享 Rig Graph、安装/生命周期基础设施发生变化，或到达可发布里程碑时，才运行完整门槛。

每个写场景功能仍必须保留：零写入预览、计划指纹、应用前漂移检查、单一命名 Undo chunk、写后读回和失败回滚。

## 界面方向

三个性格词：**有机、精确、带动势**。

- 视觉母题：关节弧线、角色轮廓、运动草图、形变带；
- 空间结构：中心弧场承担主要交互，参数贴近弧线意图，结果状态沿弧线发生；
- 色彩：骨骼暖白、张力珊瑚、通过薄荷绿、阻断朱红；色彩跟随解剖与状态，不做无意义霓虹；
- 动效：拖动时形变带连续呼吸，切线与体积随曲率响应；高频操作保持快速；
- 反参考：通用 AI 仪表盘、伪终端、治理话术、全大写英文标签、同尺寸卡片海、每块内容都发光。
