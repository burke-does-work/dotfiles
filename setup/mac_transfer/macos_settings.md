# macOS Setup — maodou-mac

## The Stack

Each layer handles a distinct scope. Don't route things through the wrong layer.

| Layer                      | Tool                | Scope                                        |
| -------------------------- | ------------------- | -------------------------------------------- |
| Modifier + key remapping   | Karabiner-Elements  | Ctrl ↔ Cmd swap, text nav, per-app rules     |
| App launching / switching  | Raycast             | Global hotkeys, app raise, window search     |
| Workspaces + window layout | AeroSpace           | Workspace switching, tiling, focus direction |
| Screenshots + app menus    | System Settings     | Screenshot shortcuts, named menu items       |
| Terminal                   | Ghostty config      | Splits, panes, nav                           |
| Per-app keybindings        | App-specific config | VS Code, browser extensions                  |

Work through sections in order. Each depends on the previous.

*Only use System Settings for: (1) screenshot shortcuts, (2) assigning shortcuts to named app menu items. Input method switching is in Karabiner. Spaces are managed by AeroSpace — macOS Spaces not used.*

User-facing key bindings live in `keybindings.md`. This file documents how each layer is configured plus the OS preferences that aren't input-related.

Thinking

- Remove tabli, use raycast windows with named Chrome windows (name Chrome windows by right clicking on the menu bar)
- Use the aerospace extension in raycast to switch between windows within the workspace
- Jump to workspace, then use raycast window switcher
- Within VS Code, use project manager (also can test using raycast window switcher)
- SketchyBar is significant effort to setup

---

## Karabiner-Elements

*What it does: intercepts key events at the kernel level, before the OS processes anything. All modifier remapping and key rules live here — one layer, no ordering ambiguity with System Settings.*

Installed. Config at `~/.config/karabiner/karabiner.json` (symlinked to dotfiles).

### Why

Mac defaults to `Cmd` as the primary modifier; Linux uses `Ctrl`. Most CLI tools, tmux, vim-style bindings, and cross-platform apps already speak `Ctrl` — fighting that on Mac with `Cmd` muscle memory creates a split-brain problem specifically in the terminal where you live.

The fix: remap the Mac to behave like Linux. The physical layout matches (`Ctrl | Fn | Super | Alt | Space`), and a two-way `Ctrl ↔ Cmd` swap at the modifier-key level means every `Cmd`-prefixed shortcut (clipboard, save, find, new tab, …) is reachable from the bottom-left `Ctrl` key. Excluded apps: `com.apple.Terminal`, `com.mitchellh.ghostty` — there `Ctrl+C` stays as SIGINT and `Ctrl+A` stays as readline line-start. VS Code participates in the swap, so its custom GUI-style keybindings are written as `Cmd` bindings.

### Decision: full modifier swap over per-binding remaps

The original rule was per-binding: explicit entries for `Ctrl+C/V/X/A → Cmd+C/V/X/A`. That works for a fixed set but doesn't generalize — every additional shortcut (`Ctrl+S`, `Ctrl+T`, `Ctrl+L`, `Ctrl+W`, …) needs another rule. Swapping `left_control` and `left_command` at the modifier level covers every Ctrl-prefix and Cmd-prefix combo, current and future, with one rule. Per-app exclusion still works the same way.

Karabiner over per-app rebinding still holds: most apps don't expose keybindings (System dialogs, Raycast, web apps inside Chrome). Karabiner remaps once at the input layer and covers them all. Per-app rebinding is reserved for app-specific shortcuts (e.g., VS Code's command palette) where there's no universal convention.

### Physical layout (left side, after remapping)

| Physical key       | Sends    | Role                                           |
| ------------------ | -------- | ---------------------------------------------- |
| `Fn` (bottom-left) | `Ctrl`   | Primary modifier — clipboard, etc.             |
| `Ctrl`             | `Fn`     | macOS function key — brightness, volume, Globe |
| `Cmd`              | `Option` | Alt — modifier-key adjacent to space           |
| `Option`           | `Cmd`    | Super — Raycast, system shortcuts              |

Right side of spacebar is unchanged.

### Naming convention

Throughout the rest of these docs, key names refer to what's *sent* after the swap — think of it as a sticker placed on top of each key. So `Cmd+S` means "the key now labeled Cmd" (physically the outer `Option` key), `Ctrl+C` means "the key now labeled Ctrl" (physically `Fn`). You don't need to think about the original Mac labels.

The one exception is `karabiner.json` itself — that file uses original physical names because it sees keys *before* the swap.

### Active rules

Defined in `config/karabiner/karabiner.json`:

- **Simple modifications** — swap `Fn`↔`Ctrl` and `Cmd`↔`Option` on the left side
- **Complex modification — Ctrl+Tab rescue** — in VS Code and Chrome, stickered `Ctrl+Tab` / `Ctrl+Shift+Tab` is rescued before macOS app-switcher handling and delivered as real `Ctrl+Tab` / `Ctrl+Shift+Tab` for tab navigation. Add future apps only after testing shows they need the same rescue.
- **Complex modification — app switcher neutralizer** — real `Cmd+Tab` / `Cmd+Shift+Tab` is sent to `vk_none` so the unused macOS app switcher does not appear.
- **Complex modification — Ctrl ↔ Cmd swap** — two-way swap of the `left_control` and `left_command` modifier keys, excluding `com.apple.Terminal` and `com.mitchellh.ghostty`. In any non-terminal app, including VS Code, the bottom-left `Ctrl` key acts as `Cmd` and the outer-left `Cmd` key acts as `Ctrl`. Subsumes the earlier per-binding `Ctrl+C/V/X/A` rule and covers every other Ctrl- and Cmd-prefixed shortcut at once.
- **Complex modification — Linux text nav** — `Home/End` → `Cmd+←/→` (line), `Shift+Home/End` → `Cmd+Shift+←/→` (select line), `Ctrl+Home/End` → `Cmd+↑/↓` (document), `Ctrl+←/→` → `Option+←/→` (word), `Ctrl+Shift+←/→` → `Option+Shift+←/→` (select word). Excludes `com.apple.Terminal` and `com.mitchellh.ghostty` (not VS Code — Linux text nav is wanted there). Works in both Cocoa and Electron apps since translation happens at the input layer. Note: in apps where the Ctrl↔Cmd swap is *also* active, the Ctrl-prefix arrow nav is reached from the outer-left key (which now signals `Ctrl`); the bottom-left key signals `Cmd` and produces Mac-native line/document nav directly.
- **Complex modification — Caps Lock → Hyper** — Caps Lock held = `Cmd+Option+Ctrl+Shift` (the Hyper chord). Tap-for-Escape (common practice for VIM users) is deferred for now.
- **Complex modification — Cmd+Space → toggle input method (English ↔ Chinese Pinyin)** — Uses `select_input_source` with a `input_chinese` variable to toggle — no macOS shortcut settings required. Variable can go out of sync if input is switched via menu bar; press twice to re-sync. Four manipulators: 2 app contexts (terminal/non-terminal) × 2 toggle states.
- **Complex modification — Cmd+Shift+S → screenshot to clipboard** — Runs `screencapture -i -c` via `shell_command` — no macOS shortcut settings required. Works in Ghostty because Karabiner intercepts before the terminal sees the event.

### Symlink note

`~/.config/karabiner` is a *directory* symlink, not a file symlink — Karabiner writes atomically and breaks file-level symlinks. `automatic_backups/` inside the directory is gitignored.

#### Tasks

- ✅ Configure Karabiner rules
- ✅ Symlink: `ln -s /Users/matt/local/dotfiles/config/karabiner /Users/matt/.config/karabiner`
- ✅ Verify: copy/paste in TextEdit, SIGINT in Ghostty
- ✅ Verify (Ctrl↔Cmd swap): in Chrome, `Ctrl+T` opens new tab, `Ctrl+L` focuses URL, `Ctrl+W` closes tab; in Ghostty, `Ctrl+C` still SIGINTs; in VS Code, `Ctrl+Shift+P` opens command palette via the post-swap `Cmd+Shift+P` binding
- ✅ Verify `Cmd+Space` toggles input method in Chrome and Ghostty (no macOS settings step needed).
- ✅ Verify `Cmd+Shift+S` takes screenshot in Chrome and Ghostty (no macOS settings step needed). If `screencapture -i -c` shows the toolbar instead of going straight to crosshair selection, adjust the flag.

#### Text editing — verify

Karabiner's "Linux text nav" rule handles text navigation. After Karabiner reloads:

- ✅ TextEdit: `Home`/`End` jump to line start/end; `Shift+Home/End` extends selection
- ✅ TextEdit: `Ctrl+←/→` moves by word; `Ctrl+Shift+←/→` extends word selection
- ✅ VS Code: same shortcuts work (Electron apps now covered too)
- ✅ Ghostty: word/line shortcuts pass through unchanged (terminal excluded from rule); shell handles its own bindings

**Do not use Cmd+Option+Space or Ctrl+Option+Space for any shortcuts.** "Ctrl+Option+Space" → Karabiner outputs Cmd+Option+Space → macOS Spotlight "Find in Finder" intercepts it
- "Cmd+Option+Space" → Karabiner outputs Ctrl+Option+Space → macOS accessibility features intercept it

Note: VS Code now participates in the Ctrl↔Cmd swap. GUI-style VS Code shortcuts should be written as `Cmd` bindings, matching the post-swap event that VS Code receives. High-value VSCodeVim Ctrl chords (`Ctrl+u/d`, `Ctrl+r`, `Ctrl+v` visual block) are restored to stickered `Ctrl` in VS Code keybindings.

---

## Raycast

*What it does: replaces Spotlight; handles app launching and search via global hotkeys. Window management moved to AeroSpace.*

Installed and configured — Spotlight shortcut unbound, Raycast hotkey set to `Option+Space`.

#### App switcher

- ✅ Skipped — don't use the OS app switcher on any platform.

#### App hotkeys

Find the app in Raycast search → `Cmd+K` → Set Hotkey.

- ✅ Assign hotkeys to core apps (Ghostty, browser, editor) - PASS: `Super+1/2/3` doesn't work because it's swapped in Ghostty

#### Window Management

- ✅ Removed — AeroSpace handles all workspace switching, tiling, and focus. Remove any previously bound Raycast Window Management hotkeys (Maximize, tile commands, Move Window to Desktop).
- ✅ Keep: Search open windows (`Shift+Option+Space`)

#### Plist note

Don't symlink Raycast's config. The plist (`~/Library/Preferences/com.raycast.macos.plist`) is managed by `cfprefsd`, which caches and rewrites the inode — symlinks there are unreliable. Use Export/Import (or Raycast Pro Cloud Sync) instead.

---

## AeroSpace

*What it does: tiling WM with its own workspace model — replaces macOS Spaces and Raycast Window Management entirely. Workspaces switch instantly with no macOS animation. Electron apps cannot intercept bindings.*

- ✅ Initial confg

  Install: `brew install --cask aerospace`

  Config: `~/.config/aerospace/aerospace.toml` (symlinked to dotfiles)

  - Install AeroSpace: `brew install --cask aerospace`
  - Symlink config: `mkdir -p ~/.config/aerospace && ln -s ~/local/dotfiles/config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml`
  - Grant Accessibility permission: System Settings → Privacy & Security → Accessibility → AeroSpace → On
  - Reduce macOS to 1 Space: open Mission Control, delete extra spaces
  - Disable Mission Control keyboard shortcuts: System Settings → Keyboard → Keyboard Shortcuts → Mission Control → uncheck all (AeroSpace replaces them)
  - Remove Raycast Window Management bindings: Raycast → Extensions → Window Management → remove hotkeys for Maximize, tile commands, Move Window to Desktop

### Setup tasks

- ✅ Reload config and verify app auto-assignments (open each app, confirm it lands on the right workspace)
- ✅ Verify bundle IDs for: ChatGPT, Claude desktop, Signal, WhatsApp, Proton Mail — run `osascript -e 'id of app "AppName"'` for each; update `aerospace.toml` if wrong
- ✅ Set up Raycast Switch Windows: Raycast Settings → Extensions → Window Management → Switch Windows → enable and assign hotkey. Used to navigate Chrome windows across workspaces.

---

## System Settings (app menus only)

The only things left in System Settings: rare per-app menu-item overrides. Input method is handled by Karabiner. Spaces are managed by AeroSpace. Screenshot shortcut is handled by Karabiner (`screencapture -i -c`).

#### macOS Spaces cleanup

- ✅ Reduce to 1 Space (AeroSpace manages its own workspaces — macOS Spaces unused)
- ✅ Disable all Mission Control shortcuts: System Settings → Keyboard → Keyboard Shortcuts → Mission Control → uncheck Switch Space left/right, Mission Control overview, Show desktop

---

## Per-app keybinding overrides

Reserved for app-specific shortcuts that don't have a universal convention.

### VS Code

- VS Code participates in the Ctrl↔Cmd swap, so custom GUI-style bindings are written for the post-swap event (`Cmd+Shift+P` command palette, `Cmd+Shift+B` sidebar). Linux text-nav rule still applies, so `Ctrl+←/→` does word nav from the key that sends real Control.
- Stickered `Ctrl+Tab` / `Ctrl+Shift+Tab` is rescued in Karabiner and delivered to VS Code as real `Ctrl+Tab` / `Ctrl+Shift+Tab` for editor/panel tab navigation.
- Stickered `Ctrl+1..9` direct editor selection is handled in VS Code keybindings as post-swap `Cmd+1..9`, not in Karabiner.
- ✅ Audit conflicts: `Cmd+←/→` is line nav on Mac; check if it clashes with Space switching
- ✅ VS Code has its own keybinding layer (`keybindings.json`) — edit via `Cmd+Shift+P` → "Open Keyboard Shortcuts (JSON)"

---

## macOS preferences

Non-input OS settings. All ✅ unless marked otherwise.

#### Appearance

- ✅ Dark mode
- ✅ Wallpaper: solid black
- ✅ Dock: auto-hidden with long hover delay (`autohide-delay 1000`)
- ✅ Dock icon bouncing: disabled (`defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock`)
- ✅ Window animations: disabled
- ✅ Clock: 24h with weekday
- ✅ Battery percentage: shown
- ✅ Display: scaled resolution set

#### Typing

- ✅ Key repeat rate: max
- ✅ Delay until repeat: min
- ✅ Autocorrect: off
- ✅ Smart quotes and dashes: off
- ✅ Chinese Pinyin input: added
- ✅ Press-and-hold disabled in VS Code (breaks VIM): `defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false`

#### Modifier / function keys

- ✅ F1–F12: standard function keys
- ✅ Volume keys: `Fn + F*` for all top-row function keys (no remap needed)

#### Trackpad

- ✅ Tap to click: off
- ✅ Natural scroll: on
- ✅ Two-finger right-click: on
- ✅ Three-finger drag: on

#### Sound

- ✅ Alert volume: 0
- ✅ UI sounds: off
- ✅ Power chime: off — `defaults write com.apple.PowerChime ChimeOnNoHardware -bool true && killall PowerChime`

#### Power

- ✅ AC power: never sleep
- ✅ Battery: sleep after 30 min
- ✅ Display dim: off
- ✅ Ambient light sensor: off

#### Privacy

- ✅ Analytics: off
- ✅ Personalised Ads: off
- ✅ Crash reporter dialogs: disabled
- ✅ DNS: switched to Quad9 (`9.9.9.9` / `149.112.112.112`)

#### Security

- ✅ Firewall: on
- ✅ FileVault: on

#### iCloud

- ✅ Signed in to Apple ID (App Store access only)
- ✅ All iCloud services off except Find My

#### Finder

- ✅ Show all file extensions: on
- ✅ Path bar: shown
- ✅ Status bar: shown
- ✅ Default view: column
- ✅ Tags: removed from sidebar

#### System cleanup

- ✅ Karabiner-Elements: installed, permissions approved
- ✅ Spotlight indexing disabled (`sudo mdutil -a -i off`)
- ✅ Spotlight shortcut unbound
- ✅ Siri: off
- ✅ Apple Intelligence: off
- ✅ Handoff: off
- ✅ Continuity Camera: off
- ✅ AirPlay Receiver: off
- ✅ Stage Manager: off
- ✅ Screen Time: off
- ✅ Game Center: off
- ✅ Hot corners: all disabled
- ✅ AirDrop: No One
- ✅ Notification Center widgets: removed

#### Sharing services — all off

- ✅ Screen Sharing
- ✅ File Sharing
- ✅ Remote Login
- ✅ Remote Management
- ✅ Bluetooth Sharing
- ✅ Internet Sharing
- ✅ Printer Sharing
- ✅ Content Caching

---

## Mac enhancements

Tooling decisions for Mac-specific jobs that have no Linux equivalent. Most are settled — entries kept here as a record. Install commands live alongside the choice; full configuration for Raycast/Window Management is in the Raycast section above.

### Window tiling

- ✅ Using AeroSpace — see AeroSpace section above for setup. macOS Sequoia native tiling, Rectangle, and Raycast Window Management all tested and abandoned (Electron apps intercept native Fill keystroke; Raycast WM had no workspace-switching capability). AeroSpace uses its own workspace model, bypasses Electron interception entirely.

### Launcher

- ✅ Raycast — `brew install --cask raycast`; initial setup in `apps.md` Raycast configuration section.

### Window switcher

- ✅ Skipped — don't use the app/window switcher on any OS. Workflow uses Raycast app hotkeys + AeroSpace workspaces instead.

### App uninstaller

AppCleaner removes apps along with their associated preference files, caches, and support files. Always use it instead of right-clicking and moving to trash — trash leaves behind config files and caches. Use for manually-installed apps only — App Store apps should be removed via Launchpad.

- ✅ `brew install --cask appcleaner`
- ✅ Went through all of `/Applications` — removed everything possible. Remaining apps are locked Apple system apps that cannot be uninstalled without disabling SIP; not worth doing.

### Menubar management

- ✅ Clean-up menu bar after app installation.

### Backup

- See `tasks.md` Phase 14 — Time Machine to pickle-pi (primary) + USB drive (redundancy).

---

## Future Consideration

Ideas parked deliberately — not forgotten, just not now.

### Hyper Key tap-for-Escape

Karabiner-Elements can do tap=Escape / hold=Hyper simultaneously, so there's no trade-off with the current Caps Lock → Escape setup. Worth revisiting if hotkey conflicts become a problem.

### Raycast

- Explore extensions. Lots of good ones.
- **Snippets** — text expansion for frequently typed strings
- **Quicklinks** — saved URLs opened by name; useful for frequently visited pages
