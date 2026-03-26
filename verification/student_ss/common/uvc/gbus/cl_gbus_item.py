
from pyuvm import uvm_sequence_item
import vsc
from .gbus_common import *

@vsc.randobj
class cl_gbus_seq_item(uvm_sequence_item, object):
    """Common base sequence item for the Generic Bus agent"""

    def __init__(self, name = "gbus_seq_item"):
        uvm_sequence_item.__init__(self, name)
        object.__init__(self)

        # Command to perform
        self.cmd    = vsc.rand_enum_t(CmdType)

        # Transaction members
        self.value  = vsc.rand_uint32_t()

        # Default bus-width
        self.bus_width = 32

    def do_copy(self, rhs):
        """Defines how copy of the GBus sequence item is done.
        Used when calling clone() of GBus sequence item"""

        super().do_copy(rhs)

        # Ranomizable item members
        self.cmd     = rhs.cmd
        self.value   = rhs.value

    def __eq__(self, other) -> bool:
        # Defines how apb seq items are compared
        if isinstance(other, cl_gbus_seq_item):
            return self.cmd == other.cmd and self.value == other.value
        else:
            return False

    def __str__(self) -> str:
        # Defines output string when printing sequence item
        if self.value is None:
            self.value = 0

        return f"{self.get_name()} : cmd = {self.cmd.name}, value = 0x{self.value:{0}{self.bus_width//4+1}x}"

class cl_gbus_monitor_item(cl_gbus_seq_item):
    def __init__(self, name = "gbus_monitor_item"):
        super().__init__(name)

    def __str__(self) -> str:
        # Defines output string when printing sequence item
        if self.value is None:
            self.value = 0

        return f"{self.get_name()} : cmd = MONITOR, value = 0x{self.value:{0}{self.bus_width//4+1}x}"

def gbus_change_width(bus_width = 32):
    """ Method that retuns a class definition which can be used by the UVM Factory to override the base sequence item class.
    The new class definition assures that the agent is using the correct WIDTH (from the configuration object)."""

    @vsc.randobj
    class cl_gbus_seq_item_updated(cl_gbus_seq_item):

        def __init__(self, name = "gbus_item_updated"):
            super().__init__(name)
            self.bus_width = bus_width

        @vsc.constraint
        def c_bus_width_parameter(self):
            """Setting the correct BUS_WIDTH parameters"""
            self.value <= 2 ** bus_width - 1

    return cl_gbus_seq_item_updated
