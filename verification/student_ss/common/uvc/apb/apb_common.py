from enum import Enum, IntEnum

class DriverType(Enum):
    """ Type of driver: not set (NOT_SET), producer (PRODUCER) or consumer (CONSUMER)"""
    NOT_SET  = 0
    CONSUMER = 1
    PRODUCER = 2

class OpType(IntEnum):
    """ Type of operation: read (RD) or write (WR)"""
    RD = 0
    WR = 1

class NormalAccess(IntEnum):
    NORMAL      = 0
    PRIVILEGED  = 1

class SecureAccess(IntEnum):
    SECURE      = 0
    NON_SECURE  = 1

class DataAccess(IntEnum):
    DATA        = 0
    INSTRUCTION = 1

class SequenceItemOverride(Enum):
    """ DEFAULT - agent makes the correct override
        USER_DEFINED - user must call the override mechanism"""
    DEFAULT      = 0
    USER_DEFINED = 1
