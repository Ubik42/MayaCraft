# -*- coding: utf-8 -*-
import importlib

# ==========================================
# 1. 模块导入 (使用相对导入语法)
# ==========================================
# 注意：这里定义的变量名 (例如 weights, targets) 必须与下面 reload 中的名字完全一致
from core.face.utils import control, weights, actions, units, targets

from . import selection # 定位器创建

# 部位模块
from core.face.systems import bulge, brow, cheek, nose, eye, lip, jaw

# 总构建模块
from . import build

# ==========================================
# 2. 模块重载 (Python 3 写法)
# 注意顺序：先底层工具，后上层逻辑
# ==========================================

# 第一梯队：底层工具
importlib.reload(control)
importlib.reload(actions)
importlib.reload(weights)  # [修正] weight -> weights
importlib.reload(units)

# 第二梯队：数据与辅助
importlib.reload(selection)
importlib.reload(targets)  # [修正] targes -> targets

# 第三梯队：具体部位 (相互之间可能有轻微依赖，顺序大致如下)
importlib.reload(jaw)    # 下颚通常是基础
importlib.reload(lip)    # 嘴唇依赖下颚
importlib.reload(brow)
importlib.reload(eye)
importlib.reload(nose)
importlib.reload(cheek)  # [修正] check -> cheek
importlib.reload(bulge)

# 第四梯队：总指挥
importlib.reload(build)

# 注意：我们移除了 'ui' 模块，因为现在使用的是 MayaCraft 的 face_tab