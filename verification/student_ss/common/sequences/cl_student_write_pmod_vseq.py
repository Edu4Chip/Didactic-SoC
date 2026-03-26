import cocotb

from cocotb.triggers import ClockCycles

from common.register_model.cl_reg_dynamic_seq import cl_reg_dynamic_seq, register_type
from common.cl_student_base_seq import cl_student_tb_base_seq
from common.uvc.apb.apb_common import OpType

class cl_student_write_pmod_vseq (cl_student_tb_base_seq):
    """
    A sequence starting a write sequence to the GPIO-Write-Register, followed by sampling the GPO-pins.

    The sequence stores the write_data and read_data to enable access in the test.
    """

    def __init__(self, name="cl_student_write_pmod_seq"):
        super().__init__(name)

        # data written to register
        self.write_data = None

        # sampled values form gpo-pins
        self.read_data_0 = None
        self.read_data_1 = None

    async def body(self):
        seq = cl_reg_dynamic_seq.create("write_seq")
        with seq.randomize_with() as s:
            s.reg_type == register_type.GPIO_W_REG
            s.item.op == OpType.WR

        await seq.start(self.sequencer)
        self.write_data = seq.write_data

        await ClockCycles(cocotb.top.clk_in, 1)

        self.read_data_0, self.read_data_1 = await self.sample_gpo_pins()

