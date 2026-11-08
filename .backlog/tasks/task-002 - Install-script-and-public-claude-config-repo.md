---
id: TASK-002
title: Install script and public claude-config repo
status: Done
assignee:
  - '@coordinator'
created_date: '2026-11-08T19:57:00Z'
updated_date: '2026-11-08T19:59:00Z'
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
- [x] #1 `./install.sh` from a fresh clone installs modes into ${CLAUDE_CONFIG_DIR:-~/.claude}/modes and cmode into ~/.local/bin
- [x] #2 It runs bin/cmode-test first and installs nothing if a check fails
- [x] #3 It is safe to re-run and reports which files were added or changed
- [x] #4 It warns, without failing, when claude is missing a plugin the modes use or when ~/.local/bin is not on PATH
- [x] #5 The repo is public at github.com/hsb3/claude-config with a README that shows the install command
<!-- AC:END -->

## Implementation Plan

<!-- SECTION:PLAN:BEGIN -->
1. Write install.sh (POSIX sh). 2. Test against a throwaway HOME/CLAUDE_CONFIG_DIR (fresh-machine path) and against this machine (re-run path). 3. Short README. 4. gh repo create hsb3/claude-config --public, push.
<!-- SECTION:PLAN:END -->

## Implementation Notes

<!-- SECTION:NOTES:BEGIN -->
Tested: (1) fresh throwaway HOME: 7 added, PATH + 3 plugin warnings, exit 0; (2) re-run: 7 unchanged; (3) broken bin/cmode: self-check fails, nothing installed, exit 1; (4) this machine: 7 unchanged; (5) fresh git clone from github.com/hsb3/claude-config into throwaway HOME: 7 added, installed cmode runs. Commit email already public on ~14k GitHub commits, so history kept as is.
<!-- SECTION:NOTES:END -->

## Final Summary

<!-- SECTION:FINAL_SUMMARY:BEGIN -->
Added install.sh (POSIX sh) and README. From a clone, ./install.sh runs bin/cmode-test, then copies modes/* to ${CLAUDE_CONFIG_DIR:-~/.claude}/modes and bin/cmode to ~/.local/bin, reporting added/changed/unchanged per file; warns (no failure) on missing ponytail/i-have-adhd/egm plugins or ~/.local/bin off PATH. Published as public repo github.com/hsb3/claude-config. Limit: the installer never deletes, so a mode removed from the repo stays installed until removed by hand.
<!-- SECTION:FINAL_SUMMARY:END -->
