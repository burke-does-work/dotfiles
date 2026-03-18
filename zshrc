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

# Mount local SSD
alias mountlocal='sudo bash /home/matt/ssd2_drive_mount.sh'

# Mount NFS network drive
alias mountnfs='sudo bash /home/matt/nfs_mount.sh'

# Open keybindings reference
alias keybindings='nvim ~/dotfiles/keybindings.md'

##### ──────────────────────────────────────────────────────────────────────────
##### Startup behaviour
##### ──────────────────────────────────────────────────────────────────────────

# Change to data drive on startup if mounted
if [[ -d /mnt/ssd2_data ]]; then
    cd /mnt/ssd2_data
fi
