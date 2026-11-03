#!/usr/bin/env bash
# Run once on macOS to install awake, which keeps the Mac awake with the lid
# closed while it's on the charger.
#
#   sudo ./setup/setup_awake.sh
#
# Safe to run again. It reinstalls the admin rule and links, and reloads the
# job unless `awake disable` turned it off.

set -euo pipefail

if [[ "$(id -u)" -ne 0 ]]; then
    echo "[ERROR] Run with sudo: sudo $0" >&2
    exit 1
fi
USER_NAME="${SUDO_USER:-}"
if [[ -z "$USER_NAME" || "$USER_NAME" == "root" ]]; then
    echo "[ERROR] Run with sudo from your own account, not as root" >&2
    exit 1
fi

USER_ID="$(id -u "$USER_NAME")"
USER_HOME="$(dscl . -read "/Users/$USER_NAME" NFSHomeDirectory | awk '{ print $2 }')"
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_DIR="$REPO_DIR/config/awake"
LABEL="local.awake"
RULE_PATH="/etc/sudoers.d/awake"
BIN_LINK="$USER_HOME/.local/bin/awake"
PLIST_LINK="$USER_HOME/Library/LaunchAgents/$LABEL.plist"

echo "=== awake setup for $USER_NAME ==="

# --- admin rule ---

# Validate a filled-in copy before installing, because a broken file in
# sudoers.d can stop sudo working entirely.
RULE_TMP="$(mktemp)"
sed "s/__USER__/$USER_NAME/" "$SOURCE_DIR/awake.sudoers" > "$RULE_TMP"
if ! visudo -c -f "$RULE_TMP"; then
    rm -f "$RULE_TMP"
    echo "[ERROR] Admin rule failed validation, nothing installed" >&2
    exit 1
fi
install -o root -g wheel -m 0440 "$RULE_TMP" "$RULE_PATH"
rm -f "$RULE_TMP"
echo "[OK] Installed $RULE_PATH"

# --- links ---

# Created as the user, so the user owns them.
sudo -u "$USER_NAME" mkdir -p "$(dirname "$BIN_LINK")" "$(dirname "$PLIST_LINK")"
sudo -u "$USER_NAME" ln -sfn "$SOURCE_DIR/awake" "$BIN_LINK"
sudo -u "$USER_NAME" ln -sfn "$SOURCE_DIR/awake.plist" "$PLIST_LINK"
echo "[OK] Linked $BIN_LINK"
echo "[OK] Linked $PLIST_LINK"

# --- job ---

DISABLED="$(launchctl print-disabled "gui/$USER_ID")"
if [[ "$DISABLED" == *"\"$LABEL\" => disabled"* ]]; then
    echo "[SKIP] awake is disabled. Run 'awake enable' to start it."
else
    # Reload, so a changed job file takes effect.
    launchctl bootout "gui/$USER_ID/$LABEL" 2>/dev/null || true
    launchctl bootstrap "gui/$USER_ID" "$PLIST_LINK"
    echo "[OK] Loaded $LABEL"
fi

echo ""
echo "Check it with: awake status"
