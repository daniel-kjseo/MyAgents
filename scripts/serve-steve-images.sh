#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
PORT="${1:-8765}"

cd "${PROJECT_ROOT}"

cat <<MESSAGE
Serving Steve images at:
  http://127.0.0.1:${PORT}/skills/steve/images/

Example:
  http://127.0.0.1:${PORT}/skills/steve/images/steve_coffee.png

Keep this process running while you want images to render in chat surfaces
that can load localhost URLs.
MESSAGE

python3 -m http.server "${PORT}" --bind 127.0.0.1
