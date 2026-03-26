import vsc
from enum import Enum
from .student_ss_regs_reg_block import *
from .cl_reg_base_seq import cl_reg_base_seq
from common.uvc.apb import cl_apb_seq_item, OpType

class register_type(Enum):
    RW_REG      = 0
    GPIO_R_REG  = 1
    GPIO_W_REG  = 2

@vsc.randobj
class cl_reg_dynamic_seq(cl_reg_base_seq, object):
    """Dynamic sequence for registers, randomizing:
    * an APB register item
    * the register to access
    * masking of write data
    """

    def __init__(self, name = "cl_reg_dynamic_seq"):
        cl_reg_base_seq.__init__(self, name)
        object.__init__(self)

        # Randomizable Variables
        self.item       = vsc.rand_attr(cl_apb_seq_item.create("apb_reg_item"))
        self.reg_type   = vsc.rand_enum_t(register_type)
        self.mask       = vsc.rand_bit_t(32)

        # Register to access
        self.reg = None

        # Data
        self.read_data = None
        self.write_data = None

    @vsc.constraint
    def masking_c(self):
        self.mask in vsc.rangelist(0x0f, 0xf0, 0xff)

    async def body(self):
        await super().body()

        if self.reg_type == register_type.RW_REG:
            self.reg = self.sequencer.reg_model.rw_reg
        elif self.reg_type == register_type.GPIO_R_REG:
            self.reg = self.sequencer.reg_model.gpio_r_reg
        elif self.reg_type == register_type.GPIO_W_REG:
            self.reg = self.sequencer.reg_model.gpio_w_reg

        self.sequencer.logger.debug(f"data: {self.item.data}, mask: {self.mask}",
                                    f"reg: {self.reg.get_full_name()}, type: {self.item.op}")

        if self.item.op == OpType.RD:
            self.status, read_data = await self.sequencer.reg_read(self.reg)
            self.read_data = read_data
        elif self.item.op == OpType.WR:
            self.write_data = self.item.data & self.mask
            self.status = await self.sequencer.reg_write(self.reg, self.write_data)
