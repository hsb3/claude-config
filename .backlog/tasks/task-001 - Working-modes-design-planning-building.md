---
id: TASK-001
title: 'Working modes: design, planning, building'
status: Done
assignee: []
created_date: '2026-11-08T19:32:00Z'
updated_date: '2026-11-08T19:50:00Z'
labels: []
dependencies: []
documentation:
  - MODES-DESIGN.md
  - claude-code-knowledge.md
ordinal: 1000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
I want each Claude Code session to start in a working mode with its own mindset, workflow and toolset, so mode-specific rules are not always loaded. The design is agreed in MODES-DESIGN.md (decisions D1-D12): layered, i.e. a shared base plus a per-mode delta in ~/.claude/modes/<mode>/ loaded via --append-system-prompt-file, --settings and optional --mcp-config. --agent was rejected because it drops the default system prompt and memory (see claude-code-knowledge.md).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Design, planning and building modes each start from one command
- [x] #2 A plain `claude` session is unchanged: no mode files load
- [x] #3 Every change under ~/.claude is logged in CUSTOMIZATIONS.md
<!-- AC:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Working modes shipped: design, planning and building, each started with `cmode <mode>`. Built and tested in this repo (modes/, bin/), installed by copy into ~/.claude/modes/ and ~/.local/bin/cmode, plain claude sessions unchanged (tested). All subtasks .01-.08 Done; changes logged in CUSTOMIZATIONS.md; findings in claude-code-knowledge.md.
<!-- SECTION:FINAL_SUMMARY:END -->
