# Working modes: design

Status: built (`modes/`, `bin/cmode`, `install.sh`). Updated 2026-11-08.

## Goal

Start a Claude Code session in a **mode** (product design, implementation planning, building). Each mode brings its own mindset and workflow. Only the mode's prompt and its setting overrides are limited to that mode. Memory, history and the base plugins are shared by every session; egm loads only in design mode.

## Facts the design depends on (Claude Code 2.1.319)

Probe method and details for each: [knowledge/claude-code.md](knowledge/claude-code.md).

- `--agent <x>` as the main thread drops the default Claude Code system prompt and the memory system.
- `--append-system-prompt-file` adds to the default prompt and keeps it.
- `--settings <file>` layers above user settings, so it can turn a plugin off for one session and set `effortLevel`.
- `disableClaudeAiConnectors: true` in user settings can't be undone per mode. A mode that needs e.g. Figma must add that server's own MCP via `mcp.json`, not the claude.ai connector.

## Approach

Rejected: running the mode as the main-thread agent (`--agent`), because it drops the default prompt and memory. Also rejected (decision-003, 2026-11-09): output styles as the carrier; they adjust how Claude writes, not what a running session is (plugins, effort, MCP). A mode may use one inside itself. Backlog decisions 001-003 hold the choices made after D1–D11 below.

**A mode = 1 folder + 1 launcher**

```text
${CLAUDE_CONFIG_DIR:-~/.claude}/modes/<mode>/
  prompt.md      # mindset + workflow, appended to the default prompt
  settings.json  # overrides: plugins on/off, effort
  mcp.json       # optional, none shipped: MCP servers only this mode needs
```

The launcher is [`bin/cmode`](bin/cmode): `cmode <mode> [claude args]` runs `claude` with `--name <mode>`, `--append-system-prompt-file prompt.md`, `--settings settings.json`, and `--mcp-config mcp.json` when that file exists.

### Rejected alternative: one config folder per mode (`CLAUDE_CONFIG_DIR`)

`CLAUDE_CONFIG_DIR=~/.claude-modes/design claude` makes Claude Code use that folder instead of `~/.claude`. `~/.claude` is left untouched, and the mode folder starts empty.

| | Layered (chosen) | Folder per mode |
|---|---|---|
| Isolation | delta only: base always shared | total |
| Shared base (AGENTS.md, plugins, settings) | one copy | duplicated per mode, or symlinked; copies drift |
| Login | shared | separate `/login` per folder (keychain is keyed by folder) |
| Memory, history, sessions | shared | split per mode, so `--resume` and memory are per mode |
| Plugin set | add or turn off on top of the base | completely different |

## Decisions (2026-11-08)

| # | Decision |
|---|---|
| D1 | Modes for now: **design**, **planning**, **building**. |
| D2 | Structure: **layered** (shared base, each mode adds a delta). |
| D3 | Memory and history: **shared** across modes. |
| D4 | Mode files: `${CLAUDE_CONFIG_DIR:-~/.claude}/modes/<mode>/` → `prompt.md` (about 20 lines), `settings.json`, optional `mcp.json`. |
| D5 | Each mode defines: mindset (2–3 sentences), workflow steps, plugins on/off, MCPs, model and effort. |
| D6 | Plugins: ponytail **off** in design, on in planning and building. i-have-adhd on everywhere. egm **off** in the base and **on** only in design (owner, 2026-11-08), so plain `claude` has no `/egm` commands. |
| D7 | Effort: `effortLevel: high` in design and planning; building sets none, so it gets the global `settings.json` value (`effortLevel: medium`, shipped since 2026-11-09; before that Claude Code's built-in default, `medium` on 2.1.319). |
| D8 | Plain `claude` = today's setup. Modes are opt-in. |
| D9 | One mode per session. No mid-session switching, and resuming a session from another mode is not supported. |
| D10 | Hand-off: design writes `.handoff/designs/<feature>.md`, planning writes `.handoff/plans/<feature>.md`, building reads both. `.handoff/` is gitignored in the project; the prompts add it if missing (owner, 2026-11-08: no working files in a project's `docs/`). egm-draft defaults to `docs/designs/` but takes a target dir; egm-brainstorm's "Publish as RFC" option hard-codes `docs/designs/`, so the design prompt steers around it. |
| D11 | Active mode shown in the terminal tab title, via `--name`. |

## Open items

- **Version drift.** The facts above are pinned to 2.1.319. Re-run the probes in [knowledge/claude-code.md](knowledge/claude-code.md) after a Claude Code upgrade.
- **Shared memory.** Notes saved in one mode load in every other mode, and the memory index is per project folder, not per mode.
- **Effort.** Probe passed (TASK-003): `effortLevel` from `--settings` reaches the API request, so D7 works as built.
