"""Maya Module bootstrap that exposes the repository as the MayaCraft package."""

from __future__ import annotations

from pathlib import Path


_repo_root = Path(__file__).resolve().parents[3]
_package_init = _repo_root / "__init__.py"
if not _package_init.is_file():
    raise ImportError(f"MayaCraft package is missing: {_package_init}")

# Turning this bootstrap module into a package lets normal imports such as
# ``MayaCraft.launch`` resolve directly from the checked-out repository.
__path__ = [str(_repo_root)]
__package__ = "MayaCraft"
exec(compile(_package_init.read_bytes(), str(_package_init), "exec"), globals())
