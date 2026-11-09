# Claude Code customizations

Current state of my live Claude Code config and why each piece is there (checked 2026-11-08). Shipped items come from `global/` and `modes/` via `./install.sh`; git history is the dated log of changes. Backups of `settings.json`: `~/.claude/backups/settings.json.pre-*`.

## Shipped by `./install.sh`

In `~/.claude/settings.json` (from `global/settings.json`) unless noted.

| Setting | Value | Why |
|---|---|---|
| `disableClaudeAiConnectors` | `true` | Don't load claude.ai connectors (Gmail, Drive, Notion, Figma, etc.). Remove to re-enable. A mode that needs one adds that server's own MCP in its `mcp.json`. |
| `syncClaudeAiSkills`, `syncClaudeAiPlugins` | `false` | Don't sync skills or plugins from the claude.ai account. Base plugins come from GitHub marketplaces instead. |
| `extraKnownMarketplaces` + `enabledPlugins` | `ponytail@ponytail` **on** (github.com/dietrichgebert/ponytail) | Lazy-senior-dev coding mode. Its band above the prompt shows the badge, so no `statusLine` (one was added and removed: it duplicated the band; ignore ponytail's "STATUSLINE SETUP NEEDED" nudge). |
| `extraKnownMarketplaces` + `enabledPlugins` | `i-have-adhd@i-have-adhd` **on** (github.com/ayghri/i-have-adhd) | ADHD-friendly output: action first, numbered steps, no tangents. Hook reviewed: reads only its own SKILL.md, no network. |
| `extraKnownMarketplaces` + `enabledPlugins` | `egm@egm` **off** (github.com/google/elephant-goldfish-model) | Elephant-Goldfish Model: design-doc drafting and fresh-eyes review. Skills and agents only, no hooks or MCP. Off in the base and on only in design mode (owner decision), so plain `claude` has no `/egm:*`. |
| `permissions.defaultMode` | `bypassPermissions` | Owner edit 2026-11-09 (was `auto`). A fresh install runs without permission prompts; modes do not override it. |
| `env` | telemetry, error reporting and nonessential traffic off (`CLAUDE_CODE_ENABLE_TELEMETRY=0`, `DISABLE_TELEMETRY`, `DISABLE_ERROR_REPORTING`, `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`, `CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY`), `ENABLE_CLAUDEAI_MCP_SERVERS=false`, `CLAUDE_CODE_DISABLE_AGENT_VIEW=1`, `CLAUDE_CODE_PLUGIN_PREFER_HTTPS=1`, `CLAUDE_CODE_MAX_SUBAGENT_SPAWN_DEPTH=5` | Owner edit 2026-11-09. Privacy and quiet by default; plugins fetched over HTTPS; subagents may nest five deep (default three). |
| `cleanupPeriodDays` | `1800` | Owner edit 2026-11-09. Keep transcripts about five years instead of the 30-day default. |
| `attribution.commit`, `attribution.pr` | `""` | Owner edit 2026-11-09. Claude Code adds no Co-Authored-By or PR footer. |
| `$schema` | json.schemastore.org claude-code-settings | Editor validation of the settings file. |
| `hooks`, `pluginConfigs` | `{}` | Empty placeholders so the keys are visible to edit. Machine hooks (herdr) stay local. |
| **Volatile seeds:** `model`, `effortLevel`, `tui`, `theme`, `switchModelsOnFlag`, `feedbackDrafts`, `promptSuggestionEnabled`, `awaySummaryEnabled` | `opus`, `medium`, `fullscreen`, `auto`, `true`, `off`, `false`, `false` | Fresh-install defaults only. `/model`, `/effort` and `/config` write these keys into the live file, so they drift by design: expect them as `-` lines in the installer diff and do not merge them back. |
| file `.i-have-adhd-always` | empty | i-have-adhd's SessionStart hook loads its ruleset every session. Delete the file to go back to on-demand. |
| file `CLAUDE.md` | `@AGENTS.md` | Makes `AGENTS.md` truly global: on its own, Claude Code loads it only as an ancestor-folder file, so it was missing outside `~/`. Edit `AGENTS.md`, not this. |
| file `AGENTS.md` | plugin scope rule | One place for global rules: i-have-adhd governs communication, ponytail governs the work. |
| folder `skills/handoff/` | `SKILL.md` + `README.md`, from my dotfiles-agents atelier plugin | `/handoff` writes the cold-start handoff `_meta/HANDOFF.md` at session boundaries. Works without atelier's hooks; a fresh session must be told to read the file. |
| folder `modes/{design,planning,building}/` | `prompt.md` + `settings.json` each. design: ponytail off, egm on, `effortLevel: high`, `EGM artifact directory: .handoff/egm` in its prompt so egm scratch output (briefs, drafts, reports) lands in the project's gitignored `.handoff/egm/`; planning: `effortLevel: high`; building: `{}` | Working modes, loaded only via `--append-system-prompt-file` + `--settings`; plain sessions untouched (tested). Hand-offs go to the project's gitignored `.handoff/designs/` and `.handoff/plans/` (owner: no working files in a project's `docs/`). Design and decisions: [modes-design.md](modes-design.md). |
| file `~/.local/bin/cmode` | from `bin/cmode` | `cmode <mode> [claude args]` starts claude in that mode, with `--name <mode>` so the tab title shows it. Unknown mode lists modes, exits 2. |

## This repo only (project scope, `.claude/settings.json`)

| Setting | Value | Why |
|---|---|---|
| `extraKnownMarketplaces` + `enabledPlugins` | `backlog-extras@backlog-md-extras` (github.com/hsb3/backlog.md-extras) | Backlog.md wrapper, guard hook against direct `.backlog/` writes, session version check. Hooks reviewed: local only, no network, no MCP. |

## Local only (this machine, not in the repo)

| What | Value | Why |
|---|---|---|
| `hooks.SessionStart` + `~/.claude/hooks/herdr-agent-state.sh` | added by `herdr integration install claude` | Sends the session ID and transcript path to herdr's local socket so the herdr pane knows which session it holds. Runs only inside a herdr pane (`HERDR_ENV=1`), no network. herdr overwrites the script on reinstall: put custom hooks next to it. Shows as `-` lines in the installer's settings diff; keep them. |
| `~/.local/share/backlog-extras/upstream`, `~/.local/bin/bl` | backlog-extras v0.7.0 terminal install (pinned Backlog.md 1.55.3) | The wrapper could not find Backlog.md because `~/.bun/bin` is not on the session PATH. The pinned install sits where the wrapper always looks. |
| `~/.claude/settings.json` extras | `skipDangerousModePermissionPrompt: true`; marketplace `backlog-md-extras` at user scope | Skips the bypass-mode confirmation on this machine; the marketplace entry came with the project plugin install. Both show as `-` lines in the installer diff; keep them. |
| `.claude/settings.local.json` (this repo, gitignored) | `spinnerTipsEnabled: false`, `prefersReducedMotion: true`, `autoMemoryDirectory: ~/Developer/claude-config/.claude/memory` | UI preferences, and auto memory kept inside the project at `.claude/memory/` (committed, written impersonally) instead of `~/.claude/projects/<project>/memory/`. Local file because the key needs an absolute or `~/` path. |
