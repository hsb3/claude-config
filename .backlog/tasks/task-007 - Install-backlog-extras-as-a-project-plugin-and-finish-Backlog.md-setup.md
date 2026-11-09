---
id: TASK-007
title: Install backlog-extras as a project plugin and finish Backlog.md setup
status: To Do
assignee: []
created_date: '2026-11-09T00:16:00Z'
labels:
  - config
milestone: m-0
dependencies: []
ordinal: 15000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
NOTES.md asks to install hsb3/backlog.md-extras as a project marketplace/plugin and to finish the Backlog.md setup. The plugin adds a backlog wrapper, a guard hook against direct .backlog/ writes, and a session check of the Backlog.md version; its hooks are local-only with no MCP (reviewed 2026-11-08). The board had no Definition of Done, labels or milestones.
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 Project .claude/settings.json declares the hsb3/backlog.md-extras marketplace and enables backlog-extras, so a fresh clone gets it
- [ ] #2 A session in this repo loads the plugin: backlog resolves to the wrapper and a direct write to .backlog/ is denied
- [ ] #3 Backlog config has a Definition of Done and the labels in use; a v1 milestone exists
<!-- AC:END -->
