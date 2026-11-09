# claude-config

My Claude Code setup from a fresh install: global settings and instructions, working modes, the `cmode` launcher, and notes on every customization.

## Install

```sh
git clone https://github.com/hsb3/claude-config.git
cd claude-config
./install.sh
```

The installer runs `tests/cmode-test`, then copies into `~/.claude/` (or `$CLAUDE_CONFIG_DIR`). Re-run it after pulling changes. It reports each file as added, changed or unchanged.

| From | To | How |
|---|---|---|
| `modes/*` | `~/.claude/modes/` | overwritten |
| `bin/cmode` | `~/.local/bin/cmode` | overwritten |
| `global/*` except `settings.json` (`CLAUDE.md`, `AGENTS.md`, `.i-have-adhd-always`, `skills/handoff/`) | `~/.claude/` | overwritten; a different old file is kept as `<name>.bak` |
| `global/settings.json` | `~/.claude/settings.json` | copied only if you have none |

If you already have a `settings.json` that differs, the installer leaves it alone and prints the diff (`-` yours, `+` repo). Copy over the lines you want by hand. Machine-specific entries such as the herdr hook are not in the repo, so they always show as `-` lines; keep them. Self-check for the installer: `tests/install-test`.

Needs Claude Code. The modes expect these plugins and warn if any is missing: [ponytail](https://github.com/dietrichgebert/ponytail), [i-have-adhd](https://github.com/ayghri/i-have-adhd), [egm](https://github.com/google/elephant-goldfish-model) (on only in design mode). Hand-off files go in the project's gitignored `.handoff/` folder.

## Use

```sh
cmode design      # explore and shape a product, writes .handoff/designs/<feature>.md
cmode planning    # turn the design into ordered, verifiable steps, writes .handoff/plans/<feature>.md
cmode building    # implement the plan step by step
```

Extra arguments pass through to `claude`, e.g. `cmode planning --resume`.

## What's here

The product is what `install.sh` copies. Everything else documents or tests it.

| Path | What |
|---|---|
| `install.sh` | installer, safe to re-run |
| `global/` | files copied into `~/.claude/`: `settings.json`, `CLAUDE.md`, `AGENTS.md`, `.i-have-adhd-always`, `skills/handoff/` |
| `modes/<mode>/` | `prompt.md` (appended to Claude Code's default prompt) and `settings.json` (per-mode overrides) |
| `modes/workflow.json` | the hand-off graph: each mode's inputs, outputs, plugins, effort and the modes it hands to; a checked mirror of the prompts, not shipped |
| `bin/cmode` | the mode launcher |
| `tests/` | self-checks: `cmode-test`, `install-test`, `workflow-test` (walks the graph, needs jq) |
| `docs/modes-design.md` | how the modes are designed, and why |
| `docs/customizations.md` | current state of my Claude Code config, with the reason for each piece |
| `docs/pre-mortem.md` | how this product could fail, and the guard for each |
| `docs/knowledge/` | research behind the design: tested Claude Code findings, Claude Code's default instructions, egm usage notes |
| `AGENTS.md` | conventions for agents working in this repo |
