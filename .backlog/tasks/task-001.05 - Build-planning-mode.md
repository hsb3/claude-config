---
id: TASK-001.05
title: Build planning mode
status: To Do
assignee: []
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:38:00Z'
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
- [ ] #1 modes/planning/ in this repo holds prompt.md (under one screen) and settings.json
- [ ] #2 A session started with --append-system-prompt-file and --settings pointing at modes/planning/ shows the planning prompt with the expected plugins on and off
- [ ] #3 The user has reviewed and approved prompt.md
<!-- AC:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: Build and test in this repo under modes/<mode>/ only; do not write to ~/.claude/ (installation is TASK-001.08). Do not edit CUSTOMIZATIONS.md: the coordinator owns it.
<!-- SECTION:NOTES:END -->
