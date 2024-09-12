import pyuvm
import vsc 

from pyuvm import *
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

import random

from .cl_student_tb_config import cl_student_tb_config
from .cl_student_tb_env import cl_student_tb_env
from .uvc.apb import cl_apb_interface, signal_placeholder, apb_common


@pyuvm.test()
class cl_student_base_test(uvm_test):
    def __init__(self, name = "cl_base_test", parent = None):
        super().__init__(name, parent)

        # Access the DUT through the cocotb.top handler
        self.dut = cocotb.top

        # APB interface
        self.apb_if = None

        # Configuration object handler
        self.cfg = None

        uvm_report_object.set_default_logging_level("INFO")

    def build_phase(self):
        super().build_phase()

        self.cfg = cl_student_tb_config("cfg")

        # APB agent configuration
        self.cfg.apb_cfg.driver                      = apb_common.DriverType.PRODUCER
        self.cfg.apb_cfg.create_default_coverage     = True
        self.cfg.apb_cfg.enable_masked_data          = False
        # Configure the ADDR_WIDTH, DATA_WIDTH and STRB_WIDTH
        self.cfg.apb_cfg.set_width_parameters(int(cocotb.top.APB_AW), int(cocotb.top.APB_DW))

        # APB interface
        self.apb_if = cl_apb_interface(self.dut.clk_in, self.dut.reset_int)
        self.apb_if._set_width_parameters(self.cfg.apb_cfg.ADDR_WIDTH, self.cfg.apb_cfg.DATA_WIDTH)

        self.cfg.apb_cfg.vif = self.apb_if

        # Instantiate environment
        ConfigDB().set(self, "student_tb_env", "cfg", self.cfg)
        self.student_tb_env = cl_student_tb_env("student_tb_env", self)

    def connect_phase(self):
        super().connect_phase()

        self.apb_if.connect(wr_signal       = self.dut.PWRITE,
                            sel_signal      = self.dut.PSEL,
                            enable_signal   = self.dut.PENABLE,
                            addr_signal     = self.dut.PADDR,
                            wdata_signal    = self.dut.PWDATA,
                            strb_signal     = signal_placeholder("strb"),
                            rdata_signal    = self.dut.PRDATA,
                            ready_signal    = self.dut.PREADY,
                            slverr_signal   = self.dut.PSLVERR)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        await self.start_clock()
        await self.trigger_reset()

        # setting non-APB signals to 0
        self.dut.irq_en.value       = 0
        self.dut.ss_ctrl.value      = 0
        self.dut.pmod_0_gpi.value   = 0
        self.dut.pmod_1_gpi.value   = 0

        await ClockCycles(self.apb_if.clk, 1)

        self.drop_objection()

    def report_phase(self):
        super().report_phase()

        # Writing coverage report in txt-format
        f = open(f'sim_build/{self.get_type_name()}_cov.txt', "w")
        f.write(f"Coverage report for {self.get_type_name()} \n")
        f.write("------------------------------------------------\n \n")
        vsc.report_coverage(fp=f, details=True)
        f.close()

        # Writing coverage report in xml-format
        vsc.write_coverage_db(
            f'sim_build/{self.get_type_name()}_cov.xml')

    async def start_clock(self):
        """Starting clock of randomized period [1, 5] ns"""

        # Start a clock of randomizd clock period [1, 5] ns
        self.clk_period = random.randint(1, 5)
        cocotb.start_soon(Clock(self.apb_if.clk, self.clk_period, 'ns').start())

    async def trigger_reset(self):
        """Activation and deactivation of reset """

        # Wait randomized number of clock cyles in [0, 5]
        await ClockCycles(self.apb_if.clk, random.randint(0, 5))

        # Activate reset (active-low reset)
        self.logger.info("Waiting for reset")
        self.apb_if.rst.value = 0

        # Wait randomized number of clock cycles before deactivating reset
        await ClockCycles(self.apb_if.clk, random.randint(1, 20))
        self.apb_if.rst.value = 1

        self.logger.info("Reset Done")