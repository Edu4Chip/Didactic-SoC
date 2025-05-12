from typing import Dict
from pathlib import Path

# File-level bindings
# Keys:
# 1. module
# 2. type (nms, ms, sw)
# Value: generated bindings
FileLvlBindings = Dict[str, Dict[str, str]]

# Project-level bindings
# Keys:
# 1. path
# 2. module
# 3. type (nms, ms, sw)
# Value: generated bindings
ProjectLvlBindings = Dict[Path, FileLvlBindings]

PATH_HDL_BINDINGS = Path("./verification/verilator/hdl_bindings.pickle").resolve()
