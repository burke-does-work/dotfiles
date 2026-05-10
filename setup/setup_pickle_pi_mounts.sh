#!/usr/bin/env bash
# Run once on pickle-pi as root (or with sudo) to set up the external HDD mount.
# Assumes the LUKS key file already exists at /etc/cryptsetup-keys.d/hdd_data.key
# (generated with: sudo dd if=/dev/urandom bs=512 count=1 > /etc/cryptsetup-keys.d/hdd_data.key)
# (added to LUKS with: sudo cryptsetup luksAddKey /dev/sda1 /etc/cryptsetup-keys.d/hdd_data.key)
# This script is safe to re-run — it checks before modifying.

set -euo pipefail

echo "=== pickle-pi external HDD mount setup ==="

: "${HDD_LUKS_UUID:?Set HDD_LUKS_UUID before running this local setup script}"
: "${HDD_FS_UUID:?Set HDD_FS_UUID before running this local setup script}"

# --- 1. Verify key file exists ---
if [[ ! -f /etc/cryptsetup-keys.d/hdd_data.key ]]; then
    echo "[ERROR] Key file not found at /etc/cryptsetup-keys.d/hdd_data.key"
    echo "  Generate with: sudo dd if=/dev/urandom bs=512 count=1 > /etc/cryptsetup-keys.d/hdd_data.key"
    echo "  Add to LUKS:   sudo cryptsetup luksAddKey /dev/sda1 /etc/cryptsetup-keys.d/hdd_data.key"
    exit 1
fi
chown root:root /etc/cryptsetup-keys.d/hdd_data.key
chmod 400 /etc/cryptsetup-keys.d/hdd_data.key
echo "[OK] Key file exists at /etc/cryptsetup-keys.d/hdd_data.key"

# --- 2. Back up system files ---
cp -n /etc/fstab /etc/fstab.bak       && echo "[OK] /etc/fstab.bak created (or already existed)"
touch /etc/crypttab 2>/dev/null || true
cp -n /etc/crypttab /etc/crypttab.bak && echo "[OK] /etc/crypttab.bak created (or already existed)"

# --- 3. Add crypttab entry ---
CRYPTTAB_ENTRY="hdd_data  /dev/disk/by-uuid/${HDD_LUKS_UUID}  /etc/cryptsetup-keys.d/hdd_data.key  luks"
if grep -q "hdd_data" /etc/crypttab 2>/dev/null; then
    echo "[SKIP] hdd_data already in /etc/crypttab"
else
    echo "$CRYPTTAB_ENTRY" >> /etc/crypttab
    echo "[OK] Added hdd_data entry to /etc/crypttab"
fi

# --- 4. Add fstab entry ---
if grep -q "/mnt/hdd_data" /etc/fstab; then
    echo "[SKIP] /mnt/hdd_data already in /etc/fstab"
else
    echo "" >> /etc/fstab
    echo "# External HDD (LUKS-encrypted, auto-unlocked via key file)" >> /etc/fstab
    echo "/dev/disk/by-uuid/${HDD_FS_UUID}  /mnt/hdd_data  ext4  defaults,nofail  0  2" >> /etc/fstab
    echo "[OK] Added /mnt/hdd_data entry to /etc/fstab"
fi

# --- 5. Create mount point if missing ---
mkdir -p /mnt/hdd_data
echo "[OK] Mount point /mnt/hdd_data exists"

# --- 6. Verify fstab syntax ---
echo ""
echo "=== Verifying fstab ==="
findmnt --verify && echo "[OK] fstab syntax valid"

echo ""
echo "=== Setup complete ==="
echo "On next boot the drive will auto-unlock and mount at /mnt/hdd_data"
echo "NFS export (/etc/exports) should already have: /mnt/hdd_data pickle-pi LAN(...)"
