from pyuvm import *

from cocotb.triggers import Combine
from common.uvc.gbus.cl_gbus_seq_lib import cl_gbus_sample_seq, cl_gbus_drive_seq

class cl_student_tb_base_seq(uvm_sequence):
    """Base sequence for student subsystem testbench"""

    def __init__(self, name = "cl_student_tb_base_seq"):
        super().__init__(name)

        self.cfg = None

    async def pre_body(self):
        if(self.sequencer is not None):
            self.cfg = self.sequencer.cfg

    async def sample_gpo_pins(self):
        """Sample GPO pins"""

        pmod_0_seq = cl_gbus_sample_seq.create("pmod_0_seq")
        pmod_1_seq = cl_gbus_sample_seq.create("pmod_1_seq")

        pmod_0_seq.randomize()
        pmod_1_seq.randomize()

        self.sequencer.logger.info("Starting pmod processes")
        pmod0_process = cocotb.start_soon(pmod_0_seq.start(self.sequencer.pmod_0_gpo_agent_sequencer))
        pmod1_process = cocotb.start_soon(pmod_1_seq.start(self.sequencer.pmod_1_gpo_agent_sequencer))

        self.sequencer.logger.debug("Waiting for pmod processes to finish")
        await Combine(pmod0_process, pmod1_process)

        return pmod_0_seq.rsp_item.value, pmod_1_seq.rsp_item.value

    async def drive_gpi_pins(self):
        """Set GPI pins to random values"""

        pmod_0_seq = cl_gbus_drive_seq.create("pmod_0_seq")
        pmod_1_seq = cl_gbus_drive_seq.create("pmod_1_seq")

        pmod_0_seq.randomize()
        pmod_1_seq.randomize()

        self.sequencer.logger.info("Starting pmod processes")
        pmod0_process = cocotb.start_soon(pmod_0_seq.start(self.sequencer.pmod_0_gpi_agent_sequencer))
        pmod1_process = cocotb.start_soon(pmod_1_seq.start(self.sequencer.pmod_1_gpi_agent_sequencer))

        self.sequencer.logger.debug("Waiting for pmod processes to finish")
        await Combine(pmod0_process, pmod1_process)

        return pmod_0_seq.rsp_item.value, pmod_1_seq.rsp_item.value
