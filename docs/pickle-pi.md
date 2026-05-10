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
