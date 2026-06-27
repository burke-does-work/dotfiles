# Reverse VPN — SPEC

## Problem

Home network sits behind ISP CG-NAT, making direct inbound connections impossible. The goal is remote access to the LAN from anywhere without opening firewall ports or port forwarding.

---

## Hardware

- **Router:** GL.iNet Slate 7 (GL-BE3600)
- **ISP:** CG-NAT (no public inbound IP)
- **WAN (current):** ISP connection
- **WAN (future):** Starlink (Step 3)

## Solution

Tailscale on GL.iNet Slate 7 as a LAN exit node. Tailscale connects outbound through CG-NAT to its coordination server. Client devices join the same Tailscale network and route all traffic through the router, which acts as the exit node.

**Firmware note:** Ensure Slate 7 is on firmware 4.8 or later — this is the version that added native exit node support for this model. After enabling the exit node, disable key expiry in the Tailscale admin console to prevent connectivity dropping when the auth key expires.

**Admin panel access (macOS):** Chrome blocks HTTP access to local router IPs on macOS — use Safari to access `http://192.168.8.1`.

```
[Laptop / Phone]
      |
  Tailscale
      |
[GL.iNet Router] ← exit node
      |
   Home LAN
      |
[Raspberry Pi's]
```

## Static IP Assignments
| Device         | IP            | MAC               |
| -------------- | ------------- | ----------------- |
| maodou-mac     | 192.168.8.224 | FC:B2:14:30:48:22 |
| USW-Lite-8-PoE | 192.168.8.156 | 28:70:4E:CB:76:29 |
| pickle-pi      | 192.168.8.154 | D8:3A:DD:18:08:09 |
| Ubiquiti AP    | 192.168.8.161 | 28:70:4E:55:9A:AC |
| maodou-pi      | 192.168.8.232 | 88:A2:9E:73:D7:A4 |
| maodou-pi-wifi | 192.168.8.233 | 88:A2:9E:73:D7:A5 |

Tailscale subnet (from router)

192.168.8.0/24

---

## Epic: Remote LAN Access

### Step 1 — Router Switchover (Critical Path)

Switch from Slate X (GL-AXT1800) to Slate 7 (GL-BE3600) before any Tailscale configuration. All subsequent steps depend on the new router being in place and LAN config verified.

**Before switching — document current Slate X config:**
- Record all static IP assignments (MAC address → IP for each device)
- Record static IP for `pickle-pi` specifically (required for NFS reconfiguration in Step 2b)
- Record DHCP range
- Record Wi-Fi SSIDs and passwords
- Record any other LAN settings (DNS, reserved addresses, etc.)

**Switchover:**
- Install Slate 7 and connect to WAN
- Recreate static IP assignments on Slate 7 (match MAC → IP exactly)
- Recreate Wi-Fi credentials
- Confirm internet connectivity

**Verify LAN config transferred correctly:**
- Confirm each device receives its expected static IP
- SSH into each device by IP and confirm connection
- Confirm no IP conflicts on the LAN

**Decommission:**
- Power down Slate X once all verification passes

### Step 2 — Tailscale Setup (Critical Path)

- Create account at tailscale.com
- In Slate 7 admin panel → Applications → Tailscale → enable and log in
- Approve router as a device in Tailscale admin console
- Enable router as exit node in Tailscale admin console
- Disable key expiry on the exit node (prevents auth key expiration dropping the tunnel)
- Install Tailscale on client devices (laptop, phone)
- Invite second user (wife) to the tailnet and install Tailscale on her devices
- Connect to exit node on each client device and verify

**China travel note:** Tailscale reliability in China is not guaranteed — the Great Firewall may block outbound connections to Tailscale's coordination server, which all devices must reach to authenticate and establish the tunnel. This must be tested. Wife is currently in China on a MacBook Air — install Tailscale and test as part of this project. If the coordination server is blocked, Tailscale will not work from China and an alternative solution is out of scope.

**Firmware v4.8.x deviation:** "Run Exit Node" is a v4.9+ UI feature. On v4.8.3 (current), exit node requires manual configuration — see Implementation section below.

### Step 2b — NFS Reconfiguration (maodou-mac)

The automount on `maodou-mac` uses `pickle-pi.local` (Bonjour/mDNS), which only resolves on the local network and will fail when remote via Tailscale. Reconfigure using `pickle-pi`'s static IP so NFS mounts work both on LAN and remotely.

```bash
PICKLE_PI_HOST=192.168.8.154 setup/setup_macos_nfs_mounts.sh
```

- `192.168.8.154` is `pickle-pi`'s static IP (now the default in the script)
- Verify mounts on LAN after reconfiguration: `ls ~/local/pickle-pi-drive_data`
- Verify mounts remotely after Tailscale is connected (off-LAN, mobile data)

**Note:** `pickle-pi`'s NFS exports restrict to `192.168.8.0/24`. This is not an issue — the router masquerades Tailscale traffic so `pickle-pi` sees requests as coming from the LAN subnet.

### Step 3 — Starlink Setup (Not Critical Path)

#### Outdoor Ethernet (Starlink to building)

- Nail Starlink down to table; nail all furniture to plywood under deck flooring via u-bolt
- Run outdoor-rated patch cable (unshielded) from Starlink along the edge of the building back to entry point; consider covering/protecting the run
- Strain relief at point where cable first hits the building (protects against Starlink being moved or tugged)
- Drip loop before apartment entry point

#### Indoor Ethernet Run

- Pass cable through existing fiber entry point; enlarge hole if needed (no sealant required)
- Terminate at Surface-mount low-voltage box with RJ45 Cat6 feed-through keystone (e.g. Leviton 41089 single-port surface box + Monoprice Cat6 RJ45 keystone inline coupler, unshielded, female–female)
- Run patch cable from keystone to GL.iNet router WAN port

#### Power (Starlink to supply)

- Amphenol-to-Powerpole extension cord from Starlink
- Strain relief against building exterior
- Drip loop before entry
- Run through fiber hole with Powerpole side terminating inside
- Prefer right-angle PP connector inside fiber hole (not required)
- Strain relief after entry point
- Connect to AC/DC plug wire with PP terminals
- Label polarity
- Consider in-line fuse adjacent to AC plug

#### Notes

- Starlink Mini — no PoE
- Setup is fully modular; no terminated patch cables, no keystone jack hardwired to wall

#### Tailscale Validation over Starlink

- Connect GL.iNet router WAN to Starlink
- Confirm Tailscale exit node reconnects through Starlink
- Run all acceptance tests over Starlink connection to verify parity with previous WAN

---

## Implementation

### Tailscale network
- Tailnet: `taila37c5e.ts.net`
- Router: `pickle-palace-router` — `100.115.111.31`
- maodou-mac: `100.109.179.51`
- Home public IP (CG-NAT): `76.191.151.66`

### Router configuration (Slate 7, firmware v4.8.3)

**Via admin panel** (`http://192.168.8.1` in Safari):
- Applications → Tailscale: enabled, logged in as `burke-does-work@github`
- Allow Remote Access LAN: enabled
- Allow Remote Access WAN: disabled
- Key expiry: disabled in Tailscale admin console

**Via Tailscale admin console** (tailscale.com/admin):
- Subnet routes `192.168.8.0/24` approved
- Exit node approved

**Via SSH** (exit node + firewall — required because v4.9 UI not yet available):

1. Add firewall forwarding rule (tailscale0 → wan), persistent via UCI:
```sh
uci add firewall forwarding
uci set firewall.@forwarding[-1].src=tailscale0
uci set firewall.@forwarding[-1].dest=wan
uci commit firewall
/etc/init.d/firewall restart
```

2. Add exit node config option to `/etc/config/tailscale`:
```sh
uci set tailscale.settings.advertise_exit_node=1
uci commit tailscale
```

3. Patch `/usr/bin/gl_tailscale` — add these two lines immediately before the `tailscale up` call at the bottom of the `restart` action:
```sh
advertise_exit_node=$(uci -q get tailscale.settings.advertise_exit_node)
[ "$advertise_exit_node" = "1" ] && param="$param --advertise-exit-node"
```

4. Apply:
```sh
gl_tailscale restart
```

**Firmware upgrade path (v4.9+):** Use "Run Exit Node" toggle in admin panel → Applications → Tailscale. Remove the `gl_tailscale` patch and the `advertise_exit_node` UCI option. Re-approve exit node in Tailscale admin console if needed.

### NFS (maodou-mac)

`setup/setup_macos_nfs_mounts.sh` line 9 default changed from `pickle-pi.local` to `192.168.8.154`. Script re-run on `maodou-mac`. Symlinks at `~/local/pickle-pi-drive_data` and `~/local/pickle-pi-hdd_data`.

### Acceptance test results (ISP WAN — passed)

| # | Test | Result |
|---|------|--------|
| 1 | SSH into `pickle-pi` and `maodou-pi` from mobile data | ✓ |
| 2 | NFS mounts and video playback remotely | ✓ |
| 3 | `curl ifconfig.me` shows `76.191.151.66` with exit node active | ✓ |
| 4 | Toggle exit node; IP switches correctly | ✓ |

---

## Acceptance Tests

These must all pass to close the project.

| #   | Test                                        | Pass Condition                                                                                        |
| --- | ------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| 1   | SSH into a Pi from outside the home network | SSH connects to Pi via LAN IP on mobile data (Wi-Fi off)                                              |
| 2   | NFS share mounts and video plays remotely   | Connect Tailscale off-LAN, access `~/local/pickle-pi-drive_data`, open video in VLC, confirm playback |
| 3   | Full-traffic routing through home IP        | whatismyip.com shows home IP when exit node is active                                                 |
| 4   | Toggle routing on/off                       | Tailscale exit node can be enabled and disabled; traffic routes correctly in both states              |

---

## Out of Scope

- **GUI** — will only become in-scope if Tailscale's native app is insufficient for toggling the exit node
- Self-hosted coordination server (Headscale)
- VPS relay
- Tailscale installed on individual Pi's
- Alternative China access solution if Tailscale coordination server is blocked

---

## Notes

**Tailscale dependency:** This solution relies entirely on Tailscale's coordination server and free tier. If Tailscale goes down, changes pricing, or is blocked, there is no fallback. Headscale (self-hosted coordination server) is the migration path if this becomes a concern — revisit if Tailscale fails to meet requirements.
