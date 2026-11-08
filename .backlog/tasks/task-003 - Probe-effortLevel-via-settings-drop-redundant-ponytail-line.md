---
id: TASK-003
title: Probe effortLevel via --settings; drop redundant ponytail line
status: Done
assignee:
  - '@claude'
created_date: '2026-11-08T20:29:00Z'
updated_date: '2026-11-08T20:33:00Z'
labels:
  - modes
dependencies: []
ordinal: 11000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The 2026-11-08 egm review (_meta/egm-review/consolidated_review_report.md, items C5 and C12) found that D7 sets per-mode effort with `effortLevel` in modes/*/settings.json, but nobody has tested whether `--settings` actually applies it. If not, design and planning silently run at default effort. Separately, modes/building/settings.json enables ponytail, which ~/.claude/settings.json already enables, so the line does nothing.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A probe shows whether `effortLevel` passed through `--settings` changes the effective effort, and the result (with method and Claude Code version) is recorded in claude-code-knowledge.md
- [x] #2 If the probe fails, the mode settings use a mechanism that does work, or the task notes say none exists
- [x] #3 modes/building/settings.json no longer contains the redundant `ponytail@ponytail: true` entry
- [x] #4 `./install.sh` re-run and `cmode building` still launches
- [x] #5 CUSTOMIZATIONS.md row added for the live config change
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Probe: local capture server via ANTHROPIC_BASE_URL, compare output_config.effort with/without --settings effortLevel
2. Record in claude-code-knowledge.md
3. Empty modes/building/settings.json, re-run ./install.sh, launch cmode building
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Probe PASS on 2.1.319: --settings effortLevel low/high -> request output_config.effort low/high; no override -> medium. design/planning modes send high, building sends medium. No change to the mechanism needed (AC #2 n/a).
Live config change for the lead to log in CUSTOMIZATIONS.md (worker was told not to edit it): 2026-11-08 | ~/.claude/modes/building/settings.json | enabledPlugins.ponytail@ponytail: true removed, file is now {} | redundant: ~/.claude/settings.json already enables ponytail (egm review C12).
Verified: ./install.sh reported 'changed ~/.claude/modes/building/settings.json'; cmode building -p replied OK with PONYTAIL MODE ACTIVE still in hook output.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Probe shows effortLevel in a --settings file sets the request's output_config.effort (low/high honored; default medium), so D7 works as built. Recorded with method and version in claude-code-knowledge.md. Removed the redundant ponytail entry from modes/building/settings.json (now {}), re-ran install.sh, cmode building launches with ponytail still active. Open: AC #5 — lead adds the CUSTOMIZATIONS.md row (exact text in notes), then moves this to Done.
<!-- SECTION:FINAL_SUMMARY:END -->
