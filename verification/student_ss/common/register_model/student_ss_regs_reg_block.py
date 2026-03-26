from pyuvm import *
from .student_ss_regs_regs import reg0, reg1, reg2, reg3

class student_ss_regs_block(uvm_reg_block):
    """Class : The UVM register block class for student_ss_regs
        * Register Block Name : student_ss_example_regs
        * Register Block Desc : addrmap with registers for student_ss_example RTL """

    def __init__(self, name="student_ss_regs_block"):
        super().__init__(name)

        self.rw_reg = None
        self.gpio_r_reg = None
        self.gpio_w_reg = None
        self.ss_ctrl_reg = None

    # Build : The build function of student_ss_regs.
    def build(self):

        self.def_map = uvm_reg_map("map")
        self.def_map.configure(self, 0)

        # Constructing all registers in the current address map.
        self.rw_reg = reg0("rw_reg")
        self.gpio_r_reg = reg1("gpio_r_reg")
        self.gpio_w_reg = reg2("gpio_w_reg")
        self.ss_ctrl_reg = reg3("ss_ctrl_reg")

        # Configuring and building all registers of the current address map.
        self.rw_reg.configure(self, "0x0", "")
        self.gpio_r_reg.configure(self, "0x4", "")
        self.gpio_w_reg.configure(self, "0x8", "")
        self.ss_ctrl_reg.configure(self, "0x12", "")

        # Overriding the configuration of registers whose configuration in RDL
        # is dynamically changed after its base type.

        # Mapping all registers to the default address map.
        self.def_map.add_reg(self.rw_reg, "0x0", "RW")
        self.def_map.add_reg(self.gpio_r_reg, "0x0", "RW")
        self.def_map.add_reg(self.gpio_w_reg, "0x0", "RW")
        self.def_map.add_reg(self.ss_ctrl_reg, "0x0", "RW")

        self.set_lock()
