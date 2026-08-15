# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/debugger.py
# Description  : DebuggerStep — creates a Python venv inside the install root,
#                installs GUI dependencies from requirements.txt, and writes the
#                didactic-debug launcher script.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import subprocess
import sys
from pathlib import Path
from .base import Step, ProgressCallback


class DebuggerStep(Step):
    """Create a Python venv with all GUI dependencies and a didactic-debug launcher.

    Everything lands inside the install root so the whole installation can be
    removed by deleting that single directory.

    Layout inside <install_dir>:
        venv/               Python virtual environment
        bin/didactic-debug  Shell launcher that execs venv/python3 main.py
    """

    title = "Debug GUI"
    description = (
        "Create Python venv, install PySide6/pygdbmi/pyserial, "
        "and write the didactic-debug launcher"
    )

    def __init__(self, install_dir: Path, repo_root: Path):
        self.venv_dir     = install_dir / "venv"
        self.bin_dir      = install_dir / "bin"
        self.launcher     = install_dir / "bin" / "didactic-debug"
        self.requirements = repo_root / "fpga" / "debug" / "requirements.txt"
        self.main_py      = repo_root / "fpga" / "debug" / "main.py"

    def check(self) -> bool:
        return (
            (self.venv_dir / "bin" / "python3").exists()
            and self.launcher.exists()
        )

    def run(self, log: ProgressCallback) -> bool:
        if self.dry_run:
            log("info", "[dry-run] Would run:")
            log("info", f"  python3 -m venv {self.venv_dir}")
            log("info", f"  {self.venv_dir}/bin/pip install -r {self.requirements}")
            log("info", f"  write {self.launcher}")
            return True

        if not self._create_venv(log):
            return False
        if not self._install_packages(log):
            return False
        self._write_launcher(log)
        return True

    def verify(self, log: ProgressCallback) -> bool:
        python = self.venv_dir / "bin" / "python3"
        if not python.exists():
            log("error", f"venv python not found: {python}")
            return False
        try:
            r = subprocess.run(
                [str(python), "-c", "import PySide6, pygdbmi, serial"],
                text=True, capture_output=True,
            )
        except OSError as exc:
            log("error", str(exc))
            return False
        if r.returncode != 0:
            log("error", f"Package import check failed:\n{r.stderr.strip()}")
            return False
        log("ok", "venv imports verified (PySide6, pygdbmi, serial).")
        return True

    # ------------------------------------------------------------------

    def _create_venv(self, log: ProgressCallback) -> bool:
        log("info", f"Creating venv  :  {self.venv_dir}")
        try:
            subprocess.run(
                [sys.executable, "-m", "venv", str(self.venv_dir)],
                check=True, text=True, capture_output=True,
            )
        except subprocess.CalledProcessError as exc:
            log("error", f"venv creation failed:\n{exc.stderr.strip()}")
            return False
        log("ok", "venv ready.")
        log("info", "")
        return True

    def _install_packages(self, log: ProgressCallback) -> bool:
        pip = self.venv_dir / "bin" / "pip"
        log("info", f"Requirements   :  {self.requirements}")
        log("info",  "Upgrading pip …")
        try:
            subprocess.run(
                [str(pip), "install", "--upgrade", "pip", "-q"],
                check=True, text=True, capture_output=True,
            )
        except subprocess.CalledProcessError as exc:
            log("warning", f"pip upgrade failed (continuing): {exc.stderr.strip()}")

        log("info", "Installing packages …")
        try:
            subprocess.run(
                [str(pip), "install", "-r", str(self.requirements)],
                check=True,
            )
        except subprocess.CalledProcessError:
            log("error", "pip install failed.")
            return False
        log("ok", "Packages installed.")
        log("info", "")
        return True

    def _write_launcher(self, log: ProgressCallback) -> None:
        self.bin_dir.mkdir(parents=True, exist_ok=True)
        python = self.venv_dir / "bin" / "python3"
        content = (
            "#!/bin/sh\n"
            "# Didactic SoC Debug GUI — launcher generated by the installer.\n"
            "#\n"
            "# Both this file and the venv/ directory live inside the same\n"
            "# install root. Delete that root to remove the entire installation.\n"
            f'exec "{python}" "{self.main_py}" "$@"\n'
        )
        self.launcher.write_text(content)
        self.launcher.chmod(0o755)
        log("ok",   f"Launcher       :  {self.launcher}")
