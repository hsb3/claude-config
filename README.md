# claude-config

My Claude Code setup: working modes, the `cmode` launcher, and notes on every customization.

## Install

```sh
git clone https://github.com/hsb3/claude-config.git
cd claude-config
./install.sh
```

The installer runs `bin/cmode-test`, then copies `modes/*` to `~/.claude/modes/` (or `$CLAUDE_CONFIG_DIR/modes/`) and `bin/cmode` to `~/.local/bin/`. Re-run it after pulling changes. It reports each file as added, changed or unchanged.

Needs Claude Code. The modes expect these plugins and warn if any is missing: [ponytail](https://github.com/dietrichgebert/ponytail), [i-have-adhd](https://github.com/ayghri/i-have-adhd), [egm](https://github.com/google/elephant-goldfish-model) (on only in design mode). Hand-off files go in the project's gitignored `.handoff/` folder.

## Use

```sh
cmode design      # explore and shape a product, writes .handoff/designs/<feature>.md
cmode planning    # turn the design into ordered, verifiable steps, writes .handoff/plans/<feature>.md
cmode building    # implement the plan step by step
```

Extra arguments pass through to `claude`, e.g. `cmode planning --resume`.

## What's here

| Path | What |
|---|---|
| `modes/<mode>/` | `prompt.md` (appended to Claude Code's default prompt) and `settings.json` (per-mode overrides) |
| `bin/cmode`, `bin/cmode-test` | launcher and its self-check |
| `MODES-DESIGN.md` | how the modes are designed, and why |
| `CUSTOMIZATIONS.md` | every change made to my Claude Code config, with the reason |
| `claude-code-knowledge.md` | tested findings about Claude Code behavior |
| `DEFAULT-INSTRUCTIONS.md` | summary of Claude Code's default instructions, as a baseline |
