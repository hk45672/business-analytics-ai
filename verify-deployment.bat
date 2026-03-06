@echo off
REM Pre-Deployment Verification Script
REM Checks that your project is ready for Railway deployment

cls
color 0A
echo.
echo ==========================================
echo  PRE-DEPLOYMENT VERIFICATION CHECKLIST
echo  Business Analytics Platform
echo ==========================================
echo.

setlocal enabledelayedexpansion
set errors=0
set warnings=0

REM Function to check file and report
set PASS=[✓]
set FAIL=[✗]

echo CHECKING PROJECT STRUCTURE...
echo.

REM Check Docker files
if exist docker-compose.yml (
    echo %PASS% docker-compose.yml exists
) else (
    echo %FAIL% docker-compose.yml MISSING
    set /a errors=!errors!+1
)

if exist backend\Dockerfile (
    echo %PASS% backend/Dockerfile exists
) else (
    echo %FAIL% backend/Dockerfile MISSING
    set /a errors=!errors!+1
)

if exist frontend\Dockerfile (
    echo %PASS% frontend/Dockerfile exists
) else (
    echo %FAIL% frontend/Dockerfile MISSING
    set /a errors=!errors!+1
)

echo.
echo CHECKING BACKEND...
echo.

if exist backend\requirements.txt (
    echo %PASS% backend/requirements.txt exists
) else (
    echo %FAIL% backend/requirements.txt MISSING
    set /a errors=!errors!+1
)

if exist backend\main.py (
    echo %PASS% backend/main.py exists
) else (
    echo %FAIL% backend/main.py MISSING
    set /a errors=!errors!+1
)

if exist backend\app (
    echo %PASS% backend/app directory exists
) else (
    echo %FAIL% backend/app directory MISSING
    set /a errors=!errors!+1
)

echo.
echo CHECKING FRONTEND...
echo.

if exist frontend\package.json (
    echo %PASS% frontend/package.json exists
) else (
    echo %FAIL% frontend/package.json MISSING
    set /a errors=!errors!+1
)

if exist frontend\src (
    echo %PASS% frontend/src directory exists
) else (
    echo %FAIL% frontend/src directory MISSING
    set /a errors=!errors!+1
)

if exist frontend\public (
    echo %PASS% frontend/public directory exists
) else (
    echo %FAIL% frontend/public directory MISSING
    set /a errors=!errors!+1
)

echo.
echo CHECKING DEVELOPMENT TOOLS...
echo.

git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo %PASS% Git is installed
    git --version | find /v ""
) else (
    echo %FAIL% Git is NOT installed
    set /a errors=!errors!+1
)

echo.
echo CHECKING GIT REPOSITORY...
echo.

if exist .git (
    echo %PASS% Git repository initialized
    git status >nul 2>&1
    if %errorlevel% equ 0 (
        echo %PASS% Git status OK
        git log -1 --pretty=format:"  Last commit: %%h - %%s" 2>nul
    ) else (
        echo %FAIL% Git repository corrupted
        set /a errors=!errors!+1
    )
) else (
    echo %PASS% Git repository NOT initialized (will do during deployment)
    set /a warnings=!warnings!+1
)

git remote -v >nul 2>&1
if %errorlevel% equ 0 (
    echo %PASS% GitHub remote configured
    for /f "tokens=*" %%a in ('git remote get-url origin 2^>nul') do (
        echo   Remote: %%a
    )
) else (
    echo %PASS% GitHub remote NOT configured (will do during deployment)
    set /a warnings=!warnings!+1
)

echo.
echo ==========================================
echo  VERIFICATION SUMMARY
echo ==========================================
echo.

if %errors% equ 0 (
    echo [SUCCESS] Your project is ready for deployment!
    echo.
    echo Next steps:
    echo 1. If Git not initialized, run: deploy-railway.bat (option 2)
    echo 2. If GitHub not configured, run: deploy-railway.bat (option 3)
    echo 3. Push code to GitHub: deploy-railway.bat (option 4)
    echo 4. Go to https://railway.app and create new project
    echo 5. Deploy from your GitHub repository
) else (
    echo [ERROR] Your project has %errors% missing file(s)
    echo.
    echo Please fix these issues before deploying:
    echo 1. Check that you're in the correct directory
    echo 2. Verify all files exist (see FAIL items above)
    echo 3. For missing files, check BACKUP or restore from git
)

if %warnings% gtr 0 (
    echo.
    echo [WARNING] %warnings% item(s) need setup (see below)
    echo These will be done automatically during deployment
)

echo.
echo ==========================================
echo.

if %errors% equ 0 (
    echo Are you ready to deploy?
    echo.
    echo Option 1: Quick Setup
    echo   - Run: deploy-railway.bat
    echo   - Follow the menu
    echo.
    echo Option 2: Manual Setup  
    echo   - Read: RAILWAY_QUICK_START.md
    echo   - Follow step-by-step
    echo.
    echo Option 3: Detailed Setup
    echo   - Read: RAILWAY_DEPLOYMENT.md
    echo   - Complete guide with troubleshooting
    echo.
)

pause
