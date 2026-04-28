$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$ROOT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$TOMCAT_DIR = "$ROOT_DIR\tomcat"

$env:CATALINA_HOME = $TOMCAT_DIR

Write-Host "=== Tomcat 시작 ===" -ForegroundColor Cyan
Write-Host "CATALINA_HOME: $TOMCAT_DIR" -ForegroundColor Gray
& "$TOMCAT_DIR\bin\catalina.bat" run
