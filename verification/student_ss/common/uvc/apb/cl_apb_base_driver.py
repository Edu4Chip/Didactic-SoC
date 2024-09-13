"""APB Base Driver
- The UVM Driver is an active entity that converts abstract transaction to design pin toggles.
- Transaction level objects are obtained from the Sequencer and the UVM Driver drives them to the design via an interface handler."""

from cocotb.triggers import RisingEdge, Event, Timer
from pyuvm import *
from .apb_common import *

class cl_apb_base_driver(uvm_driver):
    """ Signal interface driver for APB
    - translates transactions to pin level activity
    - transactions pulled from sequencer by the seq_item_port"""

    def __init__(self, name, parent):
        super().__init__(name, parent)

        # Handle to the configuration object
        self.cfg = None

        # Process
        self.get_and_drive_process = None

        # Record time of last clocking event
        self.ev_last_clock = None

    def build_phase(self):
        super().build_phase()

        # Get the configuration object
        self.cfg = ConfigDB().get(self, "", "cfg")

        # Creating the cocotb-triggers event object
        self.ev_last_clock = Event("ev_last_clock")


    async def run_phase(self):
        """Run phase:
        * Receives the sequence item.
        * For each sequence item it calls the clock_event, drive_transaction and
        handle_reset tasks in parallel in a fork join_none."""

        await super().run_phase()

        # Starts coroutines in parallel
        cocotb.start_soon(self.clock_event())
        cocotb.start_soon(self.drive_transaction())
        cocotb.start_soon(self.handle_reset())
        

    async def clock_event(self):
        while True:
            await RisingEdge(self.cfg.vif.clk)
            self.ev_last_clock.set()

            # Waits until next time step , default unit is step
            await Timer(1)
            self.ev_last_clock.clear()

    async def handle_reset(self):
        """ Kills driver process when reset is active"""
        while True:
            if self.cfg.vif.rst.value.binstr == '0':
                if self.get_and_drive_process is not None:
                    self.logger.debug("Process should be killed")
                    self.get_and_drive_process.kill()
                    self.get_and_drive_process = None
                    # Ends any active items
                    try:
                        self.seq_item_port.item_done()
                    except UVMSequenceError:
                        self.logger.info("No current active item")
            await RisingEdge(self.cfg.vif.clk)

    async def drive_transaction(self):
        while True:
            await self.drive_reset()

            while self.cfg.vif.rst.value.binstr != '1':
                await RisingEdge(self.cfg.vif.clk)

            # Passes coroutine to process handle -> possible to kill() process
            self.get_and_drive_process = cocotb.start_soon(self.get_and_drive_transaction())
            # Waits for process to finish
            await self.get_and_drive_process

    async def get_and_drive_transaction(self):
        # Start driver loop
        if self.cfg.driver is not DriverType.PRODUCER and self.cfg.driver is not DriverType.CONSUMER:
            raise UVMFatalError(
                f"APB DRIVER, not handled driver {self.get_full_name()}")
        await self.driver_loop()

    async def drive_reset(self):
        # Reset interface values according to type
        self.logger.critical(f"Driver type not handled {self.get_full_name()}")

    async def driver_loop(self):
        while True:
            self.logger.debug("APB-Driver waiting for next seq_item")

            # Waits for seq item
            self.req = await self.seq_item_port.get_next_item()
            self.logger.debug(f"APB-Driver item: {self.req}")

            # Creates clone of seq item
            self.rsp = self.req.clone()
            # Set the transaction ID
            self.rsp.set_id_info(self.req)
            # Set the response ID
            self.rsp.set_context(self.req)

            self.logger.debug("Driving pins")
            await self.drive_pins()

            self.seq_item_port.item_done(self.rsp)