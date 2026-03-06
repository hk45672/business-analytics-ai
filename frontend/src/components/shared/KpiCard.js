import React from "react";

function KpiCard({ title, value }) {
  return (
    <div className="card">
      <div style={{ fontSize: "14px", color: "#6b7280", marginBottom: "6px" }}>
        {title}
      </div>
      <div style={{ fontSize: "22px", fontWeight: "600" }}>{value}</div>
    </div>
  );
}

export default KpiCard;
