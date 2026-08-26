"""Atomic JSON storage for MayaCraft Clip packages."""

from __future__ import annotations

from dataclasses import dataclass
import json
import os
from pathlib import Path
import tempfile

from MayaCraft.domain.clip_package import (
    ClipPackage,
    clip_package_from_dict,
    clip_package_to_dict,
)
from MayaCraft.domain.clip_library import ClipLibraryEntry, build_clip_library_entry


@dataclass(frozen=True)
class ClipPackageWriteReceipt:
    path: str
    fingerprint: str
    bytes_written: int
    verified: bool
    message: str


@dataclass(frozen=True)
class ClipLibraryScan:
    directory: str
    entries: tuple
    scanned_files: int
    invalid_files: int
    truncated: bool


class ClipPackageStore:
    MAXIMUM_BYTES = 64 * 1024 * 1024
    MAXIMUM_LIBRARY_FILES = 500

    def read(self, path, allow_legacy=True):
        target = Path(path)
        if not target.is_file():
            raise FileNotFoundError(f"Clip Package 文件不存在：{target}")
        size = target.stat().st_size
        if size <= 0 or size > self.MAXIMUM_BYTES:
            raise ValueError(f"Clip Package 文件大小无效：{size} bytes")
        payload = json.loads(
            target.read_text(encoding="utf-8-sig"),
            parse_constant=lambda value: (_ for _ in ()).throw(
                ValueError(f"Clip Package 包含非法数值：{value}")
            ),
        )
        if not isinstance(payload, dict):
            raise ValueError("Clip Package 顶层必须是 JSON 对象")
        return clip_package_from_dict(payload, allow_legacy=allow_legacy)

    def write(self, path, package: ClipPackage, overwrite=False):
        target = Path(path)
        parent = target.parent
        if not parent.is_dir():
            raise FileNotFoundError(f"Clip Package 目标目录不存在：{parent}")
        if target.exists() and not overwrite:
            raise FileExistsError(f"Clip Package 已存在：{target}")
        text = json.dumps(
            clip_package_to_dict(package),
            ensure_ascii=False,
            sort_keys=True,
            indent=2,
            allow_nan=False,
        ) + "\n"
        encoded = text.encode("utf-8")
        if len(encoded) > self.MAXIMUM_BYTES:
            raise ValueError(f"Clip Package 超过 {self.MAXIMUM_BYTES} bytes 写入上限")
        temporary = None
        try:
            with tempfile.NamedTemporaryFile(
                mode="wb", dir=str(parent), prefix=f".{target.name}.",
                suffix=".tmp", delete=False,
            ) as stream:
                temporary = Path(stream.name)
                stream.write(encoded)
                stream.flush()
                os.fsync(stream.fileno())
            os.replace(str(temporary), str(target))
            temporary = None
        finally:
            if temporary is not None and temporary.exists():
                temporary.unlink()
        verified = self.read(target, allow_legacy=False)
        if verified.fingerprint != package.fingerprint:
            raise RuntimeError("Clip Package 原子写入后的 fingerprint 不一致")
        return ClipPackageWriteReceipt(
            path=str(target.resolve()),
            fingerprint=verified.fingerprint,
            bytes_written=len(encoded),
            verified=True,
            message=(
                f"已写入并验证 Clip Package：{target.name} / "
                f"{len(encoded)} bytes / {verified.fingerprint[:12]}"
            ),
        )

    def scan_directory(self, directory, recursive=False, maximum_files=None):
        root = Path(directory)
        if not root.is_dir():
            raise FileNotFoundError(f"Clip 资产目录不存在：{root}")
        limit = int(maximum_files or self.MAXIMUM_LIBRARY_FILES)
        if limit <= 0 or limit > self.MAXIMUM_LIBRARY_FILES:
            raise ValueError(f"Clip 资产扫描上限必须为 1–{self.MAXIMUM_LIBRARY_FILES}")
        pattern = "**/*" if recursive else "*"
        candidates = tuple(sorted(
            (
                path for path in root.glob(pattern)
                if path.is_file() and path.suffix.casefold() in {".mayaclip", ".json"}
            ),
            key=lambda path: str(path).casefold(),
        ))
        selected = candidates[:limit]
        entries = []
        invalid = 0
        for path in selected:
            stat = path.stat()
            try:
                package = self.read(path)
                entries.append(build_clip_library_entry(
                    package, str(path.resolve()), stat.st_size, stat.st_mtime_ns,
                ))
            except Exception as exc:
                invalid += 1
                entries.append(ClipLibraryEntry(
                    path=str(path.resolve()),
                    name=path.stem,
                    bytes_on_disk=stat.st_size,
                    modified_time_ns=stat.st_mtime_ns,
                    state="invalid",
                    issues=(f"资产读取失败：{exc}",),
                ))
        return ClipLibraryScan(
            directory=str(root.resolve()),
            entries=tuple(entries),
            scanned_files=len(selected),
            invalid_files=invalid,
            truncated=len(candidates) > limit,
        )


__all__ = [
    "ClipLibraryScan", "ClipPackageStore", "ClipPackageWriteReceipt",
]
