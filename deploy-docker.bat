@echo off
REM Docker Deployment Quick Start - Windows

echo.
echo ========================================
echo   Business Analytics - Docker Deploy
echo ========================================
echo.

REM Check Docker installation
echo 1. Checking Docker installation...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker not installed!
    echo Download from: https://www.docker.com/products/docker-desktop
    pause
    exit /b 1
)
echo ✓ Docker found

docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker Compose not installed!
    pause
    exit /b 1
)
echo ✓ Docker Compose found
echo.

REM Option menu
echo 2. Choose an option:
echo.
echo [1] Run Locally (docker-compose up)
echo [2] Build Images Only
echo [3] Push to Docker Hub
echo [4] View Logs
echo [5] Stop Containers
echo [6] Clean Up
echo.

set /p choice="Enter your choice (1-6): "

if "%choice%"=="1" (
    echo.
    echo Starting containers...
    docker-compose up --build
    goto end
)

if "%choice%"=="2" (
    echo.
    echo Building images...
    docker-compose build
    echo ✓ Images built successfully
    goto end
)

if "%choice%"=="3" (
    echo.
    set /p username="Enter Docker Hub username: "
    echo Tagging images for Docker Hub...
    docker tag analytics-backend %username%/analytics-backend:v1.0.0
    docker tag analytics-frontend %username%/analytics-frontend:v1.0.0
    echo.
    docker push %username%/analytics-backend:v1.0.0
    docker push %username%/analytics-frontend:v1.0.0
    echo ✓ Images pushed to Docker Hub
    goto end
)

if "%choice%"=="4" (
    echo.
    set /p service="Show logs for (backend/frontend/all)?: "
    if "%service%"=="backend" (
        docker-compose logs -f backend
    ) else if "%service%"=="frontend" (
        docker-compose logs -f frontend
    ) else (
        docker-compose logs -f
    )
    goto end
)

if "%choice%"=="5" (
    echo.
    echo Stopping containers...
    docker-compose down
    echo ✓ Containers stopped
    goto end
)

if "%choice%"=="6" (
    echo.
    echo WARNING: This will remove all images and containers!
    set /p confirm="Continue (yes/no)?: "
    if "%confirm%"=="yes" (
        docker-compose down --rmi all
        docker system prune -f
        echo ✓ Cleanup complete
    )
    goto end
)

echo Invalid choice
goto end

:end
echo.
echo Done!
echo.
pause
