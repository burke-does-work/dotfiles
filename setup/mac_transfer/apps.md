# Apps — maodou-mac

Current app inventory and install notes. Completed migration checklist details are
archived.

## CLI Tools

Installed with Homebrew unless noted:

- `git`
- `gh`
- `ripgrep`
- `fd`
- `fzf`
- `zoxide`
- `unar`
- `ffmpegthumbnailer`
- `imagemagick`
- `trash`
- `antidote`
- `starship`
- `yazi`
- `neovim`
- `node`

Notes:

- Homebrew Apple Silicon path is `/opt/homebrew/bin`.
- `trash` is keg-only and needs `/opt/homebrew/opt/trash/bin` in PATH.
- macOS uses `trash <file>`, not Linux `trash-put`.

## GUI Apps

Installed with Homebrew casks unless noted:

- Ghostty
- CommitMono Nerd Font
- JetBrains Mono Nerd Font
- Visual Studio Code
- Sublime Text
- Google Chrome
- VLC
- draw.io
- Proton VPN
- qBittorrent
- 1Password
- Signal
- Zoom
- Google Drive
- Adobe Creative Cloud

Special cases:

- `nicotine-plus` is installed as a formula or from upstream, not a cask.
- Microsoft Excel is deferred until needed.
- Lightroom is installed from inside Adobe Creative Cloud.

## Special Installs

- Claude Code: `npm install -g @anthropic-ai/claude-code`
- Chinese input: built-in Pinyin - Simplified

## Browser Extensions

- Vimium
- 1Password
- Simple New Tab URL, or equivalent blank-tab behavior

## Raycast

Raycast is the launcher and window search tool.

Configured:

- Launch at login.
- Hidden from Dock.
- Spotlight shortcut disabled.
- Unused default extensions disabled.
- Clipboard History enabled.
- Switch Windows enabled.

AeroSpace handles workspaces and tiling, so Raycast Window Management bindings are
not part of the current workflow.

## Adobe Creative Cloud

After installing Lightroom, harden Creative Cloud:

- Launch at login off.
- Auto-updates off.
- Notifications off.
- File sync off.

Installer cleanup:

```bash
sudo rm /Library/LaunchDaemons/com.adobe.acc.installer.v2.plist
```

Verify:

```bash
ls ~/Library/LaunchAgents | grep -i adobe
ls /Library/LaunchDaemons | grep -i adobe
```
