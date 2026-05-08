# Keybindings Reference

## Universal

Vim motions — apply across VS Code (vim extension) and Neovim unless overridden.

| Shortcut    | Action                             |
| ----------- | -----------------------------      |
| hjkl        | Move left/down/up/right            |
| gg / G      | Go to top / bottom of file         |
| Ctrl+u / d  | Half-page up / down                |
| w / b       | Next / prev word                   |
| 0 / $       | Start / end of line                |
| / + Enter   | Search forward                     |
| n / N       | Next / prev search result          |
| i / a       | Insert before / after cursor       |
| o / O       | New line below / above             |
| dd / yy / p | Delete line / yank line / put      |
| u / Ctrl+r  | Undo / redo                        |
| ciw / diw   | Change / delete inner word         |
| v / V       | Visual char / line mode            |
| > / <       | Indent / dedent selection          |
| J           | Combine lines (esp. useful in CLI) |
| yl          | copy one character                 |
| vp          | paste over one character           |

Copy/paste/delete notes:

- `d`, `x`, `c` are standard vim — cut to clipboard.
- `<Space>d`, `<Space>x`, `<Space>c` (and uppercase variants) send to the blackhole register — no clipboard effect.
- `<Space>` is the leader key in normal mode.
- `Ctrl+C` / `Ctrl+V` for copy/paste — use in Chrome, and in Ghostty (terminal). `Ctrl+C` copies if text is selected, sends SIGINT otherwise. `Ctrl+V` pastes from clipboard. Do not use in Neovim or VS Code (these intercept the keys).
- Vi-mode with macOS clipboard integration. Yank/delete operations sync to the system clipboard via `pbcopy`/`pbpaste`; `p`/`P` paste from system clipboard.

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

## Window Management

Bindings live in Raycast (not macOS native) — Raycast handles Electron apps correctly.

| Shortcut             | Action                          |
| -------------------- | ------------------------------- |
| Ctrl+Cmd+Shift+↑     | Maximize window                 |
| Cmd+Option+←/→       | Switch Space left/right         |
| Cmd+Option+Shift+←/→ | Move window to Space left/right |
| Cmd+Option+↑         | Mission Control overview        |
| Shift+Option+Space   | Search open windows (Raycast)   |
| Cmd+M                | Show desktop                    |

Tiling (halves/quarters): set in Raycast → Window Management.

## Ghostty

<!-- Keybindings to be documented -->

## Kitty (reference for Ghostty setup)

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
| Ctrl+Shift+]/[        | Move windows within the tab   |
| Ctrl+Shift+0          | Reset split sizes             |
| Ctrl+=                | Font size increase            |
| Ctrl+-                | Font size decrease            |
| Ctrl+0                | Font size reset               |
| Ctrl+C                | Copy (if selection); SIGINT (if none) |
| Ctrl+V                | Paste from clipboard          |

## fzf (shell)

| Shortcut | Action                                                              |
| -------- | ------------------------------------------------------------------- |
| Ctrl+T   | File path picker — fuzzy search files; pastes selected path(s) into command line |
| Ctrl+R   | Command history — fuzzy search history; pastes selected command into command line |
| Alt+C    | CD into directory — fuzzy search dirs; changes to selected directory |

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

## Vimium (Chrome)

Advanced setting enabled: **"Don't let pages steal the focus on load"** — prevents sites like ChatGPT from auto-focusing their input box, allowing Vimium to take precedence.

### Page navigation

| Shortcut | Action                                    |
| -------- | ----------------------------------------- |
| ?        | Show help dialog                          |
| h/j/k/l  | Scroll left/down/up/right                 |
| gg / G   | Scroll to top / bottom of page            |
| d / u    | Scroll half page down / up                |
| zH / zL  | Scroll all the way left / right           |
| f        | Open link in current tab                  |
| F        | Open link in new tab                      |
| yf       | Copy link URL (works on focus-stealing pages) |
| r        | Reload page                               |
| R        | Hard reload (skip cache)                  |
| gs       | View page source                          |
| i        | Enter insert mode (ignore commands until Esc) |
| yy       | Copy current URL to clipboard             |
| gf / gF  | Cycle to next frame / focus main frame    |

### Vomnibar (open pages)

| Shortcut | Action                                       |
| -------- | -------------------------------------------- |
| o        | Open URL, bookmark, or history entry         |
| O        | Open URL, bookmark, or history entry in new tab |
| b        | Open bookmark                                |
| B        | Open bookmark in new tab                     |
| T        | Search open tabs                             |
| ge       | Edit current URL                             |
| gE       | Edit current URL, open in new tab            |

### Find

| Shortcut | Action                          |
| -------- | ------------------------------- |
| /        | Enter find mode                 |
| n / N    | Next / previous match           |

### History

| Shortcut | Action                |
| -------- | --------------------- |
| H        | Go back               |
| L        | Go forward            |

### Tabs

| Shortcut | Action                                     |
| -------- | ------------------------------------------ |
| t        | Create new tab                             |
| x        | Close current tab                          |
| X        | Restore closed tab                         |
| J / gT   | Tab left                                   |
| K / gt   | Tab right                                  |
| g0       | First tab (`ng0` for n-th tab)             |
| g$       | Last tab                                   |
| ^        | Previously-visited tab                     |
| yt       | Duplicate tab                              |
| W        | Move tab to new window                     |
| \<a-p\>  | Pin / unpin tab                            |

### Marks

| Shortcut    | Action                                          |
| ----------- | ----------------------------------------------- |
| ma / mA     | Set local mark `a` / global mark `A`            |
| `` `a ``    | Jump to local mark `a` (uppercase = global)     |
| `` `` ``    | Jump back to position before previous jump      |

### Advanced

| Shortcut | Action                                 |
| -------- | -------------------------------------- |
| ]] / [[  | Follow 'next' / 'previous' link labels |
| \<a-f\>  | Open multiple links in new tabs        |
| gi       | Focus first (or n-th) text input       |
| gu / gU  | Up one URL level / to URL root         |
| v / V    | Visual mode / visual line mode         |

**Known limitation:** Vimium conflicts with Google Sheets — Sheets keybindings won't work while Vimium is active. Workaround TBD.

## Neovim

Uses Vim keybindings — see Universal. Tool-specific overrides listed below.

### Table plug-in

| Shortcut     | Action                                     |
| ------------ | ------------------------------------------ |
| \<Space\>tm  | Toggle vim-table-mode                      |
| \<Space\>tdd | Delete row                                 |
| \<Space\>tdc | Delete column                              |
| \<Space\>tic | Insert column                              |
| \<Space\>ts  | Sort table by column                       |

