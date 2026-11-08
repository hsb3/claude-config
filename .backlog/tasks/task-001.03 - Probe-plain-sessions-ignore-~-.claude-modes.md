---
id: TASK-001.03
title: 'Probe: plain sessions ignore ~/.claude/modes/'
status: Done
assignee:
  - '@claude'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:35:00Z'
labels: []
dependencies: []
parent_task_id: TASK-001
ordinal: 4000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Mode files will live in ~/.claude/modes/<mode>/ (decision D4). A plain claude session must not pick up anything from there (prompt.md, settings.json, agents, rules), or modes would leak into normal sessions. Test with a throwaway ~/.claude/modes/_probe/ folder holding a marker in prompt.md, CLAUDE.md, rules/ and settings.json, then delete it.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A fresh plain `claude -p` session shows none of the markers placed in ~/.claude/modes/_probe/
- [x] #2 ~/.claude/modes/_probe/ is removed after the probe
- [x] #3 Result (pass/fail plus the exact command used) is added to claude-code-knowledge.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Create ~/.claude/modes/_probe/ with unique markers in prompt.md, CLAUDE.md, rules/probe.md, agents/probe-agent.md, settings.json (env var + outputStyle-free).
2. Positive control: put a marker in a project CLAUDE.md inside a mktemp -d folder to prove the detection method sees loaded context.
3. Run fresh claude -p from that temp folder, ask it to list any MODEPROBE strings in its context/agents and echo the settings env var.
4. Delete _probe (and ~/.claude/modes since it did not exist before) and the temp folder.
5. Add a probe section to claude-code-knowledge.md.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Fresh claude -p from a mktemp -d folder: MODEPROBE_ENV unset, MODEPROBE_ markers NONE (prompt.md, CLAUDE.md, rules/, agents/, settings.json); control CLAUDE.md marker CONTROL_PROJECT_9001 was found. ~/.claude/modes/ did not exist before; removed _probe and the empty modes/ folder after (ls: No such file). Temp folder deleted.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
PASS: a plain claude -p session loads nothing from ~/.claude/modes/<mode>/, so decision D4 is safe. Evidence: probe markers absent, positive-control project CLAUDE.md marker present. Probe folder and temp folder removed. Result and exact command added as a new section in claude-code-knowledge.md. Limit: detection relied on model self-report plus printenv for settings env; agents dir checked via the model's agent list only.
<!-- SECTION:FINAL_SUMMARY:END -->
