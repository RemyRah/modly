#!/usr/bin/env bash
# Wire this repo's tracked git hooks (in .githooks/) into the local clone.
# Run once per clone:  ./scripts/setup-hooks.sh
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
cd "$ROOT"

git config core.hooksPath .githooks
chmod +x .githooks/* 2>/dev/null || true

echo "hooks: core.hooksPath -> .githooks"
echo "  pre-commit: trufflehog secret backstop"
echo "  pre-push:   npm test + force-push/delete guard on main + trufflehog scan"

if ! command -v trufflehog >/dev/null 2>&1; then
    echo "hooks: WARNING — trufflehog not on PATH; the secret scan will be skipped." >&2
    echo "       Install:  brew install trufflehog" >&2
fi
