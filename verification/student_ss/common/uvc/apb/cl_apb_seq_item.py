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

        # Transaction members
        self.op         = vsc.rand_enum_t(OpType)
        self.addr       = vsc.rand_uint64_t()
        self.data       = vsc.rand_uint64_t()
        self.strb       = vsc.rand_uint32_t()
        self.slverr     = vsc.rand_bit_t(1)

        # Access protection
        self.norm_acc   = vsc.rand_enum_t(NormalAccess)
        self.sec_acc    = vsc.rand_enum_t(SecureAccess)
        self.data_acc   = vsc.rand_enum_t(DataAccess)

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

        return (f"{self.get_name()} : op = {self.op.name}, addr = {hex(self.addr)}, "
                f"data = {hex(self.data)}, strb = {bin(self.strb)}, slverr = {self.slverr}, "
                f"Accesses = {self.norm_acc.name}, {self.sec_acc.name}, {self.data_acc.name}")