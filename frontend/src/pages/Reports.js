import React from "react";

function Reports() {
  const reports = [
    { title: "Monthly Performance Report", date: "June 2026" },
    { title: "Quarterly Business Summary", date: "Q2 2026" },
    { title: "Revenue Trend Analysis", date: "Last 90 Days" }
  ];

  return (
    <div>
      <div className="page-title">Reports</div>

      <div className="grid">
        {reports.map((report, index) => (
          <div key={index} className="card">
            <div style={{ fontSize: "16px", fontWeight: "500" }}>
              {report.title}
            </div>
            <div style={{ fontSize: "13px", color: "#6b7280", marginTop: "6px" }}>
              {report.date}
            </div>
            <div style={{ marginTop: "12px" }}>
              <button className="button">View Report</button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export default Reports;
