import pandas as pd
from typing import List


def generate_insights(df: pd.DataFrame) -> List[str]:
    insights = []

    if "revenue" in df.columns:
        total = df["revenue"].sum()
        avg = df["revenue"].mean()

        insights.append(f"Total revenue recorded is {round(total, 2)}")
        insights.append(f"Average revenue per entry is {round(avg, 2)}")

        if len(df) > 1:
            first = df["revenue"].iloc[0]
            last = df["revenue"].iloc[-1]
            if last > first:
                insights.append("Revenue shows an upward trend over the period")
            elif last < first:
                insights.append("Revenue shows a downward trend over the period")
            else:
                insights.append("Revenue remained stable over the period")

    return insights
