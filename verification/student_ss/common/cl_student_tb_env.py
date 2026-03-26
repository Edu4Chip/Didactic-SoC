from pyuvm import *

from .cl_student_tb_vsequencer import cl_student_tb_vsequencer
from .uvc.apb import cl_apb_agent
from .uvc.gbus import cl_gbus_agent
from .register_model.student_ss_regs_reg_block import student_ss_regs_block
from .uvc.apb.cl_apb_reg_adapter import cl_apb_reg_adapter

class cl_student_tb_env(uvm_env):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Configuration object handle
        self.cfg = None

        # APB UVC
        self.apb_agent = None

        # GBus UVCs
        self.pmod_0_gpi_agent = None
        self.pmod_0_gpo_agent = None
        self.pmod_1_gpi_agent = None
        self.pmod_1_gpo_agent = None
        self.ss_ctrl_agent = None

        # Register Model
        self.reg_model = None
        self.adapter = None

        # Virtual Sequencer
        self.vseqr = None

        # Assertion Checkers
        self.assertion_checker = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Create virtual_sequencer and pass handler to cfg
        ConfigDB().set(self, "virtual_sequencer", "cfg", self.cfg)
        self.virtual_sequencer = cl_student_tb_vsequencer.create("virtual_sequencer", self)

        # Instantiate the UVCs and pass handle to cfg
        ConfigDB().set(self, "apb_agent", "cfg", self.cfg.apb_cfg)
        self.apb_agent = cl_apb_agent("apb_agent", self)

        ConfigDB().set(self, "pmod_0_gpi_agent", "cfg", self.cfg.pmod_0_gpi_cfg)
        self.pmod_0_gpi_agent = cl_gbus_agent("pmod_0_gpi_agent", self)

        ConfigDB().set(self, "pmod_0_gpo_agent", "cfg", self.cfg.pmod_0_gpo_cfg)
        self.pmod_0_gpo_agent = cl_gbus_agent("pmod_0_gpo_agent", self)

        ConfigDB().set(self, "pmod_1_gpi_agent", "cfg", self.cfg.pmod_1_gpi_cfg)
        self.pmod_1_gpi_agent = cl_gbus_agent("pmod_1_gpi_agent", self)

        ConfigDB().set(self, "pmod_1_gpo_agent", "cfg", self.cfg.pmod_1_gpo_cfg)
        self.pmod_1_gpo_agent = cl_gbus_agent("pmod_1_gpo_agent", self)

        ConfigDB().set(self, "ss_ctrl_agent", "cfg", self.cfg.ss_ctrl_cfg)
        self.ss_ctrl_agent = cl_gbus_agent("ss_ctrl_agent", self)

        ConfigDB().set(self, "irq_en_agent", "cfg", self.cfg.irq_en_cfg)
        self.irq_en_agent = cl_gbus_agent("irq_en_agent", self)

        ConfigDB().set(self, "irq_agent", "cfg", self.cfg.irq_cfg)
        self.irq_agent = cl_gbus_agent("irq_agent", self)

        # Instantiate register model and adapter
        self.reg_model = student_ss_regs_block()
        self.adapter   = cl_apb_reg_adapter.create("cl_reg_adapter")

        # Build register model
        self.reg_model.build()

    def connect_phase(self):
        super().connect_phase()

        # Set register model and agents in virtual sequencer
        self.virtual_sequencer.reg_model                = self.reg_model
        self.virtual_sequencer.apb_agent_sequencer      = self.apb_agent.sequencer
        self.virtual_sequencer.pmod_0_gpi_agent_sequencer   = self.pmod_0_gpi_agent.sequencer
        self.virtual_sequencer.pmod_0_gpo_agent_sequencer   = self.pmod_0_gpo_agent.sequencer
        self.virtual_sequencer.pmod_1_gpi_agent_sequencer   = self.pmod_1_gpi_agent.sequencer
        self.virtual_sequencer.pmod_1_gpo_agent_sequencer   = self.pmod_1_gpo_agent.sequencer
        self.virtual_sequencer.ss_ctrl_agent_sequencer      = self.ss_ctrl_agent.sequencer
        self.virtual_sequencer.irq_en_agent_sequencer       = self.irq_en_agent.sequencer
        self.virtual_sequencer.irq_agent_sequencer          = self.irq_agent.sequencer

        self.reg_model.def_map.set_sequencer(self.apb_agent.sequencer)
        self.reg_model.def_map.set_adapter(self.adapter)
