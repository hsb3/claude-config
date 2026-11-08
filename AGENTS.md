## Repo conventions
- Edit modes in `modes/` and the launcher in `bin/`, then run `./install.sh`. Never edit `~/.claude/modes/` directly; it holds copies.
- Log every change to the live Claude Code config in `CUSTOMIZATIONS.md` (date, setting, value, why). Only the lead/coordinator session edits it.
- Agents working in parallel each use their own git worktree; a single agent uses the main checkout.
- Read a plugin's hooks and MCP config before installing it.
- `backlog` may not be on PATH in scripts: `export PATH="$HOME/.bun/bin:$PATH"`.
- Session state lives in `_meta/HANDOFF.md` (gitignored, run `/handoff`); read it at the start of a session.

<!-- BACKLOG.MD GUIDELINES START -->
<!-- backlog.md-instructions-version: 1.55.3 -->
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
