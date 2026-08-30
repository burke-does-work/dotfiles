# System Overview

Current machine: `maodou-mac`.

The setup uses Gruvbox Dark Hard colors and CommitMono Nerd Font where practical.
Config lives in this repo and is symlinked into the locations each tool expects.

## Shell — zsh

Config: `config/zsh/zshrc_maodou-mac`, `config/zsh/zsh_plugins.txt`

- Vi mode is enabled.
- Antidote loads zsh completions, fzf-tab, autosuggestions, and syntax highlighting.
- fzf provides file and history search.
- macOS clipboard integration uses `pbcopy` and `pbpaste`.

## Terminal — Ghostty

Config: `config/ghostty/config`

Ghostty is the main terminal. It handles tabs and splits directly. Terminals are
excluded from the Ctrl/Cmd swap so `Ctrl+C` stays SIGINT.

## Prompt — Starship

Config: `config/starship.toml`

Two-line prompt with directory, git state, active Python venv, and command status.

## Python — uv

uv is an all-in-one Python version manager, virtual environment tool, and package
manager. It replaces pyenv, pip, venv, and pipx.

- Python versions are installed via `uv python install <version>` and stored in
  `~/.local/share/uv/python/`.
- The global default is pinned in `~/.config/uv/.python-version` (currently 3.12.4).
- Per-project `.python-version` files are read automatically.
- `uv venv` creates `.venv/` in the current directory; activate with
  `source .venv/bin/activate`.
- `uv pip install` is a drop-in for `pip install`.
- `uv tool install <tool>` installs CLI tools in isolated envs (replaces pipx).
- Shell completions live in `~/.zsh/completions/_uv` (regenerate after `uv self update`).

## Window Management — AeroSpace

Config: `config/aerospace/aerospace.toml`

AeroSpace manages workspaces, tiling, directional focus, and app assignment.
Raycast remains the launcher and window search tool.

## Keyboard Layer — Karabiner

Config: `config/karabiner/`

Karabiner handles modifier remapping, Linux-style text navigation, input-source
toggle, screenshot shortcut, and app-specific rescue rules.

`~/.config/karabiner` is a directory symlink because Karabiner rewrites files
atomically.

## Editors

VS Code config:

- `config/Code/global/`
- `config/Code/matt-profile/`

Neovim config:

- `config/nvim/init.lua`

VS Code is the project editor. Neovim is the terminal editor for quick file edits
and config work.

## File Manager — Yazi

Config: `config/yazi/`

Yazi is the terminal file manager. It uses vim-like file operations and integrates
with zoxide.

## Claude Code

Config:

- `config/claude/settings.json` -> `~/.claude/settings.json`
- `config/claude/CLAUDE.md` -> `~/.claude/CLAUDE.md`
- `local/documents/global_workflows/AGENTS.md` -> `~/.claude/AGENTS.md`

Claude Code is configured for vim mode, explicit permissions, and terminal use
inside Ghostty.

## Codex

Config:

- `config/codex/config.toml` -> `~/.codex/config.toml`
- `local/documents/global_workflows/skills` -> `~/.agents/skills`

Only user-editable Codex config is tracked. Auth, logs, caches, history, sessions,
and state remain local.

## SSH

Config: `ssh/config` → `~/.ssh/config`

Configured hosts: `pickle-pi`, `maodou-pi`, and `github.com`. Key-based auth and connection
multiplexing are enabled. The multiplex socket directory `~/.ssh/multiplex/` must be
created manually on a new machine (`mkdir -p ~/.ssh/multiplex`) — it is not tracked
in this repo.
