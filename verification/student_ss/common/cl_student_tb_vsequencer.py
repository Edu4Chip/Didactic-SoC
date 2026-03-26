
from pyuvm import *

class cl_student_tb_vsequencer(uvm_sequencer):

    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Configuration object handler
        self.cfg = None

        # Register model handler
        self.reg_model = None

        # UVC agent sequencer
        self.apb_agent_sequencer = None

        # GBUS agent sequencers
        self.pmod_0_gpi_agent_sequencer = None
        self.pmod_0_gpo_agent_sequencer = None
        self.pmod_1_gpi_agent_sequencer = None
        self.pmod_1_gpo_agent_sequencer = None
        self.ss_ctrl_agent_sequencer = None
        self.irq_en_agent_sequencer = None
        self.irq_agent_sequencer = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

    async def reg_write(self, reg, write_data):
        return await reg.write(write_data, self.reg_model.def_map,
                                path_t.FRONTDOOR, check_t.NO_CHECK)

    async def reg_read(self, reg):
        return await reg.read(self.reg_model.def_map, path_t.FRONTDOOR, check_t.NO_CHECK)
