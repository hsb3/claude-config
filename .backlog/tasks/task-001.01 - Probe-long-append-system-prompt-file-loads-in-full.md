---
id: TASK-001.01
title: 'Probe: long --append-system-prompt-file loads in full'
status: Done
assignee:
  - '@claude-worker'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:35:00Z'
labels: []
dependencies: []
parent_task_id: TASK-001
ordinal: 2000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Each mode puts its mindset and workflow in a prompt.md appended with --append-system-prompt-file. Before building on that, we must know a full-page file arrives intact (not truncated) and sits alongside the default system prompt rather than replacing it. Claude Code 2.1.319. Probes must use throwaway files in a scratch dir and must not change ~/.claude/settings.json or any file under ~/.claude.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A ~1-screen prompt file with distinct markers at its start, middle and end is fully visible to a fresh `claude -p` session
- [x] #2 The same session still shows the default Claude Code system prompt (e.g. risky-action guidance)
- [x] #3 Result (pass/fail plus the exact command used) is added to claude-code-knowledge.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. mktemp -d scratch dir; write ~60-line prompt.md with unique markers at start/middle/end
2. Run fresh claude -p --append-system-prompt-file <file>, ask it to quote the three markers verbatim and a phrase from default system prompt (risky-action guidance)
3. Control run without the flag to confirm markers are not guessable
4. Record result + exact command in claude-code-knowledge.md (own section only); delete scratch dir
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Probe: 60-line 7.6KB prompt.md, random markers START-60aabd43/MIDDLE-cc714aff/END-d10f981f. claude -p --tools "" --append-system-prompt-file: all 3 markers quoted, 56/56 filler lines counted, default risky-action sentence quoted verbatim. Control without flag: NONE. Scratch dir deleted.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
PASS. --append-system-prompt-file delivers a full-page (60 lines, 7.6 KB) prompt intact (start/middle/end markers all visible, all filler lines counted) and appends to rather than replaces the default system prompt (risky-action rule quoted verbatim). Control run without the flag saw no markers. Exact command and result added as a new section in claude-code-knowledge.md. Not tested: files far larger than one page.
<!-- SECTION:FINAL_SUMMARY:END -->
