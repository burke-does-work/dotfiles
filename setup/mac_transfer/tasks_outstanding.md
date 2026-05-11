# Tasks - Outstanding

## Backup

- 🔲 SSH to pickle-pi: install and configure `netatalk` for Time Machine over network **(Claude)**
- 🔲 Restrict openclaw's access to the backup directory on pickle-pi
- 🔲 Mac: System Settings → General → Time Machine → Add backup disk → select pickle-pi share
- 🔲 Verify first backup runs
- 🔲 Add USB drive as second Time Machine disk for local redundancy

## Future Apps

- 🔲 `little-snitch` — outbound firewall; blocks app network calls you didn't approve; install via `brew install --cask little-snitch` or direct download (not free)
- 🔲 `NextDNS`

Menubar CPU, RAM, network display.

- Example (free): Stats — `brew install --cask stats`
- Or Linux style CLI tools enough (e.g. `htop`)

## Phase 10 — SSH

- 🔲 `ssh-keygen -t ed25519 -C "maodou-mac"`
- 🔲 `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`
- 🔲 Add to `~/.ssh/config`: `UseKeychain yes` and `AddKeysToAgent yes`
- 🔲 `gh auth login` (needed to add SSH key to GitHub)
- 🔲 `gh ssh-key add ~/.ssh/id_ed25519.pub --title "maodou-mac"`
- 🔲 Switch dotfiles remote to SSH: `git remote set-url origin git@github.com:burke-does-work/dotfiles.git`
- 🔲 Add maodou-mac host entry to `ssh/config` in dotfiles **(Claude)**
- 🔲 Test: `ssh pickle-pi`

## Phase 11 — NFS

- ✅ Add autofs setup script for Mac `/Volumes` mount points **(Claude)**
- ✅ Remove manual NFS mount aliases from Mac zshrc **(Claude)**
- ✅ Run autofs setup script
- ✅ Test: access both shares, verify read/write

## Phase 12 - Cleanup

Do this only after confirming maodou-mac is fully working.

- 🔲 Verify all needed files are on Mac or pickle-pi
- 🔲 Revoke matt-9000 SSH key from GitHub
- 🔲 Remove secrets and credentials that shouldn't persist on matt-9000
- 🔲 Decide matt-9000's ongoing network role
