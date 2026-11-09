---
id: TASK-011
title: Model the mode workflow as a JSON graph with a consistency check
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T02:12:00Z'
updated_date: '2026-11-09T02:29:00Z'
labels:
  - modes
  - docs
milestone: m-0
dependencies: []
ordinal: 19000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The hand-off contract between modes (design writes .handoff/designs/<feature>.md, planning reads it and writes .handoff/plans/<feature>.md, building reads both) exists only as prose in three prompt.md files that agree by hand. As modes and plugins are added, gaps (an output nobody reads, an input nobody writes, a plugin or effort the prompt assumes but settings.json does not set) will not be visible. Owner ask 2026-11-09: model the graph (nodes, edges, cycles) in JSON so it can be walked and inconsistencies found. Context: docs/pre-mortem.md items 3 and 8 (build the check, not a framework; a simulator only once the graph has a cycle). Decision-001 (POSIX sh) applies; jq is available on this machine but is not part of the product. Open question for the worker to settle first: the JSON as a checked mirror of the prompts (prompts stay the source Claude reads) versus the JSON generating the hand-off sections of the prompts.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 A JSON file in the repo lists every mode with its inputs, outputs, plugins on/off, effort and the modes it hands to; the README "What is here" names it
- [x] #2 A self-check in tests/ fails when an output has no reader, an input has no writer, or a plugin or effort in the JSON disagrees with modes/<mode>/settings.json, and when a path in the JSON is missing from that mode prompt.md
- [x] #3 The check walks the graph from the entry mode and prints the files produced and consumed at each step (the simulation), and passes on the current three modes
- [x] #4 Deliberately breaking one edge (for example renaming the plans path in one prompt) makes the check fail
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [x] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [x] #3 Live config changes recorded in docs/customizations.md
<!-- DOD:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
Decision (lead, 2026-11-09): MIRROR. The prompts stay what Claude reads; docs/workflow.json mirrors them and tests/workflow-test checks the two agree. No generator.

1. docs/workflow.json, shape:
   {"entry":"design","modes":{"design":{"reads":[],"writes":[".handoff/designs/<feature>.md"],"next":["planning"],"enabledPlugins":{"ponytail@ponytail":false,"egm@egm":true},"effortLevel":"high"},"planning":{...},"building":{...}}}
   Keys enabledPlugins and effortLevel use the exact names and values of modes/<mode>/settings.json (omit them when that file omits them). Paths are the literal strings the prompt.md uses.
2. tests/workflow-test [repo-root] (POSIX sh + jq; fail with a clear message if jq is missing). Same ok/FAIL style and exit code as tests/cmode-test. Checks, each one line of output:
   a. set of modes in the JSON == set of directories in modes/
   b. every writes path is in another mode's reads (no output without a reader); every reads path is in some mode's writes (no input without a writer)
   c. every reads/writes path occurs literally (grep -F) in that mode's prompt.md
   d. per mode, jq -S {enabledPlugins, effortLevel} of the JSON entry equals the same projection of modes/<mode>/settings.json (missing keys compare as null)
   e. every next and entry names a known mode
   f. simulation: walk from entry following next, print one line per step "mode: reads [...] writes [...]"; a repeated mode is reported as a cycle (info, not failure)
3. Self-check of the check (AC 4): the test copies the repo to a temp dir, changes the plans path in modes/planning/prompt.md, runs itself on the copy and expects a non-zero exit.
4. README "What is here": add a docs/workflow.json row and workflow-test to the tests row; AGENTS.md Tooling: add tests/workflow-test to the self-checks line. install.sh does not run it (the JSON is not product).
5. Run all three tests; nothing to install.
Worker: a cmode building session in a herdr worktree (branch task-011-workflow-graph). The worker does not commit and does not edit Backlog; the lead reviews, commits, merges and finalizes.

Outcome: the worker never saw this plan (Backlog edits on main are uncommitted files, invisible in a worktree branched from the main ref) and built from the acceptance criteria. Accepted deviations: the JSON lives at modes/workflow.json beside what it mirrors (install.sh copies only modes/*/*, so it is not shipped) and uses keys plugins/effort, mapped to enabledPlugins/effortLevel by the test. A cycle ends the walk instead of being printed; not needed with three modes.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Built by a cmode building worker in a herdr worktree (branch task-011-workflow-graph, 2m44s, $1.65), reviewed and merged by the lead (fast-forward, 5b77b74). Evidence: tests/workflow-test on main prints the walk design -> planning -> building and 5 ok lines (consistent + 4 negative cases: renamed plans path, changed effort, output with no reader, unknown next mode), exit 0. tests/cmode-test and tests/install-test 8/8 each in the worktree. Nothing to install: the JSON and test are not product. docs/customizations.md unchanged (no live config change).
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
modes/workflow.json models the three modes (reads, writes, plugins, effort, next) as a checked mirror of the prompts and settings, chosen over a generator to keep the prompts as the single thing Claude reads. tests/workflow-test (POSIX sh + jq) verifies folder/entry agreement, plugins and effort against settings.json, every hand-off path present in its prompt and both written and read, known next modes, and walks the graph from the entry; four deliberately broken copies prove it fails. README, AGENTS.md and pre-mortem item 3 point to it. Risk: jq is a dev dependency for this test only. Follow-up: none required.
<!-- SECTION:FINAL_SUMMARY:END -->
