# Cheapskate installer — copies the rule file for one or more AI coding agents
# into the current directory.
#
# Usage:
#   irm https://raw.githubusercontent.com/mazenmohammed24/cheapskate/main/install.ps1 | iex
#   # or with targets:
#   & ([scriptblock]::Create((irm https://raw.githubusercontent.com/mazenmohammed24/cheapskate/main/install.ps1))) claude cursor
#
# Targets: agents (default, universal AGENTS.md) | claude | copilot | cursor | windsurf | cline | all
param(
    [string[]]$Targets = @("agents")
)

$RepoRaw = "https://raw.githubusercontent.com/mazenmohammed24/cheapskate/main"

function Install-One {
    param([string]$Target)

    switch ($Target) {
        { $_ -in "claude", "claude-code" } {
            New-Item -ItemType Directory -Force -Path ".claude/skills/cheapskate" | Out-Null
            Invoke-WebRequest -Uri "$RepoRaw/cheapskate/SKILL.md" -OutFile ".claude/skills/cheapskate/SKILL.md"
            Write-Host "Claude Code  -> .claude/skills/cheapskate/SKILL.md"
        }
        "copilot" {
            New-Item -ItemType Directory -Force -Path ".github" | Out-Null
            Invoke-WebRequest -Uri "$RepoRaw/.github/copilot-instructions.md" -OutFile ".github/copilot-instructions.md"
            Write-Host "Copilot      -> .github/copilot-instructions.md"
        }
        "cursor" {
            New-Item -ItemType Directory -Force -Path ".cursor/rules" | Out-Null
            Invoke-WebRequest -Uri "$RepoRaw/.cursor/rules/cheapskate.mdc" -OutFile ".cursor/rules/cheapskate.mdc"
            Write-Host "Cursor       -> .cursor/rules/cheapskate.mdc"
        }
        "windsurf" {
            Invoke-WebRequest -Uri "$RepoRaw/.windsurfrules" -OutFile ".windsurfrules"
            Write-Host "Windsurf     -> .windsurfrules"
        }
        { $_ -in "cline", "roo", "roocode" } {
            Invoke-WebRequest -Uri "$RepoRaw/.clinerules" -OutFile ".clinerules"
            Write-Host "Cline/Roo    -> .clinerules"
        }
        "agents" {
            Invoke-WebRequest -Uri "$RepoRaw/AGENTS.md" -OutFile "AGENTS.md"
            Write-Host "Universal    -> AGENTS.md (Codex CLI, Gemini CLI, Aider, Zed, Devin, Jules, VS Code, and 25+ more)"
        }
        default {
            Write-Warning "Unknown target: $Target (expected: agents, claude, copilot, cursor, windsurf, cline, all)"
        }
    }
}

if ($Targets.Count -eq 1 -and $Targets[0] -eq "all") {
    $Targets = @("agents", "claude", "copilot", "cursor", "windsurf", "cline")
}

foreach ($t in $Targets) {
    Install-One -Target $t
}
