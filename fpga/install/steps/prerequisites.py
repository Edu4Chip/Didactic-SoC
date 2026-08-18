# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/prerequisites.py
# Description  : PrerequisitesStep — verifies that all required build tools
#                (git, cmake, make, autoconf, pkg-config, pip, etc.) are
#                present before the installation begins.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import shutil
import subprocess
import sys
from .base import Step, ProgressCallback
from .pkgmanager import detect_pkg_manager, install_cmd

# tool -> {package manager: package name}. Unlisted managers fall back to
# the tool name itself, which is correct for most of these.
_REQUIRED = [
    ("git",        {}),
    ("gcc",        {"apt": "build-essential", "pacman": "base-devel"}),
    ("make",       {"apt": "build-essential", "pacman": "base-devel"}),
    ("autoconf",   {}),
    ("libtoolize", {"apt": "libtool", "dnf": "libtool", "pacman": "libtool", "zypper": "libtool"}),
    ("pkg-config", {"dnf": "pkgconf-pkg-config", "pacman": "pkgconf"}),
    ("wget",       {}),
]

# venv/ensurepip only ships as a separate package on some distros; on
# others (Fedora, Arch) it's bundled with python3 and nothing extra is
# needed, so there's no package to name.
_VENV_PKG = {
    "apt":    f"python3.{sys.version_info.minor}-venv",
    "zypper": "python3-venv",
}


def _pkg_name(cmd: str, pkg_map: dict, mgr: "str | None") -> str:
    return pkg_map.get(mgr, cmd)


def _venv_available() -> bool:
    try:
        subprocess.run(
            [sys.executable, "-c", "import ensurepip"],
            check=True, capture_output=True,
        )
    except subprocess.CalledProcessError:
        return False
    return True


class PrerequisitesStep(Step):
    title = "Prerequisites"
    description = "Verify required build tools are present before compilation"

    def check(self) -> bool:
        return all(shutil.which(cmd) for cmd, _ in _REQUIRED) and _venv_available()

    def run(self, log: ProgressCallback) -> bool:
        if self.dry_run:
            log("info", f"[dry-run] Would check {len(_REQUIRED)} tools and python3 venv support: "
                + ", ".join(cmd for cmd, _ in _REQUIRED))
            return True

        mgr = detect_pkg_manager()

        log("info", f"Checking {len(_REQUIRED)} required tools …")
        log("info", "")

        missing_pkgs = []
        for cmd, pkg_map in _REQUIRED:
            path = shutil.which(cmd)
            pkg = _pkg_name(cmd, pkg_map, mgr)
            if path:
                log("ok",  f"  found    {cmd:<14}  {path}")
            else:
                log("warning", f"  missing  {cmd:<14}  (package: {pkg})")
                missing_pkgs.append(pkg)

        if _venv_available():
            log("ok", "  found    python3 venv    ensurepip available")
        else:
            venv_pkg = _VENV_PKG.get(mgr)
            if venv_pkg:
                log("warning", f"  missing  python3 venv    (package: {venv_pkg})")
                missing_pkgs.append(venv_pkg)
            else:
                log("error", "  missing  python3 venv    ensurepip is unavailable; "
                    "install the venv/ensurepip component for your Python "
                    "distribution (package name varies by system)")
                return False

        if missing_pkgs:
            log("info", "")
            unique = sorted(set(missing_pkgs))
            log("error", "One or more tools are missing. Install them with:")
            log("error", f"  {install_cmd(mgr)} {' '.join(unique)}")
            return False

        log("info", "")
        log("ok", "All prerequisites satisfied.")
        return True
