@echo off
echo Syncing Latest Changes from GitHub...
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

:: Pull latest changes from GitHub
echo Pulling latest changes from GitHub...
git pull origin main

echo.
echo =========================================
if %errorlevel% equ 0 (
    echo Sync completed successfully! You are up to date.
) else (
    echo Sync failed. There may be a conflict that needs manual resolution.
    echo Please resolve any conflicts before continuing to work.
)
echo =========================================
echo.
pause
