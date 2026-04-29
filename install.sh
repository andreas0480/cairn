#!/usr/bin/env bash
# Cairn — install script for Claude Code projects.
# Repo: https://github.com/andreas0480/cairn
#
# One-line install (cwd is the target):
#   curl -fsSL https://raw.githubusercontent.com/andreas0480/cairn/main/install.sh | bash
#
# Install into a different directory:
#   curl -fsSL https://raw.githubusercontent.com/andreas0480/cairn/main/install.sh | bash -s -- --target /path/to/repo
#
# What it does (idempotent — safe to re-run for updates):
#   - Drops scout / recall / learn / handover into <target>/.claude/commands/
#   - Drops KNOWLEDGE.md template at <target>/KNOWLEDGE.md  (kept if it exists)
#   - Creates <target>/CLAUDE.md, or updates the Cairn section between markers

set -euo pipefail

REPO="andreas0480/cairn"
BRANCH="main"
TARGET="$PWD"

while [ $# -gt 0 ]; do
  case "$1" in
    --target)   TARGET="$2"; shift 2 ;;
    --target=*) TARGET="${1#--target=}"; shift ;;
    --branch)   BRANCH="$2"; shift 2 ;;
    --branch=*) BRANCH="${1#--branch=}"; shift ;;
    -h|--help)
      sed -n '2,/^set -euo/p' "$0" | sed -e 's/^# \{0,1\}//' -e '/^set -euo/d'
      exit 0 ;;
    *) echo "unknown argument: $1" >&2; exit 1 ;;
  esac
done

command -v curl >/dev/null || { echo "curl is required" >&2; exit 1; }
[ -d "$TARGET" ] || { echo "target is not a directory: $TARGET" >&2; exit 1; }

RAW="https://raw.githubusercontent.com/$REPO/$BRANCH"
BEGIN_MARKER="<!-- BEGIN cairn -->"
END_MARKER="<!-- END cairn -->"

echo "→ installing cairn into $TARGET"
echo

# 1. Slash commands
mkdir -p "$TARGET/.claude/commands"
for cmd in scout recall learn handover; do
  curl -fsSL "$RAW/commands/$cmd.md" -o "$TARGET/.claude/commands/$cmd.md"
  echo "  ✓ .claude/commands/$cmd.md"
done

# 2. KNOWLEDGE.md — never overwrite existing entries
if [ ! -f "$TARGET/KNOWLEDGE.md" ]; then
  curl -fsSL "$RAW/KNOWLEDGE.md" -o "$TARGET/KNOWLEDGE.md"
  echo "  ✓ KNOWLEDGE.md (created)"
else
  echo "  · KNOWLEDGE.md (kept existing)"
fi

# 3. CLAUDE.md — append or update Cairn section between markers
TMP_BODY=$(mktemp)
TMP_OUT=$(mktemp)
trap "rm -f $TMP_BODY $TMP_OUT" EXIT
curl -fsSL "$RAW/CLAUDE.md" -o "$TMP_BODY"

if [ -f "$TARGET/CLAUDE.md" ]; then
  HAD_CAIRN=0
  grep -qF "$BEGIN_MARKER" "$TARGET/CLAUDE.md" 2>/dev/null && HAD_CAIRN=1

  awk -v b="$BEGIN_MARKER" -v e="$END_MARKER" '
    index($0, b) == 1 { skip=1; next }
    index($0, e) == 1 && skip { skip=0; next }
    !skip { print }
  ' "$TARGET/CLAUDE.md" > "$TMP_OUT"

  {
    cat "$TMP_OUT"
    echo
    echo "$BEGIN_MARKER"
    cat "$TMP_BODY"
    echo "$END_MARKER"
  } > "$TARGET/CLAUDE.md"

  if [ "$HAD_CAIRN" -eq 1 ]; then
    echo "  ✓ CLAUDE.md (cairn section updated in place)"
  else
    echo "  ✓ CLAUDE.md (cairn section appended)"
  fi
else
  {
    echo "$BEGIN_MARKER"
    cat "$TMP_BODY"
    echo "$END_MARKER"
  } > "$TARGET/CLAUDE.md"
  echo "  ✓ CLAUDE.md (created)"
  echo
  echo "    note: bootstrap your project's full CLAUDE.md by running the"
  echo "          context-aware starter prompt — Cairn is the workflow"
  echo "          layer, not the context layer."
fi

cat <<EOF

✓ cairn installed.

  next:
    /scout "fix login button returning 500"
    /recall "retriever performance"
    /handover                              # at session end

  re-run this installer any time to pick up updates.
EOF
