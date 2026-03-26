
from common.register_model.cl_reg_dynamic_seq import cl_reg_dynamic_seq, register_type
from common.cl_student_base_seq import cl_student_tb_base_seq
from common.uvc.apb.apb_common import OpType


class cl_student_rw_vseq (cl_student_tb_base_seq):
    """
    A sequence starting a write sequence to the Read/Write register followed by a read sequence to the Read/Write register.

    The sequence stores the write_data and read_data to enable access in the test.
    """

    def __init__(self, name="cl_student_rw_seq"):
        super().__init__(name)

        self.write_data = None
        self.read_data = None

    async def body(self):
        seq = cl_reg_dynamic_seq.create("write_seq")
        with seq.randomize_with() as s:
            s.reg_type == register_type.RW_REG
            s.item.op == OpType.WR

        await seq.start(self.sequencer)
        self.write_data = seq.write_data

        seq = cl_reg_dynamic_seq.create("read_seq")
        with seq.randomize_with() as s:
            s.reg_type == register_type.RW_REG
            s.item.op == OpType.RD

        await seq.start(self.sequencer)
        self.read_data = seq.read_data
