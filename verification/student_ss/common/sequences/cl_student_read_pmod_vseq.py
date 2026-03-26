import cocotb
from cocotb.triggers import ClockCycles

from common.register_model.cl_reg_dynamic_seq import cl_reg_dynamic_seq, register_type
from common.cl_student_base_seq import cl_student_tb_base_seq
from common.uvc.apb.apb_common import OpType


class cl_student_read_pmod_vseq (cl_student_tb_base_seq):
    """
    A sequence driving the GPI-pins with random values and starting a read sequence to the GPIO-Read-Register.

    The sequence stores the write_data and read_data to enable access in the test. 
    """

    def __init__(self, name="cl_student_read_pmod_seq"):
        super().__init__(name)

        # data driven to pmod gpi pins
        self.write_data_0 = None
        self.write_data_1 = None

        # data read from register
        self.read_data = None

    async def body(self):
        # write data to GPI pins
        self.write_data_0, self.write_data_1 = await self.drive_gpi_pins()

        await ClockCycles(cocotb.top.clk_in, 1)

        # read GPO pins
        seq = cl_reg_dynamic_seq.create("read_seq")
        with seq.randomize_with() as s:
            s.reg_type == register_type.GPIO_R_REG
            s.item.op == OpType.RD

        await seq.start(self.sequencer)
        self.read_data = seq.read_data
