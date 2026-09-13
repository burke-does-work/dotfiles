# Claude Code permissions

## Doc purpose

Reference for the permission model in `config/claude/settings.json`, symlinked to `~/.claude/settings.json`.

The settings file holds the rules; this doc holds the reasoning and the known gaps. Rules are enforced by Claude Code itself, not by the model -- instructions in `AGENTS.md` shape what Claude tries to do, but only these rules decide what it is allowed to do.

Verified against Claude Code 2.1.251.

## Working scope

`additionalDirectories` is set to two trees:

- `/Users/matt/local/documents`
- `/Users/matt/local/dotfiles`

Files in these trees are readable without prompting, and writable without prompting while in accept-edits mode. `dotfiles` is included because it holds this settings file and the git commit template; scoping to `documents/` alone would make editing config a prompt-per-line exercise.

Anything outside the two trees prompts. That is approval, not prohibition -- the prompt can be accepted.

## How modes and rules interact

Rules and modes are orthogonal. Allow, ask, and deny are evaluated identically in every mode. The mode only decides what happens to a call that no rule covers.

| | Manual (`default`) | `acceptEdits` |
| --- | --- | --- |
| Matches `allow` | Runs | Runs |
| Matches `ask` or `deny` | Prompts / blocked | Prompts / blocked |
| Built-in read-only set | Runs | Runs |
| Uncovered Bash command | Prompts | Prompts |
| Uncovered file edit | Prompts | Auto-accepted, in scope |

Accept-edits also auto-approves seven filesystem commands by mode: `mkdir`, `touch`, `rm`, `rmdir`, `mv`, `cp`, and `sed`.

## The central design decision

Filesystem mutation is granted by the **mode**, not by the allowlist.

`mkdir`, `cp`, `mv`, `touch`, `chmod`, `ln`, and `sed` are deliberately absent from `allow`. An allow rule has no directory scope -- it would grant those commands across the entire disk, in every mode. Accept-edits grants the same commands confined to the working scope.

The result: Manual mode grants no writes at all. Shift-Tab into accept-edits and writes are granted, bounded to `documents/` and `dotfiles/`.

## The three arrays

**`allow`** -- read-only utilities, read-only `git`, `docker`, and `gh` subcommands, and the project-scoped package manager commands (`uv venv`, `uv sync`, `uv add`, `npm ci`, bare `npm install`).

Several entries duplicate Claude Code's built-in read-only set (`ls`, `cat`, `echo`, `pwd`, `head`, `tail`, `grep`, `find`, `wc`, `which`, `diff`, `stat`, `du`, `cd`, read-only `git`), which runs without prompting in every mode and is not configurable. They are kept deliberately: the built-in set makes an exception for unquoted globs on write-capable commands such as `find` and `sort`, and the explicit rules cover those cases.

**`ask`** -- overrides the mode. These prompt even in accept-edits, and fire when *any* subcommand matches, including inside a subshell or command substitution.

- `rm`, `rmdir` -- the highest-value entry. Without it, accept-edits auto-approves deletion across the whole working scope.
- `uv pip install` -- `--system`, `--target`, `--prefix`, and `--break-system-packages` can all redirect it outside the project.
- `python3 -m pip` -- `python3` itself stays allowed.
- `gh extension install` -- a global install.
- `gh api` -- the general-purpose API escape hatch. It can DELETE, PATCH or PUT anything the token reaches, and the method flag can sit anywhere in the command, so no prefix pattern catches every destructive form. Putting the whole subcommand behind `ask` sidesteps the position problem. The recognizable DELETE spellings are additionally in `deny`, so those are blocked outright rather than offered.

**`deny`** -- hard block, no prompt offered. Reserved for reads of credentials and for git and GitHub operations that destroy history rather than changing it: repo deletion, archive, release deletion, `gh api` DELETE, force push, remote branch deletion, and reflog expiry.

## Global installs

Commands that install software outside the project prompt rather than running: `brew install`, `pip install`, `npm install <pkg>`, `uv python install`, `uv tool install`, `uv self update`, and `uvx`.

`uv` has no blanket allow rule; only its project-scoped subcommands are listed. Anything else under `uv` falls through to a prompt.

Note that `npm install` is allowed only in its bare form. Any argument at all -- including `-g` -- falls outside the pattern and prompts.

## Known gaps

These are properties of prefix matching, not oversights.

- **Argument position.** Rules anchor at the front of the command, so a rule that names a dangerous flag misses any spelling that puts the flag later. `git push origin main --force` does not match a deny rule written as `git push --force*`. The docs state the general case: patterns that try to constrain command arguments are fragile. The reliable answer is to gate the whole subcommand with `ask` and let a flag-named `deny` sit behind it as a backstop -- which is what `uv pip install` and `gh api` do. The `git push`, `git gc` and `git reflog` deny rules name flags with no `ask` behind them, so they catch the obvious spelling and nothing else. Plain `git push` is uncovered and prompts, which is the only reason that gap is survivable.
- **Deny rules are not program boundaries.** A deny rule matches the command text Claude writes. `/opt/homebrew/bin/gh repo delete` and `sh -c 'gh repo delete'` are not covered. Deny narrows the accident, not a determined path. Real enforcement for GitHub is the `delete_repo` OAuth scope and branch protection, both server-side.
- **`sort -o` and `awk`** can write files despite being allowlisted as read tools.
- **Indirect writes.** A Python or Node script that opens files itself is not covered by any file rule. Only sandboxing enforces at the OS level.

## Path anchoring

Read and Edit rules use gitignore pattern syntax, and the anchoring is easy to get wrong.

| Pattern | Resolves to |
| --- | --- |
| `//path` | `/path` -- absolute from the filesystem root |
| `~/path` | `$HOME/path` |
| `/path` | relative to the **settings source**, i.e. `~/.claude/path` here |
| `path` or `./path` | relative to the current working directory |

A single leading slash is not an absolute path. The deny rules in this file use `//` for that reason -- written with one slash, `Read(/Users/matt/.ssh/**)` resolves to `~/.claude/Users/matt/.ssh/**` and silently matches nothing.

## Modes that are switched off

- `disableAutoMode: "disable"` -- no classifier-approved actions.
- `disableBypassPermissionsMode: "disable"` -- keeps bypass out of the Shift-Tab cycle. Allow rules have no effect in bypass mode, and deny is the only thing that still holds.

`defaultMode` stays `default` (Manual). Accept-edits is entered per task with Shift-Tab.

## Verifying a change

A malformed settings file silently disables every setting in it, so validate before trusting it:

```
jq -e . ~/.claude/settings.json
```

Then `/permissions` to confirm the rules render with no unknown-key complaint.
