---
id: TASK-001.04
title: Build design mode end to end
status: Done
assignee:
  - '@claude-worker'
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:42:00Z'
labels: []
dependencies:
  - TASK-001.01
  - TASK-001.02
  - TASK-001.03
documentation:
  - MODES-DESIGN.md
parent_task_id: TASK-001
ordinal: 5000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
First mode built end to end, so the pattern is proven before copying it (decision D12). Design sessions are for exploring and shaping a product: ponytail off (D6), egm plugin used for design docs, higher effort (D7). Hand-off is a doc in the project docs/ folder that planning mode reads (D10, provisional: the user dislikes working files in docs/). The mode content (mindset, workflow) is the user call: draft it from MODES-DESIGN.md, then get approval before Done.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 modes/design/ in this repo holds prompt.md (under one screen) and settings.json
- [x] #2 A session started with --append-system-prompt-file and --settings pointing at modes/design/ shows the design prompt with the expected plugins on and off
- [x] #3 The user has reviewed and approved prompt.md
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write modes/design/settings.json: ponytail@ponytail false, effortLevel high (schema allows low|medium|high|xhigh).
2. Write modes/design/prompt.md: mindset, workflow, hand-off to docs/designs/ (egm default path, inside docs/ per D10), egm skills are user-invoked slash commands (disable-model-invocation: true).
3. Test with claude -p stream-json: prompt marker present, ponytail hook absent, i-have-adhd present, egm skills in init, effort applied.
4. Comment test evidence; leave In Progress for user approval.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Decision 2026-11-08: Build and test in this repo under modes/<mode>/ only; do not write to ~/.claude/ (installation is TASK-001.08). Do not edit CUSTOMIZATIONS.md: the coordinator owns it.

Coordinator verified: modes/design/prompt.md is 22 lines; egm skills confirmed disable-model-invocation: true in plugin cache 0.1.1. User approved prompt.md 2026-11-08 ("commit ok. i want you to just run with this").
<!-- SECTION:NOTES:END -->

## Comments

<!-- COMMENTS:BEGIN -->
author: @claude-worker
created: 2026-11-08T19:40:00Z

---

Test evidence (claude 2.1.319, fresh claude -p from mktemp -d, --append-system-prompt-file modes/design/prompt.md --settings modes/design/settings.json --output-format stream-json --verbose --tools=""):
- Design prompt present: model quoted the mindset line and the Hand-off first sentence verbatim.
- Ponytail absent: 2 SessionStart hooks ran, neither printed PONYTAIL MODE ACTIVE; init has 0 ponytail skills/commands; plugins = i-have-adhd, egm (+ built-ins).
- i-have-adhd present: hook printed ADHD MODE ACTIVE.
- egm available: init lists all 7 egm:* skills and slash commands. Note: egm skills are disable-model-invocation: true, so prompt.md tells the model to suggest the /egm:* commands for the user to run.
- effortLevel high: key and value valid per settings schema (low|medium|high|xhigh); init event does not report effort, so the applied level is not proven by this test.
- Hand-off path: docs/designs/<feature>.md (egm-draft default, inside docs/ per D10).
Awaiting user approval of prompt.md (AC #3).

---
<!-- COMMENTS:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Built design mode in modes/design/: prompt.md (22 lines: explore-not-build mindset, Frame/Explore/Decide/Write/Review workflow, suggests /egm:* commands, hand-off to docs/designs/<feature>.md) and settings.json (ponytail off, effortLevel high). Verified in a fresh claude -p session: design prompt present, ponytail hook and skills absent, i-have-adhd active, 7 egm skills available. Risk: the effort level is not reported in the init event, so it is set but not proven applied. Hand-off location in docs/ is provisional (D10).
<!-- SECTION:FINAL_SUMMARY:END -->
