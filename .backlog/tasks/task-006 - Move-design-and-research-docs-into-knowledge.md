---
id: TASK-006
title: Move design and research docs into knowledge/
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T00:16:00Z'
updated_date: '2026-11-09T00:17:00Z'
labels:
  - docs
milestone: m-0
dependencies: []
ordinal: 14000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The owner wants work product separated from the files used to design, plan and test it, and keeps the repo root to a few markdown docs (NOTES.md). claude-code-knowledge.md and DEFAULT-INSTRUCTIONS.md are research, not product; knowledge/egm.md already lives there.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 claude-code-knowledge.md and DEFAULT-INSTRUCTIONS.md live in knowledge/
- [x] #2 Every link to them in tracked files resolves (README, MODES-DESIGN.md, CUSTOMIZATIONS.md, knowledge/egm.md)
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. git mv both files into knowledge/
2. Rewrite links in tracked files (relative paths shift for files inside knowledge/)
3. Verify no stale references remain
<!-- SECTION:PLAN:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Moved claude-code-knowledge.md and DEFAULT-INSTRUCTIONS.md into knowledge/ with git mv. Updated MODES-DESIGN.md links and replaced the two README rows with one knowledge/ row. git grep finds no old root paths; the moved files contain no relative links to fix.
<!-- SECTION:FINAL_SUMMARY:END -->
