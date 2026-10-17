param(
    [string]$Image = "characters-mirror-server:local"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$dockerfile = Join-Path $repoRoot "characters_mirror_server/Dockerfile"

if (-not (Test-Path -LiteralPath $dockerfile)) {
    throw "Server Dockerfile not found: $dockerfile"
}
docker info *> $null
if ($LASTEXITCODE -ne 0) {
    throw "Docker daemon is not running. Start it manually before building."
}
docker build --file $dockerfile --tag $Image $repoRoot
if ($LASTEXITCODE -ne 0) {
    throw "Docker build failed. No deployment was performed."
}
docker image inspect $Image --format '{{.Id}}'
if ($LASTEXITCODE -ne 0) {
    throw "Docker image inspection failed."
}
Write-Host "Server image built: $Image"
