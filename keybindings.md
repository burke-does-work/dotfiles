# Keybindings Reference

Key names are written as the event each app receives after Karabiner remapping,
not necessarily the original label printed on the keyboard.

## Universal Vim

Applies across VS Code and Neovim unless overridden.

| Shortcut            | Action                        |
| ---                 | ---                           |
| `h/j/k/l`           | Move left/down/up/right       |
| `gg` / `G`          | Top / bottom of file          |
| `Ctrl+u` / `Ctrl+d` | Half-page up / down           |
| `w` / `b`           | Next / previous word          |
| `0` / `$`           | Start / end of line           |
| `/`, `n`, `N`       | Search, next, previous        |
| `i` / `a`           | Insert before / after cursor  |
| `o` / `O`           | New line below / above        |
| `dd` / `yy` / `p`   | Delete line / yank line / put |
| `u` / `Ctrl+r`      | Undo / redo                   |
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

Leader is `Space` in VS Code and Neovim.

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

| Shortcut                | Action                          |
| ---                     | ---                             |
| `Option+1`              | Workspace `1-main`              |
| `Option+2`              | Workspace `2-focus`             |
| `Option+3`              | Workspace `3-coms`              |
| `Option+4`              | Workspace `4-play`              |
| `Option+5`              | Workspace `5-blank`             |
| `Option+6-9`            | Workspaces `6-9`                |
| `Option+Shift+1-9`      | Move window to workspace        |
| `Option+Tab`            | Last workspace                  |
| `Option+Shift+Tab`      | Move workspace to next monitor  |
| `Option+H/J/K/L`        | Focus window left/down/up/right |
| `Option+Shift+H/J/K/L`  | Move window left/down/up/right  |
| `Option+-` / `Option+=` | Resize smaller / larger         |
| `Option+,`              | Toggle layout                   |
| `Option+Space`          | Raycast                         |
| `Shift+Option+Space`    | Raycast window search           |
| `Hyper+Option+Space`    | Raycast workspace window search |

## System

| Shortcut      | Action                            |
| ---           | ---                               |
| `Cmd+Space`   | Toggle English / Chinese input    |
| `Cmd+Shift+S` | Screenshot selection to clipboard |

## Ghostty

Ghostty is excluded from the Ctrl/Cmd swap. Ctrl is Ctrl and Cmd is Cmd.

| Shortcut                | Action                      |
| ---                     | ---                         |
| `Ctrl+Shift+T`          | New tab                     |
| `Ctrl+Shift+W`          | Close surface               |
| `Ctrl+Tab`              | Next tab                    |
| `Ctrl+Shift+Tab`        | Previous tab                |
| `Ctrl+Shift+R`          | Set tab title               |
| `Ctrl+Shift+Enter`      | New split right             |
| `Ctrl+Shift+B`          | New split down              |
| `Ctrl+Shift+H/J/K/L`    | Move split focus            |
| `Ctrl+Shift+Left/Right` | Resize split narrower/wider |
| `Ctrl+Shift+Up/Down`    | Resize split taller/shorter |
| `Ctrl+Shift+0`          | Reset split sizes           |
| `Ctrl+Shift+C`          | Copy active selection       |
| `Ctrl+Shift+V`          | Paste                       |

## Claude Code

Runs in Ghostty, so Ghostty intercepts some chords. `Ctrl+Shift+B` is reserved
for Ghostty splits; Claude brief is on `Ctrl+Shift+I`.

| Shortcut                   | Action                  |
| ---                        | ---                     |
| `Ctrl+R`                   | History search          |
| `Ctrl+T`                   | Toggle todos            |
| `Ctrl+O`                   | Toggle transcript       |
| `Ctrl+Shift+I`             | Toggle brief            |
| `Ctrl+Shift+O`             | Toggle teammate preview |
| `Enter`                    | Submit                  |
| `Escape`                   | Cancel                  |
| `Ctrl+P` / `Cmd+P`         | Model picker            |
| `Ctrl+L`                   | Clear input             |
| `Ctrl+S`                   | Stash                   |
| `Ctrl+J`                   | New line                |
| `Ctrl+G` / `Ctrl+X Ctrl+E` | External editor         |
| `Up` / `Down`              | History previous / next |
| `Shift+Tab`                | Cycle mode              |
| `Cmd+O`                    | Fast mode               |
| `Cmd+T`                    | Thinking toggle         |
| `Ctrl+B`                   | Background task         |

## Codex

Codex keybindings are configured in `config/codex/config.toml` under
`[tui.keymap]` when custom bindings are needed.

## fzf

| Shortcut | Action                 |
| ---      | ---                    |
| `Ctrl+T` | File path picker       |
| `Ctrl+R` | Command history picker |
| `Alt+C`  | Directory picker       |

## Yazi

`D` is nooped to prevent accidental permanent deletion; empty trash manually when needed.

| Shortcut    | Action                                        |
| ---         | ---                                           |
| `a`         | Create file; append `/` to name for directory |
| `r`         | Rename                                        |
| `d`         | Cut                                           |
| `<Delete>`  | Move to trash                                 |
| `Enter`     | Open                                          |
| `Space`     | Toggle selection                              |
| `Ctrl+A`    | Select all                                    |
| `Ctrl+R`    | Invert selection                              |
| `.`         | Toggle hidden files                           |
| `f`         | Filter files                                  |
| `s` / `S`   | Search by name (fd) / content (ripgrep)       |
| `z` / `Z`   | Jump via fzf / zoxide                         |
| `t`         | New tab                                       |
| `[` / `]`   | Previous / next tab                           |
| `1 / 2 / 3` | Select tab (1, 2, 3, etc.)                    |

## VS Code

VS Code participates in the Ctrl/Cmd swap. GUI-style shortcuts are written as
the event VS Code receives.

| Shortcut         | Action                             |
| ---              | ---                                |
| `Ctrl+Tab`       | Next editor / panel tab            |
| `Ctrl+Shift+Tab` | Previous editor / panel tab        |
| `Ctrl+1-8`       | Select editor tab 1-8              |
| `Ctrl+9`         | Select last editor tab             |
| `Cmd+Shift+B`    | Toggle sidebar                     |
| `Cmd+Shift+-/=`  | Decrease / increase pane           |
| `Ctrl+Shift+O`   | Search symbols in current document |
| `Ctrl+T`         | Search symbols across workspace    |
| `Ctrl+P`         | Search files                       |
| `Ctrl+K Ctrl+P`  | Search open tabs/editors           |
| `Tab`            | Accept suggestion                  |
| `Cmd+G`          | Dismiss suggestions                |

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
| `i`           | Ignore Vimium until Escape                      |
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
