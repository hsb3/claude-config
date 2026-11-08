---
id: TASK-001.02
title: 'Probe: --settings can turn a plugin off for one session'
status: Done
assignee:
  - '@claude'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:35:00Z'
labels: []
dependencies: []
parent_task_id: TASK-001
ordinal: 3000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Design mode must run without the ponytail plugin (its least-code mindset fights exploration, decision D6 in MODES-DESIGN.md). The plan is a per-mode settings file passed with --settings containing enabledPlugins ponytail@ponytail false. Unverified: whether that also stops the plugin SessionStart hook that injects PONYTAIL MODE ACTIVE. Probes must use throwaway files in a scratch dir and must not change ~/.claude/settings.json.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A fresh `claude -p --settings <file>` session with ponytail disabled shows no PONYTAIL MODE ACTIVE context and no ponytail skills
- [x] #2 i-have-adhd is still active in that session
- [x] #3 A plain `claude -p` session afterwards still has ponytail active
- [x] #4 Result (pass/fail plus the exact command used) is added to claude-code-knowledge.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write throwaway settings file in mktemp -d with enabledPlugins ponytail@ponytail false
2. Run claude -p --settings <file> asking it to report whether PONYTAIL/ADHD context and ponytail skills are present; also check hooks via stream-json init event
3. Run plain claude -p as control
4. Add one section to claude-code-knowledge.md with result + command
5. Delete scratch dir
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Probe via stream-json init/hook events. Off run: plugins list lacks ponytail, 0 ponytail skills, 0 'PONYTAIL MODE ACTIVE' matches, 2 SessionStart hooks; model answered NO/YES (ponytail/adhd). Plain run: ponytail plugin + 6 skills + hook output present, model YES/YES. settings.json unchanged (ponytail@ponytail still true). Scratch dir deleted.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Verified that `claude -p --settings <file>` with {"enabledPlugins":{"ponytail@ponytail":false}} disables ponytail for one session, including its SessionStart hook and skills, while i-have-adhd stays active; a later plain session still has ponytail. Result and command added as a new section in claude-code-knowledge.md. Unblocks the per-mode settings approach for design mode (TASK-001.04).
<!-- SECTION:FINAL_SUMMARY:END -->
