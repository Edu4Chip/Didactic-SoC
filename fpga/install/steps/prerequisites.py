import shutil
from .base import Step, ProgressCallback

# (binary to probe with `which`, apt package that provides it)
_REQUIRED = [
    ("git",        "git"),
    ("gcc",        "build-essential"),
    ("make",       "build-essential"),
    ("autoconf",   "autoconf"),
    ("libtoolize", "libtool"),
    ("pkg-config", "pkg-config"),
    ("wget",       "wget"),
]


class PrerequisitesStep(Step):
    title = "Prerequisites"
    description = "Verify required build tools are present before compilation"

    def check(self) -> bool:
        return all(shutil.which(cmd) for cmd, _ in _REQUIRED)

    def run(self, log: ProgressCallback) -> bool:
        if self.dry_run:
            log("info", f"[dry-run] Would check {len(_REQUIRED)} tools: "
                + ", ".join(cmd for cmd, _ in _REQUIRED))
            return True

        log("info", f"Checking {len(_REQUIRED)} required tools …")
        log("info", "")

        missing_pkgs = []
        for cmd, pkg in _REQUIRED:
            path = shutil.which(cmd)
            if path:
                log("ok",  f"  found    {cmd:<14}  {path}")
            else:
                log("warning", f"  missing  {cmd:<14}  (apt package: {pkg})")
                missing_pkgs.append(pkg)

        if missing_pkgs:
            log("info", "")
            unique = sorted(set(missing_pkgs))
            log("error", "One or more tools are missing. Install them with:")
            log("error", f"  sudo apt install {' '.join(unique)}")
            return False

        log("info", "")
        log("ok", "All prerequisites satisfied.")
        return True
