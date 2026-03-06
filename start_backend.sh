#!/bin/bash
# Start Backend Server on Mac/Linux

echo ""
echo "========================================"
echo "Business Analytics Platform - Backend"
echo "========================================"
echo ""

cd "$(dirname "$0")/backend"

# Check if venv exists
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

# Activate virtual environment
source .venv/bin/activate

# Install dependencies if needed
pip install -q -r requirements.txt

# Start the server
echo ""
echo "Starting FastAPI server on http://localhost:8000"
echo "Press Ctrl+C to stop"
echo ""

uvicorn main:app --reload --host 0.0.0.0 --port 8000
