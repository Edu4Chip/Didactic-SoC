#!/usr/bin/env python3

"""Inject HDL bindings into HDL files

# How to use?

`./inject.py --input-hdl <hdl-bindings.pickle> <file(s)>`

"""

import pickle
import argparse
from string import Template
from typing import Dict, List, Any
from pathlib import Path

from colorama import Fore

from print import print
from parser import parse_file, ParsedModule
from bindings import ProjectLvlBindings

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

def inject(plb: ProjectLvlBindings, path: Path, level=0) -> bool:
    if path not in plb.keys():
        print(f"not found in project-level bindings", indent=level, color=Fore.RED)
        return False
    flb = plb[path]
    if flb is None:
        print(f"no file-level bindings", indent=level, color=Fore.RED)
        return False

    result = parse_file(path, level=level)
    if result is None:
        print(f"failed to parse file", indent=level, color=Fore.RED)
        return False

    modified_elements: List[str] = list()
    for element in result.elements():
        if isinstance(element, ParsedModule):
            # Rebuild module with added content

            module_name = element.name
            
            module_parameter_list = element.parameters()
            if module_parameter_list is None:
                module_parameter_list_str = ""
            else:
                module_parameter_list_str = "#(\n" + ",\n".join(module_parameter_list) + "\n)"

            module_port_list = element.ports()
            if module_port_list is None:
                module_port_list_str = ""
            else:
                module_port_list_str = "(\n" + ",\n".join(module_port_list) + "\n)"

            module_body = "".join(element.body)
            
            ms_content_str = ""
            nms_content_str = ""
            if module_name in flb.keys():
                ms_content = flb[module_name]["ms"]
                if ms_content is None:
                    print(f"no module-specific content found for module {module_name} from file-level bindings", indent=level+1, color=Fore.YELLOW)
                    ms_content = ""
                ms_content_str = TEMPLATE_MS.substitute(
                    path_script = PATH_SCRIPT,
                    content = ms_content
                )
                nms_content = flb[module_name]["nms"]
                if nms_content is None:
                    print(f"no non-module-specific content found for module {module_name} from file-level bindings", indent=level+1, color=Fore.YELLOW)
                    nms_content = ""
                nms_content_str = TEMPLATE_NMS.substitute(
                    path_script = PATH_SCRIPT,
                    content = nms_content,
                )
            else:
                print(f"did not found module {module_name} from file-level bindings", indent=level+1, color=Fore.RED)
            
            element_str = TEMPLATE_MODULE.substitute(
                nms_content = nms_content_str,
                module_name = module_name,
                module_parameter_list = module_parameter_list_str,
                module_port_list = module_port_list_str,
                ms_content = ms_content_str,
                module_body = module_body,
            )
        elif isinstance(element, str):
            # No need to modify, add as is
            element_str = element
        else:
            raise Exception(f"element has unknown type: {type(element)}")
        modified_elements.append(element_str)
    elements_str = "".join(modified_elements)
    # Write modified data back
    with path.open("w") as stream:
        stream.write(elements_str)
    return True

def execute_inject(arguments: Dict[str, Any]):
    path_hdl_bindings = arguments["input_hdl"]
    path_hdl_bindings = path_hdl_bindings.resolve()
    with path_hdl_bindings.open("rb") as stream:
        plb = pickle.load(stream)
    print(f"loaded project-level bindings from {path_hdl_bindings}")

    files = arguments["files"]
    files = list(map(lambda p: p.resolve(), files))
    for file in files:
        print(f"{file}", indent=0)
        if not inject(plb, file, level=1):
            print(f"injection failed", indent=1, color=Fore.RED)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-hdl", type=Path, required=True)
    parser.add_argument("files", type=Path, nargs="+")
    arguments = vars(parser.parse_args())

    execute_inject(arguments)
