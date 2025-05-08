"""Generate HDL and SW bindings based on HDL module headers

# How to use?

## Generate and write bindings to file

`python3 generate_bindings.py generate`

## Write out software bindings to files

`python3 generate_bindings.py write_sw`

## Print which paths and modules were detected and written to the output file

`python3 generate_bindings.py print`
"""

import re
import pickle
import argparse
from string import Template
from typing import List, Dict, Optional
from pathlib import Path

import pyparsing as pp
from colorama import Fore

from print import print
from parser import parse_file, print_modules
from bindings import PATH_HDL_BINDINGS, FileLvlBindings, ProjectLvlBindings

from pprint import pprint

# TODO: use full paths : module format
# TODO: add clock signal names
clock_signal_names: Dict[str, Dict[str, Optional[str]]] = {
    "src/generated/DtuSubsystem.sv": {
        "SystemControl": None,
        "Rx": None,
        "Tx": None,
        "PonteEscaper": None,
        "PonteDecoder": None,
        "Ponte": None,
        "AluAccu": None,
        "Decode": None,
        "Leros": None,
        "ChiselSyncMemory": None,
        "InstructionMemory": None,
        "InstrMem": None,
        "RegBlock": None,
        "Gpio": None,
        "ChiselSyncMemory_1": None,
        "DataMemory": None,
        "Tx_1": None,
        "Buffer": None,
        "BufferedTx": None,
        "Rx_1": None,
        "UARTRx": None,
        "Uart": None,
        "ApbArbiter": None,
        "ApbMux": None,
        "DataMemMux": None,
        "DtuSubsystem": None,
    },
    "Student_SS_0_0.v": "clk",
    "Didactic.v": "clk_in",
    "SysCtrl_peripherals_0.v": "clk",
    "Student_SS_2_0.v": "clk",
    "SysCtrl_SS_wrapper_0.v": "clk",
    "Student_SS_1_0.v": "clk_in",
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
    "DtuSubsystem.sv": "clock",
    # Does not have clock signal...
    "pmod_mux.sv": None,
    "Student_area_0.sv": "clk_in",
    "SysCtrl_xbar.sv": "clk_i",
    "io_cell_frame_sysctrl.sv": "clk_in",
    "obi_to_apb_intf.sv": "clk_i",
    "peripherals_obi_to_apb.sv": "clk",
    "ibex_wrapper.sv": "clk_i",
    "obi_cut_intf.sv": "clk_i",
    "obi_icn_ss.sv": "clk",
    "sysctrl_obi_xbar.sv": "clk",
    "dtu_ss.sv": "clk_in",
    # Does not have clock signal...
    "student_ss_analog.sv": None,
    "jtag_dbg_wrapper_obi.sv": "clk_i",
    "tum_wrapper_0.v": "clk_in",
    "dtu_wrapper_0.v": "clk",
    "analog_wrapper_0.v": "clk_in",
    "kth_wrapper_0.v": "clk_in",
    "imt_wrapper_0.v": "clk_in",
    "analog_status_array.sv": "clk_in",
}

TEMPLATE_NMS_SIGNAL = Template("int unsigned ${signal_name};")
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

TEMPLATE_MS_SIGNAL_ASSIGNMENT = Template("status.${signal_name} = ${signal_name};")
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
    "uint32_t ${signal_name};"
)
TEMPLATE_SW_SIGNAL_ASSIGNMENT = Template(
    "status3.${name1} = status2->${name2};"
)
TEMPLATE_SW_SIGNAL_PRINT = Template(
    """std::cout << "  " << std::right << std::setw(15) << "${signal_name}: " << status3.${signal_name} << std::endl;"""
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
    struct {struct_name} status3;
    ${signal_assignments}
    #ifdef TRACK_${module_name_upper}
    std::cout << "[" << time << "] " << __func__ << std::endl;
    std::cout << std::string(name) << ":" << std::endl;
    ${signal_prints}
    #endif // TRACK_${module_name_upper}
}
""")

PATH_SCRIPT = Path(__file__)

def generate_file_level_bindings_from_scan_results(path: Path, results: pp.ParseResults, level=0) -> FileLvlBindings:
    print(f"generating file-level bindings", indent=level)
    result: FileLvlBindings = dict()
    for element in results:
        assert isinstance(element, pp.ParseResults)
        element_type = element.get_name()
        if element_type is None:
            pass
        else:
            if element_type == "module":
                module_kw = element[0]
                module_name = element[1]

                print(f"processing {str(path)}:{module_name} with {len(element)} elements", indent=level+1)

                module_parameter_list = None
                module_port_list = None
                if len(element) == 7:    
                    module_parameter_list = element[2]
                    module_port_list = element[3]
                    module_body_separator = element[4]
                    module_body = element[5]
                    endmodule_kw = element[6]
                elif len(element) == 6:
                    if element[2].get_name() == "module_parameter_list":
                        module_parameter_list = element[2]
                    elif element[2].get_name() == "module_port_list":
                        module_port_list = element[2]
                    else:
                        raise Exception(f"unknown element type: {element[2].get_name()}")
                    module_body_separator = element[3]
                    module_body = element[4]
                    endmodule_kw = element[5]
                elif len(element) == 5:
                    module_body_separator = element[2]
                    module_body = element[3]
                    endmodule_kw = element[4]
                else:
                    raise Exception(f"unsupported element length: {len(element)}")     

                result[module_name] = dict()

                struct_name_parts = module_name.split("_")
                struct_name_parts = list(map(lambda s: s.capitalize(), struct_name_parts))
                struct_name_parts.append("Status")
                struct_name = "".join(struct_name_parts)

                port_names = list()
                if module_port_list:
                    for port in module_port_list:
                        if isinstance(port, pp.ParseResults) and port.get_name() == "port":
                            port_name = port[-1]
                            port_names.append(port_name)

                # Try to solve clock signal name
                clock_signal_name = None
                csn_path = str(path.relative_to(Path.cwd()))
                if csn_path in clock_signal_names.keys():
                    if module_name in clock_signal_names[csn_path].keys():
                        clock_signal_name = clock_signal_names[csn_path][module_name]
                    else:
                        print(f"module {module_name} not found in clock_signal_names[{csn_path}]", indent=level+1, color=Fore.RED)
                else:
                    print(f"path {csn_path} not found in clock_signal_names", indent=level+1, color=Fore.RED)

                # Generate non-module-specific content
                signals = list()
                for port_name in port_names:
                    signal = TEMPLATE_NMS_SIGNAL.substitute(signal_name=port_name)
                    signals.append(signal)
                nms = TEMPLATE_NMS.substitute(
                    path_script=PATH_SCRIPT,
                    signals="\n".join(signals),
                    struct_name=struct_name,
                    module_name=module_name,
                )
                result[module_name]["nms"] = nms
                
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
                        module_name=module_name,
                    )
                else:
                    print(f"module {module_name} does not have a clock signal", indent=level+1, color=Fore.YELLOW)
                    ms = TEMPLATE_MS_WITHOUT_CLOCK_SIGNAL.substitute(
                        path_script=PATH_SCRIPT,
                    )
                result[module_name]["ms"] = ms

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
                    module_name=module_name,
                    signal_assignments="\n".join(signal_assignments),
                    signal_prints="\n".join(signal_prints),
                    module_name_upper=str(module_name).upper()
                )
                result[module_name]["sw"] = sw
            else:
                pass
    return result

def generate_file_level_bindings(path: Path, level=0) -> FileLvlBindings:
    flb = dict()
    print(f"{path}", indent=level)
    maybe_scans = parse_file(path)
    if maybe_scans is None:
        print(f"could not generate bindings", indent=level+1, color=Fore.RED)
    else:
        # Get file-level matches
        scans = list(maybe_scans)
        if len(scans) == 0:
            print(f"found 0 scans", indent=level+1, color=Fore.RED)
        else:
            if len(scans) == 1:
                print(f"found 1 scan", indent=level+1, color=Fore.GREEN)
                results, _, _ = scans[0]
                # Print which modules were detected
                print_modules(results, level=level+2)
                # Generate file-level bindings
                flb = generate_file_level_bindings_from_scan_results(path, results, level+2)
            else:
                print(f"found {len(scans)} scans, skipped", indent=level+1, color=Fore.RED)
    return flb

def generate_project_level_bindings(directories: List[Path], level=0) -> ProjectLvlBindings:
    plb: ProjectLvlBindings = dict()
    for directory in directories:
        print(f"{directory}", indent=level)
        for path in directory.iterdir():
            flb = generate_file_level_bindings(path, level=level+1)
            plb[path] = flb
    return plb

def execute_generate():
    directories_str = [
        "./src/generated",
        "./src/reuse",
        "./src/rtl",
    ]
    directories = list(map(lambda d: Path(d).resolve(), directories_str))
    plb = generate_project_level_bindings(directories, level=0)
    print(f"writing project-level bindings to file:")
    print(f" - {PATH_HDL_BINDINGS}")
    with PATH_HDL_BINDINGS.open("wb") as stream:
        pickle.dump(plb, stream)

def execute_print():
    if PATH_HDL_BINDINGS.exists():
        with PATH_HDL_BINDINGS.open("rb") as stream:
            plb = pickle.load(stream)
        for path in plb.keys():
            print(path)
            for module in plb[path].keys():
                print(module, indent=1)
                # Skip printing ms, nms and sw content
    else:
        print(f"bindings do not exist", color=Fore.RED)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("action", choices=["generate", "write_sw", "print"])
    parser.add_argument("--path", type=Path)
    arguments = vars(parser.parse_args())

    action = arguments["action"]
    if action == "generate":
        path = arguments.get("path", None)
        if path is None:
            execute_generate()
        else:
            flb = generate_file_level_bindings(path, level=0)
            pprint(flb)
    elif action == "write_sw":
        # TODO
        raise NotImplementedError
    elif action == "print":
        execute_print()        
    else:
        # This branch should never execute
        raise Exception(f"unknown action: {action}")
