#!/usr/bin/env bash

set -euo pipefail

payload="$(cat)"
source_value="$(printf '%s' "$payload" | jq -r '.source // ""' 2>/dev/null || true)"

# Run only for brand-new sessions, not resume/clear.
if [[ "$source_value" != "startup" ]]; then
  exit 0
fi

# Only run in git repos and only if the alias exists.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  exit 0
fi
if ! git config --get alias.fresh >/dev/null 2>&1; then
  exit 0
fi

git fresh >/dev/null 2>&1 || true
