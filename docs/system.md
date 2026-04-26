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

## Terminal — Ghostty

Config: `config/ghostty/`

Ghostty replaced Kitty. It handles splits and tabs natively, no tmux needed.

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

Terminal file manager. Launched from zsh or from the terminal.

- `dd` — move to trash (safe, recoverable)
- `D` — permanent delete
- `Delete` — move to trash

Yazi integrates with `zoxide` — use `z <partial-path>` to jump to frequently visited directories.

---

## Claude Code

Config: `config/claude/settings.mac.json` — symlinked to `~/.claude/settings.json`.
Global instructions: `config/claude/CLAUDE.md` — symlinked to `~/.claude/CLAUDE.md`, loaded for every session.

Permission model:

- **Read tool** is unrestricted (`Read(**)` + `additionalDirectories: ["/"]`). Deny list covers `~/.ssh`, `~/.gnupg`, and `.env*` files.
- **Bash** uses an explicit allow list of read-only commands (`find`, `ls`, `grep`, `rg`, `wc`, `git log/status/diff`, etc.). `cat`, `head`, `tail` are intentionally excluded — Claude is instructed to use the Read tool for file content.
- **Edit/Write** are not allow-listed, so they always prompt.

Two rules in `~/.claude/CLAUDE.md` close the most common prompt gaps:

1. Use the Read tool for file content — never `cat`/`head`/`tail` in Bash.
2. One command per Bash call — no chaining with `&&`, `||`, or `;`. Compound commands don't match single-command allow patterns and will always prompt.

---

## SSH

Config: `ssh/config`

Single configured host: `pickle-pi` (192.168.8.154). Connect with `ssh pickle-pi`.

- Key-based auth with an ed25519 key. Passphrase cached by GNOME Keyring — you only enter it once per session.
- Connection multiplexing enabled — a second `ssh pickle-pi` reuses the existing connection instantly.
