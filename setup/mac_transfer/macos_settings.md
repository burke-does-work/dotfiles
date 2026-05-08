# macOS Setup — maodou-mac

## The Stack

Each layer handles a distinct scope. Don't route things through the wrong layer.

| Layer | Tool | Scope |
|---|---|---|
| Modifier + key remapping | Karabiner-Elements | Ctrl ↔ Cmd swap, text nav, per-app rules |
| App launching / switching | Raycast | Global hotkeys, app raise |
| Window management | Raycast Window Management | Snap, resize, move, maximize |
| Mission Control + app menus | System Settings | Spaces, named menu items |
| Terminal | Ghostty config | Splits, panes, nav |
| Per-app keybindings | App-specific config | VS Code, browser extensions |
| Scripted automation | Hammerspoon | Future — install when needed |

Work through sections in order. Each depends on the previous.

*Only use System Settings for: (1) Mission Control / Spaces shortcuts, (2) assigning shortcuts to named app menu items. Everything else is handled by the stack above.*

User-facing key bindings live in `keybindings.md`. This file documents how each layer is configured plus the OS preferences that aren't input-related.

---

## Karabiner-Elements

*What it does: intercepts key events at the kernel level, before the OS processes anything. All modifier remapping and key rules live here — one layer, no ordering ambiguity with System Settings.*

Installed. Config at `~/.config/karabiner/karabiner.json` (symlinked to dotfiles).

#### Why

Mac defaults to `Cmd` as the primary modifier; Linux uses `Ctrl`. Most CLI tools, tmux, vim-style bindings, and cross-platform apps already speak `Ctrl` — fighting that on Mac with `Cmd` muscle memory creates a split-brain problem specifically in the terminal where you live.

The fix: remap the Mac to behave like Linux. The physical layout matches (`Ctrl | Fn | Super | Alt | Space`), and a two-way `Ctrl ↔ Cmd` swap at the modifier-key level means every `Cmd`-prefixed shortcut (clipboard, save, find, new tab, …) is reachable from the bottom-left `Ctrl` key. Excluded apps: `com.apple.Terminal`, `com.mitchellh.ghostty`, `com.microsoft.VSCode` — there `Ctrl+C` stays as SIGINT, `Ctrl+A` stays as readline line-start, and VS Code's Ctrl-prefixed bindings pass through unchanged.

#### Decision: full modifier swap over per-binding remaps

The original rule was per-binding: explicit entries for `Ctrl+C/V/X/A → Cmd+C/V/X/A`. That works for a fixed set but doesn't generalize — every additional shortcut (`Ctrl+S`, `Ctrl+T`, `Ctrl+L`, `Ctrl+W`, …) needs another rule. Swapping `left_control` and `left_command` at the modifier level covers every Ctrl-prefix and Cmd-prefix combo, current and future, with one rule. Per-app exclusion still works the same way.

Karabiner over per-app rebinding still holds: most apps don't expose keybindings (System dialogs, Raycast, web apps inside Chrome). Karabiner remaps once at the input layer and covers them all. Per-app rebinding is reserved for app-specific shortcuts (e.g., VS Code's command palette) where there's no universal convention.

#### Physical layout (left side, after remapping)

| Physical key | Sends | Role |
|---|---|---|
| `Fn` (bottom-left) | `Ctrl` | Primary modifier — clipboard, etc. |
| `Ctrl` | `Fn` | macOS function key — brightness, volume, Globe |
| `Cmd` | `Option` | Alt — modifier-key adjacent to space |
| `Option` | `Cmd` | Super — Raycast, system shortcuts |

Right side of spacebar is unchanged.

##### Naming convention

Throughout the rest of these docs, key names refer to what's *sent* after the swap — think of it as a sticker placed on top of each key. So `Cmd+S` means "the key now labeled Cmd" (physically the outer `Option` key), `Ctrl+C` means "the key now labeled Ctrl" (physically `Fn`). You don't need to think about the original Mac labels.

The one exception is `karabiner.json` itself — that file uses original physical names because it sees keys *before* the swap.

#### Active rules

Defined in `config/karabiner/karabiner.json`:

- **Simple modifications** — swap `Fn`↔`Ctrl` and `Cmd`↔`Option` on the left side
- **Complex modification — Ctrl ↔ Cmd swap** — two-way swap of the `left_control` and `left_command` modifier keys, excluding `com.apple.Terminal`, `com.mitchellh.ghostty`, and `com.microsoft.VSCode`. In any non-excluded app, the bottom-left `Ctrl` key acts as `Cmd` and the outer-left `Cmd` key acts as `Ctrl`. Subsumes the earlier per-binding `Ctrl+C/V/X/A` rule and covers every other Ctrl- and Cmd-prefixed shortcut at once.
- **Complex modification — Linux text nav** — `Home/End` → `Cmd+←/→` (line), `Shift+Home/End` → `Cmd+Shift+←/→` (select line), `Ctrl+Home/End` → `Cmd+↑/↓` (document), `Ctrl+←/→` → `Option+←/→` (word), `Ctrl+Shift+←/→` → `Option+Shift+←/→` (select word). Excludes `com.apple.Terminal` and `com.mitchellh.ghostty` (not VS Code — Linux text nav is wanted there). Works in both Cocoa and Electron apps since translation happens at the input layer. Note: in apps where the Ctrl↔Cmd swap is *also* active, the Ctrl-prefix arrow nav is reached from the outer-left key (which now signals `Ctrl`); the bottom-left key signals `Cmd` and produces Mac-native line/document nav directly.
- **Complex modification — Caps Lock → Hyper** — Caps Lock held = `Cmd+Option+Ctrl+Shift` (the Hyper chord). Tap-for-Escape (common practice for VIM users) is deferred for now.

#### Symlink note

`~/.config/karabiner` is a *directory* symlink, not a file symlink — Karabiner writes atomically and breaks file-level symlinks. `automatic_backups/` inside the directory is gitignored.

#### Tasks

- ✅ Configure Karabiner rules
- ✅ Symlink: `ln -s /Users/matt/local/dotfiles/config/karabiner /Users/matt/.config/karabiner`
- ✅ Verify: copy/paste in TextEdit, SIGINT in Ghostty
- 🔲 Verify (Ctrl↔Cmd swap): in Chrome, `Ctrl+T` opens new tab, `Ctrl+L` focuses URL, `Ctrl+W` closes tab; in Ghostty, `Ctrl+C` still SIGINTs; in VS Code, `Ctrl+P` opens command palette (no remap)

#### Text editing — verify

Karabiner's "Linux text nav" rule handles text navigation. After Karabiner reloads:

- ✅ TextEdit: `Home`/`End` jump to line start/end; `Shift+Home/End` extends selection
- ✅ TextEdit: `Ctrl+←/→` moves by word; `Ctrl+Shift+←/→` extends word selection
- ✅ VS Code: same shortcuts work (Electron apps now covered too)
- ✅ Ghostty: word/line shortcuts pass through unchanged (terminal excluded from rule); shell handles its own bindings

---

## Raycast

*What it does: replaces Spotlight; handles app launching and window management via global hotkeys.*

Installed and configured — Spotlight shortcut unbound, Raycast hotkey set to `Option+Space`.

#### App switcher

*What it does: equivalent of `alt-tab`*

- ✅ Skipped — don't use the OS app switcher on any platform.

#### App hotkeys

Find the app in Raycast search → `Cmd+K` → Set Hotkey.

- ✅ Assign hotkeys to core apps (Ghostty, browser, editor)

#### Window Management

Why Raycast and not macOS native: Electron apps (VS Code) intercept the macOS Fill keystroke and route it to fullscreen instead of resizing the window. Raycast's Window Management uses the Accessibility API and works uniformly across all apps. Rectangle also tested and uninstalled — Raycast covers the same ground without adding to the stack. Native macOS Fill is intentionally left unbound.

Set bindings via Raycast → Extensions → Window Management → command → Set Hotkey. Bindings listed in `keybindings.md`.

- ✅ Maximize bound (`Ctrl+Cmd+Shift+↑`)
- ✅ Move Window to Next/Previous Desktop bound
- ✅ Tile commands bound (halves, quarters as needed)

Why these key choices:

- **`Ctrl+Cmd+Shift+↑` for Maximize:** fits the tile-direction family (3-modifier chord + arrow); arrow direction reads as "make bigger toward the top." Conflict-free with the text-nav rule and app shortcuts.
- **`Cmd+Option+Shift+arrow` for moving windows between Spaces:** mnemonic — "Spaces switch chord + Shift = drag the window with you." Avoids the bottom-left-corner-key gamble that Ctrl-containing chords have.

#### Plist note

Don't symlink Raycast's config. The plist (`~/Library/Preferences/com.raycast.macos.plist`) is managed by `cfprefsd`, which caches and rewrites the inode — symlinks there are unreliable. Use Export/Import (or Raycast Pro Cloud Sync) instead.

---

## System Settings (Mission Control & app menus)

The only things to set in System Settings: Mission Control / Spaces shortcuts, and (rare) per-app menu-item overrides. Mission Control sucks so I set the shortcut but use keyboard shortcuts to switch spaces, then mouse in Mission Control as a backup.

#### Mission Control / Spaces shortcuts

Set via System Settings → Keyboard → Keyboard Shortcuts → Mission Control. Bindings listed in `keybindings.md`.

- ✅ Switch Space left/right
- ✅ Mission Control overview — rebound from default `Ctrl+↑` to `Cmd+Option+↑`
- ✅ Show desktop

Why these key choices:

- **`Cmd+Option+arrow` for Spaces:** matches Linux `Alt+Super+arrow` muscle memory (Mac `Cmd` = Linux `Super`, Mac `Option` = Linux `Alt`); doesn't conflict with the text-nav rule.
- **`Cmd+Option+↑` for Mission Control:** the macOS default `Ctrl+↑` is awkward to reach after the Ctrl↔Cmd swap (the only Ctrl-signal key is now the outer-left `Cmd` key). `Cmd+Option+↑` mirrors the Spaces switch family (`Cmd+Option+←/→`) and keeps the bottom-left + arrow ergonomic pattern. The simpler `Cmd+↑` was considered but rejected — it shadows Cocoa "go to start of document", Finder's "go to enclosing folder", and browser scroll-to-top. Set in System Settings → Keyboard → Keyboard Shortcuts → Mission Control.

#### Spaces behaviour

System Settings → Desktop & Dock → Mission Control:

- ✅ Automatically rearrange Spaces → Off (Spaces will reorder otherwise)
- ✅ Number of Spaces: set to 2 *(open Mission Control → click + to add)*
- ✅ Group windows by application → decide when you get here

---

## Ghostty (terminal)

Config: `~/.config/ghostty/config` *(already ported)*

- 🔲 **Do this before using the terminal.** Ghostty is excluded from the Ctrl↔Cmd swap and the Linux text-nav rule, so `Ctrl+C` keeps SIGINT in the terminal and Ctrl-prefixed bindings pass through to the shell unchanged. `Cmd`-based shortcuts (copy, splits) work as the ported config defines.
- 🔲 Verify SIGINT: `Ctrl+C` interrupts a running process
- 🔲 Verify clipboard: `Cmd+C` copies selected text to clipboard
- 🔲 Verify splits: `Cmd+D` / `Cmd+Shift+D` — check against ported config

---

## Per-app keybinding overrides

Reserved for app-specific shortcuts that don't have a universal convention.

### VS Code

- VS Code is excluded from the Ctrl↔Cmd swap (`com.microsoft.VSCode`) so its own Ctrl-prefixed bindings (e.g., `Ctrl+P` command palette, `Ctrl+B` sidebar) pass through unchanged. Linux text-nav rule still applies, so `Ctrl+←/→` does word nav.
- 🔲 Enable Settings Sync (if using) to pull Linux keybindings
- 🔲 Audit conflicts: `Cmd+←/→` is line nav on Mac; check if it clashes with Space switching
- 🔲 VS Code has its own keybinding layer (`keybindings.json`) — edit via `Cmd+Shift+P` → "Open Keyboard Shortcuts (JSON)"

### Chrome

- ✅ Tabli (or alternative) installed for tab management

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

- ✅ Using Raycast Window Management — see Raycast > Window Management above for setup. macOS Sequoia native tiling and Rectangle both tested and abandoned (Electron apps intercept the native Fill keystroke).

### Launcher

- ✅ Raycast — `brew install --cask raycast`; initial setup in `apps.md` Raycast configuration section.

### Window switcher

- ✅ Skipped — don't use the app/window switcher on any OS. Workflow uses Raycast launching + Spaces + window-raise hotkeys instead.

### System monitor

Menubar CPU, RAM, network display.

- Example (free): Stats — `brew install --cask stats`
- Or Linux style CLI tools enough (e.g. `htop`)

- 🔲 **(decide)** ___

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

### Hammerspoon

Listed in the stack as the scripted-automation layer; install only when a need arises. Karabiner + Raycast cover everything so far.

### Hyper Key tap-for-Escape

Karabiner-Elements can do tap=Escape / hold=Hyper simultaneously, so there's no trade-off with the current Caps Lock → Escape setup. Worth revisiting if hotkey conflicts become a problem.

### Raycast

- Explore extensions. Lots of good ones.
- **Snippets** — text expansion for frequently typed strings
- **Quicklinks** — saved URLs opened by name; useful for frequently visited pages