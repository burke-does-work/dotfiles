# Mac Transfer Tasks — maodou-mac

Historical completed-task log. Current setup status lives in
`../tasks_outstanding.md` and the current references linked from `../../../README.md`.

## High Priority - Remaining

### `git`

- ✅ Add `~/.gitconfig` to dotfiles repo and symlink **(Claude)**
- ✅ Symlink gh config: `mkdir -p ~/.config/gh && ln -s ~/local/dotfiles/config/gh/config.yml ~/.config/gh/config.yml`
  - Update `git_protocol` in `config/gh/config.yml` from `https` to `ssh` **(Claude)**

### Ghostty

- ✅ Configure Ghostty — keybindings audit (Kitty pattern vs. Ghostty Cmd defaults; opinionated overrides if any) **(Claude)**
  - ✅ Update `keybindings.md` — Ghostty section, after audit lands **(Claude)**
  - ✅ Switch so that tab selection is `Ctrl+1..9`

Config: `~/.config/ghostty/config` *(already ported)*

- ✅ **Do this before using the terminal.** Ghostty is excluded from the Ctrl↔Cmd swap and the Linux text-nav rule, so `Ctrl+C` keeps SIGINT in the terminal and Ctrl-prefixed bindings pass through to the shell unchanged. `Cmd`-based shortcuts (copy, splits) work as the ported config defines.
- ✅ Verify SIGINT: `Ctrl+C` interrupts a running process
- ✅ Update Claude Code keybindings — Claude is a text-based app but runs in Ghostty (excluded from the Ctrl↔Cmd swap), so its default Ctrl-prefixed bindings don't match the bottom-left = Cmd ergonomics used elsewhere. Audit and adjust in `config/claude/settings.mac.json`.

### Yazi

- ✅ Symlink Yazi config **(Claude)**; trash binding already uses `remove` built-in (macOS-native, no `trash-put` override needed)

### VS Code / Text editors

- ✅ Set nvim or subl as the default text editor for single file open

  * Installed duti to manage macOS file associations from the terminal
  * Accidentally associated generic Unix executables with Sublime
  * Preserved terminal behavior for scripts/executables (.sh, .command)
  * Set Sublime Text as the default GUI app for normal text/code files (.txt, .md, .json, etc.)
  * Kept nvim as the terminal editor via $EDITOR / $VISUAL separation from macOS GUI defaults

## Phase 0 — Prep (before Mac arrives)

- ✅ Gather USB drive, format as exFAT
  - Note: after formatting with `parted` on Linux, must set GPT partition type to `0700` (Microsoft Basic Data) with `sudo sgdisk --typecode=1:0700 /dev/sdX` — otherwise macOS sees "Linux Filesystem" and refuses to mount

---

## Phase 1 — File transfer (on matt-9000)

- ✅ Mount `/mnt/ssd2_data`
- ✅ Copy everything marked `[mac]` or `[both]` to USB

---

## Phase 2 — macOS initial setup

- ✅ Setup wizard: Apple ID, region — skip iCloud, Siri, analytics
  - Note: Apple ID being reset — return to later
- ✅ Computer name: System Settings → General → About → Name: `maodou-mac`
- ✅ Hostname: `sudo scutil --set HostName maodou-mac && sudo scutil --set LocalHostName maodou-mac && sudo scutil --set ComputerName maodou-mac`
- ✅ FileVault: System Settings → Privacy & Security → FileVault → On

---

## Phase 3 — Homebrew

- ✅ Install: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- ✅ Follow post-install instructions to add `/opt/homebrew/bin` to PATH
- ✅ Verify: `brew doctor`

---

## Phase 4 — Immediate working setup

Get to a working state on the Mac. Do this before continuing the full checklist.

### Directory structure

- ✅ Create local data directory: `mkdir -p ~/local`
- ✅ Verify: `ls ~`
- Note: `~` is config only; `~/local` is for all actual files (projects, documents, media) — mirrors the Linux two-drive split on a single drive
- Note: default macOS home folders (`Movies`, `Music`, `Public`) cannot be deleted — SIP (System Integrity Protection) blocks it even with `sudo`. Leave them empty and ignore them.

Specifics:

- `/mnt/ssd2_data/` → `~/local/` — all actual files (documents, projects, media)
- `~/` config files → `~/` (same structure, path changes from `/home/matt/` to `/Users/matt/`)
- `/mnt/nfs/drive_data/` → NFS mount from pickle-pi (Phase 11)
- `/mnt/nfs/hdd_data/` → NFS mount from pickle-pi (Phase 11)

### Dotfiles — clone (required for VS Code and Claude config)

- ✅ Clone via HTTPS (SSH not set up yet): `git clone https://github.com/burke-does-work/dotfiles.git ~/local/dotfiles`
- ✅ Verify: `ls ~/local/dotfiles`
  - Note: Phase 10 will switch the remote to SSH after keys are configured

### Chrome

Install and extensions: → `apps.md`

- ✅ Set as default browser: System Settings → Desktop & Dock → Default web browser → Google Chrome

### VS Code

Install: → `apps.md`

- ✅ Symlink global settings: `ln -sf /Users/matt/local/dotfiles/config/Code/global/settings.json "/Users/matt/Library/Application Support/Code/User/settings.json"`
- ✅ Symlink global keybindings: `ln -sf /Users/matt/local/dotfiles/config/Code/global/keybindings.json "/Users/matt/Library/Application Support/Code/User/keybindings.json"`
- ✅ Create "matt" profile in VS Code (profile ID: `-2716422f`), symlink profile config:
  - `ln -sf /Users/matt/local/dotfiles/config/Code/matt-profile/settings.json "/Users/matt/Library/Application Support/Code/User/profiles/-2716422f/settings.json"`
  - `ln -sf /Users/matt/local/dotfiles/config/Code/matt-profile/keybindings.json "/Users/matt/Library/Application Support/Code/User/profiles/-2716422f/keybindings.json"`
- ✅ Install extensions: VSCodeVim, Python, Pylance, Black Formatter, ms-python.debugpy
- ✅ Verify: VIM mode, Gruvbox theme

### Claude Code

Install: → `apps.md`

- ✅ Launch `claude` — enter API key when prompted
- ✅ Mac Claude settings created: `config/claude/settings.mac.json`
- ✅ Symlink: `ln -sf /Users/matt/local/dotfiles/config/claude/settings.mac.json /Users/matt/.claude/settings.json`
- ✅ Linux Claude settings symlinked to dotfiles: `ln -sf /home/matt/dotfiles/config/claude/settings.json /home/matt/.claude/settings.json`
- ✅ Global CLAUDE.md symlinked: `ln -sf /Users/matt/local/dotfiles/config/claude/CLAUDE.md /Users/matt/.claude/CLAUDE.md` (Linux: same with `/home/matt/dotfiles/...`)

### Files from USB

- ✅ Copy any projects or files you need to start working from the Mac

*You can now work from the Mac. Resume the checklist below when ready.*

---

## Phase 5 — Terminal

Install: → `apps.md`

- ✅ Set Ghostty font: `font-family = CommitMono Nerd Font`, `font-feature = calt`
- ✅ Configure Ghostty — theme, window padding, titlebar style (tabs), unfocused-split fill, confirm-close-surface; placeholder keybind for `prompt_tab_title`

---

## Phase 6 — Complete macOS settings

- ✅ Remove press and hold keys (breaks VIM keybindings): `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`

---

## Phase 7 — Shell

Install: → `apps.md`

- ✅ Dotfiles already cloned in Phase 4
- ✅ Create Mac `zshrc` **(Claude)** — adapts from Linux: pbcopy/pbpaste clipboard, Homebrew PATH, Homebrew antidote source path; removes wl-clipboard, GNOME aliases, ssd2_data startup cd, pyenv block; includes `export PATH="/opt/homebrew/opt/trash/bin:$PATH"` (`trash` is keg-only). NFS aliases deferred to Phase 11.
- ✅ Symlinks: `ln -s /Users/matt/local/dotfiles/zshrc_maodou-mac ~/.zshrc` and `ln -s /Users/matt/local/dotfiles/zsh_plugins.txt ~/.zsh_plugins.txt`
- ✅ Test: open new shell, verify starship prompt, fzf (`Ctrl+R`), zoxide (`z`)

---

## Phase 8 — CLI tools

- ✅ → `apps.md` — CLI tools section: install everything (batch brew install command) **(Claude)**
- ✅ Verify: `git --version`, `gh --version`, `rg --version`, `yazi --version`

---

## Phase 9 — Editors

### VS Code — complete setup

- ✅ Global and profile symlinks created in Phase 4
- ✅ Verify: clipboard, blackhole register bindings
- ✅ Update `keybindings.md` — any Mac-specific VS Code bindings **(Claude)**

### Neovim

Install: → `apps.md`

- ✅ `ln -s ~/local/dotfiles/config/nvim ~/.config/nvim`
- ✅ Open nvim — lazy.nvim bootstraps and installs vim-table-mode automatically
- ✅ Verify clipboard (`"+p`, leader bindings)

### Sublime Text

Install: → `apps.md`

- ✅ Launch Sublime, install package control, then Gruvbox and MarkdownEditing
