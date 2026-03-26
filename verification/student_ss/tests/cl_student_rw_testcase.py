
import pyuvm
from pyuvm import *

from cocotb.triggers import ClockCycles

from common.cl_student_base_testcase import cl_student_base_test
from common.sequences.cl_student_rw_vseq import cl_student_rw_vseq


@pyuvm.test(timeout_time=1000, timeout_unit='ns')
class cl_student_rw_test(cl_student_base_test):
    """
    A test completing a write to the Read/Write register followed by a read to the Read/Write register.

    Afterwards, checking that the write and read data aligns.
    """

    def __init__(self, name = "cl_rw_test", parent = None):
        super().__init__(name, parent)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        self.vseq = cl_student_rw_vseq.create("rw_vseq")
        await self.vseq.start(self.student_tb_env.virtual_sequencer)

        assert self.vseq.write_data == self.vseq.read_data, \
            f"Data is not identical, {self.vseq.write_data}!={self.vseq.read_data}"

        await ClockCycles(self.apb_if.clk, 1)

        self.drop_objection()
