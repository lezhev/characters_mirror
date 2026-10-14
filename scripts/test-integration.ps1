param([string]$TestPath = "test/integration")

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$serverDir = Join-Path $repoRoot "characters_mirror_server"
$storageEnvironmentNames = @(
    "S3_ENDPOINT", "S3_BUCKET", "S3_ACCESS_KEY", "S3_SECRET_KEY",
    "S3_USE_SSL", "S3_REGION", "S3_PATH_STYLE"
)
$previousStorageEnvironment = @{}
foreach ($name in $storageEnvironmentNames) {
    $previousStorageEnvironment[$name] = [Environment]::GetEnvironmentVariable($name, "Process")
}

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
    docker compose up -d --wait postgres_test minio

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to start postgres_test and minio."
    }

    $composeJson = docker compose config --format json
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to read local MinIO configuration."
    }
    $composeConfig = ConvertFrom-Json -InputObject ($composeJson -join "`n")
    $minioEnvironment = $composeConfig.services.minio.environment
    $minioPort = $composeConfig.services.minio.ports |
        Where-Object { $_.target -eq 9000 } |
        Select-Object -First 1
    if ($null -eq $minioPort -or
        [string]::IsNullOrWhiteSpace($minioPort.published) -or
        [string]::IsNullOrWhiteSpace($minioEnvironment.MINIO_ROOT_USER) -or
        [string]::IsNullOrWhiteSpace($minioEnvironment.MINIO_ROOT_PASSWORD)) {
        throw "Local MinIO must publish its API port and define root credentials."
    }

    $storageEndpoint = "http://127.0.0.1:$($minioPort.published)"
    $storageReady = $false
    $storageDeadline = [DateTime]::UtcNow.AddSeconds(60)
    while ([DateTime]::UtcNow -lt $storageDeadline) {
        try {
            $response = Invoke-WebRequest -Uri "$storageEndpoint/minio/health/ready" -UseBasicParsing -TimeoutSec 2
            if ($response.StatusCode -eq 200) {
                $storageReady = $true
                break
            }
        }
        catch {
            # MinIO may be running before its API is ready.
        }
        Start-Sleep -Seconds 1
    }
    if (-not $storageReady) {
        throw "Local MinIO did not become ready."
    }

    $env:S3_ENDPOINT = $storageEndpoint
    $env:S3_BUCKET = "characters-mirror-integration-tests"
    $env:S3_ACCESS_KEY = $minioEnvironment.MINIO_ROOT_USER
    $env:S3_SECRET_KEY = $minioEnvironment.MINIO_ROOT_PASSWORD
    $env:S3_USE_SSL = "false"
    $env:S3_REGION = "us-east-1"
    $env:S3_PATH_STYLE = "true"

    dart run tool/prepare_test_storage.dart
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to prepare the local integration-test bucket."
    }

    dart test $TestPath --concurrency=1

    if ($LASTEXITCODE -ne 0) {
        throw "Integration tests failed."
    }
}
finally {
    foreach ($name in $storageEnvironmentNames) {
        [Environment]::SetEnvironmentVariable($name, $previousStorageEnvironment[$name], "Process")
    }
    Pop-Location
}
