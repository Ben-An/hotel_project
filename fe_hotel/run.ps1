$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$PROJECT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$ROOT_DIR = Split-Path -Parent $PROJECT_DIR
$MVN = "$ROOT_DIR\apache-maven-3.9.6\bin\mvn.cmd"
$TOMCAT_DIR = "$ROOT_DIR\tomcat"
$WAR_NAME = "fe_hotel"

$env:CATALINA_HOME = $TOMCAT_DIR

Write-Host "=== fe_hotel 빌드 시작 ===" -ForegroundColor Cyan
Set-Location $PROJECT_DIR
& $MVN clean package -DskipTests
if ($LASTEXITCODE -ne 0) {
    Write-Host "빌드 실패!" -ForegroundColor Red
    exit 1
}
Write-Host "=== 빌드 완료 ===" -ForegroundColor Green

# 기존 배포 제거 & WAR 배포 (ROOT로 배포하여 localhost:8080/ 에서 바로 접근)
Write-Host "=== WAR 배포 ===" -ForegroundColor Cyan
if (Test-Path "$TOMCAT_DIR\webapps\ROOT") { Remove-Item -Recurse -Force "$TOMCAT_DIR\webapps\ROOT" }
if (Test-Path "$TOMCAT_DIR\webapps\ROOT.war") { Remove-Item -Force "$TOMCAT_DIR\webapps\ROOT.war" }
if (Test-Path "$TOMCAT_DIR\webapps\$WAR_NAME") { Remove-Item -Recurse -Force "$TOMCAT_DIR\webapps\$WAR_NAME" }
if (Test-Path "$TOMCAT_DIR\webapps\$WAR_NAME.war") { Remove-Item -Force "$TOMCAT_DIR\webapps\$WAR_NAME.war" }
Copy-Item "$PROJECT_DIR\target\$WAR_NAME-1.0.0.war" "$TOMCAT_DIR\webapps\ROOT.war"

# WAR 압축 해제 (Tomcat 실행 여부와 무관하게 즉시 배포)
Write-Host "=== WAR 압축 해제 ===" -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$TOMCAT_DIR\webapps\ROOT" -Force | Out-Null
Copy-Item "$TOMCAT_DIR\webapps\ROOT.war" "$TOMCAT_DIR\webapps\ROOT.zip" -Force
Expand-Archive -Path "$TOMCAT_DIR\webapps\ROOT.zip" -DestinationPath "$TOMCAT_DIR\webapps\ROOT" -Force
Remove-Item "$TOMCAT_DIR\webapps\ROOT.zip" -Force

Write-Host ""
Write-Host "fe_hotel 배포 완료! http://localhost:8080/" -ForegroundColor Green
