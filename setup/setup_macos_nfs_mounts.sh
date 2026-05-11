#!/usr/bin/env bash
# Run once on macOS to configure autofs for pickle-pi NFS shares.

set -euo pipefail

HOST="${PICKLE_PI_HOST:-pickle-pi.local}"
DRIVE_EXPORT="/mnt/drive_data"
HDD_EXPORT="/mnt/hdd_data"
DRIVE_MOUNT="/Volumes/pickle-pi-drive_data"
HDD_MOUNT="/Volumes/pickle-pi-hdd_data"
NFS_OPTS="resvport,nolocks,tcp"
AUTO_MAP="/etc/auto_pickle_pi"
AUTO_MASTER="/etc/auto_master"
AUTO_MASTER_ENTRY="/- ${AUTO_MAP}"
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
$DRIVE_MOUNT -fstype=nfs,$NFS_OPTS ${HOST}:${DRIVE_EXPORT}
$HDD_MOUNT -fstype=nfs,$NFS_OPTS ${HOST}:${HDD_EXPORT}
EOF

if grep -qE "^[[:space:]]*/-[[:space:]]+${AUTO_MAP//\//\\/}([[:space:]]|$)" "$AUTO_MASTER"; then
    echo "[SKIP] $AUTO_MASTER already includes $AUTO_MAP"
else
    echo "[INFO] Registering $AUTO_MAP in $AUTO_MASTER"
    printf '\n# pickle-pi NFS shares\n%s\n' "$AUTO_MASTER_ENTRY" | sudo tee -a "$AUTO_MASTER" >/dev/null
fi

echo "[INFO] Creating autofs mount points"
sudo mkdir -p "$DRIVE_MOUNT" "$HDD_MOUNT"

echo "[INFO] Reloading automount maps"
sudo automount -vc

echo
echo "[OK] autofs configured"
echo "Accessing these paths will mount the shares on demand:"
echo "  $DRIVE_MOUNT"
echo "  $HDD_MOUNT"
