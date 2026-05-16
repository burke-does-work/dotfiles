#!/usr/bin/env bash
# Run once on macOS to configure autofs for pickle-pi NFS shares.
#
# Uses an indirect map under /private/nfs. automount owns the parent directory
# and re-creates it on every boot, so no manual mkdir is needed after restarts.

set -euo pipefail

HOST="${PICKLE_PI_HOST:-pickle-pi.local}"
DRIVE_EXPORT="/mnt/drive_data"
HDD_EXPORT="/mnt/hdd_data"
NFS_OPTS="resvport,nolocks,tcp"
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
EOF

# Remove any previous (direct or indirect) pickle-pi entry from auto_master
sudo sed -i '' "/$(basename "$AUTO_MAP")/d" "$AUTO_MASTER"

echo "[INFO] Registering $AUTO_MAP in $AUTO_MASTER"
printf '\n# pickle-pi NFS shares\n%s\n' "${AUTO_PARENT} ${AUTO_MAP}" | sudo tee -a "$AUTO_MASTER" >/dev/null

echo "[INFO] Reloading automount maps"
sudo automount -vc

echo
echo "[OK] autofs configured. Update symlinks in ~/local/:"
echo "  ln -sf ${AUTO_PARENT}/hdd_data ~/local/pickle-pi-hdd_data"
echo "  ln -sf ${AUTO_PARENT}/drive_data ~/local/pickle-pi-drive_data"
