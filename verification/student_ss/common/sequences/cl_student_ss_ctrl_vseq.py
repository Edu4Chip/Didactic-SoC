
from common.uvc.gbus import cl_gbus_drive_seq
from common.uvc.apb import OpType
from common.cl_student_base_seq import cl_student_tb_base_seq
from common.register_model.cl_reg_ss_ctrl_seq import cl_reg_ss_ctrl_seq

class cl_student_ss_ctrl_vseq (cl_student_tb_base_seq):
    """
    Starting a single sequence driving the value of the ss_ctrl-signal.
    """

    def __init__(self, name="cl_student_ss_ctrl_seq"):
        super().__init__(name)

        self.write_value = None
        self.read_value = None

    async def body(self):
        # starting one random ss_ctrl_seq
        seq = cl_gbus_drive_seq.create("ss_ctrl_seq")
        seq.randomize()
        await seq.start(self.sequencer.ss_ctrl_agent_sequencer)
        self.write_value = seq.s_item.value

        # read SS_CTRL_REG
        seq = cl_reg_ss_ctrl_seq.create("ss_ctrl_seq")
        seq.randomize()
        await seq.start(self.sequencer)
        self.read_value = seq.read_data
