param(
    [string]$Message = "Ingest update"
)

$ErrorActionPreference = "Stop"
$repo = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Push-Location $repo
try {
    $paths = @(
        "raw/",
        "wiki/sources/",
        "wiki/concepts/",
        "wiki/entities/",
        "wiki/synthesis/",
        "wiki/index.md",
        "wiki/log.md",
        "AGENTS.md",
        "scripts/"
    )

    git add -- $paths
    $pending = git diff --cached --name-only
    if (-not $pending) {
        Write-Output "No ingest changes to commit."
        exit 0
    }

    git commit -m $Message
    git push origin main
}
finally {
    Pop-Location
}
