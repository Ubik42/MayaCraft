# MayaCraft Hero Prototype 完成审计

审计日期：2026-08-25。发布范围按最新决策收敛为 Maya 2025 / PySide6 单版本展示。
结论以当前工作树、Maya 2025 mayapy、隐藏 GUI 报告和实际截图为准。

| 要求 | 权威证据 | 结论 |
| --- | --- | --- |
| 产品边界 | 主工作区与 legacy 入口无 TD tab；通用 TD 已迁出 | 通过 |
| 原创现代动态 UI | Kinetic Holographic Stage、真实 DAG 投影、Change Capsule、目标与窄尺寸截图 | 通过 |
| 单一宿主栈 | `compat/qt.py` 只使用 PySide6 / shiboken6；运行栈为 Python 3.11.4、PySide6 6.5.3 | 通过 |
| 分层架构 | `domain/`、`adapters/maya/`、UI presentation 分离，UI 不直接堆 `maya.cmds` | 通过 |
| 真实 Maya 状态 | Maya 2025 构造 DAG 后扫描 root、namespace、joint、mesh、control、skinCluster、world position | 通过 |
| plan → preview → apply → verify | Character Link 从不可变 plan 到 UI preview、Maya transaction、独立读回验证 | 通过 |
| Undo 与失败安全 | 单一命名 Undo chunk；异常与 verify failure 自动 undo；实测整块撤回 | 通过 |
| 边界条件 | 覆盖 referenced blocker、foreign ID、empty selection、no-op、重复 callback 启停 | 通过 |
| GUI 生命周期 | Maya 2025 隐藏 GUI 中 initial/repeat/hot-reload/close 四步通过；旧 callback 归零 | 通过 |
| 后台不扰民 | GUI 验证只操作自己启动的隐藏 PID，超时也只停止该 PID；未连接或关闭用户已有 Maya | 通过 |
| Rig Graph 物理行为 | 73 个声明对象、34 条行为；FK/RP IK/Pole/混合/基础 Space 均为真实 DG，断线可检测/修复/撤销 | 通过 |

## 权威产物

- `tests/artifacts/maya2025_workspace_report.json`：真实 Maya 2025 GUI 生命周期报告；
- `tests/artifacts/maya2025_workspace_gui.png`：真实 Maya 2025 workspaceControl 截图；
- `tests/artifacts/mayacraft_maya2025_verified_workspace.png`：Maya 2025 Character Link 完成态；
- `tests/artifacts/mayacraft_maya2025_character_workspace.png`：Maya 2025 ChangePlan 预览态；
- `tests/artifacts/mayacraft_pyside6_narrow.png`：720×520 窄停靠回归。
- `tests/artifacts/mayacraft_retarget_contact_ik_preview_cn.png`：双脚约束、骨盆补偿与 FABRIK 零写入场；
- `tests/artifacts/mayacraft_retarget_contact_ik_verified_cn.png`：独立 Contact IK Layer 验证完成态。
- `tests/artifacts/mayacraft_retarget_axis_template_cn.png`：90° 跨骨架轴基变换与零写入 Ghost。
- `tests/artifacts/mayacraft_clip_library_cn.png`：Clip v2 资产索引、搜索、预检与损坏资产状态。
- `tests/artifacts/mayacraft_rig_graph_verified.png`：真实 FK/IK 控制链、34 条物理行为在线与 107 项构建完成态。
- `tests/artifacts/mayacraft_rig_graph_narrow.png`：760×620 原生窄 Dock 折叠与无重叠证据。

## 验证命令

```powershell
$mayaPy = 'C:\Program Files\Autodesk\Maya2025\bin\mayapy.exe'
& $mayaPy .\tests\mayapy_character_scan.py
$env:QT_QPA_PLATFORM = 'offscreen'
& $mayaPy .\tests\mayapy_ui_smoke.py
& $mayaPy .\tests\mayapy_registration_workflow.py
& $mayaPy .\tests\mayapy_rig_graph.py
& $mayaPy .\tests\mayapy_rig_graph_ui.py
& $mayaPy .\tests\mayapy_contact_ik_layer.py
& $mayaPy .\tests\mayapy_retarget_ui.py
& .\tests\run_maya2025_gui_validation.ps1
```

## 展示版范围冻结

1. Living Rig Canvas 1.0：已完成模块语义、健康度和祖先链聚焦；后续增加用户自定义模块规则、层级折叠与稳定场景事件失效；
2. Deformation MRI v0：已完成真实权重场诊断、动态热力 UI 与 Normalize Repair transaction；
3. Character Session：v0 已完成场景发现、临时固定和角色切换；后续补场景打开/引用变化监听；
4. Motion Magnetism 的轨迹微分、接触推断、可修正 ghost/trajectory 与 Contact Anchor 已完成首轮；
5. Retarget 已完成 Pose/Clip、资产导入导出、语义 Ghost、基础 Animation Layer、双脚 Contact IK
   Layer、根朝向/地面法线、Smoothstep 接触权重包络、舞台锚点拖拽、跨骨架轴模板、Clip v2 与
   批量资产浏览预检；后续补更完整 Full Body 控制与外部格式桥接；
6. Rig Graph 已从占位 transform 推进到真实 FK/RP IK/Pole、FK/IK 混合、基础全局/胸腔 Space 与可验证
   DG 行为；无跳变 FK/IK Match、动画帧 Space 补偿、Twist/Bendy 与 Guide 编辑进入后续路线；
7. 本次展示不再扩张 Face PSD/RBF、拓扑变化蒙皮迁移和完整 Full Body 控制，避免把未闭环流程伪装成成品。
