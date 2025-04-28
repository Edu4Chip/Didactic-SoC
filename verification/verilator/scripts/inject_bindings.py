"""Inject HDL bindings into HDL files

# How to use?

## Inject bindings

`python3 inject_bindings.py do`

## Remove injected bindings

`python3 inject_bindings.py undo`

## Print status

`python3 inject_bindings.py status`
"""

import os
import shutil
import argparse
from typing import Dict, List, Optional
from pathlib import Path

import pyparsing as pp
from colorama import Fore, Style

from parser import parse_file

INDENT = "  "

original_print = print

def print(*args, **kwargs):
    color = kwargs.pop("color", None)
    indent = INDENT * kwargs.pop("indent", 0)
    if color is None:
        original_print(indent + " ".join(map(str, args)), **kwargs)
    else:
        original_print(color + indent + " ".join(map(str, args)) + Style.RESET_ALL, **kwargs)

def get_original_paths(directory: Path) -> List[Path]:
    return list(filter(lambda p: p.suffix != ".bak", directory.iterdir()))

def get_backup_paths(directory: Path) -> List[Path]:
    return list(filter(lambda p: p.suffix == ".bak", directory.iterdir()))

def solve_backup_mapping(directory: Path) -> Dict[Path, Optional[Path]]:
    result: Dict[Path, Optional[Path]] = dict()
    originals = get_original_paths(directory)
    backups = get_backup_paths(directory)
    for original in originals:
        backup = Path(str(original) + ".bak")
        if backup in backups:
            result[original] = backup
        else:
            result[original] = None
    return result

def solve_orphaned_backups(directory: Path) -> List[Path]:
    result = list()
    originals = get_original_paths(directory)
    backups = get_backup_paths(directory)
    for backup in backups:
        expected_original = backup.with_suffix("")
        if expected_original in originals:
            pass
        else:
            result.append(backup)
    return result

def solve_orphaned_originals(directory: Path) -> List[Path]:
    result = list()
    backup_mapping = solve_backup_mapping(directory)
    for original, backup in backup_mapping.items():
        if backup is None:
            result.append(original)
        else:
            pass
    return result

def print_status(directory: Path, level=0):
    backup_mapping = solve_backup_mapping(directory)
    has_backupped_originals = False
    for original, backup in backup_mapping.items():
        if backup is None:
            pass
        else:
            has_backupped_originals = True
            break
    if has_backupped_originals:
        print(f"originals with backups:", indent=level, color=Fore.GREEN)
        for original, backup in backup_mapping.items():
            if backup is None:
                # Handled later
                pass
            else:
                print(f"    {original}", indent=level+1, color=Fore.GREEN)
                print(f"<-> {backup}", indent=level+1, color=Fore.GREEN)
    
    orphaned_originals = solve_orphaned_originals(directory)
    if 0 < len(orphaned_originals):
        # This is concerning
        print(f"found {len(orphaned_originals)} originals without backups:", indent=level, color=Fore.YELLOW)
        for oo in orphaned_originals:
            print(f"{oo}", indent=level+1, color=Fore.YELLOW)
    
    orphaned_backups = solve_orphaned_backups(directory)
    if 0 < len(orphaned_backups):
        # This should never happen
        print(f"found {len(orphaned_backups)} orphaned backups:", indent=level, color=Fore.RED)
        for ob in orphaned_backups:
            print(f"{ob}", indent=level+1, color=Fore.RED)

def replace_original_with_backup(original: Path, backup: Path):
    shutil.copy2(backup, original)
    os.remove(backup)

def try_replace_original_with_backup(original: Path, backup: Optional[Path], level=0) -> bool:
    if backup is None:
        print(f"file has no backup:", indent=level, color=Fore.YELLOW)
        print(f" - {original}", indent=level, color=Fore.YELLOW)
        return False
    else:
        print(f"{original}", indent=level, color=Fore.GREEN)
        print(f" <- {backup}", indent=level, color=Fore.GREEN)
        replace_original_with_backup(original, backup)
        return True

def inject(path: Path, level=0):
    print(f"injecting {path}", indent=level)
    
    # Can we find injection material for given path?
    original_relative = path.relative_to(Path.cwd())
    root_ms = Path.cwd() / Path("verification/verilator/src/hdl/ms")
    root_nms = Path.cwd() / Path("verification/verilator/src/hdl/nms")
    material_ms = root_ms / original_relative
    material_nms = root_nms / original_relative
    
    ms_exists = material_ms.exists()
    if not ms_exists:
        print(f"module specific injection material not found", indent=level+1, color=Fore.YELLOW)
        # Create missing path
        material_ms.parent.mkdir(parents=True, exist_ok=True)
        material_ms.touch(exist_ok=False)
        print(f"created new path to module specific injection material:", indent=level+1, color=Fore.RED)
        print(f" - {material_ms}", indent=level+1, color=Fore.RED)
        print(f"rerun this script", indent=level+1, color=Fore.RED)
    nms_exists = material_nms.exists()
    if not nms_exists:
        print(f"non-module specific injection material not found", indent=level+1, color=Fore.YELLOW)
        # Create missing path
        material_nms.parent.mkdir(parents=True, exist_ok=True)
        material_nms.touch(exist_ok=False)
        print(f"created new path to non-module specific injection material:", indent=level+1, color=Fore.RED)
        print(f" - {material_nms}", indent=level+1, color=Fore.RED)
        print(f"rerun this script", indent=level+1, color=Fore.RED)
    
    # Execute injection
    maybe_scans = parse_file(path)
    if maybe_scans is None:
        print(f"failed to inject", indent=level+1, color=Fore.RED)
    else:
        # Get file-level matches
        scans = list(maybe_scans)
        if len(scans) == 0:
            print(f"found 0 scans", indent=level+1, color=Fore.RED)
        else:
            if len(scans) == 1:
                print(f"found 1 scan:", indent=level+1, color=Fore.GREEN)
                results, _, _ = scans[0]
                
                # Print which modules were detected
                modules = list()
                for element in results:
                    assert isinstance(element, pp.ParseResults)
                    element_type = element.get_name()
                    if element_type is None:
                        print(f"found element without name", indent=level+2, color=Fore.RED)
                    else:
                        if element_type == "module":
                            #element.pprint()
                            module_name = element[1]
                            modules.append(module_name)
                        else:
                            pass
                if len(modules) == 0:
                    print(f"found 0 modules", indent=level+2, color=Fore.RED)
                else:
                    print(f"found {len(modules)} modules:", indent=level+2, color=Fore.GREEN)
                    for module_name in modules:
                        print(f"{module_name}", indent=level+3, color=Fore.GREEN)
                
                # Execute actual injection
                for element in results:
                    assert isinstance(element, pp.ParseResults)
                    element_type = element.get_name()
                    if element_type is None:
                        pass
                    else:
                        if element_type == "module":
                            element_list = element.as_list()
                            # Inject before module
                            if nms_exists:
                                material_nms_relative = material_nms.relative_to(Path.cwd())
                                index_module = element_list.index("module")
                                element_list.insert(index_module, f"// injected by {__file__}\n`ifdef VERILATOR\n  `include \"{material_nms_relative}\"\n`endif\n")
                            
                            # Inject before endmodule
                            if ms_exists:
                                material_ms_relative = material_ms.relative_to(Path.cwd())
                                index_endmodule = element_list.index("endmodule")
                                element_list.insert(index_endmodule, f"// injected by {__file__}\n`ifdef VERILATOR\n  `include \"{material_ms_relative}\"\n`endif\n")
                            
                            
                            def join_nested(raw_list: List[List[str] | str]) -> List[str]:
                                new_list = list()
                                for item in raw_list:
                                    if isinstance(item, str):
                                        new_list.append(item)
                                    elif isinstance(item, list):
                                        new_item = " ".join(item)
                                        new_list.append(new_item)
                                    else:
                                        raise Exception(f"unknown item type: {item}")
                                return new_list
                            
                            element_list = join_nested(element_list)
                            
                            # Write modified data back to original
                            text = " ".join(element_list)
                            with path.open("w") as stream:
                                stream.write(text)
            else:
                # One file should contain only 1 file-level match
                print(f"found {len(scans)} scans, skipped", indent=level+1, color=Fore.RED)

def execute_do(directory: Path, level=0):
    # Replace originals with backups
    print(f"replacing original files with backups:", indent=level)
    backup_mapping = solve_backup_mapping(directory)
    for original, backup in backup_mapping.items():
        if try_replace_original_with_backup(original, backup, level=level+1):
            backup_mapping[original] = None
        else:
            # Fine if backup was not created before
            pass
    
    # Check that no original has backups
    backup_mapping = solve_backup_mapping(directory)
    for original, backup in backup_mapping.items():
        if backup is None:
            pass
        else:
            # This branch should never execute
            raise Exception(f"original {original} still has backup after replacement")

    # Create backups from originals
    print(f"creating backups from originals:", indent=level)
    orphaned_originals = solve_orphaned_originals(directory)
    if 0 < len(orphaned_originals):
        print(f"found {len(orphaned_originals)} originals without backups:", indent=level, color=Fore.GREEN)
        for oo in orphaned_originals:
            backup = Path(str(oo) + ".bak")
            print(f"   {oo}", indent=level+1, color=Fore.GREEN)
            print(f"-> {backup}", indent=level+1, color=Fore.GREEN)
            shutil.copy2(oo, backup)
    else:
        print(f"found {len(orphaned_originals)} originals without backups", indent=level, color=Fore.YELLOW)
    
    # Execute injections to originals which are backupped
    print(f"injecting originals", indent=level)
    backup_mapping = solve_backup_mapping(directory)
    for original, backup in backup_mapping.items():
        if backup is None:
            print(f"path is not backupped, injection could not be done:", indent=level+1, color=Fore.RED)
            print(f" - {original}", indent=level+1, color=Fore.RED)
        else:
            inject(original, level=level+1)

def execute_undo(directory: Path, level=0):
    backup_mapping = solve_backup_mapping(directory)
    
    # Replace originals with backups
    print(f"replacing original files with backups:", indent=level)
    for original, backup in backup_mapping.items():
        _ = try_replace_original_with_backup(original, backup, level=level+1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["do", "undo", "status"])
    arguments = vars(parser.parse_args())
    
    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda d: Path(d).resolve(), directories_str))
    
    if arguments["action"] == "do":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
            execute_do(directory, level=1)
    elif arguments["action"] == "undo":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
            execute_undo(directory, level=1)
    elif arguments["action"] == "status":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
    else:
        # This branch should never execute
        raise Exception(f"unknown action: {arguments["action"]}")
