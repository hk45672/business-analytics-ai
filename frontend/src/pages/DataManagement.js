import React, { useState } from "react";
import { uploadDataset, analyzeDataset } from "../lib/api";

function DataManagement() {
  const [file, setFile] = useState(null);
  const [uploadStatus, setUploadStatus] = useState("");
  const [uploadData, setUploadData] = useState(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleUpload = async () => {
    if (!file) {
      setUploadStatus("Please select a file first");
      return;
    }

    setIsLoading(true);
    setUploadStatus("Uploading...");

    try {
      const response = await uploadDataset(file);
      setUploadData(response);
      setUploadStatus("✓ Dataset uploaded successfully!");
      console.log("Upload response:", response);
    } catch (error) {
      setUploadStatus(`✗ Upload failed: ${error.message}`);
      console.error("Upload error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleAnalyze = async () => {
    if (!file) {
      setUploadStatus("Please select a file first");
      return;
    }

    setIsLoading(true);
    setUploadStatus("Analyzing...");

    try {
      const response = await analyzeDataset(file);
      setUploadData(response);
      setUploadStatus("✓ Dataset analyzed successfully!");
      console.log("Analysis response:", response);
    } catch (error) {
      setUploadStatus(`✗ Analysis failed: ${error.message}`);
      console.error("Analysis error:", error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div>
      <div className="page-title">Data Management</div>

      <div className="card">
        <div style={{ marginBottom: "16px" }}>
          <h3>Upload CSV File</h3>
          <input
            type="file"
            accept=".csv"
            onChange={(e) => {
              setFile(e.target.files[0]);
              setUploadStatus("");
              setUploadData(null);
            }}
            disabled={isLoading}
          />
        </div>

        <div style={{ marginBottom: "16px" }}>
          <button 
            className="button" 
            onClick={handleUpload}
            disabled={isLoading || !file}
            style={{ marginRight: "8px" }}
          >
            {isLoading ? "Processing..." : "Upload Dataset"}
          </button>
          <button 
            className="button" 
            onClick={handleAnalyze}
            disabled={isLoading || !file}
          >
            {isLoading ? "Processing..." : "Upload & Analyze"}
          </button>
        </div>

        {uploadStatus && (
          <div style={{
            padding: "12px",
            marginTop: "12px",
            backgroundColor: uploadStatus.includes("✗") ? "#fee" : "#efe",
            borderRadius: "4px",
            color: uploadStatus.includes("✗") ? "#c33" : "#3c3"
          }}>
            {uploadStatus}
          </div>
        )}

        {uploadData && (
          <div style={{
            marginTop: "16px",
            padding: "12px",
            backgroundColor: "#f5f5f5",
            borderRadius: "4px",
          }}>
            <h4>Upload Details:</h4>
            <p><strong>Filename:</strong> {uploadData.filename}</p>
            <p><strong>Rows:</strong> {uploadData.rows}</p>
            <p><strong>Columns:</strong> {uploadData.columns?.join(", ")}</p>

            {uploadData.kpis && (
              <div style={{ marginTop: "12px" }}>
                <h4>KPIs:</h4>
                <ul>
                  {uploadData.kpis.map((kpi, idx) => (
                    <li key={idx}>{kpi.name}: {kpi.value}</li>
                  ))}
                </ul>
              </div>
            )}

            {uploadData.insights && (
              <div style={{ marginTop: "12px" }}>
                <h4>Insights:</h4>
                <ul>
                  {uploadData.insights.map((insight, idx) => (
                    <li key={idx}>{insight}</li>
                  ))}
                </ul>
              </div>
            )}
          </div>
        )}
      </div>
    </div>
  );
}

export default DataManagement;
