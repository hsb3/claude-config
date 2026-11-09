---
id: TASK-009
title: 'Refactor repo layout: product vs docs, tests/, naming rules'
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T01:41:00Z'
updated_date: '2026-11-09T01:44:00Z'
labels:
  - docs
  - install
milestone: m-0
dependencies: []
ordinal: 17000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The repo grew one commit at a time: product files (install.sh, bin/, modes/, global/) sit beside the docs and research that built them (MODES-DESIGN.md, CUSTOMIZATIONS.md, knowledge/), tests live in bin/, four docs each describe the layout, CUSTOMIZATIONS.md is a same-day changelog with rows for states that no longer exist, and the live ~/.claude/skills/handoff/ is not shipped so a fresh install cannot reproduce the setup. Owner NOTES.md asks to separate work product from the files that design, plan and test it. Owner go-ahead 2026-11-08: make all changes, rename files freely, add naming and placement rules.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Root holds only install.sh, README.md, AGENTS.md plus the bin/, global/, modes/, tests/, docs/ folders (and dotfiles)
- [x] #2 All repo-authored files are lowercase kebab-case except README.md, AGENTS.md, CLAUDE.md and names a tool dictates; AGENTS.md states the naming and placement rules
- [x] #3 install.sh runs tests/cmode-test before installing and installs every file under global/ including skills/handoff/; tests/cmode-test and tests/install-test pass
- [x] #4 docs/customizations.md is a current-state table (setting, value, why) with shipped items separated from local-only ones
- [x] #5 README "What is here" is the only layout description; AGENTS.md, docs/modes-design.md, .backlog/config.yml DoD and _meta/HANDOFF.md point to the new paths with no stale ones left (grep)
<!-- AC:END -->

## Definition of Done
<!-- DOD:BEGIN -->
- [x] #1 Acceptance criteria verified with evidence: a test, probe or command output
- [x] #2 ./install.sh re-run when modes/, bin/ or global/ changed
- [x] #3 Live config changes logged in CUSTOMIZATIONS.md
<!-- DOD:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. git mv: MODES-DESIGN.md->docs/modes-design.md, CUSTOMIZATIONS.md->docs/customizations.md, knowledge/*->docs/knowledge/{claude-code.md,claude-code-default-instructions.md,egm.md}, bin/{cmode,install}-test->tests/
2. Copy ~/.claude/skills/handoff/{SKILL.md,README.md} into global/skills/handoff/; install.sh iterates every file under global/ (except settings.json) and runs both tests; update tests
3. Rewrite docs/customizations.md as a state table; fix every path reference (README, AGENTS.md, modes-design, knowledge, config.yml DoD, HANDOFF); add naming/placement rules to AGENTS.md
4. Run tests/*, ./install.sh, grep for stale paths; commit

Note: install.sh cannot run tests/install-test (it calls install.sh, so it would recurse); AC 3 reworded.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Evidence: tests/cmode-test 8/8 ok, tests/install-test 8/8 ok (the globals check now includes skills/handoff/SKILL.md). ./install.sh re-run live: cmode changed (comment), handoff skill files unchanged (identical to the live copies), settings.json differs as before. ls root = AGENTS.md README.md install.sh bin docs global modes tests (+ gitignored _meta, NOTES.md). git ls-files has no uppercase names outside the allowed set. grep for MODES-DESIGN, CUSTOMIZATIONS.md, knowledge/, bin/*-test, DEFAULT-INSTRUCTIONS finds nothing outside .backlog task history; the two knowledge/ links in docs/modes-design.md are relative to docs/ and resolve.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Split product from docs: MODES-DESIGN.md -> docs/modes-design.md, CUSTOMIZATIONS.md -> docs/customizations.md (rewritten as a current-state table: shipped / this repo / local only), knowledge/ -> docs/knowledge/{claude-code,claude-code-default-instructions,egm}.md, bin/*-test -> tests/. Shipped the live /handoff skill as global/skills/handoff/; install.sh now installs every file under global/ (except settings.json) via find, so new global files need no installer edit. AGENTS.md gained naming (lowercase kebab-case, listed exceptions) and placement rules; README "What is here" is the single layout description. Backlog DoD and HANDOFF updated to the new paths. Verified: both self-checks pass, live install re-run. Risk: none for users; the installer still never deletes. Follow-up for the owner: live ~/.claude/settings.json has model fable and skipDangerousModePermissionPrompt true, which global/settings.json (model opus) does not ship.
<!-- SECTION:FINAL_SUMMARY:END -->
