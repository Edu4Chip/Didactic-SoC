import subprocess
from pathlib import Path
from .base import Step, ProgressCallback

_RULES_DST = Path("/etc/udev/rules.d/60-openocd.rules")


class UdevRulesStep(Step):
    title = "Udev Rules"
    description = "Install USB device access rules for the FTDI adapter"

    def __init__(self, rules_src: Path):
        self.rules_src = rules_src

    def check(self) -> bool:
        return _RULES_DST.exists()

    def run(self, log: ProgressCallback) -> bool:
        log("info", f"Source : {self.rules_src}")
        log("info", f"Dest   : {_RULES_DST}")
        log("info", "")

        if self.dry_run:
            log("info", f"[dry-run] Would run:")
            log("info", f"  sudo cp {self.rules_src} {_RULES_DST}")
            log("info",  "  sudo udevadm control --reload-rules")
            log("info",  "  sudo udevadm trigger")
            return True

        if not self.rules_src.exists():
            log("error", "Rules file not found — OpenOCD must be built first.")
            log("error", f"  Expected: {self.rules_src}")
            return False

        # Count rules in the file for a quick sanity check
        try:
            lines = self.rules_src.read_text().splitlines()
            rule_count = sum(1 for l in lines if "ATTRS{idVendor}" in l)
            log("info", f"Rules file contains {rule_count} device rule(s).")
        except Exception:
            pass

        log("info", f"Copying rules file (requires sudo) …")
        result = subprocess.run(
            ["sudo", "cp", str(self.rules_src), str(_RULES_DST)],
            capture_output=True, text=True,
        )
        if result.returncode != 0:
            log("error", "sudo cp failed:")
            log("error", f"  {result.stderr.strip()}")
            return False
        log("ok", f"Copied to {_RULES_DST}")

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
