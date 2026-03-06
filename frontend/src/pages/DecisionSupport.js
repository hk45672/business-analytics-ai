import React, { useState } from "react";

function DecisionSupport() {
  const [scenario, setScenario] = useState("");
  const [result, setResult] = useState(null);

  const runAnalysis = () => {
    if (!scenario) return;
    setResult(
      "Based on historical data, this scenario shows moderate upside with manageable risk."
    );
  };

  return (
    <div>
      <div className="page-title">Decision Support</div>

      <div className="card">
        <input
          type="text"
          value={scenario}
          onChange={(e) => setScenario(e.target.value)}
          placeholder="Describe a scenario"
          style={{ width: "100%", padding: "8px" }}
        />
        <div style={{ marginTop: "12px" }}>
          <button className="button" onClick={runAnalysis}>
            Run Analysis
          </button>
        </div>
        {result && (
          <div style={{ marginTop: "16px", fontSize: "14px" }}>{result}</div>
        )}
      </div>
    </div>
  );
}

export default DecisionSupport;
