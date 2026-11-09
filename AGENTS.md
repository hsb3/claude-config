## Repo conventions
- The product is what `./install.sh` copies: `global/` (to `~/.claude/`), `modes/` (to `~/.claude/modes/`), `bin/cmode` (to `~/.local/bin/`). Everything else documents or tests it. Edit the product here, then run `./install.sh` (settings.json: merge by hand from its diff). Never edit the copies in `~/.claude/` directly.
- The layout is described once, in README "What's here". Other docs link to it instead of repeating it.
- File names are lowercase kebab-case (`modes-design.md`, `cmode-test`). Exceptions: `README.md`, `AGENTS.md`, `CLAUDE.md`, and names a tool dictates (`settings.json`, `SKILL.md`, `.i-have-adhd-always`).
- Where files go: the root holds only `install.sh`, `README.md`, `AGENTS.md`. Design docs and decisions in `docs/`; tested facts about one tool in `docs/knowledge/<tool>.md`; self-checks in `tests/<thing>-test`; working files (handoff, review reports) in gitignored `_meta/`, owner notes in gitignored `NOTES.md`. Nothing new in the root.
- Every doc starts with an H1 and one line saying what it is for and when, or against which tool version, it was last checked.
- `docs/customizations.md` records the current state of the live Claude Code config (setting, value, why). Update the row in place; git history holds the dates. Only the lead/coordinator session edits it.
- Agents working in parallel each use their own git worktree; a single agent uses the main checkout.
- Read a plugin's hooks and MCP config before installing it.
- In Claude sessions `backlog` is the backlog-extras wrapper; it runs the pinned Backlog.md in `~/.local/share/backlog-extras/upstream`. Outside Claude, use `bl` (same wrapper, `~/.local/bin`).
- Session state lives in `_meta/HANDOFF.md` (gitignored, run `/handoff`); read it at the start of a session.

<CRITICAL_INSTRUCTION>

## Backlog.md Workflow

This project uses Backlog.md for task and project management.

**At the beginning of each conversation in this project, run `backlog instructions overview` before answering or taking action. Re-read it only if you have not read it yet in the current conversation.**

Use the overview to decide whether to search, read, create, or update Backlog tasks.

Before task lifecycle actions, read the matching detailed guide:
- `backlog instructions task-creation` before creating or splitting tasks
- `backlog instructions task-execution` before planning, changing status or assignee, adding a plan or implementation notes, or implementing task work
- `backlog instructions task-finalization` before checking acceptance criteria, writing final summaries, or moving tasks to terminal statuses

Use `backlog <command> --help` before running unfamiliar commands. Help shows options, fields, and examples.

Do not edit Backlog task, draft, document, decision, or milestone markdown files directly. Use the `backlog` CLI so metadata, relationships, and history stay consistent.

</CRITICAL_INSTRUCTION>
<!-- BACKLOG.MD GUIDELINES END -->
