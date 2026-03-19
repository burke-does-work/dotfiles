#!/usr/bin/env bash
# Run once as root (or with sudo) to complete the encrypted drive setup.
# This script is safe to re-run — it checks before modifying.

set -euo pipefail

echo "=== Encrypted drive setup ==="

# --- 1. Move key file to system standard location ---
if [[ ! -f /etc/cryptsetup-keys.d/ssd2_world.key ]]; then
    mkdir -p /etc/cryptsetup-keys.d
    cp /home/matt/helper_scripts/ssd2_world_key /etc/cryptsetup-keys.d/ssd2_world.key
    chown root:root /etc/cryptsetup-keys.d/ssd2_world.key
    chmod 400 /etc/cryptsetup-keys.d/ssd2_world.key
    echo "[OK] Key file copied to /etc/cryptsetup-keys.d/ssd2_world.key"
else
    echo "[SKIP] Key file already exists at /etc/cryptsetup-keys.d/ssd2_world.key"
fi

# --- 2. Back up system files ---
cp -n /etc/fstab /etc/fstab.bak    && echo "[OK] /etc/fstab.bak created (or already existed)"
touch /etc/crypttab 2>/dev/null || true
cp -n /etc/crypttab /etc/crypttab.bak && echo "[OK] /etc/crypttab.bak created (or already existed)"

# --- 3. Add crypttab entry ---
CRYPTTAB_ENTRY="ssd2_world  UUID=3efbea31-d5bb-493b-ac77-b747808217b3  /etc/cryptsetup-keys.d/ssd2_world.key  luks,noauto"
if grep -q "ssd2_world" /etc/crypttab 2>/dev/null; then
    echo "[SKIP] ssd2_world already in /etc/crypttab"
else
    echo "$CRYPTTAB_ENTRY" >> /etc/crypttab
    echo "[OK] Added ssd2_world entry to /etc/crypttab"
fi

# --- 4. Add fstab entries ---
if grep -q "/mnt/ssd2_data" /etc/fstab; then
    echo "[SKIP] /mnt/ssd2_data already in /etc/fstab"
else
    echo "" >> /etc/fstab
    echo "# SSD2 encrypted data drive" >> /etc/fstab
    echo "/dev/mapper/ssd2_world  /mnt/ssd2_data  ext4  noauto  0  0" >> /etc/fstab
    echo "[OK] Added /mnt/ssd2_data entry to /etc/fstab"
fi

if grep -q "/mnt/nfs/drive_data" /etc/fstab; then
    echo "[SKIP] NFS entries already in /etc/fstab"
else
    echo "" >> /etc/fstab
    echo "# NFS shares from Raspberry Pi (192.168.8.154)" >> /etc/fstab
    echo "192.168.8.154:/mnt/drive_data  /mnt/nfs/drive_data  nfs  noauto,_netdev  0  0" >> /etc/fstab
    echo "192.168.8.154:/mnt/hdd_data    /mnt/nfs/hdd_data    nfs  noauto,_netdev  0  0" >> /etc/fstab
    echo "[OK] Added NFS entries to /etc/fstab"
fi

# --- 5. Create mount points if missing ---
mkdir -p /mnt/ssd2_data /mnt/nfs/drive_data /mnt/nfs/hdd_data
echo "[OK] Mount points exist"

# --- 6. Verify fstab syntax ---
echo ""
echo "=== Verifying fstab ==="
findmnt --verify && echo "[OK] fstab syntax valid"

echo ""
echo "=== Setup complete ==="
echo "Test with: sudo cryptdisks_start ssd2_world && sudo mount /mnt/ssd2_data"
