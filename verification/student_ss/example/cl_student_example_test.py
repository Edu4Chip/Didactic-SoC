
import pyuvm
from pyuvm import *

from cocotb.triggers import ClockCycles
from random import randint

from common.cl_student_base_test import cl_student_base_test
from common.uvc.apb import cl_apb_single_seq, OpType

@pyuvm.test()
class cl_example_test(cl_student_base_test):
    def __init__(self, name = "cl_simple_test", parent = None):
        super().__init__(name, parent)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        # Randomize values of size 4-bits
        pmod0_gpi = randint(0, 2**4-1)
        pmod1_gpi = randint(0, 2**4-1)
        await self.set_gpi_pins(pmod0_gpi, pmod1_gpi)

        # Create sequence and randomize
        seq = cl_apb_single_seq.create("seq")
        seq.randomize()

        # Write operation, ADDR=0
        with seq.s_item.randomize_with() as it:
            it.op == OpType.WR
            it.addr == 0
        
        await seq.start(self.student_tb_env.apb_agent.sequencer)
        wdata_addr0 = self.cfg.apb_cfg.vif.wdata.value.integer
        
        # Read operation, ADDR=0
        with seq.s_item.randomize_with() as it:
            it.op == OpType.RD
            it.addr == 0
        
        await seq.start(self.student_tb_env.apb_agent.sequencer)

        # Checking that wdata and rdata at ADDR=0 is identical
        rdata_addr0 = self.cfg.apb_cfg.vif.rdata.value.integer
        assert wdata_addr0 == rdata_addr0, \
            f"wdata/rdata at ADDR=0, NOT identical. wdata = 0x{wdata_addr0:0x}, rdata = 0x{rdata_addr0:0x}"

        # Read operation, ADDR=4
        with seq.s_item.randomize_with() as it:
            it.op == OpType.RD
            it.addr == 4
        
        await seq.start(self.student_tb_env.apb_agent.sequencer)

        # Checking that pmod_1_gpi value is rdata[7:4] at ADDR=4
        rdata_addr4 = self.cfg.apb_cfg.vif.rdata.value.integer
        assert (rdata_addr4 >> 4 ) == pmod1_gpi, \
            f"pmod_1_gpi value is NOT rdata[7:4] at ADDR=4. rdata[7:4] = 0x{(rdata_addr4 >> 4):0x}, pmod_1_gpi = 0x{pmod1_gpi}"

        await ClockCycles(self.apb_if.clk, 5)
        self.drop_objection()

    async def set_gpi_pins(self, pmod0_gpi, pmod1_gpi):
        """Set GPI pins to random values"""
    
        # Driving the signals
        self.dut.pmod_0_gpi.value = pmod0_gpi
        self.dut.pmod_1_gpi.value = pmod1_gpi

        self.logger.info(f"Driving pins: pmod_0_gpi = 0x{pmod0_gpi:0x}, pmod_1_gpi = 0x{pmod1_gpi:0x}")


