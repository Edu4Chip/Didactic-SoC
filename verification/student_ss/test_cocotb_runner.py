import os
from pathlib import Path

from cocotb_tools.runner import get_runner

def setup_runner(current_test):
    # defining simulator
    sim = os.getenv("SIM", "icarus")

    # defining paths
    proj_path   = f"{Path(__file__).resolve().parent}/"
    build_path  = proj_path + "sim_build/"
    top_path    = proj_path + "common/tb_top/"
    rtl_path    = f"{Path(__file__).resolve().parent.parent.parent}/src/rtl/"
    # per-test waveform path
    wave_file = build_path + f"{current_test}.fst"

    # SV source files
    sources = [top_path + "top.sv", rtl_path + "student_ss_example.sv"]

    # RTL APB WIDTH Parameters
    APB_AW = 10
    APB_DW = 32

    runner = get_runner(sim)
    runner.build(
        # defining the hdl sources
        sources = sources,
        # defining the top level
        hdl_toplevel = "top",
        # always run the build-step
        always = True,
        # timescale for the simulation (some problems with this)
        timescale = ("1ps", "1ps"),
        # generating waveforms - must be set in both build() and test()
        waves = True,
        # compilation parameters in form of a dictionary
        parameters = {"APB_AW" : APB_AW, "APB_DW" : APB_DW}
    )

    runner.test(
        # defining, again, top-module
        hdl_toplevel = "top",
        # defining test to run
        test_module = "tests." + current_test,
        # defining path for which the test is being run
        # it will also be the level for which python imports are referenced
        test_dir = proj_path,
        # defining the path for sim_build/
        build_dir = build_path,
        # results_xml files:
        results_xml= Path(__file__).resolve().parent / "sim_build" /f"{current_test}.xml",
        # define log_files for each test
        log_file = Path (__file__).resolve().parent / "sim_build" / f"{current_test}.log",
        verbose=True,
        # generating waveforms
        plusargs=[f"+dumpfile_path={wave_file}"],
        waves = True
    )


def test_student_rw():
    # test files to be run
    current_test = "cl_student_rw_testcase"
    setup_runner(current_test)


def test_student_ss_ctrl():
    # test files to be run
    current_test = "cl_student_ss_ctrl_testcase"
    setup_runner(current_test)


def test_student_read_pmod():
    # test files to be run
    current_test = "cl_student_read_pmod_testcase"
    setup_runner(current_test)


def test_student_write_pmod():
    # test files to be run
    current_test = "cl_student_write_pmod_testcase"
    setup_runner(current_test)


def test_student_random():
    # test files to be run
    current_test = "cl_student_random_testcase"
    setup_runner(current_test)

def test_student_irq():
    current_test = "cl_student_irq_testcase"
    setup_runner(current_test)

if __name__ == '__main__':
    test_student_rw()
    test_student_ss_ctrl()
    test_student_read_pmod()
    test_student_write_pmod()
    test_student_random()
    test_student_irq()
