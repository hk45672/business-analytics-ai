// API configuration
const API_BASE_URL = process.env.REACT_APP_API_URL || "http://localhost:8000";

/**
 * Health check endpoint
 */
export const checkAPIHealth = async () => {
  try {
    const response = await fetch(`${API_BASE_URL}/`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
      },
    });
    return response.ok;
  } catch (error) {
    console.error("API health check failed:", error);
    return false;
  }
};

/**
 * Upload a CSV file for analysis
 * @param {File} file - The CSV file to upload
 * @returns {Promise<Object>} Upload response with filename, rows, and columns
 */
export const uploadDataset = async (file) => {
  try {
    const formData = new FormData();
    formData.append("file", file);

    const response = await fetch(`${API_BASE_URL}/analytics/upload`, {
      method: "POST",
      body: formData,
    });

    if (!response.ok) {
      throw new Error(`Upload failed: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Upload error:", error);
    throw error;
  }
};

/**
 * Analyze a CSV file and get KPIs and insights
 * @param {File} file - The CSV file to analyze
 * @returns {Promise<Object>} Analysis result with KPIs and insights
 */
export const analyzeDataset = async (file) => {
  try {
    const formData = new FormData();
    formData.append("file", file);

    const response = await fetch(`${API_BASE_URL}/analytics/analyze`, {
      method: "POST",
      body: formData,
    });

    if (!response.ok) {
      throw new Error(`Analysis failed: ${response.statusText}`);
    }

    return await response.json();
  } catch (error) {
    console.error("Analysis error:", error);
    throw error;
  }
};

export default {
  checkAPIHealth,
  uploadDataset,
  analyzeDataset,
};