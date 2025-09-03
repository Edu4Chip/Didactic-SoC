"""Parse Verilog file into a Python object

# How to use?

Import `parse_file` from this file and use it to parse given Path-object

# How to test?

`python3 parser.py parse <file>`

`python3 parser.py print --modules --ports <files>`
"""

import argparse
from typing import Optional, List, Dict, Any
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print

EXCEPTIONS_STR: List[str] = [
    # Why this file fails is currently unknown
    "src/rtl/ibex_wrapper.sv",
    # Name collision at sw level
    "src/reuse/sp_sram.sv",
    "src/rtl/sp_sram.sv",
]
EXCEPTIONS = list(map(lambda p: Path(p).resolve(), EXCEPTIONS_STR))

class ParsedModule:
    def __init__(self, module: pp.ParseResults):
        self.module = module
        module_list = self.module.as_list()
        module_kw = module_list[0]
        self.name = module_list[1]
        self.parameter_list = None
        self.port_list = None
        module_separator = self.module[-3]
        self.body = self.module[-2]
        endmodule_kw = self.module[-1]
        match len(module_list):
            case 5:
                # No parameters or ports
                pass
            case 6:
                # Either parameters or ports
                if "module_parameter_list" in self.module.as_dict().keys():
                    self.parameter_list = self.module[2]
                elif "module_port_list" in self.module.as_dict().keys():
                    self.port_list = self.module[2]
                else:
                    raise Exception(f"module with 6 elements do not contain parameters or ports")
            case 7:
                # Both parameters and ports
                self.parameter_list = self.module[2]
                self.port_list = self.module[3]
            case other:
                raise Exception(f"module has unsupported amount of elements: {other}")

    def parameters(self) -> Optional[List[str]]:
        if self.parameter_list is None:
            return None
        parameters_str = list()
        for parameter in self.parameter_list:
            parameter_str = parameter.split()
            parameter_str = " ".join(parameter_str)
            parameters_str.append(parameter_str)
        return parameters_str

    def ports(self) -> Optional[List[str]]:
        if self.port_list is None:
            return None
        ports_str = list()
        for port in self.port_list:
            port_str = " ".join(port)
            ports_str.append(port_str)
        return ports_str

class ParserResult:
    def __init__(self, file_level_match: pp.ParseResults):
        self.file_level_match = file_level_match

    def print(self):
        self.file_level_match.pprint()

    def elements(self) -> List[str | ParsedModule]:
        # Iterate through all elements and classify them properly
        elements: List[str | ParsedModule] = list()
        for element in self.file_level_match:
            assert isinstance(element, pp.ParseResults)
            match element.get_name():
                case "module":
                    module = ParsedModule(element)
                    elements.append(module)
                case "other":
                    # Filter empty strings
                    element_list = element.as_list()
                    element_list = list(filter(None, element_list))
                    element_str = " ".join(element_list)
                    if element_str:
                        elements.append(element_str)
                    else:
                        # No need to propagate empty string
                        pass
                case other:
                    raise Exception(f"element with unknown name: {other}")
        return elements

    def modules(self) -> List[ParsedModule]:
        elements = self.elements()
        modules = list()
        for element in elements:
            if isinstance(element, ParsedModule):
                modules.append(element)
        return modules


def parse_string(data: str, level=0) -> Optional[ParserResult]:
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
        pp.Literal("#(").suppress() +
        pp.SkipTo(")") +
        pp.Literal(")").suppress()
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
        pp.Opt(stx_direction) +
        pp.Opt(stx_net_type) +
        pp.Opt(stx_range) +
        stx_identifier
    )
    stx_port = pp.Group(stx_port) \
        .set_results_name("port")
    stx_module_port_list = pp.Group(
        pp.Literal("(").suppress() +
        pp.DelimitedList(stx_port, ",") +
        pp.Literal(")").suppress()
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

    match_generator = stx_file.scan_string(data)
    match_list = list(match_generator)

    if len(match_list) != 1:
        print(f"found {len(match_list)} file-level matches, expected one", indent=level, color=Fore.RED)
        return None
    file_level_match, _, _ = match_list[0]
    return ParserResult(file_level_match)

def parse_file(path: Path, level=0) -> Optional[ParserResult]:
    path = path.resolve()
    if path in EXCEPTIONS:
        print(f"exceptional file, could not parse", indent=level, color=Fore.RED)
        return None
    with path.open("r") as stream:
        data = stream.read()
    return parse_string(data, level=level)

def execute_parse(arguments: Dict[str, Any]):
    path = arguments["path"]
    result = parse_file(path)
    if result is None:
        print(f"failed to parse {path}", color=Fore.RED)
        return
    result.print()

def execute_print(arguments: Dict[str, Any]):
    paths = arguments["paths"]
    for path in paths:
        print(f"{path}", indent=0)
        result = parse_file(path, level=1)
        if result is None:
            print(f"could not parse", color=Fore.RED, indent=1)
            continue
        for module in result.modules():
            if arguments["modules"]:
                print(f"{module.name}", indent=1)
            if arguments["parameters"]:
                raise NotImplementedError
            if arguments["ports"]:
                ports = module.ports()
                if ports is not None:
                    for port in ports:
                        if arguments["modules"]:
                            print(port, indent=2)
                        else:
                            print(port, indent=1)

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
    # parser_print.add_argument("--parameters", action="store_true")
    parser_print.add_argument("--ports", action="store_true")
    arguments = vars(parser.parse_args())
    
    match arguments["action"]:
        case "parse":
            execute_parse(arguments)
        case "print":
            execute_print(arguments)
        case other:
            raise Exception(f"unknown action: {other}")
