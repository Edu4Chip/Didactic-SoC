from enum import Enum

class CmdType(Enum):
    """ Commands: sample and drive"""
    DRIVE  = 0
    SAMPLE = 1

class ItemType(Enum):
    MONITOR = 0

class ResetType(Enum):
    """Reset polarity: active low or active high"""
    ACTIVE_LOW = 0
    ACTIVE_HIGH = 1

class SequenceItemOverride(Enum):
    """ DEFAULT - agent makes the correct override
        USER_DEFINED - user must call the override mechanism"""
    DEFAULT      = 0
    USER_DEFINED = 1
