# Project Structure

- **路径**: `F:\05 3D\Maya\Python\MyWork\MayaCraft`
- **模式**: 结构模式 (仅文件)

```text
.
├── 🐍 __init__.py
├── 📦 core
│   ├── 🐍 __init__.py
│   ├── 🐍 attribute.py
│   ├── 🐍 controller.py
│   ├── 📦 logic
│   │   ├── 🐍 __init__.py
│   │   ├── 🐍 general_tab_logic.py
│   │   └── 📦 rigging
│   │       ├── 🐍 __init__.py
│   │       ├── 🐍 build_widget_logic.py
│   │       ├── 🐍 finalize_widget_logic.py
│   │       └── 🐍 import_widget_logic.py
│   ├── 🐍 name.py
│   └── 📦 rigging
│       ├── 🐍 __init__.py
│       ├── 🐍 bone.py
│       ├── 🐍 build_plan.py
│       ├── 🐍 fk.py
│       ├── 🐍 ik.py
│       ├── 🐍 ikfk.py
│       ├── 🐍 label.py
│       └── 🐍 stretchy.py
├── 🐍 drag_install.py
├── 🐍 launch.py
├── 📦 ui
│   ├── 🐍 __init__.py
│   ├── 📦 animation
│   │   ├── 🐍 __init__.py
│   │   └── 🐍 animation_tab.py
│   ├── 🐍 collapsible_widget.py
│   ├── 📦 general
│   │   ├── 🐍 __init__.py
│   │   └── 🐍 general_tab.py
│   ├── 🐍 main_window.py
│   ├── 📦 rigging
│   │   ├── 🐍 __init__.py
│   │   ├── 🐍 build_widget_ui.py
│   │   ├── 🐍 finalize_widget_ui.py
│   │   ├── 🐍 import_widget_ui.py
│   │   └── 🐍 rigging_tab.py
│   └── 📦 skinning
│       ├── 🐍 __init__.py
│       └── 🐍 skinning_tab.py
├── 📦 utils
│   ├── 🐍 __init__.py
│   ├── 🐍 file_handler.py
│   ├── 🐍 json_handler.py
│   └── 🐍 reload_handler.py
└── 🐍 检测所有python包内容.py
```
