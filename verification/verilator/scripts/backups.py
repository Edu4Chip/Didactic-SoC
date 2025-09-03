#!/usr/bin/env python3

import os
import shutil
import argparse
from typing import List
from pathlib import Path

from colorama import Fore

from print import print

class PathExt(Path):
    def path_to_backup(self) -> "PathExt":
        # Assume backup under same parent
        return PathExt(str(self) + ".bak")

    def backup(self) -> bool:
        if self.path_to_backup().exists():
            return False
        shutil.copy(self, self.path_to_backup())
        return True

    def restore(self) -> bool:
        if not self.path_to_backup().exists():
            return False
        shutil.copy(self.path_to_backup(), self)
        os.remove(self.path_to_backup())
        return True

def execute_backup(files: List[PathExt]):
    for file in files:
        print(file, indent=0)
        if file.path_to_backup().exists():
            _ = file.restore()
        if not file.backup():
            print(f"could not backup", indent=1, color=Fore.RED)

def execute_restore(files: List[PathExt]):
    for file in files:
        print(file, indent=0)
        if not file.restore():
            print(f"could not restore", indent=1, color=Fore.RED)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action")
    parser.add_argument("files", nargs="+")
    arguments = vars(parser.parse_args())

    action = arguments["action"]
    files_str = arguments["files"]
    files = list(map(lambda s: PathExt(s), files_str))
    files = list(map(lambda p: p.resolve(), files))
    match action:
        case "backup":
            execute_backup(files)
        case "restore":
            execute_restore(files)
        case other:
            print(f"unknown action: {other}", color=Fore.RED)
