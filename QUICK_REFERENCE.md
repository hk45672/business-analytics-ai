# Business Analytics Platform - Quick Reference

## 🚀 Start Development (60 seconds)

### Terminal 1: Backend
```bash
cd backend
source .venv/Scripts/activate  # Windows: .venv\Scripts\Activate.ps1
uvicorn main:app --reload
```
→ Backend: `http://localhost:8000`

### Terminal 2: Frontend
```bash
cd frontend
npm start
```
→ Frontend: `http://localhost:3000`

---

## 📌 Key Endpoints

| Endpoint | Request | Response |
|----------|---------|----------|
| `GET /` | - | `{status: "running"}` |
| `POST /analytics/upload` | CSV file | `{filename, rows, columns}` |
| `POST /analytics/analyze` | CSV file | `{kpis, insights}` |
| `GET /docs` | - | Swagger UI |

---

## 🔗 Frontend-Backend Flow

```
User Action (Upload File)
    ↓
Frontend calls API: POST /analytics/analyze
    ↓
Backend receives, processes CSV
    ↓
Analytics Engine computes KPIs
    ↓
Insight Generator creates insights
    ↓
Response with {kpis, insights}
    ↓
Frontend displays results
```

---

## 🛠️ Common Commands

| Task | Command |
|------|---------|
| Install backend deps | `pip install -r backend/requirements.txt` |
| Install frontend deps | `npm install` (in frontend dir) |
| Run backend | `uvicorn main:app --reload` |
| Run frontend | `npm start` |
| View API docs | `http://localhost:8000/docs` |
| Test upload | Upload `sample_data.csv` via frontend |

---

## 📁 Important Files

| File | Purpose |
|------|---------|
| `backend/main.py` | FastAPI app & CORS |
| `frontend/src/lib/api.js` | API client |
| `frontend/src/pages/DataManagement.js` | Upload page |
| `frontend/src/pages/Analytics.js` | Analytics page |
| `sample_data.csv` | Test data |
| `INTEGRATION_GUIDE.md` | Setup guide |
| `TESTING_GUIDE.md` | Test procedures |

---

## ⚙️ Configuration

### Backend (.env)
```
API_HOST=0.0.0.0
API_PORT=8000
CORS_ORIGINS=http://localhost:3000
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8000
```

---

## 🔍 Debugging

| Issue | Solution |
|-------|----------|
| CORS Error | Check CORS middleware in `main.py` |
| API 404 | Verify backend is running on port 8000 |
| Upload fails | Check CSV format, verify column names |
| No API response | Check browser Network tab (F12) |
| Module not found | Run `pip install -r requirements.txt` |

---

## 📊 API Response Examples

### Upload Response
```json
{
  "filename": "data.csv",
  "rows": 100,
  "columns": ["date", "revenue", "product"]
}
```

### Analysis Response
```json
{
  "kpis": [
    {"name": "Total Revenue", "value": 50000},
    {"name": "Average Revenue", "value": 500},
    {"name": "Revenue Growth %", "value": 25.5}
  ],
  "insights": ["Total revenue recorded is 50000", "Revenue shows upward trend"]
}
```

---

## 📚 Documentation

- **Full Setup:** INTEGRATION_GUIDE.md
- **Testing:** TESTING_GUIDE.md
- **Platform Info:** PLATFORM_OVERVIEW.md
- **Integration Status:** INTEGRATION_REPORT.md

---

## 🎯 Workflow

1. **Start both servers** (see above)
2. **Open frontend:** http://localhost:3000
3. **Navigate to:** Data Management or Analytics
4. **Upload CSV:** Use sample_data.csv
5. **View results:** KPIs and insights display

---

## ✅ Quick Checklist

- [ ] Python venv activated
- [ ] Backend dependencies installed
- [ ] Frontend dependencies installed
- [ ] Backend running on :8000
- [ ] Frontend running on :3000
- [ ] No CORS errors in console
- [ ] Sample CSV file selected
- [ ] Upload/Analysis working

---

## 📞 Help

- **Health Check:** `curl http://localhost:8000/`
- **API Docs:** http://localhost:8000/docs
- **Console Logs:** Press F12 in browser
- **Network Tab:** F12 → Network → Upload file → Check response

---

## 🚢 Before Deployment

- [ ] Build frontend: `npm run build`
- [ ] Update API URLs for production
- [ ] Add authentication
- [ ] Set up database
- [ ] Configure environment variables
- [ ] Run security checks
- [ ] Test with production data

---

**Keep this handy! ⭐**
