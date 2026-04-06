#!/usr/bin/env bash
set -euo pipefail

BLUEPRINT_PATH=""
VERSION=""
REPO="Odyno/ha-blueprints"
COMMIT=""
REGISTRY_PATH="docs/BLUEPRINT_VERSIONS.md"

usage() {
  cat <<'EOF'
Usage:
  ./scripts/release-blueprint.sh --blueprint-path <path> --version <X.Y.Z> [options]

Required:
  --blueprint-path PATH   Blueprint YAML path
  --version X.Y.Z         Semantic version for that blueprint

Optional:
  --repo OWNER/REPO       Default: Odyno/ha-blueprints
  --commit SHA            Default: current git HEAD
  --registry-path PATH    Default: docs/BLUEPRINT_VERSIONS.md
  -h, --help              Show this help
EOF
}

die() {
  echo "Error: $*" >&2
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --blueprint-path)
      [[ $# -ge 2 ]] || die "Missing value for --blueprint-path"
      BLUEPRINT_PATH="$2"
      shift 2
      ;;
    --version)
      [[ $# -ge 2 ]] || die "Missing value for --version"
      VERSION="$2"
      shift 2
      ;;
    --repo)
      [[ $# -ge 2 ]] || die "Missing value for --repo"
      REPO="$2"
      shift 2
      ;;
    --commit)
      [[ $# -ge 2 ]] || die "Missing value for --commit"
      COMMIT="$2"
      shift 2
      ;;
    --registry-path)
      [[ $# -ge 2 ]] || die "Missing value for --registry-path"
      REGISTRY_PATH="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[[ -n "$BLUEPRINT_PATH" ]] || die "--blueprint-path is required"
[[ -n "$VERSION" ]] || die "--version is required"
[[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || die "Invalid version '$VERSION' (expected X.Y.Z)"
[[ -f "$BLUEPRINT_PATH" ]] || die "Blueprint file not found: $BLUEPRINT_PATH"
[[ -f "$REGISTRY_PATH" ]] || die "Registry file not found: $REGISTRY_PATH"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "This script must run inside a git repository"

if [[ -n "$(git status --porcelain -- "$BLUEPRINT_PATH")" ]]; then
  die "Blueprint has uncommitted changes: $BLUEPRINT_PATH. Commit or stash changes before release."
fi

if [[ -z "$COMMIT" ]]; then
  COMMIT="$(git rev-parse HEAD | tr -d '\r\n')"
fi

[[ "$COMMIT" =~ ^[0-9a-fA-F]{7,40}$ ]] || die "Invalid commit value: $COMMIT"

PATH_NORMALIZED="${BLUEPRINT_PATH//\\//}"

BLUEPRINT_NAME="$(awk '
  BEGIN { in_bp=0 }
  /^blueprint:[[:space:]]*$/ { in_bp=1; next }
  in_bp && /^[^[:space:]]/ { in_bp=0 }
  in_bp && /^[[:space:]]+name:[[:space:]]*/ {
    line=$0
    sub(/^[[:space:]]+name:[[:space:]]*/, "", line)
    gsub(/^"|"$/, "", line)
    print line
    exit
  }
' "$BLUEPRINT_PATH" | tr -d '\r\n')"

[[ -n "$BLUEPRINT_NAME" ]] || die "Unable to extract blueprint name from '$BLUEPRINT_PATH'"

STABLE_URL="https://raw.githubusercontent.com/$REPO/$COMMIT/$PATH_NORMALIZED"
ROLLING_URL="https://raw.githubusercontent.com/$REPO/main/$PATH_NORMALIZED"

if command -v python >/dev/null 2>&1; then
  ENCODED_STABLE_URL="$(python - <<'PY' "$STABLE_URL"
import sys
from urllib.parse import quote
print(quote(sys.argv[1], safe=''))
PY
)"
elif command -v python3 >/dev/null 2>&1; then
  ENCODED_STABLE_URL="$(python3 - <<'PY' "$STABLE_URL"
import sys
from urllib.parse import quote
print(quote(sys.argv[1], safe=''))
PY
)"
else
  die "python/python3 is required to URL-encode the import URL"
fi

HA_IMPORT_URL="https://my.home-assistant.io/redirect/blueprint_import/?url=$ENCODED_STABLE_URL"
NEW_ROW="| $BLUEPRINT_NAME | $PATH_NORMALIZED | $VERSION | $COMMIT | $STABLE_URL | $ROLLING_URL |"

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

if grep -Fq "| $PATH_NORMALIZED |" "$REGISTRY_PATH"; then
  awk -v path="$PATH_NORMALIZED" -v row="$NEW_ROW" '
    {
      if ($0 ~ /^\|[^\n]*\|/) {
        n = split($0, cols, "|")
        if (n >= 4) {
          field = cols[3]
          gsub(/^[[:space:]]+|[[:space:]]+$/, "", field)
          if (field == path) {
            print row
            next
          }
        }
      }
      print
    }
  ' "$REGISTRY_PATH" > "$TMP_FILE"
else
  awk -v row="$NEW_ROW" '
    BEGIN { inserted = 0 }
    {
      print
      if (!inserted && $0 ~ /^\|---/) {
        print row
        inserted = 1
      }
    }
    END {
      if (!inserted) {
        print row
      }
    }
  ' "$REGISTRY_PATH" > "$TMP_FILE"
fi

mv "$TMP_FILE" "$REGISTRY_PATH"
trap - EXIT

FILE_BASENAME="$(basename "$PATH_NORMALIZED")"

echo "Updated: $REGISTRY_PATH"
echo "Blueprint: $BLUEPRINT_NAME"
echo "Version: $VERSION"
echo "Commit: $COMMIT"
echo "Stable URL: $STABLE_URL"
echo "HA Import URL (stable): $HA_IMPORT_URL"
echo
echo "Next steps:"
echo "1. Review file changes"
echo "2. git add $BLUEPRINT_PATH $REGISTRY_PATH"
echo "3. git commit -m \"release($FILE_BASENAME): v$VERSION\""
