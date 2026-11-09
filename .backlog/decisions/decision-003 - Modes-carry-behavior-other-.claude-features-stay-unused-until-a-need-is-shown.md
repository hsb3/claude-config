---
id: decision-003
title: Modes carry behavior; other .claude features stay unused until a need is shown
date: '2026-11-09T03:16:00Z'
status: accepted
---
## Context
Claude Code offers several carriers for behavior: `--append-system-prompt-file` + `--settings` (our modes), `output-styles/*.md`, `rules/*.md` (path-gated instructions), `agents/*.md` run as the main thread, `.worktreeinclude`, `agent-memory/`. The owner reviewed the list on 2026-11-09 (docs/knowledge/claude-code.md, ".claude directory" section).

## Decision
Modes are the carrier. A mode changes how a running Claude behaves as a whole: prompt, plugins on or off, effort, MCP servers. Output styles are not sufficient for that and are rejected as a mode carrier; a mode may use one inside itself. `--agent` as the main thread was rejected earlier (drops the default prompt and memory).

Deferred, each with the reason and the trigger to revisit:
- `rules/*.md`: AGENTS.md is about 25 lines; path-gated rules add a mechanism without a need. Revisit if instructions for one folder outgrow a bullet.
- `.worktreeinclude`: workers run in herdr worktrees, which git creates, so a Claude Code include list would not apply to them. Revisit if Claude Code own `isolation: worktree` or `EnterWorktree` is used for workers.
- `agent-memory/<name>/`: only meaningful once per-mode subagents exist (draft on the board).

## Consequences
- New behavior goes into a mode (prompt.md, settings.json, optional mcp.json), never into a parallel mechanism.
- Adopting a deferred feature needs a decision that names the need it meets.
