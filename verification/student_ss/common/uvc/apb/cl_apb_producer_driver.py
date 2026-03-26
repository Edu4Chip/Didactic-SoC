"""APB Producer Driver
- The UVM Driver is an active entity that converts abstract transaction to design pin toggles.
- Transaction level objects are obtained from the Sequencer and the UVM Driver drives them to the design via an interface handler."""

from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray
from pyuvm import *
from .apb_common import *
from .cl_apb_base_driver import cl_apb_base_driver

class cl_apb_producer_driver(cl_apb_base_driver):
    """ Signal interface producer driver for APB
    - translates transactions to pin level activity
    - transactions pulled from sequencer by the seq_item_port"""

    def __init__(self, name, parent):
        super().__init__(name, parent)

    async def drive_reset(self):
        # Reset interface values for producer
        self.cfg.vif.wr.value     = 0
        self.cfg.vif.sel.value    = 0
        self.cfg.vif.enable.value = 0
        self.cfg.vif.addr.value   = LogicArray("X" * self.cfg.ADDR_WIDTH)
        self.cfg.vif.wdata.value  = LogicArray("X" * self.cfg.DATA_WIDTH)
        self.cfg.vif.strb.value   = LogicArray("X" * self.cfg.STRB_WIDTH)

    async def drive_pins(self):
        # If unaligned to clock wait for clocking event
        await self.ev_last_clock.wait()

        self.logger.debug("Driving pins from transaction")

        # Drive transactions through interface
        if self.req.op == OpType.WR:
            self.cfg.vif.wr.value = 1
            self.cfg.vif.sel.value = 1
            self.cfg.vif.enable.value = 0
            self.cfg.vif.addr.value = self.req.addr
            self.cfg.vif.strb.value = self.req.strb

            # Masking signals not enabled by strobe-signal
            # Masked signals set to 0, as they cannot be x
            if self.cfg.enable_masked_data :
                masked_data = 0
                strb_signal = self.req.strb
                for i in range(self.cfg.STRB_WIDTH):
                    if strb_signal % 2 == 1:
                        masked_data += (self.req.data // 2**(8*i)) % 2**8 << (8*i)
                    strb_signal = strb_signal >> 1

                self.cfg.vif.wdata.value = masked_data
                self.logger.debug(f"Masked wdata: {hex(masked_data)}, strb={bin(self.req.strb)}")
            else:
                self.cfg.vif.wdata.value = self.req.data

        elif self.req.op == OpType.RD:
            self.cfg.vif.wr.value = 0
            self.cfg.vif.sel.value = 1
            self.cfg.vif.enable.value = 0
            self.cfg.vif.addr.value = self.req.addr
            self.cfg.vif.strb.value = 0
        else:
            self.logger.critical(f"Op type not WR or RD: op = {self.req.op}")

        self.logger.debug("Awaiting enable-signal")
        await RisingEdge(self.cfg.vif.clk)
        self.cfg.vif.enable.value = 1

        await RisingEdge(self.cfg.vif.clk)

        self.logger.debug("Awaiting ready-signal")
        while self.cfg.vif.ready.value != 1:
            await RisingEdge(self.cfg.vif.clk)
        self.rsp.slverr = int(self.cfg.vif.slverr.value)

        # Capture consumer response
        if self.req.op == OpType.RD:
            self.rsp.data = self.cfg.vif.rdata.value
            self.req.data = self.cfg.vif.rdata.value

        # Return to idle
        await self.drive_reset()

        self.logger.debug(f"REQ object: {self.req}")
        self.logger.debug(f"RSP object: {self.rsp}")
