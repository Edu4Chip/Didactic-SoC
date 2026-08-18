# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/pkgmanager.py
# Description  : Shared package-manager detection so installer steps can
#                phrase "install this" hints for whichever distro is running.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import shutil

# Probed in order; the first one found on PATH is assumed to be the host's.
_PKG_MANAGERS = [
    ("apt",    "sudo apt install"),
    ("dnf",    "sudo dnf install"),
    ("pacman", "sudo pacman -S"),
    ("zypper", "sudo zypper install"),
]


def detect_pkg_manager() -> "str | None":
    for mgr, _ in _PKG_MANAGERS:
        if shutil.which(mgr):
            return mgr
    return None


def install_cmd(mgr: "str | None") -> str:
    for name, cmd in _PKG_MANAGERS:
        if name == mgr:
            return cmd
    return "install (with your system's package manager)"
