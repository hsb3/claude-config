---
id: TASK-008
title: Ship global config as part of the product
status: To Do
assignee: []
created_date: '2026-11-09T00:16:00Z'
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
- [ ] #1 Repo holds global/settings.json, global/CLAUDE.md and global/AGENTS.md matching the live files, minus machine-specific entries (herdr hook)
- [ ] #2 install.sh installs CLAUDE.md and AGENTS.md (overwrite, previous file backed up) and installs settings.json only when none exists, otherwise prints the diff for a manual update
- [ ] #3 A test run against a temp CLAUDE_CONFIG_DIR covers fresh install, re-run unchanged, and an existing different settings.json
- [ ] #4 README documents what install changes and how to update settings by hand
<!-- AC:END -->
