from pathlib import Path

from colorama import Fore, Style

from parser import parse_file

if __name__ == "__main__":
    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda p: Path(p).resolve(), directories_str))
    
    for directory in directories:
        print(directory)
        for path in directory.iterdir():
            print(f"  {path}")
            maybe_scans = parse_file(path)
            if maybe_scans is None:
                print(Fore.RED + f"found no scans for {path}" + Style.RESET_ALL)
            else:
                for scan in maybe_scans:
                    results, _, _ = scan
                    #results.pprint()
                    modules = list()
                    for item in results:
                        if item.get_name() == "module":
                            #print(item)
                            module_name = item[1]
                            modules.append(module_name)
                    if 0 < len(modules):
                        print(Fore.GREEN + f"  found {len(modules)} modules:" + Style.RESET_ALL)
                        for module in modules:
                            print(f"    {module}")
                    else:
                        print(Fore.RED + f"  found 0 modules" + Style.RESET_ALL)
