---
id: decision-002
title: 'Mode workflow model: a checked mirror of the prompts, not a generator'
date: '2026-11-09T03:16:00Z'
status: accepted
---
## Context
The hand-off contract between modes (which files each mode reads and writes, which plugins and effort it runs with) lived only as prose in three prompt.md files. TASK-011 asked for a machine-readable model so gaps can be found. Two shapes were possible: the JSON generates the hand-off sections of the prompts, or the JSON mirrors the prompts and a test checks they agree.

## Decision
Mirror. `modes/workflow.json` describes each mode (reads, writes, plugins, effort, next) and `tests/workflow-test` fails when it disagrees with `modes/<mode>/prompt.md` or `settings.json`, when a hand-off file has no writer or no reader, or when a mode hands to an unknown mode. The prompts stay the single thing Claude reads.

## Consequences
- Editing a hand-off path means editing the prompt and the JSON; the test catches a miss.
- No build step, no templating. Revisit if a fourth mode or a cycle makes the prompts hard to keep aligned by hand (then a generator, per decision-001 in TypeScript on bun).
