---
id: TASK-011
title: Model the mode workflow as a JSON graph with a consistency check
status: To Do
assignee: []
created_date: '2026-11-09T02:12:00Z'
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
- [ ] #1 A JSON file in the repo lists every mode with its inputs, outputs, plugins on/off, effort and the modes it hands to; the README "What is here" names it
- [ ] #2 A self-check in tests/ fails when an output has no reader, an input has no writer, or a plugin or effort in the JSON disagrees with modes/<mode>/settings.json, and when a path in the JSON is missing from that mode prompt.md
- [ ] #3 The check walks the graph from the entry mode and prints the files produced and consumed at each step (the simulation), and passes on the current three modes
- [ ] #4 Deliberately breaking one edge (for example renaming the plans path in one prompt) makes the check fail
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [ ] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [ ] #3 Live config changes recorded in docs/customizations.md
<!-- DOD:END -->
