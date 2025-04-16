import os
import re
import shutil
import argparse
from pprint import pprint
from pathlib import Path

import pyparsing as pp
from colorama import Fore, Style


def solve_backup_mapping(directory):
    # Solve which originals exist
    backup_mapping = dict()
    for path in list(directory.iterdir()):
        if path.suffix == ".bak":
            pass
        else:
            backup_mapping[path] = None
    # Solve which originals are backupped and which backups are orphans
    orphaned_backups = list()
    for path in list(directory.iterdir()):
        if path.suffix == ".bak":
            original = path.with_suffix("")
            backup = path
            if original in backup_mapping.keys():
                backup_mapping[original] = backup
            else:
                orphaned_backups.append(backup)
        else:
            pass
    # Solve which originals are not backupped
    orphaned_originals = list()
    for original, backup in backup_mapping.items():
        if backup is None:
            orphaned_originals.append(original)
        else:
            pass
    return backup_mapping, orphaned_backups, orphaned_originals


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["do", "undo"])
    arguments = vars(parser.parse_args())
    
    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda d: Path(d).resolve(), directories_str))
    for directory in directories:
        print(f"{directory}")
        backup_mapping, orphaned_backups, orphaned_originals = solve_backup_mapping(directory)
        if 0 < len(orphaned_originals):
            print(Fore.RED + f"  found {len(orphaned_originals)} originals without backups:" + Style.RESET_ALL)
            for oo in orphaned_originals:
                print(Fore.RED + f"    {oo}" + Style.RESET_ALL)
        if 0 < len(orphaned_backups):
            print(Fore.RED + f"  found {len(orphaned_backups)} orphaned backups:" + Style.RESET_ALL)
            for ob in orphaned_backups:
                print(Fore.RED + f"    {ob}" + Style.RESET_ALL)
        if arguments["action"] == "do":
            # Replace originals with backups
            print(f"  replacing original files with backups:")
            for original, backup in backup_mapping.items():
                if backup is None:
                    pass
                else:
                    # Replace original with backup
                    print(Fore.GREEN + f"    {original}" + Style.RESET_ALL)
                    print(Fore.GREEN + f" <- {backup}" + Style.RESET_ALL)
                    shutil.copy2(backup, original)
                    # Remove backup
                    os.remove(backup)
                    backup_mapping[original] = None
            # Create backups from originals
            print(f"  creating backups from originals:")
            orphaned_originals = list()
            for original, backup in backup_mapping.items():
                if backup is None:
                    orphaned_originals.append(original)
                else:
                    pass
            if 0 < len(orphaned_originals):
                print(Fore.GREEN + f"  found {len(orphaned_originals)} originals without backups:" + Style.RESET_ALL)
                for oo in orphaned_originals:
                    backup = Path(str(oo) + ".bak")
                    print(Fore.GREEN + f"    {oo}" + Style.RESET_ALL)
                    print(Fore.GREEN + f" -> {backup}" + Style.RESET_ALL)
                    shutil.copy2(oo, backup)
            else:
                print(Fore.YELLOW + f"  found {len(orphaned_originals)} originals without backups" + Style.RESET_ALL)
            # Execute injections to originals which are backupped
            print(f"  injecting originals")
            backup_mapping, _, _ = solve_backup_mapping(directory)
            for original, backup in backup_mapping.items():
                if backup is None:
                    print(Fore.RED + f"  path is not backupped, injection could not be done:" + Style.RESET_ALL)
                    print(Fore.RED + f"  - {original}" + Style.RESET_ALL)
                else:
                    # Can we find injection material for the original?
                    original_relative = original.relative_to(Path.cwd())
                    root_ms = Path.cwd() / Path("verification/verilator/src/hdl/ms")
                    root_nms = Path.cwd() / Path("verification/verilator/src/hdl/nms")
                    material_ms = root_ms / original_relative
                    material_nms = root_nms / original_relative
                    ms_exists = material_ms.exists()
                    if not ms_exists:
                        print(Fore.YELLOW + f"    module specific injection material not found for original:" + Style.RESET_ALL)
                        print(Fore.YELLOW + f"     - {original}" + Style.RESET_ALL)
                        # Create missing path
                        material_ms.parent.mkdir(parents=True, exist_ok=True)
                        material_ms.touch(exist_ok=False)
                        print(Fore.RED + f"    created new path to module specific injection material:" + Style.RESET_ALL)
                        print(Fore.RED + f"     - {material_ms}" + Style.RESET_ALL)
                        print(Fore.RED + f"    rerun this script" + Style.RESET_ALL)
                    nms_exists = material_nms.exists()
                    if not nms_exists:
                        print(Fore.YELLOW + f"    non-module specific injection material not found for original:" + Style.RESET_ALL)
                        print(Fore.YELLOW + f"     - {original}" + Style.RESET_ALL)
                        # Create missing path
                        material_nms.parent.mkdir(parents=True, exist_ok=True)
                        material_nms.touch(exist_ok=False)
                        print(Fore.RED + f"    created new path to non-module specific injection material:" + Style.RESET_ALL)
                        print(Fore.RED + f"     - {material_nms}" + Style.RESET_ALL)
                        print(Fore.RED + f"    rerun this script" + Style.RESET_ALL)
                    with original.open("r") as stream:
                        data = stream.read()
                    parser = \
                        pp.SkipTo("module") \
                        + "module" \
                        + pp.Word(pp.alphanums + "_").set_results_name("module name") \
                        + pp.Opt("#(" + pp.SkipTo(")") + ")") \
                        + pp.Opt("(" + pp.SkipTo(")", ignore=pp.cppStyleComment) + ")" + ";") \
                        + pp.SkipTo("endmodule") \
                        + "endmodule"
                    result = parser.scan_string(data)
                    scans = list(result)
                    if len(scans) == 0:
                        print(Fore.RED + f"    no scans found for {original}" + Style.RESET_ALL)
                    elif len(scans) == 1:
                        scan = scans[0]
                        scan = scan[0]
                        scan = list(scan)
                        # Inject before module
                        if ms_exists:
                            material_ms_relative = material_ms.relative_to(Path.cwd())
                            index_module = scan.index("module")
                            scan.insert(index_module, f"// injected by {__file__}\n`ifdef VERILATOR\n  `include \"{material_ms_relative}\"\n`endif\n")
                        # Inject before endmodule
                        if nms_exists:
                            material_nms_relative = material_nms.relative_to(Path.cwd())
                            index_endmodule = scan.index("endmodule")
                            scan.insert(index_endmodule, f"// injected by {__file__}\n`ifdef VERILATOR\n  `include \"{material_nms_relative}\"\n`endif\n")
                        #pprint(scan)
                        # Write modified data back to original
                        text = " ".join(scan)
                        #print(text)
                        with original.open("w") as stream:
                            stream.write(text)
                    else:
                        print(Fore.RED + f"    multiple scans found for {original}" + Style.RESET_ALL)
        elif arguments["action"] == "undo":
            # Replace originals with backups
            print(f"  replacing original files with backups:")
            for original, backup in backup_mapping.items():
                if backup is None:
                    pass
                else:
                    # Replace original with backup
                    print(Fore.GREEN + f"    {original}" + Style.RESET_ALL)
                    print(Fore.GREEN + f" <- {backup}" + Style.RESET_ALL)
                    shutil.copy2(backup, original)
                    # Remove backup
                    os.remove(backup)
                    backup_mapping[original] = None
        else:
            # This branch should never execute
            raise Exception(f"unknown action: {arguments["action"]}")
