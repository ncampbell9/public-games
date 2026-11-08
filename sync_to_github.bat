@echo off
echo Starting Backup to GitHub...
echo.

:: Navigate to the script's directory (the project root)
cd /d "%~dp0"

:: Check if git is available
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Git is not installed or not in your PATH.
    echo Please install Git for Windows.
    pause
    exit /b 1
)

:: Pull latest changes from GitHub before staging local changes
echo Pulling latest changes from GitHub...
git pull origin main
if %errorlevel% neq 0 (
    echo Error: Git pull failed. There may be a conflict that needs manual resolution.
    echo Please resolve any conflicts before running this script again.
    pause
    exit /b 1
)
echo.

:: Get the current date and time for the commit message (DST-aware)
for /f "tokens=*" %%a in ('powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set "commit_message=Auto-sync backup %%a"

echo Staging changes...
git add -A

echo.
echo Committing changes...
git commit -m "%commit_message%"

echo.
echo Pushing to GitHub...
git push -u origin main

echo.
echo =========================================
if %errorlevel% equ 0 (
    echo Backup completed successfully!
) else (
    echo Backup finished, but there might have been issues pushing to GitHub.
    echo Make sure you are logged in to GitHub on this machine.
)
echo =========================================
echo.
pause
