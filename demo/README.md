# MayaCraft 演示素材

这里的场景全部由 `generate/generate_rig_switching_scenes.py` 确定性生成，不包含网络下载素材、
公司资产、角色模型或贴图。骨架尺寸、命名、动画帧和预期缺陷都写在生成脚本中，可以审计和复现。

## 一键重新生成

在仓库根目录运行：

```powershell
& 'C:\Program Files\Autodesk\Maya2025\bin\mayapy.exe' .\demo\generate\generate_rig_switching_scenes.py
```

生成结果位于 `demo/scenes/`。每次生成会新建 Maya 场景，不读取或修改用户正在工作的文件。

## 推荐演示顺序

1. `mayacraft_match_success.ma`：第 12 帧预览并应用左臂 FK→IK，观察输出骨架和关键帧；随后撤销。
2. `mayacraft_space_switch.ma`：第 12 帧把左手从全局切到胸腔，播放前后帧观察手腕无跳变和后续跟随。
3. `mayacraft_match_locked.ma`：预览 FK→IK，展示锁定通道在写入前被阻断。
4. `mayacraft_twist_sculpt.ma`：第 12 帧进入 Twist 塑形舱，展示 90° 纯扭转、偏置预览与整块撤销。
5. `mayacraft_skeleton_blocked.ma`：扫描残缺骨架，展示缺少语义时不允许构建。

详细用途、分类和来源见 `manifest.json`。
