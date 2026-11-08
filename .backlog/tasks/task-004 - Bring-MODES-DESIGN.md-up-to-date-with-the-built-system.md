---
id: TASK-004
title: Bring MODES-DESIGN.md up to date with the built system
status: Done
assignee:
  - '@claude'
created_date: '2026-11-08T20:29:00Z'
updated_date: '2026-11-08T20:32:00Z'
labels:
  - modes
  - docs
dependencies:
  - TASK-003
ordinal: 12000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The 2026-11-08 egm review (_meta/egm-review/consolidated_review_report.md) found the design holds but the doc still reads as an unbuilt draft: open questions the Decisions table already answers, build-order notes, a stale launcher sample, and a Goal that overstates isolation (base plugins like egm load in every mode). Accepted items: C1, C2, C3, C6, C7, C8, C9, C11, C13, C14. Out of scope until the owner decides: C4 (D10 hand-off location) and whether egm should load only in design mode. C10 skipped (unverified output-style claims).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Status says built; "Open questions" removed; "Not decided / risks" replaced by short Open items (version drift, shared memory, effort probe result from TASK-003)
- [x] #2 D12-D15 removed; the rejected `--agent` approach named in one sentence under a plain heading
- [x] #3 Goal states that only the prompt and setting overrides are per-mode; memory, history and base plugins are shared; "toolset" dropped
- [x] #4 Launcher sample replaced by a pointer to bin/cmode; Verified facts cut to the facts the design depends on, linking claude-code-knowledge.md
- [x] #5 D10 and the egm-scope question left as open items, not resolved
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
Rewrite MODES-DESIGN.md per review C1-C3, C6-C9, C11, C13, C14; keep D10 and egm scope as open items (C4 and egm decision are owner calls).
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Applied C1 (status built, Open questions removed, Open items: version drift, shared memory, effort probe), C2 (plain 'Approach' heading, one-sentence rejection of --agent), C3 (D12-D15 deleted), C6 (Goal), C7 (pointer to bin/cmode, mcp.json optional none shipped), C8 (4 facts + link), C9 (escape hatch and 'unlikely' removed, table kept as rejected alternative), C11 (D9 resume clause), C13 (D4 path + ~20 lines, D6 egm wording), C14 (text fence tag, ellipses, chat tone). D7 now names actual values (C5). D10 kept Provisional with the paths the prompts use; D10 and egm scope listed as owner open items. C10 skipped per task.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
MODES-DESIGN.md now describes the built system: status built, accurate Goal (only prompt and setting overrides are per-mode), facts cut to the four the design uses with a link to claude-code-knowledge.md, launcher sample replaced by a pointer to bin/cmode, D12-D15 removed, D7 states the probed effort values. Open items list version drift, shared memory, the effort probe result, and the two owner decisions (D10 location, egm scope). Docs-only change; verified by reading against the AC list.
<!-- SECTION:FINAL_SUMMARY:END -->
