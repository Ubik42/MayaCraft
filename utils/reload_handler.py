# -*- coding: utf-8 -*-
"""
================================================================================
reload_handler.py
================================================================================
Author: Gemini AI
Date: 2025-11-18
Description:
    A utility module for handling module reloading in Python environments like
    Autodesk Maya. Provides functions to print loaded modules and perform
    deep (recursive) reloads on packages or all loaded modules.

    This is essential for iterative development workflows, allowing developers
    to see code changes without restarting the main application.

Functions:
    - print_loaded_modules(filter_str=""): Prints all currently loaded modules,
      optionally filtered by a string.
    - reload_package(package_name): Performs a deep reload of a specific
      package and all its sub-modules.
    - reload_all_user_modules(exclude_packages=None): Attempts to reload all
      modules that are not part of the standard library or core application.

Usage:
    import_widget reload_handler

    # See what's loaded
    reload_handler.print_loaded_modules(filter_str="my_tool")

    # Reload your specific tool package after making code changes
    reload_handler.reload_package("my_tool")

    # In desperate times, reload everything possible
    reload_handler.reload_all_user_modules(exclude_packages=['PySide2', 'shiboken2'])

================================================================================
"""
import sys
import os
import importlib

# --- Helper Function to determine the Python interpreter path ---
# This helps in identifying which modules are standard library vs. user-installed.
PYTHON_INTERPRETER_PATH = os.path.dirname(sys.executable).lower()
PYTHON_LIB_PATH = os.path.join(sys.prefix, 'lib').lower()


def _is_user_module(module):
    """
    A helper function to heuristically determine if a module is a user-defined
    module rather than a standard library or third-party binary module.

    Args:
        module (module object): The module to check.

    Returns:
        bool: True if it's likely a user module, False otherwise.
    """
    # Exclude built-in modules
    if not hasattr(module, '__file__') or module.__file__ is None:
        return False

    module_path = module.__file__.lower()

    # Exclude modules from the standard library and Python's core directories
    if module_path.startswith(PYTHON_INTERPRETER_PATH) or module_path.startswith(PYTHON_LIB_PATH):
        return False

    # Exclude binary modules like .pyd or .so
    if module_path.endswith(('.pyd', '.so')):
        return False

    return True


def print_loaded_modules(filter_str=""):
    """
    Prints all modules currently loaded in sys.modules.

    Can be filtered to find specific modules more easily.

    Args:
        filter_str (str, optional): A string to filter module names.
                                    Only modules containing this string
                                    will be printed. Defaults to "".
    """
    print("--- Currently Loaded Modules " + (f" (filtered by '{filter_str}')" if filter_str else "") + " ---")

    # Sort the module names for readability
    sorted_modules = sorted(sys.modules.keys())

    count = 0
    for module_name in sorted_modules:
        if filter_str in module_name:
            print(f"- {module_name}")
            count += 1

    print(f"--- Found {count} matching modules. ---")


def reload_package(package_name):
    """
    Performs a deep (recursive) reload of a specific package and all its
    currently loaded sub-modules.

    Args:
        package_name (str): The top-level name of the package to reload
                            (e.g., "my_tool").
    """
    # Check for Python 3 for importlib.reload
    if sys.version_info.major < 3:
        print("Error: This reload function is designed for Python 3+ (e.g., Maya 2022+).")
        # For Python 2, you would just use the built-in `reload`
        # reload_func = reload
        return

    reload_func = importlib.reload

    # Create a safe copy of the keys to iterate over, as the dictionary
    # size should not change during iteration.
    loaded_modules = list(sys.modules.keys())

    # print(f"--- Starting Deep Reload for Package: '{package_name}' ---")

    reloaded_count = 0
    for module_name in loaded_modules:
        # The condition checks for the package itself or its sub-modules
        # (e.g., "my_tool" or "my_tool.ui")
        if module_name == package_name or module_name.startswith(package_name + '.'):
            try:
                module_to_reload = sys.modules[module_name]
                print(f"Reloading: {module_name}")
                reload_func(module_to_reload)
                reloaded_count += 1
            except Exception as e:
                print(f"ERROR: Failed to reload '{module_name}': {e}")

    if reloaded_count == 0:
        print(f"Warning: No modules found matching the package name '{package_name}'. "
              "Is it imported yet?")

    # print(f"--- Reloaded {reloaded_count} modules for '{package_name}'. ---")


def reload_all_user_modules(exclude_packages=None):
    """
    Attempts to reload all currently loaded modules that are identified as
    user-created (i.e., not standard library or binary modules).

    Warning: This is a powerful and potentially destabilizing operation.
             Use it as a last resort. It may not work for complex modules
             that have intricate interdependencies or C++ components.

    Args:
        exclude_packages (list, optional): A list of top-level package names
                                           to exclude from the reload process.
                                           Helpful for avoiding reloads of
                                           stable libraries like PySide2.
                                           Defaults to None.
    """
    if sys.version_info.major < 3:
        print("Error: This reload function is designed for Python 3+.")
        return

    reload_func = importlib.reload

    if exclude_packages is None:
        exclude_packages = []

    print("--- Starting Full Reload of All User Modules ---")
    print(f"Excluding packages: {exclude_packages}")

    reloaded_count = 0
    failed_count = 0

    # Iterate over a copy of the values (the module objects themselves)
    for module in list(sys.modules.values()):
        # Check if it's a user module
        if not _is_user_module(module):
            continue

        module_name = module.__name__

        # Check if the module belongs to an excluded package
        is_excluded = False
        for pkg in exclude_packages:
            if module_name == pkg or module_name.startswith(pkg + '.'):
                is_excluded = True
                break

        if is_excluded:
            continue

        try:
            print(f"Reloading user module: {module_name}")
            reload_func(module)
            reloaded_count += 1
        except Exception as e:
            print(f"ERROR: Failed to reload '{module_name}': {e}")
            failed_count += 1

    print("--- Full Reload Finished ---")
    print(f"Successfully reloaded: {reloaded_count} modules.")
    print(f"Failed to reload: {failed_count} modules.")


# 像你这样重载之后，fk_manager,ik_manager看到的bone也是最新的吗
# Model
#
# 是的，绝对是！只要你重载了 bone 模块本身，那么 fk_manager 和 ik_manager 在下一次被调用时，看到的也都会是最新版本的 bone 模块。