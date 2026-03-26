from common.uvc.gbus import cl_gbus_drive_seq
from common.cl_student_base_seq import cl_student_tb_base_seq


class cl_student_irq_vseq (cl_student_tb_base_seq):
    """
    A sequence starting a write sequence to the Read/Write register followed by a read sequence to the Read/Write register.

    The sequence stores the write_data and read_data to enable access in the test.
    """

    def __init__(self, name="cl_student_irq_seq"):
        super().__init__(name)

    async def body(self):
        # starting one ss_ctrl_seq setting irq_en = 1
        seq = cl_gbus_drive_seq.create("irq_en_seq")
        with seq.randomize_with() as sq:
            sq.s_item.value == 1
        await seq.start(self.sequencer.irq_en_agent_sequencer)
