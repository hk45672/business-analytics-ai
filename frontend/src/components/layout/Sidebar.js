import React from "react";

function Sidebar({ activePage, onNavigate }) {
  return (
    <aside className="sidebar">
      <h2 style={{ marginBottom: "24px", fontSize: "18px" }}>
        Business Analytics
      </h2>

      <div
        className={`nav-item ${activePage === "dashboard" ? "active" : ""}`}
        onClick={() => onNavigate("dashboard")}
      >
        Dashboard
      </div>

      <div
        className={`nav-item ${activePage === "analytics" ? "active" : ""}`}
        onClick={() => onNavigate("analytics")}
      >
        Analytics
      </div>

      <div
        className={`nav-item ${activePage === "data" ? "active" : ""}`}
        onClick={() => onNavigate("data")}
      >
        Data Management
      </div>

      <div
        className={`nav-item ${activePage === "decision" ? "active" : ""}`}
        onClick={() => onNavigate("decision")}
      >
        Decision Support
      </div>

      <div
        className={`nav-item ${activePage === "reports" ? "active" : ""}`}
        onClick={() => onNavigate("reports")}
      >
        Reports
      </div>
    </aside>
  );
}

export default Sidebar;
