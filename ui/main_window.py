"""MayaCraft's character-first workspace and fault-isolated legacy tools."""

from __future__ import annotations

import importlib
import traceback
from typing import List, Optional, Tuple

from MayaCraft.adapters.maya.character_context import MayaCharacterScanner, MayaSelectionWatcher
from MayaCraft.adapters.maya.character_registration import CharacterRegistrationService
from MayaCraft.adapters.maya.selection import MayaSelectionService
from MayaCraft.adapters.maya.character_session import MayaCharacterSessionScanner
from MayaCraft.compat.qt import QtCore, QtWidgets
from MayaCraft.domain.character import CharacterSnapshot
from MayaCraft.domain.change import CharacterRegistrationPlan
from MayaCraft.domain.session import CharacterSession
from MayaCraft.ui.character_orbit import CharacterOrbit
from MayaCraft.ui.deformation_mri import DeformationMRIWorkspace
from MayaCraft.ui.motion_magnetism import MotionMagnetismWorkspace
from MayaCraft.ui.rig_graph import RigGraphWorkspace
from MayaCraft.ui.retarget import RetargetWorkspace
from MayaCraft.ui.character_stage import CharacterStage
from MayaCraft.ui.theme import stylesheet


TAB_SPECS: Tuple[Tuple[str, str, str], ...] = (
    ("绑定", "MayaCraft.ui.rigging.rigging_tab", "RiggingTab"),
    ("面部", "MayaCraft.ui.face.face_tab", "FaceTab"),
    ("蒙皮", "MayaCraft.ui.skinning.skinning_tab", "SkinningTab"),
    ("动画", "MayaCraft.ui.animation.animation_tab", "AnimationTab"),
    ("通用", "MayaCraft.ui.general.general_tab", "GeneralTab"),
)


class UnavailableTab(QtWidgets.QWidget):
    def __init__(self, feature: str, error: BaseException, parent=None):
        super().__init__(parent)
        layout = QtWidgets.QVBoxLayout(self)
        title = QtWidgets.QLabel(f"{feature}暂不可用")
        title.setStyleSheet("font-size:16px;font-weight:700;color:#FFB15C;")
        summary = QtWidgets.QLabel(f"{type(error).__name__}: {error}")
        summary.setWordWrap(True)
        details = QtWidgets.QPlainTextEdit()
        details.setReadOnly(True)
        details.setPlainText("".join(traceback.format_exception(type(error), error, error.__traceback__)))
        layout.addWidget(title)
        layout.addWidget(summary)
        layout.addWidget(details, 1)


class MetricWidget(QtWidgets.QWidget):
    def __init__(self, label: str, parent=None):
        super().__init__(parent)
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(1)
        self.value = QtWidgets.QLabel("—")
        self.value.setStyleSheet("font-size:22px;font-weight:800;color:#F4F7FF;")
        caption = QtWidgets.QLabel(label.upper())
        caption.setProperty("muted", True)
        caption.setStyleSheet("font-size:9px;letter-spacing:1px;")
        layout.addWidget(self.value)
        layout.addWidget(caption)


class MayaCraftMainWindow(QtWidgets.QWidget):
    OBJECT_NAME = "MayaCraftMainWindow"

    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("MayaCraft — 角色智能工作站")
        self.setObjectName(self.OBJECT_NAME)
        self.setMinimumSize(720, 520)
        self.setStyleSheet(stylesheet())
        self.feature_errors: List[Tuple[str, BaseException]] = []
        self._legacy_tabs: Optional[QtWidgets.QTabWidget] = None
        self._scan_pending = False
        self._snapshot = CharacterSnapshot.empty()
        self._session = CharacterSession()
        self._discovered_characters = ()
        self._pending_plan: Optional[CharacterRegistrationPlan] = None
        self._capsule_animation = None
        self._scanner = MayaCharacterScanner()
        self._session_scanner = MayaCharacterSessionScanner(self._scanner)
        self._registration = CharacterRegistrationService()
        self._selection = MayaSelectionService()
        self._watcher = MayaSelectionWatcher(self._queue_capture)
        self._init_ui()
        self._watcher.start()
        self.capture_character(refresh_session=True)

    def _init_ui(self) -> None:
        root = QtWidgets.QVBoxLayout(self)
        root.setContentsMargins(10, 10, 10, 10)
        root.setSpacing(8)
        root.addWidget(self._build_top_bar())
        body = QtWidgets.QHBoxLayout()
        body.setSpacing(8)
        body.addLayout(self._build_rail())
        self.stack = QtWidgets.QStackedWidget()
        self.character_workspace = self._build_character_workspace()
        self.stack.addWidget(self.character_workspace)
        self.deformation_workspace = DeformationMRIWorkspace()
        self.deformation_workspace.statusChanged.connect(self._show_mri_status)
        self.deformation_workspace.componentActivated.connect(self._select_mri_component)
        self.deformation_workspace.componentsActivated.connect(self._select_mri_components)
        self.deformation_workspace.influenceActivated.connect(self._select_mri_influence)
        self.stack.addWidget(self.deformation_workspace)
        self.motion_workspace = MotionMagnetismWorkspace()
        self.motion_workspace.statusChanged.connect(self._show_motion_status)
        self.stack.addWidget(self.motion_workspace)
        self.rig_graph_workspace = RigGraphWorkspace()
        self.rig_graph_workspace.statusChanged.connect(self._show_rig_graph_status)
        self.stack.addWidget(self.rig_graph_workspace)
        self.retarget_workspace = RetargetWorkspace()
        self.retarget_workspace.statusChanged.connect(self._show_retarget_status)
        self.retarget_workspace.nodesActivated.connect(self._select_retarget_nodes)
        self.stack.addWidget(self.retarget_workspace)
        body.addWidget(self.stack, 1)
        root.addLayout(body, 1)
        root.addWidget(self._build_status_strip())

    def _build_top_bar(self):
        bar = QtWidgets.QFrame()
        bar.setObjectName("TopBar")
        layout = QtWidgets.QHBoxLayout(bar)
        layout.setContentsMargins(16, 9, 12, 9)
        brand = QtWidgets.QLabel("MAYA<span style='color:#42E8FF'>CRAFT</span>")
        brand.setTextFormat(QtCore.Qt.RichText)
        brand.setStyleSheet("font-size:16px;font-weight:900;letter-spacing:2px;")
        subtitle = QtWidgets.QLabel("角色智能 / 实时")
        subtitle.setProperty("muted", True)
        subtitle.setStyleSheet("font-size:9px;letter-spacing:1px;")
        self.auto_label = QtWidgets.QLabel("●  MAYA 已连接")
        self.auto_label.setStyleSheet("color:#A7FF6A;font-size:10px;font-weight:700;")
        self.character_orbit = CharacterOrbit()
        self.character_orbit.characterActivated.connect(self._activate_session_character)
        self.pin_button = QtWidgets.QPushButton("◇ 固定")
        self.pin_button.setObjectName("PinCharacterButton")
        self.pin_button.setToolTip("将当前角色固定在本次 MayaCraft 会话中")
        self.pin_button.clicked.connect(self._pin_current_character)
        self.pin_button.setEnabled(False)
        layout.addWidget(brand)
        layout.addSpacing(12)
        layout.addWidget(subtitle)
        layout.addWidget(self.character_orbit, 1)
        layout.addWidget(self.pin_button)
        layout.addWidget(self.auto_label)
        return bar

    def _build_rail(self):
        layout = QtWidgets.QVBoxLayout()
        layout.setSpacing(8)
        self.mode_group = QtWidgets.QButtonGroup(self)
        self.mode_group.setExclusive(True)
        character = self._rail_button("角", "角色舞台", checked=True)
        self.mode_group.addButton(character)
        character.clicked.connect(lambda: self.stack.setCurrentWidget(self.character_workspace))
        layout.addWidget(character)
        deformation = self._rail_button("形", "变形 MRI")
        self.mode_group.addButton(deformation)
        deformation.clicked.connect(self.show_deformation)
        layout.addWidget(deformation)
        motion = self._rail_button("动", "运动磁场")
        self.mode_group.addButton(motion)
        motion.clicked.connect(self.show_motion)
        layout.addWidget(motion)
        rig_graph = self._rail_button("图", "绑定图编译器")
        self.mode_group.addButton(rig_graph)
        rig_graph.clicked.connect(self.show_rig_graph)
        layout.addWidget(rig_graph)
        retarget = self._rail_button("映", "动画与语义重定向")
        self.mode_group.addButton(retarget)
        retarget.clicked.connect(self.show_retarget)
        layout.addWidget(retarget)
        for text, tab_index, tooltip in (("绑", 0, "旧版绑定工具"), ("蒙", 2, "蒙皮工具"), ("帧", 3, "动画工具")):
            button = self._rail_button(text, tooltip)
            self.mode_group.addButton(button)
            button.clicked.connect(lambda _checked=False, index=tab_index: self.show_legacy(index))
            layout.addWidget(button)
        layout.addStretch(1)
        legacy = self._rail_button("···", "全部旧版工具")
        self.mode_group.addButton(legacy)
        legacy.clicked.connect(lambda: self.show_legacy(0))
        layout.addWidget(legacy)
        return layout

    @staticmethod
    def _rail_button(text: str, tooltip: str, checked: bool = False):
        button = QtWidgets.QPushButton(text)
        button.setObjectName("RailButton")
        button.setToolTip(tooltip)
        button.setCheckable(True)
        button.setChecked(checked)
        return button

    def _build_character_workspace(self):
        workspace = QtWidgets.QWidget()
        layout = QtWidgets.QHBoxLayout(workspace)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.setSpacing(8)
        self.stage = CharacterStage()
        self.stage.nodeHovered.connect(self._hover_canvas_node)
        self.stage.nodeActivated.connect(self._select_canvas_node)
        self.stage.moduleFocused.connect(self._focus_rig_module)
        layout.addWidget(self.stage, 3)
        layout.addWidget(self._build_inspector(), 2)
        return workspace

    def _build_inspector(self):
        panel = QtWidgets.QFrame()
        panel.setObjectName("Inspector")
        panel.setMinimumWidth(230)
        layout = QtWidgets.QVBoxLayout(panel)
        layout.setContentsMargins(20, 20, 20, 20)
        layout.setSpacing(14)
        eyebrow = QtWidgets.QLabel("当前角色")
        eyebrow.setStyleSheet("color:#9D6CFF;font-size:9px;font-weight:800;letter-spacing:2px;")
        self.character_name = QtWidgets.QLabel("等待选择")
        self.character_name.setWordWrap(True)
        self.character_name.setStyleSheet("font-size:22px;font-weight:800;")
        self.root_path = QtWidgets.QLabel("在 Maya 中选择角色的任意部分。")
        self.root_path.setProperty("muted", True)
        self.root_path.setWordWrap(True)
        layout.addWidget(eyebrow)
        layout.addWidget(self.character_name)
        layout.addWidget(self.root_path)
        metrics = QtWidgets.QGridLayout()
        metrics.setHorizontalSpacing(18)
        metrics.setVerticalSpacing(12)
        self.metrics = {}
        for index, (key, label) in enumerate((("joints", "关节"), ("meshes", "网格"), ("controls", "控制器"), ("skins", "蒙皮连接"))):
            widget = MetricWidget(label)
            self.metrics[key] = widget
            metrics.addWidget(widget, index // 2, index % 2)
        layout.addLayout(metrics)
        score_header = QtWidgets.QHBoxLayout()
        score_label = QtWidgets.QLabel("绑定信号")
        score_label.setProperty("muted", True)
        self.score_value = QtWidgets.QLabel("0%")
        self.score_value.setStyleSheet("color:#42E8FF;font-weight:800;")
        score_header.addWidget(score_label)
        score_header.addStretch(1)
        score_header.addWidget(self.score_value)
        self.score_bar = QtWidgets.QProgressBar()
        self.score_bar.setRange(0, 100)
        self.score_bar.setTextVisible(False)
        layout.addLayout(score_header)
        layout.addWidget(self.score_bar)
        self.namespace_label = QtWidgets.QLabel("命名空间  —")
        self.namespace_label.setProperty("muted", True)
        self.reference_label = QtWidgets.QLabel("场景自有")
        self.reference_label.setStyleSheet("color:#A7FF6A;font-size:9px;font-weight:700;")
        layout.addWidget(self.namespace_label)
        layout.addWidget(self.reference_label)
        self.registration_state = QtWidgets.QLabel("○  角色尚未关联")
        self.registration_state.setStyleSheet("color:#FFB15C;font-size:9px;font-weight:800;letter-spacing:1px;")
        layout.addWidget(self.registration_state)
        self.register_button = QtWidgets.QPushButton("预览角色关联  +")
        self.register_button.setObjectName("RegisterButton")
        self.register_button.setToolTip("在修改场景前预览 MayaCraft 元数据")
        self.register_button.clicked.connect(self.preview_registration)
        layout.addWidget(self.register_button)
        layout.addWidget(self._build_change_capsule())
        layout.addStretch(1)
        capture = QtWidgets.QPushButton("捕获当前选择  ↗")
        capture.setObjectName("CaptureSecondaryButton")
        capture.setToolTip("重新扫描当前 Maya 选择所在的角色层级")
        capture.clicked.connect(lambda: self.capture_character(refresh_session=True))
        layout.addWidget(capture)
        self.inspector_scroll = QtWidgets.QScrollArea()
        self.inspector_scroll.setObjectName("InspectorScroll")
        self.inspector_scroll.setWidgetResizable(True)
        self.inspector_scroll.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.inspector_scroll.setHorizontalScrollBarPolicy(QtCore.Qt.ScrollBarAlwaysOff)
        self.inspector_scroll.setWidget(panel)
        self.inspector_scroll.setMinimumWidth(250)
        self.inspector_scroll.setMaximumWidth(390)
        return self.inspector_scroll

    def _build_change_capsule(self):
        self.change_capsule = QtWidgets.QFrame()
        self.change_capsule.setObjectName("ChangeCapsule")
        self.change_capsule.setMaximumHeight(0)
        self.change_capsule.setMinimumHeight(0)
        layout = QtWidgets.QVBoxLayout(self.change_capsule)
        layout.setContentsMargins(12, 10, 12, 10)
        layout.setSpacing(7)
        self.capsule_eyebrow = QtWidgets.QLabel("变更预览 / 零写入")
        self.capsule_eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:800;letter-spacing:1px;")
        self.capsule_title = QtWidgets.QLabel("关联当前角色")
        self.capsule_title.setStyleSheet("font-size:13px;font-weight:800;")
        self.capsule_details = QtWidgets.QLabel()
        self.capsule_details.setProperty("muted", True)
        self.capsule_details.setWordWrap(True)
        self.capsule_details.setStyleSheet("font-size:9px;")
        actions = QtWidgets.QHBoxLayout()
        self.cancel_button = QtWidgets.QPushButton("取消")
        self.cancel_button.setObjectName("CapsuleCancel")
        self.cancel_button.clicked.connect(lambda: self._set_capsule_open(False))
        self.apply_button = QtWidgets.QPushButton("应用并验证")
        self.apply_button.setObjectName("CapsuleApply")
        self.apply_button.clicked.connect(self.apply_registration)
        actions.addWidget(self.cancel_button)
        actions.addWidget(self.apply_button, 1)
        layout.addWidget(self.capsule_eyebrow)
        layout.addWidget(self.capsule_title)
        layout.addWidget(self.capsule_details)
        layout.addLayout(actions)
        return self.change_capsule

    def _build_status_strip(self):
        strip = QtWidgets.QFrame()
        strip.setObjectName("StatusStrip")
        layout = QtWidgets.QHBoxLayout(strip)
        layout.setContentsMargins(12, 6, 12, 6)
        self.status_dot = QtWidgets.QLabel("●")
        self.status_dot.setStyleSheet("color:#8791A8;")
        self.status_text = QtWidgets.QLabel("等待角色信号")
        self.status_text.setProperty("muted", True)
        self.status_id = QtWidgets.QLabel("只读 / 安全扫描")
        self.status_id.setProperty("muted", True)
        self.status_id.setStyleSheet("font-size:9px;letter-spacing:1px;")
        layout.addWidget(self.status_dot)
        layout.addWidget(self.status_text)
        layout.addStretch(1)
        layout.addWidget(self.status_id)
        return strip

    def _queue_capture(self) -> None:
        if self._scan_pending:
            return
        self._scan_pending = True
        QtCore.QTimer.singleShot(80, self._capture_queued)

    def _capture_queued(self) -> None:
        self._scan_pending = False
        self.capture_character()

    def capture_character(self, refresh_session: bool = False) -> None:
        try:
            if refresh_session:
                self._scanner.invalidate()
            snapshot = self._scanner.capture_selection()
            if refresh_session:
                self._discovered_characters = self._session_scanner.discover()
        except Exception as exc:
            snapshot = CharacterSnapshot.empty(f"捕获失败：{type(exc).__name__}: {exc}")
        self._present_snapshot(snapshot)

    def _present_snapshot(self, snapshot: CharacterSnapshot) -> None:
        self._snapshot = snapshot
        self.deformation_workspace.set_snapshot(snapshot)
        self._session = self._session.reconcile(self._discovered_characters, snapshot)
        self.character_orbit.set_session(self._session)
        active = next((item for item in self._session.characters if item.stable_id == self._session.active_id), None)
        self.pin_button.setEnabled(not snapshot.is_empty and not bool(active and active.pinned))
        self.pin_button.setText("◆ 已固定" if active and active.pinned else "◇ 固定")
        self.stage.set_snapshot(snapshot)
        self.character_name.setText(snapshot.display_name if not snapshot.is_empty else "等待选择")
        self.root_path.setText(snapshot.root or snapshot.message)
        values = (snapshot.joint_count, snapshot.mesh_count, snapshot.control_count, snapshot.skin_cluster_count)
        for widget, value in zip(self.metrics.values(), values):
            widget.value.setText(str(value) if not snapshot.is_empty else "—")
        self.score_bar.setValue(snapshot.score)
        self.score_value.setText(f"{snapshot.score}%")
        self.namespace_label.setText(f"命名空间  {snapshot.namespace}")
        self.reference_label.setText("引用资产 / 只读" if snapshot.referenced else "场景自有 / 只读")
        if snapshot.registered:
            self.registration_state.setText(f"●  已关联 / 架构 {snapshot.schema_version}")
            self.registration_state.setStyleSheet("color:#A7FF6A;font-size:9px;font-weight:800;letter-spacing:1px;")
            self.register_button.setText("角色已关联 / 正常")
            self.register_button.setEnabled(False)
        elif snapshot.is_empty:
            self.registration_state.setText("○  没有角色上下文")
            self.registration_state.setStyleSheet("color:#8791A8;font-size:9px;font-weight:800;letter-spacing:1px;")
            self.register_button.setText("预览角色关联  +")
            self.register_button.setEnabled(False)
        elif snapshot.referenced:
            self.registration_state.setText("◇  需要修改源资产")
            self.registration_state.setStyleSheet("color:#FFB15C;font-size:9px;font-weight:800;letter-spacing:1px;")
            self.register_button.setText("引用资产为只读")
            self.register_button.setEnabled(True)
        else:
            self.registration_state.setText("○  角色尚未关联")
            self.registration_state.setStyleSheet("color:#FFB15C;font-size:9px;font-weight:800;letter-spacing:1px;")
            self.register_button.setText("预览角色关联  +")
            self.register_button.setEnabled(True)
        self.status_text.setText(snapshot.message)
        self.status_dot.setStyleSheet("color:#42E8FF;" if not snapshot.is_empty else "color:#8791A8;")
        self.status_id.setText(f"ID {snapshot.stable_id}" if snapshot.stable_id else "只读 / 安全扫描")

    def _hover_canvas_node(self, path: str) -> None:
        if path:
            self.status_id.setText(f"悬停  {path.rsplit('|', 1)[-1]}")
        else:
            self.status_id.setText(f"ID {self._snapshot.stable_id}" if self._snapshot.stable_id else "只读 / 安全扫描")

    def _select_canvas_node(self, path: str) -> None:
        try:
            selected = self._selection.select_node(path)
        except Exception as exc:
            self.status_dot.setStyleSheet("color:#FF5C7C;")
            self.status_text.setText(f"画布选择失败：{type(exc).__name__}: {exc}")
            return
        self.status_dot.setStyleSheet("color:#FFDB69;")
        self.status_text.setText(f"已在 Maya 中选择 {selected.rsplit('|', 1)[-1]}")

    def _focus_rig_module(self, key: str) -> None:
        if key:
            module = self.stage.module_health(key)
            findings = "; ".join(module.findings) if module and module.findings else "层级与对称状态正常"
            self.status_text.setText(f"已聚焦 {module.label if module else key}：{findings}")
            self.status_id.setText(f"模块  {module.score if module else 0}%")
        else:
            self.status_text.setText("正在显示完整的已捕获绑定图")
            self.status_id.setText(f"ID {self._snapshot.stable_id}")

    def _activate_session_character(self, stable_id: str) -> None:
        root = self._session.root_for(stable_id)
        if not root:
            return
        try:
            self._selection.select_node(root)
        except Exception as exc:
            self.status_dot.setStyleSheet("color:#FF5C7C;")
            self.status_text.setText(f"角色切换失败：{type(exc).__name__}: {exc}")
            return
        self.status_dot.setStyleSheet("color:#A7FF6A;")
        self.status_text.setText(f"正在切换角色信号至 {root.rsplit('|', 1)[-1]}")

    def _pin_current_character(self) -> None:
        if self._snapshot.is_empty:
            return
        self._session = self._session.pin(self._snapshot.stable_id)
        self.character_orbit.set_session(self._session)
        self.pin_button.setText("◆ 已固定")
        self.pin_button.setEnabled(False)
        self.status_text.setText(f"已将 {self._snapshot.display_name} 固定到本次 MayaCraft 会话")

    def show_deformation(self) -> None:
        self.deformation_workspace.set_snapshot(self._snapshot)
        self.stack.setCurrentWidget(self.deformation_workspace)

    def _show_mri_status(self, message: str) -> None:
        self.status_dot.setStyleSheet("color:#FF5C7C;")
        self.status_text.setText(message)
        if self.deformation_workspace.result:
            self.status_id.setText(f"MRI {self.deformation_workspace.result.report.score}%")

    def show_motion(self) -> None:
        self.stack.setCurrentWidget(self.motion_workspace)

    def show_rig_graph(self) -> None:
        self.rig_graph_workspace.refresh_plan()
        self.stack.setCurrentWidget(self.rig_graph_workspace)

    def show_retarget(self) -> None:
        self.stack.setCurrentWidget(self.retarget_workspace)

    def _show_retarget_status(self, message: str) -> None:
        self.status_dot.setStyleSheet("color:#A7FF6A;")
        self.status_text.setText(message)
        profile = self.retarget_workspace.profile
        self.status_id.setText(
            f"重定向 {len(profile.mappings)} 个语义" if profile else "重定向等待骨架"
        )

    def _select_retarget_nodes(self, nodes) -> None:
        try:
            selected = self._selection.select_items(nodes)
        except Exception as exc:
            self.status_text.setText(f"重定向节点定位失败：{type(exc).__name__}: {exc}")
            return
        self.status_text.setText(f"已同时定位 {len(selected)} 个源/目标语义关节")

    def _show_rig_graph_status(self, message: str) -> None:
        self.status_dot.setStyleSheet("color:#42E8FF;")
        self.status_text.setText(message)
        plan = self.rig_graph_workspace.plan
        self.status_id.setText(f"绑定图 {len(plan.changes) if plan else 0} 个节点")

    def _show_motion_status(self, message: str) -> None:
        self.status_dot.setStyleSheet("color:#9D6CFF;")
        self.status_text.setText(message)
        capture = self.motion_workspace.capture_result
        if capture:
            self.status_id.setText(f"运动 {len(capture.samples)} 个采样")

    def _select_mri_component(self, component: str) -> None:
        try:
            selected = self._selection.select_item(component)
        except Exception as exc:
            self.status_text.setText(f"MRI 选择失败：{type(exc).__name__}: {exc}")
            return
        self.status_text.setText(f"已在 Maya 中选择热点 {selected.rsplit('.', 1)[-1]}")

    def _select_mri_components(self, components) -> None:
        try:
            selected = self._selection.select_items(components)
        except Exception as exc:
            self.status_text.setText(f"MRI 局部刷选失败：{type(exc).__name__}: {exc}")
            return
        self.status_text.setText(f"已在 Maya 中刷选 {len(selected)} 个局部顶点")

    def _select_mri_influence(self, influence: str) -> None:
        try:
            selected = self._selection.select_node(influence)
        except Exception as exc:
            self.status_text.setText(f"MRI 影响骨骼定位失败：{type(exc).__name__}: {exc}")
            return
        self.status_text.setText(f"已聚焦影响骨骼 {selected.rsplit('|', 1)[-1]}")

    def preview_registration(self) -> None:
        self.cancel_button.setText("取消")
        self.apply_button.setText("应用并验证")
        try:
            plan = self._registration.plan(self._snapshot)
        except Exception as exc:
            self._show_capsule_error(f"无法生成预览：{type(exc).__name__}: {exc}")
            return
        self._pending_plan = plan
        if plan.blockers:
            self.capsule_eyebrow.setText("变更已阻断 / 零写入")
            self.capsule_eyebrow.setStyleSheet("color:#FF5C7C;font-size:8px;font-weight:800;letter-spacing:1px;")
            self.capsule_title.setText("当前无法关联角色")
            self.capsule_details.setText("\n".join(plan.blockers))
            self.apply_button.setEnabled(False)
        elif plan.is_noop:
            self.capsule_eyebrow.setText("验证通过 / 无需变更")
            self.capsule_eyebrow.setStyleSheet("color:#A7FF6A;font-size:8px;font-weight:800;letter-spacing:1px;")
            self.capsule_title.setText("角色已经关联")
            self.capsule_details.setText("场景元数据已经符合当前 MayaCraft 架构。")
            self.apply_button.setEnabled(False)
        else:
            self.capsule_eyebrow.setText("变更预览 / 零写入")
            self.capsule_eyebrow.setStyleSheet("color:#42E8FF;font-size:8px;font-weight:800;letter-spacing:1px;")
            self.capsule_title.setText(f"关联 {self._snapshot.display_name}")
            lines = []
            for change in plan.changes:
                action = "创建" if change.creates_attribute else "更新"
                lines.append(f"{action}  {change.label}  →  {change.target_value}")
            self.capsule_details.setText("\n".join(lines))
            self.apply_button.setEnabled(True)
        self._set_capsule_open(True)

    def apply_registration(self) -> None:
        if self._pending_plan is None or not self._pending_plan.can_apply:
            return
        self.apply_button.setEnabled(False)
        self.apply_button.setText("正在验证…")
        QtWidgets.QApplication.processEvents()
        try:
            receipt = self._registration.apply(self._pending_plan)
        except Exception as exc:
            self._show_capsule_error(f"事务已回滚：{type(exc).__name__}: {exc}")
            return
        self.capsule_eyebrow.setText("验证通过 / 可撤销")
        self.capsule_eyebrow.setStyleSheet("color:#A7FF6A;font-size:8px;font-weight:800;letter-spacing:1px;")
        self.capsule_title.setText("角色信号已锁定")
        self.capsule_details.setText(receipt.message)
        self.apply_button.setText("验证通过")
        self.cancel_button.setText("关闭")
        self._pending_plan = None
        self.capture_character(refresh_session=True)
        self.status_text.setText(receipt.message)
        self.status_dot.setStyleSheet("color:#A7FF6A;")
        QtCore.QTimer.singleShot(1800, lambda: self._set_capsule_open(False))

    def _show_capsule_error(self, message: str) -> None:
        self._pending_plan = None
        self.capsule_eyebrow.setText("事务中止 / 场景安全")
        self.capsule_eyebrow.setStyleSheet("color:#FF5C7C;font-size:8px;font-weight:800;letter-spacing:1px;")
        self.capsule_title.setText("没有保留任何变更")
        self.capsule_details.setText(message)
        self.apply_button.setText("应用并验证")
        self.apply_button.setEnabled(False)
        self._set_capsule_open(True)

    def _set_capsule_open(self, opened: bool) -> None:
        start = self.change_capsule.maximumHeight()
        end = 176 if opened else 0
        if start == end:
            return
        animation = QtCore.QPropertyAnimation(self.change_capsule, b"maximumHeight", self)
        animation.setDuration(230)
        animation.setStartValue(start)
        animation.setEndValue(end)
        animation.setEasingCurve(QtCore.QEasingCurve.OutCubic)
        animation.start()
        self._capsule_animation = animation

    def show_legacy(self, tab_index: int = 0) -> None:
        if self._legacy_tabs is None:
            self._legacy_tabs = QtWidgets.QTabWidget()
            for label, module_name, class_name in TAB_SPECS:
                self._legacy_tabs.addTab(self._create_tab(label, module_name, class_name), label)
            self.stack.addWidget(self._legacy_tabs)
        self._legacy_tabs.setCurrentIndex(tab_index)
        self.stack.setCurrentWidget(self._legacy_tabs)

    def _create_tab(self, label: str, module_name: str, class_name: str):
        try:
            module = importlib.import_module(module_name)
            tab_class = getattr(module, class_name)
            return tab_class(parent=self)
        except Exception as exc:
            self.feature_errors.append((label, exc))
            return UnavailableTab(label, exc, parent=self)

    def shutdown(self) -> None:
        self._watcher.stop()

    def closeEvent(self, event) -> None:
        self.shutdown()
        super().closeEvent(event)
