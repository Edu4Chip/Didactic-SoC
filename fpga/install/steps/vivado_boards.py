# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/vivado_boards.py
# Description  : VivadoBoardsStep — auto-detects Vivado, downloads Digilent
#                PYNQ-Z1 / PYNQ-Z2 board files, and installs them into the
#                XHub store (2019.2+) or a board.repoPaths directory.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
"""VivadoBoardsStep — install PYNQ-Z1 and PYNQ-Z2 board files into Vivado.

Strategy
────────
Vivado 2019.2+ uses a board repository ("XHub store") at:
    <AMD_root>/<version>/data/xhub/boards/XilinxBoardStore/boards/Xilinx/
This directory is one level *above* the Vivado root in the AMD unified
installer tree (e.g. ~/AMD/2025.2/ for Vivado at ~/AMD/2025.2/Vivado/).

If the XHub store exists we install directly into it — no extra Vivado
configuration is needed.  When it does not exist (Vivado < 2019.2 or a
non-AMD installer layout) we fall back to a user-owned directory and
register it via `set_param board.repoPaths` in Vivado_init.tcl.

Both paths use the versioned-subdir format expected by the XHub store and
by set_param board.repoPaths:
    <target_root>/<board_name>/<hw_rev>/board.xml

Sources (defined in links.json)
────────────────────────────────
  pynq-z1 — https://github.com/cathalmccabe/pynq-z1_board_files  (9 KB ZIP)
  pynq-z2 — https://dpoauwgwqsy2x.cloudfront.net/Download/pynq-z2.zip  (162 KB ZIP)

Each ZIP already has the board directory at its root, so extraction into
<target_root> produces the correct layout automatically.

Vivado detection
────────────────
Search order (first match wins):
  1. --vivado-dir argument (if given)
  2. $XILINX_VIVADO environment variable
  3. Glob ~/AMD/*/Vivado   (AMD-unified installer default since 2022.x)
  4. Glob /tools/Xilinx/Vivado/*
  5. Glob /opt/Xilinx/Vivado/*
  6. `which vivado` on PATH

The latest version found in any glob is preferred.
"""

import io
import os
import re
import shutil
import subprocess
import urllib.request
import zipfile
from pathlib import Path
from .base import Step, ProgressCallback
from .links import PYNQ_BOARDS

# Board name → {"url": ..., "prefix": ...} — loaded from links.json
_BOARDS: dict = PYNQ_BOARDS

# (base_dir, glob_pattern) pairs to search for Vivado installations
_VIVADO_SEARCHES = [
    (Path.home() / "AMD",          "*/Vivado"),   # AMD unified installer ~/AMD/<ver>/Vivado
    (Path("/tools/Xilinx/Vivado"), "*"),           # /tools/Xilinx/Vivado/<ver>
    (Path("/opt/Xilinx/Vivado"),   "*"),           # /opt/Xilinx/Vivado/<ver>
]

_MARKER = "# didactic-soc board repo path"

# Path from the AMD version root to the XHub Xilinx board store
_XHUB_SUBPATH = Path("data") / "xhub" / "boards" / "XilinxBoardStore" / "boards" / "Xilinx"


# ---------------------------------------------------------------------------
# Discovery helpers
# ---------------------------------------------------------------------------

def find_vivado_roots() -> list[Path]:
    """Return all Vivado installation roots found on this machine, newest first."""
    roots: set[Path] = set()

    # Environment variable set by settings64.sh
    xv = os.environ.get("XILINX_VIVADO")
    if xv:
        roots.add(Path(xv))

    # PATH lookup
    vivado_bin = shutil.which("vivado")
    if vivado_bin:
        roots.add(Path(vivado_bin).resolve().parent.parent)

    # Glob search: each entry is (base_dir, glob_pattern)
    for base, pattern in _VIVADO_SEARCHES:
        if base.is_dir():
            for candidate in sorted(base.glob(pattern)):
                if (candidate / "bin" / "vivado").exists():
                    roots.add(candidate)

    def _version_key(p: Path) -> tuple:
        m = re.search(r"(\d+)\.(\d+)", str(p))
        return (int(m.group(1)), int(m.group(2))) if m else (0, 0)

    return sorted(roots, key=_version_key, reverse=True)


def vivado_version(vivado_root: Path) -> str:
    """Return the version string reported by vivado -version, e.g. '2025.2'."""
    binary = vivado_root / "bin" / "vivado"
    try:
        r = subprocess.run(
            [str(binary), "-version"],
            capture_output=True, text=True, timeout=30,
        )
        m = re.search(r"vivado v(\d+\.\d+)", r.stdout, re.IGNORECASE)
        if m:
            return m.group(1)
    except Exception:
        pass
    # Fall back: parse from path
    m = re.search(r"(\d{4}\.\d+)", str(vivado_root))
    return m.group(1) if m else "unknown"


# ---------------------------------------------------------------------------
# Step
# ---------------------------------------------------------------------------

class VivadoBoardsStep(Step):
    """Download and install PYNQ-Z1 / PYNQ-Z2 board files into Vivado.

    For Vivado 2019.2+ (AMD unified installer with XHub store) the boards are
    written directly into the XHub store so Vivado finds them without any
    extra configuration.

    For older Vivado the boards are written to `board_files_dir` (default:
    ~/.local/share/didactic-soc/board_files) and Vivado_init.tcl is updated
    with `set_param board.repoPaths`.

    Boards that are already installed in either location are silently skipped
    — in particular, if pynq-z2 is already present in the XHub store (as is
    the case in the AMD Vivado 2025.2 distribution), only the missing pynq-z1
    is downloaded and installed.
    """

    title = "Vivado Board Files"
    description = (
        "Install PYNQ-Z1 and PYNQ-Z2 board files (auto-detects XHub store "
        "for Vivado 2019.2+, falls back to set_param board.repoPaths)"
    )

    def __init__(self, vivado_root: "Path | None" = None,
                 board_files_dir: "Path | None" = None):
        # None → auto-detect; explicit path → use that installation
        self._explicit_root = vivado_root
        # Where to put boards when XHub is not available (fallback only).
        # If None, defaults to ~/.local/share/didactic-soc/board_files
        self._fallback_dir = board_files_dir

    # ------------------------------------------------------------------
    # Step interface
    # ------------------------------------------------------------------

    def check(self) -> bool:
        root = self._resolve_root()
        if root is None:
            return False
        return all(self._is_installed(b, root) for b in _BOARDS)

    def run(self, log: ProgressCallback) -> bool:
        root = self._resolve_root()
        if root is None:
            log("error", "Vivado installation not found.")
            log("error", "Pass --vivado-dir <path> or make sure 'vivado' is on PATH.")
            return False

        version = vivado_version(root)
        log("info", f"Vivado root    :  {root}")
        log("info", f"Vivado version :  {version}")
        log("info", "")

        xhub = self._xhub_root(root)
        if xhub is not None:
            target_dir = xhub
            use_xhub = True
            log("info", "Board store    :  XHub (Vivado 2019.2+)")
            log("info", f"  {target_dir}")
        else:
            target_dir = self._fallback_board_dir()
            use_xhub = False
            log("info", "Board store    :  custom repo (set_param board.repoPaths)")
            log("info", f"  {target_dir}")
        log("info", "")

        missing = [b for b in _BOARDS if not self._is_installed(b, root)]
        already = [b for b in _BOARDS if b not in missing]

        for b in already:
            loc = self._installed_location(b, root)
            log("ok", f"  {b}: already installed at {loc}")

        if not missing:
            log("ok", "All boards already installed.")
            return True

        log("info", f"Boards to install: {', '.join(missing)}")
        log("info", "")

        if self.dry_run:
            log("info", "[dry-run] Would install:")
            for b in missing:
                url = _BOARDS[b]["url"]
                log("info", f"  {b}  →  {target_dir / b}/  (from {url})")
            if not use_xhub:
                log("info", f"[dry-run] Would update Vivado_init.tcl (v{version})")
            return True

        # Group missing boards by archive URL so each archive is fetched once.
        by_url: dict[str, list[str]] = {}
        for b in missing:
            by_url.setdefault(_BOARDS[b]["url"], []).append(b)

        for url, boards_in_archive in by_url.items():
            data = self._download(url, log)
            if data is None:
                return False
            if not self._extract(data, boards_in_archive, target_dir, log):
                return False

        if not use_xhub:
            self._update_init_tcl(version, target_dir, log)

        return True

    def verify(self, log: ProgressCallback) -> bool:
        root = self._resolve_root()
        if root is None:
            log("error", "Vivado not found.")
            return False
        ok = True
        for name in _BOARDS:
            if self._is_installed(name, root):
                loc = self._installed_location(name, root)
                log("ok", f"  Found: {loc}")
            else:
                log("error", f"  Missing: {name}")
                ok = False
        return ok

    # ------------------------------------------------------------------
    # Board location helpers
    # ------------------------------------------------------------------

    def _xhub_root(self, vivado_root: Path) -> "Path | None":
        """Return the XHub Xilinx board directory if it exists, else None.

        In the AMD unified installer the XHub store sits one level above the
        Vivado root:
            ~/AMD/2025.2/Vivado/   ← vivado_root
            ~/AMD/2025.2/data/xhub/boards/XilinxBoardStore/boards/Xilinx/
        """
        p = vivado_root.parent / _XHUB_SUBPATH
        return p if p.is_dir() else None

    def _fallback_board_dir(self) -> Path:
        if self._fallback_dir is not None:
            return self._fallback_dir
        return Path.home() / ".local" / "share" / "didactic-soc" / "board_files"

    def _is_installed(self, board: str, vivado_root: Path) -> bool:
        """True if `board` exists in either the XHub store or the fallback dir."""
        xhub = self._xhub_root(vivado_root)
        if xhub is not None:
            d = xhub / board
            if d.is_dir() and any(True for _ in d.iterdir()):
                return True
        fb = self._fallback_board_dir()
        d = fb / board
        return d.is_dir() and any(True for _ in d.iterdir())

    def _installed_location(self, board: str, vivado_root: Path) -> Path:
        """Return the actual path where `board` is installed (for logging)."""
        xhub = self._xhub_root(vivado_root)
        if xhub is not None:
            d = xhub / board
            if d.is_dir() and any(True for _ in d.iterdir()):
                return d
        return self._fallback_board_dir() / board

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _resolve_root(self) -> "Path | None":
        if self._explicit_root is not None:
            return self._explicit_root
        roots = find_vivado_roots()
        return roots[0] if roots else None

    def _download(self, url: str, log: ProgressCallback) -> "bytes | None":
        log("info", f"Downloading  {url}")
        try:
            with urllib.request.urlopen(url, timeout=120) as resp:
                total = int(resp.headers.get("Content-Length", 0))
                data = b""
                while True:
                    block = resp.read(65536)
                    if not block:
                        break
                    data += block
                    if total:
                        pct = len(data) * 100 // total
                        print(f"\r  {len(data)//1024} / {total//1024} KB  ({pct}%)",
                              end="", flush=True)
            print(flush=True)
            log("ok", f"Downloaded {len(data)//1024} KB.")
            return data
        except Exception as exc:
            print(flush=True)
            log("error", f"Download failed: {exc}")
            return None

    def _extract(self, data: bytes, boards: "list[str]", target_dir: Path,
                 log: ProgressCallback) -> bool:
        """Extract board files from a ZIP archive into `target_dir`.

        Each board entry in links.json has a `prefix` key — the path inside the
        ZIP that contains the <hw_rev>/board.xml tree.  Files are extracted as:
            target_dir/<board_name>/<hw_rev>/board.xml
        """
        log("info", f"Installing board files → {target_dir}")
        target_dir.mkdir(parents=True, exist_ok=True)
        try:
            with zipfile.ZipFile(io.BytesIO(data)) as zf:
                for board_name in boards:
                    prefix = _BOARDS[board_name]["prefix"].rstrip("/") + "/"
                    dest   = target_dir / board_name
                    dest.mkdir(exist_ok=True)
                    members = [m for m in zf.namelist() if m.startswith(prefix)]
                    if not members:
                        log("warning", f"  {board_name}: prefix '{prefix}' not found in archive")
                        continue
                    for member in members:
                        rel = member[len(prefix):]
                        if not rel:
                            continue
                        target = dest / rel
                        if member.endswith("/"):
                            target.mkdir(parents=True, exist_ok=True)
                        else:
                            target.parent.mkdir(parents=True, exist_ok=True)
                            target.write_bytes(zf.read(member))
                    log("ok", f"  {board_name}  →  {dest}")
        except Exception as exc:
            log("error", f"Extraction failed: {exc}")
            return False
        log("info", "")
        return True

    def _update_init_tcl(self, version: str, board_files_dir: Path,
                         log: ProgressCallback) -> None:
        """Add set_param board.repoPaths to the user's Vivado_init.tcl.

        Only called when the XHub store is not available (older Vivado).
        `board_files_dir` contains <board>/<version>/board.xml entries.
        """
        init_dir  = Path.home() / ".Xilinx" / "Vivado" / version
        init_file = init_dir / "Vivado_init.tcl"

        repo_line = f'set_param board.repoPaths [list "{board_files_dir}"]'

        try:
            existing = init_file.read_text() if init_file.exists() else ""
        except OSError:
            existing = ""

        if "board.repoPaths" in existing:
            log("info", "Vivado_init.tcl already sets board.repoPaths — no changes.")
            log("info", f"  {init_file}")
            return

        init_dir.mkdir(parents=True, exist_ok=True)
        try:
            with init_file.open("a") as f:
                f.write(f"\n{_MARKER}\n{repo_line}\n")
            log("ok",  f"Updated {init_file}")
            log("info", f"  {repo_line}")
        except OSError as exc:
            log("warning", f"Could not write {init_file}: {exc}")
            log("info",    "Add this line to your Vivado_init.tcl manually:")
            log("info",    f"  {repo_line}")
