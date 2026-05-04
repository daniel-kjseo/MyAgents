#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
SOURCE_DIR="${PROJECT_ROOT}/skills/steve"

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "Missing source skill: ${SOURCE_DIR}/SKILL.md" >&2
  exit 1
fi

copy_skill() {
  local target_dir="$1"

  mkdir -p "${target_dir}"
  rm -rf "${target_dir}/steve"
  cp -R "${SOURCE_DIR}" "${target_dir}/steve"
  echo "Installed: ${target_dir}/steve"
}

copy_skill "${HOME}/.codex/skills"
copy_skill "${HOME}/.claude/skills"

if [[ "${1:-}" == "--project" ]]; then
  copy_skill "${PROJECT_ROOT}/.claude/skills"
fi

cat <<'MESSAGE'

Steve skill installed.

Default targets:
- Codex: ~/.codex/skills/steve
- Claude Code personal: ~/.claude/skills/steve

Optional project target:
- Run with --project to also install .claude/skills/steve in this project.

For Antigravity, point its skills directory at the same source folder or copy
skills/steve to the skills path configured by your Antigravity installation.
MESSAGE
