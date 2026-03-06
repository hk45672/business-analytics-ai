import React from "react";
import KpiCard from "../components/shared/KpiCard";
import InsightCard from "../components/shared/InsightCard";

function Dashboard() {
  const kpis = [
    { title: "Total Revenue", value: "$1.24M" },
    { title: "Monthly Growth", value: "6.8%" },
    { title: "Top Product", value: "Product A" },
    { title: "Active Regions", value: "5" }
  ];

  const insights = [
    "Revenue increased steadily over the last quarter",
    "Product A contributes the highest share of revenue",
    "Region North shows consistent growth",
    "Marketing campaigns improved conversion rate"
  ];

  return (
    <div>
      <div className="page-title">Dashboard Overview</div>

      <div className="grid">
        {kpis.map((kpi, index) => (
          <KpiCard key={index} title={kpi.title} value={kpi.value} />
        ))}
      </div>

      <div style={{ marginTop: "24px" }}>
        <div className="page-title">Key Insights</div>
        <div className="grid">
          {insights.map((text, index) => (
            <InsightCard key={index} text={text} />
          ))}
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
