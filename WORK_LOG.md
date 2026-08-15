# Work Log

## 2026-08-15 — Work log setup across five repos

Decided to establish a session log file (`WORK_LOG.md`) across five repos - `dotfiles`, `materials-strategy`, `global_workflows`, `network-infra`, `denning_and_outdoorsing_build` - to serve as a detailed reference of session thinking, decisions, and implementation. Framed as a thought history as much as an implementation history.

**Skill vs. AGENTS.md:** Chose AGENTS.md. The behavior needed to be passive and automatic - the agent asks at the right moment without being invoked. A skill requires explicit invocation per session, which defeats the purpose.

**Trigger design:** The agent prompts to write a log entry when a commit message is drafted, or when completion is signaled with words like "done" or "complete". Explicitly rejected having the agent ask whether something is complete - the signal must come from me. Direct requests to write the log also work without prompting.

**Framing and scope:** The log is a record of my thinking, decisions, and actions - not the agent's. The agent's contributions appear only as context for what I considered and decided. This required renaming the file from `AGENT_LOG.md` to `WORK_LOG.md` to remove the agent-centered framing from the concept itself.

**Content decisions:**
- Faithful summary, not verbatim - verbatim violates the conciseness requirement.
- Intentional duplication with other repo files (SPEC, PLAN, README) is expected and fine. The log captures the dialogue and reasoning that produced those artifacts; the artifacts capture the system state. Different lens, same subject matter. A purpose line was added to the AGENTS.md instruction to keep this distinction clear for the agent.
- Write chronologically; use bullets where they aid clarity, prose where they don't. No structural separation between thinking and decisions - they're causally linked and belong together.
- Implementation work is featured when the session is implementation-oriented, not treated as background.

`WORK_LOG.md` created in all five repos. AGENTS.md updated with the Work Log subsection under `## Completion`.

