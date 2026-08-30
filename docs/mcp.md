# MCP servers

## Doc purpose

Inventory of MCP (Model Context Protocol) servers used across AI clients (Claude Code, Codex), with per-client setup.

Claude Code stores MCP entries in `~/.claude.json`, which is a state file (session history, OAuth tokens, machine-specific paths) and is not safely tracked in dotfiles. Codex uses a clean config file at `config/codex/config.toml` -- those entries are the live tracked config.

This doc is the human-readable source of truth so the inventory isn't buried in a state file. 

## onshape-fs (OnShape Labs FeatureScript)

- Purpose: FeatureScript custom-feature authoring (parametric CAD tools)
- Transport: HTTP (remote hosted server)
- URL: `https://fs-mcp.labs.onshape.app/mcp`
- Auth: browser OAuth on first connect; requires active OnShape login
- Announced: 2026-08-13 (Onshape Labs)

Claude Code:

```
claude mcp add -s user -t http onshape-fs https://fs-mcp.labs.onshape.app/mcp
```

Codex: live entry in `config/codex/config.toml` under `[mcp_servers.onshape-fs]`.
