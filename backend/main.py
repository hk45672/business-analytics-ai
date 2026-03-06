"""Business Analytics Platform - FastAPI Backend Application.

Provides REST API endpoints for data analysis, KPI computation,
and business insights generation.
"""
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.analytics_routes import router as analytics_router

app = FastAPI(
    title="Business Analytics Platform",
    version="1.0.0",
    description="Backend API for business analytics and insights"
)

# Add CORS middleware to allow frontend requests
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(analytics_router)

@app.get("/")
def health_check():
    """Health check endpoint to verify API is running.
    
    Returns:
        dict: Status information with running state and message
    """
    return {"status": "running", "message": "Business Analytics API is operational"}
