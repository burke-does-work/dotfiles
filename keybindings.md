# Keybindings Reference

Key names are written as the event each app receives after Karabiner remapping,
not necessarily the original label printed on the keyboard.

## Universal Vim

Applies across VS Code and Neovim unless overridden.

| Shortcut            | Action                        |
| ---                 | ---                           |
| `h/j/k/l`           | Move left/down/up/right       |
| `gg` / `G`          | Top / bottom of file          |
| `ctrl+u` / `ctrl+d` | Half-page up / down           |
| `w` / `b`           | Next / previous word          |
| `0` / `$`           | Start / end of line           |
| `/`, `n`, `N`       | Search, next, previous        |
| `i` / `a`           | Insert before / after cursor  |
| `o` / `O`           | New line below / above        |
| `dd` / `yy` / `p`   | Delete line / yank line / put |
| `u` / `ctrl+r`      | Undo / redo                   |
| `ciw` / `diw`       | Change / delete inner word    |
| `v` / `V`           | Visual character / line mode  |
| `>` / `<`           | Indent / dedent selection     |
| `J`                 | Join lines                    |
| `gt` / `gT`         | Next / previous tab           |

Clipboard pattern:

- Standard `d`, `x`, and `c` cut to the clipboard.
- Leader variants send to the blackhole register.
- Mouse selection in Ghostty copies to the clipboard.

## Leader Key

Leader is `space` in VS Code and Neovim.

| Shortcut   | Action                                 |
| ---        | ---                                    |
| `<Space>d` | Delete operator to blackhole           |
| `<Space>D` | Delete to end of line to blackhole     |
| `<Space>x` | Delete char to blackhole               |
| `<Space>X` | Delete char before cursor to blackhole |
| `<Space>c` | Change operator to blackhole           |
| `<Space>C` | Change to end of line to blackhole     |

## Window Management

AeroSpace manages workspaces and tiling. Raycast handles app launching and window
search. macOS Spaces are not used.

| Shortcut              | Action                          |
| ---                   | ---                             |
| `alt+0`               | Workspace `0-blank`             |
| `alt+1`               | Workspace `1-main`              |
| `alt+2`               | Workspace `2-focus`             |
| `alt+3`               | Workspace `3-admin`             |
| `alt+4`               | Workspace `4-coms`              |
| `alt+5`               | Workspace `5-play`              |
| `alt+6-8`             | Workspaces `6-8`                |
| `alt+shift+0-8`       | Move window to workspace        |
| `alt+h/j/k/l`         | Focus window left/down/up/right |
| `alt+shift+h/j/k/l`   | Move window left/down/up/right  |
| `alt+-` / `alt+=`     | Resize smaller / larger         |
| `alt+,`               | Toggle layout                   |
| `alt+space`           | Raycast                         |
| `shift+alt+space`     | Raycast window search           |
| `hyper+alt+space`     | Raycast workspace window search |

## System

| Shortcut        | Action                            |
| ---             | ---                               |
| `super+space`   | Toggle English / Chinese input    |
| `super+shift+s` | Screenshot selection to clipboard |

## Ghostty

Ghostty is excluded from the ctrl/super swap. ctrl is ctrl and super is super.

| Shortcut                | Action                      |
| ---                     | ---                         |
| `ctrl+shift+t`          | New tab                     |
| `ctrl+shift+w`          | Close surface               |
| `ctrl+tab`              | Next tab                    |
| `ctrl+shift+tab`        | Previous tab                |
| `ctrl+shift+r`          | Set tab title               |
| `ctrl+shift+enter`      | New split right             |
| `ctrl+shift+b`          | New split down              |
| `ctrl+shift+h/j/k/l`    | Move split focus            |
| `ctrl+shift+left/right` | Resize split narrower/wider |
| `ctrl+shift+up/down`    | Resize split taller/shorter |
| `ctrl+shift+0`          | Reset split sizes           |
| `ctrl+shift+c`          | Copy active selection       |
| `ctrl+shift+v`          | Paste                       |

## Claude Code

Runs in Ghostty, so Ghostty intercepts some chords. `ctrl+shift+b` is reserved
for Ghostty splits; Claude brief is on `ctrl+shift+i`.

| Shortcut                   | Action                  |
| ---                        | ---                     |
| `ctrl+r`                   | History search          |
| `ctrl+t`                   | Toggle todos            |
| `ctrl+o`                   | Toggle transcript       |
| `ctrl+shift+i`             | Toggle brief            |
| `ctrl+shift+o`             | Toggle teammate preview |
| `enter`                    | Submit                  |
| `escape`                   | Cancel                  |
| `ctrl+p` / `super+p`       | Model picker            |
| `ctrl+l`                   | Clear input             |
| `ctrl+s`                   | Stash                   |
| `ctrl+j`                   | New line                |
| `ctrl+g` / `ctrl+x ctrl+e` | External editor         |
| `up` / `down`              | History previous / next |
| `shift+tab`                | Cycle mode              |
| `super+o`                  | Fast mode               |
| `super+t`                  | Thinking toggle         |
| `ctrl+b`                   | Background task         |

## Codex

Codex keybindings are configured in `config/codex/config.toml` under
`[tui.keymap]` when custom bindings are needed.

## fzf

| Shortcut | Action                 |
| ---      | ---                    |
| `ctrl+t` | File path picker       |
| `ctrl+r` | Command history picker |
| `alt+c`  | Directory picker       |

## Yazi

`D` is nooped to prevent accidental permanent deletion; empty trash manually when needed.

| Shortcut    | Action                                        |
| ---         | ---                                           |
| `a`         | Create file; append `/` to name for directory |
| `r`         | Rename                                        |
| `d`         | Cut                                           |
| `cc`        | Copy file path                                |
| `delete`    | Move to trash                                 |
| `enter`     | Open                                          |
| `space`     | Toggle selection                              |
| `ctrl+a`    | Select all                                    |
| `ctrl+r`    | Invert selection                              |
| `.`         | Toggle hidden files                           |
| `f`         | Filter files                                  |
| `s` / `S`   | Search by name (fd) / content (ripgrep)       |
| `z` / `Z`   | Jump via fzf / zoxide                         |
| `t`         | New tab                                       |
| `[` / `]`   | Previous / next tab                           |
| `1 / 2 / 3` | Select tab (1, 2, 3, etc.)                    |


## VS Code

VS Code participates in the ctrl/super swap. GUI-style shortcuts are written as
the event VS Code receives.

| Shortcut           | Action                             |
| ---                | ---                                |
| `ctrl+tab`         | Next editor / panel tab            |
| `ctrl+shift+tab`   | Previous editor / panel tab        |
| `ctrl+1-8`         | Select editor tab 1-8              |
| `ctrl+9`           | Select last editor tab             |
| `super+shift+b`    | Toggle sidebar                     |
| `super+shift+-/=`  | Decrease / increase pane           |
| `ctrl+shift+o`     | Search symbols in current document |
| `ctrl+t`           | Search symbols across workspace    |
| `ctrl+p`           | Search files                       |
| `ctrl+k ctrl+p`    | Search open tabs/editors           |
| `tab`              | Accept suggestion                  |
| `super+g`          | Dismiss suggestions                |

Enter does not accept suggestions.

## Vimium

Known limitation: Vimium conflicts with Google Sheets. Disable Vimium on Sheets
when native spreadsheet shortcuts matter.

| Shortcut      | Action                                          |
| ---           | ---                                             |
| `h/j/k/l`     | Scroll left/down/up/right                       |
| `gg` / `G`    | Top / bottom of page                            |
| `d` / `u`     | Half page down / up                             |
| `f` / `F`     | Open link current tab / new tab                 |
| `yf`          | Copy link URL                                   |
| `r`           | Reload                                          |
| `i`           | Ignore Vimium until escape                      |
| `yy`          | Copy current URL                                |
| `H` / `L`     | Back / forward                                  |
| `t`           | New tab                                         |
| `x`           | Close tab                                       |
| `gt` / `gT`   | Next / previous tab                             |
| `/`, `n`, `N` | Find, next, previous                            |
| `v` / `V`     | Visual mode / visual line mode                  |
| `o` / `O`     | Open URL/bookmark/history current tab / new tab |
| `T`           | Search open tabs                                |
| `ge` / `gE`   | Edit current URL current tab / new tab          |

## Neovim

Uses Vim keybindings. Tool-specific additions:

| Shortcut     | Action                |
| ---          | ---                   |
| `<Space>tm`  | Toggle vim-table-mode |
| `<Space>tdd` | Delete table row      |
| `<Space>tdc` | Delete table column   |
| `<Space>tic` | Insert table column   |
| `<Space>ts`  | Sort table by column  |
