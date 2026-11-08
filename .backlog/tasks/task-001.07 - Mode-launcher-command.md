---
id: TASK-001.07
title: Mode launcher command
status: To Do
assignee: []
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:38:00Z'
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
- [ ] #1 `cmode design|planning|building` starts a session in that mode; extra arguments pass through to claude
- [ ] #2 An unknown mode name prints the available modes and exits non-zero without starting claude
- [ ] #3 The terminal tab title shows the active mode
- [ ] #4 A small self-check covers the unknown-mode and pass-through cases
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: build and test the launcher in this repo; the coordinator owns CUSTOMIZATIONS.md.
<!-- SECTION:NOTES:END -->
