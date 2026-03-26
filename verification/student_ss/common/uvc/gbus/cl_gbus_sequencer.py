from pyuvm import *

class cl_gbus_sequencer(uvm_sequencer):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Configuration handle
        self.cfg = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")
