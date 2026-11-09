---
name: handoff
description: Maintains the project's session-handoff file so a new session can pick up the work cold. Use at session boundaries, when the user says "wrap up", "update the handoff", "prepare to clear" or "compact", "write the handoff", or runs /handoff; "/handoff init" creates the file in a project that has none. Updates _meta/HANDOFF.md (or HANDOFF.md, .claude/HANDOFF.md) with current state, in-flight work, decisions made and pending, and gotchas.
---

# Project handoff

The handoff puts every load-bearing fact of a session into one file a cold session can read in under 10k tokens. It is the bridge for new sessions, not resumes: write for a reader with zero context.

## File location

Candidates, in order: `_meta/HANDOFF.md`, `HANDOFF.md`, `.claude/HANDOFF.md`. Update an existing handoff where it lives; never relocate it.

Default for a new one: gitignored `_meta/HANDOFF.md`. Gitignored on purpose, so the file stays blunt (candid gotchas, undecided questions, operational state) without becoming an audience-facing document or churning PRs. Exception: commit a root `HANDOFF.md` when the project is worked from more than one checkout (cloud sessions, other machines, collaborators, agents on fresh clones), because a gitignored file is absent exactly at that cold start. If unsure, ask the user once at init.

Worktrees do not contain gitignored folders. Subagents in worktrees read and write the handoff via the main checkout's absolute path.

## Update pass (default)

1. Read the existing handoff in full.
2. Diff it against this session: what shipped (PR and issue refs, absolute dates); decisions made, each with its one-line why; what is in flight; gotchas found the hard way; what sits in the owner's court.
3. Edit sections in place; do not rewrite the file. Convert relative dates to YYYY-MM-DD.
4. Keep it a bridge, not a diary: target 150 lines, ceiling 200. When dated session entries pile up, distill in this order: promote durable gotchas and decisions into the conventions section; collapse the narrative to one line per era (git history keeps the detail); delete superseded guidance. Fold this session into a short "recent deliveries" list instead of adding a dated section.
5. Save any durable user preference or feedback that surfaced to auto-memory (one fact per file, pointer line in MEMORY.md).
6. In the reply, answer "what do I still know that is not written down?" and write it first. Then say whether the session is clearable, or what keeps it open (for example background agents still running).

## `/handoff init`

Survey the repo (README, CLAUDE.md or AGENTS.md, git log, issue board). Create `_meta/` and add `_meta/` to `.gitignore` if missing (or use the committed root file when the exception above applies), then write the handoff from this skeleton, filling each section or deleting it:

```markdown
# HANDOFF - read this first when starting a session in <project>

_Cold-start onboarding. Last updated: YYYY-MM-DD. Keep updated at session boundaries (/handoff)._

## 1. What this is (2-4 lines: the product/goal, and any sibling repos that matter)
## 2. Current state (what works, what is deployed, where)
## 3. In flight / next up (issue + PR refs)
## 4. Decisions made (date - decision - one-line why)
## 5. Pending decisions (the owner's court)
## 6. Conventions & gotchas (the things that bite; exact commands)
## 7. Map (key docs, dashboards, boards, related repos)
```

## Rules

- No secrets, ever: the file may be committed or shared.
- Record only what a fresh session cannot derive from the repo: state, intent, decisions, gotchas. CLAUDE.md and AGENTS.md load in every session, so replace anything copied from them with a pointer ("see AGENTS.md"). Link to the README instead of restating it.
- A tracked handoff is exempted from the repo's prose formatter (for example in `.prettierignore`), so its prose cannot fail format CI.
- An update should cost about 1 to 2k tokens of writing. If it takes much longer, the file has rotted: distill it as part of the pass.
