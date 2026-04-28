@echo off
REM fe_hotel Build & Tomcat Deploy Script

set "PROJECT_DIR=%~dp0"
pushd "%PROJECT_DIR%.."
set "ROOT_DIR=%CD%"
popd
set "MVN=%ROOT_DIR%\apache-maven-3.9.6\bin\mvn.cmd"
set "TOMCAT_DIR=%ROOT_DIR%\tomcat"
set CATALINA_HOME=%TOMCAT_DIR%
set WAR_NAME=fe_hotel

echo === fe_hotel Build Start ===
cd /d "%PROJECT_DIR%"
call "%MVN%" clean package -DskipTests
if %ERRORLEVEL% neq 0 (
    echo Build Failed!
    exit /b 1
)
echo === Build Complete ===

REM Stop Tomcat
echo === Stopping Tomcat ===
call "%TOMCAT_DIR%\bin\shutdown.bat" 2>nul
timeout /t 2 /nobreak >nul

REM Remove old deployment & copy WAR
echo === Deploying WAR ===
if exist "%TOMCAT_DIR%\webapps\%WAR_NAME%" rd /s /q "%TOMCAT_DIR%\webapps\%WAR_NAME%"
if exist "%TOMCAT_DIR%\webapps\%WAR_NAME%.war" del "%TOMCAT_DIR%\webapps\%WAR_NAME%.war"
copy "%PROJECT_DIR%target\%WAR_NAME%-1.0.0.war" "%TOMCAT_DIR%\webapps\%WAR_NAME%.war"

REM Start Tomcat
echo === Starting Tomcat ===
call "%TOMCAT_DIR%\bin\startup.bat"

echo.
echo fe_hotel Deploy Complete! http://localhost:8080/%WAR_NAME%
