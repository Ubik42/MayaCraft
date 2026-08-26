# MayaCraft 绑定与动画产品研究及方向决策

> 2026-08-25 实施决策：展示版本只以 Maya 2025 / PySide6 为目标，不再把
> Maya 2024 / PySide2 双版本兼容作为首发门槛。以下竞品与算法研究结论不受影响。

状态：R0 产品研究结论（作为后续设计与重写的约束）  
日期：2026-08-25  
范围：角色绑定、蒙皮/形变、动画与重定向；不包含通用 TD 工具  
产品口号：**Build the character. Feel the motion.**

## 0. 最终判断

MayaCraft 不应该成为另一个 mGear、Advanced Skeleton、animBot 或 ngSkinTools 的功能拼盘，也不应继续把大量 Maya 命令放进漂亮按钮中。它要成为一个 **Character Intelligence Workspace（角色智能工作台）**：同一个角色、同一个可视化上下文，从 Guide、Rig Graph、Skin、Pose 一直走到 Motion 与 Publish。

差异化不是“比竞品多 200 个按钮”，而是以下三点同时成立：

1. **空间问题直接在空间中解决**：Guide、约束、关节限制、权重、形变误差、轨迹、接触与重定向偏差都进入 Maya Viewport 2.0，不把用户赶进表格。
2. **自动算法必须可解释、可比较、可局部接管**：显示置信度、误差场、候选结果和变化范围，允许锁定身体区域、影响骨骼或时间区间。
3. **绑定与动画共享角色语义**：绑定阶段写入的部位、空间、对称、接触、控制器和形变语义，直接驱动 Picker、FK/IK、镜像、重定向、验证与动画工具。

一句话定位：

> MayaCraft 是 Maya 内一个具有实时视口交互、可解释几何算法和角色语义的下一代绑定与动画工作台。

## 1. 市场上真正值得学习的东西

### 1.1 竞品不是一个榜单，而是六类能力

| 类别 | 最强参考 | 应学习 | 不应照搬 |
|---|---|---|---|
| 模块化绑定框架 | mGear Shifter、Unreal Modular Control Rig | 可复用模块、数据化模板、连接器、可重建流程 | 把复杂度暴露成大量参数页；只会“全删全建” |
| 快速自动绑定 | Advanced Skeleton 等 | 低门槛、快速产出、完整身体/面部覆盖 | 重型黑箱 Rig、难以增量修改、性能不可解释 |
| 蒙皮与形变 | ngSkinTools、Maya Skin Tools、Brave Rabbit SHAPES | 非破坏层、镜像、笔刷、Corrective/PSD 工作流 | 只提供笔刷而没有自动诊断；多个编辑器割裂 |
| 动画效率 | animBot、The Key Machine | Tween、临时枢轴、镜像、关键帧与选择集的极短操作路径 | 无限工具条、按钮记忆、脱离角色语义的通用命令 |
| 智能运动 | Cascadeur、Ragdoll Dynamics | Ghost、轨迹、接触、物理辅助、实时操纵与结果回传 | 独立软件孤岛；一次性 bake 黑箱 |
| 映射与重定向 | Maya HumanIK、Unreal IK Rig | 可视骨架映射、全身 IK、比例差异、非破坏预览 | 脆弱的命名假设；失败后只给日志文本 |

### 1.2 关键证据

- mGear 的核心价值是 Shifter 的模块化绑定、Synoptic/Anim Picker、RBF Manager 和可扩展 Python/C++ 框架；其 5.3 版本还在加强 Guide Template Manager 与独立构建日志，而不是只增加一排按钮。[mGear 产品与组件](https://www.mgear-framework.com/) · [Shifter Quick Start](https://mgear4.readthedocs.io/en/master/quickStart.html) · [mGear 5.3](https://mgear-framework.com/mgear-5-3-release/)
- Unreal Modular Control Rig 把身体模块、Connector、Socket 和 Schematic Overlay 放进视口，明确把它称为 Visual Rigging。这证明“模块图 + 视口连接”的心智模型比传统表单更适合绑定。[Modular Control Rig](https://dev.epicgames.com/documentation/en-us/unreal-engine/modular-control-rigs-in-unreal-engine)
- ngSkinTools 的行业价值来自 layer-based、any-pose mirror、增强笔刷和 true smoothing；Autodesk 在 2025 年收购后已把非破坏分层蒙皮变成 Maya 官方能力。这意味着“有权重层”只能算入场券，不能算 MayaCraft 的杀手功能。[Autodesk App Store](https://marketplace.autodesk.com/apps/fd1e651c-7912-4935-9ae7-6d0a3ca1a1e1) · [Maya Skin Tools](https://help.autodesk.com/cloudhelp/ENU/MayaCRE-CharacterAnimation/files/GUID-70ED2FB6-10FB-4481-BDC1-B0C34FAC769F.htm)
- Cascadeur 把 Ghost、Silhouette、可编辑轨迹、AutoPosing、AutoPhysics、Tween、Retarget、Unbake 和 Control Picker 集成到统一运动编辑语境中。它的重要启示是：算法结果必须通过轨迹、幽灵姿态和可拖拽控制点变得可感知。[Cascadeur Animation Tools](https://cascadeur.com/help/tools/animation_tools) · [Cascadeur Physics](https://cascadeur.com/help/animation_pipeline/physics)
- Ragdoll Dynamics 证明 Maya 视口内实时物理不是实验噱头：Live Mode 允许直接拖拽、固定、施加重力、碰撞和回传姿态，官方目标延迟为每帧毫秒级。[Ragdoll 产品](https://ragdolldynamics.com/) · [Live Mode](https://learn.ragdolldynamics.com/documentation/live_mode/) · [Universal Transfer](https://learn.ragdolldynamics.com/releases/maya/2023.10.03/)
- animBot 的强项不是深奥算法，而是 Tween、邻键缩放、镜像、临时 Pivot、Motion Trail、选择和关键帧处理都压缩成极短动作路径。动画工具必须能被肌肉记忆调用，不能要求动画师频繁管理窗口。[animBot](https://animbot.ca/home/) · [animBot Tooltips](https://animbot.ca/tooltips/) · [Motion Trail/Tweener 示例](https://www.animationmentor.com/blog/tutorial-animbot-motion-trail-tweener/)
- HumanIK 已经提供全身 IK、Body Part 模式、Pin、Effector 和跨比例骨架重定向；MayaCraft 若只复制基础重定向没有意义，优势必须来自自动语义映射、偏差解释、接触保持和局部修正。[HumanIK](https://help.autodesk.com/view/MAYAUL/2026/ENU/?guid=GUID-EDBDA3DB-4715-40EF-9ADF-412F78BFF98E) · [非破坏重定向工作流](https://help.autodesk.com/cloudhelp/ENU/MayaCRE-CharacterAnimation/files/GUID-1EE9D0F3-D603-4537-9CEE-554835016282.htm)
- Brave Rabbit SHAPES 把 blend shape、in-between、corrective 和 RBF/pose interpolation 组织成专业形变工作流。MayaCraft 面部功能应在后期围绕 Pose Space Deformation 和形变诊断重建，而不是延续现有按五官堆脚本的结构。[SHAPES](https://www.braverabbit.com/shapes-maya/) · [SHAPES 文档](https://www.braverabbit.com/braverabbit/en/shapes-maya-documentation/) · [MetaHuman RBF](https://dev.epicgames.com/documentation/metahuman/authoring-rbf-in-maya?lang=en-US)

## 2. 社区反馈揭示的真实问题

社区讨论不是功能投票，重点是寻找反复出现的摩擦模式。

### 2.1 绑定师反复遇到的问题

1. **快速自动绑定与可维护性冲突**：Advanced Skeleton 容易上手，但用户担心 Rig 偏重、定制边界和长期维护；mGear 更数据化、更适合制作，但学习、安装和部署成本更高。
2. **生成结果像黑箱**：出错时很难知道是 Guide、命名、朝向、拓扑、模块连接还是构建顺序导致。
3. **动画 Rig、形变 Rig、游戏骨架边界不清**：制作团队倾向分离控制、形变与交付骨架，但小工具经常把所有职责焊死在一个层级中。
4. **性能太晚才被发现**：Rig 完成后才发现帧率低、串行节点或 Evaluation Graph 问题，重构代价巨大。
5. **UI 变成参数仓库**：功能全面后常见结果是标签页、折叠区和图标不断增长，信息结构反而退化。

讨论样本：[2024 auto-rigger 讨论](https://www.reddit.com/r/Maya/comments/19ab9kq/) · [详细系统比较](https://www.reddit.com/r/Maya/comments/1fzvpzx/) · [mGear 行业接受度](https://www.tech-artists.org/t/mgear-industry-acceptance-and-do-you-like-it/15571) · [小团队可扩展 Rig Pipeline](https://www.tech-artists.org/t/best-practices-for-setting-up-a-scalable-rigging-pipeline-for-a-small-studio/18075)

### 2.2 蒙皮师反复遇到的问题

1. Maya 原生 Paint Skin Weights 的定位、锁定、归一化和选择上下文容易打断连续操作。
2. 单纯“更好的笔刷”并不适合所有用户；很多问题更适合区域、边界、对称和姿态驱动的数值修复。
3. 多 SkinCluster、拓扑变化、镜像不对称和 Influence 管理仍是生产痛点。
4. 自动蒙皮常给一个结果，却不告诉用户哪里可信、哪里需要检查。

讨论样本：[Maya Paint Weights 摩擦](https://www.reddit.com/r/Maya/comments/1newtgp/) · [多 SkinCluster 问题](https://www.reddit.com/r/Maya/comments/1povtcu/ngskintools_2_and_multiple_skinclusters/) · [加速蒙皮讨论](https://www.tech-artists.org/t/is-there-any-useful-may-script-or-tool-to-fast-the-skinning-process/15966)

### 2.3 动画师反复遇到的问题

1. 高频需求集中在 Tween/Breakdown、邻键操作、Mirror、临时 Pivot、Space/FK-IK 切换、复制姿态/轨迹、选择集和 Bake/Cleanup。
2. 动画师愿意长期依赖 animBot，说明最有价值的是稳定、快速和肌肉记忆，而不是展示一个 AI 按钮。
3. Motion Trail 仍有性能与编辑体验抱怨；把轨迹显示出来还不够，必须能直接编辑并保持时间、弧线和约束的清晰关系。
4. Mocap/Mixamo 清理、脚滑、接触、错误 Pivot、约束临时搭建仍需要大量手工工作。
5. Picker 很重要，但静态二维按钮图会与 Rig 版本、命名和选择状态脱节。

讨论样本：[animBot 是否值得](https://www.reddit.com/r/animation/comments/10vh2op/is_animbot_worth_it_in_3d_animation_on_maya/) · [animBot 最佳功能](https://www.reddit.com/r/Maya/comments/115ez4o/) · [Maya 2026 动画反馈](https://www.reddit.com/r/Maya/comments/1jkujfb/) · [免费替代工具讨论](https://www.reddit.com/r/Maya/comments/1svmuiy/)

## 3. 产品支柱与三条招牌工作流

MayaCraft 的完整产品由三个 Lab 组成，但用户看到的是一个连续的 Character Workspace。

### 3.1 Rig Intelligence：可视 Rig 编译器

**目标任务**：把角色从几何/骨架意图可靠地编译成可维护、可增量、可解释的动画 Rig。

招牌工作流 **Living Rig Canvas**：

1. 导入网格或骨架后，系统检测身体区域、关节候选、对称面和朝向，并给出带置信度的语义映射。
2. 用户在视口拖拽 Guide；骨长、关节平面、Pole、Twist、肢体比例和冲突实时更新。
3. 身体模块作为可视 Socket/Connector 吸附，不需要在树和表单之间来回定位。
4. Build 前显示 Rig Diff：将创建、保留、迁移、断连或重建什么；风险直接高亮到角色上。
5. Build 以时间线/图谱显示进行状态；失败能回到具体模块、连接和 Maya 节点，并完整撤销。
6. 生成 Rig 自动带角色语义、动态 Picker、空间定义、对称规则、性能预算和发布验证。

必须具备：

- 版本化 Character/Rig Graph 数据，而不是从场景命名反推全部意图；
- 模块接口、Connector/Socket、稳定 ID、依赖图和增量编译；
- Build 的 validate → plan → preview → apply → verify 事务；
- 控制 Rig、形变 Rig、交付 Skeleton 可显式分层；
- Evaluation Manager 友好节点策略与实时性能 HUD；
- 自定义肢体、翅膀、尾巴、触手和道具连接，而不是只支持标准人形。

### 3.2 Deformation Intelligence：形变实验室

**目标任务**：不是“涂得更快”，而是更快得到可证明质量的形变。

招牌工作流 **Deformation MRI**：

1. 自动绑定并行计算多种候选：Maya heat/geodesic、harmonic/BBW 类方案和基于语义的初始化。
2. 在一组自动生成的关节极限姿态上运行 Pose Sweep。
3. 视口以热力场显示体积损失、拉伸、翻折、权重梯度突变、未归一和 Influence 超预算。
4. 用户点击问题区域，看到责任 Influence、权重层、相邻顶点和推荐修复；拖动修复半径时实时预览。
5. 系统只对未锁定区域做约束优化，并显示 before/after ghost、误差数值和置信度。
6. 拓扑变化后用空间/UV/barycentric/特征对应迁移，并把低置信区域留给人工确认。

算法候选及用途：

- Heat diffusion / Geodesic Voxel：快速初始化与复杂封闭空间传播；Maya 官方也承认 Heat Map 在真实网格上可能失败，而 Geodesic Voxel 用于处理该类问题。[Maya Bind Skin](https://help.autodesk.com/cloudhelp/2025/ENU/Maya-CharacterAnimation/files/GUID-CF2C698A-44BB-4CA0-BCB9-DB36500DA812.htm)
- Bounded Biharmonic Weights：平滑、局部、有界的自动权重候选。[BBW 论文](https://homes.cs.washington.edu/~jovan/papers/jacobson-2011-bbw.pdf)
- Cotangent Laplacian / harmonic diffusion：区域修复、平滑和异常检测；必须处理非流形、退化三角形与边界条件。
- Pose Space Deformation / RBF：肘、肩、髋、面部等 pose-dependent corrective。[PSD 论文](https://www.cs.toronto.edu/~jacobson/seminar/lewis-et-al-2000.pdf)
- 受约束稀疏优化：Influence 上限、锁定、非负、归一与误差之间做可解释折中。

“Layer”是数据基础，“MRI + Pose Sweep + 约束修复”才是产品差异。

### 3.3 Motion Intelligence：动画磁场

**目标任务**：把姿态、弧线、接触、时间与空间切换变成一个直接操纵系统。

招牌工作流 **Motion Magnetism**：

1. 动画师选中手、脚、头或质心，立即看到可编辑轨迹、速度节奏、接触段与 Ghost。
2. 拖动某个轨迹点时，系统按当前模式保持弧线、接触、肢体长度、Pivot 或全身平衡；影响范围以时间波纹显示。
3. Pin/Anchor 可以吸附地面、道具、另一控制器或历史世界轨迹，自动生成非破坏补偿层。
4. FK/IK、Space Switch、临时 Pivot 和重定向全部以“保持什么”为核心：保持世界姿态、末端轨迹、接触或局部节奏。
5. Tween 不只有一个百分比滑条，而是可在 pose、velocity、arc length、ease、overshoot 等策略间切换，并在拖动时显示 Ghost 结果。
6. Mocap 清理先检测脚滑、爆点、旋转跳变、接触和根运动，再按问题区域建议处理，不做整段盲目 smooth。

底层候选：

- FABRIK：快速多关节位置求解，适合交互式 Guide/Chain；需配合关节限制、Pole 与朝向策略。[FABRIK 论文](https://www.andreasaristidou.com/publications/papers/FABRIK.pdf)
- Position-Based IK / Jacobian DLS：多 Effector、刚度、限制和接触；Unreal Full Body IK 也采用 position-based framework。[Unreal Full-Body IK](https://dev.epicgames.com/documentation/en-us/unreal-engine/control-rig-full-body-ik-in-unreal-engine)
- Quaternion swing-twist 与 parallel transport：Twist 分配、轨迹朝向和避免翻转。
- 速度、加速度、jerk、弧长和接触区间：运动诊断、减帧和节奏保持。
- 误差有界曲线拟合：清理 mocap/烘焙曲线时明确最大空间或角度误差，而不是按固定阈值删 Key。

## 4. 视觉与动态交互方向

### 4.1 三条候选视觉路线

| 路线 | 核心形象 | 优点 | 风险 |
|---|---|---|---|
| A. Kinetic Holographic Stage | 深石墨 Maya 舞台 + 电青/洋红/琥珀的能量场、轨迹和骨架信号 | 最符合“炫酷、动态、空间化”；产品辨识度最强 | 若全界面都发光会降低密度与可读性 |
| B. Precision Motion Instrument | 黑白灰精密仪器 + 少量信号色，强调曲线、刻度和数据 | 专业、耐用、高密度 | 戏剧性不足，容易像高级版 Maya 面板 |
| C. Character Blueprint Theater | 蓝图网格、身体拓扑图、模块连接与构建状态变形 | 绑定叙事极强，结构容易理解 | 动画阶段可能显得静态和工程化 |

**决定：采用 A，吸收 B 的信息纪律和 C 的结构表达。**

视觉名称：**Kinetic Holographic Stage / 动态全息舞台**。

### 4.2 视觉路线卡（后续 UI 实现约束）

- **产品类型**：专业 DCC 编辑器，不是 Dashboard，不用 SaaS 卡片墙。
- **中心舞台**：Maya 原生 Viewport 是主画布；主要视觉冲击来自角色、轨迹、权重场、Ghost 和构建图，而不是窗口边框。
- **整体轮廓**：顶部极窄 Mode Rail；左侧 Character/Module Rail；中央 Viewport；右侧 Context Inspector；底部 Motion/Build Strip。面板可自动收缩，让角色始终最大。
- **色彩语义**：电青 = 当前意图/可编辑；洋红 = 运动预测/时间影响；琥珀 = 警告/低置信；红 = 确定错误；薄荷绿 = 已验证/接触锁定。颜色不能同时承担装饰和状态两种互相矛盾的含义。
- **材质**：平整深石墨面板、细分隔线、局部高亮；拒绝大面积玻璃拟态、渐变文字、巨型圆角卡片和到处发光。
- **形态语言**：骨骼/约束采用细线与节点；权重和误差采用表面场；时间影响采用波纹/拖尾；模块连接采用 Socket 脉冲；不要用无意义粒子。
- **字体与数字**：UI 使用清晰的无衬线体；角度、权重、帧和误差使用等宽数字。关键数字变化时做短暂滚动/闪变反馈。
- **图标**：统一自绘线性图标系统；图标表达对象或动作，不以抽象炫酷符号代替语义；高频操作配短标签或稳定 tooltip。

### 4.3 动态交互语法

炫酷必须表现“系统正在理解什么”，而不是播放装饰动画：

- Hover：显示影响对象和可操作方向，不改变场景；80–120ms。
- Press/Drag：高亮约束、锁定项和传播范围；拖动必须连续，禁止等待结束后才跳结果。
- Solve：能量沿骨链/图边传播，表示求解方向；颜色强度对应 Influence 或置信度。
- Compare：before/after Ghost、差异矢量和误差数字同时出现，松手后短暂停留。
- Build：模块由 Guide 形态过渡为控制器/骨架，底部 Build Strip 显示阶段和耗时；失败路径停在红色节点。
- Time edit：受影响帧在时间轴产生洋红波纹，强度对应权重；接触区用薄荷色磁吸带。
- Validation：扫描线只在主动验证时出现，随后错误固定到模型表面或 Rig Graph 节点。

性能门槛：拖拽交互以 60 Hz 为目标，复杂角色最低可接受 30 Hz；昂贵求解必须分级预览、增量计算、可取消，并在松手后完成高质量 refine。视觉效果不得使 Maya Evaluation 或选择延迟不可预测。

### 4.4 动态 Picker 的决定

不把传统二维 Picker 当独立文件手工维护。Picker 由 Rig 语义实时生成，并提供三种同步视图：

1. Viewport Controls：直接选角色控制器；
2. Body Map：适合遮挡、面部和密集手指；
3. Semantic Search / Marking Menu：键盘检索和肌肉记忆操作。

三种视图共享选择、左右侧、当前 Space、FK/IK、Key 状态和错误状态。AnimSchool Picker 的 Maya 双向选择与导航值得保留，但静态按钮布局不是最终形态。[AnimSchool Picker](https://www.animschool.edu/pickerInfo.aspx)

## 5. 技术可行性与平台约束

### 5.1 Maya 2025 能支撑的原生体验

- Maya 2025 已迁移到 Qt 6 / PySide6 6.5.3，且 Qt6 默认启用 High DPI；展示版直接使用这一套宿主栈并优先打磨视觉和交互，不承担 PySide2 分支。[Qt6 Migration](https://help.autodesk.com/cloudhelp/2025/ENU/Maya-DEVHELP/files/Whats-New-Whats-Changed/2025-Whats-New-in-API/Qt6Migration.html) · [Maya 2025 Components](https://help.autodesk.com/cloudhelp/2025/CHS/Maya-DEVHELP/files/Maya_DEVHELP_Open_Source_Components_html.html)
- `MPxManipulatorNode` 支持自定义操纵器、拾取、press/drag/release 和 Viewport 2.0 绘制，因此 Guide、轨迹、Anchor、关节限制不应退化成普通 Qt 滑条。[MPxManipulatorNode](https://help.autodesk.com/cloudhelp/2025/ENU/MAYA-API-REF/cpp_ref/class_m_px_manipulator_node.html)
- Evaluation Manager 会依据依赖关系构建并行调度；Rig 节点是否线程安全、是否形成串行链应成为模块验证的一部分，而非发布前临时测速。[Evaluation Manager](https://help.autodesk.com/cloudhelp/2025/ENU/Maya-Animation/files/GUID-190D97E7-9AC0-4D67-8A07-1AF3A9DBAF15.htm)

### 5.2 建议的实现分层

```text
Character Domain / Versioned Schema
          ↓
Rig Graph + Motion/Deformation Algorithms
          ↓
Preview & ChangeSet / Undo Transaction
          ↓
Maya Nodes + OpenMaya Adapters + Evaluation Validation
          ↓
Viewport 2.0 Draw/Manipulators + PySide6 Workspace Shell
```

- Python：产品逻辑、schema、图编译、工作流编排和大部分 UI。
- NumPy/纯算法层：权重、曲线、映射、误差与优化原型，可脱离 Maya 测试。
- C++ 插件：高频求解节点、Deformer、并行安全节点、自定义 Manipulator/Draw Override 和性能热点；不是为了“底层”标签而提前全部 C++ 化。
- Maya 原生节点优先：能用稳定原生 DG 节点表达且性能足够时不制造专有节点，降低场景交付依赖。
- 每个专有节点必须有版本、升级、丢失插件时的降级显示和 bake/export 路径。

## 6. 现有 MayaCraft 的去留结论

| 现有部分 | 决定 | 原因 |
|---|---|---|
| `core/rigging/basic`、`attribute`、`ik_label` | 作为行为参考，逐模块重写 | 现有命令式构建可帮助确认需求，但不适合作为 Rig Graph 编译器基础 |
| `core/rigging/build*` | 重写 | 必须换成稳定 ID、plan/diff、事务、幂等和验证流程 |
| `core/logic/skinning` 与现有 Skin UI | 重写 | 目标从命令包装升级为权重数据层、Pose Sweep、误差场和局部优化 |
| `core/animation/curve.py` | 先测试再决定提取 | 仅保留可验证的曲线数学；UI/场景副作用拆除 |
| `core/face` | 隔离在 legacy 思维下，不继续扩建 | PyMEL、命名和 UI/业务耦合高；等 Deformation/PSD 数据层稳定后重建 |
| 全部现有 `ui/` | 只作需求清单，界面重做 | 标签页 + 表单 + 按钮架构与新产品交互模型冲突 |
| 已迁出的 TD 功能 | 保持在 MayaScope | 产品边界已经明确，不再回流 |

正式重写时不做一次性大爆炸替换：每条新工作流通过 adapter 调用旧能力或与旧结果对照，完成黄金场景和性能门槛后再删除对应旧运行时。

## 7. 优先级：先做“英雄闭环”，不是先铺满菜单

### Phase A — Hero Prototype（证明产品灵魂）

只选一个双足角色，完成一条 10 分钟可演示闭环：

1. 语义识别与视口 Guide；
2. 拖拽式 Arm/Leg/Spine 模块连接；
3. Rig Diff + 增量 Build；
4. 一组 Pose Sweep + 形变 MRI 热力图；
5. 手/脚 Motion Magnet、Ghost、接触与 FK/IK 保持；
6. 动态 Body Map Picker；
7. 60/30 Hz 交互性能 HUD。

此阶段的成功标准不是模块数量，而是让人一眼看出它不是传统 Maya 工具窗。

### Phase B — Production Core

- 完整双足、手指、脚、Twist/Bendy、空间切换；
- Rig Graph 版本迁移、引用场景策略、Animation Preserve；
- 分层蒙皮、镜像/迁移、约束修复、质量评分；
- Pose/Clip、Tween、临时 Pivot、轨迹、Mirror、FK/IK、Space；
- Maya 2025 单版本安装、测试、崩溃恢复和基准。

### Phase C — Character Breadth

- 四足、翅膀、尾巴、触手、机械与自定义模块 SDK；
- HumanIK/自定义骨架/Unreal 重定向；
- mocap 诊断、foot contact、motion warping；
- 动态 Picker 模板和团队共享角色配置。

### Phase D — Advanced Deformation & Face

- Corrective/PSD/RBF 图、形变代理与 Shape 管理；
- 肌肉/软组织接口与 ML Deformer 数据准备/比较；
- 面部语义、表情组合、口型、眼睑和形变质量验证。

## 8. 明确不做什么

- 不以“AI 一键自动绑定/自动动画”作为首发卖点；不能解释、不能局部修正的 AI 只会制造新返工。
- 不复制 Maya 所有原生命令，也不做一个更漂亮的 Shelf。
- 不把炫酷等同于玻璃卡片、无意义发光、连续粒子或阻塞式转场。
- 不在 UI 定稿前大规模写功能页；先验证 Viewport 操纵、状态语义与英雄闭环。
- 不为了显示技术深度而自研所有数学：成熟算法优先验证、封装和正确可视化，真正的壁垒是组合、交互和生产可靠性。
- 不在 Rig Graph、Skin 数据层和 Pose 数据层稳定前重写完整面部系统。

## 9. 产品衡量指标

### 体验与视觉

- 新用户在 60 秒内能指出当前角色、工作阶段、错误位置和下一动作；
- Hero Workflow 中至少 70% 的核心操作在视口/快捷上下文完成；
- 高频动画操作无需在多个固定窗口之间切换；
- 所有动效能回答“影响哪里、为什么变化、是否可信”。

### 制作效率

- 标准双足从 Guide 到可动画 Rig 的人工交互时间相对现有 MayaCraft 降低 70%；
- FK/IK、Space、Pivot、Mirror 和接触修复保持世界轨迹时无可见跳变；
- 权重自动修复同时报告最大/平均形变误差，不只报告“成功”。

### 可靠性与性能

- 重复 Build 幂等；增量更新不破坏已有动画；失败无未知半成品；
- 交互拖拽目标 60 Hz，重角色最低 30 Hz，并提供可见的降级模式；
- 每个 Rig 模块记录 Evaluation、节点数量和帧耗预算；
- Maya 2025 有真实 mayapy/GUI 场景证据。

## 10. 下一轮应进入的工作

本轮已确定产品方向。下一轮不再继续无限扩竞品表，应该进入 **Hero Prototype 设计研究**：

1. 为 Living Rig Canvas、Deformation MRI、Motion Magnetism 分别画可交互状态图；
2. 选定 Hero 双足场景与 3 个典型动作；
3. 验证 PySide6 Workspace Shell + VP2 Overlay + 自定义 Manipulator 的最小技术切片；
4. 定义 Character Schema、稳定 ID、Socket/Connector 和 ChangeSet；
5. 做 3 张高保真关键界面：Guide/Build、Skin MRI、Motion Edit；
6. 在任何全面重写前，用原型测试视觉层级、拖拽手感和交互帧率。

这三条招牌工作流应成为所有后续功能的筛选器：不能增强它们、不能共享角色语义、不能在视口中解释结果的功能，默认不进入主产品。
