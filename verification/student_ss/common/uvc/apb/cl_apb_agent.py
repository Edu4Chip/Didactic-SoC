""" APB Agent.
- Provides protocol specific tasks to generate transactions, check the results and perform coverage.
- UVM agent encapsulates the Sequencer, Driver and Monitor into a single entity.
- The components here are instatiated and connected via TLM interfaces.
- Can also have configuration options like:
    - the type of UVM agent (active/passive),
    - knobs to turn on features such as functional coverage, and other similar parameters."""

from pyuvm import *
from .cl_apb_base_driver import cl_apb_base_driver
from .cl_apb_producer_driver import cl_apb_producer_driver
from .cl_apb_cosumer_driver import cl_apb_consumer_driver
from .cl_apb_sequencer import cl_apb_sequencer
from .cl_apb_monitor import cl_apb_monitor
from .cl_apb_coverage import cl_apb_coverage
from .apb_common import *
from .apb_parameterization import *
from .cl_apb_seq_item import cl_apb_seq_item


class cl_apb_agent(uvm_agent):
    """ UVM agent for APB """

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
        self.monitor = cl_apb_monitor.create("monitor", self)

        if self.cfg.is_active == uvm_active_passive_enum.UVM_ACTIVE:
            # Create driver and pass handle to cfg if active
            ConfigDB().set(self, "driver", "cfg", self.cfg)
            if self.cfg.driver == DriverType.PRODUCER:
                self.driver = cl_apb_producer_driver.create("driver", self)
            elif self.cfg.driver == DriverType.CONSUMER:
                self.driver = cl_apb_consumer_driver.create("driver", self)
            else:
                self.logger.critical(f"Driver type not set in cfg {self.cfg.get_full_name()}")
                self.driver = cl_apb_base_driver.create("driver", self)

            # Create sequencer and pass handle to cfg if active
            ConfigDB().set(self, "sequencer", "cfg", self.cfg)
            self.sequencer = cl_apb_sequencer.create("sequencer", self)

        if self.cfg.create_default_coverage:
            # Create coverage and pass handle to cfg if active
            ConfigDB().set(self,"coverage", "cfg", self.cfg)
            self.coverage = cl_apb_coverage.create("coverage", self)

        # Update the sequence item width
        if self.cfg.seq_item_override == SequenceItemOverride.DEFAULT:
            uvm_factory().set_type_override_by_type(cl_apb_seq_item, apb_change_width(self.cfg.ADDR_WIDTH, self.cfg.DATA_WIDTH))


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

