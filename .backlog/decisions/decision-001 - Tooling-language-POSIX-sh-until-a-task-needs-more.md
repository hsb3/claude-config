---
id: decision-001
title: 'Tooling language: POSIX sh until a task needs more'
date: '2026-11-09T00:20:00Z'
status: proposed
---
## Context
NOTES.md asks: if we need more than shell, which language: ts, py, rs or go? Today the product is install.sh, bin/cmode and two sh self-checks, all small.

## Decision
Stay with POSIX sh (plus jq where JSON is read). Do not add a language until a task needs one. The likely trigger is merging settings.json in install.sh instead of printing a diff (TASK-008 shortcut).

When that happens, prefer TypeScript run with bun: bun is already installed for Backlog.md, it has JSON built in, and needs no build step. Python is the fallback (preinstalled on macOS, the backlog-extras hooks already require python3). Rust and Go add a compile step and a release binary for no gain at this size.

## Consequences
- Contributors need only sh, jq and Claude Code.
- Revisit when a script passes about 150 lines or needs structured parsing beyond jq.
