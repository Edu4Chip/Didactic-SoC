
import vsc
from .cl_apb_seq_item import cl_apb_seq_item

def apb_change_width(addr_width = 8, data_width = 8):
    """ Method that retuns a class definition which can be used by the UVM Factory to override the base sequence item class.
    The new class definition assures that the agent is using the correct WIDTH (from the configuration object)."""

    @vsc.randobj
    class cl_apb_seq_item_updated(cl_apb_seq_item):
        """Common base sequence item for the APB agent"""

        def __init__(self, name = "apb_item_updated"):
            super().__init__(name)

        @vsc.constraint
        def c_apb_width_parameter(self):
            """Setting the correct ADDR_WIDTH and DATA_WIDTH parameters"""
            self.addr <= 2 ** addr_width - 1
            self.data <= 2 ** data_width - 1
            self.strb <= 2 ** (data_width//8) - 1

    return cl_apb_seq_item_updated
