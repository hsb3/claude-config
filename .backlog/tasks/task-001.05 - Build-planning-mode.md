---
id: TASK-001.05
title: Build planning mode
status: Done
assignee:
  - '@claude-worker'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:45:00Z'
labels: []
dependencies:
  - TASK-001.04
documentation:
  - MODES-DESIGN.md
parent_task_id: TASK-001
ordinal: 6000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Planning sessions turn an approved design into an implementation plan. They read the design hand-off doc from docs/, ponytail on, higher effort (D6, D7). Reuse the folder pattern proven by the design mode. Mode content is the user call: draft, then get approval.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 modes/planning/ in this repo holds prompt.md (under one screen) and settings.json
- [x] #2 A session started with --append-system-prompt-file and --settings pointing at modes/planning/ shows the planning prompt with the expected plugins on and off
- [x] #3 The user has reviewed and approved prompt.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write modes/planning/settings.json: effortLevel high; ponytail left out (stays on from user settings).
2. Write modes/planning/prompt.md: plan-not-build mindset; workflow Read design → check code → steps → risks/verification → write; hand-off docs/plans/<feature>.md plus backlog tasks via CLI when backlog/ or .backlog/ exists; building mode reads it.
3. Test with fresh claude -p stream-json from mktemp -d: prompt marker present, ponytail hook + skills present, i-have-adhd present.
4. Comment test evidence; leave In Progress for user approval; commit.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: Build and test in this repo under modes/<mode>/ only; do not write to ~/.claude/ (installation is TASK-001.08). Do not edit CUSTOMIZATIONS.md: the coordinator owns it.

Coordinator verified after merge (988e61c): fresh claude -p with modes/planning flags shows '# Mode: planning', expected ponytail state, i-have-adhd active. Prompt reviewed and approved by coordinator on the user's behalf (user: 'i want you to just run with this').
<!-- SECTION:NOTES:END -->

## Comments

<!-- COMMENTS:BEGIN -->
author: @claude-worker
created: 2026-11-08T19:44:00Z

---

Test evidence (claude 2.1.319, fresh claude -p from mktemp -d, --append-system-prompt-file modes/planning/prompt.md --settings modes/planning/settings.json --output-format stream-json --verbose --tools=""):
- Planning prompt present: model quoted the mindset sentence verbatim and the hand-off path docs/plans/<feature>.md.
- Ponytail on: hook printed PONYTAIL MODE ACTIVE — level: full; init lists 6 ponytail skills.
- i-have-adhd on: hook printed ADHD MODE ACTIVE.
- Plugins in init: i-have-adhd, ponytail, egm (+ built-ins). egm stays loaded (not turned off; D6 does not require it off).
- effortLevel high: set in settings.json; init does not report effort, so applied level not proven (same as design mode).
- prompt.md is 19 lines. Awaiting user approval (AC #3).

---
<!-- COMMENTS:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Built planning mode in modes/planning/ (prompt.md 19 lines + settings.json) following the design-mode pattern, on branch mode/planning in its own worktree, merged into main. Verified in fresh claude -p sessions: mode prompt loaded, ponytail on, i-have-adhd on. Hand-off chain: docs/designs -> docs/plans (+ backlog tasks when the project uses Backlog.md) -> building. Risk: effortLevel is set but the init event does not report it, so its effect is unproven.
<!-- SECTION:FINAL_SUMMARY:END -->
