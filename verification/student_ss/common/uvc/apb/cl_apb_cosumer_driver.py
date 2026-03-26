"""APB Consumer Driver
- The UVM Driver is an active entity that converts abstract transaction to design pin toggles.
- Transaction level objects are obtained from the Sequencer and the UVM Driver drives them to the design via an interface handler."""

from cocotb.triggers import RisingEdge, ReadOnly
from cocotb.types import LogicArray
from pyuvm import *
from .apb_common import *
from .cl_apb_base_driver import cl_apb_base_driver

class cl_apb_consumer_driver(cl_apb_base_driver):
    """ Signal interface cosumer driver for APB
    - translates transactions to pin level activity
    - transactions pulled from sequencer by the seq_item_port"""

    def __init__(self, name, parent):
        super().__init__(name, parent)

    async def drive_reset(self):
        # Reset interface values
        self.cfg.vif.ready.value  = 0
        self.cfg.vif.slverr.value = 0
        self.cfg.vif.rdata.value  = LogicArray("X" * self.cfg.DATA_WIDTH)

    async def drive_pins(self):
        await ReadOnly()

        # Wait for request phase
        while self.cfg.vif.sel.value == 0:
            await RisingEdge(self.cfg.vif.clk)
            await ReadOnly()

        await RisingEdge(self.cfg.vif.clk)

        self.cfg.vif.ready.value = 1
        self.cfg.vif.slverr.value = self.req.slverr

        if self.cfg.vif.wr.value == 0:
            self.cfg.vif.rdata.value = self.req.data

        await RisingEdge(self.cfg.vif.clk)
        await self.drive_reset()
