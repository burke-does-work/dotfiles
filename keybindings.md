# Keybindings Reference

## Universal

Vim motions — apply across VS Code (vim extension) and Neovim unless overridden.

| Shortcut     | Action                        |
| ------------ | ----------------------------- |
| hjkl         | Move left/down/up/right       |
| gg / G       | Go to top / bottom of file    |
| Ctrl+u / d   | Half-page up / down           |
| w / b        | Next / prev word              |
| 0 / $        | Start / end of line           |
| / + Enter    | Search forward                |
| n / N        | Next / prev search result     |
| i / a        | Insert before / after cursor  |
| o / O        | New line below / above        |
| dd / yy / p  | Delete line / yank line / put |
| u / Ctrl+r   | Undo / redo                   |
| ciw / diw    | Change / delete inner word    |
| v / V        | Visual char / line mode       |
| > / <        | Indent / dedent selection     |

Note:

- Vim delete keybindings (d / x / c) updated so they don't cut to the clipboard.
- A.K.A send to the blackhole registry
- For a ctrl+x behavior, yank, then delete (2 steps).
- This is the simplest update to avoid a custom keybinding rabbit hole.

## GNOME

| Shortcut | Action              |
| -------- | ------------------- |
| Super+1  | Raise Kitty terminal |

## Kitty

| Shortcut     | Action              |
| ------------ | ------------------- |
| Ctrl+Shift+T | New tab             |
| Ctrl+Shift+Q | Close tab           |
| Ctrl+Shift+H | Vertical split      |
| Ctrl+Shift+B | Horizontal split    |
| Ctrl+Shift+W | Close split         |
| Ctrl+=       | Font size increase  |
| Ctrl+-       | Font size decrease  |
| Ctrl+0       | Font size reset     |

## Zsh

Uses zsh defaults.

## VS Code

Uses Vim keybindings — see Universal. Tool-specific overrides listed below.

### Global Navigation

| Shortcut         | Action                   |
| ---------------- | ------------------------ |
| Ctrl+Tab         | Next editor / panel tab  |
| Ctrl+Shift+Tab   | Prev editor / panel tab  |
| Ctrl+Shift+B     | Toggle sidebar           |
| Ctrl+Shift+-/=   | Decrease / increase pane |

### Intellisense

| Shortcut | Action              |
| -------- | ------------------- |
| Tab      | Accept suggestion   |
| Ctrl+G   | Dismiss suggestions |

### Jupyter interactive window

| Shortcut      | Action                    |
| ------------- | ------------------------- |
| Enter         | Execute cell              |
| Shift+Enter   | New line in cell          |
| Ctrl+K Ctrl+R | Restart kernel + run all  |

## Neovim

Uses Vim keybindings — see Universal. Tool-specific overrides listed below.

| Shortcut | Action              |
| -------- | ------------------- |
| \tm      | Toggle vim-table-mode |
| \tdd     | Delete row          |
| \tdc     | Delete column       |
| \tic     | Insert column       |
| \ts      | Sort table by column |
| \tt      | Realign table       |

## Ranger

| Shortcut | Action        |
| -------- | ------------- |
| Delete   | Move to trash |
