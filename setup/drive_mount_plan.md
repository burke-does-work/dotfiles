[//]: # (Style guide: no markdown tables — use lists and descriptions only)

# Encrypted Drive Mount Setup Plan

## Context

The current approach uses bash scripts (`ssd2_drive_mount.sh`, `nfs_mount.sh`) invoked via zsh aliases (`mountlocal`, `mountnfs`). The scripts were written to solve two requirements:
1. No passphrase prompt on every mount — solved via LUKS key files
2. Mount to `/mnt/` rather than `/media/` — solved by manually calling cryptsetup + mount

Both requirements are natively supported by `/etc/crypttab` + `/etc/fstab`. The scripts are a manual workaround for something the standard Linux system handles directly. The scripts also have bugs (shebang not on line 1, `umount` failure breaks the chain on first run).

---

## Decisions

- **Approach:** Replace scripts with `crypttab` + `fstab` (systemd-managed, declarative)
- **Key files:** Move to `/etc/cryptsetup-keys.d/` (system standard, root-only) — no passphrases
- **Mount timing:** On-demand only (`noauto` in both crypttab and fstab)
- **Aliases:** Keep `mountlocal` and `mountnfs` — just update what they call
- **Mount points:** Unchanged — `/mnt/ssd2_data/` and `/mnt/nfs/`

---

## Safety measures

- **`noauto` on all entries** — systemd ignores these at boot; a mistake means the drive doesn't mount, not a boot failure
- **Appending only** — existing fstab entries (system drive, etc.) are not touched
- **Backups taken before any edit** — `/etc/fstab.bak` and `/etc/crypttab.bak`
- **Syntax verified before reboot** — `sudo findmnt --verify` after fstab edit
- **Manual test before alias use** — verify `cryptdisks_start` + `mount` work directly
- **Scripts archived, not deleted** — original approach restorable immediately if needed

---

## Implementation

### 1. Move key file to `/etc/cryptsetup-keys.d/`

The current location (`/home/matt/helper_scripts/ssd2_world_key`) is in user space — wrong for a system credential. The systemd/cryptsetup standard location is `/etc/cryptsetup-keys.d/`, root-owned, permissions `400`.

```bash
sudo mkdir -p /etc/cryptsetup-keys.d
sudo mv /home/matt/helper_scripts/ssd2_world_key /etc/cryptsetup-keys.d/ssd2_world.key
sudo chown root:root /etc/cryptsetup-keys.d/ssd2_world.key
sudo chmod 400 /etc/cryptsetup-keys.d/ssd2_world.key
```

### 2. Back up critical files

```bash
sudo cp /etc/fstab /etc/fstab.bak
sudo cp /etc/crypttab /etc/crypttab.bak
```

### 3. `/etc/crypttab` — add ssd2_world entry

```
ssd2_world  UUID=3efbea31-d5bb-493b-ac77-b747808217b3  /etc/cryptsetup-keys.d/ssd2_world.key  luks,noauto
```

- `noauto` — systemd skips this at boot; safe even if key file is inaccessible at boot
- `luks` — tells cryptsetup to use LUKS format

### 4. `/etc/fstab` — add ssd2_data and NFS entries

```
# SSD2 encrypted data drive
/dev/mapper/ssd2_world  /mnt/ssd2_data  ext4  noauto  0  0

# NFS shares from Raspberry Pi (192.168.8.154)
192.168.8.154:/mnt/drive_data  /mnt/nfs/drive_data  nfs  noauto,_netdev  0  0
192.168.8.154:/mnt/hdd_data    /mnt/nfs/hdd_data    nfs  noauto,_netdev  0  0
```

- `noauto` — not mounted at boot
- `_netdev` — tells systemd this requires network; prevents boot hang if Pi is unreachable

### 5. Update zsh aliases in `~/dotfiles/zshrc`

```zsh
# Mount local SSD (LUKS open via crypttab, then mount via fstab)
alias mountlocal='sudo cryptdisks_start ssd2_world && sudo mount /mnt/ssd2_data'

# Unmount local SSD
alias umountlocal='sudo umount /mnt/ssd2_data && sudo cryptdisks_stop ssd2_world'

# Mount NFS shares from Raspberry Pi
alias mountnfs='sudo mount /mnt/nfs/drive_data && sudo mount /mnt/nfs/hdd_data'

# Unmount NFS shares
alias umountnfs='sudo umount /mnt/nfs/drive_data && sudo umount /mnt/nfs/hdd_data'
```

- `cryptdisks_start` reads `/etc/crypttab` and opens the LUKS device using the key file
- `mount /mnt/ssd2_data` reads `/etc/fstab` for the mapper device and options
- Unmount aliases added since the scripts handled this implicitly

### 6. Archive old scripts

Move `ssd2_drive_mount.sh` and `nfs_mount.sh` to `helper_scripts/archive/` — keep for reference but remove from active use.

### 7. Remove key file from helper_scripts

The original key file at `/home/matt/helper_scripts/ssd2_world_key` is moved in step 1 — nothing remains there. The `drive_world_key` (for the unaliased `drive_world_mount.sh`) stays in `helper_scripts/` for now as that script is out of scope.

---

## Files to modify

- `/etc/crypttab` — add ssd2_world entry
- `/etc/fstab` — add ssd2_data and NFS entries
- `~/dotfiles/zshrc` — update mountlocal, mountnfs; add umount aliases
- `/etc/cryptsetup-keys.d/ssd2_world.key` — new key file location (moved from helper_scripts)
- `/home/matt/helper_scripts/` — archive old scripts

## Verification

- Run `mountlocal` — confirm LUKS opens and drive mounts at `/mnt/ssd2_data/` without passphrase prompt
- Run `umountlocal` — confirm clean unmount and LUKS close
- Run `mountnfs` — confirm NFS shares mount at `/mnt/nfs/drive_data` and `/mnt/nfs/hdd_data`
- Reboot — confirm nothing mounts automatically (noauto working)
- After reboot, run `mountlocal` again — confirm it still works
