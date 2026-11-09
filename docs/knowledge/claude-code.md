# Claude Code knowledge

Things learned while setting up, worth remembering. Version tested in brackets.

## `--agent` replaces the default system prompt [2.1.319]

`claude --agent <name>` (or the `agent` setting) runs the main thread *as* that agent. Tested with a throwaway inline agent:

```
claude --agents '{"probe":{"description":"probe","prompt":"Marker: ZEBRA-42.","tools":["Read"]}}' \
       --agent probe -p '...'
```

| | With `--agent` |
|---|---|
| Agent's own prompt | loaded |
| Default Claude Code system prompt (risky-action rules, harness guidance, `!` prefix, …) | **dropped**: replaced by a bare "Agent SDK" prompt |
| Memory system (MEMORY.md) | **dropped** |
| Plugin SessionStart hooks | still run |
| `~/.claude/CLAUDE.md` / AGENTS.md | still loaded |
| `tools:` restriction | works |

- `--agents '<json or file>'` defines agents inline for one session, with nothing written to disk. Handy for experiments.
- To **add** instructions and keep the defaults, use `--append-system-prompt "<text>"` or `--append-system-prompt-file <file>`.
- `--system-prompt[-file]` replaces the default prompt, like `--agent` does.

## Per-session overrides [2.1.319, from `claude --help` + settings schema]

- `--settings <file-or-json>`: layers above user settings (user < project < local < **flag** < policy).
- `--mcp-config <files…>`: extra MCP servers for one session. `--strict-mcp-config`: only those.
- `--tools`, `--allowedTools`, `--disallowedTools`: toolset for one session.
- `disableClaudeAiConnectors: true` can't be undone by a higher layer: "any source true wins".

## Separate config folders: `CLAUDE_CONFIG_DIR` [2.1.319]

- There's no `--config-dir` flag. The env var `CLAUDE_CONFIG_DIR=/path claude` makes Claude Code use `/path` **instead of** `~/.claude` for everything it normally keeps there: settings, plugins, CLAUDE.md, memory, history, sessions. Nothing is moved or copied. `~/.claude` is left untouched, and a new folder starts empty like a fresh install.
- **Login is separate per folder.** On macOS the keychain entry name gets a hash of the folder path appended, so each folder needs its own `/login`.
- Found in the binary, undocumented, not tested: `CLAUDE_SECURESTORAGE_CONFIG_DIR` overrides which folder the keychain entry is keyed on. Set to an empty string, it seems to reuse the default login. Test before relying on it.
- Plugins and hooks read it too: ponytail writes its flag to `${CLAUDE_CONFIG_DIR:-~/.claude}`, and i-have-adhd looks for `.i-have-adhd-always` in the same place.

## Instruction files [2.1.319]

- `AGENTS.md` alone loads only as a file from the project's folder or a folder above it (`AGENTS.md` or `.claude/AGENTS.md`). By default it's used only when the project has no CLAUDE.md of its own. `~/.claude/AGENTS.md` did **not** load in a folder outside `~/`.
- Fix used here: `~/.claude/CLAUDE.md` containing `@AGENTS.md`. Tested: loads once, inside and outside `~/`.

## Settings found in the binary (not all in public docs) [2.1.319]

- `disableClaudeAiConnectors`: turns off the claude.ai MCP connectors.
- `syncClaudeAiSkills: false` / `syncClaudeAiPlugins: false`: stop the account sync. Only `false` is honored.
- Synced plugins are addressed as `<name>@synced` in `enabledPlugins`.

## `--settings` turns a plugin off for one session [2.1.319, TASK-001.02]

**PASS.** A flag-level `enabledPlugins: false` removes the plugin completely for that session, including its SessionStart hook:

```
echo '{"enabledPlugins":{"ponytail@ponytail":false}}' > "$D/no-ponytail.json"
claude -p --settings "$D/no-ponytail.json" --output-format stream-json --verbose '<prompt>'
```

| | `--settings` with ponytail off | plain `claude -p` afterwards |
|---|---|---|
| `PONYTAIL MODE ACTIVE` hook output | absent (0 matches; 2 SessionStart hooks ran instead of 3) | present |
| `ponytail:*` skills / slash commands in init event | none | all 6 |
| i-have-adhd (`ADHD MODE ACTIVE`) | still active | active |

- `~/.claude/settings.json` is untouched; the override only lives for that one process.
- Tip: `--output-format stream-json --verbose` prints the `init` event (plugins, skills) and each `hook_response`, so you can check what loaded without asking the model.

## Plain sessions ignore `~/.claude/modes/` [2.1.319, TASK-001.03]

**PASS.** Nothing in `~/.claude/modes/<mode>/` loads into a normal session. Markers placed in `~/.claude/modes/_probe/`: `prompt.md`, `CLAUDE.md`, `rules/probe.md`, `agents/modeprobe-agent-7734.md`, and `settings.json` (`{"env":{"MODEPROBE_ENV":"..."}}`). Control: a `CLAUDE.md` with its own marker in the `mktemp -d` folder the session ran from.

```
cd "$(mktemp -d)"   # holds the control CLAUDE.md
claude -p "Run: printenv MODEPROBE_ENV (report its output or 'unset'). Then list verbatim every string in your context (system prompt, CLAUDE.md/memory, rules, agent list) that starts with MODEPROBE_ or CONTROL_. If none, say NONE for that prefix." --allowedTools "Bash(printenv:*)"
```

- Result: `MODEPROBE_ENV` unset; `MODEPROBE_` markers: NONE; control `CONTROL_PROJECT_9001` found. So the check could see loaded files, and the modes folder was not loaded.
- Gotcha: `--allowedTools` takes several values, so put the prompt **before** it, or `-p` reports "Input must be provided".

## `--append-system-prompt-file` loads a full page, keeps the default prompt [2.1.319, TASK-001.01]

**PASS.** A 60-line, 7.6 KB `prompt.md` with random markers at the start (line 2), middle (line 31) and end (line 60) arrived complete. The default Claude Code system prompt was still there alongside it.

```
cd "$(mktemp -d)"   # prompt.md here: markers START-/MIDDLE-/END-<random hex>, 56 numbered filler lines
claude -p --tools "" --append-system-prompt-file "$PWD/prompt.md" "Without using any tools, answer from your system prompt only: (1) quote verbatim every line that starts with 'Marker:'; (2) quote verbatim one sentence from your default system prompt about confirming risky or hard-to-reverse actions; (3) how many lines starting with 'Line ' do you see, and what is the highest number?"
```

- Result: all 3 markers quoted exactly; 56 of 56 filler lines counted; the default risky-action rule quoted word for word ("For actions that are hard to reverse or outward-facing, confirm first…").
- Control (same command without the flag): the session reports NONE for `Marker:` lines, so the markers came only from the file.
- `--tools ""` blocks file reads, so the model could only see the file through the system prompt.
- Gotcha: `--tools ""` also eats the next argument if the prompt comes right after it. Use `--tools=""`, or put another flag between them.

## Terminal title: use `--name`, not a title set before launch [2.1.319, TASK-001.07]

Claude Code writes its own tab title at startup (OSC 0), so a title printed by a launcher before `exec claude` is overwritten straight away. `--name <name>` sets the session name, which claude puts in the title itself.

| Started as | Title escape captured in a pty (10 s, in a trusted folder) |
|---|---|
| `claude` | `✳ Claude Code` |
| `claude --name design` | `✳ design` |

- `terminalTitleFromRename` (setting, default `true`): `/rename` and the session name drive the title; `false` keeps auto-generated topic titles instead. `CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1` stops claude writing a title at all.
- The name also shows in the prompt box and the `/resume` picker, so every session started by `cmode design` is named `design` there. `/rename` still works.
- Not tested: whether the title stays after the first reply, since that needs a real API turn. The schema text implies the name wins over topic titles while `terminalTitleFromRename` is `true`.
- Gotcha: in an untrusted folder the trust dialog comes first and no title was written within 10 s.
- Gotcha: claude ignores SIGTERM under a pty, so a test harness waiting on it hangs. Use SIGKILL.

## `effortLevel` through `--settings` sets the request effort [2.1.319, TASK-003]

**PASS.** A flag-level `effortLevel` reaches the API request as `output_config.effort`. The init event and `/effort` in `-p` don't show the effort, so the probe reads the request itself. A local Python server on 127.0.0.1 logs only the `model`, `thinking` and `output_config` fields of each `POST /v1/messages` and answers 400. Claude is pointed at it with `ANTHROPIC_BASE_URL`:

```
python3 -I cap.py out.txt &      # logs those fields, answers 400
ANTHROPIC_BASE_URL=http://127.0.0.1:8765 claude -p --tools= --settings '{"effortLevel":"high"}' "Reply OK."
```

| Run (model opus, `~/.claude/settings.json` has no effort key) | `output_config.effort` |
|---|---|
| no override | `medium` (built-in default) |
| `--settings '{"effortLevel":"low"}'` | `low` |
| `--settings '{"effortLevel":"high"}'` | `high` |
| `--effort low` | `low` |
| `--settings ~/.claude/modes/building/settings.json` | `medium` |
| `--settings ~/.claude/modes/design/settings.json` | `high` |

- Requests also carry `thinking: {"type":"adaptive"}`. Effort is the only setting that changes between runs.
- Gotcha: zsh doesn't word-split `$var`, so `claude $args` with `args="--settings x"` fails with "unknown option '--settings x'". Pass the flags as separate words.

## Custom agents (subagents): what is configurable [docs, read 2026-11-09, not probed]

Source of truth: https://code.claude.com/docs/en/sub-agents.md. Re-read it before building a per-mode agent; this is a digest, and unknown or misspelled fields are ignored silently (find them with `claude --debug`, search "does not recognize or apply").

Frontmatter (`name` and `description` required; camelCase, exact spelling):

| Field | Values | Note |
|---|---|---|
| `name` | up to 256 chars, no `:`, no leading `-` | hooks receive it as `agent_type`; filename is irrelevant |
| `description` | text | drives automatic delegation; combined descriptions over 15k tokens warn at startup |
| `tools` / `disallowedTools` | comma list or YAML list | denylist first; `mcp__<server>__*` for one MCP server; `Bash(git push *)` in `disallowedTools` removes all of Bash (use `permissions.deny` instead) |
| `model` | `sonnet`, `opus`, `haiku`, `fable`, full ID, `inherit` | order: Agent-call param, this field, `CLAUDE_CODE_SUBAGENT_MODEL`, main model |
| `effort` | `low`..`max` | per-call param overrides; `CLAUDE_CODE_EFFORT_LEVEL` overrides both |
| `permissionMode` | `default`, `acceptEdits`, `auto`, `dontAsk`, `bypassPermissions`, `plan` | ignored when the main session is in bypass, acceptEdits or auto; ignored for plugin agents |
| `maxTurns`, `autoCompactWindow` | int; 100000..1000000 (2.1.296+) | partial output returned at the turn limit |
| `skills` | list of skill names | full content preloaded, first 32; `disable-model-invocation` skills can't be preloaded |
| `mcpServers` | server name or inline `{name: config}` | inline ones connect for the agent's lifetime; ignored for plugin agents |
| `hooks` | lifecycle hooks | run only while the agent is active; `Stop` becomes `SubagentStop`; ignored for plugin agents; project-agent hooks need the folder trusted |
| `memory` | `user`, `project`, `local` | `MEMORY.md` first 200 lines / 25KB into the prompt; off when auto memory is off |
| `background`, `isolation` | `true`; `worktree` | worktree branches from the default branch, not HEAD |
| `omitClaudeMd` | `true` (2.1.271+) | skip CLAUDE.md; ignored when run as the main agent via `--agent` |
| `initialPrompt` | text | auto-submitted first turn when run via `--agent`; ignored for plugin agents |
| `color`, `experimental.cacheTtl` | 8 colors; `5m`/`1h` | both ignored in `--agents` JSON |

Locations, highest priority first: managed settings `.claude/agents/`, `--agents` (session only), project `.claude/agents/` (walks up to the repo root; nearest wins), `~/.claude/agents/`, plugin `agents/` (registered as `<plugin>:<path>`). Same `name` in one tree: one loads by read order; `/doctor` reports it. Hot reload within seconds, except the first file in a new `agents/` dir.

Not inherited: the Claude Code system prompt (the body is the whole prompt; confirms the `--agent` finding above), conversation history (forks excepted), output style, auto memory. Explore and Plan also skip CLAUDE.md and the git snapshot. Background subagents get a reduced built-in tool set (Read, Grep, Glob, Bash, Edit, Write, WebFetch, WebSearch, Skill, ToolSearch, worktree and messaging tools) plus all MCP tools.

Gotchas: a file without `name` is treated as documentation; `name` without `description`, bad YAML, or frontmatter not on line 1 is skipped with only a debug-log entry. Validate with `claude plugin validate <dir>` (2.1.233+). Plugin agents lose `hooks`, `mcpServers` and `permissionMode`: copy the file into `.claude/agents/` when those are needed.
