# MayaCraft

Maya 2025 综合绑定插件系统 (Comprehensive Rigging Plugin System)。

## 简介 (Overview)

MayaCraft 是一个专为 Maya 2025 设计的模块化绑定工具集，旨在简化角色绑定流程。它提供了从基础骨骼构建、身体自动化绑定 (FK/IK/IKFK) 到高级面部绑定的完整解决方案，并集成了一系列 TD 辅助工具。

## 主要功能 (Features)

- **身体系统**:
  - 自动构建 FK、IK 及 IK/FK 切换系统
  - 模块化设计 (手臂、腿部、脊柱等)
  - 属性驱动的组件 (Twist, Bendy, Inbetween Joint)

- **面部系统**:
  - 基于曲线驱动的高级面部绑定
  - 涵盖眼睛、嘴唇、眉毛、鼻子、下巴等模块
  - 权重与控制器形状管理

- **TD 工具箱**:
  - **节点分析器**: 可视化节点连接图 (集成 Mermaid & AuroraView)
  - 节点查看器: 快速调试与属性检查

- **通用工具**:
  - 控制器形状库管理 (导入/导出/替换)
  - 蒙皮工具集
  - 动画辅助工具

## 技术栈 (Tech Stack)

- **Core**: Python 3.11 + Maya API 2.0
- **UI**: PySide6
- **Web Integration**: AuroraView (Rust/WebView 引擎，用于 图表渲染)

## 安装与启动 (Installation & Usage)

确保 `MayaCraft` 位于 Maya 的脚本路径中。

在 Maya 脚本编辑器 (Python) 中运行：

```python
import MayaCraft.launch as launch
launch.run()
```

插件将自动加载并停靠在界面侧边栏。

## 开发注意事项 (Dev Notes)

1. **命名规范**: 必须确保场景中所有节点的短名 (Short Name) 不重名。Maya 的很多操作依赖短名逻辑，重名会导致不可预知的错误。
2. **辅助脚本**: 项目根目录下的 `py_analyzer.py` 和 `print_scene.py` 是独立工具，分别用于分析 Python 代码结构和 Maya 场景层级结构。
