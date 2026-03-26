from pyuvm import *

class reg0(uvm_reg):
    """Class : The UVM register class for reg0"""

    def __init__(self, name="reg0",reg_width=32):
        super().__init__(name, reg_width)

        self.field0 = None
        self.field1 = None
        self.field2 = None

    # Build : The build function of reg0.
    def build(self):

        # Constructing all fields in the current register.
        self.field0 = uvm_reg_field("field0")
        self.field1 = uvm_reg_field("field1")
        self.field2 = uvm_reg_field("field2")

        # Configuring all fields of the current register.
        self.field0.configure(self, 8, 0, "RW", True, 0)
        self.field1.configure(self, 8, 8, "RW", True, 0)
        self.field2.configure(self, 16, 16, "RW", False, 0)

class reg1(uvm_reg):
    """Class : The UVM register class for reg1 """

    def __init__(self, name="reg1",reg_width=32):
        super().__init__(name, reg_width)

        self.gpio0_field = None
        self.gpio1_field = None
        self.unused = None

    # Build : The build function of reg1.
    def build(self):

        # Constructing all fields in the current register.
        self.gpio0_field = uvm_reg_field("gpio0_field")
        self.gpio1_field = uvm_reg_field("gpio1_field")
        self.unused = uvm_reg_field("unused")

        # Configuring all fields of the current register.
        self.gpio0_field.configure(self, 4, 0, "RW", True, 0)
        self.gpio1_field.configure(self, 4, 4, "RW", True, 0)
        self.unused.configure(self, 24, 8, "RW", False, 0)

class reg2(uvm_reg):
    """Class : The UVM register class for reg2"""

    def __init__(self, name="reg2",reg_width=32):
        super().__init__(name, reg_width)

        self.gpio0_field = None
        self.gpio1_field = None
        self.unused = None

    # Build : The build function of reg2.
    def build(self):

        # Constructing all fields in the current register.
        self.gpio0_field = uvm_reg_field("gpio0_field")
        self.gpio1_field = uvm_reg_field("gpio1_field")
        self.unused = uvm_reg_field("unused")

        # Configuring all fields of the current register.
        self.gpio0_field.configure(self, 4, 0, "RW", True, 0)
        self.gpio1_field.configure(self, 4, 4, "RW", True, 0)
        self.unused.configure(self, 24, 8, "RW", False, 0)

class reg3(uvm_reg):
    """Class : The UVM register class for reg3"""

    def __init__(self, name="reg3",reg_width=32):
        super().__init__(name, reg_width)

        self.ss_ctrl = None
        self.unused = None

    # Build : The build function of reg3.
    def build(self):

        # Constructing all fields in the current register.
        self.ss_ctrl = uvm_reg_field("ss_ctrl")
        self.unused = uvm_reg_field("unused")

        # Configuring all fields of the current register.
        self.ss_ctrl.configure(self, 8, 0, "RW", True, 0)
        self.unused.configure(self, 24, 8, "RW", False, 0)
