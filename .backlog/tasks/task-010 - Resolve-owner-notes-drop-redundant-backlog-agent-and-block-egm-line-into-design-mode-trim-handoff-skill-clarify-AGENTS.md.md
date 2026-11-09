---
id: TASK-010
title: >-
  Resolve owner notes: drop redundant backlog agent and block, egm line into
  design mode, trim handoff skill, clarify AGENTS.md
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T01:55:00Z'
updated_date: '2026-11-09T01:55:00Z'
labels:
  - docs
  - config
milestone: m-0
dependencies: []
ordinal: 18000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
Owner NOTES.md (2026-11-08) asked: whether .claude/agents/project-manager-backlog.md and the Backlog block in AGENTS.md are still needed now that the backlog-extras plugin is installed; whether the egm artifact-directory line belongs in the global AGENTS.md when egm runs only in design mode; and whether the repo makes clear what is being built, the conventions and which tooling to use when. The owner also asked that the copied handoff skill be trimmed to Anthropic skill best practices.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 No .claude/agents/project-manager-backlog.md and no Backlog instruction block in AGENTS.md; the backlog-extras skill and session hook supply that guidance (its README names the skill as the one source of agent instructions)
- [x] #2 The egm artifact-directory line lives in modes/design/prompt.md, not global/AGENTS.md, and a cmode design -p probe answers .handoff/egm
- [x] #3 global/skills/handoff/SKILL.md has no atelier-hook or override content, a third-person description, and keeps the update pass, init skeleton and rules
- [x] #4 AGENTS.md opens with what the product is and a tooling-and-when list; docs that named the old egm location are updated
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [x] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [x] #3 Live config changes recorded in docs/customizations.md
<!-- DOD:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Inspect backlog-extras plugin (skill, hooks, README) and egm docs on the artifact-directory marker. 2. git rm the agent file; rewrite AGENTS.md (what this is, tooling and when, conventions) without the Backlog block. 3. Move the egm line to the design prompt; update egm.md, customizations.md, HANDOFF. 4. Rewrite SKILL.md. 5. Run tests, install, probe design mode.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Evidence: backlog-extras README states the backlog-md skill is the one source of agent instructions and that init reverts both the agent file and the AGENTS.md block; the agent file was upstream 1.55.3 boilerplate that also named backlog/tasks/ (wrong for .backlog). egm docs/claude.md honors the marker in the prompt or instructions file; probe `cmode design -p "Where does egm write its scratch artifacts..." --tools=""` answered `.handoff/egm` after ./install.sh. tests/cmode-test 8/8, tests/install-test 8/8. Install changed modes/design/prompt.md, AGENTS.md (old kept as .bak), skills/handoff/SKILL.md. bl doctor reports no issues.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Removed .claude/agents/project-manager-backlog.md and the Backlog block from AGENTS.md: the backlog-extras plugin (skill + SessionStart briefing) covers them. Moved `EGM artifact directory: .handoff/egm` from global/AGENTS.md into modes/design/prompt.md since egm loads only there; probe confirms design mode sees it. Trimmed the handoff SKILL.md from 127 to 50 lines: dropped atelier hook contract, atelier.local.md override and the ADR reference; description now third person. AGENTS.md restructured: What this is / Tooling, and when / Conventions. Risk: a headless egm review was not re-run after the move; the probe shows the line is in context, which is what egm reads.
<!-- SECTION:FINAL_SUMMARY:END -->
