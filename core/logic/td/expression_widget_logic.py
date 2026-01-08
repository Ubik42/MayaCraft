# -*- coding: utf-8 -*-
import maya.cmds as cmds
import maya.mel as mel
import re


def get_all_expressions():
    return sorted(cmds.ls(type='expression') or [])


def get_expression_code(node_name):
    return cmds.expression(node_name, q=True, s=True) if cmds.objExists(node_name) else ""


def format_code_to_html(raw_code):
    """仅高亮对象名部分，属性名保持普通文本"""
    if not raw_code: return ""

    html = raw_code.replace("<", "&lt;").replace(">", "&gt;").replace("\n", "<br>")

    # 正则：组1匹配对象(含命名空间)，组2匹配点和属性
    pattern = r"(\b[\w|:]+)(\.[\w]+\b)"

    # 替换逻辑：只给组1加 <a> 标签
    linked_html = re.sub(
        pattern,
        r'<a href="\1" style="color: #82cfff; text-decoration: none; font-weight: bold;">\1</a>\2',
        html
    )

    return f"""
    <div style='color: #dcdcdc; font-family: "Consolas", monospace; font-size: 12pt; line-height: 150%;'>
        {linked_html}
    </div>
    """


def jump_to_expression_editor(exp_node):
    """强制以 'By Expression Name' 模式打开并定位"""
    if not cmds.objExists(exp_node): return

    # 确保编辑器窗口存在
    mel.eval('ExpressionEditor;')
    mel.eval('EEselectFilterCB expression;')

def select_obj(obj_name):
    if cmds.objExists(obj_name):
        cmds.select(obj_name)