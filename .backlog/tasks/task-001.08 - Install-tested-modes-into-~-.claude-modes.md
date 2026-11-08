---
id: TASK-001.08
title: Install tested modes into ~/.claude/modes/
status: To Do
assignee: []
created_date: '2026-11-08T19:38:00Z'
labels: []
dependencies:
  - TASK-001.04
  - TASK-001.05
  - TASK-001.06
parent_task_id: TASK-001
ordinal: 9000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Modes are built and tested in this repo (modes/<mode>/) before touching the live global config, at the user request. Once all three are approved, they get copied or linked into ~/.claude/modes/ and re-tested from there.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 ~/.claude/modes/{design,planning,building}/ match the approved repo versions
- [ ] #2 Each mode, started from the installed location, passes the same check as in the repo
- [ ] #3 A plain `claude` session is unchanged after install
- [ ] #4 The install is logged in CUSTOMIZATIONS.md by the coordinator
<!-- AC:END -->
