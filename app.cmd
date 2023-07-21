@echo off
cls
REM Set the console size to 150 columns and 80 lines
mode con: cols=100 lines=60
mode con: cols=100 lines=60 & mode con: move /M 0 0

echo Checking whether the script is already running as administrator...
net session >nul 2>&1
if %errorlevel% == 0 ( goto runMain ) 
else (
    echo Attempting to elevate privileges...
    >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
    if %errorlevel% neq 0 (
        echo This script requires administrator rights. Please run the script as an administrator.
        goto end
    ) 
    else ( goto runMain )
)

:runMain
echo Running as administrator
:: Set the execution policy and unblock the required PowerShell script
powershell -NoLogo -NoProfile -Command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force; ls -Recurse *.ps*1 | Unblock-File"
:: Launch main.ps1 and wait for it to finish
powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0interface\app.ps1"

:end