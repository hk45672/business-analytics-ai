# ⚡ RAILWAY QUICK START (5 MINUTES)

## The Fastest Way to Deploy

### ✅ Prerequisites (Check First)
```bash
git --version          # Must be installed
cd your-project-folder
ls docker-compose.yml  # Must exist
```

### 🚀 Step 1: Git Setup (2 min)
```bash
# Initialize Git (if not done)
git init
git add .
git commit -m "Initial commit"

# Create GitHub account at https://github.com (free)
# Then create empty repo named "business-analytics-ai"

# Add GitHub remote
git remote add origin https://github.com/YOUR_USERNAME/business-analytics-ai.git
git branch -M main
git push -u origin main
```

### 🎯 Step 2: Deploy on Railway (3 min)
1. Go to **https://railway.app/signup**
2. Sign up with GitHub (easiest)
3. Click **"New Project"**
4. Click **"Deploy from GitHub"**
5. Select your **business-analytics-ai** repo
6. Click **"Deploy"**

**WAIT** (5-10 minutes for build)

### ⚙️ Step 3: Configure Environment Variables
1. In Railway dashboard, click **backend** service
2. Go to **"Variables"** tab
3. Search for or add: `CORS_ORIGINS`
4. Set value: `https://YOUR-FRONTEND-DOMAIN.railway.app`
5. Save (auto-redeploy)

### 🔗 Step 4: Link Frontend to Backend
1. Click **frontend** service
2. Go to **"Variables"** tab
3. Add: `REACT_APP_API_URL=https://YOUR-BACKEND-DOMAIN.railway.app`
4. Save

### ✨ Step 5: You're Done!
Get your URLs from Railway dashboard:
- Frontend running at: `https://xxx.railway.app`
- Backend API at: `https://yyy.railway.app`
- API docs at: `https://yyy.railway.app/docs`

---

## 🆘 Common Issues

| Problem | Solution |
|---------|----------|
| **Can't find GitHub account** | Create at https://github.com/signup |
| **Can't push to GitHub** | Enter credentials when prompted, or use SSH keys |
| **Frontend blank page** | Check REACT_APP_API_URL, must start with `https://` |
| **CORS errors** | Update CORS_ORIGINS in backend variables to include frontend URL |
| **Build failed** | Check Rails logs, common: missing dependencies in requirements.txt |
| **Slow deployment** | Normal on free tier, takes 5-10 minutes for full build |

---

## 📊 After Deploy

**Test your app:**
```bash
# Open in browser
https://your-frontend.railway.app

# Upload a CSV file to test integration
# Check that data appears in dashboard
```

**Check everything works:**
```bash
# Backend health check
curl https://your-backend.railway.app/

# API documentation
https://your-backend.railway.app/docs
```

---

## 🎉 Success Indicators
- ✅ Frontend loads without errors
- ✅ No CORS errors in browser console
- ✅ Can upload CSV file
- ✅ Data displays in dashboard
- ✅ Response time < 2 seconds

---

**🎓 For detailed steps, see: RAILWAY_DEPLOYMENT.md**
