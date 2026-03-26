import vsc
from pyuvm import *
from common.uvc.apb import OpType

@vsc.randobj
class cl_reg_base_seq(uvm_sequence, object):
    """Base sequence for register sequences"""

    def __init__(self, name = "cl_reg_base_seq"):
        super().__init__(name)
        object.__init__(self)

        self.cfg = None

        # Status of register sequence
        self.status = None

    async def pre_body(self):
        if self.sequencer is not None:
            self.cfg = self.sequencer.cfg

    async def post_body(self):
        # Check the status received
        if self.status == status_t.IS_OK:
            if self.item.op == OpType.RD:
                self.sequencer.logger.info(f"Reg Seq: READ data = {self.read_data} from {self.reg.get_full_name()}")
            elif self.item.op == OpType.WR:
                self.sequencer.logger.info(f"Reg Seq: WRITE data = {self.write_data} to {self.reg.get_full_name()}")
        else:
            self.sequencer.logger.error(f"STATUS is NOT_OK, {self.status}")
