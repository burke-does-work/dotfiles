# Apps — maodou-mac

Current app inventory and install notes. Completed migration checklist details are
archived.

## CLI Tools

Installed with Homebrew unless noted:

- `git`
- `gh`
- `pandoc`
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

- uv (Python manager): `curl -LsSf https://astral.sh/uv/install.sh | sh`, then symlink `config/uv/uv.toml` → `~/.config/uv/uv.toml`
- SSH: symlink `ssh/config` → `~/.ssh/config`; create `~/.ssh/multiplex/`; add key to agent with `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`; add GitHub host key with `ssh-keyscan github.com >> ~/.ssh/known_hosts`
- Claude Code: `npm install -g @anthropic-ai/claude-code`
- Chinese input: built-in Pinyin - Simplified

## Symlinks

Config files in this repo are symlinked into the locations each tool expects. Run
these after cloning. Repo root is assumed to be `~/local/dotfiles`.

Shell:

```bash
ln -sf ~/local/dotfiles/config/zsh/zshrc_maodou-mac ~/.zshrc
ln -sf ~/local/dotfiles/config/zsh/zsh_plugins.txt ~/.zsh_plugins.txt
```

Git:

```bash
ln -sf ~/local/dotfiles/config/git/gitconfig ~/.gitconfig
```

`~/.config/` apps (directory symlinks for tools that rewrite files atomically):

```bash
ln -sf ~/local/dotfiles/config/nvim ~/.config/nvim
ln -sf ~/local/dotfiles/config/ghostty ~/.config/ghostty
ln -sf ~/local/dotfiles/config/karabiner ~/.config/karabiner
ln -sf ~/local/dotfiles/config/yazi ~/.config/yazi
```

`~/.config/` apps (file symlinks):

```bash
ln -sf ~/local/dotfiles/config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/local/dotfiles/config/gh/config.yml ~/.config/gh/config.yml
ln -sf ~/local/dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/local/dotfiles/config/uv/uv.toml ~/.config/uv/uv.toml
```

VS Code — global (Default profile):

```bash
ln -sf ~/local/dotfiles/config/Code/global/settings.json \
  "$HOME/Library/Application Support/Code/User/settings.json"
ln -sf ~/local/dotfiles/config/Code/global/keybindings.json \
  "$HOME/Library/Application Support/Code/User/keybindings.json"
```

VS Code — active profile (profile ID is machine-specific; find yours in
`~/Library/Application Support/Code/User/profiles/`):

```bash
VSCODE_PROFILE="$HOME/Library/Application Support/Code/User/profiles/-2716422f"
ln -sf ~/local/dotfiles/config/Code/matt-profile/settings.json "$VSCODE_PROFILE/settings.json"
ln -sf ~/local/dotfiles/config/Code/matt-profile/keybindings.json "$VSCODE_PROFILE/keybindings.json"
```

Claude Code:

```bash
ln -sf ~/local/dotfiles/config/claude/settings.json ~/.claude/settings.json
ln -sf ~/local/dotfiles/config/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/local/documents/global_workflows/AGENTS.md ~/.claude/AGENTS.md
ln -sf ~/local/dotfiles/config/claude/keybindings.json ~/.claude/keybindings.json
```

Codex:

```bash
ln -sf ~/local/dotfiles/config/codex/config.toml ~/.codex/config.toml
mkdir -p ~/.agents
ln -sfn ~/local/documents/global_workflows/skills ~/.agents/skills
```

SSH:

```bash
ln -sf ~/local/dotfiles/ssh/config ~/.ssh/config
```

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
