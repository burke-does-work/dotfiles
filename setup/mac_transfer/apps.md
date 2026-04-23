[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Install Checklist — maodou-mac

Check off as you install. See `tasks.md` for when each phase happens.

---

## CLI tools — `brew install`

- 🔲 `git`
- 🔲 `gh`
- 🔲 `ripgrep`
- 🔲 `fd`
- 🔲 `fzf`
- 🔲 `zoxide`
- 🔲 `unar`
- 🔲 `ffmpegthumbnailer`
- 🔲 `imagemagick`
- 🔲 `trash` — replaces Linux `trash-cli`; command is `trash <file>`, not `trash-put`
- 🔲 `antidote`
- 🔲 `starship`
- 🔲 `yazi`
- 🔲 `neovim`
- 🔲 `node`

---

## GUI apps — `brew install --cask`

- 🔲 `ghostty`
- 🔲 `font-jetbrains-mono-nerd-font`
- 🔲 `visual-studio-code`
- 🔲 `sublime-text`
- 🔲 `google-chrome`
- 🔲 `vlc`
- 🔲 `drawio`
- 🔲 `nicotine-plus`
- 🔲 `protonvpn`
- 🔲 `qbittorrent`
- 🔲 `1password`
- 🔲 `signal`
- 🔲 `zoom`
- 🔲 `google-drive`
- 🔲 `microsoft-excel` — requires Microsoft 365 subscription; confirm before installing
- 🔲 `adobe-creative-cloud` — then install Lightroom from within Creative Cloud

---

## Special installs

- 🔲 Claude Code: `npm install -g @anthropic-ai/claude-code`
- 🔲 Python 3.13: `pyenv install 3.13 && pyenv global 3.13` (after pyenv is installed)
- 🔲 Chinese input: System Settings → Keyboard → Input Sources → add Pinyin - Simplified; install `squirrel` via Homebrew if the built-in is insufficient

---

## Browser extensions (Chrome)

- 🔲 Vimium
- 🔲 1Password
- 🔲 Simple New Tab URL (or set blank new tab)

---

## Mac enhancements — decide and install

These have no Linux equivalent. Decide before Phase 14.

### Window tiling

macOS has no built-in tiling. Without a tool, managing windows is cumbersome.

- Example (free): Rectangle — `brew install --cask rectangle`
- Note: Raycast (below) includes window management; may cover this

- 🔲 **(decide)** ___

### Launcher

Replaces or augments Spotlight. Adds clipboard history, snippets, extensible actions.

- Example (free): Raycast — `brew install --cask raycast`

- 🔲 **(decide)** ___

### Window switcher

`Cmd+Tab` switches apps, not windows. Useful if you run multiple windows of the same app.

- Example (free): AltTab — `brew install --cask alt-tab`

- 🔲 **(decide)** ___

### System monitor

Menubar CPU, RAM, network display.

- Example (free): Stats — `brew install --cask stats`

- 🔲 **(decide)** ___

### Menubar management

Once apps accumulate, the menubar gets cluttered. macOS Sequoia has some native management — evaluate that first.

- 🔲 **(decide)** ___

### Backup

- ✅ Strategy: Time Machine → pickle-pi (primary), USB drive (interim/redundancy)
  - Restrict openclaw access on pickle-pi when backup directory is created

---

## Notes

- Homebrew Apple Silicon path: `/opt/homebrew/bin/` — must be in PATH
- `trash` syntax differs from Linux: `trash <file>`, not `trash-put <file>` — Yazi config updated in Phase 6
- `wl-clipboard` has no place on Mac — zshrc clipboard integration rewritten with `pbcopy`/`pbpaste` in Phase 5
- Google Docs and Sheets: web-only via Chrome
