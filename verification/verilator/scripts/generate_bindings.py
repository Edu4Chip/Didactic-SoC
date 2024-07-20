"""Generate HDL and SW bindings based on HDL module headers

# How to use?

`python3 generate_bindings.py`
"""

import re
from typing import List
from pathlib import Path

clock_signal_names = {
    "Student_SS_0_0.v": "clk",
    "Didactic.v": "clk_in",
    "SysCtrl_peripherals_0.v": "clk",
    "Student_SS_2_0.v": "clk",
    "SysCtrl_SS_wrapper_0.v": "clk",
    "Student_SS_1_0.v": "clk",
    "SysCtrl_SS_0.v": "clk_internal",
    "Student_SS_3_0.v": "clk_in",
    "jtag_dbg_wrapper.sv": "clk_i",
    "BootRom.sv": "clk_i",
    "ibex_axi_bridge.sv": "clk_i",
    "mem_axi_bridge.sv": "clk_i",
    "sp_sram.sv": "clk_i",
    "student_ss_1.sv": "clk_in",
    "SS_Ctrl_reg_array.sv": "clk",
    "Student_SS_3.sv": "clk_in",
    "AX4LITE_APB_converter_wrapper.sv": "clk",
    "Student_SS_2.sv": "clk_in",
    "ICN_SS.sv": "clk",
    # Does not have clock signal...
    "pmod_mux.sv": None,
    "Student_area_0.sv": "clk_in",
    "SysCtrl_xbar.sv": "clk_i",
    "io_cell_frame_sysctrl.sv": "clk_in",
}

if __name__ == "__main__":
    path_script_full = Path(__file__)
    path_cwd = Path.cwd()
    path_script = Path(str(path_script_full).removeprefix(str(path_cwd)))

    output_directory = Path("./verification/verilator/src/generated").resolve()
    output_directory.mkdir(exist_ok=True)

    output_directory_hdl = output_directory / "hdl"
    output_directory_hdl.mkdir(exist_ok=True)

    output_directory_sw = output_directory / "sw"
    output_directory_sw.mkdir(exist_ok=True)

    output_directory_ms = output_directory_hdl / "ms"
    output_directory_nms = output_directory_hdl / "nms"

    output_directory_ms.mkdir(exist_ok=True)
    output_directory_nms.mkdir(exist_ok=True)

    line_comment_matcher = re.compile(r"\/\/[\s\S]*?\n")
    square_bracket_matcher = re.compile(r"\[[\s\S]*?\]")
    module_matcher = re.compile(r"module (?P<name>\w*?)\s*?(?P<parameters>#\([\S\s]*?\))*?\s*?(?P<arguments>\([\S\s]*?\))")
    argument_name_matcher = re.compile(r"^\s+(input|output|inout)\s+[\S\s]*?\s+(?P<name>\w+),?$", re.MULTILINE)

    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda d: Path(d).resolve(), directories_str))
    for directory in directories:
        print(f"{directory}")
        for path in list(directory.iterdir()):
            print(f"  {path}")
            clock_signal_name = clock_signal_names[path.name]

            with path.open("r") as stream:
                data = stream.read()

            # Remove line comments
            # Line comments interfere with `module_matcher`
            data = line_comment_matcher.sub("", data)

            # Remove content between square brackets
            # Content inside square brackets interfere with `module_matcher`
            data = square_bracket_matcher.sub("", data)

            m = module_matcher.search(data)
            if not m:
                raise Exception(f'could not match "module_matcher"')
            module_name = m.group("name")
            # module_parameters = m.group("parameters")
            module_arguments = m.group("arguments")
            signal_names: List[str] = list()
            for m in argument_name_matcher.finditer(module_arguments):
                signal_name = m.group("name")
                signal_names.append(signal_name)

            struct_name_parts = module_name.split("_")
            struct_name_parts = list(map(lambda s: s.capitalize(), struct_name_parts))
            struct_name_parts.append("Status")
            struct_name = "".join(struct_name_parts)

            # Generate non-module-specific content
            output_path = output_directory_nms / path.name
            output_path = output_path.with_suffix(".sv")
            print(f"  -> {output_path}")
            with output_path.open("w") as stream:
                print(f"// generated from {path_script}", file=stream)
                print(f"typedef struct packed {{", file=stream)
                for signal_name in signal_names:
                    print(f"  int unsigned {signal_name};", file=stream)
                print(f"}} {struct_name};", file=stream)
                print(f'import "DPI-C" function void track_{module_name}(input real itime, input string name, input {struct_name} status);', file=stream)

            # Generate module-specific content
            output_path = output_directory_ms / path.name
            output_path = output_path.with_suffix(".sv")
            print(f"  -> {output_path}")
            with output_path.open("w") as stream:
                print(f"// generated from {path_script}", file=stream)
                if clock_signal_name:
                    print(f"always @ (posedge {clock_signal_name}) begin", file=stream)
                    print(f"  string name;", file=stream)
                    print(f"  {struct_name} status;", file=stream)
                    for signal_name in signal_names:
                        print(f"  status.{signal_name} = {signal_name};", file=stream)
                    print(f'  $sformat(name, "%m");', file=stream)
                    print(f"  track_{module_name}($realtime, name, status);", file=stream)
                    print(f"end", file=stream)
                else:
                    print(f"  module {path.name} does not have a clock signal")

            # Generate software bindings
            output_path = output_directory_sw / path.name
            output_path = output_path.with_suffix(".cpp")
            print(f"  -> {output_path}")
            with output_path.open("w") as stream:
                print(f"// generated from {path_script}", file=stream)
                print(f"#include <iostream>", file=stream)
                print(f"#include <iomanip>", file=stream)

                print(f"struct {struct_name} {{", file=stream)
                for signal_name in signal_names:
                    print(f"  uint32_t {signal_name};", file=stream)
                print(f"}};", file=stream)

                print(f"void track_{module_name}(double time, const char* name, const uint32_t* status) {{", file=stream)
                print(f"  // Apparently struct members come in reverse order...", file=stream)
                print(f"  struct {struct_name}* status2 = (struct {struct_name}*)status;", file=stream)
                print(f"  struct {struct_name} status3;", file=stream)
                signal_names_reversed = list(reversed(signal_names))
                for name1, name2 in zip(signal_names, signal_names_reversed):
                    print(f"  status3.{name1} = status2->{name2};", file=stream)
                print(f"#ifdef TRACK_{module_name.upper()}", file=stream)
                print(f'  std::cout << "[" << time << "] " << __func__ << std::endl;', file=stream)
                print(f'  std::cout << std::string(name) << ":" << std::endl;', file=stream)
                for signal_name in signal_names:
                    print(f'  std::cout << "  " << std::right << std::setw(15) << "{signal_name}: " << status3.{signal_name} << std::endl;', file=stream)
                print(f"#endif // TRACK_{module_name.upper()}", file=stream)
                print(f"}}", file=stream)
