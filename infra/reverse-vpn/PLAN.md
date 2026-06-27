# Plan: Reverse VPN — Remote LAN Access

## Context

Home network sits behind ISP CG-NAT. Goal is remote access to LAN (SSH into Pis, NFS mounts) from anywhere. Solution: Tailscale on GL.iNet Slate 7 as an exit node. Devices connect to Tailscale and route traffic through the router, which appears to place them on the home LAN.

Project also includes a router switchover (Slate X → Slate 7), an NFS reconfiguration to replace mDNS hostname with static IP (so mounts survive off-LAN), and a future Starlink WAN switchover with full re-validation.

**Key file:** `setup/setup_macos_nfs_mounts.sh` — default changed to `192.168.8.154` (pickle-pi static IP).

---

## Remaining

### Phase 3 — Tailscale Client Setup

- [ ] Install Tailscale on phone; confirm LAN connectivity
- [ ] Wife (China): install Tailscale on MacBook Air; join tailnet; confirm connectivity
  - China reachability validation only — project proceeds regardless of outcome

---

## Phase 6 — Starlink Setup (not critical path)

### Outdoor Ethernet (Starlink to building)
- [ ] Secure Starlink dish to table; nail furniture to plywood under deck via u-bolt
- [ ] Run outdoor-rated patch cable (unshielded) from Starlink along building edge to entry point; protect/cover run
- [ ] Strain relief where cable first contacts building
- [ ] Drip loop before apartment entry point

### Indoor Ethernet Run
- [ ] Pass cable through existing fiber entry point (enlarge hole if needed; no sealant required)
- [ ] Terminate at surface-mount low-voltage box with RJ45 Cat6 feed-through keystone (e.g. Leviton 41089 + Monoprice Cat6 unshielded female–female keystone)
- [ ] Run patch cable from keystone to Slate 7 WAN port

### Power (Starlink to supply)
- [ ] Amphenol-to-Powerpole extension cord from Starlink; strain relief on building exterior
- [ ] Drip loop before entry point
- [ ] Run through fiber hole; Powerpole side terminates inside
- [ ] Connect to AC/DC plug wire with PP terminals; label polarity
- [ ] Add in-line fuse adjacent to AC plug
- [ ] Strain relief after interior entry point

### Tailscale Validation over Starlink
- [ ] Switch Slate 7 WAN to Starlink
- [ ] Confirm Tailscale exit node reconnects through Starlink

---

## Phase 7 — Acceptance Tests (Starlink WAN)

Re-run all off-LAN tests over Starlink to confirm parity with ISP baseline.

- [ ] **Test 1a:** SSH into `pickle-pi` via LAN IP from mobile data via Starlink
- [ ] **Test 1b:** SSH into `maodou-pi` via LAN IP from mobile data via Starlink
- [ ] **Test 2:** NFS share mounts; video plays remotely via Starlink
- [ ] **Test 3:** whatismyip.com shows home IP with exit node active via Starlink
- [ ] **Test 4:** Toggle exit node on/off; verify routing correct in both states via Starlink

---

## Done

### Phase 1 — Pre-Switchover: Document Slate X Config
- [x] Verify Slate 7 firmware is 4.8 or later
- [x] Document all static IP assignments (MAC → IP) — see `slate-x-config.md`
- [x] Record `pickle-pi` static IP: `192.168.8.154`
- [x] Record `maodou-pi` static IP: `192.168.8.232`
- [x] Record DHCP range (default, not manually configured)
- [x] Record Wi-Fi SSID: `pickle-palace`

### Phase 2 — Router Switchover
- [x] Install Slate 7; connect to WAN
- [x] Recreate all static IP assignments
- [x] Wi-Fi handled by Ubiquiti AP (no credentials on Slate 7 radio)
- [x] Confirm internet connectivity
- [x] Verify `pickle-pi` SSH on 192.168.8.154
- [x] Verify `maodou-pi` SSH on 192.168.8.232
- [x] Power down Slate X

### Phase 3 — Tailscale Setup (completed items)
- [x] Create account at tailscale.com
- [x] Slate 7 admin panel → Applications → Tailscale: enable and log in
- [x] Approve router as device; disable key expiry
- [x] Enable "Allow Remote Access LAN"; approve subnet routes (192.168.8.0/24)
- [x] Install Tailscale on laptop (`maodou-mac`); confirm LAN connectivity
- [x] Invite wife to tailnet

### Phase 3b — Exit Node Fix (Firmware v4.8.x Workaround)
- [x] Run `tailscale up` with `--advertise-exit-node` via SSH
- [x] Add firewall forwarding rule: tailscale0 → wan (via UCI)
- [x] Patch `/usr/bin/gl_tailscale` to read `advertise_exit_node` UCI option
- [x] Add `advertise_exit_node=1` to `/etc/config/tailscale`
- [x] Verify exit node persists across reboot

### Phase 4 — NFS Reconfiguration (maodou-mac)
- [x] Changed default in `setup/setup_macos_nfs_mounts.sh` from `pickle-pi.local` to `192.168.8.154`
- [x] Re-ran script on `maodou-mac`
- [x] Verified mounts on LAN
- [x] Verified mounts remotely via Tailscale

### Phase 5 — Acceptance Tests (ISP WAN)
- [x] **Test 1a:** SSH into `pickle-pi` (192.168.8.154) from mobile data ✓
- [x] **Test 1b:** SSH into `maodou-pi` (192.168.8.232) from mobile data ✓
- [x] **Test 2:** NFS mounts and video playback remotely ✓
- [x] **Test 3:** `curl ifconfig.me` shows `76.191.151.66` (home IP) with exit node active ✓
- [x] **Test 4:** Toggle exit node; IP switches between `76.191.151.66` and cell IP ✓
