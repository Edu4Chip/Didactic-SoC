#!/usr/bin/env python3

"""Generate HDL and SW bindings based on HDL module headers

# How to use?

## Generate and write bindings to file

`python3 generate_bindings.py generate`

## Write out software bindings to files

`python3 generate_bindings.py write_sw`

## Print which paths and modules were detected and written to the output file

`python3 generate_bindings.py print`
"""

# TODO: docstring
# TODO: sw level bindings can have name collisions...
# TODO: now insert ms and nms content from verification/verilator/src/hdl/...
# TODO: this should also contain cycle counters

import pickle
import argparse
from string import Template
from typing import List, Dict, Optional, Any
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print
from parser import parse_file
from bindings import PATH_HDL_BINDINGS, FileLvlBindings, ProjectLvlBindings

CLOCK_SIGNAL_NAMES: Dict[str, Dict[str, Optional[str]]] = {
    "src/generated/analog_wrapper_0.v": {
        "analog_wrapper_0": "clk_in",
    },
    "src/generated/Didactic.v": {
        "Didactic": "clk_in",
    },
    "src/generated/DtuSubsystem.sv": {
        "SystemControl": "clock",
        "Rx": "clock",
        "Tx": "clock",
        "PonteEscaper": "clock",
        "PonteDecoder": "clock",
        "Ponte": "clock",
        "AluAccu": "clock",
        # Does not have clock signal
        "Decode": None,
        "Leros": "clock",
        "ChiselSyncMemory": "clock",
        "InstructionMemory": "clock",
        "InstrMem": "clock",
        "RegBlock": "clock",
        "Gpio": "clock",
        "ChiselSyncMemory_1": "clock",
        "DataMemory": "clock",
        "Tx_1": "clock",
        "Buffer": "clock",
        "BufferedTx": "clock",
        "Rx_1": "clock",
        "UARTRx": "clock",
        "Uart": "clock",
        "ApbArbiter": "clock",
        # Does not have clock signal
        "ApbMux": None,
        "DataMemMux": "clock",
        "DtuSubsystem": "clock",
    },
    "src/generated/dtu_wrapper_0.v": {
        "dtu_wrapper_0": "clk",
    },
    "src/generated/imt_wrapper_0.v": {
        "imt_wrapper_0": "clk_in",
    },
    "src/generated/kth_wrapper_0.v": {
        "kth_wrapper_0": "clk_in",
    },
    "src/generated/Student_SS_0_0.v": {
        "Student_SS_0_0": "clk",
    },
    "src/generated/Student_SS_1_0.v": {
        "Student_SS_1_0": "clk_in",
    },
    "src/generated/Student_SS_2_0.v": {
        "Student_SS_2_0": "clk",
    },
    "src/generated/Student_SS_3_0.v": {
        "Student_SS_3_0": "clk_in",
    },
    "src/generated/SysCtrl_peripherals_0.v": {
        "SysCtrl_peripherals_0": "clk",
    },
    "src/generated/SysCtrl_SS_0.v": {
        "SysCtrl_SS_0": "clk_internal",
    },
    "src/generated/SysCtrl_SS_wrapper_0.v": {
        "SysCtrl_SS_wrapper_0": "clock",
    },
    "src/generated/tum_wrapper_0.v": {
        "tum_wrapper_0": "clk_in",
    },

    "src/reuse/ibex_axi_bridge.sv": {
        "ibex_axi_bridge": "clk_i",
    },
    "src/reuse/jtag_dbg_wrapper.sv": {
        "jtag_dbg_wrapper": "clk_i",
    },
    "src/reuse/mem_axi_bridge.sv": {
        "mem_axi_bridge": "clk_i",
    },
    # TODO: maybe the dots in signal names cause havoc?
    #"src/reuse/obi_to_apb_intf.sv": {
    #    "found 0 file-level matches": None,
    #    "obi_to_apb_intf": "clk_i",
    #},
    "src/reuse/sp_sram.sv": {
        "sp_sram": "clk_i",
    },

    "src/rtl/analog_status_array.sv": {
        "analog_status_array": "clk_in",
    },
    "src/rtl/AX4LITE_APB_converter_wrapper.sv": {
        "AX4LITE_APB_converter_wrapper": "clk",
    },
    "src/rtl/dtu_ss.sv": {
        "dtu_ss": "clk_in",
    },
    # TODO: maybe custom type instead of logic cause havoc?
    #"src/rtl/ibex_wrapper.sv": {
    #    "skip": None,
    #    "ibex_wrapper": "clk_i",
    #},
    "src/rtl/ICN_SS.sv": {
        "ICN_SS": "clk",
    },
    "src/rtl/io_cell_frame_sysctrl.sv": {
        "io_cell_frame_sysctrl": "clk_in",
    },
    "src/rtl/jtag_dbg_wrapper_obi.sv": {
        "jtag_dbg_wrapper_obi": "clk_i",
    },
    # TODO
    #"src/rtl/obi_cut_intf.sv": {
    #    "found 0 file-level matches": None,
    #    "obi_cut_intf": "clk_i",
    #},
    "src/rtl/obi_icn_ss.sv": {
        "obi_icn_ss": "clk",
    },
    "src/rtl/peripherals_obi_to_apb.sv": {
        "peripherals_obi_to_apb": "clk",
    },
    "src/rtl/pmod_mux.sv": {
        # Does not have clock signal
        "pmod_mux": None,
    },
    "src/rtl/sp_sram.sv": {
        "sp_sram": "clk_i",
    },
    "src/rtl/SS_Ctrl_reg_array.sv": {
        "SS_Ctrl_reg_array": "clk",
    },
    "src/rtl/Student_area_0.sv": {
        "Student_area_0": "clk_in",
    },
    "src/rtl/student_ss_1.sv": {
        "student_ss_1": "clk_in",
    },
    "src/rtl/Student_SS_2.sv": {
        "student_ss_2": "clk_in",
    },
    "src/rtl/Student_SS_3.sv": {
        "Student_SS_3": "clk_in",
    },
    "src/rtl/student_ss_analog.sv": {
        # Does not have clock signal
        "student_ss_analog": None,
    },
    "src/rtl/sysctrl_obi_xbar.sv": {
        "sysctrl_obi_xbar": "clk",
    },
    "src/rtl/SysCtrl_xbar.sv": {
        "SysCtrl_xbar": "clk_i",
    },
}

TEMPLATE_NMS_SIGNAL = Template("    int unsigned ${signal_name};")
TEMPLATE_NMS = Template("""\
// generated from ${path_script}
typedef struct packed {
${signals}
} ${struct_name};
import "DPI-C" function void track_${module_name}(
    input real itime,
    input string name,
    input ${struct_name} status
);
""")

TEMPLATE_MS_SIGNAL_ASSIGNMENT = Template("    status.${signal_name} = ${signal_name};")
TEMPLATE_MS_WITH_CLOCK_SIGNAL = Template("""\
// generated from ${path_script}
always @ (posedge ${clock_signal_name}) begin
    string name;
    ${struct_name} status;
${signal_assignments}
    $$sformat(name, "%m");
    track_${module_name}($$realtime, name, status);
end
""")
TEMPLATE_MS_WITHOUT_CLOCK_SIGNAL = Template("""\
// generated from ${path_script}
""")

TEMPLATE_SW_STRUCT_SIGNAL = Template(
    "    uint32_t ${signal_name};"
)
TEMPLATE_SW_SIGNAL_ASSIGNMENT = Template(
    "    status3.${name1} = status2->${name2};"
)
TEMPLATE_SW_SIGNAL_PRINT = Template(
    """    std::cout << "  " << std::right << std::setw(15) << "${signal_name}: " << status3.${signal_name} << std::endl;"""
)
TEMPLATE_SW = Template("""\
// generated from ${path_script}
#include <iomanip>
#include <iostream>

struct ${struct_name} {
${struct_signals}
};

void track_${module_name}(double time, const char* name, const uint32_t* status) {
    // Apparently struct members come in reverse order...
    struct ${struct_name}* status2 = (struct ${struct_name}*)status;
    struct ${struct_name} status3;
${signal_assignments}
    #ifdef TRACK_${module_name_upper}
    std::cout << "[" << time << "] " << __func__ << std::endl;
    std::cout << std::string(name) << ":" << std::endl;
${signal_prints}
    #endif // TRACK_${module_name_upper}
}
""")

PATH_SCRIPT = Path(__file__)
PATH_GENERATED = Path("./verification/verilator/src/generated").resolve()
PATH_SW_INCLUDES = PATH_GENERATED / Path("includes.cpp")

def generate_file_level_bindings(path: Path, level=0) -> Optional[FileLvlBindings]:
    print(f"{path}", indent=level)
    result = parse_file(path)
    if result is None:
        print(f"could not generate bindings", indent=level+1, color=Fore.RED)
        return None
    flb: FileLvlBindings = dict()
    for module in result.modules():
        print(f"{path}:{module.name}", indent=level+1)
        flb[module.name] = dict()

        # Try to solve clock signal name
        clock_signal_name = None
        csn_path = str(path.relative_to(Path.cwd()))
        if csn_path in CLOCK_SIGNAL_NAMES.keys():
            if module.name in CLOCK_SIGNAL_NAMES[csn_path].keys():
                clock_signal_name = CLOCK_SIGNAL_NAMES[csn_path][module.name]
            else:
                print(f"module {module.name} not found in clock_signal_names[{csn_path}]", indent=level+1, color=Fore.RED)
        else:
            print(f"path {csn_path} not found in clock_signal_names", indent=level+1, color=Fore.RED)

        struct_name_parts = module.name.split("_")
        struct_name_parts = list(map(lambda s: s.capitalize(), struct_name_parts))
        struct_name_parts.append("Status")
        struct_name = "".join(struct_name_parts)

        port_names = list()
        if module.port_list:
            for port in module.port_list:
                if isinstance(port, pp.ParseResults) and port.get_name() == "port":
                    port_name = port[-1]
                    port_names.append(port_name)

        # TODO: add content from filesystem?

        # Generate non-module-specific content
        signals = list()
        for port_name in port_names:
            signal = TEMPLATE_NMS_SIGNAL.substitute(signal_name=port_name)
            signals.append(signal)
        nms = TEMPLATE_NMS.substitute(
            path_script=PATH_SCRIPT,
            signals="\n".join(signals),
            struct_name=struct_name,
            module_name=module.name,
        )
        flb[module.name]["nms"] = nms
        
        # Generate module-specific content
        if clock_signal_name:
            signal_assignments = list()
            for port_name in port_names:
                assignment = TEMPLATE_MS_SIGNAL_ASSIGNMENT.substitute(
                    signal_name=port_name
                )
                signal_assignments.append(assignment)
            ms = TEMPLATE_MS_WITH_CLOCK_SIGNAL.substitute(
                path_script=PATH_SCRIPT,
                clock_signal_name=clock_signal_name,
                struct_name=struct_name,
                signal_assignments="\n".join(signal_assignments),
                module_name=module.name,
            )
        else:
            print(f"module {module.name} does not have a clock signal", indent=level+1, color=Fore.YELLOW)
            ms = TEMPLATE_MS_WITHOUT_CLOCK_SIGNAL.substitute(
                path_script=PATH_SCRIPT,
            )
        flb[module.name]["ms"] = ms

        # Generate software bindings
        struct_signals = list()
        for port_name in port_names:
            struct_signal = TEMPLATE_SW_STRUCT_SIGNAL.substitute(
                signal_name=port_name
            )
            struct_signals.append(struct_signal)
        signal_assignments = list()
        port_names_reversed = list(reversed(port_names))
        for name1, name2 in zip(port_names, port_names_reversed):
            signal_assignment = TEMPLATE_SW_SIGNAL_ASSIGNMENT.substitute(
                name1=name1,
                name2=name2,
            )
            signal_assignments.append(signal_assignment)
        signal_prints = list()
        for port_name in port_names:
            signal_print = TEMPLATE_SW_SIGNAL_PRINT.substitute(
                signal_name=port_name,
            )
            signal_prints.append(signal_print)
        sw = TEMPLATE_SW.substitute(
            path_script=PATH_SCRIPT,
            struct_name=struct_name,
            struct_signals="\n".join(struct_signals),
            module_name=module.name,
            signal_assignments="\n".join(signal_assignments),
            signal_prints="\n".join(signal_prints),
            module_name_upper=str(module.name).upper()
        )
        flb[module.name]["sw"] = sw
    return flb

def execute_bindings(arguments: Dict[str, Any]):
    files = arguments["files"]
    files = list(map(lambda p: p.resolve(), files))
    plb: ProjectLvlBindings = dict()
    for file in files:
        flb = generate_file_level_bindings(file, level=0)
        plb[file] = flb
    # Write bindings to pickle-file
    with PATH_HDL_BINDINGS.open("wb") as stream:
        pickle.dump(plb, stream)
    print(f"wrote project-level bindings to path {PATH_HDL_BINDINGS}")
    print(f"creating files for software bindings and an include file with correct paths")
    include_paths: List[Path] = list()
    for path in plb.keys():
        flb = plb[path]
        if flb is None:
            print(f"no project-level bindings for {path}", indent=1, color=Fore.RED)
            continue
        path_relative = path.relative_to(Path.cwd())
        path_final = PATH_GENERATED / path_relative
        path_final = path_final.resolve()
        path_final = path_final.with_suffix(".cpp")
        path_final.parent.mkdir(parents=True, exist_ok=True)
        content_list = list()
        for module in flb.keys():
            sw_bindings = flb[module]["sw"]
            if sw_bindings is not None:
                content_list.append(sw_bindings)
        content = "\n".join(content_list)
        with path_final.open("w") as stream:
            stream.write(content)
        include_paths.append(path_final)
    include_content_list = list()
    for path in include_paths:        
        path = path.relative_to(PATH_GENERATED)
        content = f"#include \"{path}\""
        include_content_list.append(content)
    include_content = "\n".join(include_content_list)    
    with PATH_SW_INCLUDES.open("w") as stream:
        stream.write(include_content)
    print(f"wrote software bindings include file to path {PATH_SW_INCLUDES}")

def execute_print(arguments: Dict[str, Any]):
    if not PATH_HDL_BINDINGS.exists():
        print(f"bindings do not exist", color=Fore.RED)
        return
    with PATH_HDL_BINDINGS.open("rb") as stream:
        plb = pickle.load(stream)
    for path in plb.keys():
        print(path)
        for module in plb[path].keys():
            print(module, indent=1)
            # Skip printing ms, nms and sw content

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="action", required=True)
    parser_bindings = subparsers.add_parser(
        "bindings",
        help="generate hdl and sw bindings"
    )
    parser_bindings.add_argument("files", type=Path, nargs="+")
    parser_print = subparsers.add_parser(
        "print",
        help="print generated bindings",
    )
    arguments = vars(parser.parse_args())

    match arguments["action"]:
        case "bindings":
            execute_bindings(arguments)
        case "print":
            execute_print(arguments)
        case other:
            print(f"unknown action: {other}", color=Fore.RED)
