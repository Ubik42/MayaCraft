# -*- coding: utf-8 -*-
"""
curve_logic.py
处理动画曲线的计算逻辑，包括Tween、偏移、缩放和特殊模式处理。
"""

import maya.cmds as cmds
import random


def get_selected_curves():
    """获取当前选中对象的动画曲线名称列表"""
    return cmds.keyframe(query=True, name=True, selected=True) or []


# ==========================================
# 1 & 2. Tween / Blend 逻辑
# ==========================================

def tween_keys(bias):
    """
    计算中间帧 (Tween Machine)。
    bias: 0.0 (上一帧) <-> 0.5 (线性中间) <-> 1.0 (下一帧)
    支持 Overshoot (例如 -0.5 或 1.5)
    """
    # 如果选中了具体的关键帧点，只处理选中的点
    # 如果只选中了物体没选点，处理当前时间

    # 策略：优先处理 Graph Editor 中选中的曲线点
    # 如果没有选点，则处理选中物体在当前时间轴的帧（如果有Key）

    sel_keys = cmds.keyframe(q=True, sl=True, name=True)
    use_selection = bool(sel_keys)

    curves = sel_keys if use_selection else cmds.keyframe(q=True, name=True, sl=True)
    if not curves:
        cmds.warning("请在曲线编辑器中选中关键帧，或选中带有动画的物体。")
        return

    current_time = cmds.currentTime(q=True)

    cmds.undoInfo(openChunk=True)
    try:
        for curve in curves:
            # 获取需要处理的时间点
            if use_selection:
                times = cmds.keyframe(curve, q=True, sl=True, tc=True)
            else:
                # 如果没选点，尝试处理当前帧
                if cmds.keyframe(curve, time=(current_time,), q=True, kc=True):
                    times = [current_time]
                else:
                    continue

            for t in times:
                # 寻找前后关键帧
                # index=True 返回的是浮点数，需要转int，且findKeyframe有些坑，这里用time search
                # 简单算法：获取所有关键帧时间，找到 t 的位置
                all_times = cmds.keyframe(curve, q=True, tc=True) or []
                if t not in all_times: continue

                idx = all_times.index(t)

                # 处理边界情况
                prev_val = None
                next_val = None

                if idx > 0:
                    prev_time = all_times[idx - 1]
                    prev_val = cmds.keyframe(curve, time=(prev_time,), q=True, vc=True)[0]

                if idx < len(all_times) - 1:
                    next_time = all_times[idx + 1]
                    next_val = cmds.keyframe(curve, time=(next_time,), q=True, vc=True)[0]

                current_val = cmds.keyframe(curve, time=(t,), q=True, vc=True)[0]

                # 计算新值
                final_val = current_val

                if prev_val is not None and next_val is not None:
                    # 标准 Tween: prev + (next - prev) * bias
                    final_val = prev_val + (next_val - prev_val) * bias
                elif prev_val is not None:
                    # 只有前一帧，向后推
                    final_val = prev_val  # 或者根据 bias 做一些衰减
                elif next_val is not None:
                    # 只有后一帧
                    final_val = next_val

                cmds.keyframe(curve, time=(t,), value_change=final_val, absolute=True)

    except Exception as e:
        print(f"Tween Error: {e}")
    finally:
        cmds.undoInfo(closeChunk=True)


# ==========================================
# 3. 数值精确控制
# ==========================================

def offset_value(amount):
    """增加或减少数值"""
    # relative=True, value_change=amount
    cmds.keyframe(animation='keys', relative=True, value_change=amount)


# ==========================================
# 4. 关键帧移动与重置
# ==========================================

def shift_time(amount):
    """左右移动关键帧 (时间轴)"""
    # option='over' 移动过去覆盖
    cmds.keyframe(animation='keys', relative=True, time_change=amount, option='over')


def zero_value():
    """将选中点数值归零"""
    # absolute=True, value_change=0
    cmds.keyframe(animation='keys', absolute=True, value_change=0)


# ==========================================
# 5. 高级滑块模式逻辑
# ==========================================

def apply_slider_mode(mode_name, slider_val):
    """
    根据选择的模式和滑块值(0-100)执行计算。
    这里的 slider_val 假设是一个系数，比如 0.5 是中间，0是起始，1是结束。
    或者对于 Noise 来说是强度。
    """
    # 归一化 slider_val 到 0.0 - 1.0 (根据需求也可以是 -1 到 1)
    factor = slider_val / 100.0

    # 获取选中曲线
    curves = cmds.keyframe(q=True, name=True, sl=True)
    if not curves: return

    cmds.undoInfo(openChunk=True)
    try:
        # --- 模式分发 ---
        if mode_name == "Blend To Neighbors":
            # 直接复用 Tween 逻辑
            tween_keys(factor)

        elif mode_name == "Noise":
            # 噪波：factor 决定噪波幅度
            for curve in curves:
                times = cmds.keyframe(curve, q=True, sl=True, tc=True) or []
                for t in times:
                    curr = cmds.keyframe(curve, time=(t,), q=True, vc=True)[0]
                    # 简单噪波算法：基于当前值的一定比例，或者绝对值
                    noise = (random.random() - 0.5) * 2 * factor * 10  # 这里的10是随意缩放
                    cmds.keyframe(curve, time=(t,), vc=curr + noise, absolute=True)

        elif mode_name == "Pull Push":
            # 拉伸/推挤：放大或缩小曲线幅度 (相对于平均值)
            for curve in curves:
                times = cmds.keyframe(curve, q=True, sl=True, tc=True) or []
                values = cmds.keyframe(curve, q=True, sl=True, vc=True) or []
                if not values: continue

                avg = sum(values) / len(values)
                # factor 0.5 = 不变, 1.0 = 放大, 0.0 = 变平
                # 调整 factor 映射： 50% slider -> 1.0 scale
                scale = factor * 2

                for t in times:
                    curr = cmds.keyframe(curve, time=(t,), q=True, vc=True)[0]
                    new_val = avg + (curr - avg) * scale
                    cmds.keyframe(curve, time=(t,), vc=new_val, absolute=True)

        elif mode_name == "Scale From Default":
            # 缩放相对于 0
            # factor 0.5 -> 1.0 scale
            scale = factor * 2
            cmds.keyframe(animation='keys', relative=True, value_change=scale, option='scale', valuePivot=0)

        # ... 可以继续添加其他模式 ...

    except Exception as e:
        print(f"Mode Error: {e}")
    finally:
        cmds.undoInfo(closeChunk=True)