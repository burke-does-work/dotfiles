[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Install Checklist — maodou-mac

Check off as you install. See `tasks.md` for when each phase happens.


Add Claude, ChatGPT desktop, Apple mail, proton

---

## CLI tools — `brew install`

- ✅ `git`
- ✅ `gh`
- ✅ `ripgrep`
- ✅ `fd`
- ✅ `fzf`
- ✅ `zoxide`
- ✅ `unar`
- ✅ `ffmpegthumbnailer`
- ✅ `imagemagick`
- ✅ `trash` — replaces Linux `trash-cli`; command is `trash <file>`, not `trash-put`; keg-only (not auto-linked) — requires PATH entry in zshrc
- ✅ `antidote`
- ✅ `starship`
- ✅ `yazi`
- ✅ `neovim`
- ✅ `node`

---

## GUI apps — `brew install --cask`

- ✅ `ghostty`
- ✅ `font-commit-mono-nerd-font` — current default font (replaces JetBrains Mono Nerd Font)
- ✅ `font-jetbrains-mono-nerd-font`
- ✅ `visual-studio-code`
- ✅ `sublime-text`
- ✅ `google-chrome`
- ✅ `vlc`
- ✅ `drawio`
- ✅ `nicotine-plus` — not available as cask; install via formula (`brew install nicotine-plus`, GTK4) or download from nicotine-plus.org
- ✅ `protonvpn`
- ✅ `qbittorrent` — deprecated in Homebrew; Gatekeeper issue, will be disabled 2026-09-01
- ✅ `1password`
- ✅ `signal`
- ✅ `zoom`
- ✅ `google-drive`
- ✅ `microsoft-excel` — consider if necessary. **decision**: wait until it's needed
- ✅ `adobe-creative-cloud` — install Lightroom CC only from within Creative Cloud; see Adobe hardening notes below

---

## Special installs

- ✅ Claude Code: `npm install -g @anthropic-ai/claude-code`
- ✅ Chinese input: System Settings → Keyboard → Input Sources → add Pinyin - Simplified; install `squirrel` via Homebrew if the built-in is insufficient

To install apps from an unknown developer (wtv that means), follow these directions:

[Open a Mac app from an unknown developer](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unknown-developer-mh40616/mac)

--

## Browser extensions (Chrome)

- ✅ Vimium
- ✅ 1Password
- ✅ Simple New Tab URL (or set blank new tab)

---

## Finding and browsing installed apps

- `brew list --cask` — GUI apps installed via Homebrew
- `brew list --formula` — CLI tools installed via Homebrew
- This file (`apps.md`) — source of truth for everything else (npm installs, manual downloads)
- `/Applications` in Finder — actual file system; matches `ls /Applications` in terminal
- **Launchpad** (4-finger pinch) — visual overview of all apps, equivalent to GNOME Super grid; good for occasionally browsing or auditing installed apps. Not a file system view — includes Adobe's app catalogue (available-to-install apps), which clutters it
- **Raycast** — power user launcher; replaces the need to visually browse apps day-to-day

---

## Raycast configuration

Initial setup done. Return to this section to complete configuration.

### Core settings

- ✅ Preferences → General → Hotkey → **(decide)** — to use `Cmd+Space`, disable Spotlight first: search "Spotlight" → uncheck "Show Spotlight search"
- ✅ Preferences → Advanced → "Hide Raycast in Dock" → On
- ✅ Launch at login → On (needed — this is your app launcher)

### Reduce bloat
- ✅ Preferences → Extensions → disable everything you won't use — defaults include many you won't need (GIF Search, Emoji Search, Confetti, etc.)

### Power user features to configure
- ✅ **Clipboard History** — enable and set a hotkey; replaces needing a separate clipboard manager
- ✅ **Window Management** — enabled; replaces macOS native tiling. Setup in `macos_settings.md`.

---

## Adobe Creative Cloud hardening

- ✅ Setup Adobe

Adobe installs to `/Applications/Utilities`, not `/Applications` — it won't appear in a normal `ls /Applications`.

After installing Lightroom, harden Creative Cloud in Preferences:
- Launch at login → Off
- Auto-updates → Off
- Notifications → Off
- File sync → Off (this is CC Files folder sync, separate from Lightroom photo sync — photo sync still works)

Then remove the installer daemon that CC leaves behind:
```
sudo rm /Library/LaunchDaemons/com.adobe.acc.installer.v2.plist
```

Verify clean:
```
ls ~/Library/LaunchAgents | grep -i adobe
ls /Library/LaunchDaemons | grep -i adobe
```

---

## Notes

- Homebrew Apple Silicon path: `/opt/homebrew/bin/` — must be in PATH
- `trash` syntax differs from Linux: `trash <file>`, not `trash-put <file>` — Yazi config updated in Phase 6
- `trash` is keg-only — must add `export PATH="/opt/homebrew/opt/trash/bin:$PATH"` to Mac zshrc (Phase 7); without it `trash` command is not found
- `wl-clipboard` has no place on Mac — zshrc clipboard integration rewritten with `pbcopy`/`pbpaste` in Phase 5
- Google Docs and Sheets: web-only via Chrome
