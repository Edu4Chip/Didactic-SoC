import vsc
from .student_ss_regs_reg_block import *
from .cl_reg_base_seq import cl_reg_base_seq
from common.uvc.apb import cl_apb_seq_item, OpType

@vsc.randobj
class cl_reg_ss_ctrl_seq(cl_reg_base_seq, object):
    """Sequence for reading the ss_ctrl register """

    def __init__(self, name = "cl_reg_ss_crl_seq"):
        cl_reg_base_seq.__init__(self, name)
        object.__init__(self)

        # Randomizable Variables
        self.item = vsc.rand_attr(cl_apb_seq_item.create("apb_reg_item"))

        # Register to access
        self.reg = None

    @vsc.constraint
    def c_op_type(self):
        self.item.op == OpType.RD

    async def body(self):
        await super().body()

        self.reg = self.sequencer.reg_model.ss_ctrl_reg

        if self.item.op == OpType.RD:
            self.status, read_data = await self.reg.read(self.sequencer.reg_model.def_map, path_t.FRONTDOOR, check_t.NO_CHECK)
            self.read_data = read_data
        elif self.item.op == OpType.WR:
            assert False, "Cannot write to read-only register: SS_CTRL_REG"
