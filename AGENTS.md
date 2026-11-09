# Working in claude-config

## What this is

The product is a Claude Code setup reproducible from a fresh install: global settings and instructions (`global/`), three working modes (`modes/`) and the `cmode` launcher (`bin/`), copied into place by `./install.sh`. Everything else in the repo documents or tests it. Layout: README "What's here".

## Tooling, and when

- **Backlog.md** for work that needs planning, decisions or hand-off notes. Load the `backlog-extras:backlog-md` skill first and use only the `backlog` CLI (in Claude sessions it is the backlog-extras wrapper, pinned in `~/.local/share/backlog-extras/upstream`; outside Claude use `bl`). Questions, exploration and mechanical edits need no task. What goes where:
  - **task**: a change to the product or its docs, with verifiable acceptance criteria. Subtasks when steps share one goal; `--dep` when they span components. Commit the task file before launching a worker in a worktree.
  - **draft**: a candidate the owner has not approved (ideas from sessions, follow-ups). Promote on a go-ahead, archive when dropped. The owner's own ideas start in gitignored `NOTES.md` and become drafts or tasks when picked up.
  - **decision**: a choice between alternatives that constrains later work and is costly to reverse (a language, the layout, which Claude Code feature carries a behavior). Create it `proposed` with context, decision, consequences; the owner accepts. Link its ID from the design doc. D1–D11 in `docs/modes-design.md` predate this and stay there.
  - **milestone**: a shippable version of the product (`m-0` is v1). Every task gets one; add the next when a new goal starts.
  - **doc**: not used. Prose lives in `docs/`, reviewed in git and linked by path.
- **Self-checks** `tests/cmode-test` and `tests/install-test` before committing a change to `bin/`, `install.sh` or `global/`. `tests/workflow-test` (needs jq) before committing a change to `modes/`. Then `./install.sh` after any product edit (settings.json: merge by hand from its diff). Never edit the copies in `~/.claude/` directly.
- **`/handoff`** at session boundaries. Session state lives in gitignored `_meta/HANDOFF.md`; read it when a session starts.
- **egm** (design-doc drafting and review) runs only in `cmode design`. Usage: `docs/knowledge/egm.md`.
- **Worktrees**: agents working in parallel each use their own; a single agent uses the main checkout.
- Read a plugin's hooks and MCP config before installing it.
- **Claude Code docs** before deciding what Claude Code can do (flags, settings, agents, hooks, plugins): the index is https://code.claude.com/docs/llms.txt, each page also as `.md`. Read the page, then design; probe only what it leaves unclear, and record load-bearing facts in `docs/knowledge/claude-code.md` with date and version.

## Conventions

- The layout is described once, in README "What's here". Other docs link to it instead of repeating it.
- File names are lowercase kebab-case (`modes-design.md`, `cmode-test`). Exceptions: `README.md`, `AGENTS.md`, `CLAUDE.md`, and names a tool dictates (`settings.json`, `SKILL.md`, `.i-have-adhd-always`).
- Where files go: the root holds only `install.sh`, `README.md`, `AGENTS.md`. Design docs and decisions in `docs/`; tested facts about one tool in `docs/knowledge/<tool>.md`; self-checks in `tests/<thing>-test`; working files (handoff, review reports) in gitignored `_meta/`, owner notes in gitignored `NOTES.md`. Nothing new in the root.
- Every doc starts with an H1 and one line saying what it is for and when, or against which tool version, it was last checked.
- Agent instructions and skills (`global/AGENTS.md`, `modes/*/prompt.md`, `global/skills/*/SKILL.md`, this file) follow Anthropic's [Agent Skills best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices). In short: a skill's description is third person, says what it does and when to use it, and names trigger terms; the body is concise and imperative, holds only what Claude does not already know, gives one default per decision plus an escape hatch, and carries no time-sensitive facts; a SKILL.md stays under 500 lines with details in reference files one level deep, forward-slash paths; multi-step work is numbered steps with a verify-and-loop check; names are lowercase with hyphens, gerund form preferred. Re-read the doc before a large edit.
- `docs/customizations.md` records the current state of the live Claude Code config (setting, value, why). Update the row in place; git history holds the dates. Only the lead/coordinator session edits it.
- `.claude/memory/` is auto memory and is committed: the repo is a statement of preferences. Write memories impersonally (rule, date, why, how to apply; no names, personal details or paths outside the repo), one fact per file, indexed in `MEMORY.md`.
