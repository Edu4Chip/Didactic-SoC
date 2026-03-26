
class cl_apb_interface():
    """Python interface for APB configuration"""

    def __init__(self, clk_signal, rst_signal, name = "apb_interface"):
        self.name = name
        self.clk = clk_signal
        self.rst = rst_signal

        # Signals
        self.wr        = None   # APB operation type (1 bit)
        self.sel       = None   # APB slave selector (1 bit)
        self.enable    = None   # APB transfer enable (1 bit)
        self.addr      = None   # APB address (up to 32 bits)
        self.wdata     = None   # APB write data (8, 16 or 32 bits)
        self.strb      = None   # APB write strobe signal (DATA_WIDTH/8 bits)
        self.rdata     = None   # APB read data (8, 16 or 32 bits)
        self.ready     = None   # APB ready signal (1 bit)
        self.slverr    = None   # APB error signal (1 bit)

        # Signal widths
        self.ADDR_WIDTH = None
        self.DATA_WIDTH = None
        self.STRB_WIDTH = None


    def connect(self, wr_signal, sel_signal, enable_signal, addr_signal,
                wdata_signal, strb_signal, rdata_signal, ready_signal, slverr_signal):
        """Connecting the signals to the interface"""

        self.wr        = wr_signal
        self.sel       = sel_signal
        self.enable    = enable_signal
        self.addr      = addr_signal
        self.wdata     = wdata_signal
        self.strb      = strb_signal
        self.rdata     = rdata_signal
        self.ready     = ready_signal
        self.slverr    = slverr_signal

        if self.ADDR_WIDTH is None or self.DATA_WIDTH is None or self.STRB_WIDTH is None:
            raise UVMFatalError("APB CFG WIDTH parameters not set")

    def _set_width_parameters(self, ADDR_WIDTH = 8, DATA_WIDTH = 8):
        self.ADDR_WIDTH = ADDR_WIDTH
        self.DATA_WIDTH = DATA_WIDTH
        self.STRB_WIDTH = DATA_WIDTH // 8
