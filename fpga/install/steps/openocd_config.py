import re
from pathlib import Path
from .base import Step, ProgressCallback
from .openocd import CHIPS


class OpenOCDConfigStep(Step):
    title = "OpenOCD Config"
    description = "Patch fpga/utils/openocd-didactic.cfg for the selected FTDI chip"

    def __init__(self, cfg_path: Path, ftdi_chip: str):
        self.cfg_path  = cfg_path
        self.ftdi_chip = ftdi_chip
        self._chip     = CHIPS[ftdi_chip]

    def check(self) -> bool:
        if not self.cfg_path.exists():
            return False
        text = self.cfg_path.read_text()
        chip = self._chip
        vid_pid_line = f"ftdi vid_pid {chip['openocd_vid']} {chip['openocd_pid']}"
        channel_line = f"ftdi channel {chip['openocd_channel']}"
        return vid_pid_line in text and channel_line in text

    def run(self, log: ProgressCallback) -> bool:
        chip = self._chip
        vid_pid_want = f"ftdi vid_pid {chip['openocd_vid']} {chip['openocd_pid']}"
        channel_want = f"ftdi channel {chip['openocd_channel']}"

        log("info", f"Config file  : {self.cfg_path}")
        log("info", f"FTDI chip    : {self.ftdi_chip.upper()}")
        log("info", f"  ftdi channel  → {chip['openocd_channel']}  ({chip['jtag_channel']})")
        log("info", f"  ftdi vid_pid  → {chip['openocd_vid']} {chip['openocd_pid']}")
        log("info", "")

        if self.dry_run:
            log("info", "[dry-run] Would patch:")
            log("info", f"  ftdi channel <n>           →  {channel_want}")
            log("info", f"  ftdi vid_pid <vid> <pid>   →  {vid_pid_want}")
            return True

        if not self.cfg_path.exists():
            log("error", f"Config file not found: {self.cfg_path}")
            return False

        text = self.cfg_path.read_text()
        original = text

        text = re.sub(r"^ftdi channel \S+",   channel_want,  text, flags=re.MULTILINE)
        text = re.sub(r"^ftdi vid_pid \S+ \S+", vid_pid_want, text, flags=re.MULTILINE)

        if text == original:
            log("info", "Config already up to date — no changes made.")
            return True

        self.cfg_path.write_text(text)
        log("ok", "Config patched successfully.")
        return True
