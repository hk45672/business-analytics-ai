@echo off
REM Start Frontend Server on Windows

echo.
echo ========================================
echo Business Analytics Platform - Frontend
echo ========================================
echo.

cd /d "%~dp0frontend"

REM Check if node_modules exists
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install
)

REM Start the server
echo.
echo Starting React development server on http://localhost:3000
echo Press Ctrl+C to stop
echo.

call npm start

pause
