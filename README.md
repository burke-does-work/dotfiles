# Matt's Dotfiles

Personal public dotfiles for a keyboard-first macOS and Unix workflow.

## Approach

This setup makes a Mac behave like a controlled Unix workstation.

The goal is not to create an exact Linux. The goal is to keep the parts that make work predictable: text files, explicit config, keyboard control, and tools that can be inspected.

### Principles

- **Keyboard first** — common actions should not require hunting through UI.
- **One mental model** — vim motions, terminal habits, and editor behavior should agree.
- **Config is text** — important behavior should live in files, not hidden app state.
- **Local first** — files and tools should work without depending on cloud sync.
- **Use the GUI deliberately** — macOS is good at hardware, windows, trackpad, and polished apps; use those where they help.
- **Avoid accidental modes** — fewer overlapping systems means fewer surprises.
- **Key names follow signal, not label** — keyboard shortcuts are documented by the signal each app receives after Karabiner remapping, not the physical key label printed on the keyboard.

### Conceptual Stack 

I want the Mac hardware with the Unix-centered workflow. The result is a hybrid.

- macOS handles the desktop layer.
- Homebrew handles packages.
- Ghostty, zsh, Neovim, VS Code, and CLI tools handle daily work.
- Karabiner and AeroSpace make the keyboard and window model consistent.

The setup is opinionated because, well, I'm opinionated. It favors repeatable operations, plain files, and muscle memory over defaults chosen for a broad audience.

## Reference

- [System overview](docs/system.md) — current tools, roles, and config locations.
- [Keybindings](keybindings.md) — current keyboard reference.
- [macOS setup](docs/macos.md) — settled macOS configuration.
- [Apps](docs/apps.md) — installed app inventory and install notes.

## Infrastructure

Workshop infrastructure documentation lives in the `network-infra` repo.

## Public Repo Notes

Secrets, credentials, local state, generated backups, and app caches are not tracked. Host names and public Git identity are intentional.
