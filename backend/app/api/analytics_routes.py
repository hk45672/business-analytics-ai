from fastapi import APIRouter, UploadFile, File
from app.services.csv_handler import load_csv
from app.services.analytics_engine import compute_kpis
from app.services.insight_generator import generate_insights
from app.models.schemas import UploadResponse, AnalyticsResult

router = APIRouter(prefix="/analytics", tags=["analytics"])


@router.post("/upload", response_model=UploadResponse)
async def upload_dataset(file: UploadFile = File(...)):
    df = load_csv(file)
    return {
        "filename": file.filename,
        "rows": len(df),
        "columns": list(df.columns),
    }


@router.post("/analyze", response_model=AnalyticsResult)
async def analyze_dataset(file: UploadFile = File(...)):
    df = load_csv(file)
    kpis = compute_kpis(df)
    insights = generate_insights(df)
    return {"kpis": kpis, "insights": insights}
