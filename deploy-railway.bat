@echo off
REM Railway Deployment Helper Script for Windows
REM This script helps you deploy to Railway quickly

setlocal enabledelayedexpansion

cls
color 0A
echo.
echo ========================================
echo  Railway Deployment Helper
echo  Business Analytics Platform
echo ========================================
echo.

:MENU
echo.
echo Select an action:
echo.
echo 1. Prerequisites Check (Git, Docker)
echo 2. Initialize Git Repository
echo 3. Create GitHub Remote
echo 4. Push Code to GitHub
echo 5. Check Railway CLI Status
echo 6. View Project Status
echo 7. View Logs
echo 8. Open Railway Dashboard
echo 9. Exit
echo.
set /p choice="Enter your choice (1-9): "

if "%choice%"=="1" goto CHECK_PREREQUISITES
if "%choice%"=="2" goto INIT_GIT
if "%choice%"=="3" goto CREATE_REMOTE
if "%choice%"=="4" goto PUSH_CODE
if "%choice%"=="5" goto CHECK_RAILWAY
if "%choice%"=="6" goto VIEW_STATUS
if "%choice%"=="7" goto VIEW_LOGS
if "%choice%"=="8" goto OPEN_DASHBOARD
if "%choice%"=="9" goto EXIT

echo Invalid choice, please try again.
timeout /t 2 >nul
goto MENU

:CHECK_PREREQUISITES
cls
echo.
echo ===== CHECKING PREREQUISITES =====
echo.

REM Check Git
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Git is installed
    git --version
) else (
    echo [ERROR] Git is NOT installed
    echo Please install from: https://git-scm.com/download/win
)

REM Check Docker
docker --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Docker is installed
    docker --version
) else (
    echo [WARNING] Docker is NOT installed
    echo This is only needed for local testing
    echo Install from: https://www.docker.com/products/docker-desktop
)

REM Check important files
echo.
echo ===== CHECKING PROJECT FILES =====
echo.

if exist docker-compose.yml (
    echo [OK] docker-compose.yml found
) else (
    echo [ERROR] docker-compose.yml NOT found
)

if exist backend\Dockerfile (
    echo [OK] backend/Dockerfile found
) else (
    echo [ERROR] backend/Dockerfile NOT found
)

if exist frontend\Dockerfile (
    echo [OK] frontend/Dockerfile found
) else (
    echo [ERROR] frontend/Dockerfile NOT found
)

if exist backend\requirements.txt (
    echo [OK] backend/requirements.txt found
) else (
    echo [ERROR] backend/requirements.txt NOT found
)

if exist frontend\package.json (
    echo [OK] frontend/package.json found
) else (
    echo [ERROR] frontend/package.json NOT found
)

echo.
echo ===== NEXT STEPS =====
echo 1. If Git is missing, install it from git-scm.com
echo 2. If files are missing, check your project directory
echo 3. Once everything is OK, use option 2 to initialize Git
echo.
pause
goto MENU

:INIT_GIT
cls
echo.
echo ===== INITIALIZING GIT REPOSITORY =====
echo.

git init
git add .
git config user.name "Business Analytics Developer"
git config user.email "developer@analytics.local"

echo Committing initial files...
git commit -m "Initial commit - Business Analytics Platform v1.0.0"

echo.
echo [SUCCESS] Git repository initialized!
echo.
echo Next steps:
echo 1. Create account at https://github.com/signup if you don't have one
echo 2. Create a new repository named 'business-analytics-ai'
echo 3. Use option 3 to add the GitHub remote
echo.
pause
goto MENU

:CREATE_REMOTE
cls
echo.
echo ===== ADDING GITHUB REMOTE =====
echo.
echo.
set /p github_user="Enter your GitHub username: "
set /p repo_name="Enter repository name (default: business-analytics-ai): "

if "!repo_name!"=="" set repo_name=business-analytics-ai

set remote_url=https://github.com/!github_user!/!repo_name!.git

echo Adding remote: !remote_url!
git remote add origin !remote_url!

echo.
echo [SUCCESS] GitHub remote added!
echo.
echo Next steps:
echo 1. Make sure repository exists on GitHub: https://github.com/!github_user!/!repo_name!
echo 2. Use option 4 to push your code
echo.
pause
goto MENU

:PUSH_CODE
cls
echo.
echo ===== PUSHING CODE TO GITHUB =====
echo.

REM Check if remote exists
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] GitHub remote not configured
    echo Use option 3 to add GitHub remote first
    pause
    goto MENU
)

echo Setting up branch to main...
git branch -M main

echo Pushing code to GitHub...
echo (Enter your GitHub credentials when prompted)
echo.
git push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Code pushed to GitHub!
    echo.
    echo Next steps:
    echo 1. Create account at https://railway.app
    echo 2. Sign in with GitHub
    echo 3. Create new project
    echo 4. Deploy from your GitHub repository
    echo.
) else (
    echo.
    echo [ERROR] Failed to push code
    echo Check your GitHub credentials and try again
    echo.
)

pause
goto MENU

:CHECK_RAILWAY
cls
echo.
echo ===== RAILWAY PROJECT STATUS =====
echo.
echo Opening Railway dashboard...
echo Please check deployment status at: https://railway.app/dashboard
echo.
start https://railway.app/dashboard
timeout /t 2 >nul
goto MENU

:VIEW_STATUS
cls
echo.
echo ===== PROJECT STATUS =====
echo.
echo Your deployment URLs:
echo.
echo Frontend:  https://your-frontend.railway.app
echo Backend:   https://your-backend.railway.app
echo API Docs:  https://your-backend.railway.app/docs
echo.
echo Replace 'your-frontend' and 'your-backend' with your actual Railway URLs
echo (You'll see these in Railway dashboard after deployment)
echo.
pause
goto MENU

:VIEW_LOGS
cls
echo.
echo ===== VIEWING LOGS =====
echo.
echo To view logs, go to Railway dashboard:
echo 1. Open: https://railway.app/dashboard
echo 2. Select your project
echo 3. Click on service (backend or frontend)
echo 4. Click "Deployments"
echo 5. Select active deployment
echo 6. View logs
echo.
start https://railway.app/dashboard
timeout /t 2 >nul
goto MENU

:OPEN_DASHBOARD
cls
echo.
echo ===== OPENING RAILWAY DASHBOARD =====
echo.
start https://railway.app/dashboard
echo Dashboard opened in your browser
timeout /t 3 >nul
goto MENU

:EXIT
cls
echo.
echo ===== DEPLOYMENT GUIDE =====
echo.
echo Follow these steps:
echo.
echo 1. Prerequisites Check (Option 1)
echo    - Ensure Git is installed
echo    - All project files present
echo.
echo 2. Initialize Git (Option 2)
echo    - Creates local Git repository
echo    - Commits your code
echo.
echo 3. Create GitHub Remote (Option 3)
echo    - Links to your GitHub repository
echo    - Create repo on GitHub first!
echo.
echo 4. Push Code (Option 4)
echo    - Uploads code to GitHub
echo    - Required for Railway deployment
echo.
echo 5. Deploy on Railway
echo    - Go to https://railway.app
echo    - Click "New Project"
echo    - Select "Deploy from GitHub"
echo    - Choose your repository
echo    - Click "Deploy"
echo.
echo 6. Configure and Monitor
echo    - Set environment variables
echo    - View logs in Railway dashboard
echo    - Test deployed app
echo.
echo For detailed guide, see RAILWAY_DEPLOYMENT.md
echo.
pause
exit /b 0
