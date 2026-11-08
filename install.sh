#!/bin/sh
# install.sh: install the working modes and the cmode launcher from this repo. Safe to re-run.
set -eu
repo=$(cd "$(dirname "$0")" && pwd)
modes_dst="${CLAUDE_CONFIG_DIR:-$HOME/.claude}/modes"
bin_dst="$HOME/.local/bin"

"$repo/bin/cmode-test" >/dev/null || { echo "install: bin/cmode-test failed, nothing installed" >&2; exit 1; }

put() { # put <src> <dst>: copy and report added / changed / unchanged
  if [ ! -e "$2" ]; then s=added; elif cmp -s "$1" "$2"; then s=unchanged; else s=changed; fi
  mkdir -p "$(dirname "$2")"
  cp "$1" "$2"
  echo "$s  $2"
}
# shortcut: never deletes, so a mode removed from the repo stays installed until removed by hand
for f in "$repo"/modes/*/*; do put "$f" "$modes_dst/${f#"$repo"/modes/}"; done
put "$repo/bin/cmode" "$bin_dst/cmode"
chmod +x "$bin_dst/cmode"

case ":$PATH:" in *":$bin_dst:"*) ;; *) echo "warning: $bin_dst is not on PATH, add it to run cmode" >&2 ;; esac
if command -v claude >/dev/null 2>&1; then
  plugins=$(claude plugin list 2>/dev/null || true)
  for p in ponytail i-have-adhd egm; do
    printf '%s\n' "$plugins" | grep -q "$p@" || echo "warning: plugin '$p' is not installed, modes still start but its settings do nothing" >&2
  done
else
  echo "warning: claude not found, install Claude Code before running cmode" >&2
fi
