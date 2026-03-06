@echo off
REM Start Backend Server on Windows

echo.
echo ========================================
echo Business Analytics Platform - Backend
echo ========================================
echo.

cd /d "%~dp0backend"

REM Check if venv exists
if not exist ".venv" (
    echo Creating virtual environment...
    python -m venv .venv
)

REM Activate virtual environment
call .venv\Scripts\activate.bat

REM Install dependencies if needed
pip install -q -r requirements.txt

REM Start the server
echo.
echo Starting FastAPI server on http://localhost:8000
echo Press Ctrl+C to stop
echo.

uvicorn main:app --reload --host 0.0.0.0 --port 8000

pause
