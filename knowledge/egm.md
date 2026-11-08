# egm (Elephant-Goldfish Model): how to use it here

Source: github.com/google/elephant-goldfish-model, installed as `egm@egm` **0.1.1**. Local copy of everything below: `~/.claude/plugins/cache/egm/egm/0.1.1/`. Re-check this file after an upgrade.

## What it is

Spec-driven development. The **Elephant** (your main session, full context) brainstorms and drafts a design doc. **Goldfish** reviewers (fresh subagents, read-only, `omitClaudeMd: true`) review it with no conversation history, so they can't inherit the drafter's bias. Code is written only after the spec passes review.

Pipeline: `/egm:egm-brainstorm` → `/egm:egm-draft` → `/egm:egm-review <doc>` → `/egm:egm-resolve` → implement → `/egm:egm-drift-report` now and then.

Review stages run in order (5 → 9): zoom-out (YAGNI, reuse), comprehension (naive reader), critic (design, failure modes), zoom-out again, implementation readiness (needs a `## Implementation Plan` section, else skipped). Presets: interactive, uninterrupted (one consolidated report), feature-spec only, implementation only.

## Where it writes (the part we fight)

| Output | Default location | Redirect |
|---|---|---|
| Scratch: `concepts_brief.md`, `design_draft.md`, `discussion_summary.md`, review reports, `goldfish_review_report.md` | working dir (project root) | `EGM artifact directory: <path>` line in CLAUDE.md / AGENTS.md or the prompt (`docs/claude.md`) |
| Final design doc (egm-draft) | `docs/designs/<feature>.md` | Pass a dir: `/egm:egm-draft .handoff/designs/`, or pick "Specify custom target directory" at the gate |
| brainstorm "Publish as RFC" | `docs/designs/<feature>.md` + `SITEMAP.md` | **Hard-coded.** Pick "Proceed to egm-draft" instead |

A relative artifact-dir path resolves against the working dir. A path outside it triggers a confirm prompt (headless: falls back to the working dir).

## Invoking it

- All egm skills are `disable-model-invocation: true`. The model can't call them, and the Skill tool refuses them. Only a typed slash command works.
- From a lead session: `herdr agent prompt <agent> "/egm:egm-review ..."` types it into another Claude pane. Since TASK-005, egm loads only in design mode, so start that worker with `cmode design`.
- Headless args that skip the gates: `TargetFile=<doc> GoldfishContext=[a.md, b.md] Step=uninterrupted`, plus "no one will answer questions".
- Reviewer subagents (`egm:egm-zoom-out`, `egm:egm-design`, …) can also be spawned directly with the Agent tool.
- Reviewers can't open URLs: save pages to files and pass paths.
- Headless runs need read rules for the plugin's `agents/ docs/ resources/ skills/` folders (`Read(//Users/henry/.claude/plugins/cache/egm/egm/*/agents/**)` etc.). Don't use `--add-dir`, which also grants write.

## Modifying it

- Rubrics live in `resources/document_standards/`; personas in `agents/` (harness-neutral) with Claude adapters in `.claude-plugin/agents/` (these set tools and `omitClaudeMd`).
- The "Default agents/ folder is ignored" warning in `/plugin` is expected.
- Test a modified copy under a different name: `claude --plugin-dir <copy>`, validate with `claude plugin validate <copy>/.claude-plugin/plugin.json`. Never edit the cache: updates overwrite it.

## Upstream docs worth reading (in the local copy, `docs/`)

- `designs/architecture.md`: components, lifecycle, write boundaries per phase.
- `claude.md`: Claude Code specifics: artifact dir, permissions, reviewer isolation.
- `designs/review.md`, `designs/draft.md`, `designs/brainstorm.md`, `designs/synthesizer.md`: one per skill.
- `getting_started.md`, `faq.md`: user guides.
