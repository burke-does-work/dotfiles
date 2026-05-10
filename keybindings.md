# Keybindings Reference

## Universal

Vim motions — apply across VS Code (vim extension) and Neovim unless overridden.

| Shortcut    | Action                             |
| ----------- | ---------------------------------- |
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
| gt / gT     | next tab / previous tab            |

Copy/paste/delete notes:

- `d`, `x`, `c` are standard vim — cut to clipboard.
- `<Space>d`, `<Space>x`, `<Space>c` (and uppercase variants) send to the blackhole register — no clipboard effect.
- `<Space>` is the leader key in normal mode.
- `Ctrl+C` / `Ctrl+V` for copy/paste in GUI apps — use in Chrome and GUI apps without VIM bindings.
- Ghostty (terminal): `Ctrl+C` copies if text is selected, sends SIGINT otherwise. `Ctrl+V` pastes from clipboard. Do not use in Neovim or VS Code (these intercept the keys).
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

## Window Management & System

AeroSpace manages workspaces and tiling. Raycast handles app launching and window search. macOS Spaces not used.

AeroSpace uses the `alt` modifier — the **Option** key (physical inner-left Cmd, "Option" sticker). This key sends `left_option`, which is unaffected by the Ctrl↔Cmd swap and consistent across all apps.

### Workspaces (AeroSpace)

| Shortcut         | Action                                                               |
| ---------------- | -------------------------------------------------------------------- |
| Option+1         | Switch to workspace 1-main (Ghostty, VS Code, ChatGPT, Claude, etc.) |
| Option+2         | Switch to workspace 2-focus (empty — focus mode)                     |
| Option+3         | Switch to workspace 3-coms (Signal, WhatsApp, Mail, etc.)            |
| Option+4         | Switch to workspace 4-play (Chrome, VLC)                             |
| Option+5         | Switch to workspace 5-blank (context reset)                          |
| Option+6–9       | Switch to workspace 6–9 (blank)                                      |
| Option+Shift+1   | Move window to workspace 1-main                                      |
| Option+Shift+2   | Move window to workspace 2-focus                                     |
| Option+Shift+3   | Move window to workspace 3-coms                                      |
| Option+Shift+4   | Move window to workspace 4-play                                      |
| Option+Shift+5   | Move window to workspace 5-blank                                     |
| Option+Shift+6–9 | Move window to workspace 6–9                                         |
| Option+Tab       | Switch to last workspace                                             |
| Option+Shift+Tab | Move workspace to next monitor                                       |

Note: Chrome has no auto-assignment (appears on both workspace 2 and 4). Move manually with Option+Shift+2 or Option+Shift+4 after opening.

### Windows (AeroSpace/Raycast)

| Shortcut             | Action                            |
| -------------------- | --------------------------------- |
| Option+H/J/K/L       | Focus window left/down/up/right   |
| Option+Shift+H/J/K/L | Move window within workspace      |
| Option+minus/equal   | Resize window smaller/larger      |
| Option+,             | Toggle layout (accordion ↔ tiles) |
| Option+Space         | Switch apps                       |
| Shift+Option+Space   | Switch windows                    |
| Hyper+Option+Space   | Switch windows in workspace       |

### Other system

| Shortcut    | Action                                                                                  |
| ----------- | --------------------------------------------------------------------------------------- |
| Cmd+Space   | Toggle input method English ↔ Chinese (Karabiner — no macOS settings)                   |
| Cmd+Shift+S | Screenshot selection to clipboard (Karabiner `screencapture -i -c` — no macOS settings) |

## Ghostty

Ghostty is excluded from the Ctrl↔Cmd swap — Ctrl is Ctrl, Cmd is Cmd. `super` (Cmd) = physical Option key.

### Tabs

| Shortcut       | Action                   |
| -------------- | ------------------------ |
| Ctrl+Shift+T   | New tab                  |
| Ctrl+Shift+W   | Close surface            |
| Ctrl+Tab       | Next tab                 |
| Ctrl+Shift+Tab | Prev tab                 |
| Ctrl+Shift+R   | Set tab title (persists) |

### Splits

| Shortcut              | Action                        |
| --------------------- | ----------------------------- |
| Ctrl+Shift+Enter      | New split (right)             |
| Ctrl+Shift+B          | New split (down)              |
| Ctrl+Shift+H/J/K/L    | Move focus left/down/up/right |
| Ctrl+Shift+Left/Right | Resize split narrower/wider   |
| Ctrl+Shift+Up/Down    | Resize split taller/shorter   |
| Ctrl+Shift+0          | Reset split sizes             |

### Clipboard

| Shortcut | Action                            |
| -------- | --------------------------------- |
| Ctrl+C   | Copy if selection; SIGINT if none |
| Ctrl+V   | Paste                             |

## Claude Code

Runs in Ghostty (excluded from Ctrl↔Cmd swap), so sticker names equal signal names here: Ctrl=Ctrl, Cmd=Cmd.

`ctrl+shift+b` is dead — Ghostty intercepts it for splits. Brief is on `ctrl+shift+i` instead.

### Global

| Shortcut | Action |
| -------- | ------ |
| Ctrl+R | History search |
| Ctrl+T | Toggle todos |
| Ctrl+O | Toggle transcript |
| Ctrl+Shift+I | Toggle brief (moved from Ctrl+Shift+B) |
| Ctrl+Shift+O | Toggle teammate preview |

### Chat

| Shortcut | Action |
| -------- | ------ |
| Enter | Submit |
| Escape | Cancel |
| Ctrl+P / Cmd+P | Model picker |
| Ctrl+L | Clear input |
| Ctrl+S | Stash |
| Ctrl+J | New line |
| Ctrl+G / Ctrl+X Ctrl+E | External editor |
| Up / Down | History previous / next |
| Shift+Tab | Cycle mode |
| Cmd+O | Fast mode |
| Cmd+T | Thinking toggle |
| Ctrl+B | Background task (Task context) |

## Kitty (reference for Ghostty setup)

| Shortcut              | Action                                |
| --------------------- | ------------------------------------- |
| Ctrl+Shift+T          | New tab                               |
| Ctrl+Shift+Alt+T      | Set tab title (persists)              |
| Ctrl+Tab              | Next tab                              |
| Ctrl+Shift+Tab        | Previous tab                          |
| Ctrl+Shift+R          | Vertical split                        |
| Ctrl+Shift+B          | Horizontal split                      |
| Ctrl+Shift+W          | Close split                           |
| Ctrl+Shift+H/J/K/L    | Move focus left/down/up/right         |
| Ctrl+Shift+Left/Right | Resize split narrower/wider           |
| Ctrl+Shift+Up/Down    | Resize split taller/shorter           |
| Ctrl+Shift+]/[        | Move windows within the tab           |
| Ctrl+Shift+0          | Reset split sizes                     |
| Ctrl+=                | Font size increase                    |
| Ctrl+-                | Font size decrease                    |
| Ctrl+0                | Font size reset                       |
| Ctrl+C                | Copy (if selection); SIGINT (if none) |
| Ctrl+V                | Paste from clipboard                  |

## fzf (shell)

| Shortcut | Action                                                                            |
| -------- | --------------------------------------------------------------------------------- |
| Ctrl+T   | File path picker — fuzzy search files; pastes selected path(s) into command line  |
| Ctrl+R   | Command history — fuzzy search history; pastes selected command into command line |
| Alt+C    | CD into directory — fuzzy search dirs; changes to selected directory              |

## VS Code

### Global Navigation

| Shortcut       | Action                   |
| -------------- | ------------------------ |
| Ctrl+Tab       | Next editor / panel tab  |
| Ctrl+Shift+Tab | Prev editor / panel tab  |
| Ctrl+Shift+B   | Toggle sidebar           |
| Ctrl+Shift+-/= | Decrease / increase pane |

### Intellisense

| Shortcut | Action                |
| -------- | --------------------- |
| Tab      | Accept suggestion     |
| Ctrl+G   | Dismiss suggestions   |
| Arrows   | Scroll btw selections |

**Enter**: Set to do nothing for tab completion.

## Vimium (Chrome)

**Known limitation:** Vimium conflicts with Google Sheets — Sheets keybindings won't work while Vimium is active. Workaround TBD.

### Page navigation

| Shortcut | Action                                        |
| -------- | --------------------------------------------- |
| h/j/k/l  | Scroll left/down/up/right                     |
| gg / G   | Scroll to top / bottom of page                |
| d / u    | Scroll half page down / up                    |
| f        | Open link in current tab                      |
| F        | Open link in new tab                          |
| yf       | Copy link URL (works on focus-stealing pages) |
| r        | Reload page                                   |
| i        | Enter insert mode (ignore commands until Esc) |
| yy       | Copy current URL to clipboard                 |
| H        | Go back                                       |
| L        | Go forward                                    |

### Functional

| Shortcut | Action                         |
| -------- | ------------------------------ |
| t        | Create new tab                 |
| x        | Close current tab              |
| gt / gT  | Tab right/left                 |
| /        | Enter find mode                |
| n / N    | Next / previous match          |
| v / V    | Visual mode / visual line mode |

Note: for visual mode, click the location first, then hit v / V. Also tested Carret mode (`F7`), Chrome's built in text selector. Vimium is more intuitive. But accept that all options are not good and select with mouse is going to be best most times.

### Vomnibar (open pages)

| Shortcut | Action                                          |
| -------- | ----------------------------------------------- |
| o        | Open URL, bookmark, or history entry            |
| O        | Open URL, bookmark, or history entry in new tab |
| T        | Search open tabs                                |
| ge       | Edit current URL                                |
| gE       | Edit current URL, open in new tab               |

## Neovim

Uses Vim keybindings — see Universal. Tool-specific overrides listed below.

### Table plug-in

| Shortcut     | Action                |
| ------------ | --------------------- |
| \<Space\>tm  | Toggle vim-table-mode |
| \<Space\>tdd | Delete row            |
| \<Space\>tdc | Delete column         |
| \<Space\>tic | Insert column         |
| \<Space\>ts  | Sort table by column  |
