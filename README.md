TJ's Shell Bits 'n' Pieces
==========================

A collection of scripts, bash profile changes, etc. that I like to have on most of my systems.

**Targets:** bash on Linux and macOS (compatible with bash v3, the macOS system default).

## Install

```bash
./install.sh
```

`install.sh` does two things:

1. **Symlinks `./bin/*`** (executable files) into `~/Local/bin/`, creating the directory if needed.
2. **Sources `./init/*.sh`** from `~/.bashrc` — each file gets a `source "..."` line appended if not already present.

Run from the repo root. Re-running is safe; existing entries are skipped.

---

## bin commands

### `gnutil`

Run GNU tools via `nix` without touching your shell profile. Binaries are built on first use and cached under `~/Local/share/gnutil/`.

Primarily intended for **macOS**, where system tools are BSD variants. On Linux the symlink is installed but gnutil does nothing unless actually invoked — it is otherwise dormant and harmless.

**Usage:**

```
gnutil                  # list all supported tools
gnutil CMD              # install a gCMD symlink in ~/Local/bin/
gCMD [args…]           # run the GNU version of CMD (via symlink)
```

Requires `nix`. Override paths with `GNUTIL_LOCALBIN` and `GNUTIL_LINKDIR`.

---

### `kctool`

An interactive terminal UI for `kubectl`. The typical kubectl workflow is: list objects, select the one you want, copy its name, paste it into the next command — repeat. kctool eliminates that: it lists objects with index numbers and lets you act on any of them immediately with a single keystroke. Consecutive objects can be targeted as a range, and consecutive objects in the same namespace are batched into one kubectl call.

Requires `kubectl` and `jq`.

**Usage:**

```
kctool [kind]           # default kind: all,ingress,secret
```

Namespace defaults to the current directory name; falls back to all namespaces if not found.

Commands are single letters optionally followed by an object number or range (e.g. `D3`, `L12-15`). Run `H` inside the tool for the full command reference. Destructive actions (`R`, `C`) prompt for confirmation (y/n/always).

---

## Bash init (sourced into `~/.bashrc`)

### `init/home_local.sh`

Adds `~/Local` as the local prefix for tools and libraries. Uses a `prepend_path` helper that skips entries already in the variable and skips paths whose parent directory doesn't exist.

| Variable | Path |
|----------|------|
| `PATH` | `~/Local/bin` |
| `LD_LIBRARY_PATH` | `~/Local/lib` |
| `PKG_CONFIG_PATH` | `~/Local/lib/pkgconfig` |
| `MANPATH` | `~/Local/share/man` |
| `PYTHONPATH` | `~/Local/lib/python` |
| `GOPATH` / `GOBIN` | `~/Local/lib/go` / `~/Local/bin` |
| `PERL5LIB` | `~/Local/lib/perl5` |

`MANPATH` is initialised to `:` before prepending, so the system man pages are still included.

### `init/alias.sh`

Kubectl convenience aliases:

| Alias | Expands to |
|-------|-----------|
| `kc` | `kubectl` |
| `kcn` | `kubectl -n "$(basename $PWD)"` — uses current directory name as namespace |

### `init/prompt.sh`

Sets a colourful `PS1` with: tty number, `user@host`, current directory, and a `=)` / `:(` smiley indicating whether the last command succeeded or failed.

Also defines an `rs` alias to print just the smiley on demand.
