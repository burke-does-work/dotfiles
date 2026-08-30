# Work Log

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
