#!/usr/bin/env python3
# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/install.py
# Description  : Main CLI entry point; parses command-line arguments, builds
#                the ordered list of installation steps, and drives execution
#                with colour-coded progress logging.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
"""Didactic SoC FPGA installation script.

Installs all software prerequisites for building and running the Didactic SoC
on a PYNQ-Z1, PYNQ-Z2, or Basys3 FPGA board.

Everything is installed under a single root directory (default:
~/DidacticSoCInstall/).  Deleting that directory removes the entire
installation cleanly.

Layout after a successful install
──────────────────────────────────
<install_dir>/
    bin/
        didactic-debug          ← launches the debug GUI (venv python + main.py)
        openocd                 ← symlink to installed OpenOCD
        riscv32-unknown-elf-*   ← symlinks to toolchain binaries
    board_files/                ← FPGA board files (only if XHub store absent)
    openocd/                    ← OpenOCD install prefix (bin/, lib/, share/, …)
    toolchain/                  ← RISC-V toolchain tarball extraction root
    venv/                       ← Python venv for the debug GUI

The build directory (OpenOCD source clone, toolchain archive) defaults to
/tmp/didactic-install and is NOT inside the install root — it can be deleted
after installation without affecting the installed tools.

Each installation step is an independent module so the same step objects can
be reused directly by a GUI wizard without any changes.
"""

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from steps import (
    PrerequisitesStep,
    OpenOCDStep,
    OpenOCDConfigStep,
    ToolchainStep,
    UdevRulesStep,
    PathStep,
    BoardStep,
    DebuggerStep,
    VivadoBoardsStep,
)
from steps.links import TOOLCHAIN_DEFAULT_RELEASE
from steps.openocd import CHIPS
from steps.vivado_boards import find_vivado_roots, vivado_version

_DEFAULT_INSTALL_DIR = Path.home() / "DidacticSoCInstall"

_ANSI = {
    "info":    "\033[0m",
    "warning": "\033[33m",
    "error":   "\033[31m",
    "ok":      "\033[32m",
    "header":  "\033[1;36m",
    "reset":   "\033[0m",
}

_LEVELS = {
    "error":   0,
    "warning": 0,
    "ok":      0,
    "info":    1,
    "detail":  2,
}


def _cli_logger(verbosity: int = 1):
    def log(level: str, msg: str) -> None:
        if verbosity < _LEVELS.get(level, 1):
            return
        colour = _ANSI.get(level, "")
        print(f"{colour}{msg}{_ANSI['reset']}", flush=True)
    return log


def _print_header(title: str) -> None:
    bar = "─" * (len(title) + 4)
    print(f"\n{_ANSI['header']}┌{bar}┐")
    print(f"│  {title}  │")
    print(f"└{bar}┘{_ANSI['reset']}", flush=True)


def _parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description="Install prerequisites for the Didactic SoC FPGA flow.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=f"""
Install layout (default root: {_DEFAULT_INSTALL_DIR}):
  <install_dir>/bin/didactic-debug   debug GUI launcher
  <install_dir>/bin/openocd          openocd symlink
  <install_dir>/bin/riscv32-*        toolchain symlinks
  <install_dir>/openocd/             OpenOCD installation
  <install_dir>/toolchain/           RISC-V toolchain
  <install_dir>/venv/                Python venv for the debug GUI

Delete <install_dir> to remove the entire installation.

examples:
  # Full install for PYNQ-Z1 with FT4232H adapter (default)
  python3 install.py --board z1

  # Full install for PYNQ-Z2 with automotive FT4232HA (applies source patch)
  python3 install.py --board z2 --ftdi-chip ft4232ha

  # Custom install root
  python3 install.py --board z1 --install-dir ~/mytools

  # Dry run — see what would happen without making any changes
  python3 install.py --board z2 --ftdi-chip ft4232ha --dry-run
""",
    )
    p.add_argument(
        "--board", choices=["z1", "z2", "basys3"], required=True,
        help="Target FPGA board",
    )
    _chip_choices = sorted(CHIPS.keys())
    _needs_patch  = [k for k, v in CHIPS.items() if v["patch"]]
    p.add_argument(
        "--ftdi-chip", choices=_chip_choices, required=True,
        help=(
            f"FTDI adapter chip variant. "
            f"Choices: {', '.join(_chip_choices)}. "
            f"Requires source patch: {', '.join(_needs_patch)}."
        ),
    )
    p.add_argument(
        "--install-dir", type=Path, default=_DEFAULT_INSTALL_DIR,
        help=f"Root directory for the entire installation "
             f"(default: {_DEFAULT_INSTALL_DIR}). "
             "Delete this directory to uninstall everything.",
    )
    p.add_argument(
        "--build-dir", type=Path, default=Path("/tmp/didactic-install"),
        help="Temporary directory for cloning/building OpenOCD and downloading "
             "the toolchain tarball (default: /tmp/didactic-install). "
             "Safe to delete after installation.",
    )
    p.add_argument(
        "--toolchain-release", default=TOOLCHAIN_DEFAULT_RELEASE,
        help=f"riscv-gnu-toolchain release tag (default: {TOOLCHAIN_DEFAULT_RELEASE})",
    )
    p.add_argument("--skip-prerequisites", action="store_true",
                   help="Skip tool availability checks")
    p.add_argument("--skip-openocd",       action="store_true",
                   help="Skip OpenOCD clone/build/install")
    p.add_argument("--skip-toolchain",     action="store_true",
                   help="Skip RISC-V toolchain download")
    p.add_argument("--skip-udev",          action="store_true",
                   help="Skip udev rules installation")
    p.add_argument("--skip-path",          action="store_true",
                   help="Skip symlink directory creation and PATH extension")
    p.add_argument("--skip-debugger",      action="store_true",
                   help="Skip Python venv creation and didactic-debug launcher")
    p.add_argument("--skip-vivado-boards", action="store_true",
                   help="Skip Vivado board files installation")
    p.add_argument("--vivado-dir",         type=Path, default=None,
                   help="Vivado installation root (e.g. ~/AMD/2025.2/Vivado). "
                        "Auto-detected if omitted.")
    p.add_argument("--force-toolchain",    action="store_true",
                   help="Re-download and re-install the toolchain even if already present")
    p.add_argument("--dry-run",            action="store_true",
                   help="Print what would be done without making any changes")
    p.add_argument("-v", "--verbose",      action="store_true",
                   help="Show full subprocess output (git clone, make, etc.)")
    return p.parse_args()


def build_steps(args: argparse.Namespace) -> list:
    """Return the ordered list of Step objects for the given arguments.

    This function is the single point of entry for a GUI wizard: call it with
    a namespace-like object to get the same step list without re-parsing CLI
    arguments.
    """
    # install.py lives at fpga/install/install.py → repo root is two levels up
    repo_root = Path(__file__).resolve().parent.parent.parent

    install_dir   = args.install_dir
    openocd_prefix = install_dir / "openocd"
    toolchain_dir  = install_dir / "toolchain"
    symlink_dir    = install_dir / "bin"
    openocd_bin    = openocd_prefix / "bin"   # for extra symlinks in PathStep

    openocd_rules_src = (
        args.build_dir / "riscv-openocd" / "contrib" / "60-openocd.rules"
    )
    openocd_cfg = repo_root / "fpga" / "utils" / "openocd-didactic.cfg"

    dry_run = getattr(args, "dry_run", False)

    steps = []
    if not getattr(args, "skip_prerequisites", False):
        steps.append(PrerequisitesStep())
    if not getattr(args, "skip_openocd", False):
        steps.append(OpenOCDStep(args.build_dir, ftdi_chip=args.ftdi_chip,
                                 install_prefix=openocd_prefix))
    steps.append(OpenOCDConfigStep(openocd_cfg, args.ftdi_chip))
    if not getattr(args, "skip_toolchain", False):
        steps.append(ToolchainStep(toolchain_dir,
                                   release=args.toolchain_release,
                                   force=getattr(args, "force_toolchain", False)))
    if not getattr(args, "skip_debugger", False):
        steps.append(DebuggerStep(install_dir, repo_root))
    if not getattr(args, "skip_vivado_boards", False):
        steps.append(VivadoBoardsStep(
            vivado_root=getattr(args, "vivado_dir", None),
            board_files_dir=install_dir / "board_files",
        ))
    if not getattr(args, "skip_path", False):
        steps.append(PathStep(toolchain_dir,
                              symlink_dir=symlink_dir,
                              extra_bin_dirs=[openocd_bin]))
    if not getattr(args, "skip_udev", False):
        steps.append(UdevRulesStep(openocd_rules_src))
    steps.append(BoardStep(args.board))

    for step in steps:
        step.dry_run = dry_run
    return steps


def main() -> int:
    args = _parse_args()
    verbosity = 2 if getattr(args, "verbose", False) else 1
    log = _cli_logger(verbosity)

    dry_run = getattr(args, "dry_run", False)
    if dry_run:
        log("warning", "DRY-RUN mode — no files will be written, no commands executed.")

    install_dir = args.install_dir
    log("info", "")
    log("info", f"Install root  :  {install_dir}")
    log("info", f"Build dir     :  {args.build_dir}  (temporary, safe to delete)")

    vivado_dir = getattr(args, "vivado_dir", None)
    if vivado_dir is None:
        roots = find_vivado_roots()
        if roots:
            vivado_dir = roots[0]
            log("info", f"Vivado        :  {vivado_dir}  "
                        f"(v{vivado_version(vivado_dir)}, auto-detected)")
        else:
            log("warning", "Vivado        :  not found — board files step will be skipped")
    else:
        log("info", f"Vivado        :  {vivado_dir}  (--vivado-dir)")
    log("info", "")

    steps = build_steps(args)
    failed = []
    path_step_ran = False

    for step in steps:
        _print_header(step.title)
        log("info", step.description)

        already_done = step.check()
        if already_done:
            log("ok", "  Already complete — skipping.")
            continue

        ok = step.run(log)
        if not ok:
            log("error", f"  {step.title} FAILED.")
            failed.append(step.title)
            if isinstance(step, PrerequisitesStep):
                break  # missing tools make subsequent steps pointless
        elif isinstance(step, PathStep):
            path_step_ran = True

    _print_header("Summary")
    if failed:
        log("error", f"Failed: {', '.join(failed)}")
        log("warning", "Correct the errors above and re-run.")
        return 1

    log("ok", "Installation complete.")
    log("info", "")
    log("info", f"Install root   :  {install_dir}")
    log("info", f"  Launcher     :  {install_dir}/bin/didactic-debug")
    log("info", f"  Tools        :  {install_dir}/bin/")
    log("info", f"  venv         :  {install_dir}/venv/")
    log("info", "")
    log("info", f"To uninstall, delete the install root:")
    log("info", f"  rm -rf {install_dir}")

    if path_step_ran:
        script = Path(__file__).parent / "install.sh"
        log("info", "")
        log("warning", "PATH was updated but is not yet active in this terminal.")
        log("info",    "To activate it without opening a new terminal, re-run using:")
        log("info",    f"  source {script} <same arguments>")

    return 0


if __name__ == "__main__":
    sys.exit(main())
