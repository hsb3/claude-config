---
name: agent-instructions-follow-skill-best-practices
description: Anything written into agent instructions or skills (AGENTS.md, CLAUDE.md, mode prompts, SKILL.md) follows Anthropic's Agent Skills best-practices doc
metadata:
  type: feedback
---

Rule (2026-11-08): agent instructions and skills follow https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

**Why:** this repo ships prompts (global/AGENTS.md, modes/*/prompt.md, global/skills/*/SKILL.md) and they are held to Anthropic's own standard rather than ad-hoc prose.

**How to apply:** before editing such a file, check it against the doc's rules: description in third person, what plus when, with trigger terms; concise imperative body with only what Claude does not already know; one default per decision plus an escape hatch; no time-sensitive facts; SKILL.md under 500 lines, reference files one level deep, forward-slash paths; numbered steps with a verify-and-loop check; names lowercase-hyphen, gerund preferred. The repo's AGENTS.md carries the same checklist. Related: [[consult-claude-code-docs-first]].
