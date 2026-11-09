---
id: TASK-007
title: Install backlog-extras as a project plugin and finish Backlog.md setup
status: Done
assignee:
  - '@claude'
created_date: '2026-11-09T00:16:00Z'
updated_date: '2026-11-09T00:18:00Z'
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
- [x] #1 Project .claude/settings.json declares the hsb3/backlog.md-extras marketplace and enables backlog-extras, so a fresh clone gets it
- [x] #2 A session in this repo loads the plugin: backlog resolves to the wrapper and a direct write to .backlog/ is denied
- [x] #3 Backlog config has a Definition of Done and the labels in use; a v1 milestone exists
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. claude plugin marketplace add hsb3/backlog.md-extras --scope project; install backlog-extras --scope project
2. Verify in a headless session: plugin loaded, wrapper on PATH, guard denies a .backlog write
3. Backlog config: definition_of_done defaults, labels in use; milestone m-0 already added
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
config.yml labels and definition_of_done edited directly: backlog config set does not accept those keys and the wrapper adds none. Verified with backlog config list and backlog doctor.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Installed backlog-extras 0.7.0 at project scope; .claude/settings.json declares the marketplace and enables the plugin, so a fresh clone is prompted to install it. Headless check: backlog resolves to the plugin wrapper, a Write to .backlog/ is denied by the guard. Backlog config now has labels (modes, docs, install, config) and a 3-item Definition of Done; milestone m-0 'v1 fresh-install product' holds TASK-006..008.
<!-- SECTION:FINAL_SUMMARY:END -->
