# Global Claude Code Instructions

## Reading files: never use Bash

To read file contents, always use the Read tool. Never use `cat`, `head`, `tail`, `less`, or `more` via the Bash tool — they will trigger permission prompts because they are intentionally not in the Bash allow list. The Read tool has unrestricted filesystem access (except for `~/.ssh`, `~/.gnupg`, and `.env*` files, which are denied on purpose). If a file is in a denied path, do not attempt to read it via Bash as a workaround.

## Bash commands: one command per call

Each Bash tool call must contain exactly one command. Never chain commands with `&&`, `||`, or `;`. Break multi-step sequences into separate sequential Bash tool calls. Single-command redirections like `2>/dev/null` on one command are fine.
