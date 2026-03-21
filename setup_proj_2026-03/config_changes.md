[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Config Changes

## zsh

Config file: `~/.zshrc`

- Built `.zshrc` from scratch (not based on default template)
- PATH: added `~/.local/bin` (kitty, etc.), `~/helper_scripts` (personal scripts), and `~/.npm-global/bin` (claude code, etc.)
- Pyenv: set `PYENV_ROOT`, added to PATH, initialized shell integration and virtualenv management
- Plugins: load Antidote from `~/.antidote/antidote.zsh`, then `antidote load` (reads `~/.zsh_plugins.txt`)
- Prompt: initialized Starship with `starship init zsh`
- fzf: sourced key-bindings and completion from `/usr/share/doc/fzf/examples/`
- Vi mode: enabled with `bindkey -v`, reduced ESC delay to 0.1s (`KEYTIMEOUT=1`)
- Cursor shape: block cursor in normal mode, line cursor in insert mode (via `zle-keymap-select` and `zle-line-init`)
- Tab completion: initialized with `compinit`, enabled cache, case-insensitive matching, menu select highlight
- History: 10,000 lines, shared across sessions, no duplicates
- Ranger: set `RANGER_LOAD_DEFAULT_RC=FALSE` to prevent double-loading rc.conf
- Aliases: `mountlocal`/`umountlocal` for encrypted SSD (via systemd/crypttab), `mountnfs`/`umountnfs` for NFS shares, `keybindings` to open keybindings reference in nvim
- Startup: `cd /mnt/ssd2_data` on startup if mounted

## Kitty

Config file: `~/.config/kitty/kitty.conf`

- Font: JetBrainsMono Nerd Font (regular, bold, italic, bold italic), size 13.0
- Colors: Gruvbox Dark Hard theme (background `#1d2021`, foreground `#ebdbb2`, full 16-color palette)
- Window: remember size, initial 120×35 cols, padding 4px, decorations on
- Tabs: bar at bottom, powerline slanted style, `{index}: {title}` template, Gruvbox-matched active/inactive colors
- Splits: enabled `splits` and `stack` layouts, default `splits`
- Keybindings:

  - `Ctrl+Shift+T` — new tab
  - `Ctrl+Shift+Q` — close tab
  - `Ctrl+Shift+H` — vertical split
  - `Ctrl+Shift+B` — horizontal split
  - `Ctrl+Shift+W` — close window
  - `Ctrl+=` / `Ctrl+-` / `Ctrl+0` — font size increase/decrease/reset

- Startup: loads `startup.conf` session
- Misc: shell set to `/usr/bin/zsh`, Ctrl+click opens links, 10,000 scrollback lines, audio bell disabled
- `copy_on_select clipboard` — mouse selections automatically copy to system clipboard

## Starship

Config file: `~/.config/starship.toml`

- Format: 2-line prompt — info line then `❯` character on second line
- Modules: directory, git_branch, git_status, python (venv only), character
- Directory: Gruvbox yellow (`#fabd2f`), truncated to 3 levels, truncate to repo root, read-only lock icon
- Git branch: Nerd Font branch icon, Gruvbox green (`#8ec07c`)
- Git status: dirty/modified/untracked/staged/renamed/deleted all show `✗`, Gruvbox red (`#fb4934`); ahead/behind/diverged/stashed use arrow icons
- Python: shows virtualenv name only (no Python version), Gruvbox purple (`#d3869b`); detection disabled — only shows when venv is active
- Character: `❯` green on success (`#b8bb26`), red on error (`#fb4934`)
- Note: git and venv display not yet tested — no git repos or virtualenvs on this machine yet (see Pending in setup_tasks.md)

## Antidote

Config file: `~/.zsh_plugins.txt`

- Plugin list:
  - `zsh-users/zsh-autosuggestions`
  - `zsh-users/zsh-syntax-highlighting`

## Ranger

Config files: `~/.config/ranger/rc.conf`, `~/.config/ranger/rifle.conf`, `~/.config/ranger/colorschemes/gruvbox.py`

- View mode: `multipane` (Midnight Commander style, shows all tabs side by side)
- Colorscheme: `gruvbox` (custom `gruvbox.py` added to `colorschemes/`)
- Image preview: enabled, method set to `kitty`
- Keybinding: `<DELETE>` mapped to `trash-put` (moves to trash instead of permanent delete)
- `RANGER_LOAD_DEFAULT_RC=FALSE` set in `.zshrc` to avoid loading default rc.conf on top of custom one

## VS Code

Config files: `~/.config/Code/User/profiles/1565dd03/settings.json` (active profile), `~/.config/Code/User/keybindings.json`

Note: base `~/.config/Code/User/settings.json` is empty — all settings live in the matt profile.

- Extensions: VSCodeVim (vscodevim.vim), ms-python.black-formatter (+ Python, Pylance, debugpy)
- Settings:

  - `workbench.startupEditor`: `none`, `workbench.colorTheme`: `Gruvbox Dark Hard`
  - `update.showReleaseNotes`: `false`, `update.mode`: `none` (auto-update disabled)
  - `window.newWindowProfile`: `matt`
  - `application.shellEnvironmentResolutionTimeout`: `60`
  - Explorer: all confirmation dialogs off
  - Editor: inline suggest off, parameter hints off, auto-closing brackets/quotes off; Python: codeLens off, black formatter, tab size 4
  - Tab completion: acceptSuggestionOnEnter off, tabCompletion on, quickSuggestions configured, suggestSelection recentlyUsedByPrefix
  - Markdown: validation on, referenceLinks ignored, markdownlint rules configured (MD033/045/036/024), inline fold for links, language overrides
  - Formatting: per-language rules for json, python (black formatter)
  - Appearance: font JetBrains Mono Nerd Font, ruler at 88, minimap off, markdown H1 headings styled `#928374` bold (token color customization)
  - VIM: `vim.useSystemClipboard: true`; `vim.leader: " "` (Space); `d`/`x`/`c` standard vim (cut to clipboard); `<Space>d`/`D`/`x`/`X`/`c`/`C` → blackhole register in normal and visual mode
  - Git: autofetch on, count badge off, rebase on sync, action buttons hidden, no parent folder scanning
  - Jupyter: notebookFileRoot, askForKernelRestart, interactiveWindow codeLens/cellMarker/collapse settings
  - Project Manager: baseFolders set to `/mnt/ssd2_data/documents` and `/home/matt/dotfiles`
  - Spell check: cSpell.userWords with personal word list
  - Misc: vscode-pets forest theme, githubPullRequests quickDiff

- Keybindings:

  - `Shift+Enter` in terminal: sends `\` + newline (line continuation)

- File roles:

  - `nvim -R` in Kitty — read-only inspection
  - Sublime — single file quick edits
  - VS Code — projects and directories

- Terminal switching: Super+1 raises Kitty (GNOME-level, no VS Code config needed)
- Theme: Gruvbox Dark Hard, font JetBrains Mono Nerd Font

## Sublime Text

Config path: TBD

- Pending: match color palette to Gruvbox Dark Hard
- Note: titlebar removal is not possible on Wayland (investigated — no workaround exists; was X11-only)

## GNOME

Config: gsettings, `~/.config/user-dirs.dirs`

- Pending: set Gruvbox accent color

## Dotfiles repo

Repo: `~/dotfiles` → `https://github.com/burke-does-work/dotfiles` (public)

- `keybindings.md` — keybindings reference file, managed with vim-table-mode in Neovim
- `config/Code/keybindings.json` → `~/.config/Code/User/keybindings.json`
- `config/Code/profiles/1565dd03/settings.json` → `~/.config/Code/User/profiles/1565dd03/settings.json` (note: profile ID is machine-specific)
- SSH key: ed25519 at `~/.ssh/id_ed25519`, added to GitHub as "matt-9000"
- GitHub CLI (`gh`) installed and authenticated
- ssh-agent: GNOME Keyring manages the agent (`SSH_AUTH_SOCK=/run/user/1000/keyring/ssh`); key added with `ssh-add`, passphrase cached — no prompt required after login

## keybindings.md (updated)

- Universal section populated with high-impact vim motions (navigation, editing, search, visual mode)
- Leader key section added: `<Space>` as leader; `<Space>d`/`D`/`x`/`X`/`c`/`C` → blackhole (VS Code + Neovim only)
- VS Code section restructured with subsections: Global Navigation, Intellisense, Jupyter
- Zsh section: notes Wayland clipboard integration (yank/delete → clipboard, `p`/`P` ← clipboard)

## Neovim (updated)

Config file: `~/.config/nvim/init.lua`

- lazy.nvim bootstrapped (installs to `~/.local/share/nvim/lazy/`)
- Plugin: `dhruvasagar/vim-table-mode` — for managing markdown tables in `keybindings.md`
- `vim.opt.clipboard = "unnamedplus"` — links `y`/`p` to OS clipboard
- `vim.g.mapleader = " "` — Space as leader key; all leader bindings including vim-table-mode use `<Space>`
- `d`/`x`/`c` are standard vim (cut to clipboard via `unnamedplus`)
- `<Space>d`/`D`/`x`/`X`/`c`/`C` → blackhole register (`"_`) in normal and visual mode

## zsh (updated)

- Alias: `keybindings` — opens `~/dotfiles/keybindings.md` in nvim

## zsh (updated — Wayland clipboard integration)

- Installed `wl-clipboard` (`wl-copy`/`wl-paste`) for Wayland clipboard access
- `vi-yank` and `vi-yank-whole-line` wrapped to sync CUTBUFFER to system clipboard via `wl-copy` after each yank
- `vi-delete-char` (`x`) wrapped to sync to system clipboard (normal mode only via `$KEYMAP` check)
- `kill-whole-line` (`dd`) wrapped to sync to system clipboard
- `vi-put-after`/`vi-put-before` (`p`/`P`) wrapped to read from system clipboard via `wl-paste` before pasting
- `vi-backward-delete-char` intentionally NOT wrapped — shared with Backspace in insert mode, caused freezing

## Kitty (updated)

- Startup tab `keybindings` added — opens `~/dotfiles/keybindings.md` in nvim on launch

## pyenv

Config: `~/.pyenv/`

- Installed, managing Python 3.13.12
- Shell integration initialized in `.zshrc`
- Pending: create first virtual environment
