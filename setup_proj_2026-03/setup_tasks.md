[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Ubuntu 24.04 Setup Tasks

## Configuration tasks

### Pending

- fzf — configure default options and keybindings
- Kitty — full keybindings and splits configuration
- Kitty — Neovim integration
- Antidote — review and expand plugins as needed

## Default applications

### Pending

- Set EDITOR and VISUAL env vars in `.zshrc`

## Neovim

### Pending

- Basic nvim configuration (full setup — deferred)
- Essential navigation and workflow
- Implement tab completion standard in neovim
- Evaluate ranger alternatives (yazi, lf, etc.) before investing in ranger config

## Chinese input

### Pending

- Decision — fcitx5 vs alternatives
- Install and configure chosen input method

## Vim clipboard / black-hole deletes

### Completed

- Inverted pattern: `d`/`x`/`c` are now standard vim (cut to clipboard); `<Space>d`/`x`/`c` send to blackhole register. Space is leader in nvim and VS Code.
- Zsh vi-mode: full Wayland clipboard integration via `wl-clipboard`; yank/delete syncs to system clipboard, `p`/`P` paste from system clipboard. Blackhole bindings not implemented in zsh (ZLE limitation).

## VS Code

### Decisions

- VIM extension — VSCodeVim (`vscodevim.vim`); `vim.useSystemClipboard: true` for clipboard integration
- Terminal switching — Super+1 raises Kitty (GNOME-level); no VS Code config needed
- File roles — `nvim -R` for read-only inspection, nvim for single file edits, VS Code for projects
- Inline suggestions — disabled globally (`editor.inlineSuggest.enabled: false`); Copilot next edit suggestions not used
- VS Code terminal — not used; all execution happens in Kitty to avoid confusion about which terminal to use. VS Code is passive (editing, viewing Claude Code changes); Kitty is active (running scripts, Claude Code). VS Code terminal panel kept closed to remove temptation.

### Pending

- VSCodeVim + tab completion — verify Tab works in insert mode; add vim.handleKeys for `<tab>` if needed
- Keybindings — clean up and expand

## Kitty

### Pending

- Add keybinding to jump directly to the `proj_dev` tab
- Explore Kitty `hints` kitten for keyboard-driven text selection — lets you select URLs, paths, and words from terminal output without the mouse; invoked via a Kitty shortcut (default `ctrl+shift+p`) — purpose: reduce cognitive load when switching from VS Code to run a quick command; eliminates having to scan open tabs and navigate manually. Workflow: Super+1 raises Kitty (already configured), then this shortcut lands on `proj_dev` immediately. Candidate: `ctrl+3` via `goto_tab 3` in `kitty.conf` (proj_dev is always the 3rd tab in startup.conf).

## Keyboard shortcuts

### Pending

- Test vim-table-mode in Neovim — verify `\tm` toggles table mode and tables format correctly in `keybindings.md`
- Create Google Sheet in Google Drive listing keyboard shortcuts across the stack — goal is consistency across all tools
- Fix zsh stealing Ctrl+Shift+B in VS Code — this keybinding is used to toggle the VS Code sidebar but zsh intercepts it

## Remaining installation and configuration

### Pending

- Claude Code — cursor shape not configurable — block cursor is hardcoded regardless of mode
- Re-upgrade zlib1g and libbz2 security patches

## Context for continuation

- **OS:** Ubuntu 24.04, username: matt
- **Shell:** zsh with Antidote, Starship, fzf, zsh-autosuggestions, zsh-syntax-highlighting
- **Terminal:** Kitty with Gruvbox Dark Hard theme, JetBrains Mono Nerd Font
- **Python:** pyenv managing Python 3.13.12
- **Editors:** VS Code (primary), Neovim (single file edits)
- **Claude Code:** installed and configured, version 2.1.76

## Raspberry Pi on LAN (pickle-pi) setup

### Pending

- Evaluate SSH setup
- Troubleshoot drive mount issues for access to the drive data via NFS on matt-9000 (this computer)

---

## Completed

### Decisions

- File roles — nvim for single file edits, VS Code for projects

### Shell setup

- Verify zsh is set as default shell and GNOME Terminal is updated
- Install pyenv
- Verify pyenv works in zsh
- Build `.zshrc` from scratch

### Zsh decision points

- Prompt — Starship
- Syntax highlighting — zsh-syntax-highlighting
- Autosuggestions — zsh-autosuggestions
- Fuzzy completion — fzf + zsh built-in
- Plugin manager — Antidote

### Terminal emulator & multiplexer

- Terminal emulator — Kitty
- Multiplexer — Drop tmux
- Cursor shape

### Configuration tasks

- Kitty — basic config, colors, font
- Starship — configure prompt appearance (directory, git branch, dirty indicator, Python venv, 2-line prompt with Nerd Font icons and Gruvbox colors)
- pyenv — create first virtual environment
- Kitty — implement focused/unfocused window background color differentiation (see decision point in Terminal emulator & multiplexer)
- Starship — test git branch/dirty indicator and Python venv display once a git repo and virtualenv are set up on this machine

### Tab completion

- Finalize tab completion standard
- Implement in zsh
- Implement in VS Code

### Theme

- VS Code — Gruvbox Dark Hard
- Kitty — Gruvbox Dark Hard
- Kitty — verify font rendering
- GNOME — Gruvbox accent color

### Neovim

- Install neovim (v0.9.5 already present)
- Minimal init.lua for nvim -R (read-only viewing): line numbers, no swapfile, termguicolors
- Clipboard: `unnamedplus` set; Space as leader (all bindings including table-mode use `<Space>`); `d`/`x`/`c` standard vim (cut to clipboard); `<Space>d`/`x`/`c` → blackhole register

### Ranger

- Check if Ranger should open Neovim or another tool — Ranger opens nvim for text files and scripts
- Install and configure Ranger

### VS Code

- Vim keybindings: Space as leader; `d`/`x`/`c` standard vim (cut to clipboard); `<Space>d`/`D`/`x`/`X`/`c`/`C` → blackhole register in normal and visual mode
- Install VSCodeVim (vscodevim.vim)
- Install ms-python.black-formatter (pulled in Python, Pylance, debugpy)
- Tab completion: acceptSuggestionOnEnter off, tabCompletion on, quickSuggestions configured, suggestSelection recentlyUsedByPrefix
- Jupyter: interactive window settings applied; notebook-specific settings removed
- Basic functionality: explorer confirmations off
- Editor: inline suggestions off, parameter hints off, auto-closing brackets/quotes off
- Formatting: per-language rules for json, markdown, python (black)
- Markdown: validation enabled, markdownlint configured (MD033/045/036/024 disabled), inline fold for links
- Appearance: ruler at 88, minimap off, font set to JetBrains Mono Nerd Font
- Git: autofetch on, count badge off, rebase on sync, action buttons hidden, no parent folder scanning
- Project Manager: baseFolders set to /mnt/ssd2_data/documents

### Keyboard shortcuts

- Set up keybindings reference file (`~/dotfiles/keybindings.md`): dotfiles repo, vim-table-mode in Neovim, `keybindings` alias, Kitty startup tab
- Populate `keybindings.md`: Universal vim motions, VS Code subsections (Global Nav, Intellisense, Jupyter)

### Remaining installation and configuration

- Set up dotfiles repo on GitHub (`~/dotfiles` → `github.com/burke-does-work/dotfiles`)
- SSH key (ed25519) generated, added to GitHub as "matt-9000", GNOME Keyring caching passphrase via ssh-agent
- Claude Code — install, configure, and enable vim mode (`"vim": true` in `~/.claude/settings.json`)
- Ranger — install and configure

### Drive mounting

- Replaced `ssd2_drive_mount.sh` and `nfs_mount.sh` with `/etc/crypttab` + `/etc/fstab` entries managed by systemd. Key file moved to `/etc/cryptsetup-keys.d/ssd2_world.key` (root-only). Aliases `mountlocal`, `umountlocal`, `mountnfs`, `umountnfs` updated in `~/dotfiles/zshrc`. Old scripts archived to `helper_scripts/archive/`. Drives remain `noauto` — no change to boot behaviour or user workflow.
  - Planning notes: `/home/matt/.claude/projects/-home-matt-temp-workstation-setup/` (session `2f4b5d7e-b7a5-41f1-bf66-c59971dd8350`)
  - One implementation detail not in the plan: GNOME auto-mounts the drive at `/media/matt/ssd2_world` on plug-in, which blocked `cryptdisks_start`. `mountlocal` now silently dismisses the GNOME mount first.
