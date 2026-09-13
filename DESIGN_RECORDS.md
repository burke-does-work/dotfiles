# Design Records

## 2026-09-13 -- Claude Code permission model

An install ran without an approval gate, which exposed that `config/claude/settings.json` granted more than intended. The audit found three separate problems, and the fixes share one idea.

**Filesystem mutation is granted by the permission mode, not by the allowlist.**

`mkdir`, `cp`, `mv`, `touch`, `chmod`, `ln`, and `sed` were in `allow`, so they ran unprompted in Manual mode across the entire disk. Six of the seven are exactly what accept-edits auto-approves -- but accept-edits confines them to the working directories and an allow rule cannot. Removing them from `allow` makes Manual mode grant no writes at all, and makes accept-edits the single lever that grants them, bounded.

Rejected: keeping them in `allow` and relying on staying in Manual. That leaves the grant one Shift-Tab away from being filesystem-wide, and makes the mode indicator the only thing standing between an accident and the whole disk.

**Working scope is two trees, not `/`.**

`additionalDirectories` was `["/"]`, which made accept-edits filesystem-wide. It is now `documents/` and `dotfiles/`. `dotfiles` is included because it holds this config and the git commit template. Everything else prompts, which is approval rather than prohibition.

Downside accepted: reads outside those trees now cost one prompt each. Considered and rejected: `blockReadsOutsideWorkingDirectories`, which is not available in Claude Code 2.1.251.

**`ask` is preferred over `deny`, except where the action is irreversible.**

`ask` overrides the permission mode and still lets the human approve. `deny` blocks outright with no prompt. Commands that redirect an install outside the project (`uv pip install`, `python3 -m pip`) go to `ask`. Only operations that destroy history rather than change it go to `deny`: repo deletion, force push, remote branch deletion, release deletion, reflog expiry.

`rm` and `rmdir` are in `ask` specifically because accept-edits auto-approves them by mode, and an `ask` rule is the only mechanism that overrides a mode. Without that entry, accept-edits grants unprompted deletion across the whole working scope.

Downside accepted: a prompt on every delete, in every mode.

**Deny rules narrow accidents; they are not security boundaries.**

A deny rule matches the command text Claude writes. `/opt/homebrew/bin/gh repo delete` and `sh -c 'gh repo delete'` are not covered, and prefix matching cannot constrain an argument that appears late in a command. Real enforcement lives elsewhere -- OAuth scopes, branch protection, sandboxing. The rules here are written to prevent the plausible accident, and the doc says so rather than implying more.

**Path anchoring was silently broken.**

The deny rules protecting SSH and GPG keys used a single leading slash, which anchors at the settings source rather than the filesystem root. `Read(/Users/matt/.ssh/**)` had been resolving to `~/.claude/Users/matt/.ssh/**` and matching nothing. Absolute paths need `//`. The keys were unprotected for as long as those rules had existed.
