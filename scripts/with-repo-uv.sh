#!/usr/bin/env bash
# Execute `uv …` tied to THIS repo's .venv regardless of shell VIRTUAL_ENV.
# Usage (from repo root): ./scripts/with-repo-uv.sh run pytest tests/
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export UV_PROJECT_ENVIRONMENT="$ROOT/.venv"
unset VIRTUAL_ENV
exec uv "$@"
