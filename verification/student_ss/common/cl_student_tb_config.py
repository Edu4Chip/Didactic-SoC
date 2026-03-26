
from pyuvm import *
from .uvc.apb import cl_apb_config
from .uvc.gbus import cl_gbus_cfg

class cl_student_tb_config(uvm_object):
    def __init__(self, name = "cl_student_tb_config"):
        super().__init__(name)

        # Handle to APB configuration
        self.apb_cfg        = cl_apb_config.create("apb_cfg")

        # Handle to GPIO configurations
        self.pmod_0_gpi_cfg = cl_gbus_cfg.create("pmod_0_gpi_cfg")
        self.pmod_0_gpo_cfg = cl_gbus_cfg.create("pmod_0_gpo_cfg")
        self.pmod_1_gpi_cfg = cl_gbus_cfg.create("pmod_1_gpi_cfg")
        self.pmod_1_gpo_cfg = cl_gbus_cfg.create("pmod_1_gpo_cfg")

        # Handle to SS CTRL configuration
        self.ss_ctrl_cfg    = cl_gbus_cfg.create("ss_ctrl_cfg")

        # Handle to IRQ configuration
        self.irq_en_cfg     = cl_gbus_cfg.create("irq_en_cfg")
        self.irq_cfg        = cl_gbus_cfg.create("irq_cfg")
