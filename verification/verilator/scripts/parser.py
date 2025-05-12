"""Parse Verilog file into a Python object

# How to use?

Import `parse_file` from this file and use it to parse given Path-object

# How to test?

`python3 parser.py <file.v>`

`python3 test_parser.py`
"""

import argparse
from typing import Generator, Tuple, Optional, List, Dict, Any
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print

EXCEPTIONS_STR: List[str] = [
    # Why this file fails is currently unknown
    "src/rtl/ibex_wrapper.sv",
]
EXCEPTIONS = list(map(lambda p: Path(p).resolve(), EXCEPTIONS_STR))

# TODO: rename into file_lvl_results or similar
ParserResult = Generator[Tuple[pp.ParseResults, int, int]]

def print_modules(results: pp.ParseResults, level=0):
    modules = list()
    for element in results:
        assert isinstance(element, pp.ParseResults)
        element_type = element.get_name()
        if element_type is None:
            print(f"found element without name", indent=level, color=Fore.RED)
        else:
            if element_type == "module":
                module_name = element[1]
                modules.append(module_name)
            else:
                pass
    if len(modules) == 0:
        print(f"found 0 modules", indent=level, color=Fore.RED)
    else:
        print(f"found {len(modules)} modules:", indent=level, color=Fore.GREEN)
        for module_name in modules:
            print(f"{module_name}", indent=level+1, color=Fore.GREEN)

def parse_string(data: str) -> ParserResult:
    # Syntax for common elements
    stx_identifier = pp.Word(
        pp.alphas,
        pp.alphanums + "_" + ":"
    )
    stx_comment = pp.cpp_style_comment

    # Comments make parsing a nightmare so we remove them
    data = stx_comment \
        .suppress() \
        .transform_string(data)
    # Also remove empty lines
    data = "\n".join([line for line in data.splitlines() if line.strip()])

    # Syntax for module parameters
    stx_module_parameter_list = pp.Group(
        pp.Literal("#(") +
        pp.SkipTo(")") +
        pp.Literal(")")
    ).set_results_name("module_parameter_list")
    
    # Syntax for module ports
    # Elaborated to support extraction of port names
    stx_range = (
        pp.Literal("[") +
        pp.SkipTo(":") +
        pp.Literal(":") +
        pp.SkipTo("]") +
        pp.Literal("]")
    )
    stx_net_type = (
        pp.Keyword("logic") |
        pp.Keyword("wire") |
        pp.Keyword("reg")
    )
    stx_direction = (
        pp.Keyword("input") |
        pp.Keyword("output") |
        pp.Keyword("inout")
    )
    stx_port = (
        stx_direction +
        pp.Opt(stx_net_type) +
        pp.Opt(stx_range) +
        stx_identifier
    )
    stx_port = pp.Group(stx_port) \
        .set_results_name("port")
    stx_module_port_list = pp.Group(
        pp.Literal("(") +
        pp.DelimitedList(stx_port, ",") +
        pp.Literal(")")
    ).set_results_name("module_port_list")
    
    # Syntax for module
    kw_module = pp.Keyword("module") \
        .set_results_name("kw_module")
    kw_endmodule = pp.Keyword("endmodule") \
        .set_results_name("kw_endmodule")
    # Can be modified to use forwards if some files contain nested modules (hopefully not)
    stx_module = (
        kw_module +
        stx_identifier("module_name") +
        pp.Opt(stx_module_parameter_list) +
        pp.Opt(stx_module_port_list) +
        pp.Literal(";") +
        pp.Group(pp.SkipTo("endmodule")).set_results_name("module_body") +
        kw_endmodule
    )
    stx_module = pp.Group(stx_module) \
        .set_results_name("module")

    # Syntax for file
    stx_other = pp.Group(
        pp.SkipTo(stx_module)
    ).set_results_name("other")
    stx_file = pp.OneOrMore(stx_other + stx_module)

    return stx_file.scan_string(data)

def parse_file(path: Path) -> Optional[ParserResult]:
    path = path.resolve()
    if path in EXCEPTIONS:
        print(f"file is exceptional, could not parse automatically:", color=Fore.RED)
        print(f" - {path}", color=Fore.RED)
        return None
    else:
        with path.open("r") as stream:
            data = stream.read()
        return parse_string(data)

def execute_parse(arguments: Dict[str, Any]):
    path = arguments["path"]
    file_level_matches_generator = parse_file(path)
    if file_level_matches_generator is None:
        print(f"failed to parse {path}", color=Fore.RED)
        exit(-1)
    file_level_matches = list(file_level_matches_generator)
    # Expect 1 file-level match
    if len(file_level_matches) != 1:
        print(f"found {len(file_level_matches)} file-level matches", color=Fore.RED)
    for (file_level_match, _, _) in file_level_matches:
        file_level_match.pprint()

def execute_print(arguments: Dict[str, Any]):
    paths = arguments["paths"]
    for path in paths:
        print(f"{path}", indent=0)
        file_level_matches_generator = parse_file(path)
        if file_level_matches_generator is None:
            print(f"failed to parse {path}", color=Fore.RED)
            continue
        file_level_matches = list(file_level_matches_generator)
        # Expect 1 file-level match
        if len(file_level_matches) != 1:
            print(f"found {len(file_level_matches)} file-level matches", color=Fore.RED)
            continue
        file_level_match, _, _ = file_level_matches[0]
        for element in file_level_match:
            assert isinstance(element, pp.ParseResults)
            match element.get_name():
                case "module":
                    element_list = element.as_list()
                    element_dict = element.as_dict()
                    if arguments["modules"]:
                        module_name = element_dict["module_name"]
                        print(f"{module_name}", indent=1)
                    if arguments["parameters"]:
                        raise NotImplementedError
                    if arguments["ports"]:
                        module_port_list = None
                        match len(element_list):
                            case 5:
                                # No parameters or ports
                                pass
                            case 6:
                                # Either parameters or ports
                                if "module_port_list" in element_dict.keys():
                                    module_port_list = element_list[2]
                            case 7:
                                # Both parameters and ports
                                module_port_list = element_list[3]
                            case other:
                                raise Exception(f"unsupported element list length: {other}")
                        if module_port_list is None:
                            print(f"no ports", indent=2)
                        else:
                            _ = module_port_list.pop(0)
                            _ = module_port_list.pop(-1)
                            for i in range(len(module_port_list)):
                                module_port_list[i] = " ".join(module_port_list[i])
                            for port in module_port_list:
                                print(f"{port}", indent=2)
                case "other":
                    pass
                case other:
                    raise Exception(f"unknown element type: {other}")

if __name__ == "__main__":
    # Parse program arguments
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(
        dest="action",
        required=True,
    )
    parser_parse = subparsers.add_parser(
        "parse",
        help="print full parsing result of given path",
    )
    parser_parse.add_argument("path", type=Path)
    parser_print = subparsers.add_parser(
        "print",
        help="print selected information extracted from given paths",
    )
    parser_print.add_argument("paths", type=Path, nargs="+")
    parser_print.add_argument("--modules", action="store_true")
    parser_print.add_argument("--parameters", action="store_true")
    parser_print.add_argument("--ports", action="store_true")
    arguments = vars(parser.parse_args())
    
    action = arguments["action"]
    match action:
        case "parse":
            execute_parse(arguments)
        case "print":
            execute_print(arguments)
        case other:
            raise Exception(f"unknown action: {other}")
