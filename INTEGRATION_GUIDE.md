# Business Analytics Platform - Integration Guide

## System Architecture

```
┌─────────────────────────────────────────┐
│         Frontend (React)                 │
│  - Analytics Dashboard                   │
│  - Data Management                       │
│  - Decision Support                      │
│  - Reports & Insights                    │
└────────────────┬────────────────────────┘
                 │ (HTTP Requests)
                 │ (JSON Responses)
                 ▼
┌─────────────────────────────────────────┐
│      Backend API (FastAPI)               │
│  - CORS Enabled                          │
│  - Analytics Routes                      │
│  - CSV Processing                        │
│  - KPI Computation                       │
│  - Insight Generation                    │
└────────────────┬────────────────────────┘
                 │
                 ▼
          CSV Files, Analytics Data
```

## Setup Instructions

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv .venv
   source .venv/Scripts/activate  # Windows
   # or
   source .venv/bin/activate  # Mac/Linux
   ```

3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the backend server:**
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

   Backend will be available at: `http://localhost:8000`
   API documentation: `http://localhost:8000/docs`

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Create .env file:**
   ```bash
   cp .env.example .env
   ```

4. **Run the development server:**
   ```bash
   npm start
   ```

   Frontend will be available at: `http://localhost:3000`

## API Endpoints

### Health Check
- **URL:** `GET /`
- **Response:** `{"status": "running", "message": "Business Analytics API is operational"}`

### Upload Dataset
- **URL:** `POST /analytics/upload`
- **Description:** Upload a CSV file and get metadata
- **Request:** FormData with 'file' field containing CSV
- **Response:**
  ```json
  {
    "filename": "sales_data.csv",
    "rows": 100,
    "columns": ["date", "revenue", "product"]
  }
  ```

### Analyze Dataset
- **URL:** `POST /analytics/analyze`
- **Description:** Upload CSV and receive full analysis with KPIs and insights
- **Request:** FormData with 'file' field containing CSV
- **Response:**
  ```json
  {
    "kpis": [
      {"name": "Total Revenue", "value": 50000.00},
      {"name": "Average Revenue", "value": 500.00},
      {"name": "Revenue Growth %", "value": 25.50}
    ],
    "insights": [
      "Total revenue recorded is 50000.00",
      "Average revenue per entry is 500.00",
      "Revenue shows an upward trend over the period"
    ]
  }
  ```

## Frontend Features

### Pages

1. **Dashboard** - Overview and key metrics
2. **Analytics** - Data analysis and visualization
   - Upload CSV files
   - View KPIs
   - See generated insights
   - Chart visualizations

3. **Data Management** - File upload and processing
   - Upload datasets
   - View file metadata
   - Display KPIs and insights

4. **Decision Support** - Decision making tools
5. **Reports** - Generate and view reports

### API Module (`src/lib/api.js`)

The frontend API module provides three main functions:

```javascript
// Check API health
const isHealthy = await checkAPIHealth();

// Upload and get metadata
const uploadResponse = await uploadDataset(csvFile);

// Upload and get full analysis
const analysisResponse = await analyzeDataset(csvFile);
```

## CSV File Requirements

For optimal analysis, your CSV files should include:

- **Date column** (optional) - For trend analysis (column name: `date`)
- **Revenue column** (optional) - For financial metrics (column name: `revenue`)
- **Other columns** - Any other relevant business metrics

### Example CSV Format:
```
date,revenue,product,region
2024-01-01,1000,Product A,North
2024-01-02,1200,Product B,South
2024-01-03,950,Product A,East
```

## CORS Configuration

The backend is configured to allow requests from:
- `http://localhost:3000` (React development server)
- `http://localhost:5173` (Vite development server)

To add more origins, modify `main.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://your-domain.com", ...],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

## Development Workflow

1. **Start Backend:**
   ```bash
   cd backend
   source .venv/Scripts/activate
   uvicorn main:app --reload
   ```

2. **Start Frontend (in another terminal):**
   ```bash
   cd frontend
   npm start
   ```

3. **Test Integration:**
   - Navigate to Data Management page
   - Upload a CSV file
   - Check browser console for API calls
   - Verify data appears in the UI

## Troubleshooting

### CORS Errors
**Problem:** `Access to XMLHttpRequest blocked by CORS`
**Solution:** Ensure backend is running with CORS middleware and frontend uses correct API URL

### CSV Upload Fails
**Problem:** `Upload failed: error message`
**Solution:** 
- Check CSV format (must be valid CSV with headers)
- Verify file is not empty
- Check browser console for detailed error logs

### API Not Responding
**Problem:** `Cannot connect to API`
**Solution:**
- Verify backend is running: `http://localhost:8000/docs`
- Check frontend `.env` file has correct `REACT_APP_API_URL`
- Ensure ports 8000 (backend) and 3000 (frontend) are not in use

## Performance Optimization Tips

1. **CSV File Size:** Keep CSV files under 10MB for optimal performance
2. **Column Names:** Use lowercase column names with underscores (e.g., `total_revenue`)
3. **Date Format:** Use ISO format dates (YYYY-MM-DD) for consistency

## Security Considerations

- Never commit `.env` files to version control
- Use environment variables for sensitive configuration
- Validate all CSV uploads on the backend
- Implement rate limiting for production
- Add authentication/authorization as needed

## Future Enhancements

- Database integration for persistent data storage
- User authentication and authorization
- Advanced data visualization options
- Real-time data processing
- Email report generation
- Data export in multiple formats (Excel, PDF)
- Scheduled report generation

## Support

For issues or questions, refer to:
- Backend API docs: `http://localhost:8000/docs`
- Frontend component source code comments
- Integration test files
