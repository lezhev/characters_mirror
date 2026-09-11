$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$serverDir = Join-Path $repoRoot "characters_mirror_server"

function Test-Docker {
    $previousErrorActionPreference = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
        docker info *> $null
        return $LASTEXITCODE -eq 0
    }
    catch {
        return $false
    }
    finally {
        $ErrorActionPreference = $previousErrorActionPreference
    }
}

if (-not (Test-Path -LiteralPath $serverDir)) {
    throw "Server package was not found at $serverDir."
}

if (-not (Test-Docker)) {
    $dockerDesktop = "C:\Program Files\Docker\Docker\Docker Desktop.exe"

    if (-not (Test-Path -LiteralPath $dockerDesktop)) {
        throw "Docker daemon is unavailable and Docker Desktop was not found."
    }

    Write-Host "Docker daemon is unavailable. Starting Docker Desktop..."
    Start-Process -FilePath $dockerDesktop -WindowStyle Hidden

    $ready = $false

    for ($attempt = 0; $attempt -lt 60; $attempt++) {
        Start-Sleep -Seconds 2

        if (Test-Docker) {
            $ready = $true
            break
        }
    }

    if (-not $ready) {
        throw "Docker daemon did not become ready."
    }
}

Push-Location $serverDir

try {
    docker compose up -d --wait postgres_test

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to start postgres_test."
    }

    dart test test/integration

    if ($LASTEXITCODE -ne 0) {
        throw "Integration tests failed."
    }
}
finally {
    Pop-Location
}
