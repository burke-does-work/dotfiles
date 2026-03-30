# System Overview

All tools use the Gruvbox Dark Hard color scheme and JetBrains Mono Nerd Font for visual consistency.

---

## Shell — zsh

Config: `zshrc`, `zsh_plugins.txt`

The shell is the center of the environment. Key design decisions:

- **Vi mode** — press `Esc` to enter normal mode at the command line. Enables vim motions for editing commands. Cursor changes shape (block in normal, line in insert) to show which mode you're in.
- **Antidote** — plugin manager. Loads four plugins in order: completions → fzf-tab → autosuggestions → syntax highlighting. Order matters.
- **fzf integration** — fuzzy search over command history (`Ctrl+R`) and files (`Ctrl+T`). Tab completion uses fzf-tab for a visual dropdown.
- **Wayland clipboard sync** — yank/delete in zsh vi-mode syncs to the system clipboard so you can paste into any app.
- **Pyenv** — manages Python. Version 3.13.12. Activates automatically per directory if a `.python-version` file exists.
- **Startup `cd`** — if the encrypted SSD (`/mnt/ssd2_data`) is mounted at login, the shell starts there automatically.

---

## Terminal — Kitty

Config: `config/kitty/kitty.conf`, `config/kitty/startup.conf`

Kitty replaces tmux. It handles splits and tabs natively.

- **Startup session** — Kitty opens 5 tabs on launch: `keybindings` (nvim), `yazi`, `terminal`, `dev_01`, `dev_02`.
- **Splits** — vertical (`Ctrl+Shift+R`) and horizontal (`Ctrl+Shift+B`). Navigate with `Ctrl+Shift+H/J/K/L`.
- **No tmux** — Kitty's native tab/split system is used instead. Don't install tmux.

---

## Prompt — Starship

Config: `config/starship.toml`

Two-line prompt. Line 1 shows context (directory, git branch/status, active Python venv). Line 2 is the `❯` input character (green on success, red on error).

Python venv only appears when a venv is active — it doesn't show the system Python version.

---

## Primary editor — VS Code

Config: `config/Code/matt-profile/`

VS Code uses a named profile (`matt-profile`) rather than the default profile. This keeps settings isolated.

- **VSCodeVim** — vim modal editing inside VS Code. Leader key is `Space`. Same blackhole register bindings as Neovim (`<Space>d/c/x`).
- **Tab completion** — `Tab` accepts suggestions. Enter does not (prevents accidental accepts on newline).
- **Black formatter** — auto-formats Python on save.
- **Project Manager extension** — quick-switch between `~/dotfiles` and `/mnt/ssd2_data/documents`.

---

## Secondary editor — Neovim

Config: `config/nvim/init.lua`

Minimal config, used for single-file edits from the terminal. Not a full IDE.

- **vim-table-mode** — for editing markdown tables. Toggle with `<Space>tm`.
- **Clipboard** — uses the system clipboard (`unnamedplus`), so yanks paste into other apps.

Open a file from the terminal: `nvim filename`. The `keybindings` alias opens `keybindings.md` directly.

---

## File manager — Yazi

Config: `config/yazi/`

Terminal file manager. Launched from zsh or from the `yazi` startup tab.

- `dd` — move to trash (safe, recoverable)
- `D` — permanent delete
- `Delete` — move to trash

Yazi integrates with `zoxide` — use `z <partial-path>` to jump to frequently visited directories.

---

## SSH

Config: `ssh/config`

Single configured host: `pickle-pi` (192.168.8.154). Connect with `ssh pickle-pi`.

- Key-based auth with an ed25519 key. Passphrase cached by GNOME Keyring — you only enter it once per session.
- Connection multiplexing enabled — a second `ssh pickle-pi` reuses the existing connection instantly.
