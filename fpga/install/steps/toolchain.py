import shutil
import sys
import tarfile
import urllib.request
from pathlib import Path
from .base import Step, ProgressCallback

_DEFAULT_RELEASE = "2026.07.15"
_BASE_URL = (
    "https://github.com/riscv-collab/riscv-gnu-toolchain"
    "/releases/download/{release}/riscv32-elf-{os_tag}-gcc.tar.xz"
)
_OS_MAP = {
    ("ubuntu", "22.04"): "ubuntu-22.04",
    ("ubuntu", "24.04"): "ubuntu-24.04",
}
_FALLBACK_OS_TAG = "ubuntu-22.04"

_BAR_WIDTH = 40


def _detect_os() -> tuple:
    try:
        info = {}
        with open("/etc/os-release") as f:
            for line in f:
                k, _, v = line.strip().partition("=")
                info[k] = v.strip('"')
        return info.get("ID", "").lower(), info.get("VERSION_ID", "")
    except FileNotFoundError:
        return "", ""


def _draw_bar(pct: int) -> str:
    filled = round(_BAR_WIDTH * pct / 100)
    bar = "█" * filled + "░" * (_BAR_WIDTH - filled)
    return f"  [{bar}] {pct:3d}%"


class ToolchainStep(Step):
    title = "RISC-V Toolchain"
    description = "Download and install the riscv32-elf cross-compilation toolchain"

    def __init__(self, install_dir: Path, release: str = _DEFAULT_RELEASE):
        self.install_dir = install_dir
        self.release = release

    def check(self) -> bool:
        return (
            shutil.which("riscv32-unknown-elf-gcc") is not None
            or (self.install_dir / "bin" / "riscv32-unknown-elf-gcc").exists()
        )

    def run(self, log: ProgressCallback) -> bool:
        os_name, os_ver = _detect_os()
        log("info", f"Detected OS : {os_name} {os_ver}")

        os_tag = _OS_MAP.get((os_name, os_ver))
        if os_tag is None:
            log("warning", f"OS '{os_name} {os_ver}' not in pre-built release list.")
            if os_name == "ubuntu":
                os_tag = _FALLBACK_OS_TAG
                log("warning", f"Falling back to {os_tag} binaries.")
            else:
                log("error", "Cannot determine toolchain URL. Download manually from:")
                log("error", "  https://github.com/riscv-collab/riscv-gnu-toolchain/releases")
                return False

        url = _BASE_URL.format(release=self.release, os_tag=os_tag)
        archive = self.install_dir.parent / "riscv32-elf-gcc.tar.xz"

        log("info", f"Release     : {self.release}")
        log("info", f"Variant     : {os_tag}")
        log("info", f"URL         : {url}")
        log("info", f"Archive     : {archive}")
        log("info", f"Install dir : {self.install_dir}")
        log("info", "")

        if self.dry_run:
            log("info", f"[dry-run] Would run:")
            log("info", f"  wget {url}")
            log("info", f"  tar -xJf {archive} -C {self.install_dir}")
            log("info", f"  # then add bin/ to PATH")
            return True

        if not self._download(url, archive, log):
            return False

        log("info", "")
        log("info", f"Extracting archive …")
        self.install_dir.mkdir(parents=True, exist_ok=True)
        if not self._extract(archive, log):
            return False

        bin_dirs = sorted(self.install_dir.glob("*/bin")) + [self.install_dir / "bin"]
        bin_dir = next((d for d in bin_dirs if d.exists()), None)
        if bin_dir:
            log("ok",   "")
            log("ok",   "Toolchain installed successfully.")
            log("info", "Add to PATH:")
            log("info", f'  export PATH="{bin_dir}:$PATH"')
            log("info", "  (add the line above to ~/.bashrc to make it permanent)")
        return True

    def verify(self, log: ProgressCallback) -> bool:
        bin_dirs = sorted(self.install_dir.glob("*/bin")) + [self.install_dir / "bin"]
        compiler = next(
            (d / "riscv32-unknown-elf-gcc"
             for d in bin_dirs
             if (d / "riscv32-unknown-elf-gcc").exists()),
            None,
        )
        if compiler:
            log("ok", f"Compiler verified : {compiler}")
            return True
        log("error", "riscv32-unknown-elf-gcc not found after extraction.")
        return False

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _download(self, url: str, dest: Path, log: ProgressCallback) -> bool:
        if dest.exists():
            size_mb = dest.stat().st_size / 1_048_576
            log("info", f"Archive already present ({size_mb:.1f} MB), skipping download.")
            return True

        dest.parent.mkdir(parents=True, exist_ok=True)
        last_pct = [-1]

        def _progress(count, block, total):
            if total <= 0:
                return
            pct = min(count * block * 100 // total, 100)
            if pct != last_pct[0]:
                last_pct[0] = pct
                bar = _draw_bar(pct)
                done_mb = min(count * block, total) / 1_048_576
                total_mb = total / 1_048_576
                sys.stdout.write(f"\r{bar}  {done_mb:.1f}/{total_mb:.1f} MB")
                sys.stdout.flush()

        try:
            log("info", "Downloading …")
            urllib.request.urlretrieve(url, dest, reporthook=_progress)
            sys.stdout.write("\n")
            sys.stdout.flush()
            size_mb = dest.stat().st_size / 1_048_576
            log("ok", f"Download complete ({size_mb:.1f} MB).")
            return True
        except Exception as exc:
            sys.stdout.write("\n")
            log("error", f"Download failed: {exc}")
            return False

    def _extract(self, archive: Path, log: ProgressCallback) -> bool:
        try:
            with tarfile.open(archive) as tf:
                members = tf.getmembers()
                total = len(members)
                last_pct = -1
                for i, member in enumerate(members, 1):
                    tf.extract(member, self.install_dir)
                    pct = i * 100 // total
                    if pct != last_pct and pct % 2 == 0:
                        last_pct = pct
                        bar = _draw_bar(pct)
                        sys.stdout.write(f"\r{bar}  {i}/{total} files")
                        sys.stdout.flush()
            sys.stdout.write("\n")
            sys.stdout.flush()
            log("ok", "Extraction complete.")
            return True
        except Exception as exc:
            sys.stdout.write("\n")
            log("error", f"Extraction failed: {exc}")
            return False
