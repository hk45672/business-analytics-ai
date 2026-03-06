# Business Analytics Platform - System Overview

## Platform Architecture

### Technology Stack

**Backend:**
- Framework: FastAPI (Python)
- Server: Uvicorn
- Data Processing: Pandas, NumPy
- API Format: JSON/REST
- CORS: FastAPI CORSMiddleware

**Frontend:**
- Framework: React 18
- HTTP Client: Fetch API
- Charting: Chart.js with react-chartjs-2
- Styling: CSS
- Build Tool: Create React App

**Database:**
- Currently: In-memory (CSV processing)
- Future: PostgreSQL, MongoDB

### Project Structure

```
business-analytics-ai/
├── backend/                          # Python FastAPI backend
│   ├── main.py                      # Application entry point
│   ├── requirements.txt             # Python dependencies
│   ├── app/
│   │   ├── api/
│   │   │   └── analytics_routes.py # API endpoints
│   │   ├── services/
│   │   │   ├── analytics_engine.py # KPI computation
│   │   │   ├── csv_handler.py      # CSV processing
│   │   │   └── insight_generator.py # Insight generation
│   │   ├── models/
│   │   │   └── schemas.py           # Data models
│   │   ├── utils/
│   │   │   └── logger.py            # Logging utilities
│   │   └── core/
│   │       └── config.py            # Config management
│   └── .env.example                # Environment template
│
├── frontend/                        # React frontend
│   ├── public/
│   ├── src/
│   │   ├── index.js                # Entry point
│   │   ├── App.js                  # Main app component
│   │   ├── components/
│   │   │   ├── layout/
│   │   │   │   └── Sidebar.js      # Navigation
│   │   │   └── shared/
│   │   │       ├── KpiCard.js      # KPI display
│   │   │       └── InsightCard.js  # Insight display
│   │   ├── pages/
│   │   │   ├── Dashboard.js        # Home page
│   │   │   ├── Analytics.js        # Analytics page
│   │   │   ├── DataManagement.js   # Data upload/management
│   │   │   ├── DecisionSupport.js  # Decision tools
│   │   │   └── Reports.js          # Report generation
│   │   └── lib/
│   │       └── api.js              # API client
│   ├── package.json                # NPM dependencies
│   ├── .env.example                # Environment template
│   └── public/index.html           # HTML template
│
├── .vscode/
│   └── settings.json               # VS Code configuration
├── pyproject.toml                  # Pyright & Pylint config
├── .pylintrc                       # Pylint configuration
├── INTEGRATION_GUIDE.md            # Integration documentation
├── TESTING_GUIDE.md                # Testing procedures
├── sample_data.csv                 # Sample CSV for testing
└── README.md                       # Project overview
```

## Key Features

### 1. Data Management
- CSV file upload
- Automatic column detection
- Data validation
- File metadata display

### 2. Analytics
- KPI computation (Total, Average, Growth %)
- Trend analysis
- Insight generation
- Data visualization with Chart.js

### 3. Decision Support
- Decision analysis tools
- Risk assessment (planned)
- Scenario planning (planned)

### 4. Reporting
- Report generation (planned)
- Export functionality (planned)
- Scheduled reports (planned)

## API Specification

### Endpoints

#### 1. Health Check
```
GET /
Response: {"status": "running", "message": "..."}
```

#### 2. Upload File
```
POST /analytics/upload
Content-Type: multipart/form-data
Body: {file: <csv_file>}
Response: {
  filename: string,
  rows: number,
  columns: [string]
}
```

#### 3. Analyze File
```
POST /analytics/analyze
Content-Type: multipart/form-data
Body: {file: <csv_file>}
Response: {
  kpis: [{name: string, value: number}],
  insights: [string]
}
```

## Data Flow

```
User uploads CSV
       ↓
Frontend sends to /analytics/analyze
       ↓
Backend receives file
       ↓
CSV Handler loads and normalizes data
       ↓
Analytics Engine computes KPIs
       ↓
Insight Generator creates insights
       ↓
Response sent back to frontend
       ↓
Frontend displays KPIs and insights
```

## Supported CSV Format

- **Headers:** First row must contain column names
- **Columns:** Any columns are supported
- **Date column:** Optional, detected as "date"
- **Revenue column:** Optional, detected as "revenue"
- **Encoding:** UTF-8
- **Delimiters:** Comma-separated

Example:
```csv
date,revenue,product,region
2024-01-01,1000,Product A,North
2024-01-02,1200,Product B,South
```

## Configuration

### Backend (.env)
```
API_HOST=0.0.0.0
API_PORT=8000
API_RELOAD=true
CORS_ORIGINS=http://localhost:3000,http://localhost:5173
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8000
```

## Development Commands

### Backend
```bash
cd backend
python -m venv .venv
source .venv/Scripts/activate
pip install -r requirements.txt
uvicorn main:app --reload
```

### Frontend
```bash
cd frontend
npm install
npm start
```

### Testing
```bash
# Backend tests (when available)
pytest

# Frontend tests (when available)
npm test
```

## Performance Considerations

- CSV files optimized for < 10MB
- API response time < 500ms
- Frontend load time < 2 seconds
- No database queries (current version)

## Security

- CORS middleware prevents unauthorized requests
- Input validation on file uploads
- Column name sanitization
- No sensitive data exposure
- Environment variables for configuration

## Error Handling

### Backend
- 200: Success
- 400: Bad request (invalid file)
- 500: Server error

### Frontend
- API errors display in UI
- Network errors show in console
- User-friendly error messages

## Roadmap

### Phase 1 (Current)
- ✅ Basic CSV upload
- ✅ KPI computation
- ✅ Insight generation
- ✅ Frontend integration

### Phase 2
- Database integration (PostgreSQL)
- User authentication
- Data persistence
- Advanced filtering

### Phase 3
- Real-time data processing
- Machine learning insights
- Predictive analytics
- Report generation

### Phase 4
- Mobile app
- Advanced visualizations
- API versioning
- Production deployment

## Monitoring & Debugging

### Browser DevTools
- Network tab: Monitor API calls
- Console: Check for JavaScript errors
- Sources: Debug frontend code

### Backend Logs
- Uvicorn logs: Request/response info
- Exception logs: Error tracking

### API Documentation
- Available at: http://localhost:8000/docs
- Generated by Swagger UI

## Contributing

1. Follow code structure
2. Add docstrings to functions
3. Use type hints
4. Test before committing
5. Update documentation

## License

MIT License - See LICENSE file

## Support

Refer to INTEGRATION_GUIDE.md and TESTING_GUIDE.md for setup and troubleshooting.
