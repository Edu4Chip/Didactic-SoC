# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/openocd.py
# Description  : OpenOCDStep — clones the RISC-V OpenOCD fork, optionally
#                patches it for the automotive FT4232HA chip, builds it with
#                libftdi/libusb support, and installs it under the install root.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import os
import shutil
import subprocess
from pathlib import Path
from .base import Step, ProgressCallback
from .links import OPENOCD_REPO, OPENOCD_COMMIT

_DEFAULT_PREFIX = Path.home() / ".local"


def _needs_sudo(path: Path) -> bool:
    """Return True if path (or its closest existing parent) is not user-writable."""
    p = path
    while not p.exists():
        p = p.parent
    return not os.access(p, os.W_OK)

# Registry of known FTDI chips and their support status at the pinned commit.
# Fields:
#   pid         — USB product ID (hex string, no 0x prefix, as it appears in udev rules)
#   bcd_device  — bcdDevice value OpenOCD reads to identify the chip variant
#   type_enum   — C enum name in mpsse.h
#   udev_in_rules — True if the PID is already present in contrib/60-openocd.rules
#   patch       — None = natively supported; "ft4232ha" = apply the HA patch set
#   jtag_channel — which MPSSE channel carries JTAG (informational, for the board summary)
CHIPS = {
    "ft2232c": {
        "pid": "6010", "bcd_device": "0x0500",
        "type_enum": "TYPE_FT2232C",
        "udev_in_rules": True,
        "patch": None,
        "jtag_channel": "A (ADBUS)",
        "openocd_channel": 0,         # channel index for ftdi channel directive
        "openocd_vid": "0x0403",
        "openocd_pid": "0x6010",
    },
    "ft2232h": {
        "pid": "6010", "bcd_device": "0x0700",
        "type_enum": "TYPE_FT2232H",
        "udev_in_rules": True,
        "patch": None,
        "jtag_channel": "A (ADBUS)",
        "openocd_channel": 0,
        "openocd_vid": "0x0403",
        "openocd_pid": "0x6010",
    },
    "ft4232h": {
        "pid": "6011", "bcd_device": "0x0800",
        "type_enum": "TYPE_FT4232H",
        "udev_in_rules": True,
        "patch": None,
        "jtag_channel": "B (BDBUS)",
        "openocd_channel": 1,
        "openocd_vid": "0x0403",
        "openocd_pid": "0x6011",
    },
    "ft4232ha": {
        "pid": "6048", "bcd_device": "0x3600",
        "type_enum": "TYPE_FT4232HA",
        "udev_in_rules": False,
        "patch": "ft4232ha",
        "jtag_channel": "B (BDBUS)",
        "openocd_channel": 1,
        "openocd_vid": "0x0403",
        "openocd_pid": "0x6048",
    },
}


class OpenOCDStep(Step):
    title = "OpenOCD"
    description = "Clone, build and install OpenOCD with RISC-V JTAG support"

    def __init__(self, build_dir: Path, ftdi_chip: str = "ft4232h",
                 install_prefix: Path = _DEFAULT_PREFIX):
        self.build_dir      = build_dir
        self.ftdi_chip      = ftdi_chip
        self.install_prefix = install_prefix
        self.clone_dir      = build_dir / "riscv-openocd"
        self._chip          = CHIPS[ftdi_chip]

    def _openocd_bin(self) -> "Path | None":
        """Return the openocd binary path, checking prefix/bin first then PATH."""
        prefix_bin = self.install_prefix / "bin" / "openocd"
        if prefix_bin.exists():
            return prefix_bin
        found = shutil.which("openocd")
        return Path(found) if found else None

    def check(self) -> bool:
        if not self._openocd_bin():
            return False
        if self._chip.get("patch") == "ft4232ha":
            # Binary present but we need to confirm the source was patched and
            # built with FT4232HA support.  Use the patched header as the
            # indicator — if the clone doesn't exist or lacks the enum value,
            # we must rebuild.
            h_file = self.clone_dir / "src/jtag/drivers/mpsse.h"
            if not h_file.exists() or "TYPE_FT4232HA" not in h_file.read_text():
                return False
        return True

    def run(self, log: ProgressCallback) -> bool:
        chip = self._chip
        log("info", f"Repository  : {OPENOCD_REPO}")
        log("info", f"Commit      : {OPENOCD_COMMIT[:12]}  (full: {OPENOCD_COMMIT})")
        log("info", f"FTDI chip   : {self.ftdi_chip.upper()}"
                    f"  (PID 0x{chip['pid']}, bcdDevice {chip['bcd_device']})")
        log("info", f"JTAG channel: {chip['jtag_channel']}")
        h_file = self.clone_dir / "src/jtag/drivers/mpsse.h"
        patch_applied = chip["patch"] == "ft4232ha" and h_file.exists() and "TYPE_FT4232HA" in h_file.read_text()
        if chip["patch"]:
            patch_status = "already applied" if patch_applied else "will be applied"
            log("info", f"Patch needed: yes — {chip['patch']} ({patch_status})")
        else:
            log("info",  "Patch needed: no")
        sudo_needed = _needs_sudo(self.install_prefix)
        log("info", f"Install prefix : {self.install_prefix}")
        log("info", f"Requires sudo  : {'yes' if sudo_needed else 'no'}")
        log("info", f"Build dir      : {self.clone_dir}")
        log("info", "")

        if self.dry_run:
            install_cmd = ("sudo " if sudo_needed else "") + "make install"
            log("info", "[dry-run] Would run:")
            log("info", f"  git clone {OPENOCD_REPO} {self.clone_dir}")
            log("info", f"  git checkout {OPENOCD_COMMIT}")
            if chip["patch"] == "ft4232ha":
                log("info",  "  patch src/jtag/drivers/mpsse.h  — add TYPE_FT4232HA enum value")
                log("info",  "  patch src/jtag/drivers/mpsse.c  — map bcdDevice 0x3600 → TYPE_FT4232HA")
                log("info",  "  patch contrib/60-openocd.rules  — add PID 0x6048 udev rule")
            log("info", f"  ./bootstrap && ./configure --prefix={self.install_prefix} && make -j4 && {install_cmd}")
            return True

        self.build_dir.mkdir(parents=True, exist_ok=True)

        if not self._clone(log):
            return False
        if chip["patch"] == "ft4232ha":
            if not self._patch_ft4232ha(log):
                return False
        return self._build(log)

    def verify(self, log: ProgressCallback) -> bool:
        binary = self._openocd_bin()
        if binary:
            log("ok", f"openocd found : {binary}")
            result = subprocess.run([str(binary), "--version"],
                                    capture_output=True, text=True)
            version_line = (result.stdout or result.stderr).splitlines()
            if version_line:
                log("info", f"  {version_line[0]}")
            return True
        log("error", f"openocd not found in {self.install_prefix / 'bin'} or on PATH.")
        return False

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _clone(self, log: ProgressCallback) -> bool:
        if self.clone_dir.exists():
            log("info", "Source directory already exists — skipping clone.")
            log("info", f"  {self.clone_dir}")
        else:
            log("info", f"Cloning {OPENOCD_REPO} …")
            log("info", "  (this may take a few minutes on a slow connection)")
            if not self._cmd(["git", "clone", "--progress",
                               OPENOCD_REPO, str(self.clone_dir)],
                              cwd=self.build_dir, log=log):
                return False

        log("info", "")
        log("info", f"Checking out commit {OPENOCD_COMMIT[:12]} …")
        return self._cmd(["git", "checkout", OPENOCD_COMMIT],
                         cwd=self.clone_dir, log=log)

    def _patch_ft4232ha(self, log: ProgressCallback) -> bool:
        log("info", "")
        log("info", "Applying FT4232HA support patches …")
        log("info", "  bcdDevice 0x3600 identifies the HA variant (EEPROM Appendix A)")

        h_file = self.clone_dir / "src/jtag/drivers/mpsse.h"
        text = h_file.read_text()
        if "TYPE_FT4232HA" in text:
            log("info", "  [skip]    mpsse.h — already patched")
        else:
            text = text.replace(
                "\tTYPE_FT232H,\n};",
                "\tTYPE_FT232H,\n\tTYPE_FT4232HA,\n};"
            )
            h_file.write_text(text)
            log("ok",  "  [patched] src/jtag/drivers/mpsse.h — added TYPE_FT4232HA enum value")

        c_file = self.clone_dir / "src/jtag/drivers/mpsse.c"
        text = c_file.read_text()
        if "0x3600" in text:
            log("info", "  [skip]    mpsse.c — already patched")
        else:
            insert = (
                "\t\tcase 0x3600:\n"
                "\t\t\tctx->type = TYPE_FT4232HA;\n"
                "\t\t\tbreak;\n"
            )
            text = text.replace(
                "\t\tdefault:\n\t\t\tLOG_ERROR",
                insert + "\t\tdefault:\n\t\t\tLOG_ERROR"
            )
            c_file.write_text(text)
            log("ok",  "  [patched] src/jtag/drivers/mpsse.c — case 0x3600 → TYPE_FT4232HA")

        rules_file = self.clone_dir / "contrib/60-openocd.rules"
        text = rules_file.read_text()
        if "6048" in text:
            log("info", "  [skip]    60-openocd.rules — already patched")
        else:
            ha_rule = (
                "# Original FT4232HA VID:PID\n"
                'ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6048",'
                ' MODE="660", GROUP="plugdev", TAG+="uaccess"\n\n'
            )
            text = text.replace(
                "# Original FT4232 VID:PID\n",
                ha_rule + "# Original FT4232 VID:PID\n"
            )
            rules_file.write_text(text)
            log("ok",  "  [patched] contrib/60-openocd.rules — added PID 0x6048 udev rule")

        log("ok", "All patches applied.")
        return True

    def _build(self, log: ProgressCallback) -> bool:
        sudo_needed = _needs_sudo(self.install_prefix)
        install_cmd = ["sudo", "make", "install"] if sudo_needed else ["make", "install"]

        if sudo_needed:
            log("info", "")
            log("info", f"Prefix {self.install_prefix} requires sudo for installation.")
            log("info", "Authenticating now so the prompt appears before compilation starts …")
            result = subprocess.run(["sudo", "-v"])
            if result.returncode != 0:
                log("error", "sudo authentication failed.")
                return False
            log("ok", "sudo credentials obtained.")

        stages = [
            (["./bootstrap"],
             "Step 1/4 — Bootstrap …"),
            (["./configure", f"--prefix={self.install_prefix}"],
             f"Step 2/4 — Configure  (prefix: {self.install_prefix}) …"),
            (["make", "-j4"],
             "Step 3/4 — Compile  (this takes several minutes) …"),
            (install_cmd,
             f"Step 4/4 — Install into {self.install_prefix} …"),
        ]
        log("info", "")
        for cmd, msg in stages:
            log("info", msg)
            if not self._cmd(cmd, cwd=self.clone_dir, log=log):
                return False
            log("ok", "  done.")
            log("info", "")
        return True

    def _cmd(self, cmd: list, cwd: Path, log: ProgressCallback) -> bool:
        try:
            proc = subprocess.Popen(
                cmd, cwd=cwd,
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                text=True, bufsize=1,
            )
            for line in proc.stdout:
                log("detail", "    " + line.rstrip())
            proc.wait()
            if proc.returncode != 0:
                log("error", f"  Command failed (exit {proc.returncode}): {' '.join(cmd)}")
                return False
            return True
        except FileNotFoundError as exc:
            log("error", str(exc))
            return False
