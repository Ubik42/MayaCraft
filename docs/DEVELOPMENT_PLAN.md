# MayaCraft 开发计划

> 本文保留 2026-08-25 起的逐批决策与验证日志，其中的版本号、数量和“下一步”均是当时快照。
> 当前稳定能力、本轮边界与最新开发目标统一见 [PROJECT_STATUS.md](PROJECT_STATUS.md)。

状态：产品重新定位后的基线计划  
日期：2026-08-25  
产品定位：面向 Maya 的专业角色绑定、蒙皮与动画制作系统

> R0 市场、社区、算法与视觉方向研究已经完成。产品决策以
> [RESEARCH_RIGGING_ANIMATION_PRODUCT.md](RESEARCH_RIGGING_ANIMATION_PRODUCT.md)
> 为准：MayaCraft 定位为 Character Intelligence Workspace，采用
> Living Rig Canvas、Deformation MRI、Motion Magnetism 三条招牌工作流，
> 并以 Kinetic Holographic Stage 作为视觉与动态交互方向。

## 1. 产品判断

MayaCraft 不再做“常用 Maya 命令按钮合集”，也不再承载通用 TD、节点浏览和场景诊断。它应该解决绑定师和动画师真正困难、重复、容易出错且需要大量空间推理的问题，并把算法过程做成可理解、可预览、可回滚的交互系统。

核心价值不是按钮数量，而是以下四件事：

1. 用声明式 Rig Graph 表达角色绑定意图，并稳定地编译成 Maya 节点网络；
2. 用几何、拓扑、数值优化和运动学算法处理传统脚本难以可靠处理的问题；
3. 用视口叠加、热力图、曲线与依赖图解释系统正在做什么；
4. 用事务、差异预览、验证器和回归场景把危险操作变成可控流程。

## 2. 明确边界

### 属于 MayaCraft

- 身体、面部和道具绑定；
- 控制器、骨架、约束、变形器与 Rig 构建；
- 蒙皮权重生成、迁移、修复、镜像和质量评估；
- FK/IK、空间切换、Pose、重定向、动画曲线与运动编辑；
- 面向绑定和动画的视口可视化、诊断与发布验证；
- 与 Unreal、MotionBuilder 等角色动画链路相关的导出与兼容。

### 不属于 MayaCraft

- 通用 DG/DAG 浏览器、任意节点网络分析与 Maya 性能剖析；
- 通用 Set 管理、脚本源码分析、MEL IDE；
- 与角色绑定和动画没有直接关系的资产管理或流水线工具；
- 没有稳定数据模型、验证和撤销策略的一次性按钮。

上述通用 TD 能力统一进入 MayaScope。

## 3. 当前代码基线与债务

- 现有 Rigging、Face、Skinning、Animation 是可以提取需求的原型，不是目标架构；
- Face 有 14 个 PyMEL 依赖文件，耦合场景命名、UI 和执行副作用；
- Build 流程缺少统一的 Rig 数据模型、变更计划、事务和幂等保证；
- 蒙皮和动画算法以命令组合为主，缺少独立数值内核及可验证输入输出；
- 当前 UI 以表单和按钮为主，没有面向复杂空间关系的交互模型；
- 缺少 Maya 场景夹具、黄金结果、性能基准和多版本 CI 证据。

现有功能后续必须经过“保留、重写、淘汰”三选一评审，不默认继承。

## 4. 目标架构

```text
MayaCraft/
├─ domain/            Rig、Skeleton、Control、Pose、Skin 等纯数据模型
├─ graph/             Rig Graph、依赖解析、编译计划、差异与迁移
├─ algorithms/        几何、拓扑、运动学、权重、曲线与优化算法
├─ adapters/maya/     maya.api.OpenMaya、cmds、Undo 与 Evaluation 适配
├─ features/          rigging、face、skinning、animation、retarget
├─ visualization/     VP2 overlay、heatmap、轨迹、依赖图和调试绘制
├─ ui/                工作流界面；不直接包含 Maya 业务命令
├─ schemas/           Rig/Pose/Profile 的版本化 JSON schema
├─ tests/
│  ├─ unit/           可在普通 Python 执行的算法测试
│  ├─ maya/           mayapy 场景集成测试
│  ├─ scenes/         最小复现场景和黄金结果
│  └─ benchmarks/     构建、求解、权重和交互性能基准
└─ legacy/            只供迁移比对，不进入运行时
```

### 4.1 Rig Graph 与编译器

Rig 不应由散落的 `cmds.createNode` 调用定义，而应先形成中间表示：

- 节点、端口、属性、空间、约束和变形关系拥有稳定 ID；
- Build 分为 validate、plan、preview、apply、verify 五个阶段；
- 编译器计算依赖 DAG、构建顺序、命名和 Maya 实现策略；
- 同一个定义重复构建必须幂等；
- 修改 Rig 定义时生成结构化 diff，而不是全删全建；
- 每次执行进入 Maya Undo Chunk，并记录可审计的 ChangeSet；
- 失败时报告精确步骤、输入、创建对象和回滚结果。

### 4.2 算法内核候选

以下是下一轮调研要验证价值和可行性的候选，不在调研前盲目承诺实现：

#### 几何与拓扑

- 半边结构或 Maya Mesh Iterator 上的边环/边界/分区识别；
- Dijkstra/A* 测地路径、曲面距离和对称对应；
- Laplacian、cotangent Laplacian、曲率与局部特征检测；
- barycentric/UV/closest-point 映射，用于权重和控制数据迁移；
- parallel transport frame，减少沿曲线分布关节时的翻转；
- RBF、MLS 或 Pose Space Deformation 的局部形变插值。

#### 蒙皮与变形

- heat diffusion、geodesic voxel 或 harmonic weight 初始化；
- 稀疏权重约束、归一化、prune 与 influence 预算优化；
- 拓扑变化后的权重重投影和置信度可视化；
- 基于局部坐标、骨骼语义和网格特征的镜像映射；
- 形变质量指标：体积损失、拉伸、翻折、权重梯度异常。

#### 运动学与重定向

- 稳定 Pole Vector 与共线退化处理；
- quaternion swing-twist 分解和可控 Twist 分配；
- FABRIK、Jacobian DLS 等多关节求解候选；
- FK/IK 无跳变匹配、空间切换补偿和世界轨迹保持；
- 不同骨架比例、轴向和关节层级之间的语义重定向；
- 足底接触、根运动和滑步检测/修正。

#### 动画曲线与运动分析

- quaternion continuity、Euler unroll/filter 与旋转误差度量；
- Ramer–Douglas–Peucker、误差有界拟合或分段多项式减帧；
- 速度、加速度、jerk、弧长和接触区间分析；
- Pose/Clip 相似度、镜像、对齐与可搜索特征；
- 时间重映射、motion warping 和轨迹约束。

### 4.3 可视化与动态交互

- VP2 视口中显示骨骼轴、关节限制、Pole 平面、Twist 分布和空间关系；
- 蒙皮权重、影响骨骼、异常梯度和变形误差热力图；
- 可拖动的 Rig Guide，拖动时实时求解并显示约束冲突；
- FK/IK、重定向和空间切换前后的 Ghost/Trajectory 对比；
- Rig Graph 可视化：模块折叠、依赖追踪、构建状态和错误定位；
- 所有自动算法提供 preview、置信度、局部锁定和用户修正入口；
- 长任务可取消，进度与当前阶段可见，UI 不阻塞 Maya 主线程。

## 5. 产品工作区设想

最终界面不应继续以六七个大标签页堆按钮。候选结构：

```text
Project / Character
├─ Guides & Skeleton
├─ Rig Graph
├─ Skin & Deformation
├─ Animation & Retarget
├─ Inspect & Validate
└─ Publish

Viewport Overlay + Context Inspector + Task/Change History
```

选中对象、当前工作阶段和错误上下文应驱动界面；同一功能不重复出现在多个面板。

## 6. 开发阶段

### R0：整轮深度调研（已完成，2026-08-25）

目标：回答“专业绑定/动画工具真正值得做什么”，形成有证据的产品定义。

必须产出：

1. 用户工作流地图：角色从 Guide 到发布、动画从导入到交付的完整链路；
2. 竞品矩阵：Maya 原生、mGear、Advanced Skeleton、HumanIK、Rapid Rig、ngSkinTools、Zoo Tools、AnimBot、Red9、Studio Library 等；
3. 算法调查：论文、开源实现、复杂度、Maya API 可落地性和许可；
4. 交互调查：视口操控、图编辑、热力图、实时预览和错误解释范式；
5. 现有代码逐模块去留表；
6. 三个候选“杀手级工作流”的原型规格和价值/风险评分；
7. 目标用户、首发范围、非目标和成功指标；
8. 调研证据索引，所有结论可回溯到来源。

R0 研究结论见 `docs/RESEARCH_RIGGING_ANIMATION_PRODUCT.md`。结论要求先做
Hero Prototype 和三张高保真关键界面，不先铺满功能菜单；Face 继续冻结，
直到 Rig Graph、Skin 数据层与 Pose 数据层建立。

### R1：可信内核

- 建立 domain model、schema、Maya adapter 和事务层；
- 建立 unit/mayapy/scene/benchmark 四层测试；
- 选一个最小 Rig 模块走通 plan-preview-apply-verify；
- 展示版只支持 Maya 2025 / PySide6，并加入真实 mayapy 与 GUI 验证证据。

### R2：Rig Graph 与身体绑定

- Guide、Skeleton 与 Rig Graph；
- FK/IK、空间切换、Twist/Bendy 的声明式模块；
- 增量 Build、结构 diff、错误定位和发布验证；
- 完成至少一套双足角色黄金场景。

### R3：Skin 与 Deformation

- 权重数据模型和高性能读写；
- 自动初始化、镜像、迁移、修复和质量评分；
- 热力图和局部交互修正；
- 大网格性能基准及拓扑变化回归场景。

### R4：Animation 与 Retarget

- Pose/Clip 数据层；
- FK/IK、空间、曲线、轨迹和接触工作流；
- 骨架语义映射与重定向；
- 非破坏预览、Animation Layer 策略和导出验证。

### R5：Face 与高级求解

- 依据 R0 结论决定保留传统模块化面部 Rig，还是转向 PSD/RBF 混合方案；
- 移除运行时 PyMEL 依赖；
- 建立表情、口型、眼睑和面部权重黄金场景。

### R6：制作化

- Maya Module 安装、版本迁移、日志和崩溃恢复；
- 文档、示例角色、性能预算和发布检查清单；
- 真实项目试用与遥测（默认本地、显式同意）；
- API 稳定性和兼容策略。

## 7. 质量门槛

任何功能进入主界面前必须满足：

- 有明确用户任务，不是“可能有用”的按钮；
- 核心算法可脱离 UI 测试；
- Maya 修改进入 Undo/事务边界；
- 有空选择、坏命名、缺节点、引用场景和大场景处理；
- 有 preview 或清晰的不可逆提示；
- 有最小场景、黄金结果和至少一个失败测试；
- 记录复杂度与性能预算；
- Maya 2025 的宿主结论有实际 mayapy 与 GUI 验证；
- 文档不把占位、禁用或未经验证的能力写成已完成。

## 8. 第一性成功指标

- 绑定构建可重复、可增量、可解释，失败不会留下未知半成品；
- 复杂权重/重定向任务相对手工流程显著减少时间，同时误差可量化；
- 动画师能在视口内理解和修正结果，而不是依赖黑箱脚本；
- 工具在生产场景规模下仍保持交互响应，并能定位性能瓶颈；
- 新功能通过数据模型和算法内核组合，而不是继续复制 UI 与 `cmds` 代码。

## 9. R1 快速开发记录

### 2026-08-25 — Hero Slice 01：Live Character Capture

已落地：

- 新增 host-independent `CharacterSnapshot` / `NodeSummary` domain model；
- 新增只读 Maya adapter，从任意深层级选择识别角色根、namespace、reference、
  joint、mesh、NURBS control 与 skinCluster；
- namespaced 角色位于公共资产容器下时，以 namespace 边界隔离角色，避免扫描整场；
- Maya `SelectionChanged` callback 有显式 start/stop 生命周期并带 UI 防抖；
- 主界面替换为 Kinetic Holographic Character Workspace：动态轨道、角色骨架舞台、
  live inspector、结构评分和状态反馈；
- 旧 Rigging / Face / Skinning / Animation / General 延迟加载并保留故障隔离。

验证证据：

- CPython 离线单元测试 10 项通过；
- Maya 2025 `mayapy` 构造真实 DAG 场景后，深层级与 namespace 根识别通过；
- Maya 2025 bundled PySide6 6.5.3 中，窗口创建、状态投射、程序化绘制和完整字体截图通过；
- Maya 2025 真实 GUI 中，workspaceControl、宿主字体、重复启动、热重载和关闭清理通过。

下一批最高价值工作：

1. 让 Character Capture 进入可固定、可切换的多角色 session，而非只跟随选择；
2. Living Rig Canvas 增加节点点击回写 Maya selection、层级折叠和模块健康度；
3. Deformation MRI v0：skinCluster 权重异常的只读诊断与热力可视化；
4. 建立 Guide 对称/关节方向诊断的第二条 plan-preview-apply-verify 工作流。

### 2026-08-25 — Hero Slice 02：Character Link Transaction

已落地第一条完整 `plan → preview → apply → verify → undo` 写操作：

- 角色注册生成不可变 `CharacterRegistrationPlan`，逐项描述 attribute、当前值、
  目标值和数据类型；预览阶段不触碰 Maya 场景；
- 引用角色、消失的根节点和已有冲突 ID 会在计划阶段阻断；
- 应用阶段写入 `mayacraftCharacter`、`mayacraftCharacterId` 和
  `mayacraftSchemaVersion`，所有写入处于单一命名 Undo chunk；
- 写后独立读回三个属性，任何异常或验证失败都会撤销整个 transaction；
- 重复注册是 no-op，不产生冗余 undo 或重复属性；
- 扫描器优先采用已注册稳定 ID，角色身份不再仅依赖本次 Maya UUID hash；
- UI 新增动态 Change Capsule，展示零写入预览、逐项 CREATE/UPDATE、blocked、
  verified、scene-safe rollback 与 Undo 状态；成功后舞台信号由 cyan 切换为 lime。

新增验证证据：

- 离线单元测试增至 10 项，覆盖 plan/no-op/blocker/state threshold；
- Maya 2025 mayapy 覆盖 apply、读回 verify、幂等、整块 undo 与 ID conflict；
- Maya 2025 bundled PySide6 端到端覆盖 UI preview → adapter transaction →
  scanner recapture → verified UI state，并生成完成态截图；
- PySide6 覆盖 Change Capsule 动画展开和目标高度，截图无溢出。

### 2026-08-25 — Hero Slice 03：Living Rig Projection v0

- `CharacterSnapshot` 新增 host-independent `RigNode` 图，记录 joint/control、直接父级、
  world position、左右侧和选择态；
- Maya scanner 每次 capture 从真实 DAG 生成最多 200 joints + 80 controls 的轻量图；
- Character Stage 根据实际 X/Y/Z 位置动态归一化，不再默认绘制与场景无关的火柴人；
- joint parent edge、left/right/center、control ring 和 selected pulse 使用独立视觉语义；
- 角色注册成功后实际 skeleton 与主 orbit 同步切换为 lime signal，形成可见的事务反馈；
- 空层级、全零坐标或仅有单节点时继续使用抽象 fallback，避免舞台崩坏。

Maya 2025 集成截图已使用真实 17-joint 双侧骨架，证明舞台图形来自 Maya DAG，
而非测试夹具直接注入的 UI 假数据。

视觉回归同时覆盖 980×760 浮动工作区和 720×520 窄停靠尺寸；窄尺寸保持主舞台，
Inspector 自动转为纵向滚动且禁止横向漂移，Change Capsule 不通过缩小字体规避空间问题。

### 2026-08-25 — Maya 2025 真实 GUI 生命周期验收

新增 `tests/run_maya2025_gui_validation.ps1`，通过 Maya `-script` 在隐藏的全新 GUI 进程中执行：

1. 初次创建真实 `workspaceControl`；
2. 重复 `launch.run()` 并验证旧 selection callback 已清理；
3. `launch.run(development=True)` 热重载并验证第二代 callback 已清理；
4. 捕获真实宿主截图；
5. `launch.close()` 后验证 callback ID 归零且 workspaceControl 不存在；
6. 写入结构化 JSON 报告并自动退出 Maya。

当前 Maya 2025 / PySide6 报告 `passed: true`。完整要求级审计见 `HERO_PROTOTYPE_AUDIT.md`。

### 2026-08-25 — R2 Slice 01：Living Rig Canvas 真实交互

Living Rig Projection 已从“只展示”推进到可操作的 Maya 导航界面：

- 新增 host-independent `ProjectedRigNode`、屏幕投影和 nearest-hit-test 内核，
  算法不依赖 Qt/Maya，可直接做确定性单元测试；
- Canvas 开启连续鼠标追踪，最近节点以高能光晕、十字标记和浮动名称 HUD 响应；
- 点击节点通过独立 Maya selection adapter 写回真实长路径，写后立即读回验证；
- Maya `SelectionChanged` callback 继续作为唯一宿主同步入口，点击后的快照会自动重捕获，
  Canvas 与 Maya Outliner/Viewport 选择态形成双向闭环；
- selection adapter 只执行导航，不修改场景数据；不存在的 DAG 路径会明确失败，不静默吞错；
- `CharacterStage.hit_point()` 提供只读测试探针，使 Maya 2025 QtTest 能在真实投影坐标上
  模拟移动和点击，而不是调用内部 slot 伪造成功。

验证证据：

- CPython 离线测试增至 11 项，覆盖多平面投影、深度缩放与最近命中；
- Maya 2025 mayapy 在真实 17-joint 双足 DAG 上验证 selection adapter；
- Maya 2025 PySide6 QtTest 实际移动到 `L_wrist_JNT`、显示 hover HUD、点击写回 Maya，
  等待 callback 后验证对应 `RigNode.selected == true`；
- 集成截图 `tests/artifacts/mayacraft_maya2025_verified_workspace.png` 保留 hover 与
  transaction verified 的同屏证据。

当前投影构建与 hit-test 都是 `O(N)`；扫描器硬上限为 200 joints + 80 controls，
因此本阶段预算为 280 节点下单次指针交互不超过 8 ms。超过该规模后再依据 benchmark
决定是否引入 uniform grid，而不是预先增加索引复杂度。

下一步进入 Character Session：发现并固定多个已注册角色，在顶部构建可切换的动态角色轨道，
切换动作仍以真实 Maya 角色根和 selection callback 为事实来源。

### 2026-08-25 — R2 Slice 02：Character Orbit Session v0

- 新增 host-independent `CharacterSession`，以稳定 ID 合并场景发现、当前角色与本次会话固定项；
- 已链接角色通过 Maya metadata 只读发现，扫描已知根时不改变 Maya selection；
- 未链接角色只在当前或被明确固定时进入 session，离开后不会无限积累失效条目；
- 顶栏 Character Orbit 最多同时呈现五个角色信号，活动项持续脉冲，linked / transient / pinned
  使用不同视觉语义；同名角色自动加入 namespace，避免常见的 `CHARACTER` 重名歧义；
- 点击角色信号只选择真实 DAG 根，现有 `SelectionChanged` callback 负责重新捕获和界面切换；
- 集成测试在 Maya 2025 中完成“固定未链接角色 → 切换到第二个已链接角色 → callback 验证 →
  返回固定角色 → Canvas 选取手腕 → 注册并重新发现”的完整路径。

场景自动发现只在启动、人工 Capture 和注册成功后执行；高频 SelectionChanged 不全场重扫，
只重捕获当前角色并复用 discovery cache，避免把多角色支持变成每次点击的场景级成本。

Living Rig Canvas 下一块将补齐层级折叠与模块健康度；随后进入 Deformation MRI v0 的
skinCluster 只读数据面、异常评分和热力视觉原型。

### 2026-08-25 — R2 Slice 03：Rig Module Spectrum / Living Rig Canvas 1.0

- 新增纯算法 Rig 语义层，将 joint/control 归入 Core、Head、Arms、Hands、Legs、Feet、
  Controls 与 Other，不依赖特定 rig framework；
- 模块健康度解释左右数量不平衡与捕获外父链，按节点数加权形成整体结果；
- Canvas 顶部 Module Spectrum 实时显示各模块分数，hover 展开首要 finding；点击后只保留
  目标模块与祖先链，非目标上下文降亮，Esc 返回完整图；
- 结构捕获增加 0.75 秒短期 topology cache，高频 SelectionChanged 仍更新位置和选中态，
  但不会为连续 Canvas 点击重复做完整 descendants/type discovery；人工 Capture 显式失效缓存；
- 280 节点 `project + nearest hit` 实测均值 **0.3062 ms**，低于 8 ms 交互预算。

至此 Living Rig Canvas 1.0 的真实层级、左右侧、选择态、hover/click、Maya 双向同步、
模块聚焦/健康度、多角色固定/切换、callback 防抖与缓存均已形成可运行闭环。

### 2026-08-25 — R3 Slice 01：Deformation MRI v0

数据与算法：

- 使用 Maya API 2.0 `MFnSkinCluster.getWeights`，以 4096 顶点为默认 batch 读取完整权重场；
- host-independent 算法逐顶点计算 weight sum、活跃 influence 数、dominant influence/index、
  normalized Shannon entropy、低权重碎片、未绑定与未归一信号；
- adapter 同时检查 influence `liw` 锁定状态和 skinCluster matrix 空洞；
- 综合热度保留每项 finding，不把分数变成无法解释的黑箱；
- 100,000 顶点 × 8 influences 的纯算法扫描实测 **522.859 ms**，结果写入
  `tests/artifacts/domain_benchmark.json`。

视觉与交互：

- 左侧 `D` 打开专用 Deformation MRI 工作区，不复用旧 Skinning 表格；
- Vertex Field 使用动态扫描线、发光热柱、hover 精确读数和异常详情；
- 点击热柱选择真实 `mesh.vtx[index]`，组件选择仍能被 Character Capture 正确解析回角色根；
- 980×760 与 720×520 均生成真实 PySide6 截图；窄停靠状态没有横向滚动或控件裁切。

修复 transaction：

- Normalize Repair 只修复 `sum > 0` 且误差超过 tolerance 的权重向量；未绑定顶点、碎片清理、
  influence 限制等需要艺术判断的操作保持只读；
- preview 保存精确 before/after，零写入，并设 5000 顶点交互安全上限；
- apply 前重读 influence 顺序和每个 before vector，场景在预览后漂移则拒绝执行；
- sparse 写入位于单一 `MayaCraft Deformation MRI Normalize` Undo chunk；写后使用 API 重读验证，
  失败自动 undo；
- Undo 后再次重读并证明原权重向量恢复。真实测试把 `vtx[0]` 的 sum 从 0.5 修复到 1.0，
  验证 Hotspots/Sum Errors 归零，再 Undo 回 0.5。

证据：离线测试 19 项、Maya 2025 mayapy scanner/repair、PySide6 多角色+Canvas+MRI 集成流程、
真实隐藏 workspaceControl 生命周期全部独立运行。下一阶段进入 Motion Magnetism：先建立轨迹、
速度、加速度、jerk、弧长与接触区间的纯算法数据层，再做 viewport ghost/trajectory 交互原型。

### 2026-08-25 — R4 Slice 01：Motion Magnetism / Ghost Trajectory

已完成第一条真实 Animation Intelligence 数据链，但这只是 Motion Magnetism 的开端，
不代表 R4 或项目完成。

数据与 Maya adapter：

- host-independent `MotionSample / MotionSignal / MotionAnalysis / ContactInterval`；
- 支持非均匀时间的中心差分速度、加速度和 jerk，以及累计三维弧长；
- 四元数比较使用 `abs(dot)` 消除 `q/-q` 表示翻转，再独立标记真实角度跳变；
- 接触推断联合速度、离地高度、锚点漂移与持续时间，并输出 0–1 confidence；
- Maya 2025 adapter 通过 `worldMatrix[0]` 的 time context 采样，不调用 `currentTime` 扫帧，
  因此不会在艺术家时间线上闪动；当前帧在扫描前后保持不变；
- 单次交互限制 1200 samples，坏范围、空选择和非 transform 来源明确失败。

原生 Maya UI：

- `MotionMagnetismWorkspace`、`MotionFieldCanvas` 均为 PySide6 `QWidget`；所有轨迹、Ghost、
  网格、扫描光、HUD 和接触时间带由 `QPainter` 绘制；
- 电青→紫→洋红轨迹表达时间方向，薄荷绿表达接触，琥珀表达旋转跳变，洋红 spike 表达高 jerk；
- hover 显示 frame / velocity / acceleration / jerk / arc，接触样本显示 confidence；
- 点击真实投影样本调用 Maya 时间导航并读回验证；
- 覆盖空选择错误态、success、hover、active，以及 980×760 和 720×520 两种 dock 尺寸。

验证：离线测试增至 23 项；Maya 2025 mayapy 在 25 帧动画上得到 18.251 单位弧长、
2 个接触区间和 1 个旋转跳变，并证明扫描未改变当前第 13 帧；PySide6 交互测试点击
第 10 个投影信号后 Maya 定位到对应帧；隐藏 workspaceControl 生命周期继续通过。

下一批 Motion Magnetism 工作不是再加静态指标，而是建立 baseline/candidate 空间误差对比、
接触保持评价和用户可修正的 Anchor 意图，再进入非破坏 Animation Layer 预览事务。

### 2026-08-25 — R4 Slice 02：Motion Baseline / Candidate Field

- 新增纯算法 `MotionComparison`，严格要求 sample count 与 frame identity 对齐；
- 逐样本计算 position error、velocity error、quaternion angular error、baseline contact 是否保持；
- 汇总 RMS / maximum position error、RMS velocity error、maximum angular error、arc-length delta
  和 contact preservation ratio；
- Motion 工作区的 `SET BASELINE` 明确记录用户要保持的世界轨迹；修改动画、切换空间或运行外部
  retarget 后再次 Capture，即得到 candidate 对比，不需要工具先假设用户意图；
- Canvas 用虚线绘制 baseline，用琥珀误差 spoke 表达空间偏移；如果 baseline contact 被破坏，
  spoke 升级为红色；误差最大的采样点自动获得更强信号；
- Maya 2025 PySide6 测试锁定 baseline 后把第 13 帧 Y 改动 2 个单位，candidate 捕获正确报告
  maximum position error ≥ 1.99，并生成同屏误差场截图。

下一步：把 baseline contact 转换为可编辑 Anchor 意图，预览每帧世界空间补偿及影响时间波纹；
实际写入必须使用独立 Animation Layer、命名 Undo chunk、写后重采样验证和完整 rollback。

### 2026-08-25 — R4 Slice 03：Contact Anchor Animation Layer Transaction

- `plan_contact_anchor` 把用户选中的 baseline contact 转换为不可变 `ContactAnchorPlan`；
- 接触段内部 influence 为 1，段外按指定 sample 数形成时间 falloff，预览保存 expected、target、
  world delta 与 influence，不依赖 UI 状态猜测；
- Canvas 用补偿矢量和脉冲目标环显示逐帧影响，contact 内为 mint，falloff 为 violet；
- Maya adapter 将 world delta 乘 parent world inverse 转为 parent-space additive translate，支持有父级控制器；
- 写入独立 `MayaCraft_Anchor_*` additive Animation Layer，并使用 `setKeyframe(noResolve=True)`
  直接写 layer delta，避免 Maya 把期望结果再次 resolve 成错误值；
- transaction 使用单一 `MayaCraft Contact Anchor` Undo chunk；应用前重采样 expected position，
  防止 preview 后场景漂移；应用后重采样每个 target，超 tolerance 自动 undo；
- Undo 后验证 Animation Layer 已消失，并逐帧确认 candidate expected position 恢复；
- 引用节点、锁定 translate、同名 layer、节点消失与 baseline/candidate 不匹配均明确阻断。

Maya 2025 实测把破坏的 F1–F6 接触从 50% preservation 恢复到 100%，8 个受影响样本的
maximum world error 为 `0.0000`；UI 同时保留 Undo 入口。此能力仍只校正 translation，
旋转 contact、constraint/space switch 自动构建、FK/IK chain compensation 将在后续 Motion/R4 继续。

### 2026-08-25 — R2 Slice 04：Declarative Rig Graph Compiler Core

旧 `RigBuilder` 会捕获任务异常后继续执行，并最终打印 `BUILD COMPLETE`；新路径不再把它作为
可信构建内核。本批建立独立、host-independent 的声明式 Rig Graph：

- 版本化 `RigGraphSpec`、`RigModuleSpec`、`RigSocketSpec`、`RigConnectionSpec` 和 `RigNodeSpec`；
- 每个节点拥有稳定 ID、owner module、control/deform/delivery/meta layer、声明属性与父稳定 ID；
- 验证 module/node ID 唯一性、依赖缺失、module/node cycle、owner、layer 及 socket 类型/方向；
- 确定性拓扑排序和增量 diff，区分 CREATE、PRESERVE、REPARENT、RENAME、UPDATE、REBUILD、REMOVE；
- `golden_biped_graph` 首版包含 Root、Spine、Head、双臂、双腿共 7 modules / 19 declared nodes，
  并显式表示 body/chest/shoulder/hip socket 连接；
- Maya adapter 仅扫描带 MayaCraft graph/node metadata 的自有节点，不通过名字猜测全部意图；
- build preview 保存完整 observed fingerprint；预览后任何名字、类型、父级、owner、layer 或 signature
  漂移都会拒绝执行；
- apply 在单一 `MayaCraft Incremental Rig Build` Undo chunk 内增量创建、迁移或删除自有节点，
  写后重新扫描并要求整个 diff 只剩 PRESERVE；失败自动 undo；
- Undo 后用完整 observed fingerprint 验证之前图状态恢复；引用节点的变更会在 plan 阶段阻断。

Maya 2025 mayapy 已验证：空场景 19 个 CREATE → 全图 PRESERVE；整块 Undo 回到零节点；
重新 Build 后人为破坏 Head 父级得到 REPARENT，修复并验证，再 Undo 恢复破坏态；预览后重命名节点
触发 stale-plan 拒绝。下一步是 Guide/Skeleton adapter、可视 Rig Diff 工作区和真实双足黄金场景，
随后逐模块替换旧 FK/IK/Space/Twist/Bendy builder。

### 2026-08-25 — R2 Slice 05：Semantic Skeleton / Native Rig Graph Workspace

本批把 Rig Graph 从声明文件推进到 Maya 2025 内的可见、可验证工作流：

- 新增 host-independent `JointObservation / SemanticJoint / SkeletonAnalysis`，联合名称 token、层级、
  归一化高度、中心面与 world X 几何证据推断 pelvis/spine/chest/head 与双侧 limb 语义；
- 每个语义结果保留 confidence 和 evidence；多根、必需中心语义缺失、候选歧义、左右缺对、低覆盖
  均形成可定位 issue，不把猜测伪装成确定标签；
- Maya adapter 从任意已选 joint 向上定位根，再只读捕获最多 512 个 joint 的完整父链、world matrix、
  quaternion orientation 与 child count；扫描不改变 Maya selection 或 currentTime；
- 黄金双足场景以 18 个真实 Maya joint 验证 18 个语义结果与 100% 对称度；
- `bind_graph_to_skeleton` 把已验证的 source joint、semantic role、world position 和 quaternion 编译进
  对应 Spine/Head/FK/IK 控制节点 signature；build 后控制器不是堆在原点，而是落到语义骨架空间；
- Maya transaction 写入 `mayacraftSourceJoint` 追踪来源，并在父级建立后应用声明的 world transform；
  写后仍要求完整 Rig Graph 只剩 PRESERVE，Undo 仍验证整个之前状态；
- 新增 `RigGraphWorkspace + RigGraphCanvas`，全部使用 Maya PySide6 QWidget/QPainter：动态 typed-socket
  连线、流动 packet、扫描光、模块 hover/focus、action 风险颜色、零写入 diff、Apply/Verify/Undo；
- 1120×760 和 760×620 原生截图通过；窄布局自动收缩 arm/leg graph spread，没有模块裁切。

真实 Maya 2025 UI 测试从所选 `L_hand_JNT` 捕获骨架，预览 19 个 CREATE，构建后验证
`L_hand_IK_CTRL` world position 为 `(11, 17, 0)` 且 source joint metadata 正确，再 Undo 回到零 graph nodes。
当前离线测试 35 项。下一阶段进入模块执行层：Guide 编辑、FK/IK chain、Space Switch、Twist/Bendy，
同时继续 Skin、Retarget 与 Face 的新架构，项目 `/goal` 仍保持 active。

### 2026-08-25 — 产品语言纠偏：国内企业展示默认中文

- MayaCraft 的目标展示对象明确为国内企业面试官与中文用户，简体中文成为主界面语言；
- Maya、PySide6、FK/IK、RBF、Jerk、Pose、skinCluster、节点名等必要行业术语保留，不再用大面积
  英文全大写制造“科技感”；
- Character、Motion、Deformation MRI、Rig Graph、事务状态、错误提示、Legacy 标签与工具按钮已统一
  中文化，并按中文长度重新检查窄 Dock；
- Maya 离屏 Qt 不会可靠回退 CJK 字体，因此新增 `ensure_ui_font()`，显式注册系统微软雅黑并让
  QWidget stylesheet 与所有 QPainter Canvas 使用同一字体；中文方框问题以真实截图闭环验证；
- 同一原则已写入 Codex 全局 frontend Skill 与 Obsidian 源 Skill：产品语言服从目标市场，国内展示
  默认简体中文，禁止无依据的整片英文或装饰性双语堆叠。

### 2026-08-25 — R3 Slice 02：Skin Mirror / 语义与空间双重配对

- `InfluenceMirrorMap` 先移除 L/R/Left/Right token 得到 canonical name，再用镜像世界坐标验证；
  无可靠命名时使用空间最近邻回退，并输出 method、distance、confidence、歧义与未配对诊断；
- `plan_skin_mirror` 使用空间哈希在近线性复杂度下配对对称顶点，严格区分左到右/右到左；
- 权重向量通过 influence map 重排，中心 influence 保持自身；带权重但未配对的 influence、超过 5%
  未匹配顶点、向量维度错误、重复索引与超过 5000 项交互上限均阻断；
- Maya adapter 读取真实 MFnSkinCluster 权重、影响骨骼矩阵和 MFnMesh 世界坐标；引用资产、锁定
  influence 明确阻断；preview 后权重、拓扑或配对漂移会拒绝 apply；
- 写入单一 `MayaCraft Skin Mirror` Undo chunk，逐目标向量写入，API 读回验证；失败自动 Undo；
  显式 Undo 后再次读回并证明目标侧 before vector 恢复；
- Deformation MRI 新增中文“对称迁移”动态 Capsule、方向选择、零写入摘要、置信度、未匹配统计、
  目标顶点薄荷绿轮廓及 Apply/Verify/Undo 状态；
- Maya 2025 黄金四边形测试验证 2 个顶点权重镜像、stale preview、locked influence、读回与撤销；
  中文 UI 宽屏截图 `mayacraft_skin_mirror_preview_cn.png` / `verified_cn.png` 已生成。

这仍不是 Skin/Deformation 完成态。下一批继续网格空间热力投影、局部刷选、拓扑签名与权重迁移回归。

### 2026-08-25 — R3 Slice 03：网格空间热力场 / PCA 与局部刷选

- Deformation MRI 结果现在携带 `MFnMesh.getPoints(kWorld)` 的真实世界坐标和三角拓扑，不再只把
  顶点序号画成统计柱；读取仍与 skinCluster 权重共用一次只读扫描，不改变选择或场景；
- 新增 host-independent `DeformationFieldProjection`：由 3×3 协方差、确定性 power iteration、
  正交化与稳定符号得到主平面和深度轴，把任意朝向网格投影到归一化二维场；
- 修复严格平面网格的退化协方差：第二主轴按剩余协方差能量初始化，而不是在等长候选中误选
  零方差法线；专门回归证明 Maya 默认 XZ polyPlane 不会再塌成一条线；
- 大网格按完整三角面抽样而不是按顶点步长抽样，避免过滤后失去全部表面；热度 ≥ 0.12 的异常点
  无条件保留，既保持曲面可读性，也不会因性能降采样丢失 hotspot；
- 原生 QPainter 热力场按 depth 排序绘制三角面、热度填色、网格边、动态扫描线、hotspot glow、
  mirror target 与 hover HUD；没有位置数据时才回退旧热柱模式；
- `Shift + 拖拽` 以投影空间半径实时圈选顶点，释放后一次性写回真实 Maya component selection；
  12×12 平面测试一次刷选 6 个顶点，并在底部状态条读回确认；
- 100,000 顶点投影、热点保留与约 198k 三角输入实测 **408.969 ms**，输出 12,816 个可视顶点和
  4,093 个完整三角，低于 850 ms 首次构建预算；离线测试增至 43 项。

证据截图：`tests/artifacts/mayacraft_mri_spatial_brush_cn.png`。下一批继续 dominant/entropy/
locked/missing influence 的可切换 Inspector、拓扑签名与权重迁移回归；之后进入 Animation/Retarget，
整个 `/goal` 继续 active。

### 2026-08-25 — R3 Slice 04：多维诊断光谱 / Influence Inspector

- 新增 host-independent `InfluenceWeightDiagnostic / DeformationInspectorReport`，逐 influence 统计
  affected vertices、dominant vertices、累计权重、最大权重与锁定状态；批次分析可流式合并，
  不为界面长期复制十万级稠密权重矩阵；
- Inspector 同时输出高混合熵顶点、低主导权重顶点、带锁定权重的顶点集合，以及具体缺失
  `skinCluster.matrix[*]` 槽位；批次宽度或 influence 顺序漂移会明确失败；
- 原有 PCA 网格场升级为四种实时观察模式：综合异常热度、主导骨骼分区、混合熵扩散场、锁定
  influence 覆盖场；切换模式直接重着色同一份真实拓扑，不重新扫描 Maya；
- 新增原生 QPainter Influence Spectrum：柱高表达累计权重，白色水平标线表达主导占比，橙色顶线
  标记锁定；hover 显示中文精确统计，点击 influence 会聚焦其主导区域并回选真实 Maya joint；
- 锁定模式摘要显示锁定影响数、覆盖顶点数和 matrix 空洞数，完整缺失槽位进入 tooltip；
- 620px 高窄 Dock 使用结构性紧凑态：收起说明副文案与 metric caption、缩短光谱但保留全部模式、
  Apply/Verify/Undo 和诊断数据，不采用全局缩小字体；
- Maya 2025 黄金场景包含 169 顶点、1 个锁定 influence 与真实 `matrix[7]` 空洞，验证四模式、
  influence 回选、7 个顶点局部刷选以及宽/窄中文截图；隐藏 workspaceControl 重载与清理继续通过。

当前离线测试 44 项；100,000 顶点投影最新实测 **399.411 ms**。证据截图：
`mayacraft_mri_entropy_cn.png`、`mayacraft_mri_locked_cn.png`、
`mayacraft_mri_inspector_narrow_cn.png`。下一阶段进入 Skin 拓扑签名/迁移回归及 Animation/Retarget
数据层；这仍不是 Deformation 或项目完成态。

### 2026-08-25 — R4 Slice 04：Pose / Clip Schema 与语义重定向预览内核

本批开始替换旧 Animation 页的短名 JSON 与静默命令包装，但尚未把旧页视为已迁移完成。

Pose / Clip 数据层：

- 新增版本化 `PoseNode / PoseFrame / PoseAsset / ClipAsset`，同时保存本地 translation、最短弧
  quaternion rotation、scale、世界 translation/quaternion、父语义键和确定性排序的自定义标量通道；
- `mayacraft.pose` / `mayacraft.clip` schema 均提供严格读回、版本拒绝与稳定 SHA-256 fingerprint；
- Clip 验证帧号严格递增，并要求每帧节点顺序、父键和自定义通道拓扑一致，防止中途少控制器或
  属性变化被静默写成坏资产；
- Pose 混合对位移、缩放和自定义标量做插值，对旋转使用处理 `q/-q` 的 quaternion SLERP；
  Pose Difference 输出世界位移/旋转 RMS 与最大误差及双侧缺失键；
- Maya 2025 adapter 通过 API 2.0 `MDGContext(MTime)` 读取指定帧的 transform plug、worldMatrix
  与动态 keyable 通道，不调用 `currentTime` 扫帧；一次最多 512 节点、120,000 节点帧采样，短名
  去 namespace 后冲突会明确阻断；
- mayapy 验证 2 控制器 × 3 帧和 `fingerCurl` 通道，捕获前后当前第 3 帧与 Maya selection 完全不变，
  世界姿态差异正确得到 5.099 单位 / 90°，Pose/Clip JSON fingerprint 往返一致。

语义重定向预览：

- `RetargetProfile` 用两侧 `SkeletonAnalysis` 的语义角色配对，不依赖同名骨骼；每项保留 source、
  target、confidence 和 evidence，关键语义缺失、共享语义不足及低置信度会显式诊断；
- 骨架包围尺度得到 source→target 比例，`RetargetPosePreview` 将源姿态相对参考姿态的世界位移增量
  按比例映射，并把世界 quaternion delta 组合到目标参考姿态；全程只生成 Ghost 数据，不写目标 Rig；
- Maya 2025 双骨架黄金场景使用 1× 与 2× 比例、不同 namespace，共识别 18 个语义映射，比例 2.0、
  置信度 0.787；源骨盆移动 1 单位得到目标 Ghost 2 单位，左手 45° delta 保持 45°；目标骨架矩阵、
  时间线和 selection 逐项证明零变化。

当前离线测试 49 项，新增 `mayapy_pose_clip.py` 与 `mayapy_retarget_preview.py` 均通过。下一批要把
Profile/Ghost 变成中文原生 Animation & Retarget 工作区，加入映射置信度场、源/目标骨架双轨、
Clip 时间带和非破坏 Animation Layer 预览事务；不能把当前世界增量 Ghost 当作完整 IK 重定向。

### 2026-08-25 — R4 Slice 05：原生双骨架 Retarget Ghost 工作区

- 主 Mode Rail 新增中文“映”入口，工作区继续使用 Maya 2025 原生 QWidget/QPainter，不复用旧
  Animation Tab，也不嵌入网页；
- 工作流要求用户分别捕获源/目标骨架参考姿态，随后才允许生成当前源姿态 Ghost；没有可用语义映射
  时 Preview 保持 disabled，不提供未连接的 Apply 占位按钮；
- 中央 Retarget Stage 将源紫色骨架与目标电青骨架并排投影，18 条 semantic mapping 用动态虚线与
  流动 packet 表达；低置信连接转为琥珀色，hover 显示角色语义和精确 confidence；
- 目标 Ghost 使用薄荷绿虚线骨架、脉冲关节与 reference→preview delta spoke；指标区实时显示映射数、
  总置信度、骨架比例和待确认问题；
- 点击任意映射中点会一次回选真实 Maya 源/目标关节，主状态条读回选择结果；
- 1120×760 与 760×620 中文截图通过。窄 Dock 将中文标题和动作区拆成两行，保持完整标题与按钮点击
  面积，不通过缩小字体硬塞；
- Maya 2025 UI 黄金场景验证 18 个映射、1.65× 比例、79% 置信度、52° 最大旋转增量和目标骨架
  全矩阵零变化；新增 QTimer/信号后，隐藏 workspaceControl 的首次启动、重复清理、development
  hot reload 与 close cleanup 全部通过，用户 Maya PID 30492 始终未被连接或修改。

证据截图：`mayacraft_retarget_ghost_cn.png` / `mayacraft_retarget_ghost_narrow_cn.png`。下一批继续
Clip 时间带、逐帧 Ghost、接触保持/根运动偏差和真正的 Animation Layer preview/apply/verify/undo；
完整 FK/IK / Full Body 求解仍未完成，项目 goal 保持 active。

### 2026-08-25 — R4 Slice 06：Clip 时间带与 Retarget Animation Layer 事务

逐帧分析：

- `RetargetClipPreview` 对源 Clip 每帧生成目标 Ghost，并输出比例化 root motion、最大旋转增量、
  平均映射置信度和双脚接触诊断；
- 接触检测按源骨架尺度自适应速度/漂移阈值，分别记录 source drift、ghost drift、confidence 与
  preserved；工作区时间带以紫色柱表示根运动、电青线表示旋转增量、绿色/红色区表示接触保持结果；
- 点击时间带采样会同时切换 Ghost 与 Maya 当前帧；只有显式点击才调用 `currentTime`，Clip 捕获和
  Preview 继续使用 API 2.0 DG Context，不闪动时间线；
- 120 帧 × 18 语义的 Clip Ghost + Layer plan 纯算法实测 **35.998 ms**，低于 120 ms 预算。

非破坏事务：

- `RetargetLayerPlan` 为每个必要节点帧保存目标 baseline local translation/quaternion 与 desired 值；
  只写语义关节旋转，translation 仅允许 root/pelvis，禁止用逐关节平移伪造 Ghost、破坏骨长；
- desired rotation 使用 source local quaternion 相对参考姿态的 delta 组合到 target reference；根运动
  按骨架比例缩放；无变化节点帧不进入计划，50,000 节点帧为交互安全上限；
- Maya adapter 检查引用节点、已锁定通道、缺失通道和同名 Layer；Apply 前按每帧重新采样 baseline，
  Preview 后目标场景漂移会拒绝执行；
- 写入单一 `MayaCraft Semantic Retarget` Undo chunk 和独立 Override Animation Layer；按目标
  rotateOrder 将 quaternion 转为 Euler key，写后重新采样 local translation/quaternion；超过
  `0.0001` 位移或 `0.02°` 旋转容差自动 Undo；
- Undo 后验证 Layer 消失，并逐节点帧证明目标 baseline 恢复；锁定旋转、stale target 与同名 Layer
  均有独立阻断路径；
- Maya 2025 黄金事务只写 4 个必要节点帧，读回最大位移/旋转误差均为 0；UI 流程覆盖 Clip 捕获、
  时间带点击、第 5 帧 Ghost、零写入计划、Apply/Verify/Undo 和两个保持的足底接触区间。

视觉与生命周期：

- 宽屏截图 `mayacraft_retarget_clip_layer_verified_cn.png` 显示接触带、根运动柱、旋转曲线和验证回执；
- 760×620 紧凑态将舞台降为 175px、时间带降为 54–60px，并隐藏重复 caption/说明，保留四个事务
  按钮；自动几何断言证明 Stage、Timeline 与 Capsule 不重叠；
- workspaceControl 首次启动、重复清理、development hot reload 和 close cleanup 再次通过；验证前后
  唯一用户 Maya PID 32232（无标题场景）保持存在且未被连接。

这仍不是完整 Full Body Retarget。下一批继续目标实际运动与 Ghost 的逐帧偏差、根方向/朝向、
旋转轴重定向校准、接触 IK/FABRIK 修正和 Clip 导出验证；随后继续 R2 未完成的声明式 FK/IK/
Space/Twist/Bendy 与 R3 拓扑迁移路线。

### 2026-08-25 — R4 Slice 07：旋转轴校准、真实结果偏差与接触 IK 场

旋转轴与动画层边界：

- Layer 计划不再把源关节通道 quaternion 直接复制给目标。它从目标参考 world/local 总旋转反推出
  `jointOrient` 等静态轴偏移，再把 Ghost world intent 转换回目标自己的 rotate-channel quaternion；
  Maya 2025 `jointOrientY=35°` 黄金场景证明通道值与源 Z 旋转不同，但最终世界旋转与 Ghost 一致；
- root/pelvis 的 Ghost 世界位移也先经过目标父级世界旋转反变换，得到目标 parent-local translation，
  避免父级朝向不同时根运动方向错误；
- 修复 Override Animation Layer 的首尾外推污染：只要某个语义通道在 Clip 任意帧发生变化，就保留
  该通道完整采样边界键，包括差值为零的首帧；全程不变通道仍完全不写。真实 UI 回归捕获并消除了
  首帧左手 9.75° 的错误外推，动画层读回世界旋转最大误差恢复为 0°。

真实结果验证与 FABRIK：

- Apply 后重新捕获目标实际 Clip，并逐帧比较目标结果与 Ghost world translation/quaternion；时间带以
  红色误差针显示实际偏差，回执同时给出最大世界旋转误差、最大位置误差和接触保持率；
- 新增 host-independent FABRIK 内核：支持任意链迭代、两骨 pole 精确解析、不可达伸展、长度保持、
  收敛次数与末端误差；退化零长度链明确拒绝；
- `RetargetContactIKPreview` 从 Ghost 接触区间建立脚底锚点，并以目标实际髋/膝/脚位置逐帧求解；
  当前为严格零写入预览，不改目标骨架或 Animation Layer；
- 原生 QPainter 舞台叠加红色虚线实际腿链、薄荷绿可达解、橙色不可达解与接触锚环。Maya 2025
  黄金场景中 4 个链帧精确收敛、6 个链帧因髋部横移超过腿长而诚实报告不可达，最大缺口 0.30281；
  点击“接触 IK”前后所有目标世界矩阵完全一致；
- 1120×760 中文截图 `mayacraft_retarget_contact_ik_preview_cn.png` 已生成；760×620 紧凑态把五个
  事务动作改为结构化中文短标签，仍保留完整点击面积和 Stage/Timeline/Capsule 不重叠断言；
- 离线测试 54 项通过；120 帧 × 18 语义的 Ghost + Layer plan 最新实测 **62.137 ms**，生成 240 个
  边界安全键，仍低于 120 ms 预算。

这一 Slice 只完成了单腿接触求解的零写入诊断，尚未把解转换成可靠的髋/膝旋转事务。下一批继续
双脚约束下的骨盆补偿、Full Body reachability、IK 旋转层 plan/apply/verify/undo 与 Clip 导出验证；
之后继续声明式 FK/IK/Space/Twist/Bendy、拓扑迁移和 Face/制作化路线，整个 goal 保持 active。

### 2026-08-25 — R4 Slice 08：双脚约束骨盆补偿与 Contact IK 动画层事务

全身可达性求解：

- 每个接触脚把“允许的骨盆世界位移”表达为以 `anchor - hip` 为中心、腿链总长为半径的凸球；
  多脚同时接触时使用确定性的 Dykstra 交替投影，求距离零位移最近的共同可达点，而不是分别移动
  两条腿、拉长骨骼或任意下压骨盆；
- 骨盆补偿后再次运行严格保长的两骨 FABRIK。黄金场景原有 6 个不可达链帧全部转为可达，10 个
  左右腿链帧末端误差低于 `1e-4`，最大骨盆补偿为 `0.303005`；
- 安全门槛限制骨盆补偿不超过最短活动腿链的 25%；双脚允许区域无交集、语义缺失、仍不可达或
  超过安全比例都会阻断写入，不把伸长结果包装成成功；
- 髋与膝使用最短弧 quaternion 将当前骨段方向对齐到 FABRIK 解；脚通道反向补偿父级旋转以保持
  原世界朝向。每个目标关节仍通过当前 parent world、local total 与 channel quaternion 反推出
  `jointOrient` 静态轴偏移，再转换成目标自身的 rotate-channel 值。

独立 Animation Layer 事务：

- 新增 `ContactIKLayerPlan / Key / AnchorTarget / Receipt`。骨盆只写 parent-local translation，髋、膝、
  脚只写 rotation；任何活动通道保留完整 Clip 边界键，非接触帧回到基础重定向结果；
- Maya adapter 创建独立 `MayaCraft_ContactIK_*` Override Layer，检查引用、锁定/缺失通道、同名层和
  预览后场景漂移；写入单一 `MayaCraft Contact IK` Undo chunk；
- 写后先验证每个节点帧的 local translation/quaternion，再从 API 2.0 DG Context 独立读回脚底世界
  位置。黄金场景 35 个节点帧最大脚底锚点误差为 `2.512e-15`，接触保持率从 0% 提升到 100%；
- 失败自动撤层；显式 Undo 验证 IK Layer 消失且基础 Retarget Clip fingerprint 恢复，再撤基础层可
  完整回到目标参考矩阵；漂移探针通过修改真实 Retarget Layer 键证明 stale plan 会拒绝执行；
- 修复 Maya 当前帧求值刷新：事务 Apply/Undo 后在不移动当前时间且不污染 Undo 栈的条件下 dirty
  并更新当前上下文，使视口、`xform` 与显式 DG Context 同步。

中文原生交互与证据：

- Retarget 工作区现在有两条分离的 Change Capsule：上层“基础语义重定向”，下层“求解骨盆与接触
  → 预览 IK 动画层 → 应用并验证 IK → 撤销 IK”；基础层在 IK 层存在时拒绝越级撤销；
- 舞台同时显示红色实际腿链、电青骨盆补偿链/方向箭头、薄荷绿保长解与脚底锚环；全部为 Maya
  2025 原生 PySide6/QPainter，无 HTML 或外部前端；
- 1120×760 完成态截图 `mayacraft_retarget_contact_ik_verified_cn.png` 与零写入预览截图
  `mayacraft_retarget_contact_ik_preview_cn.png` 已生成；760×620 使用两行中文短动作，自动几何断言
  证明 Stage、Timeline、基础 Capsule 与 IK Capsule 无重叠；
- 离线测试增至 55 项。120 帧、240 个双腿约束链帧的骨盆补偿 + FABRIK + 840 键计划实测
  **19.789 ms**，低于 80 ms 预算；基础 Retarget 120 帧计划 **67.525 ms**，低于 120 ms 预算。

接触 IK 的核心事务已经闭环，但完整 Animation/Retarget 路线仍未完成：下一批继续 Clip 文件导出/
导入与 schema 迁移、根朝向与地面法线、接触权重包络和用户修正入口；随后回到声明式
FK/IK/Space/Twist/Bendy、Skin 拓扑迁移、Face/PSD/RBF 与制作化路线，goal 继续 active。

### 2026-08-25 — R4 Slice 09：可迁移 Clip Package 与原子导入导出

- 新增 `mayacraft.clip.package/v1`：包内同时保存严格 `ClipAsset`、必需的参考 `PoseFrame`、稳定
  SHA-256 fingerprint、metadata 与 `migrated_from`，解决旧裸 Clip 无法知道动作相对哪一个参考姿态
  计算的问题；参考姿态与首帧的节点键、父语义和自定义通道拓扑必须完全一致；
- 读取拒绝未知 schema/version、缺失 fingerprint、篡改 payload、非法 NaN/Infinity、非 JSON 对象、
  空文件及超过 64 MiB 的资产；旧 `mayacraft.clip/v1` 只在明确允许时迁移，并标记
  `first-frame-reference`，不静默假装拥有原始 bind pose；
- `remap_clip_package_paths` 按便携节点键把资产路径重定向到当前捕获源骨架，缺少任何节点键都会
  阻断；UI 额外检查节点数、节点帧上限和资产参考骨架与当前源骨架的尺度差，避免载入错误角色；
- `ClipPackageStore` 在目标同目录写临时文件、flush + `fsync` 后用原子 replace 提交，再立即严格读回
  并比较 fingerprint；默认拒绝覆盖现有文件，返回绝对路径、字节数、指纹与验证回执；
- Retarget 基础事务条新增“载入资产 Clip”，与“捕获播放范围 Clip”明确分开；导入成功后直接生成
  零写入 Ghost/接触时间带，不需要把资产先烘焙回源 Maya 骨架；
- Contact IK 事务条新增“导出结果 Clip”，优先导出已验证 IK 结果，否则导出基础重定向结果；包内
  metadata 记录目标根、接触保持率和是否包含接触 IK；写后状态条显示文件名、字节数和指纹前缀；
- Maya 2025 UI 黄金场景实测载入同骨架源资产、完成双层事务、导出 85,752 bytes 结果包并严格读回，
  导出 Clip fingerprint 与内存 `corrected_clip` 一致；760×620 两条事务行各五个中文动作，无重叠、
  截断或英文占位文案；离线测试增至 56 项。

Animation/Retarget 仍需继续根朝向与地面法线、接触权重包络、用户锚点修正、跨骨架轴模板和更完整
Clip 浏览/版本迁移；随后继续 Rig Graph 声明式模块、Skin 拓扑迁移、Face/PSD/RBF 和发布制作化。

### 2026-08-25 — R4 Slice 10：坡面全身朝向、接触包络与可拖拽锚点

算法与数据：

- `ContactIKSettings` 统一保存单位地面法线、地面高度、0–30 帧过渡、左右脚用户偏移和根朝向开关；
  非法零法线、重复脚侧和越界过渡在进入 Maya 前由纯算法层拒绝；
- 接触区间前后使用 Smoothstep 权重包络，脚目标从当前世界位置连续插值到地面锚点；地面锚点先投影
  到推断平面再叠加动画师偏移，避免硬编码世界 Y=0；
- 根节点使用最短弧 quaternion 将角色上方向对齐地面法线，并按接触权重 SLERP 渐入；髋、膝、脚链
  以根枢轴同步旋转后再做共同骨盆补偿与 FABRIK，脚世界朝向也进入目标关节自身的轴系；
- 坡面根旋转、骨盆 parent-local 位移与双腿旋转统一进入 Contact IK Layer 计划。离线黄金场景验证
  45° 地面、0.5→1→0.5 包络、用户偏移和完整边界键，测试总数增至 57 项。

Maya 事务与交互：

- Maya 2025 真实 10° 坡面事务写入根朝向键，读回根上方向与法线点积大于 0.9999；35 个接触链帧
  最大脚底目标误差 `6.969e-15`，坡面层与基础层按顺序撤销后恢复；
- 原生 PySide6 调校条提供“过渡、坡度、地面、重置锚点”四个中文动作；舞台脚底绿环支持 hover、
  抓取光标和直接拖拽，拖动每一步都只重算 host-independent 预览并使旧计划失效，不写 Maya；
- UI 黄金场景在 8° 坡面直接拖动左脚锚点，证明目标矩阵零变化，再生成包含根节点的 40 个节点帧
  计划并完成 apply/readback/undo；验证后的 Clip Package 记录中文地面法线、地面高度、过渡帧和脚底
  偏移 metadata；
- 120 帧、240 个双腿链帧、10° 地面法线和左右脚用户偏移的完整预览 + 计划实测 **32.190 ms**，
  生成 960 个根/骨盆/腿节点帧，低于 80 ms 交互预算；
- 1120×760 与 760×620 截图已更新。窄 Dock 的 Stage、Timeline、调校条和两条事务 Capsule 均有
  自动几何顺序断言，用户可见动作、状态、错误与演示数据均以简体中文呈现；仅保留 Maya、Clip、
  Ghost、FK/IK 和真实节点名等行业术语。

Animation/Retarget 仍需跨骨架轴模板、批量 Clip 浏览、版本迁移与更完整 Full Body 控制；随后继续
Rig Graph 声明式 FK/IK/Space/Twist/Bendy、Skin 拓扑迁移、Face/PSD/RBF 与发布制作化，goal 继续
active。

### 2026-08-25 — R4 Slice 11：跨骨架轴空间模板与动态校准仪表

坐标基算法：

- 新增不可变 `RetargetAxisTemplate`，以带符号的 source/target forward + up 轴描述两个正交右手坐标
  基；拒绝未知轴、前向/向上平行、空 ID 和空中文名称；
- 内置同向、`+Z → +X`、`+X → +Z`、前向反转与 Z-up → Y-up 五种模板。算法由
  `targetBasis × transpose(sourceBasis)` 得到旋转矩阵并稳定转换为单位 quaternion；
- 源世界平移增量先按骨架比例缩放，再旋转到目标坐标基；源世界旋转增量使用
  `Qbasis × Qdelta × inverse(Qbasis)` 做共轭变换，随后才组合目标参考姿态并进入既有
  `jointOrient` 静态轴校准；因此“骨架面向不同”和“关节通道轴不同”是两层独立、可验证的问题；
- 离线黄金场景证明源沿 +Z 前进 1 单位在 `+Z → +X` 模板、2× 比例下变成目标 +X 2 单位，源绕
  Z 90° 变成目标绕 X 90°；平行轴模板明确阻断。离线测试增至 58 项。

真实宿主与交互：

- Maya 2025 黄金事务同时使用目标手腕 `jointOrientY=35°` 和 90° 世界轴模板；源 X 根运动正确写为
  目标 -Z 6 单位，手腕最终世界 quaternion 与共轭后的意图点积大于 0.99999，Animation Layer 写入、
  读回与 Undo 均为零误差；
- 原生调校条新增“骨架轴空间”中文模板选择器；模板切换立即重算当前 Pose/Clip Ghost、清除旧 Layer
  计划并保持 Maya 目标矩阵不变。基础 Layer 应用后选择器锁定，撤销并验证后恢复；
- QPainter 舞台中心新增动态轴基变换仪表，显示源前向、目标前向和旋转角度；90° 模板的紫/电青
  仪表与两侧骨架语义流形成同一 Kinetic Holographic 空间，而不是额外弹出传统设置窗；
- 修复接触参数 80ms 防抖与显式 IK 计划之间的竞态：求解、计划和应用现在先停止待处理刷新，再冻结
  当前意图。原生 UI 黄金流程连续运行 3 次均通过；宽/窄 Dock 无遮挡，全部用户文案为简体中文；
- 导出 Clip Package 写入轴模板稳定 ID 与中文名称。120 帧 × 18 语义、90° 轴变换的 Ghost + Layer
  plan 实测 **84.323 ms**，240 个节点帧，低于 120 ms 预算。

下一批进入批量 Clip 浏览、搜索/预检、package v2 迁移和资产级失败状态；随后继续完整 Full Body、
Rig Graph 声明式模块、Skin 拓扑迁移、Face/PSD/RBF 与发布制作化，goal 保持 active。

### 2026-08-25 — R4 Slice 12：Clip Package v2 与原生资产舱

资产格式与迁移：

- `mayacraft.clip.package/v2` 在严格 Clip、参考姿态、metadata 和 fingerprint 之外，新增可搜索显示名、
  规范化标签与显式 signed forward/up 坐标约定；标签数量、长度、重复和非法/平行轴均在纯数据层拒绝；
- v1 Package 不直接信任或重写：先按 v1 原始 canonical JSON 重新计算 SHA-256 并比较旧 fingerprint，
  验证通过后才迁移到 v2；篡改过的 v1 仍被拒绝。旧裸 Clip 继续明确标记首帧参考来源；
- `ClipPackagePreflight` 在路径重映射前统一检查节点键缺失/冗余、参考骨架尺度、轴模板源空间、节点数
  与节点帧上限；UI 与直接 API 加载共用同一套 blocker，不再维护两份易漂移判断；
- 导出的重定向结果以当前轴模板 target forward/up 写入 v2，并携带“重定向结果 / 接触 IK 或基础
  重定向”标签、模板稳定 ID 和中文名称。

资产索引与中文原生浏览：

- `ClipPackageStore.scan_directory` 最多扫描 500 个 `.mayaclip`/JSON，稳定排序并把有效、已迁移、损坏
  文件都保留为索引条目；损坏资产记录中文读取原因，不因单文件失败中止整个目录；
- host-independent 搜索同时匹配名称、标签和路径，可组合多词并选择是否显示损坏项；索引记录帧数、
  fps、时长、节点数、坐标轴、版本、字节数、修改时间和 fingerprint；
- “浏览资产 Clip”进入原生 `Clip 资产舱`：中央映射舞台切换为紫色资产工作区，时间带和事务行暂时
  收起，避免在 760px 高度下挤出产品顶栏；返回映射场后完整恢复原状态；
- 左侧资产列表显示内容摘要与可预检/待另存 v2/损坏状态，损坏项使用红色信号且无法加载；右侧执行
  节点、尺度、轴空间和采样规模预检，只有全部通过才启用“载入并生成零写入 Ghost”；
- Maya 2025 UI 黄金场景在同一目录放置真实 v2 Clip 与损坏 JSON，索引得到 2 文件 / 1 损坏，搜索
  后加载有效资产并继续完成 Retarget + Contact IK 双层事务；截图 `mayacraft_clip_library_cn.png`
  证明失败资产与成功路径来自真实运行而非设计稿；
- 121 文件（120 个有效 v2 + 1 个损坏）的读取、指纹验证、索引和多词筛选实测 **89.884 ms**，低于
  250 ms 资产舱预算；离线 58 项、Maya UI 与隐藏生命周期门槛继续保持。

R4 数据、轴空间、接触与资产工作流已形成较完整闭环，但项目未完成。下一批回到 R2/Rig Graph，
推进声明式 FK/IK/Space/Twist/Bendy 模块、结构 diff、错误定位和双足黄金 Build；随后继续 Skin 拓扑
迁移、Face/PSD/RBF 与 `.mod` 发布制作化，goal 保持 active。

### 2026-08-25 — R2 Slice 06：真实 FK 行为图与物理漂移检测

Rig Graph 不再把带 `FK/IK` 名字的空 transform 当成功。本批把“对象声明”和“行为声明”拆成两层：

- 新增不可变 `RigBehaviorSpec / ObservedRigBehavior`，行为拥有稳定 ID、类型、owner module、输入、输出、
  设置与独立 observed fingerprint；模块、节点和行为分别验证唯一性、端点、归属与一对一矩阵驱动 arity；
- 增量计划新增 behavior CREATE/PRESERVE/UPDATE/REBUILD/REMOVE，并把行为 diff、物理指纹和 destructive
  风险纳入 stale-plan 判定、`can_apply`、全图 verify 与 Undo 回执；
- Maya adapter 以真实 `multMatrix` 作为首种行为实现，将控制器 `worldMatrix` 与目标
  `parentInverseMatrix` 组合后驱动 `offsetParentMatrix`；扫描时从真实 Maya 插头反查稳定端点，断开输出即使
  metadata 完整也会得到精确 UPDATE；
- 黄金双足从 7 modules / 19 个占位对象升级为 7 modules / 37 个声明对象 / 14 条物理行为。脊柱、头部、
  双臂和双腿生成真实 NURBS 控制曲线、独立 driver joint 层与逐关节矩阵驱动；输入语义骨架只读；
- `bind_graph_to_skeleton` 不再维护硬编码节点 ID 表，而是读取节点声明中的 `semanticRole`，将所有三段
  肢体控制器和 driver joint 对齐到 source joint 世界位置/四元数并记录来源；源关节删除或改名会在 plan
  阶段形成中文 blocker，不进入写事务；
- Apply 仍是单一 `MayaCraft Incremental Rig Build` Undo chunk；行为先安全断开/重建，节点按父级顺序
  增量处理，PRESERVE 节点不再被重复写入；写后节点和物理行为必须全部只剩 PRESERVE，失败自动回滚；
- Maya 2025 实测控制器旋转会驱动对应 driver joint；人为断开 hand 矩阵输出后计划定位
  `l_arm.drive.2`，修复、读回、Undo 恢复断线状态均通过。完整 Build 为 51 项声明变更，整块 Undo 回到
  零对象/零行为；
- Rig Graph 原生工作区显示“37 个对象 / 14 条物理行为”、模块驱动数量与行为状态；未扫描可用骨架时
  主动作禁用。760×620 窄 Dock 自动收起次要说明，几何断言证明 Diff 与三个动作按钮无重叠；
- 240 modules / 480 nodes / 240 behaviors 的 CREATE + NOOP 双计划为 **21.536 ms**，低于 50 ms 预算；
  离线测试增至 59 项，mayapy 事务、原生 UI 截图与隐藏 Maya GUI 生命周期均通过，用户 Maya PID
  `32232` 在验证前后保持不变。

本 Slice 建立的是可信 FK 行为底座，不代表 R2 完成。下一批继续在同一行为 IR 上实现 RP IK + Pole、
无跳变 FK/IK blend 与 Space Switch 补偿，再进入 quaternion Twist 分配、Bendy 曲线和 Guide 增量编辑；
之后仍需 Skin 拓扑迁移、Face/PSD/RBF 与发布制作化，goal 保持 active。

### 2026-08-25 — R2 Slice 07：FK/IK 行为链与展示版收口

本批不再扩张长线功能，而是把现有能力冻结成可录屏、可讲解、可验证的 Maya 2025 展示版本：

- 黄金双足升级为 7 modules / 73 个声明对象 / 34 条物理行为，总计 107 项；四肢拥有独立 FK driver、
  IK driver 与 result/delivery 链，结果通过 `blendMatrix` 在 FK/IK 之间混合；
- Maya adapter 创建真实 `ikRPsolver`、IK handle 与 `poleVectorConstraint`，IK 控制器移动后 result 末端
  到达目标；Pole 控制器使用独立菱形曲线并进入行为读回；
- 手脚 IK 控制器提供“全局 / 胸腔”基础 Space Switch，以 `choice + multMatrix` 驱动空间组；初始切换
  保持世界位置，胸腔移动会被正确跟随；物理插头断开仍会进入精确行为 diff；
- 修复骨架语义评分：名称按 token 边界匹配，`upperArm` 不再被 `forearm` 内部的 `arm` 片段抢占；
  离线测试新增左右上臂/前臂路径断言；
- 未完成的实验性 FK/IK Match 事务从展示版移除。动画帧上的无跳变 FK/IK 匹配、带关键帧补偿的
  Space 切换、Twist/Bendy/Guide、Face PSD/RBF 和拓扑变化蒙皮迁移进入后续路线；
- 发布门槛固定为：60 项离线测试、Rig Graph mayapy 事务、关键工作区原生 UI 截图、隐藏 Maya 2025
  `workspaceControl` 生命周期、性能基准与 GitHub 展示素材全部通过。

这次收口的判断标准不是“按钮数量”，而是面试现场能够证明每个 Hero 路径使用真实 Maya 数据、
具备中文动态反馈，并且写操作可以验证和撤销。

### 2026-08-27 — R2 Slice 08：时间感知 FK/IK Match 与关键帧 Space 补偿

本批把展示版中明确暂缓的动画师切换工作流重新作为 MayaCraft 2.1 单一 Hero 目标推进：

- 新增 host-independent `rig_switching` 计划层。当前帧、三段结果意图、FK/IK/Pole 世界矩阵、Blend、
  Twist 和 Space 属性进入 SHA-256 漂移指纹；零长度链、无效矩阵、同空间、锁定/驱动通道和未完成
  Rig Graph 在写入前阻断；
- FK→IK 由结果末端矩阵和三段几何计算 Pole；IK→FK 按父到子顺序匹配三个 FK 控制器。应用统一进入
  单一命名 Undo chunk，并在切换 Blend 后逐关节重采样世界矩阵；
- 真机弯曲 FK 测试暴露旧输出网络使用被驱动节点 `parentInverseMatrix` 的不稳定求值依赖。驱动、混合
  与 Space 网络已统一改为显式父节点 `worldInverseMatrix`，旧 Rig Graph 事务回归继续通过；
- Maya RP IK 在任意弯曲平面存在关节 Roll 差异。没有放宽误差阈值，而是在三段 IK 输入前加入
  `composeMatrix + multMatrix` 旋转补偿，并把九个补偿角作为 IK 控制器隐藏可关键帧通道；FK→IK 后
  最大位置误差 `2.184e-7`、最大矩阵误差 `2.077e-7`，IK→FK 位置误差 `5.044e-15`；
- Space Switch 在当前帧前一帧写旧空间与旧局部通道保护键，当前帧切换 enum、恢复控制器世界矩阵并
  写补偿键；实测世界矩阵误差为 `0`，Undo 验证空间、姿态和新增关键帧全部恢复；
- Rig Graph Inspector 在构建验证后动态展开中文“动画匹配舱”：FK/IK 光轨由真实 Blend 驱动，覆盖
  零写入预览、成功回执、锁定阻断、760×620 窄 Dock 和 Undo 五种截图状态；
- `demo/` 新增四个 Maya 2025 确定性自生成场景、JSON 清单、生成脚本和自动场景验证；中文使用教程、
  录屏脚本和素材说明已落盘。离线测试 64 项通过。

本 Slice 已完成核心算法、真实 Maya 事务、中文 UI 和首批素材。随后完成发布硬化：2000 次宿主无关
匹配/空间计划实测 `82.581 ms`，低于 `120 ms` 总预算；独立隐藏 Maya 2025 进程 PID `37156` 完成
启动、重复打开清理、开发热重载与关闭清理，插件内启动 `199.362 ms`、关闭 `19.012 ms`，测试前后
均无 Maya 残留进程；一键安装脚本支持零写入预览，并只向当前用户 Maya 2025 modules 目录写入经
读回验证的 `MayaCraft.mod`。Twist/Bendy、Guide、Face PSD/RBF 和拓扑变化蒙皮迁移不扩入本 goal。

### 2026-08-27 — Hero Slice 09：Quaternion Twist 能量塑形舱

本批以作品集展示价值为第一优先，不再扩一排普通按钮，而是建立可直接录屏讲算法、网络和事务的
单一 Hero：

- 黄金双足由 73 对象 / 34 行为升级为 **97 对象 / 42 行为**。四条肢体各增加上、下两段，每段三枚
  Twist 关节与独立 `twist_distribution` 行为；总计 24 枚实时关节和 8 套可物理反查的 DG 网络；
- 宿主无关算法对相对四元数向量部沿任意骨段局部轴做投影，得到单位 Twist quaternion，再以
  `swing = q × inverse(twist)` 分离 Swing。纯弯曲不会被当作 Twist，180° 退化和零轴明确处理；
- Maya 2025 网络使用内置 `quatNodes`：`multMatrix → decomposeMatrix → dot/project → quatNormalize →
  quatSlerp → quatToEuler`。90° 前臂扭转实测三枚关节为 `22.5° / 45° / 67.5°`，误差低于 `1e-6°`；
- “分布偏置、缓入曲线、扭转强度”生成单调、端点安全的艺术曲线。`-0.65 / 85% / 90%` 得到
  `54% / 85% / 90%`；拖动只改变动态能量场，明确预览后才允许修改真实 slerp 权重；
- 应用执行预览指纹复核、单一命名 Undo chunk、逐节点读回和误差阈值验证；失败自动撤销，Undo 后
  再次验证原权重。引用节点、锁定或已有输入连接会在写前红色阻断；
- 原生 QPainter “Twist 能量场”用流动螺旋、发光关节和实时角度表达当前骨段。进入 Hero 模式自动
  收起已完成构建摘要，让 Inspector 成为完整塑形工作区；宽版、760×620、成功、阻断、撤销均由
  生产 Widget 实际渲染；
- 新增 `mayacraft_twist_sculpt.ma` 确定性场景，五套演示素材继续不含第三方或公司资产。离线测试
  增至 68 项，并新增 Maya 2025 quaternion DG、UI 和场景级验证。

发布实测：5000 次 swing–twist 分解与三关节分布曲线生成耗时 **47.421 ms**，低于 140 ms 预算；
独立隐藏 Maya 2025 PID `36676` 使用 `2.2.0.dev1 / PySide6` 完成首次启动、重复启动清理、开发热重载
和关闭清理，插件内首次启动 `200.045 ms`、关闭 `16.314 ms`，测试前后均无 Maya 残留进程。

Bendy 曲线、Guide 高级编辑、Face PSD/RBF 与拓扑变化蒙皮迁移仍不扩入本 Hero，避免为展示数量牺牲
Twist 闭环的可信度。

### 2026-08-30 — Bendy Slice 01：形变弧场算法底座

本轮先清理项目事实入口，再启动 Bendy Hero，不把新功能继续塞进通用赛博仪表盘：

- `PROJECT_STATUS.md` 成为当前版本、稳定能力、legacy 边界和验证节奏的单一事实源；本文早期数字与
  “下一步”明确降级为历史快照，2.2 审计冻结为发布证据；
- Bendy 的视觉母题定为角色轮廓、关节弧线和形变带；中心弧场承担直接操纵，不使用伪终端、治理词、
  同尺寸卡片海或无业务含义的霓虹；
- 新增宿主无关三次曲线算法，以高精度查找表把关节按真实弧长均分，不用曲线参数伪装等距；
- 使用 Parallel Transport Frame 沿弧线传递局部朝向，覆盖直线、低曲率和 S 型反弯，避免 Frenet
  Frame 在拐点翻转；上方向与切线近乎平行时选择最稳定的备用局部轴；
- 弧长/弦长比驱动可调幂律体积保持；零长度骨段、非法采样规模和参数越界在进入 Maya 前阻断；
- 新增 5 项针对性测试并全部通过。本片不写 Maya 节点，因此按快速开发规则没有重复运行发布级
  mayapy、隐藏 GUI 和全量性能门槛。

下一片直接实现可拖拽 QPainter 形变带和中文弧线参数交互，再把稳定采样结果接入 Rig Graph 与真实
Maya DG 事务。

### 2026-08-30 — Bendy Slice 02：可拖拽形变带

- 新增生产 `BendyArcField`，以一条有厚度的角色轮廓取代参数卡片：两枚切线把手分别控制入弧与
  出弧，中间“肌腹”把手整体推弯；键盘方向键也可微调当前把手；
- 直线、自然 C 弧与反向 S 弧可即时切换。所有拖动只调用宿主无关算法，弧上显示 11 个等弧长
  采样点，并实时显示弧长、伸长比和体积保持后的截面比例；
- Rig Graph Inspector 新增“形变设计台”模式，进入后标题、色彩和工作区结构整体切换；Twist 使用
  螺旋能量场，Bendy 使用暖色轮廓草绘台，两者不是相同卡片换强调色；
- 界面使用自然中文，330px 窄场采用短标题和紧凑指标，不靠缩小整个界面解决溢出；生产 Widget 的
  760×420、330×340 和 760×620 Rig Graph 集成渲染均由 Maya 2025 mayapy 通过；
- 首次渲染发现 QApplication 创建前注册字体会导致离屏中文方块，测试启动顺序已修正并重新截图；
- 本片仍是明确的零写入交互，不暴露伪装成可用的 Maya 应用按钮。下一片进入 Bendy Rig Graph
  声明、真实曲线/关节 DG 和安全事务。

### 2026-08-30 — Bendy Slice 03：真实 DG、事务与展示闭环

- 黄金双足从 97 对象 / 42 行为升级为 **137 对象 / 50 行为**，总计 187 项读回结果。四肢的八条
  骨段各新增两枚切线控制器、三枚 Bendy 关节和一条 `bendy_curve` 物理行为；
- 每条行为创建原生 NURBS 曲线，四个 CV 由起点、入弧切线、出弧切线和终点的世界矩阵驱动；三枚
  关节使用 fraction motionPath 保持等弧长分布，不依赖逐帧 Python callback；
- `curveInfo.arcLength / distanceBetween` 得到弧长/弦长比，`multiplyDivide` 以
  `ratio ^ (-0.5 × volume)` 驱动主轴之外的两个截面轴；本次空间弧实测截面为 `0.9882`；
- Twist 关节改为对应 Bendy 关节子层。真实 Maya 组合测试中，形变曲线改变后 quaternion Twist 仍为
  `22.5° / 45° / 67.5°`；原 Twist swing 隔离与艺术分布回归继续通过；
- 形变弧场现已连接零写入计划、当前帧/骨段/控制器/体积 SHA-256 指纹、锁定/引用预检、单一命名
  Undo、控制器与三关节读回验证和失败回滚。UI 黄金场景关节最大误差为 `0.000440`；
- 手动拔掉 motionPath 旋转输出后，Rig Graph 将具体 `bendy_curve` 行为识别为 UPDATE；修复、读回与
  Undo 后恢复断线状态；
- `mayacraft_bendy_sculpt.ma` 成为第六套确定性自生成场景。成功、预览、760×620、Undo 与锁定阻断
  五张真实中文截图已生成，教程和录屏路径更新到 2.3；
- 68 项旧离线测试、7 项 Bendy 算法测试、Bendy DG 事务、六场景验证、共享 Rig Graph UI 与 Twist
  组合回归均通过。

### 2026-08-30 — Bendy Slice 04：2.3 发布收口

- 版本由 `2.3.0.dev1` 收口为 `2.3.0`，Maya 2025 `.mod` 安装声明同步更新到 2.3，并完成实际写入
  与逐字节读回；
- 合并发现式离线回归共 **75 项**，全部通过；此前 Bendy DG 事务、六场景、共享 Rig Graph UI、
  Twist 组合与五种中文状态截图保持通过；
- 独立隐藏 Maya 2025 PID `33448` 使用 `2.3.0 / PySide6` 完成首次启动、重复启动清理、开发热重载
  和关闭清理。插件内四步合计在 2 秒内完成，启动器生命周期约 22.35 秒；
- 验证前后均无 Maya 进程，测试只关闭自己启动的 PID，没有触碰用户宿主；
- Bendy Hero 由“正在推进”转为“2.3 已完成”。后续 Hero 必须另开清晰切片，不继续把已交付事项
  伪装成开放待办。
