---
id: TASK-001.06
title: Build building mode
status: In Progress
assignee:
  - '@claude-worker'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:44:00Z'
labels: []
dependencies:
  - TASK-001.04
documentation:
  - MODES-DESIGN.md
parent_task_id: TASK-001
ordinal: 7000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Building sessions implement an approved plan. Ponytail on, default effort (D6, D7). Reuse the folder pattern proven by the design mode. Mode content is the user call: draft, then get approval.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 modes/building/ in this repo holds prompt.md (under one screen) and settings.json
- [ ] #2 A session started with --append-system-prompt-file and --settings pointing at modes/building/ shows the building prompt with the expected plugins on and off
- [ ] #3 The user has reviewed and approved prompt.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write modes/building/settings.json: ponytail@ponytail true (explicit, matches base), no effortLevel key (D7 default).
2. Write modes/building/prompt.md: implement-the-approved-plan mindset; workflow reads docs/plans/<feature>.md and, when the project uses Backlog.md, the plan's backlog tasks; step by step, verify each, flag deviations instead of redesigning; no restating ponytail/i-have-adhd/default rules.
3. Test with fresh claude -p stream-json from mktemp -d: prompt marker present, ponytail hook + skills present, i-have-adhd present, effort not set by mode.
4. Comment test evidence; leave In Progress for user approval; commit on branch.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: Build and test in this repo under modes/<mode>/ only; do not write to ~/.claude/ (installation is TASK-001.08). Do not edit CUSTOMIZATIONS.md: the coordinator owns it.
<!-- SECTION:NOTES:END -->

## Comments

<!-- COMMENTS:BEGIN -->
author: @claude-worker
created: 2026-11-08T19:44:00Z

---

Test evidence (claude 2.1.319, fresh claude -p from mktemp -d, --append-system-prompt-file modes/building/prompt.md --settings modes/building/settings.json --output-format stream-json --verbose --tools=""):
- Building prompt present: model quoted the mindset first sentence and the first Deviations sentence verbatim.
- Default prompt kept: model quoted the hard-to-reverse-actions rule word for word.
- Ponytail on: 3 SessionStart hooks ran, one printed PONYTAIL MODE ACTIVE; init lists all 6 ponytail:* skills.
- i-have-adhd on: hook printed ADHD MODE ACTIVE.
- Effort: settings.json has no effortLevel key, so the user default applies (D7). init does not report effort.
- prompt.md is 19 lines. settings.json sets ponytail@ponytail true explicitly (same as base, documents D6).
- Hand-off: reads docs/plans/<feature>.md plus backlog tasks when backlog/ or .backlog/ exists; links back to docs/designs/<feature>.md.
Awaiting user approval of prompt.md (AC #3).

---
<!-- COMMENTS:END -->
