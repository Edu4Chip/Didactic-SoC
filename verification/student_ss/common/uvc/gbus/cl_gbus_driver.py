from pyuvm import *
from cocotb.triggers import RisingEdge, FallingEdge, Timer

from .gbus_common import CmdType, ResetType

class cl_gbus_driver(uvm_driver):
    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Configuration handle
        self.cfg = None

        # Handle to request and reponse items
        self.req = None
        self.rsp = None

        # Driver process
        self.active_driver_process = None

        # Record time of last clocking event
        self.ev_last_clock = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Creating the cocotb-triggers event object
        self.ev_last_clock = Event("ev_last_clock")

    async def run_phase(self):
        await super().run_phase()

        cocotb.start_soon(self.clock_event())
        cocotb.start_soon(self.handle_reset())
        cocotb.start_soon(self.drive_transaction())

    async def clock_event(self):
        while True:
            self.ev_last_clock.clear()
            await RisingEdge(self.cfg.vif.clk)
            self.ev_last_clock.set()

    async def drive_transaction(self):
        while True:
            await self.drive_reset()

            self.active_driver_process = cocotb.start_soon(self.get_and_drive_transaction())
            await self.active_driver_process

    async def handle_reset(self):
        """Detect reset and kill driver process"""
        while True:
            if self.cfg.reset_polarity == ResetType.ACTIVE_HIGH:
                await RisingEdge(self.cfg.vif.rst)
            elif self.cfg.reset_polarity == ResetType.ACTIVE_LOW:
                await FallingEdge(self.cfg.vif.rst)
            else:
                raise UVMFatalError(
                    f"GBUS DRIVER, reset polarity not set in cfg, {self.get_full_name()}")

            if self.active_driver_process is not None:
                self.active_driver_process.kill()
                self.active_driver_process = None

    async def drive_reset(self):
        """Drive bus to reset value and await reset deactivation"""

        self.cfg.vif.initialize_bus()

        if self.cfg.reset_polarity == ResetType.ACTIVE_HIGH:
            await FallingEdge(self.cfg.vif.rst)
        elif self.cfg.reset_polarity == ResetType.ACTIVE_LOW:
            await RisingEdge(self.cfg.vif.rst)
        else:
            raise UVMFatalError(
                f"GBUS DRIVER, reset polarity not set in cfg, {self.get_full_name()}")

    async def get_and_drive_transaction(self):
        """Await request item and handle request according to CmdType"""
        while True:
            # Waits for seq item
            self.req = await self.seq_item_port.get_next_item()
            self.logger.debug(f"Got item: {self.req}")

            await self.handle_sync_request()
            self.seq_item_port.item_done(self.rsp)

    async def handle_sync_request(self):
        # aligning sync requests with clock
        await self.ev_last_clock.wait()

        # Creates clone of seq item
        self.rsp = self.req.clone()
        # Set the transaction ID
        self.rsp.set_id_info(self.req)
        # Set the response ID
        self.rsp.set_context(self.req)

        if self.req.cmd == CmdType.DRIVE:
            self.cfg.vif.bus.value = self.req.value
            self.rsp.value = self.req.value
        elif self.req.cmd == CmdType.SAMPLE:
            self.rsp.value = self.cfg.vif.bus.value
        else:
            raise UVMFatalError(
                f"GBUS DRIVER, Request has invalid CmdType, {self.get_full_name()}")

