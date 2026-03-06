# Integration Testing & Validation Guide

## Quick Start (5-Minute Setup)

### 1. Terminal 1 - Start Backend
```bash
cd backend
source .venv/Scripts/activate  # or .venv\Scripts\Activate.ps1 on Windows
uvicorn main:app --reload --port 8000
```

Expected output:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
INFO:     Application startup complete
```

### 2. Terminal 2 - Start Frontend
```bash
cd frontend
npm start
```

Expected output:
```
Compiled successfully!
Local: http://localhost:3000
```

### 3. Browser Tests

#### Test 1: API Health Check
- Open: `http://localhost:8000/`
- Expected: `{"status": "running", "message": "Business Analytics API is operational"}`

#### Test 2: API Documentation
- Open: `http://localhost:8000/docs`
- Expected: Interactive Swagger UI with endpoints

#### Test 3: Frontend Loads
- Open: `http://localhost:3000`
- Expected: Dashboard page with sidebar navigation

#### Test 4: Data Upload
1. Click "Data Management" in sidebar
2. Choose `sample_data.csv` file
3. Click "Upload Dataset"
4. Expected: File metadata displayed (15 rows, 5 columns)

#### Test 5: Full Analysis
1. Click "Data Management" in sidebar
2. Choose `sample_data.csv` file
3. Click "Upload & Analyze"
4. Expected: KPIs and insights displayed

#### Test 6: Analytics Page
1. Click "Analytics" in sidebar
2. Choose `sample_data.csv` file
3. Click "Analyze"
4. Expected: KPIs displayed in cards and insights in list

## API Endpoint Testing (cURL)

### Test Backend Health
```bash
curl http://localhost:8000/
```

### Test File Upload (using sample_data.csv)
```bash
curl -X POST http://localhost:8000/analytics/upload \
  -F "file=@sample_data.csv"
```

Expected response:
```json
{
  "filename": "sample_data.csv",
  "rows": 15,
  "columns": ["date", "revenue", "product", "region", "quantity"]
}
```

### Test Full Analysis
```bash
curl -X POST http://localhost:8000/analytics/analyze \
  -F "file=@sample_data.csv"
```

Expected response:
```json
{
  "kpis": [
    {"name": "Total Revenue", "value": 20550},
    {"name": "Average Revenue", "value": 1370},
    {"name": "Revenue Growth %", "value": 85}
  ],
  "insights": [
    "Total revenue recorded is 20550",
    "Average revenue per entry is 1370",
    "Revenue shows an upward trend over the period"
  ]
}
```

## Browser Console Testing

### Check API Connection
Open browser console (F12) and run:
```javascript
// Test API health
fetch('http://localhost:8000/')
  .then(r => r.json())
  .then(d => console.log('API Status:', d))
  .catch(e => console.error('Error:', e));
```

### Test Data Upload
```javascript
const file = document.querySelector('input[type="file"]').files[0];
const formData = new FormData();
formData.append('file', file);

fetch('http://localhost:8000/analytics/upload', {
  method: 'POST',
  body: formData
})
.then(r => r.json())
.then(d => console.log('Upload Result:', d))
.catch(e => console.error('Error:', e));
```

## Evaluation Checklist

### Backend Evaluation
- [ ] FastAPI server starts without errors
- [ ] Health check endpoint responds correctly
- [ ] CORS middleware is active
- [ ] CSV upload endpoint works
- [ ] Analysis endpoint returns KPIs
- [ ] Analysis endpoint returns insights
- [ ] Error handling works for invalid files

### Frontend Evaluation
- [ ] React app loads at localhost:3000
- [ ] Sidebar navigation works
- [ ] All pages load without js errors
- [ ] Data Management page loads
- [ ] File input accepts CSV files
- [ ] Upload button calls API (check Network tab)
- [ ] Response data displays correctly
- [ ] Analytics page loads
- [ ] Chart displays with mock data

### Integration Evaluation
- [ ] No CORS errors in browser console
- [ ] API calls show in browser Network tab
- [ ] Response times reasonable (< 2 seconds)
- [ ] Error messages display when API fails
- [ ] File validation works
- [ ] KPIs display correctly
- [ ] Insights display correctly
- [ ] Loading states work properly

## Performance Metrics

### Target Performance
- Backend API response time: < 500ms
- Frontend page load: < 2 seconds
- CSV processing: < 1 second for files < 1MB

### How to Measure
1. Open browser DevTools (F12)
2. Go to Network tab
3. Upload a file
4. Check response time

## Troubleshooting Checklist

### Issue: "Cannot connect to localhost:8000"
- [ ] Backend server is running?
- [ ] Port 8000 not in use by another app
- [ ] Check firewall settings

### Issue: CORS error in console
- [ ] Backend CORS middleware enabled
- [ ] Frontend using correct API URL (http://localhost:8000)
- [ ] Clear browser cache (Ctrl+Shift+Delete)

### Issue: CSV Upload fails
- [ ] File is valid CSV
- [ ] File not empty
- [ ] Column names are lowercase
- [ ] Check browser console for error

### Issue: No data displayed after upload
- [ ] Check Network tab for API response
- [ ] Check for JavaScript errors in console
- [ ] Verify API returns data in expected format

## Next Steps

After successful integration testing:

1. **Deployment:**
   - Build frontend: `npm run build`
   - Deploy to hosting (Vercel, Netlify, etc.)
   - Deploy backend to cloud (Heroku, AWS, Azure, etc.)

2. **Production Setup:**
   - Update API URLs in environment variables
   - Add authentication
   - Set up database
   - Configure production logging

3. **Monitoring:**
   - Set up error tracking (Sentry, etc.)
   - Add performance monitoring
   - Create dashboards for metrics

## Support

- Check browser console (F12) for JavaScript errors
- Check browser Network tab for API calls
- Review INTEGRATION_GUIDE.md for detailed setup
- Check backend logs for server errors
