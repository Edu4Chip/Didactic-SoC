"""APB-UVC Configuration object"""

from pyuvm import uvm_object, uvm_active_passive_enum
from .apb_common import SequenceItemOverride

class cl_apb_config(uvm_object):
    """Configuration object for the APB agent (and its sub-components)"""

    def __init__(self, name = 'apb_config'):
        super().__init__(name)

        #############################
        # General configuration
        #############################

        # Configuration knob for controlling the signal widths, default: 8
        self.ADDR_WIDTH = 8
        self.DATA_WIDTH = 8
        self.STRB_WIDTH = self.DATA_WIDTH // 8

        # Setting agent as ACTIVE or PASSIVE
        self.is_active = uvm_active_passive_enum.UVM_ACTIVE

        # Defining reset type, default active low
        self.active_low_reset = True

        # Virtual interface handle
        self.vif = None

        # Driver type
        self.driver = None

        #############################
        # Coverage specific settings
        #############################

        # Control is coverage is created, build time switch
        self.create_default_coverage = True

        # Control if transaction coverage is sampled, run time switch
        self.enable_transaction_coverage = True

        # Control knob for monitor sequence item overriding
        self.seq_item_override = SequenceItemOverride.DEFAULT

        #######################################
        # Protocol specific configurations
        #######################################

        self.enable_masked_data = True

    def set_width_parameters(self, addr_width, data_width):
        self.ADDR_WIDTH = addr_width
        self.DATA_WIDTH = data_width
        self.STRB_WIDTH = data_width // 8