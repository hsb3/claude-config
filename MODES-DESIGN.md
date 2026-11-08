# Working modes: design

Status: DRAFT, not built. Updated 2026-11-08.

## Goal

Start a Claude Code session in a **mode** (product design, implementation planning, …). Each mode brings its own mindset, workflow and toolset. Nothing mode-specific is loaded outside that mode.

## Verified facts (Claude Code 2.1.319)

Tested in this session with a throwaway inline agent (`--agents '{…}' --agent probe -p …`):

| With `--agent <x>` as the main thread | Result |
|---|---|
| Agent's own prompt | loaded |
| Default Claude Code system prompt (risky-action rules, harness, `!` prefix…) | **dropped**: replaced by a bare "Agent SDK" prompt |
| Memory system (MEMORY.md) | **dropped** |
| Plugin SessionStart hooks (ponytail, i-have-adhd) | still run |
| `~/.claude/AGENTS.md` via CLAUDE.md | still loaded |
| `tools:` restriction | works (only `Read` was available) |

From `claude --help` and the settings schema:
- `--append-system-prompt[-file]` **adds** to the default prompt instead of replacing it.
- `--tools`, `--allowedTools` and `--disallowedTools` control the toolset per session.
- `--settings <file>` layers a settings file above user settings (precedence user < project < local < **flag** < policy). So it can override `enabledPlugins`, i.e. turn ponytail off for one mode.
- `--mcp-config <file>` adds MCP servers for one session. `--strict-mcp-config` uses only those.
- `disableClaudeAiConnectors: true` in user settings **cannot** be undone per mode ("any-source-true wins"). Modes that need e.g. Figma must add that server's own MCP via `--mcp-config`, not the claude.ai connector.

## Design change vs. the agreed "option 1 + 2"

`--agent` drops the default prompt and memory, so it's the wrong carrier for a mode's mindset. Proposed instead:

**A mode = 1 folder + 1 launcher**

```
~/.claude/modes/<mode>/
  prompt.md      # mindset + workflow, appended to the default prompt
  settings.json  # overrides: plugins on/off, permissions, model, outputStyle…
  mcp.json       # optional: MCP servers only this mode needs
```

The launcher is a shell function, e.g. `cmode design`, which runs:

```
claude --append-system-prompt-file ~/.claude/modes/design/prompt.md \
       --settings ~/.claude/modes/design/settings.json \
       [--mcp-config ~/.claude/modes/design/mcp.json] [--tools …]
```

Keep `--agent` for a mode only if it deliberately wants a bare prompt (unlikely).

### Alternative: one config folder per mode (`CLAUDE_CONFIG_DIR`)

`CLAUDE_CONFIG_DIR=~/.claude-modes/design claude` makes Claude Code use that folder instead of `~/.claude`. `~/.claude` is left untouched, and the mode folder starts empty.

| | Layered (above) | Folder per mode |
|---|---|---|
| Isolation | delta only: base always shared | total |
| Shared base (AGENTS.md, plugins, settings) | one copy | duplicated per mode, or symlinked; copies drift |
| Login | shared | separate `/login` per folder (keychain is keyed by folder) |
| Memory, history, sessions | shared | split per mode, so `--resume` and memory are per mode |
| Plugin set | add or turn off on top of the base | completely different |

Leaning: layered by default. Use a folder per mode only for a mode whose toolset is radically different from the base.

## Decisions (2026-11-08)

| # | Decision |
|---|---|
| D1 | Modes for now: **design**, **planning**, **building**. |
| D2 | Structure: **layered** (shared base, each mode adds a delta). Folder-per-mode only for a mode whose toolset is radically different. |
| D3 | Memory and history: **shared** across modes. |
| D4 | Mode files: `~/.claude/modes/<mode>/` → `prompt.md` (under one screen), `settings.json`, optional `mcp.json`. |
| D5 | Each mode defines: mindset (2–3 sentences), workflow steps, plugins on/off, MCPs, model and effort. |
| D6 | Plugins: ponytail **off** in design, on in planning and building. i-have-adhd on everywhere. egm used in design. |
| D7 | Effort: higher in design and planning, default in building. |
| D8 | Plain `claude` = today's setup. Modes are opt-in. |
| D9 | One mode per session. No mid-session switching for now. |
| D10 | Hand-off: design writes a doc to the project's `docs/`, planning reads it. **Provisional**: you don't love working files in `docs/`. Revisit (e.g. a gitignored `.handoff/` folder). |
| D11 | Active mode shown in the terminal tab title, set by the launcher. |
| D12 | Build order: probes → one mode end to end → copy pattern → launcher last. |
| D13 | Build and test in this repo (`modes/<mode>/`). Install into `~/.claude/modes/` only after approval (TASK-001.08). |
| D14 | Agents working in parallel each get their own git worktree. A single agent works in this folder. |
| D15 | The coordinator alone edits CUSTOMIZATIONS.md and logs changes on the user's behalf. |

## Open questions (need your input)

1. **Mode list.** Design and implementation planning so far. What else? (e.g. build/implement, review, research, writing, ops?)
2. **Per mode:** mindset (2–3 sentences), workflow steps, tools on/off, plugins on/off, MCPs, model and effort.
3. **Default (no mode).** Is a plain `claude` session today's setup, or a mode of its own?
4. **Switching.** A new session per mode (simplest), or do you need to switch mid-session?
5. **Hand-off between modes.** Does design output a doc that planning picks up? Where do those files live (project folder, `docs/`)? The egm plugin is built for that design-doc → review → plan flow.
6. **Where it shows.** Should the active mode appear somewhere (status line, terminal title)?

## Not decided / risks

- Probes done (TASK-001.01–.03, all PASS; see claude-code-knowledge.md): a 60-line appended prompt loads in full alongside the default prompt; `--settings` with `enabledPlugins: false` removes the plugin and its SessionStart hook for one session; plain sessions ignore `~/.claude/modes/`.
- The memory index is per project folder, not per mode. Modes share it.
