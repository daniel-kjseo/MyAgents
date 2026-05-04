#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  cat >&2 <<'USAGE'
Usage:
  scripts/set-steve-github-raw-url.sh <github-raw-image-base-url>

Example:
  scripts/set-steve-github-raw-url.sh \
    https://raw.githubusercontent.com/daniel/03_Agent_Steve/main/skills/steve/images
USAGE
  exit 1
fi

RAW_BASE_URL="${1%/}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SKILL_FILE="${PROJECT_ROOT}/skills/steve/SKILL.md"

if [[ ! "${RAW_BASE_URL}" =~ ^https://raw\.githubusercontent\.com/.+/skills/steve/images$ ]]; then
  echo "Expected a GitHub raw image base URL ending in /skills/steve/images" >&2
  exit 1
fi

if [[ ! -f "${SKILL_FILE}" ]]; then
  echo "Missing skill file: ${SKILL_FILE}" >&2
  exit 1
fi

perl -0pi -e "s#GITHUB_RAW_BASE_URL#${RAW_BASE_URL}#g" "${SKILL_FILE}"

echo "Updated Steve image base URL in ${SKILL_FILE}"
echo "Next: run scripts/install-steve-skill.sh --project"
