[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Files Transfer — maodou-mac

## Dotfiles repo

- `[mac]` Clone from GitHub — no USB transfer needed

---

## SSH

- `[skip]` `~/.ssh/id_ed25519` — generate fresh key on Mac (Phase 9)
- SSH config comes from dotfiles repo

---

## Config files (copy to USB in Phase 1, install in Phase 11)

- `[mac]` `~/.config/sublime-text/Packages/User/Preferences.sublime-settings`
- `[mac]` `~/.config/sublime-text/Packages/User/Package Control.sublime-settings`
- `[mac]` `~/.config/nicotine/config` — credentials + settings; update `/home/matt/` paths to `/Users/matt/` before using; credentials are plaintext, handle with care
- `[mac]` `~/.gitconfig` — will be added to dotfiles and symlinked (Phase 11)
- `[mac]` `~/.config/gh/config.yml` — already in dotfiles at `config/gh/config.yml`; symlinked in Phase 11
- `[mac]` `~/.claude/settings.json` — already in dotfiles at `config/claude/settings.json`; Mac-adapted version created in Phase 12

---

## `/mnt/ssd2_data` — encrypted external SSD

Copy via USB (exFAT). Fill in what you're transferring.

---

## `~/` — other home directory items

- Fill in if anything lives here outside of `/mnt/ssd2_data` and the config files above

---

## Destination paths on maodou-mac

- `/mnt/ssd2_data/` → `~/local/` — all actual files (documents, projects, media)
- `~/` config files → `~/` (same structure, path changes from `/home/matt/` to `/Users/matt/`)
- `/mnt/nfs/drive_data/` → NFS mount from pickle-pi (Phase 11)
- `/mnt/nfs/hdd_data/` → NFS mount from pickle-pi (Phase 11)
