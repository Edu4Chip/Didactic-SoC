from pyuvm import *
from .gbus_common import ResetType, SequenceItemOverride

class cl_gbus_cfg(uvm_object):
    def __init__(self, name="cfg"):
        super().__init__(name)

        # Size of bus-signal
        self.BUS_WIDTH = 32

        # Control knob for controlling the agent is ACTIVE or PASSIVE
        self.is_active = uvm_active_passive_enum.UVM_ACTIVE

        # Virtual interface handle
        self.vif = None

        # Sets the reset polarity level by which the agent will be sensitive to
        self.reset_polarity = ResetType.ACTIVE_HIGH

        # Control is coverage is created, build time switch
        self.create_default_coverage = True

        # Control knob for monitor sequence item overriding
        self.seq_item_override = SequenceItemOverride.DEFAULT

    def set_width_parameters(self, BUS_WIDTH = 32):
        self.BUS_WIDTH = BUS_WIDTH
