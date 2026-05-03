[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# macOS Interface Settings — maodou-mac

Work through each section during Phase 2 of the transfer. Most settings live in System Settings unless noted. Items marked **(known)** reflect confirmed preferences from dconf. Items marked **(decide)** need a choice.

---

## Apple features and ecosystem — disable

Do this immediately after the setup wizard, before configuring anything else. Most of these features are useless without other Apple devices and all of them send data or add UI clutter.

### Setup wizard — what to skip

- ✅ Migration Assistant: skip — don't transfer from another Mac
- ✅ Apple Intelligence: skip or Off if prompted
- ✅ Location Services: skip — configure per-app later if needed
- ✅ Screen Time: skip
- ✅ Siri: skip
- ✅ iCloud: sign in to Apple ID if you want (for App Store access), but decline every individual iCloud service when prompted
  - Note: cannot sign in until Apple ID reset

### iCloud services

Sign in to Apple ID is fine (needed for App Store). Turn off every iCloud service:

- 🔲 search "iCloud" → turn off: iCloud Drive, Photos, Mail, Contacts, Calendar, Reminders, Notes, Safari, Passwords & Keychain, Find My Mac, iCloud Backup
  - Note: currently not signed-in. Return to if sign in to Apple ID to check
- 🔲 iCloud+ features (if shown): Private Relay → Off, Hide My Email → Off

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

Spotlight sends queries to Apple by default. Disable the network features:

- ✅ search "Spotlight" → uncheck: Siri Suggestions, Bing Web Searches, Allow Spotlight Suggestions in Look Up
- 🔲 Limit search categories: uncheck anything not local (News, Siri Suggestions, Websites)
  - Note: I think everything is local after show related content and help improve search turned off (but not sure)

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
- 🔲 Uninstall everything possible

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

- ✅ search "Displays" → **(decide)** use a scaled resolution that gives more breathing room, or

---

## Dock

- ✅ Auto-hide: search "Dock" → Automatically hide and show the Dock → On
- ✅ Set a long hover delay so the Dock never appears — run in Terminal:
  `defaults write com.apple.dock autohide-delay -float 1000 && killall Dock`
  - Toggle the Dock on demand with `Cmd+Option+D`.
- ✅ Position: **(decide)** bottom / left / right
- ✅ Size: drag to preferred size
- ✅ Magnification: Off
- ✅ Remove all default Apple apps from Dock — right-click each → Remove from Dock. Finder and trash can't be removed.
- 🔲 Pin these apps (matching Linux dock): Ghostty, Chrome, VS Code, Signal **(known)**
  - Note: need to return to after applications installed
- 🔲 Add Google Sheets as a PWA: in Chrome, open sheets.google.com → address bar menu → Save and share → Add to Dock **(known: pinned on Linux)**
  - Note: still evaluating which spreadsheet program I'll use. Return to this when a spreadsheet program is added
- ✅ search "Dock" → Show recent applications in Dock → Off

---

## Menu bar

- ✅ Clock: show weekday → On; search "Clock" 
- ✅ 24-hour time: search "24-hour" 
- 🔲 Battery percentage → On; search "Battery" **(known)**
- 🔲 Spotlight: hide from menu bar if replacing with Raycast — search "Spotlight" **(decide)**
- 🔲 Review all menu bar icons once apps are installed — hide anything unnecessary

---

## Keyboard

### Typing behaviour

- 🔲 Key repeat rate: search "Key Repeat" → Key Repeat Rate → Fast (maximum)
- 🔲 Delay until repeat: search "Key Repeat" → Delay Until Repeat → Short (minimum)
- ✅ Disable autocorrect: search "Text Input" → Edit → turn off each:
  - Correct spelling automatically
  - Capitalise words automatically
  - Add full stop with double-space
  - Use smart quotes and dashes

### Modifier keys

- 🔲 **(decide)** Caps Lock: remap to Escape (useful for vim) or leave as Caps Lock
  - search "Modifier Keys"

### Function keys

- ✅ **(decide)** F1–F12 as standard function keys or media/system keys (Mac default is media keys; press Fn for F1–F12)
  - Standard F keys are useful if you use F-key shortcuts in VS Code
  - search "Function Keys"

### Input sources

- ✅ Add Chinese input: search "Input Sources" → Edit → add Pinyin - Simplified
- 🔲 **(decide)** Shortcut to switch input sources — default is Ctrl+Space which conflicts with many tools; remap
  - NOTE: come back to later if running into conflicts. Otherwise leave at `Ctrl+Space`

### Keyboard shortcuts — system level

Target equivalents for Linux keybindings from dconf. Set via search "Keyboard Shortcuts", or via Raycast/Hammerspoon for anything macOS doesn't support natively.

- 🔲 Show desktop: `Super+M` on Linux → Mission Control shortcut or **(decide)** equivalent
- 🔲 Switch workspace left/right: `Alt+Super+←/→` on Linux → `Ctrl+←/→` (macOS default for Spaces) or remap
- 🔲 Move window to workspace left/right: `Shift+Alt+Super+←/→` on Linux → **(decide)** remap via search "Keyboard Shortcuts"
- 🔲 Volume up/down: `Ctrl+Super+↑/↓` on Linux → macOS F11/F12 (or function keys if remapped); **(decide)** whether to replicate the Linux combo
- 🔲 Screenshot: `Shift+Super+S` on Linux → `Cmd+Shift+4` (macOS default for region screenshot) — close enough, no change needed
- 🔲 App switcher: set to current Space only — **(decide)** achieve via Mission Control settings

### Raising the terminal — equivalent to Super+1 on Linux

On Linux, `Super+1` raised Kitty at the GNOME level. macOS has no built-in equivalent. Options:

- **Raycast** (if adopted): assign a global shortcut to launch/raise Ghostty — e.g., `Cmd+1` or `Option+Space`
- **Hammerspoon** (free, scriptable): bind any key combo to raise a specific app window; requires Lua config

- 🔲 **(decide)** Global shortcut to raise Ghostty: ___

---

## Trackpad

- ✅ Tap to click: Off **(known: disabled on Linux)**
- ✅ Tracking speed: adjust to preference; search "Trackpad"
- ✅ Scroll direction: Natural Scrolling → **On** (matches Linux — `natural-scroll=true` in dconf) **(known)**; search "Trackpad"
- ✅ Three-finger drag: search "three finger drag" → Use trackpad for dragging → Three Finger Drag **(decide)**
  - Note: this is new to me, but I like it.
- ✅ Click method: two-finger right-click **(known: `click-method='fingers'` on Linux)**
- 🔲 **(decide)** Review other gestures: swipe between Spaces, Mission Control, etc.

---

## Finder

- 🔲 Show hidden files: `Cmd+Shift+.` to toggle; or make permanent: `defaults write com.apple.finder AppleShowAllFiles true && killall Finder`
- 🔲 Show all file extensions: Finder → Settings → Advanced → Show all filename extensions → On
- 🔲 Show path bar: Finder menu → View → Show Path Bar
- 🔲 Show status bar: Finder menu → View → Show Status Bar
- 🔲 Default view: List view **(known: `default-folder-viewer='list-view'` in dconf)**
- 🔲 Sort directories first: **(known: `sort-directories-first=true` in dconf)**
- 🔲 New Finder window opens to: **(decide)** Home folder — Finder → Settings → General
- 🔲 Sidebar: Finder → Settings → Sidebar — configure to taste
- 🔲 Remove tags from sidebar if unused

---

## Hot corners

- 🔲 Disable all hot corners — search "Hot Corners" → set all to `-` **(known: no hot corners configured on Linux)**

---

## Mission Control and Spaces

- 🔲 Number of Spaces: 2 **(known: `num-workspaces=2` on Linux)**
- 🔲 search "Mission Control" → Automatically rearrange Spaces based on most recent use → Off — otherwise Spaces reorder and become unpredictable
- 🔲 Group windows by application → **(decide)**
- 🔲 App switcher shows current Space only: **(known: `current-workspace-only=true` on Linux)** — **(decide)** how to replicate; not a direct macOS setting but AltTab (if installed) supports this

---

## Notifications

- 🔲 Global banners: search "Notifications" → Off **(known: `show-banners=false` on Linux)**
- 🔲 Show in lock screen: Off **(known)**
- 🔲 Per-app after installing — based on Linux config, enable notifications only for:
  - VS Code **(known: enabled)**
  - Nicotine+ **(known: enabled)**
  - Sublime Text **(known: enabled)**
  - Signal **(known: disabled on Linux — keep disabled or decide)**
  - Everything else: Off

---

## Screen lock

- 🔲 Require password after sleep: **(known: lock disabled on Linux — `lock-enabled=false`)** → set to your preference; search "Lock Screen"
- 🔲 Screen saver: Off — search "Screen Saver" → Never

---

## Power and sleep

- 🔲 On AC power: display sleep → **(decide)**; system sleep → Never **(known: `sleep-inactive-ac-type='nothing'` on Linux)**; search "Battery"
- 🔲 On battery: system sleep after 30 minutes **(known: `sleep-inactive-battery-timeout=1800` on Linux)**
- 🔲 Dim display: Off **(known: `idle-dim=false` on Linux)**; search "display brightness"
- 🔲 Ambient light sensor: Off **(known: `ambient-enabled=false` on Linux)**

---

## Sound

- 🔲 search "Sound" → Sound Effects → Alert volume → 0, Play user interface sound effects → Off **(known: `event-sounds=false` on Linux)**
- 🔲 Startup chime: Off by default on modern Macs

---

## Security

- 🔲 Firewall: search "Firewall" → On
- 🔲 Gatekeeper: approve Homebrew cask installs via search "Privacy & Security" when prompted

---

## Privacy and telemetry

- 🔲 search "Analytics":
  - Share Mac Analytics → Off
  - Improve Siri & Dictation → Off
  - Share with App Developers → Off
  - Share iCloud Analytics → Off
- 🔲 search "Advertising" → Personalised Ads → Off
- 🔲 search "Location Services" → review per-app; disable for anything that doesn't need it
- 🔲 search "Research Sensor" → Off (if present)

---

## Displays

- 🔲 Resolution: see Text scaling section above — use scaled resolution if text is too small
- 🔲 True Tone: **(decide)** adjusts white balance to ambient light; `ambient-enabled=false` on Linux suggests Off; search "True Tone"
- 🔲 Night Shift: **(decide)**; search "Night Shift"

---

## Sharing and remote access

Covered comprehensively in the "Apple features and ecosystem — disable" section above.
