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
import pickle
import shutil
import argparse
from string import Template
from typing import Dict, List, Optional, Any
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print
from parser import parse_file, print_modules
from bindings import PATH_HDL_BINDINGS, ProjectLvlBindings

TEMPLATE_MS = Template("""\
// injected by ${path_script}
`ifdef VERILATOR
  ${content}
`endif
""")

TEMPLATE_NMS = Template("""\
// injected by ${path_script}
`ifdef VERILATOR
  ${content}
`endif
""")

TEMPLATE_MODULE = Template("""\
${nms_content}
module ${module_name} ${module_parameter_list} ${module_port_list};
${ms_content}
${module_body}
endmodule
""")

PATH_SCRIPT = f"{__file__}"

def get_original_paths(directory: Path) -> List[Path]:
    return list(filter(lambda p: p.suffix != ".bak", directory.iterdir()))

def get_backup_paths(directory: Path) -> List[Path]:
    return list(filter(lambda p: p.suffix == ".bak", directory.iterdir()))

def flatten_nested_list(raw_list: List[List[Any] | str]) -> List[str]:
    new_list = list()
    for item in raw_list:
        if isinstance(item, str):
            new_list.append(item)
        elif isinstance(item, list):
            joined = flatten_nested_list(item)
            new_list.extend(joined)
        else:
            raise Exception(f"unsupported item type: {item}")
    return new_list

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

def inject(path: Path, plb: ProjectLvlBindings, level=0):
    print(f"injecting {path}", indent=level)
    if path not in plb.keys():
        print(f"path not found in project-level bindings", indent=level+1, color=Fore.RED)
        return

    # Execute injection
    file_level_result_generator = parse_file(path)
    if file_level_result_generator is None:
        print(f"failed to parse file, injection failed", indent=level+1, color=Fore.RED)
        return

    file_level_result = list(file_level_result_generator)

    # One file must contain only 1 file-level match
    match len(file_level_result):
        case 1:
            # Success
            file_level_match, _, _ = file_level_result[0]
        case other:
            print(f"found {other} file-level matches, injection failed", indent=level+1, color=Fore.RED)
            return

    # Print which modules were detected
    print_modules(file_level_match, level=level+1)

    # Execute actual injection
    print(f"executing injection", indent=level+1)
    modified_elements = list()
    for element in file_level_match:
        assert isinstance(element, pp.ParseResults)
        element_type = element.get_name()
        if element_type is None:
            continue
        match element_type:
            case "module":
                element_dict = element.as_dict()
                element_list = element.as_list()

                module_name = element_dict["module_name"]
                
                module_parameter_list = element_dict.get("module_parameter_list", "")
                
                # Can not use dict because all except one port are removed
                #module_port_list = element_dict.get("module_port_list", "")
                module_port_list = ""
                for sub_element in element:
                    if isinstance(sub_element, pp.ParseResults) and sub_element.get_name() == "module_port_list":
                        module_port_list_list = sub_element
                        # Remove surrounding braces
                        _ = module_port_list_list.pop(0)
                        _ = module_port_list_list.pop(-1)
                        # Join separate port definitions
                        new_module_port_list = list()
                        for port in module_port_list_list:
                            new_port = " ".join(port)
                            new_module_port_list.append(new_port)
                        # Combine port definitions into a port list
                        module_port_list = ",\n".join(new_module_port_list)
                        module_port_list = "(" + module_port_list + ")"

                module_body = element_dict["module_body"][0]

                if isinstance(module_parameter_list, list):
                    module_parameter_list = " ".join(module_parameter_list)
                if isinstance(module_port_list, list):
                    # Remove surrounding braces
                    _ = module_port_list.pop(0)
                    _ = module_port_list.pop(-1)
                    # Join separate port definitions
                    new_module_port_list = list()
                    for port in module_port_list:
                        new_port = " ".join(port)
                        new_module_port_list.append(new_port)
                    # Combine port definitions into a port list
                    module_port_list = ",\n".join(new_module_port_list)
                    module_port_list = "(" + module_port_list + ")"

                ms_content = None
                nms_content = None
                if module_name in plb[path].keys():
                    ms_content = plb[path][module_name]["ms"]
                    ms_content = TEMPLATE_MS.substitute(
                        path_script = PATH_SCRIPT,
                        content = ms_content
                    )
                    nms_content = plb[path][module_name]["nms"]
                    nms_content = TEMPLATE_NMS.substitute(
                        path_script = PATH_SCRIPT,
                        content = nms_content,
                    )
                else:
                    print(f"did not found module {module_name} from project-level bindings", indent=level+3, color=Fore.RED)

                # Rebuild module
                element_str = TEMPLATE_MODULE.substitute(
                    nms_content = nms_content,
                    module_name = module_name,
                    module_parameter_list = module_parameter_list,
                    module_port_list = module_port_list,
                    ms_content = ms_content,
                    module_body = module_body,
                )
            case _:
                # Filter lists of empty strings
                element_list = list(element)
                element_list = list(filter(None, element_list))
                element_str = " ".join(element_list)
        modified_elements.append(element_str)
    elements_str = "".join(modified_elements)
    
    # Write modified data back
    with path.open("w") as stream:
        stream.write(elements_str)

def try_to_find_project_level_bindings(level=0) -> Optional[ProjectLvlBindings]:
    if PATH_HDL_BINDINGS.exists():
        print(f"found project-level bindings from path:", indent=level, color=Fore.GREEN)
        print(f" - {PATH_HDL_BINDINGS}", indent=level, color=Fore.GREEN)
        with PATH_HDL_BINDINGS.open("rb") as stream:
            plb = pickle.load(stream)
        return plb
    else:
        print(f"did not find project-level bindings, injection failed:", indent=level, color=Fore.RED)
        print(f" - {PATH_HDL_BINDINGS}", indent=level, color=Fore.RED)
        return None

def execute_do(directory: Path, level=0):
    # Check that project-level bindings even exist
    maybe_plb = try_to_find_project_level_bindings(level)
    if maybe_plb is None:
        return
    else:
        plb = maybe_plb
    
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
            inject(original, plb, level=level+1)

def execute_undo(directory: Path, level=0):
    backup_mapping = solve_backup_mapping(directory)
    
    # Replace originals with backups
    print(f"replacing original files with backups:", indent=level)
    for original, backup in backup_mapping.items():
        _ = try_replace_original_with_backup(original, backup, level=level+1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["do", "undo", "status", "inject"])
    parser.add_argument("--path", type=Path)
    arguments = vars(parser.parse_args())
    
    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda d: Path(d).resolve(), directories_str))
    
    action = arguments["action"]
    if action == "do":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
            execute_do(directory, level=1)
    elif action == "undo":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
            execute_undo(directory, level=1)
    elif action == "status":
        for directory in directories:
            print(f"{directory}")
            print_status(directory, level=1)
    elif action == "inject":
        # Check that project-level bindings even exist
        maybe_plb = try_to_find_project_level_bindings(level=0)
        if maybe_plb is None:
            pass
        else:
            plb = maybe_plb
            maybe_path = arguments.get("path")
            if maybe_path is None:
                print(f"argument --path must be a valid path", color=Fore.RED)
            else:
                path = maybe_path
                assert isinstance(path, Path)
                if path.exists():
                    path = path.resolve()
                    print(f"{path}")
                    inject(path, plb, level=1)
                else:
                    print(f"given path does not exist: {path}", color=Fore.RED)
    else:
        # This branch should never execute
        raise Exception(f"unknown action: {arguments["action"]}")
