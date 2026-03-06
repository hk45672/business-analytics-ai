#!/bin/bash
# Docker Deployment Quick Start - Mac/Linux

echo ""
echo "========================================"
echo "  Business Analytics - Docker Deploy"
echo "========================================"
echo ""

# Check Docker installation
echo "1. Checking Docker installation..."

if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker not installed!"
    echo "Download from: https://www.docker.com/products/docker-desktop"
    exit 1
fi
echo "✓ Docker found: $(docker --version)"

if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose not installed!"
    exit 1
fi
echo "✓ Docker Compose found: $(docker-compose --version)"
echo ""

# Option menu
echo "2. Choose an option:"
echo ""
echo "[1] Run Locally (docker-compose up)"
echo "[2] Build Images Only"
echo "[3] Push to Docker Hub"
echo "[4] View Logs"
echo "[5] Stop Containers"
echo "[6] Clean Up"
echo ""

read -p "Enter your choice (1-6): " choice

case $choice in
    1)
        echo ""
        echo "Starting containers..."
        docker-compose up --build
        ;;
    2)
        echo ""
        echo "Building images..."
        docker-compose build
        echo "✓ Images built successfully"
        ;;
    3)
        echo ""
        read -p "Enter Docker Hub username: " username
        echo "Tagging images for Docker Hub..."
        docker tag analytics-backend $username/analytics-backend:v1.0.0
        docker tag analytics-frontend $username/analytics-frontend:v1.0.0
        echo ""
        echo "Pushing to Docker Hub..."
        docker push $username/analytics-backend:v1.0.0
        docker push $username/analytics-frontend:v1.0.0
        echo "✓ Images pushed to Docker Hub"
        ;;
    4)
        echo ""
        read -p "Show logs for (backend/frontend/all)?: " service
        if [ "$service" = "backend" ]; then
            docker-compose logs -f backend
        elif [ "$service" = "frontend" ]; then
            docker-compose logs -f frontend
        else
            docker-compose logs -f
        fi
        ;;
    5)
        echo ""
        echo "Stopping containers..."
        docker-compose down
        echo "✓ Containers stopped"
        ;;
    6)
        echo ""
        echo "WARNING: This will remove all images and containers!"
        read -p "Continue (yes/no)?: " confirm
        if [ "$confirm" = "yes" ]; then
            docker-compose down --rmi all
            docker system prune -f
            echo "✓ Cleanup complete"
        fi
        ;;
    *)
        echo "Invalid choice"
        ;;
esac

echo ""
echo "Done!"
echo ""
