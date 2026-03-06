#!/bin/bash
# Start Frontend Server on Mac/Linux

echo ""
echo "========================================"
echo "Business Analytics Platform - Frontend"
echo "========================================"
echo ""

cd "$(dirname "$0")/frontend"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Start the server
echo ""
echo "Starting React development server on http://localhost:3000"
echo "Press Ctrl+C to stop"
echo ""

npm start
