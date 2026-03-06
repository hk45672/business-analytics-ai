# 🐳 DOCKER DEPLOYMENT GUIDE - COMPLETE

## Business Analytics Platform - Docker Deployment

**Status:** ✅ Ready to Deploy  
**Platform:** Docker + Any Host (Free/Low-Cost)  
**Time:** 45 minutes  
**Cost:** Free to $5/month  

---

## 📋 WHAT YOU'LL DEPLOY

- **Backend:** FastAPI running in container
- **Frontend:** React running in container
- **Network:** Containers communicate via Docker network
- **Ports:** Backend on 8000, Frontend on 3000
- **Health Checks:** Automatic service monitoring

---

## 🚀 QUICK START (5 MINUTES)

### Prerequisites
```bash
# Install Docker Desktop
# Windows: https://www.docker.com/products/docker-desktop
# Mac: https://www.docker.com/products/docker-desktop
# Linux: sudo apt-get install docker.io docker-compose
```

### Deploy Locally with Docker Compose
```bash
# Navigate to project directory
cd business-analytics-ai

# Build and start all containers
docker-compose up --build

# Expected output:
# ✅ analytics-backend running on http://localhost:8000
# ✅ analytics-frontend running on http://localhost:3000
```

### Stop Containers
```bash
docker-compose down
```

---

## 🔧 DETAILED SETUP STEPS

### Step 1: Verify Docker Installation
```bash
docker --version
# Expected: Docker version 20.10+

docker-compose --version
# Expected: Docker Compose version 1.29+
```

### Step 2: Build Images
```bash
# Build both backend and frontend images
docker-compose build

# Monitor progress - this takes 5-10 minutes
# ✅ Backend image built
# ✅ Frontend image built
```

### Step 3: Start Services
```bash
# Start in foreground (see logs)
docker-compose up

# OR start in background
docker-compose up -d

# Check status
docker-compose ps
# Shows all running containers
```

### Step 4: Verify Services Running
```bash
# Backend
curl http://localhost:8000/
# Expected: {"status": "running", "message": "..."}

# Frontend
curl http://localhost:3000
# Expected: HTML page

# API Docs
# Open: http://localhost:8000/docs
```

### Step 5: Test Integration
```bash
# Run integration tests (in new terminal)
python integration_test.py

# Expected: 5/5 tests passing ✅
```

---

## 📦 FREE HOSTING OPTIONS

### Option A: Railway (RECOMMENDED - Easiest)
**Cost:** Free tier + $5-20/month  
**Time:** 20 minutes  
**Complexity:** Easy

#### Deploy to Railway:
```bash
# 1. Install Railway CLI
npm install -g @railway/cli

# 2. Login to Railway
railway login

# 3. Create new project
railway init

# 4. Deploy
railway up

# 5. Get your URL
railway open
```

**Railway Benefits:**
- No credit card required for free tier
- Automatic deployments from Git
- Environment variables management
- Database support included
- Real-time logs

### Option B: Render (Free Tier)
**Cost:** Free tier (with limitations) + $12-100/month  
**Time:** 25 minutes  
**Complexity:** Easy

#### Deploy with Docker:
1. Push code to GitHub
2. Connect to Render (https://render.com)
3. Create new Web Service
4. Select Docker runtime
5. Configure environment
6. Deploy

### Option C: Fly.io (Fast, Global)
**Cost:** Free tier + $3-15/month  
**Time:** 30 minutes  
**Complexity:** Medium

```bash
# 1. Install Fly CLI
curl -L https://fly.io/install.sh | sh

# 2. Login
flyctl auth login

# 3. Create app
flyctl launch

# 4. Deploy
flyctl deploy
```

### Option D: Oracle Cloud (Free Tier - Always Free)
**Cost:** Free (2 instances, always)  
**Time:** 45 minutes  
**Complexity:** Medium

```bash
# Access Oracle Cloud free tier
# Includes 2 computing instances permanently free
# Perfect for production deployment
```

### Option E: AWS Free Tier (First Year)
**Cost:** Free for 12 months  
**Time:** 1 hour  
**Complexity:** Medium

```bash
# Use AWS Elastic Container Service (ECS)
# Or AWS Elastic Beanstalk with Docker
```

---

## 🌍 PRODUCTION DEPLOYMENT

### Pre-Production Checklist
```bash
# ✅ Test locally
docker-compose up
python integration_test.py

# ✅ Build images
docker-compose build

# ✅ Push to registry
docker tag analytics-backend your-registry/analytics:backend-v1
docker tag analytics-frontend your-registry/analytics:frontend-v1
docker push your-registry/analytics:backend-v1
docker push your-registry/analytics:frontend-v1
```

### Deploy via Docker Hub (Free)
```bash
# 1. Create Docker Hub account (free)
# https://hub.docker.com/signup

# 2. Login to Docker Hub
docker login

# 3. Tag your images
docker tag backend your-username/analytics-backend:v1.0.0
docker tag frontend your-username/analytics-frontend:v1.0.0

# 4. Push to registry
docker push your-username/analytics-backend:v1.0.0
docker push your-username/analytics-frontend:v1.0.0

# 5. Deploy on target host
# Pull and run on your server using:
# docker-compose -f docker-compose.prod.yml up
```

### Production Docker Compose
```yaml
# docker-compose.prod.yml (optimized)
version: '3.8'

services:
  backend:
    image: your-username/analytics-backend:v1.0.0
    ports:
      - "8000:8000"
    environment:
      - DEBUG=false
      - CORS_ORIGINS=https://yourdomain.com
    restart: always
    
  frontend:
    image: your-username/analytics-frontend:v1.0.0
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=https://api.yourdomain.com
    restart: always
```

---

## 🔐 PRODUCTION SECURITY

### Environment Variables in Production
```bash
# Create .env.production
cat > .env.production << EOF
API_HOST=0.0.0.0
API_PORT=8000
CORS_ORIGINS=https://yourdomain.com
DEBUG=false
LOG_LEVEL=INFO
EOF

# Use in production
docker-compose --env-file .env.production up
```

### SSL/TLS with Let's Encrypt
```yaml
# Add to docker-compose for production
services:
  nginx-proxy:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - backend
      - frontend
```

### Database Backup
```bash
# Regular backups
docker exec analytics-backend tar -czf /backup/data.tar.gz /app/data

# Copy to host
docker cp analytics-backend:/backup/data.tar.gz ./backups/
```

---

## 📊 MONITORING & LOGS

### View Container Logs
```bash
# Backend logs
docker-compose logs backend

# Frontend logs
docker-compose logs frontend

# Follow logs in real-time
docker-compose logs -f backend

# Last 100 lines
docker-compose logs --tail=100 backend
```

### Container Status
```bash
# Check all services
docker-compose ps

# Detailed inspection
docker inspect analytics-backend

# Resource usage
docker stats
```

### Health Checks
```bash
# Automatic health checks run every 30 seconds
# Check status
docker-compose ps

# Both services should show "healthy" status
```

---

## 🆘 TROUBLESHOOTING

### Port Already in Use
```bash
# Find process using port 8000
netstat -ano | findstr :8000  # Windows
lsof -i :8000                  # Mac/Linux

# Kill process
taskkill /PID <PID> /F  # Windows
kill -9 <PID>           # Mac/Linux

# Or change port in docker-compose.yml
ports:
  - "8001:8000"  # Use 8001 instead
```

### Container Won't Start
```bash
# Check logs
docker-compose logs backend

# Common issues:
# - Port already in use
# - Missing environment variables
# - Image build failed
# - Dependencies not installed

# Rebuild
docker-compose down
docker-compose build --no-cache
docker-compose up
```

### Network Connection Issues
```bash
# Verify containers can communicate
docker-compose exec backend curl http://frontend:3000

# Check network
docker network ls
docker network inspect analytics-network
```

### Out of Disk Space
```bash
# Clean up unused images/containers
docker system prune

# Remove all stopped containers
docker container prune

# Remove unused networks
docker network prune
```

---

## 📈 SCALING

### Increase Replicas
```yaml
# Scale backend to 3 instances
services:
  backend:
    deploy:
      replicas: 3
    # Load balancing handled by Docker Compose
```

### Load Balancer Setup
```bash
# Use Docker-compose with Nginx reverse proxy
# Or deploy on Kubernetes for true scaling
```

### Database Persistence
```yaml
# Add volumes for data persistence
volumes:
  backend_data:
    driver: local

services:
  backend:
    volumes:
      - backend_data:/app/data
```

---

## 🚀 DEPLOYMENT CHECKLIST

### Before Deploying to Production
- [ ] All tests pass locally
- [ ] Updated environment variables
- [ ] Set DEBUG=false
- [ ] Configured CORS properly
- [ ] Backed up any existing data
- [ ] DNS is configured (if using domain)
- [ ] SSL certificate ready (if using HTTPS)
- [ ] Monitoring alerts set up
- [ ] Log aggregation configured
- [ ] Backup strategy in place

### After Deploying
- [ ] Test all endpoints
- [ ] Check logs for errors
- [ ] Verify performance metrics
- [ ] Monitor for 24 hours
- [ ] Set up alerting
- [ ] Document deployment
- [ ] Create rollback plan

---

## 🎯 RECOMMENDED DEPLOYMENT PATH

### Step 1: Deploy Locally (15 min)
```bash
# Verify everything works locally
docker-compose up
docker run integration_test.py
```

### Step 2: Deploy to Railway (20 min) - RECOMMENDED
```bash
# Easiest path for beginners
# Free tier available
# No credit card needed initially
```

### Step 3: Scale on Render/Fly.io (30 min)
```bash
# Once comfortable with Docker
# More control over infrastructure
```

### Step 4: Enterprise on AWS/Azure (1-2 hours)
```bash
# For production with high traffic
# Full auto-scaling and monitoring
```

---

## 📚 NEXT STEPS

1. **Verify Docker Installation**
   ```bash
   docker --version
   docker-compose --version
   ```

2. **Test Locally**
   ```bash
   docker-compose up
   python integration_test.py
   ```

3. **Choose Hosting**
   - Railway (recommended for ease)
   - Render (good alternative)
   - Fly.io (fast deployment)
   - Oracle Cloud (free tier)

4. **Deploy**
   - Follow platform-specific guide
   - Set environment variables
   - Verify deployment

5. **Monitor**
   - Check logs
   - Verify endpoints
   - Set up alerts

---

## 🔗 USEFUL RESOURCES

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Guide](https://docs.docker.com/compose/)
- [Railway Docs](https://docs.railway.app)
- [Render Docs](https://render.com/docs)
- [Fly.io Docs](https://fly.io/docs)

---

## ✅ SUCCESS INDICATORS

When deployment is successful, you'll see:
```
✅ Backend running on http://your-domain.com/api
✅ Frontend running on http://your-domain.com
✅ Both connected and communicating
✅ Test results: 5/5 passing
✅ Performance: < 500ms response time
```

---

**Status:** 🎉 Ready to Deploy with Docker!

**Next:** Choose your hosting platform and deploy! 🚀
