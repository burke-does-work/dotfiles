# Design Records

## 2026-08-30 -- The commit subject carries the type; body bullets do not

The commit template asked for a first line of roughly 50 characters, 72 maximum. Real subject lines in this repo ran 238, 359, 424 and 455 characters. The cause was structural rather than sloppiness: the stacked `Type:` lines carried no blank line after the first, so git treated the whole message as the subject. The guidance was describing something that had never once happened.

Chose a format with a real subject line, since that is what makes `git log --oneline`, GitHub, and everything else that reads a subject useful. The type appears once, in the subject. The body is plain bullets, one topic each.

Rejected: the stacked `Type:` prefixes. A first pass at the new format carried them into the body, which was also rejected -- once the subject line carries the type, repeating it on every body line is redundant, and on a single-type commit it is pure noise.

Accepted: every future commit follows a format that none of the existing history used.

Full narrative in `WORK_LOG.md`, 2026-08-30.

---

## 2026-08-30 -- Long bullets split rather than wrap

The template said to wrap at 72 characters. `denning_and_outdoorsing_build/README.md` says the opposite: split a long line into another line, and wrap only for atomic content that cannot cleanly split.

Chose the split rule, as the better and more general of the two. Two further rules were promoted from that README on the same grounds -- no dates and no file lists, since git stores both.

Rejected: the wrap rule.

Accepted: bullets multiply where a single topic will not compress, so a commit body can run longer than it would under wrapping.

Full narrative in `WORK_LOG.md`, 2026-08-30.

---

## 2026-08-30 -- Repo-specific commit rules stay unpromoted

While promoting rules from `denning_and_outdoorsing_build/README.md` into this repo's template, two were deliberately held back.

Chose to leave the no-Conventional-Commits rule and one-commit-per-session in that repo's README, as repo-specific rather than general. The unused `Context:` and `Changes:` scaffolding was dropped from the template in the same pass.

Rejected: promoting both. The no-Conventional-Commits rule contradicts this template's entire premise, and one-commit-per-session was overridden in this repo the same day by splitting the MCP migration away from unrelated config drift.

Accepted: the two repos' commit conventions now diverge on purpose, so something has to resolve which applies where. That is the lookup order recorded in `global_workflows/DESIGN_RECORDS.md`, 2026-08-30.

Full narrative in `WORK_LOG.md`, 2026-08-30.

---

## 2026-08-30 -- Session trailers removed by history rewrite

Two commits pushed earlier that day carried a `Claude-Session:` trailer. `global_workflows/AGENTS.md` forbids AI self-attribution footers and no prior commit in this repo has one, so it should never have landed.

Chose to rewrite rather than leave it. Used `git filter-branch --msg-filter`, diffed against a backup ref to confirm file contents were byte-identical and only messages had changed, then force-pushed and deleted the backup. Both messages were restructured into the new subject-line format while the history was already being rewritten.

Rejected: leaving the trailers in place as a matter of historical record.

Accepted: rewritten public history. Safe only because no clone of this repo exists on any other machine, which was confirmed before the force-push rather than assumed.

Full narrative in `WORK_LOG.md`, 2026-08-30.

---

## 2026-08-29 -- OnShape MCP moved to the official hosted server

The previous setup was `hedless/onshape-mcp`, a community Python server run locally out of `mcp/onshape/` under a uv-managed environment, authenticated by OnShape API keys. It never reached working state: it had been blocked waiting on OnShape support to resolve an API key creation error, so the keys were never issued and the server was never exercised. Onshape Labs released an official FeatureScript MCP on 2026-08-13, making the community server redundant.

Chose the hosted remote HTTP server at `https://fs-mcp.labs.onshape.app/mcp`, authenticated by browser OAuth against an active OnShape login, which sidesteps the key-creation blocker entirely. Removed `mcp/onshape/` and its uv environment, deleted `config/claude/mcp.json`, and switched the Codex entry from a local command invocation to HTTP transport.

Rejected: continuing to wait on API keys for the community server.

Accepted: scope. The official server does FeatureScript custom-feature authoring only, with no REST API access to documents, parts, or assemblies. Taken because the local server was delivering nothing at all.

Full narrative in `WORK_LOG.md`, 2026-08-29.

---

## 2026-08-29 -- MCP inventory kept as a standalone doc

Claude Code keeps its MCP entries in `~/.claude.json`, which mixes session history, OAuth tokens, and machine-specific paths, and so is not safely tracked in dotfiles. Codex, by contrast, has a clean tracked config. That asymmetry means no single tracked file describes what is actually installed.

Chose `docs/mcp.md` as a standalone inventory carrying the human-readable list and the per-client setup commands, linked from `README.md`.

Rejected: relying on tracked configuration alone to document what is installed.

Accepted: the inventory is maintained by hand, so it can drift from reality in a way a generated list could not.

Full narrative in `WORK_LOG.md`, 2026-08-29.

---

## 2026-08-22 -- Codex skills reached by symlink, not duplication

Codex did not expose the shared skills maintained in `global_workflows/skills` despite their valid `SKILL.md` metadata. The Codex home directory held only system-managed skills, and the current global skill path, `~/.agents/skills`, did not exist.

Chose to create `~/.agents/skills` as a symlink to that directory, keeping `global_workflows/skills` the single source of truth so updates stay available across Codex sessions with no synchronization work.

Rejected: duplicating the skill directories into the Codex home.

Accepted: the link is machine-local and has to be recreated on a new machine. Recorded in the Codex setup instructions in `docs/apps.md` and the configuration reference in `docs/system.md`.

Full narrative in `WORK_LOG.md`, 2026-08-22.
