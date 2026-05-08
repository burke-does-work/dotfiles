# Mac Transfer Project

## The Mac Book purchase

I purchased a new Mac Book Air, specs as follows:

- M5 chip
- 15.3-inch Liquid Retina Display
- 24GB Unified Memory, 1TB SSD

The current machine is a Framework 13, called matt-9000.

This is my first time ever owning a Mac.

I decided to go Mac because the quality of the hardware is now surpassing the equivalent PC. When I see Macs, I no longer just see design aesthetics, ecosystem lock-in, and expensive products. I see the integrated system with the M5 chip, massive battery life, etc.

## Purpose and goals

**Purpose**: Transfer from my Ubuntu Linux OS machine.

**Goal**: As much as possible, copy existing settings, workflow, and applications.

**Important**: Copying will be intentional, there's not wholesale copying of directories. For example, don't just copy-paste all of `home/matt/`

## Core Philosophy

### Psychology

- I don't like being told what is best for me, and I know what it best for me more than Apple does.
- That said, there is a time and effort trade-off to fighting Apple with complicated workarounds. I accept that I'll have to adapt to the Mac to some extent.

### In practice

- Treat the Mac as a Linux machine with a Mac desktop — accept macOS's desktop layer (Spaces, menu bar, trackpad, app ecosystem) as a replacement for Gnome/WM, but Linuxify everything below and around it.
- A separate client-issued Windows machine is used for one client due to security requirements. It is treated as a distinct physical context — no attempt to unify muscle memory across Mac and Windows, except noting that Linux & Windows share some keyboard workflow.

## Window Management

**Model**: One app, full screen by default. No tiling, no multiple simultaneous windows — intentional focus discipline.

**Exceptions**:
- Two windows side-by-side occasionally, for direct comparison
- Second monitor as dedicated visualization display during data analysis

**Tooling**:
- Raycast Window Management for snap/maximize. macOS Sequoia native tiling tested but abandoned — Electron apps (VS Code) intercept the Fill keystroke and go fullscreen instead of resizing. Rectangle also tested and uninstalled.
- yabai explicitly ruled out — tiling WM is in conflict with single-focus workflow

**Verdict**: Raycast WM bound for maximize (default) and snap-to-half (comparison). See `macos_settings.md`.

---

## Domain Decisions

| Domain | Approach |
|---|---|
| Package management | Homebrew (`brew`) = `apt` |
| Shell & dotfiles | Same as Linux, same repo |
| Terminal | Ghostty |
| File navigation | CLI-first; Finder used when necessary |
| System monitoring | `btop`, `htop`, `lsof` — not Activity Monitor |
| Config | `defaults write`, dotfiles; avoid GUI-only config |
| App launcher | Raycast |
| Window management | Raycast |

---

## Accept as "Mac Desktop Layer"

These have no Linux equivalent and are not worth fighting:

- **Spaces** — virtual desktop implementation; serves the same role as i3 workspaces
- **Trackpad gestures** — hardware advantage, lean in
- **Menu bar** — app-level menus are how Mac apps work

---

