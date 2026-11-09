---
id: DRAFT-001
title: >-
  Per-mode subagents from the claude-code-templates catalog (UX/PRD for design,
  architect for planning)
status: Draft
assignee: []
created_date: '2026-11-09T03:16:00Z'
labels:
  - modes
dependencies: []
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Candidate since 2026-11-08, no go-ahead yet. Each mode could ship subagents in its folder or in .claude/agents/ with mode-specific prompts; needs the sub-agents digest in docs/knowledge/claude-code.md and decision-003 (adds agent-memory/ only then). Catalog: npx claude-code-templates@latest (github.com/davila7).
<!-- SECTION:DESCRIPTION:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [ ] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [ ] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [ ] #3 Live config changes recorded in docs/customizations.md
<!-- DOD:END -->
