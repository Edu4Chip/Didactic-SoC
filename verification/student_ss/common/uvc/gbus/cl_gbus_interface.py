from pyuvm import *

class cl_gbus_interface():
    """Python interface for Generic Bus configuration"""

    def __init__(self, clk_signal, rst_signal, name = "gbus_interface"):
        self.name = name
        self.clk = clk_signal
        self.rst = rst_signal

        # Signals
        self.bus = None

        # Signal widths
        self.BUS_WIDTH = None

    def connect(self, bus_signal):
        self.bus = bus_signal

    def initialize_bus(self):
        self.bus.value = 0

    def set_width_parameters(self, BUS_WIDTH = 32):
        self.BUS_WIDTH = BUS_WIDTH
