# MayaCraft 2.3 / Bendy Hero 发布验收

验收日期：2026-08-30  
目标环境：Autodesk Maya 2025 / Python 3.11 / PySide6 6.5.3

## 交付结论

Bendy「形变弧场」已经形成可演示、可撤销、可读回的完整闭环。它不是一张参数表：绑定师在中文
轮廓草绘台直接拖动肌腹和两端切线，零写入预览 C/S 型形变，再把意图安全应用到原生 Maya DG。
曲线形变和 Quaternion Twist 作为上下层协同，不依赖逐帧 Python 回调。

## 验收证据

- 黄金 Rig Graph：137 个声明对象、50 条物理行为、187 项读回结果；
- Bendy DG：NURBS、motionPath、curveInfo、distanceBetween、multiplyDivide 与矩阵连接；
- 安全写入：当前帧与场景指纹复核、锁定/引用阻断、单一 Undo、写后读回、失败回滚；
- 演示素材：6 套 Maya 2025 自生成场景；预览、成功、窄版、撤销、阻断 5 张生产界面截图；
- 自动验证：75 项离线测试；真实 Bendy DG、Rig Graph、Twist、UI 与六场景 mayapy 回归；
- 生命周期：隐藏 Maya PID `33448` 加载 `2.3.0 / PySide6`，通过首次启动、重复启动、热重载、
  关闭清理；测试前后均无 Maya 残留进程；
- 安装：`MayaCraft.mod` 以 2.3 写入当前用户 Maya 2025 modules 目录并读回一致。

## 作品集演示重点

先展示拖动时连续响应的形变带，再展示“生成预览”没有改场景；随后应用并旋转末端，证明 Bendy
轮廓变化时三枚 Twist 关节仍保持 `22.5° / 45° / 67.5°` 分布。最后锁定目标属性触发红色阻断，
再展示一次整块 Undo。这样能同时证明视觉交互、底层算法和制作安全性，而不是只展示按钮数量。
