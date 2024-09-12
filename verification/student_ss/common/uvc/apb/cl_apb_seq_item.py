"""APB-UVC sequence item. Contrained random verification methodology using PyVSC."""

from pyuvm import uvm_sequence_item
import vsc
from .apb_common import *

@vsc.randobj
class cl_apb_seq_item(uvm_sequence_item, object):
    """Common base sequence item for the APB agent"""

    def __init__(self, name = "apb_seq_item"):
        uvm_sequence_item.__init__(self, name)
        object.__init__(self)

        #  Configuration settings
        self.no_wait_len    = vsc.rand_bit_t(1)
        self.max_wait_len   = 15

        # Transaction members
        self.op         = vsc.rand_enum_t(OpType)
        self.addr       = vsc.rand_uint32_t()
        self.data       = vsc.rand_uint32_t()
        self.strb       = vsc.rand_bit_t(4)
        self.slverr     = vsc.rand_bit_t(1)

        # Access protection
        self.norm_acc   = vsc.rand_enum_t(NormalAccess)
        self.sec_acc    = vsc.rand_enum_t(SecureAccess)
        self.data_acc   = vsc.rand_enum_t(DataAccess)

        # APB protocol delay
        self.wait_len   = vsc.rand_uint8_t()

    @vsc.constraint
    def c_consumer_wait_len(self):
        self.no_wait_len <= 1

        with vsc.if_then(self.no_wait_len == 1):
            self.wait_len == 0
        with vsc.else_if(self.no_wait_len != 1):
            self.wait_len <= self.max_wait_len

    def do_copy(self, rhs):
        """Defines how copy of the APB sequence item is done

        Used when calling clone() of APB sequence item"""

        super().do_copy(rhs)

        # Ranomizable item members
        self.op     = rhs.op
        self.addr   = rhs.addr
        self.data   = rhs.data
        self.strb   = rhs.strb
        self.slverr = rhs.slverr

        # Cycle delays
        self.wait_len = rhs.wait_len

        # Configuration settings
        self.no_wait_len    = rhs.no_wait_len
        self.max_wait_len   = rhs.max_wait_len

    def __eq__(self, other) -> bool:
        # Defines how apb seq items are compared
        if isinstance(other, cl_apb_seq_item):
            return self.op == other.op and self.addr == other.addr \
                and self.data == other.data \
                and self.strb == other.strb \
                and self.slverr == other.slverr
        else:
            return False

    def __str__(self) -> str:
        # Defines output string when printing sequence item
        if self.data is None:
            self.data = 0

        return f"{self.get_name()} : op = {self.op.name}, addr = 0x{self.addr:08x}, data = 0x{self.data:08x}, strb = 0b{self.strb:04b}, slverr = {self.slverr}, Accesses = {self.norm_acc.name}, {self.sec_acc.name}, {self.data_acc.name}"
