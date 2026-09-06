# Work Log

## 2026-09-06 -- Commit template gains the tighten step

`gitmessage` said "split a long line into another line -- do not wrap," which states a semantic rule in typographic units. An agent following it literally reported two wrapped bullets as violations when the real defect was that both joined two claims with a semicolon. Splitting was the only remedy the template offered, and splitting a rambling bullet gives two rambling bullets.

`denning_and_outdoorsing_build/README.md` already carried the missing clause -- tighten wording before splitting -- and the template never received it, even though the split rule itself was promoted out of that same README on 2026-08-30. The better-worded copy stayed in the override while the base kept the weaker one.

Reworded to state the order plainly: tighten, then split only when it is genuinely two topics, then wrap only when it can't split. Splitting is still preferred over wrapping and the atomic-content exception survives, so the 2026-08-30 choice stands. The tighten step sits ahead of splitting and mitigates its known cost -- bullets multiplying where a single topic will not compress.

`DESIGN_RECORDS.md` was cleared in this repo and in `global_workflows` in the same pass. Both had been seeded by sweeping their work logs, and the entries read as test material rather than decisions worth keeping. The file remains, empty.

The template is now the base layer for every repo rather than a fallback, following the `AGENTS.md` change made in `global_workflows` the same day. Full reasoning in `global_workflows/WORK_LOG.md`, 2026-09-06. That raises the stakes on edits here: a change to `gitmessage` now reaches every repo that has not overridden the rule being changed.

## 2026-09-06 -- Design records added

`DESIGN_RECORDS.md` was added to this repo as part of a workflow change made in `global_workflows` the same day, which replaced a never-instantiated `DEV_HISTORY.md` with a flat, ADR-style decision record. The full reasoning is in `global_workflows/WORK_LOG.md`, 2026-09-06.

Seeded by sweeping this log. Seven decisions qualified under the two-part admission test -- a real alternative was rejected, and reversing the decision would now cost more than an edit. Four from the 2026-08-30 commit template rework: the subject line carrying the type, splitting long bullets rather than wrapping, holding back two rules as repo-specific, and the `filter-branch` rewrite that stripped the `Claude-Session:` trailers. Two from the 2026-08-29 MCP session: the move to the official hosted server and the decision to keep a hand-maintained inventory in `docs/mcp.md`. One from 2026-08-22, the `~/.agents/skills` symlink.

The 2026-08-15 work log session was swept but its decisions were filed in `global_workflows/DESIGN_RECORDS.md` instead. They were taken here, but they govern an artifact that lives in `AGENTS.md`, and the record belongs where the artifact is -- the citation points back at this log for the narrative. The unpromoted commit rules entry points the other way, at `global_workflows` for the lookup order that resolves which repo's conventions apply.

Nothing in this repo required a style sweep; both work logs were already ASCII throughout.

---

## 2026-08-30 -- Commit template reworked around a real subject line

Drafting a commit message for the OnShape MCP migration exposed that the commit template was not being followed and, in one respect, could not be. Claude proposed `Add:` as a type prefix. It appears exactly once in this repo's history and is not valid vocabulary -- the valid list has been sitting in `config/git/gitmessage` all along, wired up as `commit.template` in `config/git/gitconfig`.

Auditing the template against actual practice turned up two defects rather than one.

The template asked for a first line of roughly 50 characters, 72 maximum. Real subject lines in this repo run 238, 359, 424 and 455 characters. The cause is structural: the stacked `Type:` lines carry no blank line after the first, so git treats the whole message as the subject. The guidance was describing something that had never once happened. Decided the format should have a real subject line, since that is what makes `git log --oneline`, GitHub, and everything else that reads a subject useful.

A first pass at the new format carried the old stacked `Type:` prefixes into the body. That was wrong: once the subject line carries the type, repeating it on every body line is redundant, and on a single-type commit it is pure noise. The body is plain bullets, one topic each, and the type appears once in the subject.

The template also said to wrap at 72. `denning_and_outdoorsing_build/README.md` says the opposite -- split a long line into another line, and wrap only for atomic content that cannot cleanly split. The split rule is the better one and is general, so it replaces the wrap rule here. Two further rules were promoted from that README on the same grounds: no dates and no file lists, since git stores both.

Deliberately not promoted, as repo-specific rather than general: the no-Conventional-Commits rule, which contradicts this template's entire premise, and one-commit-per-session, which was overridden in this repo the same day by splitting the MCP migration away from unrelated config drift. The unused `Context:` and `Changes:` scaffolding was dropped as well.

The two commits pushed earlier in the day carried a `Claude-Session:` trailer. `global_workflows/AGENTS.md` forbids AI self-attribution footers and no prior commit here has one, so it should never have gone in. Confirmed no clone of this repo exists on any other machine, which makes a force-push safe, and took the opportunity to restructure both messages into the new subject-line format while the history was already being rewritten. Rewritten with `git filter-branch --msg-filter`, diffed against a backup ref to confirm the file contents were byte-identical and only the messages had changed, then force-pushed and the backup deleted.

---

## 2026-08-29 -- OnShape MCP migrated to the official Labs server

Replaced the OnShape MCP server entirely. The previous setup was `hedless/onshape-mcp` -- a community Python server run locally out of `mcp/onshape/` under a uv-managed environment, needing OnShape API keys. That setup never reached working state: it had been blocked waiting on OnShape support to resolve an API key creation error, so the keys were never issued and the server was never exercised.

Onshape Labs released an official FeatureScript MCP on 2026-08-13, which made the community server redundant. It is a hosted remote HTTP server at `https://fs-mcp.labs.onshape.app/mcp`, authenticated by browser OAuth against an active OnShape login rather than by API keys -- which sidesteps the key-creation blocker completely. The tradeoff is scope: FeatureScript custom-feature authoring only, with no REST API access to documents, parts, or assemblies. Accepted, since the local server was delivering nothing at all.

Removed `mcp/onshape/` and its uv environment, and deleted `config/claude/mcp.json`. Switched the Codex entry in `config/codex/config.toml` from the local `[mcp_servers.onshape]` command invocation to `[mcp_servers.onshape-fs]` on HTTP transport.

Added `docs/mcp.md` as a new MCP server inventory, linked from `README.md`. The reasoning for a standalone doc: Claude Code keeps its MCP entries in `~/.claude.json`, which mixes session history, OAuth tokens, and machine-specific paths, and so is not safely tracked in dotfiles. Codex, by contrast, has a clean tracked config. That asymmetry means there is no single tracked file describing what is installed, so the doc carries the human-readable inventory and the per-client setup commands -- Claude Code registers with `claude mcp add -s user -t http`, Codex reads its live tracked entry.

One setup finding worth recording for any future App Store-gated MCP: after subscribing to the server in the Onshape App Store, reconnecting the client is not enough. Reconnecting through `/mcp` mints a fresh OAuth token and the "not subscribed" state persists anyway, which rules out a stale token as the cause -- the client caches its tool list for the life of the session. A full quit and relaunch is what picks up the new entitlement.

Also carried in this working tree from earlier sessions, unrelated to MCP: the `~/.agents/skills` symlink work, Karabiner and aerospace tweaks, and Claude settings and keybindings drift. Everything is still unstaged and uncommitted, including the MCP migration.

---

## 2026-08-22 -- Codex global skills discovery

Found that Codex did not expose the shared skills maintained in `global_workflows/skills`, despite their valid `SKILL.md` metadata. The Codex home directory had only system-managed skills, while the current global skill path (`~/.agents/skills`) did not exist.

Decided to keep `global_workflows/skills` as the single source of truth rather than duplicate skill directories. Created `~/.agents/skills` as a symlink to that directory so updates remain available across Codex sessions without synchronization work.

Updated the Codex setup instructions in `docs/apps.md` and the configuration reference in `docs/system.md` to recreate the link on a new machine. Left all files unstaged and uncommitted for later review.

---

## 2026-08-15 -- Work log setup across five repos

Decided to establish a session log file (`WORK_LOG.md`) across five repos -- `dotfiles`, `materials-strategy`, `global_workflows`, `network-infra`, `denning_and_outdoorsing_build` -- to serve as a detailed reference of session thinking, decisions, and implementation. Framed as a thought history as much as an implementation history.

Skill vs. AGENTS.md: Chose AGENTS.md. The behavior needed to be passive and automatic -- the agent asks at the right moment without being invoked. A skill requires explicit invocation per session, which defeats the purpose.

Trigger design: The agent prompts to write a log entry when a commit message is drafted, or when completion is signaled with words like "done" or "complete". Explicitly rejected having the agent ask whether something is complete -- the signal must come from me. Direct requests to write the log also work without prompting.

Framing and scope: The log is a record of my thinking, decisions, and actions -- not the agent's. The agent's contributions appear only as context for what I considered and decided. This required renaming the file from `AGENT_LOG.md` to `WORK_LOG.md` to remove the agent-centered framing from the concept itself.

Content decisions:

- Faithful summary, not verbatim -- verbatim violates the conciseness requirement.
- Intentional duplication with other repo files (SPEC, PLAN, README) is expected and fine. The log captures the dialogue and reasoning that produced those artifacts; the artifacts capture the system state. Different lens, same subject matter. A purpose line was added to the AGENTS.md instruction to keep this distinction clear for the agent.
- Write chronologically; use bullets where they aid clarity, prose where they don't. No structural separation between thinking and decisions -- they're causally linked and belong together.
- Implementation work is featured when the session is implementation-oriented, not treated as background.

`WORK_LOG.md` created in all five repos. AGENTS.md updated with the Work Log subsection under `## Completion`.
