# pickle-pi

Raspberry Pi on the LAN. Used for local storage and related home services.

## Connect

```bash
ssh pickle-pi
```

The host alias is defined in `ssh/config`.

## Dotfile Deployment

The Pi shell config is maintained here and deployed manually:

| File in repo | Deployed to |
| --- | --- |
| `zshrc_pickle-pi` | `~/.zshrc` |
| `ssh/config` | `~/.ssh/config` |

Deploy shell changes with:

```bash
scp zshrc_pickle-pi pickle-pi:~/.zshrc
```

## Storage

NFS mount aliases are defined in the shell config. Operational setup history is
archived under `setup/archive/`.

Exports used by Mac and Linux clients:

| Export | Local macOS mount point |
| --- | --- |
| `pickle-pi:/mnt/drive_data` | `/Volumes/pickle-pi-drive_data` |
| `pickle-pi:/mnt/hdd_data` | `/Volumes/pickle-pi-hdd_data` |

On macOS, configure automatic on-demand mounts with:

```bash
setup/setup_macos_nfs_mounts.sh
```

The macOS setup defaults to `pickle-pi.local`, which is the Bonjour/mDNS name
macOS resolves on the local network.

If macOS cannot resolve `pickle-pi.local`, pass the Pi's IP address or another
resolvable LAN hostname:

```bash
PICKLE_PI_HOST=192.168.1.x setup/setup_macos_nfs_mounts.sh
```

The setup script installs `/etc/auto_pickle_pi`, registers it in
`/etc/auto_master`, and reloads automount. After that, opening either path
mounts the share automatically.

```bash
ls /Volumes/pickle-pi-drive_data
ls /Volumes/pickle-pi-hdd_data
```
