[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Mac Transfer Tasks — maodou-mac

Steps marked **(Claude)** mean ask Claude to do the work. All others you do yourself.

### Reference files

- `apps.md` — install checklist; open it when a phase says to install apps
- `files.md` — what to copy from matt-9000; fill in and refer to during Phases 0–1 and 13
- `macos_settings.md` — full settings checklist; started in Phase 2, completed in Phase 5

---

## Phase 0 — Prep (before Mac arrives)

- ✅ → `files.md`: fill in the ssd2_data section — list what you're copying to USB
- ✅ Gather USB drive, format as exFAT
  - Note: after formatting with `parted` on Linux, must set GPT partition type to `0700` (Microsoft Basic Data) with `sudo sgdisk --typecode=1:0700 /dev/sdX` — otherwise macOS sees "Linux Filesystem" and refuses to mount

---

## Phase 1 — File transfer (on matt-9000)

- ✅ Mount `/mnt/ssd2_data`
- ✅ → `files.md`: copy everything marked `[mac]` or `[both]` to USB

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

### Dotfiles — clone (required for VS Code and Claude config)

- ✅ Clone via HTTPS (SSH not set up yet): `git clone https://github.com/burke-does-work/dotfiles.git ~/dotfiles`
- ✅ Verify: `ls ~/dotfiles`
  - Note: Phase 11 will switch the remote to SSH after keys are configured

### Chrome

- ✅ `brew install --cask google-chrome`
- ✅ Open Chrome → sign in to Google account (syncs bookmarks and history)
  - Note: I don't sign into Google in Chrome.
- ✅ Set as default browser when prompted, or: System Settings → Desktop & Dock → Default web browser → Google Chrome
- ✅ Install extensions:
  - ✅ Vimium
  - ✅ 1Password
  - ✅ Simple New Tab URL (or set new tab to blank)

### VS Code

- ✅ `brew install --cask visual-studio-code`
- ✅ Symlink global settings: `ln -sf /Users/matt/dotfiles/config/Code/global/settings.json "/Users/matt/Library/Application Support/Code/User/settings.json"`
- ✅ Symlink global keybindings: `ln -sf /Users/matt/dotfiles/config/Code/global/keybindings.json "/Users/matt/Library/Application Support/Code/User/keybindings.json"`
- ✅ Create "matt" profile in VS Code (profile ID: `-2716422f`), symlink profile config:
  - `ln -sf /Users/matt/dotfiles/config/Code/matt-profile/settings.json "/Users/matt/Library/Application Support/Code/User/profiles/-2716422f/settings.json"`
  - `ln -sf /Users/matt/dotfiles/config/Code/matt-profile/keybindings.json "/Users/matt/Library/Application Support/Code/User/profiles/-2716422f/keybindings.json"`
- ✅ Install extensions: VSCodeVim, Python, Pylance, Black Formatter, ms-python.debugpy
- ✅ Verify: VIM mode, Gruvbox theme

### Claude Code

- ✅ `brew install node`
- ✅ `npm install -g @anthropic-ai/claude-code`
- ✅ Launch `claude` — enter API key when prompted
- ✅ Mac Claude settings created: `config/claude/settings.mac.json`
- ✅ Symlink: `ln -sf /Users/matt/dotfiles/config/claude/settings.mac.json /Users/matt/.claude/settings.json`
- ✅ Linux Claude settings symlinked to dotfiles: `ln -sf /home/matt/dotfiles/config/claude/settings.json /home/matt/.claude/settings.json`
- ✅ Global CLAUDE.md symlinked: `ln -sf /Users/matt/dotfiles/config/claude/CLAUDE.md /Users/matt/.claude/CLAUDE.md` (Linux: same with `/home/matt/dotfiles/...`)

### Files from USB

- ✅ Copy any projects or files you need to start working from the Mac

*You can now work from the Mac. Resume the checklist below when ready.*

---

## Phase 5 — Terminal

- ✅ `brew install --cask ghostty`
- ✅ `brew install --cask font-jetbrains-mono-nerd-font`
- 🔲 Configure Ghostty — review built-in keybindings before overriding; port from Kitty config intentionally **(Claude)**
- 🔲 Update `keybindings.md` — Ghostty section **(Claude)**

---

## Phase 6 — Complete macOS settings

- 🔲 → `macos_settings.md`: resume from where Phase 2 paused — work through every remaining section
- 🔲 Update `keybindings.md` — macOS OS-level bindings **(Claude)**
- Remove press and hold keys (breaks VIM keybindings): `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`

---

## Phase 7 — Shell

- ✅ `brew install antidote starship fzf zoxide`
- ✅ Dotfiles already cloned in Phase 4
- 🔲 Create Mac `zshrc` **(Claude)** — adapts from Linux: pbcopy/pbpaste clipboard, Homebrew PATH, NFS mount aliases; removes wl-clipboard, GNOME aliases, ssd2_data startup cd; include `export PATH="/opt/homebrew/opt/trash/bin:$PATH"` (`trash` is keg-only)
- 🔲 Test: open new shell, verify starship prompt, fzf (`Ctrl+R`), zoxide (`z`)

---

## Phase 8 — CLI tools

- 🔲 → `apps.md` — CLI tools section: install everything (batch brew install command) **(Claude)**
- 🔲 Verify: `git --version`, `gh --version`, `rg --version`, `yazi --version`
- 🔲 Symlink Yazi config **(Claude)**; update Yazi trash binding: `trash-put` → `trash`

---

## Phase 9 — Python

- 🔲 `brew install pyenv` (init already included in Mac zshrc from Phase 7)
- 🔲 `pyenv install 3.13 && pyenv global 3.13`
- 🔲 Verify: `python --version` shows pyenv 3.13, not system Python

---

## Phase 10 — Editors

### VS Code — complete setup

- 🔲 Global and profile symlinks created in Phase 4
- 🔲 Verify: clipboard, blackhole register bindings
- 🔲 Update `keybindings.md` — any Mac-specific VS Code bindings **(Claude)**

### Neovim

- 🔲 `brew install neovim`
- 🔲 `ln -s ~/dotfiles/config/nvim ~/.config/nvim`
- 🔲 Open nvim — lazy.nvim bootstraps and installs vim-table-mode automatically
- 🔲 Verify clipboard (`"+p`, leader bindings)

### Sublime Text

- 🔲 `brew install --cask sublime-text`
- 🔲 Copy from USB: `Preferences.sublime-settings` and `Package Control.sublime-settings` → `~/Library/Application Support/Sublime Text/Packages/User/`
- 🔲 Launch Sublime — Package Control will auto-install MarkdownEditing

---

## Phase 11 — SSH

- 🔲 `ssh-keygen -t ed25519 -C "maodou-mac"`
- 🔲 `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
- 🔲 Add to `~/.ssh/config`: `UseKeychain yes` and `AddKeysToAgent yes`
- 🔲 `gh auth login` (needed to add SSH key to GitHub)
- 🔲 `gh ssh-key add ~/.ssh/id_ed25519.pub --title "maodou-mac"`
- 🔲 Switch dotfiles remote to SSH: `git remote set-url origin git@github.com:burke-does-work/dotfiles.git`
- 🔲 Add maodou-mac host entry to `ssh/config` in dotfiles **(Claude)**
- 🔲 Test: `ssh pickle-pi`

---

## Phase 12 — NFS

- 🔲 `sudo mkdir -p /mnt/nfs/drive_data /mnt/nfs/hdd_data`
- 🔲 Add NFS mount aliases to Mac zshrc **(Claude)**
- 🔲 Test: mount both shares, verify read/write

---

## Phase 13 — Files from USB — complete

- 🔲 → `files.md` — destination paths: copy all remaining `[mac]` and `[both]` items
- 🔲 Nicotine+ config: copy to `~/Library/Application Support/Nicotine+/`; update all `/home/matt/` paths to `/Users/matt/`
- 🔲 Add `~/.gitconfig` to dotfiles repo and symlink **(Claude)**
- 🔲 Symlink gh config: `mkdir -p ~/.config/gh && ln -s ~/dotfiles/config/gh/config.yml ~/.config/gh/config.yml`
  - Update `git_protocol` in `config/gh/config.yml` from `https` to `ssh` **(Claude)**
- 🔲 Verify key files, keep USB until fully confirmed

---

## Phase 14 — GUI apps

- 🔲 → `apps.md` — GUI apps section: install remaining apps with `brew install --cask`
- 🔲 Signal: link to phone
- 🔲 Google Sheets: open in Chrome → address bar → Save and share → Add to Dock
- 🔲 1Password: set up
- 🔲 Nicotine+: open and verify config loaded correctly, confirm download paths
- 🔲 Adobe Creative Cloud → install Lightroom
- 🔲 Claude Code settings adapted and symlinked in Phase 4
- 🔲 Set up Claude Code Google MCP integration **(Claude)**

---

## Phase 15 — Backup

- 🔲 SSH to pickle-pi: install and configure `netatalk` for Time Machine over network **(Claude)**
- 🔲 Restrict openclaw's access to the backup directory on pickle-pi
- 🔲 Mac: System Settings → General → Time Machine → Add backup disk → select pickle-pi share
- 🔲 Verify first backup runs
- 🔲 Add USB drive as second Time Machine disk for local redundancy

---

## Phase 16 — Mac enhancements

→ `apps.md` — Mac enhancements section: install and configure any tools you decided on.

- 🔲 Window tiling tool (if decided)
- 🔲 Launcher (if decided)
- 🔲 Window switcher (if decided)
- 🔲 System monitor (if decided)
- 🔲 Menubar management (if decided)

---

## Phase 17 — keybindings.md final review

- 🔲 → `keybindings.md`: open in nvim, review every section against what's actually on maodou-mac
- 🔲 Remove or annotate Linux-only bindings
- 🔲 Add anything missed **(Claude)**

---

## Phase 18 — Cleanup matt-9000

Do this only after confirming maodou-mac is fully working.

- 🔲 Verify all needed files are on Mac or pickle-pi
- 🔲 Revoke matt-9000 SSH key from GitHub
- 🔲 Remove secrets and credentials that shouldn't persist on matt-9000
- 🔲 Decide matt-9000's ongoing network role
