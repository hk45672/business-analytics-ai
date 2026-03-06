import React, { useState } from "react";
import { Line } from "react-chartjs-2";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Tooltip,
  Legend
} from "chart.js";
import { analyzeDataset } from "../lib/api";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Tooltip,
  Legend
);

function Analytics() {
  const [file, setFile] = useState(null);
  const [analysisData, setAnalysisData] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState("");

  const handleFileChange = (e) => {
    setFile(e.target.files[0]);
    setError("");
  };

  const handleAnalyze = async () => {
    if (!file) {
      setError("Please select a CSV file");
      return;
    }

    setIsLoading(true);
    setError("");

    try {
      const result = await analyzeDataset(file);
      setAnalysisData(result);
    } catch (err) {
      setError(`Failed to analyze file: ${err.message}`);
    } finally {
      setIsLoading(false);
    }
  };

  // Mock chart data (can be replaced with data from file once backend processes it)
  const mockData = {
    labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
    datasets: [
      {
        label: "Revenue",
        data: [120, 150, 180, 210, 240, 300],
        borderColor: "#2563eb",
        backgroundColor: "rgba(37, 99, 235, 0.2)"
      }
    ]
  };

  const options = {
    responsive: true,
    plugins: {
      legend: {
        position: "top"
      }
    }
  };

  return (
    <div>
      <div className="page-title">Analytics</div>

      <div className="card" style={{ marginBottom: "16px" }}>
        <h3>Upload Data for Analysis</h3>
        <input
          type="file"
          accept=".csv"
          onChange={handleFileChange}
          disabled={isLoading}
        />
        <button
          className="button"
          onClick={handleAnalyze}
          disabled={isLoading || !file}
          style={{ marginLeft: "8px" }}
        >
          {isLoading ? "Analyzing..." : "Analyze"}
        </button>

        {error && (
          <div style={{
            marginTop: "12px",
            padding: "12px",
            backgroundColor: "#fee",
            color: "#c33",
            borderRadius: "4px"
          }}>
            {error}
          </div>
        )}
      </div>

      {analysisData ? (
        <div>
          <div className="card" style={{ marginBottom: "16px" }}>
            <h3>Key Performance Indicators</h3>
            {analysisData.kpis && analysisData.kpis.length > 0 ? (
              <div style={{ display: "grid", gridTemplateColumns: "repeat(2, 1fr)", gap: "12px" }}>
                {analysisData.kpis.map((kpi, idx) => (
                  <div
                    key={idx}
                    style={{
                      padding: "12px",
                      backgroundColor: "#f5f5f5",
                      borderRadius: "4px",
                      borderLeft: "4px solid #2563eb"
                    }}
                  >
                    <div style={{ fontSize: "12px", color: "#666" }}>{kpi.name}</div>
                    <div style={{ fontSize: "24px", fontWeight: "bold", color: "#2563eb" }}>
                      {kpi.value}
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p>No KPIs available</p>
            )}
          </div>

          <div className="card" style={{ marginBottom: "16px" }}>
            <h3>Insights</h3>
            {analysisData.insights && analysisData.insights.length > 0 ? (
              <ul style={{ paddingLeft: "20px" }}>
                {analysisData.insights.map((insight, idx) => (
                  <li key={idx} style={{ marginBottom: "8px" }}>{insight}</li>
                ))}
              </ul>
            ) : (
              <p>No insights generated</p>
            )}
          </div>
        </div>
      ) : (
        <div className="card">
          <Line data={mockData} options={options} />
        </div>
      )}
    </div>
  );
}

export default Analytics;
