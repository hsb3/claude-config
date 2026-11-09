---
name: stage-only-own-changes
description: The owner edits files in the working tree while a session works; stage only the files the session changed, never `git add -A`, and give owner edits their own commit
metadata:
  type: feedback
---

Rule (2026-11-09): stage by path. `git add -A` swept two in-progress owner edits to `global/settings.json` and `global/AGENTS.md` into unrelated commits with misleading messages.

**Why:** the owner and the lead session share one checkout. Owner edits may be unfinished, and their intent belongs in their own commit message so `docs/customizations.md` and the handoff can record them.

**How to apply:** `git status --short` before committing; add only the files this session touched. If owner edits are present, ask whether they are ready, then commit them separately with a message naming the change, and record config changes in `docs/customizations.md`. Related: [[write-memories-impersonally]].
