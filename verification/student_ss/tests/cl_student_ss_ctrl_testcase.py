
import pyuvm
from pyuvm import *

from cocotb.triggers import ClockCycles

from common.cl_student_base_testcase import cl_student_base_test
from common.sequences.cl_student_ss_ctrl_vseq import cl_student_ss_ctrl_vseq


@pyuvm.test(timeout_time=1000, timeout_unit='ns')
class cl_ss_ctrl_test(cl_student_base_test):
    """
    A test setting the value of the ss_ctrl-signal once.
    """

    def __init__(self, name = "cl_ss_ctrl_test", parent = None):
        super().__init__(name, parent)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        self.vseq = cl_student_ss_ctrl_vseq.create("ss_ctrl_vseq")
        await self.vseq.start(self.student_tb_env.virtual_sequencer)
        await ClockCycles(self.apb_if.clk, 1)

        assert self.vseq.write_value == self.vseq.read_value, \
            f"SS-ctrl pins value: {self.vseq.write_value} != SS-CTRL REG value: {self.vseq.read_value}"

        self.drop_objection()
