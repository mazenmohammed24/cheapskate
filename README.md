# Cheapskate

Token/tool/context-economy skill for AI coding agents. The instructions are identical everywhere — only the wrapper/location changes per tool.

| Tool | File | Install |
|---|---|---|
| Claude Code | `cheapskate/SKILL.md` | copy the `cheapskate/` folder into your project's `.claude/skills/` |
| VS Code Copilot | `.github/copilot-instructions.md` | copy to your repo root |
| Cursor | `.cursor/rules/cheapskate.mdc` | copy to your repo root |
| Windsurf | `.windsurfrules` | copy to your repo root |
| Cline / Roo Code | `.clinerules` | copy to your repo root |

For any other agent, paste the body of `cheapskate/SKILL.md` (everything below the `---` frontmatter) into its system prompt / custom instructions field.
