# Claude Code customizations

All in `~/.claude/settings.json` unless noted. Backups in `~/.claude/backups/settings.json.pre-*`.

| Date | Setting | Value | Why |
|---|---|---|---|
| 2026-11-08 | `disableClaudeAiConnectors` | `true` | Don't load claude.ai connectors (Gmail, Drive, Notion, Figma, etc.) by default. Remove to re-enable. |
| 2026-11-08 | `syncClaudeAiSkills` | `false` | Don't sync the `anthropic-skills:*` set from claude.ai. |
| 2026-11-08 | `syncClaudeAiPlugins` | `false` | Don't sync account plugins from claude.ai. Base plugins are installed from GitHub instead (below). Replaced an earlier per-plugin `@synced: false` list. |
| 2026-11-08 | `extraKnownMarketplaces` + `enabledPlugins` | `ponytail@ponytail` (github.com/dietrichgebert/ponytail, v5.3.3) | Base plugin: lazy-senior-dev coding mode. Includes the band (badge above the prompt). |
| 2026-11-08 | `extraKnownMarketplaces` + `enabledPlugins` | `i-have-adhd@i-have-adhd` (github.com/ayghri/i-have-adhd, v0.4.1) | Base plugin: ADHD-friendly output (action first, numbered steps, no tangents). Hook reviewed: only reads its own SKILL.md, no network. |
| 2026-11-08 | `extraKnownMarketplaces` + `enabledPlugins` | `egm@egm` (github.com/google/elephant-goldfish-model, v0.1.1) | Base plugin: Elephant-Goldfish Model, design-doc drafting and fresh-eyes review. Skills + agents only, no hooks or MCP. |
| 2026-11-08 | file `~/.claude/.i-have-adhd-always` | exists (empty) | Makes i-have-adhd always on: its SessionStart hook loads the ruleset every session. Delete the file to go back to on-demand. |
| 2026-11-08 | `statusLine` | added, then removed | Ponytail's band already shows its badge above the prompt; the statusLine just duplicated it. Ignore ponytail's "STATUSLINE SETUP NEEDED" startup nudge. |
| 2026-11-08 | file `~/.claude/AGENTS.md` | global instructions (starts with "Plugin scope": i-have-adhd = communication, ponytail = work) | Single place for my global rules. On its own, Claude Code only loads it as an ancestor-folder file, so it was missing outside `~/`. |
| 2026-11-08 | file `~/.claude/CLAUDE.md` | one line: `@AGENTS.md` | Makes AGENTS.md truly global. Tested: one copy loads inside and outside `~/`. Edit AGENTS.md, not this. |
| 2026-11-08 | `hooks.SessionStart` + file `~/.claude/hooks/herdr-agent-state.sh` | added by `herdr integration install claude` | herdr integration: on session start, sends the session ID and transcript path to herdr's local Unix socket so the herdr pane knows which Claude session it holds. Only runs inside a herdr pane (`HERDR_ENV=1`); does nothing elsewhere. No network. Hook reviewed. herdr manages the script and overwrites it on reinstall, so don't edit it: put custom hooks next to it. |
| 2026-11-08 | folder `~/.claude/modes/{design,planning,building}/` | copied from this repo's `modes/` (each: `prompt.md` + `settings.json`) | Working modes: per-session mindset, workflow and plugin overrides. Loaded only via `--append-system-prompt-file` + `--settings`; plain sessions untouched (tested). Copy, not symlink: edit in the repo, test, then re-copy. Design: MODES-DESIGN.md. |
| 2026-11-08 | file `~/.local/bin/cmode` | copied from this repo's `bin/cmode` | Launcher: `cmode design\|planning\|building [claude args]` starts claude in that mode (adds `--name <mode>` so the tab title shows it). Unknown mode lists modes, exits 2. Self-check: `bin/cmode-test`. Re-copy after editing. |
| 2026-11-08 | folder `~/.claude/skills/handoff/` | `SKILL.md` + `README.md` restored from the trashed solo-skills plugin (my own dotfiles-agents marketplace) | `/handoff` writes a cold-start handoff file (`_meta/HANDOFF.md`, gitignored) at session boundaries. Works without atelier's hooks; a fresh session must be told to read the file. Tested: loads in a fresh session. |
| 2026-11-08 | file `~/.claude/modes/building/settings.json` | `enabledPlugins.ponytail@ponytail: true` removed; file is now `{}` | Redundant: `~/.claude/settings.json` already enables ponytail (egm review C12, TASK-003). Re-installed via `./install.sh`; `cmode building` still loads ponytail. |
