#!/usr/bin/env python3
"""Didactic SoC FPGA installation script.

Installs all software prerequisites for building and running the Didactic SoC
on a PYNQ-Z1, PYNQ-Z2, or Basys3 FPGA board.

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
)
from steps.openocd import CHIPS
from steps.path import _DEFAULT_SYMLINK_DIR

_ANSI = {
    "info":    "\033[0m",
    "warning": "\033[33m",
    "error":   "\033[31m",
    "ok":      "\033[32m",
    "header":  "\033[1;36m",
    "reset":   "\033[0m",
}


def _cli_logger():
    def log(level: str, msg: str) -> None:
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
        epilog="""
examples:
  # Full install for PYNQ-Z1 with FT4232H adapter (default)
  python3 install.py --board z1

  # Full install for PYNQ-Z2 with automotive FT4232HA (applies source patch)
  python3 install.py --board z2 --ftdi-chip ft4232ha

  # Full install with FT2232H adapter (natively supported, no patch needed)
  python3 install.py --board z1 --ftdi-chip ft2232h

  # Toolchain only (OpenOCD already installed)
  python3 install.py --board z1 --skip-openocd --skip-udev

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
            f"FTDI adapter chip variant (required). "
            f"Choices: {', '.join(_chip_choices)}. "
            f"Requires source patch: {', '.join(_needs_patch)}."
        ),
    )
    p.add_argument(
        "--build-dir", type=Path, default=Path("/tmp/didactic-install"),
        help="Directory for cloning/building OpenOCD (default: /tmp/didactic-install)",
    )
    p.add_argument(
        "--toolchain-dir", type=Path, default=Path.home() / "riscv32",
        help="Directory to install the RISC-V toolchain (default: ~/riscv32)",
    )
    p.add_argument(
        "--toolchain-release", default="2026.07.15",
        help="riscv-gnu-toolchain release tag (default: 2026.07.15)",
    )
    p.add_argument("--skip-prerequisites", action="store_true",
                   help="Skip tool availability checks")
    p.add_argument("--skip-openocd",       action="store_true",
                   help="Skip OpenOCD clone/build/install")
    p.add_argument("--skip-toolchain",     action="store_true",
                   help="Skip RISC-V toolchain download")
    p.add_argument("--skip-udev",           action="store_true",
                   help="Skip udev rules installation")
    p.add_argument("--force-toolchain",    action="store_true",
                   help="Re-download and re-install the toolchain even if already present")
    p.add_argument("--skip-path",          action="store_true",
                   help="Skip symlink directory creation and PATH extension")
    p.add_argument("--symlink-dir",        type=Path, default=_DEFAULT_SYMLINK_DIR,
                   help=f"Directory for tool symlinks (default: {_DEFAULT_SYMLINK_DIR})")
    p.add_argument("--dry-run",            action="store_true",
                   help="Print what would be done without making any changes")
    return p.parse_args()


def build_steps(args: argparse.Namespace) -> list:
    """Return the ordered list of Step objects for the given arguments.

    This function is the single point of entry for a GUI wizard: call it with
    a namespace-like object to get the same step list without re-parsing CLI
    arguments.
    """
    # install.py lives at fpga/install/install.py → repo root is two levels up
    repo_root = Path(__file__).resolve().parent.parent.parent
    openocd_rules_src = (
        args.build_dir / "riscv-openocd" / "contrib" / "60-openocd.rules"
    )
    openocd_cfg = repo_root / "fpga" / "utils" / "openocd-didactic.cfg"

    dry_run = getattr(args, "dry_run", False)

    steps = []
    if not getattr(args, "skip_prerequisites", False):
        steps.append(PrerequisitesStep())
    if not getattr(args, "skip_openocd", False):
        steps.append(OpenOCDStep(args.build_dir, ftdi_chip=args.ftdi_chip))
    steps.append(OpenOCDConfigStep(openocd_cfg, args.ftdi_chip))
    if not getattr(args, "skip_toolchain", False):
        steps.append(ToolchainStep(args.toolchain_dir,
                                   release=args.toolchain_release,
                                   force=getattr(args, "force_toolchain", False)))
    if not getattr(args, "skip_path", False):
        steps.append(PathStep(args.toolchain_dir,
                              symlink_dir=getattr(args, "symlink_dir", _DEFAULT_SYMLINK_DIR)))
    if not getattr(args, "skip_udev", False):
        steps.append(UdevRulesStep(openocd_rules_src))
    steps.append(BoardStep(args.board))

    for step in steps:
        step.dry_run = dry_run
    return steps


def main() -> int:
    args = _parse_args()
    log = _cli_logger()

    dry_run = getattr(args, "dry_run", False)
    if dry_run:
        log("warning", "DRY-RUN mode — no files will be written, no commands executed.")

    steps = build_steps(args)
    failed = []

    for step in steps:
        _print_header(step.title)
        log("info", step.description)

        if step.check():
            log("ok", f"  Already complete — skipping.")
            continue

        ok = step.run(log)
        if not ok:
            log("error", f"  {step.title} FAILED.")
            failed.append(step.title)
            if isinstance(step, PrerequisitesStep):
                break  # missing tools make subsequent steps pointless

    _print_header("Summary")
    if failed:
        log("error", f"Failed: {', '.join(failed)}")
        log("warning", "Correct the errors above and re-run.")
        return 1

    log("ok", "Installation complete.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
