
import pyuvm
from pyuvm import *

from cocotb.triggers import ClockCycles

from common.cl_student_base_testcase import cl_student_base_test
from common.sequences.cl_student_read_pmod_vseq import cl_student_read_pmod_vseq


@pyuvm.test(timeout_time=1000, timeout_unit='ns')
class cl_student_read_pmod_test(cl_student_base_test):
    """
    A test setting the GPI-pins with random values and doing a read of the GPIO-Read-Register.

    Afterwards, checking that the data is identical.
    """

    def __init__(self, name = "cl_read_pmod_test", parent = None):
        super().__init__(name, parent)

    async def run_phase(self):
        self.raise_objection()
        await super().run_phase()

        self.vseq = cl_student_read_pmod_vseq.create("read_pmod_vseq")
        await self.vseq.start(self.student_tb_env.virtual_sequencer)

        assert self.vseq.write_data_0 == self.vseq.read_data % 2**4, \
            f"Data is not identical, {self.vseq.write_data_0}!={self.vseq.read_data % 2**4}"

        assert self.vseq.write_data_1 == self.vseq.read_data % 2**8 >> 4, \
            f"Data is not identical, {self.vseq.write_data_1}!={self.vseq.read_data % 2**8 >> 4}"

        await ClockCycles(self.apb_if.clk, 1)

        self.drop_objection()
