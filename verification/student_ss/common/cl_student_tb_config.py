
from pyuvm import *
from .uvc.apb import cl_apb_config

class cl_student_tb_config(uvm_object):
    def __init__(self, name = "cl_student_tb_config"):
        super().__init__(name)

        # Handle to APB configuration
        self.apb_cfg           = cl_apb_config.create("apb_cfg")
