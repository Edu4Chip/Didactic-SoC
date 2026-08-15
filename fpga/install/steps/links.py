# =============================================================================
# Project      : DidacticSoC
# File         : fpga/install/steps/links.py
# Description  : Load external resource URLs and version pins from links.json
#                at the install root; exposes named constants used by the step
#                modules so all download targets live in one place.
# -----------------------------------------------------------------------------
# Copyright    : Copyright (c) 2026 LogiqWorks Ltd.
# License      : Solderpad Hardware Licence Version 2.1 (SHL-2.1)
# Contributors : LogiqWorks Ltd.
# Contact      : Dobroslav Tsonev  <dobroslav.tsonev@logiqworks.io>
#                Vladimir Todorov   <vladimir.todorov@logiqworks.io>
# =============================================================================
import json
from pathlib import Path

_LINKS_FILE = Path(__file__).resolve().parent.parent / "links.json"


def _load() -> dict:
    try:
        with _LINKS_FILE.open() as f:
            return json.load(f)
    except (OSError, json.JSONDecodeError) as exc:
        raise RuntimeError(
            f"Cannot load {_LINKS_FILE}: {exc}\n"
            "Ensure the install directory structure is intact."
        ) from exc


_links = _load()

# OpenOCD source repository and pinned commit
OPENOCD_REPO      = _links["openocd"]["repo"]
OPENOCD_COMMIT    = _links["openocd"]["commit"]
# Udev rules fetched from the same pinned commit when no local copy is found
OPENOCD_RULES_URL = _links["openocd"]["rules_url"]

# RISC-V GNU toolchain tarball; {release} and {os_tag} are substituted at runtime
TOOLCHAIN_URL_TEMPLATE    = _links["toolchain"]["url_template"]
TOOLCHAIN_DEFAULT_RELEASE = _links["toolchain"]["default_release"]

# PYNQ board file archives.  Each entry has:
#   url    — download URL for a ZIP archive
#   prefix — path inside the ZIP that contains the <hw-rev>/board.xml tree;
#             files are extracted to <target>/<board-name>/<hw-rev>/board.xml
PYNQ_BOARDS: "dict[str, dict]" = _links["pynq_boards"]
