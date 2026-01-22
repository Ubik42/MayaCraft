# -*- coding: utf-8 -*-
import maya.cmds as cmds
import hashlib
import colorsys
import base64


class NodeAnalyserLogic:
    # 需要智能追踪的数学节点类型
    MATH_NODE_TYPES = {
        'multMatrix', 'inverseMatrix', 'blendMatrix', 'composeMatrix',
        'decomposeMatrix', 'pickMatrix', 'aimMatrix', 'wtAddMatrix',
        'holdMatrix', 'passMatrix', 'fourByFourMatrix', 'transposeMatrix',
        'addMatrix',
        'plusMinusAverage', 'multiplyDivide', 'multDoubleLinear', 'reverse',
        'distanceBetween', 'vectorProduct', 'angleBetween',
        'clamp', 'setRange', 'remapValue', 'ramp',
        'blendColors', 'blendTwoAttr', 'blendWeighted', 'condition', 'choice',
        'quatToEuler', 'eulerToQuat', 'axisAngleToQuat', 'rotationToDirection',
        'unitConversion'
    }

    def __init__(self):
        self.dynamic_classes = set()
        self.mm_lines = []
        self.mm_nodes = set()

    def get_expanded_selection(self, initial_selection, smart_trace=True):
        """获取扩展的节点列表，并过滤 objectSet"""
        # 初始过滤
        valid_initial = [n for n in (cmds.ls(initial_selection, long=True) or []) if cmds.nodeType(n) != 'objectSet']

        if not smart_trace:
            return valid_initial

        nodes_to_process = list(valid_initial)
        final_nodes = set(nodes_to_process)
        visited = set(nodes_to_process)
        queue = list(nodes_to_process)

        while queue:
            current_node = queue.pop(0)
            connections = cmds.listConnections(current_node, source=True, destination=True) or []

            for conn in connections:
                try:
                    full_conn = cmds.ls(conn, long=True)[0]
                except:
                    full_conn = conn

                if full_conn in visited: continue

                try:
                    node_type = cmds.nodeType(full_conn)
                except:
                    continue

                # 过滤 objectSet
                if node_type == 'objectSet':
                    visited.add(full_conn)
                    continue

                if node_type in self.MATH_NODE_TYPES:
                    visited.add(full_conn)
                    final_nodes.add(full_conn)
                    queue.append(full_conn)

        return list(final_nodes)

    def get_connections(self, node, source=True, destination=True):
        """获取单个节点的连接信息"""
        conns = cmds.listConnections(node, s=source, d=destination, plugs=True, connections=True) or []
        results = []
        for i in range(0, len(conns), 2):
            my_plug_str = conns[i]
            other_plug_str = conns[i + 1]
            _, _, my_attr = my_plug_str.partition('.')
            other_node_part, _, other_attr = other_plug_str.partition('.')

            full_other_node = other_node_part
            if cmds.objExists(other_node_part):
                ls_res = cmds.ls(other_node_part, long=True)
                if ls_res: full_other_node = ls_res[0]

            if cmds.nodeType(full_other_node) == 'objectSet':
                continue

            short_other_node = full_other_node.split('|')[-1]
            results.append({
                'my_attr': my_attr,
                'other_node': short_other_node,
                'other_node_full': full_other_node,
                'other_attr': other_attr
            })
        return results

    def generate_markdown(self, nodes, include_trace_info=True):
        """生成 Markdown 文本"""
        nodes.sort()
        md = ["# Node Connections", ""]
        if include_trace_info:
            md.append("> 🌀 Smart Trace Active\n")

        for node in nodes:
            typ = cmds.nodeType(node)
            short = node.split('|')[-1]
            md.append(f"### `{short}` ({typ})")

            ins = self.get_connections(node, source=True, destination=False)
            outs = self.get_connections(node, source=False, destination=True)
            ins.sort(key=lambda x: x['my_attr'])
            outs.sort(key=lambda x: x['my_attr'])

            if not ins and not outs:
                md.append("> *No connections.*\n")
                continue

            md.append("| Dir | My Attr | Connected Node | Other Attr |")
            md.append("|:---:|:---|:---|:---|")
            for x in ins:
                md.append(f"| ← | `{x['my_attr']}` | `{x['other_node']}` | `{x['other_attr']}` |")
            for x in outs:
                md.append(f"| → | `{x['my_attr']}` | `{x['other_node']}` | `{x['other_attr']}` |")
            md.append("")
        return "\n".join(md)

    def generate_mermaid(self, nodes, show_in=True, show_out=True):
        """生成 Mermaid 代码"""
        self.mm_lines = ["graph LR"]
        # 基础样式
        self.mm_lines.append("    classDef transform fill:#333,stroke:#fff,stroke-width:2px,color:#fff;")
        self.mm_lines.append("    classDef joint fill:#2b6a99,stroke:#fff,stroke-width:2px,color:#fff;")
        self.mm_lines.append("    classDef matrix fill:#483C6C,stroke:#a6a,stroke-width:1px,color:#fff;")
        self.mm_lines.append("    classDef math fill:#2D5A4C,stroke:#4ea,stroke-width:1px,color:#fff;")
        self.mm_lines.append("    classDef constraint fill:#8B4513,stroke:#fa0,stroke-width:1px,color:#fff;")
        self.mm_lines.append(
            "    classDef router fill:#222,stroke:#666,stroke-width:1px,color:#ccc,rx:5,ry:5,font-size:9pt;")

        self.mm_nodes = set()
        self.dynamic_classes = set()
        raw_edges = []

        # 收集节点和边
        for node in nodes:
            self._mm_add_node(node)
            nid = self._mm_id(node)

            if show_in:
                ins = self.get_connections(node, source=True, destination=False)
                for x in ins:
                    oid = self._mm_id(x['other_node_full'])
                    self._mm_add_node(x['other_node_full'])
                    raw_edges.append({
                        'src_id': oid, 'dst_id': nid,
                        'src_attr': x['other_attr'], 'dst_attr': x['my_attr']
                    })

            if show_out:
                outs = self.get_connections(node, source=False, destination=True)
                for x in outs:
                    oid = self._mm_id(x['other_node_full'])
                    self._mm_add_node(x['other_node_full'])
                    raw_edges.append({
                        'src_id': nid, 'dst_id': oid,
                        'src_attr': x['my_attr'], 'dst_attr': x['other_attr']
                    })

        # 路由逻辑 (合并相同输出属性的连线)
        router_groups = {}
        for edge in raw_edges:
            key = (edge['src_id'], edge['src_attr'], edge['dst_attr'])
            if key not in router_groups: router_groups[key] = []
            router_groups[key].append(edge['dst_id'])

        processed_lines = set()

        for (src_id, src_attr, dst_attr), targets in router_groups.items():
            targets = list(set(targets))

            if len(targets) > 1:
                # 1对多：创建路由节点
                router_hash = hashlib.md5(f"{src_id}{src_attr}{dst_attr}".encode()).hexdigest()[:6]
                router_id = f"r_{router_hash}"
                router_label = f"{src_attr} → {dst_attr}".replace('"', "'")

                line_def = f'    {router_id}(["{router_label}"]):::router'
                self.mm_lines.append(line_def)

                line1 = f'    {src_id} --- {router_id}'
                if line1 not in processed_lines:
                    self.mm_lines.append(line1)
                    processed_lines.add(line1)

                for dst_id in targets:
                    line2 = f'    {router_id} --> {dst_id}'
                    if line2 not in processed_lines:
                        self.mm_lines.append(line2)
                        processed_lines.add(line2)
            else:
                # 1对1
                dst_id = targets[0]
                label = f"{src_attr} → {dst_attr}".replace('"', "'")
                line = f'    {src_id} -- "{label}" --> {dst_id}'
                if line not in processed_lines:
                    self.mm_lines.append(line)
                    processed_lines.add(line)

        return "\n".join(self.mm_lines)

    # --- Mermaid Helpers ---
    def _mm_id(self, name):
        return "n" + hashlib.md5(name.encode()).hexdigest()[:6]

    def _mm_add_node(self, fullname):
        nid = self._mm_id(fullname)
        if nid not in self.mm_nodes:
            short = fullname.split("|")[-1]
            try:
                typ = cmds.nodeType(fullname)
            except:
                typ = "unknown"

            style_class = "transform"
            if typ == 'joint':
                style_class = "joint"
            elif typ in self.MATH_NODE_TYPES:
                style_class = "matrix" if 'Matrix' in typ else "math"
            elif 'Constraint' in typ:
                style_class = "constraint"
            elif typ == 'transform':
                style_class = "transform"
            else:
                style_class = self._get_random_color_class(typ)

            self.mm_lines.append(f'    {nid}["{short}<br><small>({typ})</small>"]:::{style_class}')
            self.mm_nodes.add(nid)

    def _get_random_color_class(self, node_type):
        class_name = f"type_{node_type}"
        if class_name not in self.dynamic_classes:
            hash_val = int(hashlib.md5(node_type.encode()).hexdigest(), 16)
            hue = hash_val % 360
            r, g, b = colorsys.hls_to_rgb(hue / 360.0, 0.4, 0.6)
            hex_color = f"#{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"
            self.mm_lines.append(f"    classDef {class_name} fill:{hex_color},stroke:#fff,color:#fff;")
            self.dynamic_classes.add(class_name)
        return class_name