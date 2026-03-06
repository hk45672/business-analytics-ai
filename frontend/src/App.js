import React, { useState } from "react";

import Dashboard from "./pages/Dashboard";
import Analytics from "./pages/Analytics";
import DataManagement from "./pages/DataManagement";
import DecisionSupport from "./pages/DecisionSupport";
import Reports from "./pages/Reports";

import Sidebar from "./components/layout/Sidebar";

import "./index.css";

function App() {
  const [activePage, setActivePage] = useState("dashboard");

  const renderPage = () => {
    switch (activePage) {
      case "analytics":
        return <Analytics />;
      case "data":
        return <DataManagement />;
      case "decision":
        return <DecisionSupport />;
      case "reports":
        return <Reports />;
      default:
        return <Dashboard />;
    }
  };

  return (
    <div className="app-container">
      <Sidebar activePage={activePage} onNavigate={setActivePage} />
      <main className="main-content">{renderPage()}</main>
    </div>
  );
}

export default App;
