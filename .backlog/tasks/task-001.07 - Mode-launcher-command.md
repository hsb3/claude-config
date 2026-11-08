---
id: TASK-001.07
title: Mode launcher command
status: Done
assignee:
  - '@claude-worker'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:50:00Z'
labels: []
dependencies:
  - TASK-001.08
documentation:
  - MODES-DESIGN.md
parent_task_id: TASK-001
ordinal: 8000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Typing the full flag set per mode is error-prone. One shell command (e.g. cmode <mode>) should start a session in a mode and set the terminal tab title to the mode name (D11). Built last on purpose (user request), once all three modes exist.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 `cmode design|planning|building` starts a session in that mode; extra arguments pass through to claude
- [x] #2 An unknown mode name prints the available modes and exits non-zero without starting claude
- [x] #3 The terminal tab title shows the active mode
- [x] #4 A small self-check covers the unknown-mode and pass-through cases
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. bin/cmode (POSIX sh): root ${CLAUDE_CONFIG_DIR:-$HOME/.claude}/modes; validate mode (prompt.md+settings.json exist, no / or leading dot), else list modes, exit 2.
2. exec claude --name <mode> --append-system-prompt-file --settings [+ --mcp-config if mcp.json] + passthrough args.
3. Title: test in pty whether claude overwrites a launcher-set title; use --name if so. Record in claude-code-knowledge.md.
4. bin/cmode-test with stub claude + fake CLAUDE_CONFIG_DIR: missing arg, unknown mode, path rejection, pass-through, mcp.json.
5. Comment test output; leave In Progress.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: build and test the launcher in this repo; the coordinator owns CUSTOMIZATIONS.md.

Coordinator verified: bin/cmode-test 8/8 ok; `cmode bogus` lists modes, exit 2; installed copy at ~/.local/bin/cmode (identical); real `cmode planning -p` session loaded "# Mode: planning" with ponytail and i-have-adhd on. Title via --name (agent pty test: "✳ design").
<!-- SECTION:NOTES:END -->

## Comments

<!-- COMMENTS:BEGIN -->
author: @claude-worker
created: 2026-11-08T19:49:00Z

---

Files: bin/cmode, bin/cmode-test (both chmod +x, POSIX sh), section appended to claude-code-knowledge.md.

bin/cmode-test (sh and zsh, exit 0):
ok   missing arg exits non-zero
ok   missing arg lists modes
ok   unknown mode exits non-zero
ok   unknown mode lists modes
ok   path in mode name rejected
ok   pass-through args
ok   no mcp.json, no --mcp-config
ok   mcp.json adds --mcp-config

bin/cmode against the real ~/.claude/modes with no arg: lists building, design, planning; exit 2.

Title (AC #3): claude writes its own OSC 0 title at startup, so a printf'd title would be overwritten. pty capture: plain claude -> '✳ Claude Code'; claude --name design -> '✳ design'. cmode passes --name <mode>. Not tested: title after the first reply (needs an API turn). Side effect: sessions are named <mode> in /resume; a user -n/--name in the passed-through args comes later and should override it (not tested).
Not done: a real interactive cmode session start (AC #1 checked only via the stub).

---
<!-- COMMENTS:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added bin/cmode (POSIX sh): cmode <mode> [claude args] runs claude with the mode prompt.md/settings.json (+ mcp.json when present) from ${CLAUDE_CONFIG_DIR:-~/.claude}/modes, plus --name <mode> so Claude Code itself shows the mode in the tab title (a launcher-printed title is overwritten). Unknown/missing mode lists modes and exits 2. bin/cmode-test covers 8 cases with a stub claude. Installed to ~/.local/bin/cmode and logged. Risk: title persistence after the first reply is untested (needs a real API turn).
<!-- SECTION:FINAL_SUMMARY:END -->
