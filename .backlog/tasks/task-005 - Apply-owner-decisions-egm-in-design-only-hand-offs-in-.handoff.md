---
id: TASK-005
title: 'Apply owner decisions: egm in design only, hand-offs in .handoff/'
status: Done
assignee:
  - '@worker'
created_date: '2026-11-08T22:34:00Z'
updated_date: '2026-11-08T22:36:00Z'
labels:
  - modes
dependencies: []
ordinal: 13000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Owner decisions on 2026-11-08 after the egm review (MODES-DESIGN.md Open items). (1) egm should load only in design mode, not in every session, so the Goal isolation claim holds; plain `claude` loses /egm commands by choice. (2) D10: design and planning hand-off files go in a gitignored `.handoff/` folder in the project, not `docs/`, because the owner does not want working files in docs/.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 egm is off in ~/.claude/settings.json and on in modes/design/settings.json; a probe shows egm loaded in `cmode design` and absent in `cmode planning`, `cmode building` and plain `claude`
- [x] #2 Design and planning prompts write to `.handoff/designs/<feature>.md` and `.handoff/plans/<feature>.md`, building reads them, and the prompts say to add `.handoff/` to the project .gitignore if missing
- [x] #3 MODES-DESIGN.md D6 and D10 record the decisions; the two Open items are removed; README updated if it mentions the old paths or egm everywhere
- [x] #4 `./install.sh` re-run; installed copies match the repo
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Check egm skills for hard-coded docs/designs/ paths
2. settings: egm off in ~/.claude/settings.json, on in modes/design/settings.json
3. Prompts: .handoff/designs, .handoff/plans, gitignore note; steer egm to .handoff/designs
4. MODES-DESIGN.md D6/D10, drop Open items; README paths
5. ./install.sh, diff installed copies; probe plugin load per mode
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Owner decisions (2026-11-08, relayed by lead): egm loads only in design mode (plain claude loses /egm by choice); hand-off files go in gitignored .handoff/ not docs/.

Live config change for lead to log in CUSTOMIZATIONS.md (worker did not edit it):
- ~/.claude/settings.json enabledPlugins."egm@egm": true -> false (only change; backup of prior file in session scratchpad)
- modes/design/settings.json: added enabledPlugins."egm@egm": true (installed to ~/.claude/modes/design/settings.json)

egm path check (egm 0.1.1 SKILL.md files): egm-draft Step 6.2 probes docs/designs/ and defaults to it, but takes a user-given target dir or a custom-dir answer, so .handoff/designs/ works. egm-brainstorm Option 0 'Publish as RFC' hard-codes docs/designs/<feature>.md and docs/designs/SITEMAP.md; Option 1 'Proceed to egm-draft' keeps concepts_brief.md in the working dir. egm-review/review-loop/resolve take the target file as an argument; resolve writes goldfish_review_report.md to the working dir. So the design prompt now says: run /egm:egm-draft .handoff/designs/ and pick Proceed, not Publish as RFC. Risk: if the user picks RFC or accepts the draft default, the file lands in docs/designs/ and must be moved by hand. Also egm working files (concepts_brief.md, goldfish_review_report.md) land in the project root, not .handoff/.

Probe (init event of -p --output-format stream-json, fresh mktemp dir): cmode design plugins include egm + egm:* skills; cmode planning, cmode building, plain claude: no egm plugin, no egm skills. install.sh re-run (cmode-test passed); cmp shows all 6 installed mode files match repo.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
egm now off in base settings and on only in modes/design/settings.json; probe confirms egm loads in cmode design only. Design/planning/building prompts use .handoff/designs/ and .handoff/plans/ and tell the agent to add .handoff/ to .gitignore. MODES-DESIGN.md Goal, D6, D10 updated, both Open items removed; README paths and egm note updated. install.sh re-run, copies match. Follow-ups for lead: log the two settings changes in CUSTOMIZATIONS.md; egm-brainstorm 'Publish as RFC' still hard-codes docs/designs/ (prompt steers around it); egm scratch files land in project root.
<!-- SECTION:FINAL_SUMMARY:END -->
