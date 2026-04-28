$ErrorActionPreference = "Stop"

$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$ROOT_DIR = Split-Path -Parent $PROJECT_DIR
$TOMCAT_DIR = "$ROOT_DIR\tomcat"
$WEBAPP_SRC = "$PROJECT_DIR\src\main\webapp"
$WEBAPP_DEST = "$TOMCAT_DIR\webapps\ROOT"

Write-Host "=== fe_hotel Watch Mode ===" -ForegroundColor Cyan
Write-Host "Source: $WEBAPP_SRC" -ForegroundColor Gray
Write-Host "Target: $WEBAPP_DEST" -ForegroundColor Gray
Write-Host "Press Ctrl+C to stop" -ForegroundColor Gray
Write-Host ""

function Get-FileSnapshot {
    $snapshot = @{}
    Get-ChildItem -Path $WEBAPP_SRC -Recurse -File | ForEach-Object {
        $snapshot[$_.FullName] = $_.LastWriteTime
    }
    return $snapshot
}

$lastSnapshot = Get-FileSnapshot

while ($true) {
    Start-Sleep -Seconds 2

    $currentSnapshot = Get-FileSnapshot

    foreach ($file in $currentSnapshot.Keys) {
        if (-not $lastSnapshot.ContainsKey($file) -or $lastSnapshot[$file] -ne $currentSnapshot[$file]) {
            $relativePath = $file.Substring($WEBAPP_SRC.Length)
            $destPath = "$WEBAPP_DEST$relativePath"
            $destDir = Split-Path -Parent $destPath
            if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Path $destDir -Force | Out-Null }
            Copy-Item -Path $file -Destination $destPath -Force
            Write-Host "[$(Get-Date -Format 'HH:mm:ss')] Synced: $relativePath" -ForegroundColor Green
        }
    }

    $lastSnapshot = $currentSnapshot
}
