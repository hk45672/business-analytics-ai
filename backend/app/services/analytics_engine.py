"""Analytics engine for computing KPIs and metrics from data."""
from typing import List

import pandas as pd

from app.models.schemas import KPI


def compute_kpis(df: pd.DataFrame) -> List[KPI]:
    """Compute key performance indicators from a DataFrame.
    
    Args:
        df: Input DataFrame with financial data
        
    Returns:
        List of computed KPI objects
    """
    kpis = []

    if "revenue" in df.columns:
        total_revenue = float(df["revenue"].sum())
        kpis.append(KPI(name="Total Revenue", value=round(total_revenue, 2)))

        avg_revenue = float(df["revenue"].mean())
        kpis.append(KPI(name="Average Revenue", value=round(avg_revenue, 2)))

    if "date" in df.columns and "revenue" in df.columns:
        df_sorted = df.sort_values("date")
        if len(df_sorted) > 1:
            growth = (
                (df_sorted["revenue"].iloc[-1] - df_sorted["revenue"].iloc[0])
                / max(df_sorted["revenue"].iloc[0], 1)
            ) * 100
            kpis.append(KPI(name="Revenue Growth %", value=round(growth, 2)))

    return kpis
