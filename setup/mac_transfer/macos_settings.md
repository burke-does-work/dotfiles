# macOS Setup — maodou-mac

Settled configuration for the current Mac. User-facing shortcuts live in
`../../keybindings.md`.

## Layer Model

| Layer | Tool | Scope |
| --- | --- | --- |
| Modifier and key remapping | Karabiner-Elements | Ctrl/Cmd swap, text nav, per-app rules |
| App launching and search | Raycast | Launcher, clipboard history, window search |
| Workspaces and layout | AeroSpace | Workspaces, tiling, directional focus |
| Terminal | Ghostty | Tabs, splits, terminal keybindings |
| Per-app bindings | App configs | VS Code, Claude Code, browser extensions |

Use System Settings only for OS preferences and rare app menu shortcuts.

## Karabiner-Elements

Config: `~/.config/karabiner` -> `config/karabiner`

Karabiner makes the keyboard behave closer to a Linux workstation while preserving
terminal behavior.

Active decisions:

- Left-side modifier remap: Fn -> Ctrl, Ctrl -> Fn, Cmd -> Option, Option -> Cmd.
- Ctrl/Cmd swap applies outside terminal apps.
- Ghostty and Terminal are excluded so `Ctrl+C` remains SIGINT.
- Linux-style text navigation is handled at the input layer.
- Caps Lock held is Hyper.
- `Cmd+Space` toggles English / Chinese input.
- `Cmd+Shift+S` runs screenshot selection to clipboard.
- VS Code and Chrome get a `Ctrl+Tab` rescue rule for tab navigation.

Symlink note: Karabiner needs a directory symlink because it rewrites files
atomically.

## Raycast

Raycast replaces Spotlight as the launcher.

Configured:

- Hotkey: `Option+Space`.
- Launch at login.
- Hidden from Dock.
- Unused extensions disabled.
- Clipboard History enabled.
- Switch Windows enabled on `Shift+Option+Space`.

Do not symlink Raycast preferences. The plist is managed by `cfprefsd` and is not
reliable as a dotfile.

## AeroSpace

Config: `~/.config/aerospace/aerospace.toml` -> `config/aerospace/aerospace.toml`

AeroSpace is the workspace and tiling system. macOS Spaces and Raycast Window
Management are not used for layout.

Configured:

- Workspaces for main, focus, communications, play, and blank contexts.
- Directional focus and window movement.
- App auto-assignment where useful.
- Mission Control shortcuts disabled.
- macOS reduced to one Space.

## Editors

VS Code participates in the Ctrl/Cmd swap. GUI-style custom bindings are written
for the post-swap event.

Neovim is the terminal editor and uses the system clipboard.

## macOS Preferences

Appearance:

- Dark mode.
- Solid black wallpaper.
- Dock auto-hidden with long hover delay.
- Window animations reduced.
- 24-hour clock with weekday.
- Battery percentage shown.

Typing:

- Key repeat max.
- Delay until repeat min.
- Autocorrect off.
- Smart quotes and dashes off.
- Press-and-hold disabled for VS Code.

Trackpad:

- Tap to click off.
- Natural scroll on.
- Two-finger right-click on.
- Three-finger drag on.

Sound and power:

- Alert volume 0.
- UI sounds off.
- Power chime off.
- AC power does not sleep.
- Battery sleeps after 30 minutes.
- Display dim and ambient light sensor off.

Privacy and security:

- Analytics off.
- Personalized ads off.
- Crash reporter dialogs disabled.
- DNS set manually.
- Firewall on.
- FileVault on.

iCloud and Apple features:

- Apple ID signed in for App Store.
- iCloud services off except Find My.
- Siri, Apple Intelligence, Handoff, AirPlay Receiver, Stage Manager, Screen Time,
  Game Center, and AirDrop disabled.
- Spotlight indexing disabled.
- Notification Center widgets removed.

Finder:

- File extensions shown.
- Path bar and status bar shown.
- Column view default.
- Tags removed from sidebar.

Sharing:

- Screen Sharing, File Sharing, Remote Login, Remote Management, Bluetooth Sharing,
  Internet Sharing, Printer Sharing, and Content Caching off.

## Mac-Specific Tools

- AppCleaner is used for manually installed app removal.
- Menubar is kept minimal.
- Backup work remains in `tasks_outstanding.md`.

## Future Considerations

- Hyper tap-for-Escape.
- Raycast snippets and quicklinks.
