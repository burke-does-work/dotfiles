# macOS Interface Settings — maodou-mac

Historical draft. Current macOS settings live in `../macos_settings.md`.

Work through each section during Phase 2 of the transfer. Most settings live in System Settings unless noted. Items marked **(known)** reflect confirmed preferences from dconf. Items marked **(decide)** need a choice.

## Keyboard

### System-level shortcuts

- 🔲 System Settings → Keyboard → Keyboard Shortcuts. Work through each category. Map to Linux equivalents where possible; use Raycast, Hammerspoon for anything macOS can't do natively, or consider Karabiner-Elements. 

#### Screenshots

- 🔲 Region screenshot: macOS default `Cmd+Shift+4` — Linux was `Shift+Super+S`; close enough, no remap needed

#### Mission Control / Spaces

Replaces GNOME workspaces.

- 🔲 Switch Space left: macOS default `Ctrl+←` — Linux was `Alt+Super+←`; decide whether to adapt or remap
- 🔲 Switch Space right: macOS default `Ctrl+→` — same
- 🔲 Move window to Space left: no macOS default — **(decide)** assign via Keyboard Shortcuts → Mission Control
- 🔲 Move window to Space right: no macOS default — **(decide)** assign via Keyboard Shortcuts → Mission Control
- 🔲 Show desktop: Linux was `Super+M` — **(decide)** assign or leave unmapped

#### Volume

- 🔲 Volume up/down: Linux was `Ctrl+Super+↑/↓` → macOS uses F11/F12 (when F-keys are media keys) or `Fn+F11/F12` (when F-keys are standard) — **(decide)** whether to replicate the Linux combo or adapt to Mac convention

#### App switcher

- 🔲 App switcher current Space only: Linux was `current-workspace-only=true` — macOS Cmd+Tab shows all Spaces by default; AltTab app supports current-Space-only if this matters enough

- 🔲 Shortcut to switch input sources: macOS default is `Ctrl+Space`; conflicts with many tools — come back only if conflicts arise

### Per-app shortcuts

After the system layer is done, configure shortcuts inside each app.

#### Raising apps — global shortcuts

On Linux, `Super+1` raised Kitty at the GNOME level. macOS has no native equivalent; use Raycast.

- 🔲 Raycast: Extensions → assign a global shortcut to launch/raise Ghostty — **(decide)** `Cmd+1`, `Option+\``, or similar
- 🔲 **(optional)** Hammerspoon: use if Raycast's window-raising isn't enough; requires a small Lua config

#### Ghostty

- 🔲 Review Ghostty config at `~/.config/ghostty/config` — already ported from Linux
- 🔲 **(decide)** any Mac-specific key conflicts (e.g., `Cmd` vs `Ctrl` for Ghostty-internal shortcuts)

#### VS Code

- 🔲 Port keybindings from Linux or sync via Settings Sync
- 🔲 **(decide)** resolve any Mac-specific conflicts (e.g., `Cmd+←/→` for line nav vs workspace switching)

#### Raycast

- 🔲 Review extensions and assign per-extension shortcuts as needed

#### Chrome

- Additional Vimium settings & shortcuts
- **(decide)** return to Tabli or similar

#### Other apps

- 🔲 Handle per-app as apps are installed; flag shortcuts that conflict with system-level bindings

#### Spotlight / launcher

- ✅ Disable Spotlight shortcut: Keyboard Shortcuts → Spotlight → uncheck `Cmd+Space`
- ✅ Set Raycast to `Cmd+Space` or `Option+Space` in Raycast → Settings → General

#### Siri

- ✅ All Siri shortcuts already disabled

### Typing behaviour

Do this before anything else so key repeat is in effect during all subsequent configuration.

- ✅ Key repeat rate: search "Key Repeat" → Key Repeat Rate → Fast (maximum)
- ✅ Delay until repeat: search "Key Repeat" → Delay Until Repeat → Short (minimum)
- ✅ Disable autocorrect: search "Text Input" → Edit → turn off each:
  - Correct spelling automatically
  - Capitalise words automatically
  - Add full stop with double-space
  - Use smart quotes and dashes
- ✅ Add Chinese input: search "Input Sources" → Edit → add Pinyin - Simplified

### Modifier keys and function keys

- ✅ F1–F12 as standard function keys
- ✅ Set caps Lock: remap to Escape (useful for vim) or leave as Caps Lock
  - Note: no changes to caps lock (already used to Escape for Vim) but consider for "hyper key"

### Window Management

One app, full screen by default. No tiling, no multiple simultaneous windows — intentional focus discipline.

Exceptions:
- Two windows side by side for direct comparison
- Second monitor as a dedicated visualisation display during data analysis

Tooling verdict:
- macOS Sequoia native window snapping covers the side-by-side case — evaluate before installing anything additional
- Rectangle available if native snapping keybinding support is insufficient
- yabai ruled out — tiling WM conflicts with single-focus workflow

🔲 Review and add Sequoia default keybindings for windows layout to `keybindings.md` 
🔲 **(decide)** - what is the equivalent to hitting `super` on Linux to see and select open apps? Does this just switch to Raycast?

---

## Mission Control and Spaces

Spaces is the Mac desktop layer equivalent of GNOME/i3 workspaces — accepted as-is, not fought.

- 🔲 Number of Spaces: 2 **(known: `num-workspaces=2` on Linux)**
- 🔲 search "Mission Control" → Automatically rearrange Spaces based on most recent use → Off — otherwise Spaces reorder and become unpredictable
- 🔲 Group windows by application → **(decide)**
- 🔲 App switcher shows current Space only: **(known: `current-workspace-only=true` on Linux)** — **(decide)** how to replicate; not a direct macOS setting but AltTab (if installed) supports this

---

## Screen lock

- ✅ Require password after sleep: **(known: lock disabled on Linux — `lock-enabled=false`)** → set to your preference; search "Lock Screen"
- ✅ Screen saver: Off — search "Screen Saver" → Never

---

## Power and sleep

- ✅ On AC power: display sleep → system sleep → Never **(known: `sleep-inactive-ac-type='nothing'` on Linux)**; search "Battery"
- ✅ On battery: system sleep after 30 minutes **(known: `sleep-inactive-battery-timeout=1800` on Linux)**
- ✅ Dim display: Off **(known: `idle-dim=false` on Linux)**; search "display brightness"
- ✅ Ambient light sensor: Off **(known: `ambient-enabled=false` on Linux)**

---

## Sound

- ✅ search "Sound" → Sound Effects → Alert volume → 0, Play user interface sound effects → Off **(known: `event-sounds=false` on Linux)**

---

## Security

- ✅ Firewall: search "Firewall" → On

Reminder: Must approve Homebrew cask installs in settings. This is a Mac security measure, search "Privacy & Security"

---

## Privacy and telemetry

- ✅ search "Analytics":
  - Share Mac Analytics → Off
  - Improve Siri & Dictation → Off
  - Share with App Developers → Off
  - Share iCloud Analytics → Off
- ✅ search "Advertising" → Personalised Ads → Off
- ✅ search "Location Services" → review per-app; disable for anything that doesn't need it
- ✅ search "Research Sensor" → Off (if present)
- ✅ Disable crash reporter dialogs and Apple reporting: `defaults write com.apple.CrashReporter DialogType none`
- ✅ Switch DNS away from ISP: System Settings → Network → select interface → Details → DNS → replace with a non-logging resolver
  - Quad9: `9.9.9.9` / `149.112.112.112` — non-profit, Swiss jurisdiction, blocks malware domains
  - Note: this is stored at the connection level. See `apps.md` to install NextDNS
---

## Apple features and ecosystem — disable

Do this immediately after the setup wizard, before configuring anything else. Most of these features are useless without other Apple devices and all of them send data or add UI clutter. Or to be blunt, they are a fucking headache when on and a fucking headache to figure out how to switch the shit off.

### Setup wizard — what to skip

- ✅ Migration Assistant: skip — don't transfer from another Mac
- ✅ Apple Intelligence: skip or Off if prompted
- ✅ Location Services: skip — configure per-app later if needed
- ✅ Screen Time: skip
- ✅ Siri: skip
- ✅ iCloud: sign in to Apple ID if you want (for App Store access), but decline every individual iCloud service when prompted
  - Note: done with everything switched off except "Find My"

### iCloud services

Sign in to Apple ID is fine (needed for App Store). Turn off every iCloud service:

- ✅ search "iCloud" → turn off: iCloud Drive, Photos, Mail, Contacts, Calendar, Reminders, Notes, Safari, Passwords & Keychain, Find My Mac, iCloud Backup
- ✅ iCloud+ features (if shown): Private Relay → Off, Hide My Email → Off

### Apple Intelligence

- ✅ search "Apple Intelligence" → Apple Intelligence → Off
- ✅ Writing Tools: disabled automatically when Apple Intelligence is off
- ✅ If the option to turn off is greyed out, set Siri to off first

### Siri

- ✅ search "Siri" → Siri → Off
- ✅ Remove Siri from menu bar: search "Siri" → Control Centre → Don't Show in Menu Bar
  - Note: don't see it in menu bar settings
- ✅ Keyboard shortcut: search "Siri" → Keyboard Shortcuts → disable all
  - Note: Don't see it in keyboard shortcuts
- ✅ Improve Siri & Dictation: search "Analytics" → Improve Siri & Dictation → Off

### Handoff and Continuity

All of these require other Apple devices — none apply here.

- ✅ search "Handoff" → Allow Handoff → Off
- ✅ search "Handoff" → AirPlay Receiver → Off
- ✅ search "Handoff" → Continuity Camera → Off
- ✅ iPhone Mirroring (Sequoia): search "iPhone Mirroring" → disable if present

### Spotlight data collection

- ✅ Switch off everything since using Raycast 
- ✅ Disable Spotlight indexing entirely (switched to Raycast): `sudo mdutil -a -i off`

### Stage Manager

Not useful for a keyboard-driven workflow — off by default but confirm:

- ✅ search "Stage Manager" → Stage Manager → Off

### Screen Time

Only useful for parental controls:

- ✅ search "Screen Time" → Off

### Game Center

- ✅ search "Game Center" → Off (or just don't sign in)

### Notification Center widgets

macOS adds widgets to the Notification Center by default:

- ✅ Open Notification Center (click clock, or swipe from right edge) → scroll to bottom → Edit Widgets → remove all

### Apple apps — remove from Dock and hide

These apps run in the background or clutter the Dock. Remove from Dock (right-click → Remove from Dock); uninstall from Launchpad if desired:

- ✅ Remove from dock
- ✅ Uninstall everything possible

Note: most Apple apps cannot be fully uninstalled on macOS; removing from Dock is sufficient.
  - Note: I want to try to uninstall as much as possible. Need to return to. Removing from the dock for now.

### Sharing and remote access — disable all unused services

- ✅ search "Sharing":
  - Screen Sharing → Off
  - File Sharing → Off
  - Media Sharing → Off
  - Remote Login (SSH into this Mac) → Off unless intentionally wanted
  - Remote Management → Off
  - Bluetooth Sharing → Off
  - Internet Sharing → Off
  - Printer Sharing → Off
  - Content Caching → Off
- ✅ AirDrop: search "AirDrop" → AirDrop → No One

---

## Appearance

- ✅ Dark mode: search "Appearance" → Dark **(known)**
- ✅ Accent color: search "Appearance" → **(decide)** choose closest to Gruvbox orange/yellow, or multicolor
- ✅ Wallpaper: set background to solid black — search "Wallpaper" → Colour → black **(known: current wallpaper is a solid black PNG, no file transfer needed)**
- ✅ Cursor size: search "Pointer size"
- ✅ Remove animations
  - `defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false` to stop animations with new window
  - Cues specific to size or minimize didn't work with change window size or minimize 

---

## Text scaling

On Linux, `text-scaling-factor=1.25` — text is 25% larger than default. Replicate on Mac:

- ✅ search "Displays" → use a scaled resolution that gives more breathing room

---

## Dock

- ✅ Clean-up Dock
  - Note: Cleaned up but not relevant since hiding the dock anyway.
- ✅ Auto-hide: search "Dock" → Automatically hide and show the Dock → On
- ✅ Set a long hover delay so the Dock never appears — run in Terminal:
  `defaults write com.apple.dock autohide-delay -float 1000 && killall Dock`
  - Toggle the Dock on demand with `Cmd+Option+D`.

---

## Menu bar

- ✅ Clock: show weekday → On; search "Clock" 
- ✅ 24-hour time: search "24-hour" 
- ✅ Battery percentage → On; search "Battery" **(known)**
- ✅ Spotlight: hide from menu bar if replacing with Raycast — search "Spotlight"
- ✅ Review all menu bar icons once apps are installed — hide anything unnecessary

---

## Hot corners

- ✅ Disable all hot corners — search "Hot Corners" → set all to `-` ---

---

## Trackpad

- ✅ Tap to click: Off **(known: disabled on Linux)**
- ✅ Tracking speed: adjust to preference; search "Trackpad"
- ✅ Scroll direction: Natural Scrolling → **On** (matches Linux — `natural-scroll=true` in dconf) **(known)**; search "Trackpad"
- ✅ Three-finger drag: search "three finger drag" → Use trackpad for dragging → Three Finger Drag **(decide)**
  - Note: this is new to me, but I like it.
- ✅ Click method: two-finger right-click **(known: `click-method='fingers'` on Linux)**
- ✅ Review other gestures: swipe between Spaces, Mission Control, etc. — lean in; trackpad gestures are a hardware advantage over Linux, not something to disable

--- 

## Notifications

- ✅ Switch everything off

---

## Finder

- ✅ Show all file extensions: Finder → Settings → Advanced → Show all filename extensions → On
- ✅ Show path bar: Finder menu → View → Show Path Bar
- ✅ Show status bar: Finder menu → View → Show Status Bar
- ✅ Default view: column view **(known: `default-folder-viewer='list-view'` in dconf)**
- ✅ New Finder window opens to: `local/`
- ✅ Sidebar: Finder → Settings → Sidebar — configure to taste
- ✅ Remove tags from sidebar if unused
