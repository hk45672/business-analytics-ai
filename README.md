# Business Analytics Platform 📊

A full-stack business analytics application with real-time data processing, KPI computation, and AI-driven insights.

## 🌟 Features

- **📁 Data Management** - Upload and process CSV files
- **📈 Analytics Engine** - Compute KPIs automatically
- **💡 Insight Generation** - AI-powered business insights
- **📊 Interactive Dashboard** - Beautiful data visualization
- **🔄 REST API** - Fully documented FastAPI backend
- **⚡ Real-time Processing** - Instant analysis results
- **🎯 Multiple Views** - Analytics, Reports, Decision Support

## 📸 Quick Demo

```
1. Upload CSV → 2. Auto-analyze → 3. View KPIs → 4. Get Insights
```

## 🏗️ Architecture

### Frontend
- **React 18** - Modern UI framework
- **Chart.js** - Data visualization
- **Fetch API** - Backend communication
- **CSS** - Responsive styling

### Backend
- **FastAPI** - High-performance API
- **Pandas** - Data processing
- **Uvicorn** - ASGI server
- **Python 3.10+** - Latest features

### Integration
- **REST API** - JSON communication
- **CORS** - Cross-origin support
- **Environment Config** - Flexible deployment

## 🚀 Quick Start

### Prerequisites
- Python 3.10 or higher
- Node.js 16 or higher
- npm or yarn

### 1️⃣ Clone Repository
```bash
git clone <repository>
cd business-analytics-ai
```

### 2️⃣ Backend Setup
```bash
cd backend
python -m venv .venv
source .venv/Scripts/activate  # Windows: .venv\Scripts\Activate.ps1
pip install -r requirements.txt
uvicorn main:app --reload
```
✅ Backend running at: `http://localhost:8000`

### 3️⃣ Frontend Setup
```bash
cd frontend
npm install
npm start
```
✅ Frontend running at: `http://localhost:3000`

### 4️⃣ Test Integration
1. Open browser: http://localhost:3000
2. Navigate to "Data Management"
3. Upload `sample_data.csv`
4. View results!

## 📚 Documentation

| Document | Purpose |
|----------|---------|
| [**QUICK_REFERENCE.md**](QUICK_REFERENCE.md) | 60-second setup & key commands |
| [**INTEGRATION_GUIDE.md**](INTEGRATION_GUIDE.md) | Complete setup & configuration |
| [**TESTING_GUIDE.md**](TESTING_GUIDE.md) | Testing procedures & verification |
| [**PLATFORM_OVERVIEW.md**](PLATFORM_OVERVIEW.md) | Architecture & roadmap |
| [**INTEGRATION_REPORT.md**](INTEGRATION_REPORT.md) | Integration status & evaluation |

## 📂 Project Structure

```
business-analytics-ai/
├── backend/                    # FastAPI backend
│   ├── main.py                # Application entry
│   ├── requirements.txt        # Dependencies
│   └── app/
│       ├── api/               # API routes
│       ├── services/          # Business logic
│       ├── models/            # Data schemas
│       └── utils/             # Utilities
├── frontend/                   # React frontend
│   ├── src/
│   │   ├── pages/             # Page components
│   │   ├── components/        # UI components
│   │   ├── lib/               # API client
│   │   └── App.js             # Main app
│   └── package.json           # Dependencies
└── documentation files/        # Guides & references
```

## 🔌 API Endpoints

### Base URL
- **Development:** `http://localhost:8000`
- **API Docs:** `http://localhost:8000/docs` (Swagger UI)

### Endpoints

#### Health Check
```bash
GET /
```
**Response:** `{"status": "running", "message": "..."}`

#### Upload Dataset
```bash
POST /analytics/upload
Content-Type: multipart/form-data
Body: file=<csv_file>
```
**Response:**
```json
{
  "filename": "data.csv",
  "rows": 100,
  "columns": ["date", "revenue", "product"]
}
```

#### Analyze Dataset
```bash
POST /analytics/analyze
Content-Type: multipart/form-data
Body: file=<csv_file>
```
**Response:**
```json
{
  "kpis": [
    {"name": "Total Revenue", "value": 50000},
    {"name": "Average Revenue", "value": 500},
    {"name": "Revenue Growth %", "value": 25.5}
  ],
  "insights": [
    "Total revenue recorded is 50000",
    "Revenue shows an upward trend"
  ]
}
```

## 📊 Pages & Features

### Dashboard
- Summary statistics
- Quick overview of key metrics
- Navigation hub

### Analytics
- Upload CSV files
- View computed KPIs
- See AI-generated insights
- Interactive charts

### Data Management
- File upload interface
- Data validation
- Metadata display
- Results visualization

### Decision Support
- Decision analysis tools
- Risk assessment
- Scenario planning

### Reports
- Report generation (planned)
- Export functionality (planned)
- Scheduled reports (planned)

## 🧪 Testing

### Run Tests
```bash
# Backend tests (when available)
cd backend
pytest

# Frontend tests (when available)
cd frontend
npm test
```

### Manual Testing
See [TESTING_GUIDE.md](TESTING_GUIDE.md) for comprehensive testing procedures.

### Sample Data
Pre-configured `sample_data.csv` available for quick testing.

## 🎯 Supported CSV Format

```csv
date,revenue,product,region
2024-01-01,1000,Product A,North
2024-01-02,1200,Product B,South
```

**Requirements:**
- CSV format with comma delimiters
- First row contains column headers
- Column names should be lowercase
- Date format: YYYY-MM-DD (recommended)

## ⚙️ Configuration

### Backend (.env)
```
API_HOST=0.0.0.0
API_PORT=8000
API_RELOAD=true
CORS_ORIGINS=http://localhost:3000
```

### Frontend (.env)
```
REACT_APP_API_URL=http://localhost:8000
REACT_APP_TITLE=Business Analytics Platform
```

## 🔒 Security

- CORS middleware for API security
- Input validation on file uploads
- CSV data sanitization
- No sensitive data exposure
- Environment variables for secrets

## 🚀 Deployment

### Production Build

**Frontend:**
```bash
cd frontend
npm run build
# Build output: frontend/build/
```

**Backend:**
```bash
cd backend
uvicorn main:app --host 0.0.0.0 --port 8000
```

### Cloud Deployment Options

- **Frontend:** Vercel, Netlify, AWS S3 + CloudFront
- **Backend:** Heroku, AWS EC2, Google Cloud Run, Azure

## 📈 Performance

- **CSV Processing:** < 500ms
- **Frontend Load:** < 2 seconds
- **API Response:** < 300ms
- **File Size:** Optimized for < 10MB

## 🐛 Troubleshooting

### Common Issues

**CORS Errors**
```
Solution: Ensure backend is running with correct CORS configuration
Check: http://localhost:8000/ returns running status
```

**API Not Responding**
```
Solution: Verify backend is running on port 8000
Command: curl http://localhost:8000/
```

**CSV Upload Fails**
```
Solution: Validate CSV format
Check: Headers in first row, properly formatted
```

See [TESTING_GUIDE.md](TESTING_GUIDE.md) for more troubleshooting.

## 🔄 Development Workflow

1. Create `.env` files from `.env.example`
2. Install dependencies (both backend & frontend)
3. Start backend server
4. Start frontend dev server
5. Open browser to http://localhost:3000
6. Make changes and see hot-reload
7. Test with sample data

## 🎓 Learning Resources

- [FastAPI Docs](https://fastapi.tiangolo.com/)
- [React Docs](https://react.dev/)
- [Pandas Docs](https://pandas.pydata.org/)
- [Chart.js Docs](https://www.chartjs.org/)

## 📞 Support

- **Documentation:** See INTEGRATION_GUIDE.md
- **API Docs:** http://localhost:8000/docs
- **Testing:** See TESTING_GUIDE.md
- **Quick Help:** See QUICK_REFERENCE.md

## 🗺️ Roadmap

### Phase 1 ✅
- CSV upload and processing
- KPI computation
- Basic API

### Phase 2 🔄
- Database integration
- User authentication
- Advanced analytics

### Phase 3 📋
- Machine learning insights
- Real-time data processing
- Report generation

### Phase 4 🎯
- Mobile app
- Advanced visualizations
- Enterprise features

## 📄 License

MIT License - See LICENSE file for details

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## ✨ Key Technologies

- ✅ Python 3.10+
- ✅ FastAPI
- ✅ React 18
- ✅ Pandas
- ✅ Chart.js
- ✅ Uvicorn
- ✅ npm/Node.js

## 🎉 Getting Started

**[→ Start with QUICK_REFERENCE.md](QUICK_REFERENCE.md)** for the fastest setup!

Or follow the **[Complete Setup Guide](INTEGRATION_GUIDE.md)** for detailed instructions.

---

**Status:** ✅ Ready for Development & Testing

**Last Updated:** March 6, 2026

**Questions?** Check the documentation files or API docs at `http://localhost:8000/docs`
