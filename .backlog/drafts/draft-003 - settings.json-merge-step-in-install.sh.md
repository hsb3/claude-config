---
id: DRAFT-003
title: settings.json merge step in install.sh
status: Draft
assignee: []
created_date: '2026-11-09T03:16:00Z'
labels:
  - install
dependencies: []
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Candidate since 2026-11-08 (TASK-008 shortcut). Today the installer prints a diff and the owner merges by hand. Build only if hand-merging gets tedious; per decision-001 this is the likely trigger for TypeScript on bun.
<!-- SECTION:DESCRIPTION:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [ ] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [ ] #3 Live config changes recorded in docs/customizations.md
<!-- DOD:END -->
