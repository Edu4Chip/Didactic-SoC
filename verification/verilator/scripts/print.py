"""Print colored and indented text
"""

from colorama import Style

INDENT = "  "

original_print = print

def print(*args, **kwargs):
    color = kwargs.pop("color", None)
    indent = INDENT * kwargs.pop("indent", 0)
    if color is None:
        original_print(indent + " ".join(map(str, args)), **kwargs)
    else:
        original_print(color + indent + " ".join(map(str, args)) + Style.RESET_ALL, **kwargs)
