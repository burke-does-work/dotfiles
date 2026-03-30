# pickle-pi

Raspberry Pi on LAN. Serves NFS shares and runs the field_notes agent (Rusty).

## Connecting

```bash
ssh pickle-pi
```

Host alias is defined in `ssh/config`. Key-based auth, passphrase cached by GNOME Keyring.

## Config files

The Pi's shell config is maintained in this repo and deployed manually (no symlink):

| File in dotfiles      | Deployed to (on pickle-pi) |
| --------------------- | -------------------------- |
| `zshrc_pickle-pi`     | `~/.zshrc`                 |
| `ssh/config`          | `~/.ssh/config`            |

To deploy a change:

```bash
scp zshrc_pickle-pi pickle-pi:~/.zshrc
```

## NFS share

pickle-pi exposes a drive over NFS. Mount it from this machine with the `mountnfs` alias.

## field_notes agent (Rusty)

Rusty is a separate project — see `/mnt/ssd2_data/documents/field_notes_pi/` for its documentation.
