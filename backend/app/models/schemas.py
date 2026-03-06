"""Data models and schemas for API requests and responses."""
from typing import List, Optional

from pydantic import BaseModel


class UploadResponse(BaseModel):
    """Response model for file upload operations."""

    filename: str
    rows: int
    columns: List[str]


class KPI(BaseModel):
    """Key Performance Indicator model."""

    name: str
    value: float


class AnalyticsResult(BaseModel):
    """Analytics computation results model."""

    kpis: List[KPI]
    insights: List[str]


class DecisionRequest(BaseModel):
    """Request model for decision support analysis."""

    scenario: str


class DecisionResponse(BaseModel):
    """Response model for decision support output."""

    summary: str
    risk_level: Optional[str] = None
