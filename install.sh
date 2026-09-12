#!/usr/bin/env bash
# Cheapskate installer — copies the rule file for one or more AI coding agents
# into the current directory.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/mazenmohammed24/cheapskate/main/install.sh | bash -s -- <target> [more targets...]
#
# Targets: agents (default, universal AGENTS.md) | claude | copilot | cursor | windsurf | cline | all
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/mazenmohammed24/cheapskate/main"

install_one() {
  case "$1" in
    claude|claude-code)
      mkdir -p .claude/skills/cheapskate
      curl -fsSL "$REPO_RAW/cheapskate/SKILL.md" -o .claude/skills/cheapskate/SKILL.md
      echo "Claude Code  -> .claude/skills/cheapskate/SKILL.md"
      ;;
    copilot)
      mkdir -p .github
      curl -fsSL "$REPO_RAW/.github/copilot-instructions.md" -o .github/copilot-instructions.md
      echo "Copilot      -> .github/copilot-instructions.md"
      ;;
    cursor)
      mkdir -p .cursor/rules
      curl -fsSL "$REPO_RAW/.cursor/rules/cheapskate.mdc" -o .cursor/rules/cheapskate.mdc
      echo "Cursor       -> .cursor/rules/cheapskate.mdc"
      ;;
    windsurf)
      curl -fsSL "$REPO_RAW/.windsurfrules" -o .windsurfrules
      echo "Windsurf     -> .windsurfrules"
      ;;
    cline|roo|roocode)
      curl -fsSL "$REPO_RAW/.clinerules" -o .clinerules
      echo "Cline/Roo    -> .clinerules"
      ;;
    agents)
      curl -fsSL "$REPO_RAW/AGENTS.md" -o AGENTS.md
      echo "Universal    -> AGENTS.md (Codex CLI, Gemini CLI, Aider, Zed, Devin, Jules, VS Code, and 25+ more)"
      ;;
    *)
      echo "Unknown target: $1 (expected: agents, claude, copilot, cursor, windsurf, cline, all)" >&2
      exit 1
      ;;
  esac
}

if [ $# -eq 0 ]; then
  set -- agents
fi

if [ "$1" = "all" ]; then
  set -- agents claude copilot cursor windsurf cline
fi

for target in "$@"; do
  install_one "$target"
done
