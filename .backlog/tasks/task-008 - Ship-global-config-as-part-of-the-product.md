---
id: TASK-008
title: Ship global config as part of the product
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T00:16:00Z'
updated_date: '2026-11-09T00:20:00Z'
labels:
  - install
milestone: m-0
dependencies: []
ordinal: 16000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
NOTES.md defines the product as a fresh-install setup: global ~/.claude/settings.json, ~/.claude/CLAUDE.md and AGENTS.md, enabled marketplaces/plugins, plus modes and the launcher. install.sh only installed modes and cmode; the global files existed only on this machine. Owner (2026-11-08): keep it simple, overwrite or manual update, no merging for now.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [x] #1 Repo holds global/settings.json, global/CLAUDE.md and global/AGENTS.md matching the live files, minus machine-specific entries (herdr hook)
- [x] #2 install.sh installs CLAUDE.md and AGENTS.md (overwrite, previous file backed up) and installs settings.json only when none exists, otherwise prints the diff for a manual update
- [x] #3 A test run against a temp CLAUDE_CONFIG_DIR covers fresh install, re-run unchanged, and an existing different settings.json
- [x] #4 README documents what install changes and how to update settings by hand
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. global/: settings.json (live minus herdr hooks, which herdr installs itself), CLAUDE.md, AGENTS.md, .i-have-adhd-always
2. install.sh: CLAUDE.md, AGENTS.md, flag file overwrite with .bak of a differing old file; settings.json copied only if absent, else diff -u printed for a manual merge
3. bin/install-test: temp HOME + CLAUDE_CONFIG_DIR, stub claude; fresh, re-run, differing settings
4. README section
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
global/settings.json = live settings minus hooks (herdr installs its own via herdr integration install claude). Also ships .i-have-adhd-always. Real ./install.sh run: all files unchanged, settings diff shows only the herdr hook. bin/install-test: 8/8 ok. Repo AGENTS.md convention now says edit global/, not ~/.claude/. Not in global/: ~/.claude/skills/handoff (from another repo) and ponytail-statusline.sh (unused by settings).
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
The product now ships the global config: global/ holds settings.json, CLAUDE.md, AGENTS.md and the i-have-adhd always-on flag. install.sh overwrites the instruction files (differing old file kept as .bak) and copies settings.json only when absent; otherwise it prints a diff for a manual merge, per the owner's keep-it-simple call. bin/install-test covers fresh install, unchanged re-run, and differing settings (8/8 pass). README documents what install changes. Follow-up candidate: settings merge step if hand-merging gets tedious (shortcut comment in install.sh).
<!-- SECTION:FINAL_SUMMARY:END -->
