# ~/.zshrc
# Author: MTB

##### ──────────────────────────────────────────────────────────────────────────
##### PATH
##### ──────────────────────────────────────────────────────────────────────────

# Add user local binaries to PATH (kitty, etc.)
path=($HOME/.local/bin $path)

# Add personal helper scripts to PATH
path=($HOME/helper_scripts $path)

# Add global npm packages to PATH (claude code, etc.)
path=($HOME/.npm-global/bin $path)

##### ──────────────────────────────────────────────────────────────────────────
##### Pyenv
##### ──────────────────────────────────────────────────────────────────────────

# Set pyenv root directory
export PYENV_ROOT="$HOME/.pyenv"

# Add pyenv to PATH
[[ -d $PYENV_ROOT/bin ]] && path=($PYENV_ROOT/bin $path)

# Initialise pyenv shell integration
eval "$(pyenv init - zsh)"

# Initialise pyenv virtual environment management
eval "$(pyenv virtualenv-init -)"

##### ──────────────────────────────────────────────────────────────────────────
##### Plugins
##### ──────────────────────────────────────────────────────────────────────────

# Load antidote plugin manager
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh

# Load plugins from ~/.zsh_plugins.txt
antidote load

##### ──────────────────────────────────────────────────────────────────────────
##### Prompt
##### ──────────────────────────────────────────────────────────────────────────

# Initialize Starship prompt
eval "$(starship init zsh)"

##### ──────────────────────────────────────────────────────────────────────────
##### fzf
##### ──────────────────────────────────────────────────────────────────────────

# Load fzf keybindings and completion
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

##### ──────────────────────────────────────────────────────────────────────────
##### Vi mode
##### ──────────────────────────────────────────────────────────────────────────

# Enable vi keybindings
bindkey -v

# Reduce ESC delay from 0.4s to 0.1s
export KEYTIMEOUT=1

##### ──────────────────────────────────────────────────────────────────────────
##### Cursor shape
##### ──────────────────────────────────────────────────────────────────────────

# Block cursor in normal mode, line cursor in insert mode
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        echo -ne '\e[1 q'  # Block cursor for normal mode
    else
        echo -ne '\e[5 q'  # Line cursor for insert mode
    fi
}

# Line cursor for insert mode on startup
function zle-line-init {
    echo -ne '\e[5 q'
}

zle -N zle-keymap-select
zle -N zle-line-init

##### ──────────────────────────────────────────────────────────────────────────
##### Vi mode — Wayland clipboard integration
##### ──────────────────────────────────────────────────────────────────────────

_zle-to-clipboard()   { echo -n "$CUTBUFFER" | wl-copy }
_zle-from-clipboard() { CUTBUFFER=$(wl-paste -n 2>/dev/null) }

# Yank → system clipboard
_zle-vi-yank()            { zle .vi-yank;            _zle-to-clipboard }
_zle-vi-yank-whole-line() { zle .vi-yank-whole-line; _zle-to-clipboard }
zle -N vi-yank            _zle-vi-yank
zle -N vi-yank-whole-line _zle-vi-yank-whole-line

# Delete → system clipboard
# vi-backward-delete-char (X in normal, Backspace in insert) is intentionally not overridden
# to avoid freezing on repeated backspace.
_zle-vi-delete-char() { zle .vi-delete-char; [[ $KEYMAP == vicmd ]] && _zle-to-clipboard }
_zle-kill-whole-line() { zle .kill-whole-line; _zle-to-clipboard }
zle -N vi-delete-char  _zle-vi-delete-char
zle -N kill-whole-line _zle-kill-whole-line

# Paste ← system clipboard (p / P always paste from system clipboard)
_zle-vi-put-after()  { _zle-from-clipboard; zle .vi-put-after  }
_zle-vi-put-before() { _zle-from-clipboard; zle .vi-put-before }
zle -N vi-put-after  _zle-vi-put-after
zle -N vi-put-before _zle-vi-put-before

##### ──────────────────────────────────────────────────────────────────────────
##### Tab completion
##### ──────────────────────────────────────────────────────────────────────────

# Initialize zsh completion system
autoload -Uz compinit && compinit

# Use cache for faster completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Highlight selected option in completion menu
zstyle ':completion:*' menu select

##### ──────────────────────────────────────────────────────────────────────────
##### History
##### ──────────────────────────────────────────────────────────────────────────

# History file location and size
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Share history across all zsh sessions
setopt share_history

# Don't save duplicate commands
setopt hist_ignore_dups

##### ──────────────────────────────────────────────────────────────────────────
##### Ranger
##### ──────────────────────────────────────────────────────────────────────────

# Prevent ranger from loading both the default and custom rc.conf
export RANGER_LOAD_DEFAULT_RC=FALSE


##### ──────────────────────────────────────────────────────────────────────────
##### Aliases
##### ──────────────────────────────────────────────────────────────────────────

# Mount the encrypted external SSD at /mnt/ssd2_data.
# GNOME auto-mounts the drive at /media/matt/ssd2_world when it's plugged in, blocking our mount.
# Steps: dismiss GNOME's mount → close GNOME's LUKS device → open LUKS using /etc/crypttab
# (key file: /etc/cryptsetup-keys.d/ssd2_world.key) → mount via /etc/fstab.
# The first two steps use ; and suppress errors so they no-op cleanly if GNOME hasn't auto-mounted.
alias mountlocal='sudo umount /media/matt/ssd2_world 2>/dev/null; sudo cryptsetup close luks-3efbea31-d5bb-493b-ac77-b747808217b3 2>/dev/null; sudo cryptdisks_start ssd2_world && sudo mount /mnt/ssd2_data'

# Unmount the encrypted SSD and close the LUKS device.
alias umountlocal='sudo umount /mnt/ssd2_data && sudo cryptdisks_stop ssd2_world'

# Mount NFS shares exported by the Raspberry Pi (192.168.8.154).
# Entries are defined in /etc/fstab with noauto,_netdev — not mounted at boot.
alias mountnfs='sudo mount /mnt/nfs/drive_data && sudo mount /mnt/nfs/hdd_data'

# Unmount NFS shares.
alias umountnfs='sudo umount /mnt/nfs/drive_data && sudo umount /mnt/nfs/hdd_data'

# Open keybindings reference
alias keybindings='nvim ~/dotfiles/keybindings.md'

##### ──────────────────────────────────────────────────────────────────────────
##### Startup behaviour
##### ──────────────────────────────────────────────────────────────────────────

# Change to data drive on startup if mounted
if [[ -d /mnt/ssd2_data ]]; then
    cd /mnt/ssd2_data
fi
