from abc import ABC, abstractmethod
from typing import Callable

ProgressCallback = Callable[[str, str], None]


class Step(ABC):
    title: str = ""
    description: str = ""
    dry_run: bool = False

    def check(self) -> bool:
        """Return True if this step is already complete and can be skipped."""
        return False

    @abstractmethod
    def run(self, log: ProgressCallback) -> bool:
        """Perform the step. Call log(level, msg) to report progress.
        In dry-run mode (self.dry_run is True) print what would happen and
        return True without making any changes.
        """
        ...

    def verify(self, log: ProgressCallback) -> bool:
        """Confirm success after run(). Defaults to check()."""
        return self.check()
