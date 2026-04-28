chcp 65001 | Out-Null

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

# 1. Maven build
& "$root\apache-maven-3.9.6\bin\mvn.cmd" clean package -DskipTests -f "$root\fe_hotel\pom.xml"
if ($LASTEXITCODE -ne 0) { Write-Host "Maven build failed"; exit 1 }

# 2. Start watch in a separate window
Start-Process powershell -WindowStyle Hidden -ArgumentList "-ExecutionPolicy", "Bypass", "-Command", "& '$root\fe_hotel\watch.ps1'"

# 3. Start Tomcat
& "$root\tomcat-start.ps1"
