---
id: TASK-001.06
title: Build building mode
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

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: Build and test in this repo under modes/<mode>/ only; do not write to ~/.claude/ (installation is TASK-001.08). Do not edit CUSTOMIZATIONS.md: the coordinator owns it.
<!-- SECTION:NOTES:END -->
