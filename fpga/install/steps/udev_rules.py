# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/udev_rules.py
# Description  : UdevRulesStep — installs the OpenOCD udev rules file
#                (60-openocd.rules) so FTDI USB adapters are accessible without
#                root privileges.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import subprocess
import urllib.request
from pathlib import Path
from .base import Step, ProgressCallback
from .links import OPENOCD_RULES_URL

_RULES_DST = Path("/etc/udev/rules.d/60-openocd.rules")
_RULES_FILENAME = "60-openocd.rules"
_RULES_URL = OPENOCD_RULES_URL

# Paths searched in order before falling back to a download
_SYSTEM_CANDIDATES = [
    Path("/usr/local/share/openocd/contrib") / _RULES_FILENAME,
    Path("/usr/share/openocd/contrib") / _RULES_FILENAME,
]


class UdevRulesStep(Step):
    title = "Udev Rules"
    description = "Install USB device access rules for the FTDI adapter"

    def __init__(self, build_rules_src: Path):
        """build_rules_src: path inside the OpenOCD build/clone directory.
        Used first; if missing the step searches system paths then downloads.
        """
        self.build_rules_src = build_rules_src

    def check(self) -> bool:
        return _RULES_DST.exists()

    def run(self, log: ProgressCallback) -> bool:
        log("info", f"Destination : {_RULES_DST}")
        log("info", "")

        if self.dry_run:
            src = self._find_source(log, dry=True)
            if src is None:
                log("info", f"[dry-run] No local rules file found; would download from:")
                log("info", f"  {_RULES_URL}")
            log("info", "[dry-run] Would run:")
            log("info", f"  sudo cp <rules file> {_RULES_DST}")
            log("info",  "  sudo udevadm control --reload-rules")
            log("info",  "  sudo udevadm trigger")
            return True

        src = self._find_source(log)
        if src is None:
            log("info", f"No local rules file found — downloading from pinned commit …")
            log("info", f"  {_RULES_URL}")
            src = self._download(log)
            if src is None:
                return False

        log("info", f"Copying rules file (requires sudo) …")
        result = subprocess.run(
            ["sudo", "cp", str(src), str(_RULES_DST)],
            capture_output=True, text=True,
        )
        if result.returncode != 0:
            log("error", "sudo cp failed:")
            log("error", f"  {result.stderr.strip()}")
            return False
        log("ok", f"Copied to {_RULES_DST}")

        try:
            lines = _RULES_DST.read_text().splitlines()
            rule_count = sum(1 for l in lines if "ATTRS{idVendor}" in l)
            log("info", f"Rules file contains {rule_count} device rule(s).")
        except Exception:
            pass

        for cmd in [
            ["sudo", "udevadm", "control", "--reload-rules"],
            ["sudo", "udevadm", "trigger"],
        ]:
            log("info", f"Running: {' '.join(cmd)} …")
            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                log("warning", f"  {result.stderr.strip()}")
            else:
                log("ok", "  done.")

        log("info", "")
        log("ok",   "Udev rules installed.")
        log("info", "If the FTDI adapter is already plugged in, replug it now.")
        return True

    # ------------------------------------------------------------------

    def _find_source(self, log: ProgressCallback, dry: bool = False) -> "Path | None":
        candidates = [self.build_rules_src] + _SYSTEM_CANDIDATES
        for path in candidates:
            label = "[dry-run] " if dry else ""
            if path.exists():
                log("ok",  f"{label}Found rules file: {path}")
                return path
            else:
                log("info", f"{label}Not found: {path}")
        return None

    def _download(self, log: ProgressCallback) -> "Path | None":
        dest = Path("/tmp") / _RULES_FILENAME
        try:
            urllib.request.urlretrieve(_RULES_URL, dest)
            log("ok", f"Downloaded to {dest}")
            return dest
        except Exception as exc:
            log("error", f"Download failed: {exc}")
            log("error", "Install the rules manually:")
            log("error", f"  sudo cp /path/to/{_RULES_FILENAME} {_RULES_DST}")
            return None
