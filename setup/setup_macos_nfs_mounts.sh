#!/usr/bin/env bash
# Run once on macOS to configure autofs for pickle-pi NFS shares.
#
# Uses an indirect map under /private/nfs. automount owns the parent directory
# and re-creates it on every boot, so no manual mkdir is needed after restarts.

set -euo pipefail

HOST="${PICKLE_PI_HOST:-192.168.8.154}"
DRIVE_EXPORT="/mnt/drive_data"
HDD_EXPORT="/mnt/hdd_data"
VAULT_EXPORT="/mnt/vault_data"
# rsize and readahead raised above the macOS defaults: fewer round trips per
# megabyte, the limit on a high-latency mount.
#
# wsize deliberately unset. Measured 2026-10-19: macOS negotiates wsize=32768
# and writes at 88.3 MB/s, above the 50.5 MB/s the vault's drive and LUKS
# impose, so raising it would tune the half that is not slow.
NFS_OPTS="resvport,nolocks,tcp,rsize=65536,readahead=128"
AUTO_PARENT="/private/nfs"
AUTO_MAP="/etc/auto_pickle_pi"
AUTO_MASTER="/etc/auto_master"
BACKUP_SUFFIX="backup-before-pickle-pi"

echo "=== macOS pickle-pi autofs setup ==="

backup_file() {
    local path="$1"
    if [[ -f "$path" ]]; then
        local backup="${path}.${BACKUP_SUFFIX}"
        if [[ -e "$backup" ]]; then
            echo "[SKIP] Backup already exists: $backup"
        else
            echo "[INFO] Backing up $path -> $backup"
            sudo cp -p "$path" "$backup"
        fi
    fi
}

backup_file "$AUTO_MASTER"
backup_file "$AUTO_MAP"

echo "[INFO] Exports visible from $HOST:"
showmount -e "$HOST"

echo "[INFO] Installing $AUTO_MAP"
sudo tee "$AUTO_MAP" >/dev/null <<EOF
drive_data -fstype=nfs,${NFS_OPTS} ${HOST}:${DRIVE_EXPORT}
hdd_data   -fstype=nfs,${NFS_OPTS} ${HOST}:${HDD_EXPORT}
vault_data -fstype=nfs,${NFS_OPTS} ${HOST}:${VAULT_EXPORT}
EOF

# Remove any previous (direct or indirect) pickle-pi entry from auto_master
sudo sed -i '' "/$(basename "$AUTO_MAP")/d" "$AUTO_MASTER"

echo "[INFO] Registering $AUTO_MAP in $AUTO_MASTER"
printf '\n# pickle-pi NFS shares\n%s\n' "${AUTO_PARENT} ${AUTO_MAP}" | sudo tee -a "$AUTO_MASTER" >/dev/null

echo "[INFO] Reloading automount maps"
sudo automount -vc

echo
# -sfn, not -sf. Without -n, re-running these once the symlink exists makes ln
# follow it into the share and create the link inside the mounted volume.
echo "[OK] autofs configured. Update symlinks in ~/local/:"
echo "  ln -sfn ${AUTO_PARENT}/hdd_data ~/local/pickle-pi-hdd_data"
echo "  ln -sfn ${AUTO_PARENT}/drive_data ~/local/pickle-pi-drive_data"
echo "  ln -sfn ${AUTO_PARENT}/vault_data ~/local/pickle-pi-vault_data"
