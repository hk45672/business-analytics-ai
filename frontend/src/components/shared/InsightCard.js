import React from "react";

function InsightCard({ text }) {
  return (
    <div className="card">
      <div style={{ fontSize: "14px", lineHeight: "1.4" }}>{text}</div>
    </div>
  );
}

export default InsightCard;
