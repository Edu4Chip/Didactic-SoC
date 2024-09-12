from pyuvm import *

class cl_apb_sequencer(uvm_sequencer):
    """ APB sequencer: passes sequence items for APB UVCs """

    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Handle to the configuration object
        self.cfg = None

    def build_phase(self):
        super().build_phase()

        self.cfg = ConfigDB().get(self, "", "cfg")

