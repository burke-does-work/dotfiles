# Keybindings Reference

## Universal

Vim motions — apply across VS Code (vim extension) and Neovim unless overridden.

| Shortcut    | Action                        |
| ----------- | ----------------------------- |
| hjkl        | Move left/down/up/right       |
| gg / G      | Go to top / bottom of file    |
| Ctrl+u / d  | Half-page up / down           |
| w / b       | Next / prev word              |
| 0 / $       | Start / end of line           |
| / + Enter   | Search forward                |
| n / N       | Next / prev search result     |
| i / a       | Insert before / after cursor  |
| o / O       | New line below / above        |
| dd / yy / p | Delete line / yank line / put |
| u / Ctrl+r  | Undo / redo                   |
| ciw / diw   | Change / delete inner word    |
| v / V       | Visual char / line mode       |
| > / <       | Indent / dedent selection     |

Copy/paste/delete notes:

- `d`, `x`, `c` are standard vim — cut to clipboard.
- `<Space>d`, `<Space>x`, `<Space>c` (and uppercase variants) send to the blackhole register — no clipboard effect.
- `<Space>` is the leader key in normal mode.
- `Ctrl+C` / `Ctrl+V` for copy/paste — use in Chrome only. Do not use in terminal, Claude, Neovim, or VS Code (these intercept the keys).
- Vi-mode with Wayland clipboard integration. Yank/delete operations sync to the system clipboard; `p`/`P` paste from system clipboard.

## Leader key (Space)

Applies in VS Code and Neovim only. Not implemented in zsh (ZLE has no operator-pending mode).

| Shortcut   | Action                             |
| ---------- | ---------------------------------- |
| \<Space\>d | Delete (operator) to blackhole     |
| \<Space\>D | Delete to end of line to blackhole |
| \<Space\>x | Delete char to blackhole           |
| \<Space\>X | Delete char before to blackhole    |
| \<Space\>c | Change (operator) to blackhole     |
| \<Space\>C | Change to end of line to blackhole |

## GNOME

| Shortcut | Action               |
| -------- | -------------------- |
| Super+1  | Raise Kitty terminal |

## Kitty

| Shortcut              | Action                        |
| --------------------- | ----------------------------- |
| Ctrl+Shift+T          | New tab                       |
| Ctrl+Shift+Alt+T      | Set tab title (persists)      |
| Ctrl+Tab              | Next tab                      |
| Ctrl+Shift+Tab        | Previous tab                  |
| Ctrl+Shift+R          | Vertical split                |
| Ctrl+Shift+B          | Horizontal split              |
| Ctrl+Shift+W          | Close split                   |
| Ctrl+Shift+H/J/K/L    | Move focus left/down/up/right |
| Ctrl+Shift+Left/Right | Resize split narrower/wider   |
| Ctrl+Shift+Up/Down    | Resize split taller/shorter   |
| Ctrl+Shift+0          | Reset split sizes             |
| Ctrl+=                | Font size increase            |
| Ctrl+-                | Font size decrease            |
| Ctrl+0                | Font size reset               |

## VS Code

### Global Navigation

| Shortcut       | Action                   |
| -------------- | ------------------------ |
| Ctrl+Tab       | Next editor / panel tab  |
| Ctrl+Shift+Tab | Prev editor / panel tab  |
| Ctrl+Shift+B   | Toggle sidebar           |
| Ctrl+Shift+-/= | Decrease / increase pane |

### Intellisense

| Shortcut | Action              |
| -------- | ------------------- |
| Tab      | Accept suggestion   |
| Ctrl+G   | Dismiss suggestions |

### Jupyter interactive window

| Shortcut      | Action                   |
| ------------- | ------------------------ |
| Enter         | Execute cell             |
| Shift+Enter   | New line in cell         |
| Ctrl+K Ctrl+R | Restart kernel + run all |

## Neovim

Uses Vim keybindings — see Universal. Tool-specific overrides listed below.

### Table plug-in

| Shortcut     | Action                                     |
| ------------ | ------------------------------------------ |
| \<Space\>tm  | Toggle vim-table-mode                      |
| \<Space\>tr  | Realign table                              |
| \<Space\>tt  | Tableize (convert delimited text to table) |
| \<Space\>tdd | Delete row                                 |
| \<Space\>tdc | Delete column                              |
| \<Space\>tic | Insert column                              |
| \<Space\>ts  | Sort table by column                       |

## Ranger

| Shortcut | Action        |
| -------- | ------------- |
| Delete   | Move to trash |
