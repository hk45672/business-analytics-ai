# 🆘 TROUBLESHOOTING & QUICK HELP

## ⚡ QUICK FIXES (Most Common Issues)

### Issue 1: Backend Won't Start - "Address Already in Use"
```
Error: OSError: [Errno 48] Address already in use
Port 8000 is occupied by another process
```

**Fix (Windows):**
```bash
# Find what's using port 8000
netstat -ano | findstr :8000

# Kill the process (replace<PID> with the actual ID)
taskkill /PID <PID> /F

# Try starting backend again
cd backend && uvicorn main:app --reload
```

**Fix (Mac/Linux):**
```bash
# Find process
lsof -i :8000

# Kill it
kill -9 <PID>
```

---

### Issue 2: Frontend Won't Start - "Port 3000 in Use"
```
Error: Something is already listening on port 3000
```

**Fix (Windows):**
```bash
# Find process on port 3000
netstat -ano | findstr :3000

# Kill it
taskkill /PID <PID> /F

# Try starting frontend again
cd frontend && npm start
```

---

### Issue 3: CORS Error in Browser Console
```
Error: Access to XMLHttpRequest blocked by CORS policy
No 'Access-Control-Allow-Origin' header
```

**Checklist:**
```
1. Backend is running? ✓ Check: http://localhost:8000/
2. Backend has CORS middleware? ✓ Check main.py has @app.add_middleware(CORSMiddleware...)
3. Backend restarted? ✓ Stop and :8000 and restart
4. Browser cache cleared? ✓ Press Ctrl+Shift+Delete
5. Correct API URL? ✓ Check frontend .env has REACT_APP_API_URL=http://localhost:8000
```

---

### Issue 4: CSV Upload Fails - "Invalid File"
```
Error: Upload failed: Bad Request
File validation error
```

**Check CSV File:**
```
✓ First row has column headers
✓ Headers are lowercase and underscored: revenue, product_name, region
✓ File is comma-separated (not tab or semicolon)
✓ File is not empty
✓ File encoding is UTF-8

Try: Use sample_data.csv that's included in the project
```

---

### Issue 5: "Failed to Fetch" or Network Error
```
Error: Failed to fetch resource from http://localhost:8000/analytics/upload
```

**Checklist:**
```
1. Backend running? ✓ http://localhost:8000/ should work
2. Frontend API URL correct? ✓ Check .env file
3. Using http not https? ✓ Should be http://localhost
4. Firewall blocking? ✓ Check Windows Defender firewall
5. VPN/Proxy? ✓ Try disabling VPN
```

---

### Issue 6: "Module Not Found" Error
```
ModuleNotFoundError: No module named 'pandas'
```

**Fix (Backend):**
```bash
cd backend
pip install -r requirements.txt
```

**Fix (Frontend):**
```bash
cd frontend
npm install
```

---

## 🔍 DIAGNOSTIC COMMANDS

### Check if Backend is Running
```bash
# Should work and return JSON
curl http://localhost:8000/
```

### Check if Frontend is Running
```bash
# Should return HTML
curl http://localhost:3000/
```

### Check if Python is Installed
```bash
python --version  # Should be 3.10+
```

### Check if Node is Installed
```bash
node --version    # Should be 16+
npm --version     # Should be 8+
```

### Check Open Ports
```bash
# Windows
netstat -ano | findstr :8000
netstat -ano | findstr :3000

# Mac/Linux
lsof -i :8000
lsof -i :3000
```

---

## 📋 FULL DIAGNOSTIC CHECKLIST

Run through these in order:

```
1. Can I start Backend?
   → cd backend && uvicorn main:app --reload
   → Expected: "Uvicorn running on http://0.0.0.0:8000"

2. Can I access Backend health?
   → curl http://localhost:8000/
   → Expected: {"status": "running", ...}

3. Can I access API Docs?
   → http://localhost:8000/docs in browser
   → Expected: Swagger UI appears

4. Can I start Frontend?
   → cd frontend && npm start
   → Expected: "Compiled successfully!"

5. Can I access Frontend?
   → http://localhost:3000 in browser
   → Expected: Dashboard loads

6. Are there Console Errors?
   → Press F12 in browser
   → Check Console tab
   → Expected: No red error messages

7. Do API Calls Work?
   → Press F12 → Network tab
   → Upload a CSV file
   → Expected: Request shown with status 200

8. Do Results Display?
   → After upload completes
   → Expected: KPIs and insights appear in UI
```

---

## 🛠️ RESET & RESTART

### Full Clean Start

**If everything is broken, try this:**

```bash
# Terminal 1: Backend Reset
cd backend
# Stop backend (Ctrl+C if running)
rm -rf .venv
python -m venv .venv
.venv\Scripts\activate  # Windows: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --reload

# Terminal 2: Frontend Reset
cd frontend
# Stop frontend (Ctrl+C if running)
rm -rf node_modules
npm install
npm start
```

---

## 🔧 ADVANCED DEBUGGING

### Enable Debug Logging (Backend)

Edit `backend/main.py`:
```python
import logging
logging.basicConfig(level=logging.DEBUG)
```

### Check Network Tab Details (Frontend)

Press F12 in browser:
1. Go to Network tab
2. Select the failed request
3. Click "Response" to see error message
4. Click "Request" to see what was sent
5. Check "Headers" for CORS headers

### Check API Response

```bash
# Upload with verbose output
curl -v -X POST http://localhost:8000/analytics/upload \
  -F "file=@sample_data.csv"

# Look for:
# - Response status (should be 200)
# - CORS headers (should have Access-Control-Allow-Origin)
# - Response body (should have JSON data)
```

---

## 💡 TIPS & TRICKS

### Clear Browser Cache
```
Windows: Ctrl+Shift+Delete
Mac: Cmd+Shift+Delete
```

### Force Refresh
```
Windows: Ctrl+F5 or Ctrl+Shift+R
Mac: Cmd+Shift+R
```

### Check Running Processes
```bash
# See all running Python processes
tasklist | findstr python

# See all running Node processes
tasklist | findstr node
```

### Kill Stubborn Processes
```bash
# Windows - Force kill all Python
taskkill /F /IM python.exe

# Windows - Force kill all Node
taskkill /F /IM node.exe
```

---

## 📞 SUPPORT RESOURCES

| Issue | Document | Solution |
|-------|----------|----------|
| How to start? | INTEGRATION_SETUP.md | Step-by-step guide |
| Port conflicts? | This document | Quick fixes section |
| Testing? | TESTING_GUIDE.md | Test procedures |
| Architecture? | PLATFORM_OVERVIEW.md | System design |
| All questions? | README.md | Main documentation |

---

## ✅ VERIFICATION: EVERYTHING WORKS IF...

```
✅ Backend shows "Uvicorn running on http://0.0.0.0:8000"
✅ Frontend shows "Compiled successfully!"
✅ http://localhost:8000/ returns JSON status
✅ http://localhost:3000 shows dashboard
✅ Browser console has no red errors
✅ Uploading CSV file shows results
✅ KPIs and insights display in UI
✅ Network requests show status 200
```

---

## 🎯 NEXT STEPS

### If All Checks Pass
1. Run `python integration_test.py`
2. All tests should pass
3. You're ready to deploy!

### If Tests Fail
1. Run diagnostic commands above
2. Check specific error message
3. Refer to fixes in "Quick Fixes" section
4. Try "Reset & Restart" if needed

---

## 📞 STILL HAVING ISSUES?

Use this debugging workflow:

```
1. What is the exact error message?
   → Write it down

2. When does it occur?
   → Backend start / Frontend start / File upload / Display

3. What have you tried?
   → Record fixes attempted

4. Check relevant section above:
   → Quick Fixes (common issues)
   → Diagnostic Commands (verify setup)
   → Advanced Debugging (deep dive)

5. Review related documentation:
   → INTEGRATION_SETUP.md
   → TESTING_GUIDE.md
   → README.md
```

---

## 🚀 FINAL CHECKLIST BEFORE DEPLOYMENT

- [ ] Backend health check passes
- [ ] Frontend loads without errors
- [ ] CSV upload works
- [ ] Data analysis returns KPIs and insights
- [ ] No CORS errors in console
- [ ] Integration test passes (python integration_test.py)
- [ ] Performance meets targets (< 500ms per request)
- [ ] All documentation reviewed
- [ ] Ready for production

---

**You've got this!** 💪

If you're stuck:
1. Check "Quick Fixes" above
2. Run diagnostic commands
3. Review related documentation
4. Reset & restart if needed

**Good luck!** 🍀
