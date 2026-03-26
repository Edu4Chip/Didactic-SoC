import pyuvm
import vsc

from pyuvm import *
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

import random
import warnings
from pathlib import Path

from .cl_student_tb_config import cl_student_tb_config
from .cl_student_tb_env import cl_student_tb_env
from .cl_student_tb_assertions import cl_student_tb_assertions
from .uvc.apb import cl_apb_interface, apb_common, cl_apb_seq_item, apb_change_width
from .uvc.gbus import cl_gbus_interface, ResetType, cl_gbus_seq_item, gbus_change_width


@pyuvm.test()
class cl_student_base_test(uvm_test):
    """
    Base test for the test bench - all new tests should extend from this.

    The base test does the following:
    * creating and connecting all interfaces
    * setting all configurations
    * creating and starting a clock
    * activating and deactivating reset
    * creating coverage report for test
    """
    def __init__(self, name = "cl_base_test", parent = None):
        super().__init__(name, parent)

        # Access the DUT through the cocotb.top handler
        self.dut = cocotb.top

        # APB interface
        self.apb_if = None

        # PMOD interfaces
        self.pmod_0_gpi_if = None
        self.pmod_0_gpo_if = None
        self.pmod_1_gpi_if = None
        self.pmod_1_gpo_if = None

        # SS_ctrl interface
        self.ss_ctrl_if = None

        # IRQ interfaces
        self.irq_en_if = None
        self.irq_if = None

        # Configuration object handler
        self.cfg = None

        # Assertions
        self.assertion_checker = None

        uvm_report_object.set_default_logging_level("INFO")
        # Quick fix because of warnings og PYVSC
        warnings.simplefilter("ignore")

    def build_phase(self):
        super().build_phase()

        self.cfg = cl_student_tb_config("cfg")

        # APB agent configuration
        self.cfg.apb_cfg.driver                      = apb_common.DriverType.PRODUCER
        self.cfg.apb_cfg.create_default_coverage     = True
        self.cfg.apb_cfg.enable_masked_data          = False

        # Configure the ADDR_WIDTH, DATA_WIDTH and STRB_WIDTH
        self.cfg.apb_cfg.set_width_parameters(int(cocotb.top.APB_AW), int(cocotb.top.APB_DW))

        # GBUS agent cfg
        self.cfg.pmod_0_gpi_cfg.set_width_parameters(4)
        self.cfg.pmod_0_gpi_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.pmod_0_gpo_cfg.set_width_parameters(4)
        self.cfg.pmod_0_gpo_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.pmod_1_gpi_cfg.set_width_parameters(4)
        self.cfg.pmod_1_gpi_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.pmod_1_gpo_cfg.set_width_parameters(4)
        self.cfg.pmod_1_gpo_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.ss_ctrl_cfg.set_width_parameters(8)
        self.cfg.ss_ctrl_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.irq_en_cfg.set_width_parameters(1)
        self.cfg.irq_en_cfg.reset_polarity = ResetType.ACTIVE_LOW

        self.cfg.irq_cfg.set_width_parameters(1)
        self.cfg.irq_cfg.reset_polarity = ResetType.ACTIVE_LOW

        # TB Assertion Checkers
        self.assertion_checker = cl_student_tb_assertions(self.dut.clk_in, self.dut.reset_int)

        # APB and GBus interfaces
        self.apb_if = cl_apb_interface(self.dut.clk_in, self.dut.reset_int)
        self.apb_if._set_width_parameters(self.cfg.apb_cfg.ADDR_WIDTH, self.cfg.apb_cfg.DATA_WIDTH)

        self.pmod_0_gpi_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)
        self.pmod_0_gpo_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)
        self.pmod_1_gpi_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)
        self.pmod_1_gpo_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)

        self.ss_ctrl_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)
        self.irq_en_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)
        self.irq_if = cl_gbus_interface(self.dut.clk_in, self.dut.reset_int)

        # Passing interfaces to corresponding cfg
        self.cfg.apb_cfg.vif = self.apb_if
        self.cfg.pmod_0_gpi_cfg.vif = self.pmod_0_gpi_if
        self.cfg.pmod_0_gpo_cfg.vif = self.pmod_0_gpo_if
        self.cfg.pmod_1_gpi_cfg.vif = self.pmod_1_gpi_if
        self.cfg.pmod_1_gpo_cfg.vif = self.pmod_1_gpo_if
        self.cfg.ss_ctrl_cfg.vif = self.ss_ctrl_if
        self.cfg.irq_en_cfg.vif = self.irq_en_if
        self.cfg.irq_cfg.vif = self.irq_if

        # Instance factory overrides
        uvm_factory().set_type_override_by_type(cl_apb_seq_item, apb_change_width(16, 16))
        uvm_factory().set_inst_override_by_type(cl_gbus_seq_item, gbus_change_width(8), "*ss_ctrl*")
        uvm_factory().set_inst_override_by_type(cl_gbus_seq_item, gbus_change_width(4), "*pmod*")
        uvm_factory().set_inst_override_by_type(cl_gbus_seq_item, gbus_change_width(1), "*irq*")

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
                            strb_signal     = self.dut.PSTRB,
                            rdata_signal    = self.dut.PRDATA,
                            ready_signal    = self.dut.PREADY,
                            slverr_signal   = self.dut.PSLVERR)

        self.pmod_0_gpi_if.connect(bus_signal=self.dut.pmod_0_gpi)
        self.pmod_0_gpo_if.connect(bus_signal=self.dut.pmod_0_gpo)
        self.pmod_1_gpi_if.connect(bus_signal=self.dut.pmod_1_gpi)
        self.pmod_1_gpo_if.connect(bus_signal=self.dut.pmod_1_gpo)
        self.ss_ctrl_if.connect(bus_signal=self.dut.ss_ctrl)
        self.irq_en_if.connect(bus_signal=self.dut.irq_en)
        self.irq_if.connect(bus_signal=self.dut.irq)

        self.assertion_checker.connect(irq_signal       = self.dut.irq,
                                       irq_en_signal    = self.dut.irq_en,
                                       ss_ctrl_signal   = self.dut.ss_ctrl)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        cocotb.start_soon(self.assertion_checker.check_assertions())

        await self.start_clock()
        await self.trigger_reset()

        # setting irq_en to 0
        self.dut.irq_en.value = 0

        await ClockCycles(self.apb_if.clk, 1)

        self.drop_objection()

    def report_phase(self):
        super().report_phase()

        assert self.assertion_checker.passed, "tb assertions failed"

        print(f"==== COVERAGE FOR TEST \"{type(self).__name__}\" ====")
        # vsc.report_coverage(details = True)

        build_path = Path(__file__).resolve().parent.parent
        vsc.write_coverage_db(f"{build_path}/sim_build/{type(self).__name__}_cov.xml")
        vsc.impl.coverage_registry.CoverageRegistry.clear()

    async def start_clock(self):
        """Starting clock of randomized period [1, 5] ns"""

        # Start a clock of randomizd clock period [1, 5] ns
        self.clk_period = random.randint(1, 5)
        cocotb.start_soon(Clock(self.apb_if.clk, self.clk_period, 'ns').start())

    async def trigger_reset(self):
        """Activation and deactivation of reset """

        await ClockCycles(self.apb_if.clk, 1)

        # Activate reset (active-low reset)
        self.logger.info("Waiting for reset")
        self.apb_if.rst.value = 0

        # Wait randomized number of clock cycles before deactivating reset
        await ClockCycles(self.apb_if.clk, random.randint(2, 20))
        self.apb_if.rst.value = 1

        self.logger.info("Reset Done")
