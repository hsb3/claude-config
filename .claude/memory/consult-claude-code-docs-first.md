---
name: consult-claude-code-docs-first
description: Before deciding what Claude Code can or cannot do (flags, settings, agents, hooks, plugins, the .claude layout), read the official docs; index at https://code.claude.com/docs/llms.txt
metadata:
  type: feedback
---

Rule (2026-11-09): reference the Claude Code docs to understand what is possible. The index of all pages is https://code.claude.com/docs/llms.txt; each page is also served as markdown.

Key pages for this repo:
- https://code.claude.com/docs/en/claude-directory.md: what can live in `~/.claude` and a project's `.claude/`, with scope and whether it is committed
- https://code.claude.com/docs/en/sub-agents.md: every configurable field of a custom agent, locations, what a subagent does not inherit
- https://code.claude.com/docs/en/memory.md and settings-reference.md: auto memory, `autoMemoryDirectory`, all settings keys

**Why:** earlier work probed the binary and guessed at behavior (modes design, effort, subagents); the docs already state most of it, and guessing produced stale or wrong facts.

**How to apply:** when a task touches Claude Code configuration or capabilities, fetch llms.txt, pick the relevant pages, read them, then design. Record load-bearing facts in `docs/knowledge/claude-code.md` with the date and version. Probe only what the docs leave unclear. Related: [[agent-instructions-follow-skill-best-practices]], [[write-memories-impersonally]].
