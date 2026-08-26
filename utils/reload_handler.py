"""Predictable development-time module reloading for MayaCraft."""

from __future__ import annotations

import importlib
import sys
from types import ModuleType
from typing import Collection, List


def loaded_module_names(package_name: str) -> List[str]:
    """Return loaded package modules in child-before-parent order."""
    prefix = package_name + "."
    names = [
        name
        for name, module in sys.modules.items()
        if module is not None and (name == package_name or name.startswith(prefix))
    ]
    return sorted(names, key=lambda name: (name.count("."), name), reverse=True)


def reload_package(
    package_name: str, *, exclude: Collection[str] = ()
) -> List[str]:
    """Reload already imported modules belonging to ``package_name``.

    Failures are surfaced instead of leaving Maya in a silently half-reloaded
    state. The returned names are useful for diagnostics and tests.
    """
    excluded = set(exclude)
    reloaded: List[str] = []
    for name in loaded_module_names(package_name):
        if name in excluded:
            continue
        module = sys.modules.get(name)
        if not isinstance(module, ModuleType):
            continue
        try:
            importlib.reload(module)
        except Exception as exc:
            raise RuntimeError(f"Failed to reload module {name!r}") from exc
        reloaded.append(name)
    return reloaded


def print_loaded_modules(package_name: str = "MayaCraft") -> None:
    """Print matching modules in Maya's Script Editor."""
    for name in loaded_module_names(package_name):
        print(name)
