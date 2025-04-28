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
from colorama import Fore, Style

exceptions_str: List[str] = []
exceptions = list(map(lambda p: Path(p).resolve(), exceptions_str))

ParserResult = Generator[Tuple[pp.ParseResults, int, int]]

def parse_string(data: str) -> ParserResult:
    # Syntax for common elements
    stx_identifier = pp.Word(
        pp.alphas,
        pp.alphanums + "_"
    )
    stx_comment = pp.cpp_style_comment

    # Comments make parsing a nightmare so we remove them
    data = stx_comment \
        .suppress() \
        .transform_string(data)

    # Syntax for module parameters
    stx_module_parameter_list = (
        pp.Literal("#(") +
        pp.SkipTo(")") +
        pp.Literal(")")
    )
    
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
    stx_module_port_list = (
        pp.Literal("(") +
        pp.DelimitedList(stx_port, ",", combine=True) +
        pp.Literal(")")
    )
    
    # Syntax for module
    kw_module = pp.Keyword("module")
    kw_endmodule = pp.Keyword("endmodule")
    # Use forwards if some files contain nested modules (hopefully not)
    stx_module = (
        kw_module +
        stx_identifier +
        pp.Opt(stx_module_parameter_list) +
        pp.Opt(stx_module_port_list) +
        pp.SkipTo("endmodule") +
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
        print(Fore.RED + f"file is exceptional, could not parse automatically:" + Style.RESET_ALL)
        print(Fore.RED + f" - {path}" + Style.RESET_ALL)
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
        print(Fore.RED + f"failed to parse file:" + Style.RESET_ALL)
        print(Fore.RED + f" - {path}" + Style.RESET_ALL)
    else:
        for scan in maybe_scans:
            results, _, _ = scan
            results.pprint()
