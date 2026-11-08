---
id: TASK-002
title: Install script and public claude-config repo
status: In Progress
assignee:
  - '@coordinator'
created_date: '2026-11-08T19:57:00Z'
labels: []
dependencies: []
ordinal: 10000
---

## Description

<!-- SECTION:DESCRIPTION:BEGIN -->
The user wants to set up cmode and the working modes on other machines by running one command from a clone of this repo. Today it is two manual copies and there is no remote. The user approved a public GitHub repo named claude-config. Scope chosen: cmode plus modes, and a warning (not an install) for the plugins the modes rely on (ponytail, i-have-adhd, egm).
<!-- SECTION:DESCRIPTION:END -->

## Acceptance Criteria
<!-- AC:BEGIN -->
- [ ] #1 `./install.sh` from a fresh clone installs modes into ${CLAUDE_CONFIG_DIR:-~/.claude}/modes and cmode into ~/.local/bin
- [ ] #2 It runs bin/cmode-test first and installs nothing if a check fails
- [ ] #3 It is safe to re-run and reports which files were added or changed
- [ ] #4 It warns, without failing, when claude is missing a plugin the modes use or when ~/.local/bin is not on PATH
- [ ] #5 The repo is public at github.com/hsb3/claude-config with a README that shows the install command
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write install.sh (POSIX sh). 2. Test against a throwaway HOME/CLAUDE_CONFIG_DIR (fresh-machine path) and against this machine (re-run path). 3. Short README. 4. gh repo create hsb3/claude-config --public, push.
<!-- SECTION:PLAN:END -->
