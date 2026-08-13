import os
from pathlib import Path
from .base import Step, ProgressCallback

_DEFAULT_SYMLINK_DIR = Path.home() / "Toolchains" / "DidacticSoC" / "bin"
_MARKER = "# didactic-soc PATH"

# Shell name (from $SHELL basename) → RC file path and export syntax
_SHELL_INFO = {
    "bash": (Path.home() / ".bashrc",                           "posix"),
    "zsh":  (Path.home() / ".zshrc",                            "posix"),
    "ksh":  (Path.home() / ".kshrc",                            "posix"),
    "sh":   (Path.home() / ".profile",                          "posix"),
    "dash": (Path.home() / ".profile",                          "posix"),
    "fish": (Path.home() / ".config" / "fish" / "config.fish",  "fish"),
}


def _detect_shell() -> tuple:
    shell_name = Path(os.environ.get("SHELL", "/bin/bash")).name
    rc_path, syntax = _SHELL_INFO.get(shell_name, _SHELL_INFO["bash"])
    return shell_name, rc_path, syntax


def _export_line(syntax: str, symlink_dir: Path) -> str:
    if syntax == "fish":
        return f"fish_add_path {symlink_dir}"
    return f'export PATH="{symlink_dir}:$PATH"'


class PathStep(Step):
    title = "PATH Extension"
    description = (
        "Create a canonical symlink directory for installed tools "
        "and extend the shell PATH"
    )

    def __init__(self, toolchain_install_dir: Path,
                 symlink_dir: Path = _DEFAULT_SYMLINK_DIR):
        self.toolchain_install_dir = toolchain_install_dir
        self.symlink_dir = symlink_dir

    def check(self) -> bool:
        if not self.symlink_dir.exists():
            return False
        _, rc_path, _ = _detect_shell()
        try:
            return str(self.symlink_dir) in rc_path.read_text()
        except OSError:
            return False

    def run(self, log: ProgressCallback) -> bool:
        shell_name, rc_path, syntax = _detect_shell()
        export_line = _export_line(syntax, self.symlink_dir)

        log("info", f"Symlink dir : {self.symlink_dir}")
        log("info", f"Shell       : {shell_name}  (detected from $SHELL)")
        log("info", f"RC file     : {rc_path}")
        log("info", f"Export line : {export_line}")
        log("info", "")

        if self.dry_run:
            log("info", "[dry-run] Step 1 — Would create symlink directory and populate:")
            log("info", f"  mkdir -p {self.symlink_dir}")
            log("info",  "  ln -sf <toolchain>/bin/* <symlink_dir>/")
            log("info", "")
            log("info", "[dry-run] Step 2 — Would extend PATH:")
            log("info", f"  echo '{_MARKER}' >> {rc_path}")
            log("info", f"  echo '{export_line}' >> {rc_path}")
            return True

        if not self._create_symlinks(log):
            return False
        self._extend_rc(export_line, rc_path, log)
        return True

    # ------------------------------------------------------------------

    def _toolchain_bin(self) -> "Path | None":
        dirs = sorted(self.toolchain_install_dir.glob("*/bin"))
        dirs.append(self.toolchain_install_dir / "bin")
        return next((d for d in dirs if d.is_dir()), None)

    def _create_symlinks(self, log: ProgressCallback) -> bool:
        log("info", "Step 1 — Symlink directory")
        log("info", "─" * 40)

        bin_dir = self._toolchain_bin()
        if bin_dir is None:
            log("error", f"Toolchain bin directory not found under {self.toolchain_install_dir}")
            log("error", "Run the toolchain installation step first.")
            return False

        self.symlink_dir.mkdir(parents=True, exist_ok=True)
        log("ok",   f"Directory ready: {self.symlink_dir}")

        tools = sorted(p for p in bin_dir.iterdir() if p.is_file() or p.is_symlink())
        if not tools:
            log("warning", f"No executables found in {bin_dir}")
            return True

        created = updated = skipped = 0
        for tool in tools:
            link = self.symlink_dir / tool.name
            if link.is_symlink():
                if link.resolve() == tool.resolve():
                    skipped += 1
                    continue
                link.unlink()
                link.symlink_to(tool)
                updated += 1
            else:
                if link.exists():
                    log("warning", f"  {link.name}: non-symlink file exists — skipping")
                    skipped += 1
                    continue
                link.symlink_to(tool)
                created += 1

        log("ok",   f"Symlinks: {created} created, {updated} updated, {skipped} unchanged")
        log("info", f"  source : {bin_dir}")
        log("info", f"  target : {self.symlink_dir}")
        log("info", "")
        return True

    def _extend_rc(self, export_line: str, rc_path: Path,
                   log: ProgressCallback) -> None:
        log("info", "Step 2 — Shell RC file")
        log("info", "─" * 40)

        current_path = os.environ.get("PATH", "").split(":")
        if str(self.symlink_dir) in current_path:
            log("info", "Symlink directory already active in current $PATH.")

        try:
            existing = rc_path.read_text() if rc_path.exists() else ""
        except OSError:
            existing = ""

        if str(self.symlink_dir) in existing:
            log("info", f"RC file already references {self.symlink_dir} — no changes.")
            return

        rc_path.parent.mkdir(parents=True, exist_ok=True)
        try:
            with rc_path.open("a") as f:
                f.write(f"\n{_MARKER}\n{export_line}\n")
            log("ok",   f"Appended to {rc_path}:")
            log("info", f"  {export_line}")
            log("info",  "  Open a new terminal (or run 'source {rc_path}') to activate.")
        except OSError as exc:
            log("warning", f"Could not write to {rc_path}: {exc}")
            log("info",    "Add this line manually:")
            log("info",    f"  {export_line}")
