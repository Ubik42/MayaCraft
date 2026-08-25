# MayaCraft

面向 Autodesk Maya 2025 的模块化角色绑定与技术美术工具集。MayaCraft 将身体绑定、面部系统、蒙皮、动画辅助、通用场景操作和节点分析集中在一个可停靠的 PySide6 面板中，同时保留清晰的 UI / Logic / Core 分层，方便继续扩展绑定模块。

## 当前界面模块

MayaCraft 启动后以 `workspaceControl` 嵌入 Maya，包含六个标签页：

| 标签页 | 已接入能力 |
| --- | --- |
| Rigging | 导入示例角色与骨架、骨骼标签、模块化 Build、控制器形状管理 |
| Face | 眼、眉、鼻、嘴唇、下巴、面颊与 bulge 等面部模块构建 |
| Skinning | 权重导入导出、复制、粘贴、镜像、平滑、Prune 与清理无用影响骨骼 |
| Animation | Pose 保存/应用/删除/镜像、曲线插值、时间和值偏移、烘焙与运动轨迹 |
| General | 对齐、批量命名、Transform 分组冻结、控制器替换和关节辅助操作 |
| TD | Node Editor 辅助、节点属性检查、Markdown / Mermaid 连接图导出 |

## 绑定系统

### 身体绑定

`core/rigging/` 实现了可组合的身体绑定模块：

- FK、IK 与 IK/FK 混合系统；
- 手臂、腿、脊柱等带标签模块；
- Foot Roll 与 Foot Rock；
- Aim、Stretchy、Segment Scale Compensation；
- Twist / Bendy 与 Inbetween Joint；
- 由 `priorities.json` 控制的构建顺序；
- 绑定结构、骨骼处理和控制器集合的分阶段 Build。

仓库同时包含多套原始骨架模板，可从 Rigging 页导入用于验证不同角色结构。`files/Rigged/` 中的示例资产来自各自来源，署名信息保存在对应目录的 `credit.txt`。

### 面部绑定

`core/face/` 按部位拆分面部系统，包含 brow、eye、lip、jaw、nose、cheek 和 bulge 模块。系统配套：

- 定位器与分区选择逻辑；
- 曲线控制器形状数据；
- Surface / Polygon 权重 JSON；
- 单模块构建、全量构建和次级模块更新入口。

面部页不是单纯的按钮集合，实际构建逻辑位于 `core/logic/face/` 与 `core/face/systems/`，UI 只负责参数和流程组织。

## 动画、蒙皮与 TD 工具

### Animation

- 保存当前控制器 Pose，并生成对应缩略图数据；
- 以百分比混合应用 Pose；
- 按左右命名规则镜像 Pose；
- Tween、Overshoot、线性插值；
- 关键帧时间偏移与数值偏移；
- 动画烘焙与 Motion Trail。

### Skinning

- JSON 权重导入与导出；
- 按位置或顶点序号组织导入流程；
- 复制、粘贴、镜像和平滑权重；
- 清理小权重与未使用 Influence。

界面中的 Delta Mush 按钮目前为禁用状态，不列为已完成功能。

### TD

- 管理当前 Maya Node Editor 中的输入、输出与隔离显示；
- 查看选择节点的属性和连接；
- 生成节点网络的 Markdown 说明与 Mermaid 图；
- 在安装 AuroraView 时，以内嵌 WebView 渲染 Mermaid；未安装时仍可使用文本输出。

## 安装与启动

### 环境

- Autodesk Maya 2025；
- Maya 自带 Python 3.11、PySide6 与 shiboken6；
- AuroraView 为可选依赖，仅用于 TD 页的内嵌 Mermaid 预览。

### 放置仓库

将仓库父目录加入 Maya 的 Python 搜索路径。假设目录为：

```text
D:\tools\MayaCraft\
```

则需要让 `D:\tools` 位于 `PYTHONPATH`，然后在 Maya Script Editor 的 Python 标签页运行：

```python
import MayaCraft.launch as launch
launch.run()
```

重复运行会先清理旧的 `MayaCraftWorkspaceControl`，再创建新的可停靠面板，并重载 `core`、`ui` 与 `utils` 下的开发模块。

## 工程结构

```text
core/
├─ rigging/          FK、IK、IKFK、标签模块与构建流程
├─ face/             面部系统、控制器和权重数据
├─ logic/            各标签页的 Maya 操作逻辑
├─ animation/        动画曲线能力
└─ controller.py     控制器形状读写与替换
ui/                  六个标签页与可折叠控件
utils/               JSON、路径与开发期模块重载
files/ma/            原始骨架模板
files/shape/         控制器形状库
files/poses/         Pose 数据与预览
files/Rigged/        绑定示例资产及来源说明
launch.py            Maya workspaceControl 启动入口
```

## 当前边界

- 这是面向 Maya 2025 的开发版工具集，仓库没有安装器或 Maya Module 包；
- 自动绑定依赖骨骼命名、标签和场景结构，投入实际制作前应在副本场景验证；
- AuroraView 只增强 Mermaid 可视化，不是核心绑定功能的运行依赖；
- 示例模型与贴图不是 MayaCraft 自有资产，二次使用前请阅读相应 `credit.txt`。
