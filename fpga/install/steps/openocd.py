import shutil
import subprocess
from pathlib import Path
from .base import Step, ProgressCallback

OPENOCD_REPO   = "https://github.com/riscv-collab/riscv-openocd"
OPENOCD_COMMIT = "9ea7f3d647c8ecf6b0f1424002dfc3f4504a162c"

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
    },
    "ft2232h": {
        "pid": "6010", "bcd_device": "0x0700",
        "type_enum": "TYPE_FT2232H",
        "udev_in_rules": True,
        "patch": None,
        "jtag_channel": "A (ADBUS)",
    },
    "ft4232h": {
        "pid": "6011", "bcd_device": "0x0800",
        "type_enum": "TYPE_FT4232H",
        "udev_in_rules": True,
        "patch": None,
        "jtag_channel": "B (BDBUS)",
    },
    "ft4232ha": {
        "pid": "6048", "bcd_device": "0x3600",
        "type_enum": "TYPE_FT4232HA",
        "udev_in_rules": False,
        "patch": "ft4232ha",
        "jtag_channel": "B (BDBUS)",
    },
}


class OpenOCDStep(Step):
    title = "OpenOCD"
    description = "Clone, build and install OpenOCD with RISC-V JTAG support"

    def __init__(self, build_dir: Path, ftdi_chip: str = "ft4232h"):
        self.build_dir  = build_dir
        self.ftdi_chip  = ftdi_chip
        self.clone_dir  = build_dir / "riscv-openocd"
        self._chip      = CHIPS[ftdi_chip]

    def check(self) -> bool:
        return shutil.which("openocd") is not None

    def run(self, log: ProgressCallback) -> bool:
        chip = self._chip
        log("info", f"Repository  : {OPENOCD_REPO}")
        log("info", f"Commit      : {OPENOCD_COMMIT[:12]}  (full: {OPENOCD_COMMIT})")
        log("info", f"FTDI chip   : {self.ftdi_chip.upper()}"
                    f"  (PID 0x{chip['pid']}, bcdDevice {chip['bcd_device']})")
        log("info", f"JTAG channel: {chip['jtag_channel']}")
        log("info", f"Patch needed: {'yes — ' + chip['patch'] if chip['patch'] else 'no'}")
        log("info", f"Build dir   : {self.clone_dir}")
        log("info", "")

        if self.dry_run:
            log("info", "[dry-run] Would run:")
            log("info", f"  git clone {OPENOCD_REPO} {self.clone_dir}")
            log("info", f"  git checkout {OPENOCD_COMMIT}")
            if chip["patch"] == "ft4232ha":
                log("info",  "  patch src/jtag/drivers/mpsse.h  — add TYPE_FT4232HA enum value")
                log("info",  "  patch src/jtag/drivers/mpsse.c  — map bcdDevice 0x3600 → TYPE_FT4232HA")
                log("info",  "  patch contrib/60-openocd.rules  — add PID 0x6048 udev rule")
            log("info", "  ./bootstrap && ./configure && make -j4 && sudo make install")
            return True

        self.build_dir.mkdir(parents=True, exist_ok=True)

        if not self._clone(log):
            return False
        if chip["patch"] == "ft4232ha":
            if not self._patch_ft4232ha(log):
                return False
        return self._build(log)

    def verify(self, log: ProgressCallback) -> bool:
        path = shutil.which("openocd")
        if path:
            log("ok", f"openocd found : {path}")
            result = subprocess.run(["openocd", "--version"],
                                    capture_output=True, text=True)
            version_line = (result.stdout or result.stderr).splitlines()
            if version_line:
                log("info", f"  {version_line[0]}")
            return True
        log("error", "openocd not found on PATH after installation.")
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
        stages = [
            (["./bootstrap"],             "Step 1/4 — Bootstrap (generating configure script) …"),
            (["./configure"],             "Step 2/4 — Configure …"),
            (["make", "-j4"],             "Step 3/4 — Compile  (this takes several minutes) …"),
            (["sudo", "make", "install"], "Step 4/4 — Install  (requires sudo) …"),
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
                log("info", "    " + line.rstrip())
            proc.wait()
            if proc.returncode != 0:
                log("error", f"  Command failed (exit {proc.returncode}): {' '.join(cmd)}")
                return False
            return True
        except FileNotFoundError as exc:
            log("error", str(exc))
            return False
