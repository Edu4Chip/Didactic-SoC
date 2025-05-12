"""Parse Verilog file into a Python object

# How to use?

Import `parse_file` from this file and use it to parse given Path-object

# How to test?

`python3 parser.py <file.v>`

`python3 test_parser.py`
"""

import argparse
from typing import Generator, Tuple, Optional, List
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print

exceptions_str: List[str] = [
    # Why this file fails is currently unknown
    "src/rtl/ibex_wrapper.sv",
]
exceptions = list(map(lambda p: Path(p).resolve(), exceptions_str))

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
    if path in exceptions:
        print(f"file is exceptional, could not parse automatically:", color=Fore.RED)
        print(f" - {path}", color=Fore.RED)
        return None
    else:
        with path.open("r") as stream:
            data = stream.read()
        return parse_string(data)

if __name__ == "__main__":
    argument_parser = argparse.ArgumentParser()
    argument_parser.add_argument("path")
    arguments = vars(argument_parser.parse_args())
    
    path = Path(arguments["path"])
    maybe_scans = parse_file(path)
    if maybe_scans is None:
        print(f"failed to parse file:", color=Fore.RED)
        print(f" - {path}", color=Fore.RED)
    else:
        for scan in maybe_scans:
            results, _, _ = scan
            results.pprint()
