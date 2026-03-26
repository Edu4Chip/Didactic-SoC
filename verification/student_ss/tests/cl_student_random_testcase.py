
import pyuvm
from pyuvm import *

from cocotb.triggers import ClockCycles

from common.cl_student_base_testcase import cl_student_base_test
from common.sequences.cl_student_random_vseq import cl_student_random_vseq
from common.sequences.cl_student_irq_vseq import cl_student_irq_vseq
from common.sequences.cl_student_ss_ctrl_vseq import cl_student_ss_ctrl_vseq

@pyuvm.test(timeout_time=10000, timeout_unit='ns')
class cl_student_random_test(cl_student_base_test):
    """
    A randomized test starting three randomized sequences.

    First, driving the GPIO pins to random values.
    Then running three randomized dynamic sequences i.e. a read or write to a random register.
    """

    def __init__(self, name = "cl_random_test", parent = None):
        super().__init__(name, parent)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        self.vseq = cl_student_irq_vseq.create("irq_vseq")
        await self.vseq.start(self.student_tb_env.virtual_sequencer)
        await ClockCycles(self.apb_if.clk, 1)
        assert (self.irq_en_if.bus.value == 1)

        self.vseq = cl_student_ss_ctrl_vseq.create("ss_ctrl_vseq")
        await self.vseq.start(self.student_tb_env.virtual_sequencer)
        await ClockCycles(self.apb_if.clk, 1)

        for _ in range(100):
            self.vseq = cl_student_random_vseq.create("random_vseq")
            await self.vseq.start(self.student_tb_env.virtual_sequencer)
            await ClockCycles(self.apb_if.clk, 1)

        self.drop_objection()
