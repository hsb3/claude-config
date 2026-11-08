---
id: TASK-001.08
title: Install tested modes into ~/.claude/modes/
status: Done
assignee:
  - '@coordinator'
created_date: '2026-11-08T19:38:00Z'
updated_date: '2026-11-08T19:46:00Z'
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
- [x] #1 ~/.claude/modes/{design,planning,building}/ match the approved repo versions
- [x] #2 Each mode, started from the installed location, passes the same check as in the repo
- [x] #3 A plain `claude` session is unchanged after install
- [x] #4 The install is logged in CUSTOMIZATIONS.md by the coordinator
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Copy modes/{design,planning,building} to ~/.claude/modes/ (copy, not symlink: repo edits stay a deliberate install step).
2. Diff installed vs repo.
3. Re-run the per-mode check from the installed path; check a plain session shows no mode prompt.
4. Log in CUSTOMIZATIONS.md.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
diff -r modes ~/.claude/modes: identical. Installed-path checks: design ponytail=0 adhd=1; planning and building ponytail=1 adhd=1; each quotes its "# Mode:" line. Plain claude -p: 0 mode lines in context, answers NO, ponytail still on.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Copied the three approved modes into ~/.claude/modes/ (copy, not symlink, so repo edits need a deliberate re-install). Re-tested each from the installed path in fresh claude -p sessions: correct mode prompt and plugin state. A plain session is unchanged. Logged in CUSTOMIZATIONS.md.
<!-- SECTION:FINAL_SUMMARY:END -->
