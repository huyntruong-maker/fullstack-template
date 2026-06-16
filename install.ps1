# claude-fullstack-pack - drop-in installer (Windows PowerShell)
# Usage:
#   .\install.ps1                       # install into current directory
#   .\install.ps1 -Target C:\path\proj # install into a specific project
#   .\install.ps1 -WithMcp             # also list MCP configs to merge
param(
  [string]$Target = (Get-Location).Path,
  [switch]$WithMcp
)
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Test-Path $Target)) { Write-Error "Target directory '$Target' does not exist"; exit 1 }

Write-Host "Installing claude-fullstack-pack into: $Target\.claude"
foreach ($d in @("agents","commands","skills","rules","hooks")) {
  New-Item -ItemType Directory -Force -Path "$Target\.claude\$d" | Out-Null
}
function Copy-Component($name) {
  $src = Join-Path $ScriptDir $name
  if (Test-Path $src) {
    Copy-Item -Recurse -Force "$src\*" "$Target\.claude\$name\"
    Write-Host "  + $name\"
  }
}
"agents","commands","skills","rules","hooks" | ForEach-Object { Copy-Component $_ }

Copy-Item -Force "$ScriptDir\CLAUDE.md" "$Target\.claude\fullstack-pack.CLAUDE.md"
Write-Host "  + .claude\fullstack-pack.CLAUDE.md (import from your project's CLAUDE.md)"

if ($WithMcp) {
  Write-Host "MCP configs (merge into $Target\.mcp.json):"
  Get-ChildItem "$ScriptDir\mcp\*.json" | ForEach-Object { Write-Host "  $($_.FullName)" }
  Write-Host "See mcp\README.md for env vars and merge steps."
}

Write-Host ""
Write-Host "Done. Next steps:"
Write-Host "  1. Add to your project's CLAUDE.md:   @.claude/fullstack-pack.CLAUDE.md"
Write-Host "  2. In Claude Code run:  /start"
Write-Host "  3. (Optional) MCP servers: see mcp\README.md"
Write-Host "Nothing existing was overwritten - only new files were added under .claude\."
