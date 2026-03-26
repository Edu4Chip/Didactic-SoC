
from pyuvm import *

from .cl_gbus_driver import cl_gbus_driver
from .cl_gbus_monitor import cl_gbus_monitor
from .cl_gbus_sequencer import cl_gbus_sequencer
from .cl_gbus_coverage import cl_gbus_coverage
from .cl_gbus_item import cl_gbus_seq_item, gbus_change_width
from .gbus_common import SequenceItemOverride

class cl_gbus_agent(uvm_agent):
    """ UVM agent for Generic Bus """

    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Analysis port connected to monitor
        self.ap         = None

        # Handle to configuration object
        self.cfg        = None

        # Transaction sequencer
        self.sequencer  = None

        # Signal monitor
        self.monitor    = None

        # Signal driver
        self.driver     = None

        # Coverage transactor
        self.coverage   = None

    def build_phase(self):
        super().build_phase()

        # Construct analysis port
        self.ap = uvm_analysis_port("ap", self)

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Create monitor and pass handle to cfg
        ConfigDB().set(self,"monitor","cfg",self.cfg)
        self.monitor = cl_gbus_monitor.create("monitor", self)

        if self.cfg.is_active == uvm_active_passive_enum.UVM_ACTIVE:
            # Create driver and pass handle to cfg if active
            ConfigDB().set(self, "driver", "cfg", self.cfg)
            self.driver = cl_gbus_driver.create("driver", self)

            # Create sequencer and pass handle to cfg if active
            ConfigDB().set(self, "sequencer", "cfg", self.cfg)
            self.sequencer = cl_gbus_sequencer.create("sequencer", self)

        if self.cfg.create_default_coverage:
            # Create coverage and pass handle to cfg if active
            ConfigDB().set(self,"coverage", "cfg", self.cfg)
            self.coverage = cl_gbus_coverage.create("coverage", self)

        # Update the sequence item width
        if self.cfg.seq_item_override == SequenceItemOverride.DEFAULT:
            uvm_factory().set_type_override_by_type(cl_gbus_seq_item, gbus_change_width(self.cfg.BUS_WIDTH))


    def connect_phase(self):
        super().connect_phase()

        # Connect driver and sequencer
        if self.cfg.is_active == uvm_active_passive_enum.UVM_ACTIVE:
            self.driver.seq_item_port.connect(self.sequencer.seq_item_export)

        # Connect monitor analysis port
        self.monitor.ap.connect(self.ap)

        # Connect coverage
        if self.cfg.create_default_coverage:
            self.monitor.ap.connect(self.coverage.analysis_export)
