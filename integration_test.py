#!/usr/bin/env python3
"""Integration Testing & Performance Monitoring Script.

Tests frontend-backend integration and monitors API performance.
"""
import sys
import time
from pathlib import Path
from typing import Dict, List

import requests

# Configuration
BACKEND_URL = "http://localhost:8000"
FRONTEND_URL = "http://localhost:3000"
SAMPLE_CSV = "sample_data.csv"

class IntegrationTester:
    """Test suite for frontend-backend integration."""

    def __init__(self):
        """Initialize tester with results storage."""
        self.results: List[Dict] = []
        self.start_time = None

    def test_backend_health(self) -> bool:
        """Test backend API health endpoint."""
        print("\n🔍 Testing Backend Health...", end=" ")
        try:
            start = time.time()
            response = requests.get(f"{BACKEND_URL}/")
            duration = time.time() - start

            if response.status_code == 200:
                print(f"✅ OK ({duration*1000:.0f}ms)")
                self._log_result("Backend Health", True, duration)
                return True
            print(f"❌ Failed (Status: {response.status_code})")
            self._log_result("Backend Health", False, duration)
            return False
        except requests.RequestException as e:
            print(f"❌ Error: {str(e)}")
            self._log_result("Backend Health", False, 0)
            return False

    def test_api_docs(self) -> bool:
        """Test API documentation endpoint."""
        print("🔍 Testing API Docs...", end=" ")
        try:
            start = time.time()
            response = requests.get(f"{BACKEND_URL}/docs")
            duration = time.time() - start

            if response.status_code == 200:
                print(f"✅ OK ({duration*1000:.0f}ms)")
                self._log_result("API Docs", True, duration)
                return True
            print("❌ Failed")
            self._log_result("API Docs", False, duration)
            return False
        except requests.RequestException as e:
            print(f"❌ Error: {str(e)}")
            self._log_result("API Docs", False, 0)
            return False

    def test_csv_upload(self) -> bool:
        """Test CSV upload endpoint."""
        print("🔍 Testing CSV Upload...", end=" ")
        try:
            if not Path(SAMPLE_CSV).exists():
                print("⚠️  Sample CSV not found")
                return False

            with open(SAMPLE_CSV, 'rb') as f:
                files = {'file': f}
                start = time.time()
                response = requests.post(
                    f"{BACKEND_URL}/analytics/upload", files=files
                )
                duration = time.time() - start

            if response.status_code == 200:
                data = response.json()
                rows = data['rows']
                print(f"✅ OK ({duration*1000:.0f}ms) - {rows} rows")
                self._log_result("CSV Upload", True, duration)
                return True
            print(f"❌ Failed (Status: {response.status_code})")
            self._log_result("CSV Upload", False, duration)
            return False
        except (requests.RequestException, OSError, KeyError) as e:
            print(f"❌ Error: {str(e)}")
            self._log_result("CSV Upload", False, 0)
            return False

    def test_analysis(self) -> bool:
        """Test data analysis endpoint."""
        print("🔍 Testing Data Analysis...", end=" ")
        try:
            if not Path(SAMPLE_CSV).exists():
                print("⚠️  Sample CSV not found")
                return False

            with open(SAMPLE_CSV, 'rb') as f:
                files = {'file': f}
                start = time.time()
                response = requests.post(
                    f"{BACKEND_URL}/analytics/analyze", files=files
                )
                duration = time.time() - start

            if response.status_code == 200:
                data = response.json()
                kpis_count = len(data.get('kpis', []))
                insights_count = len(data.get('insights', []))
                msg = (
                    f"✅ OK ({duration*1000:.0f}ms) - "
                    f"{kpis_count} KPIs, {insights_count} insights"
                )
                print(msg)
                self._log_result("Data Analysis", True, duration)
                return True
            print(f"❌ Failed (Status: {response.status_code})")
            self._log_result("Data Analysis", False, duration)
            return False
        except (requests.RequestException, OSError, KeyError) as e:
            print(f"❌ Error: {str(e)}")
            self._log_result("Data Analysis", False, 0)
            return False

    def test_cors(self) -> bool:
        """Test CORS configuration."""
        print("🔍 Testing CORS...", end=" ")
        try:
            headers = {'Origin': FRONTEND_URL}
            start = time.time()
            response = requests.get(f"{BACKEND_URL}/", headers=headers)
            duration = time.time() - start

            if 'access-control-allow-origin' in response.headers:
                print("✅ OK - CORS enabled")
                self._log_result("CORS", True, duration)
                return True
            print("⚠️  CORS header missing")
            self._log_result("CORS", False, duration)
            return False
        except requests.RequestException as e:
            print(f"❌ Error: {str(e)}")
            self._log_result("CORS", False, 0)
            return False

    def _log_result(self, test_name: str, passed: bool, duration: float) -> None:
        """Log test result."""
        self.results.append({
            "test": test_name,
            "passed": passed,
            "duration_ms": duration * 1000
        })

    def print_summary(self) -> bool:
        """Print test summary.

        Returns:
            bool: True if all tests passed, False otherwise.
        """
        total = len(self.results)
        passed = sum(1 for r in self.results if r["passed"])

        print("\n" + "="*60)
        print("📊 INTEGRATION TEST SUMMARY")
        print("="*60)

        for result in self.results:
            status = "✅" if result["passed"] else "❌"
            test_name = result['test']
            duration = result['duration_ms']
            print(f"{status} {test_name:<25} {duration:>8.0f}ms")

        print("-"*60)
        print(f"Total: {passed}/{total} tests passed")
        print("="*60)

        # Performance metrics
        avg_duration = sum(r["duration_ms"] for r in self.results) / len(
            self.results
        )
        print("\n⚡ Performance Metrics:")
        print(f"   Average Response Time: {avg_duration:.0f}ms")
        if avg_duration < 300:
            status_msg = "✅ EXCELLENT"
        elif avg_duration < 500:
            status_msg = "⚠️  GOOD"
        else:
            status_msg = "❌ SLOW"
        print(f"   Status: {status_msg}")

        return passed == total

def main() -> int:
    """Run integration tests.

    Returns:
        int: 0 if all tests passed, 1 otherwise.
    """
    print("\n" + "="*60)
    print("🚀 BUSINESS ANALYTICS PLATFORM - INTEGRATION TESTING")
    print("="*60)
    print(f"\nBackend URL: {BACKEND_URL}")
    print(f"Frontend URL: {FRONTEND_URL}")

    tester = IntegrationTester()

    # Check backend availability
    print("\n" + "="*60)
    print("BACKEND TESTS")
    print("="*60)

    tests = [
        tester.test_backend_health,
        tester.test_api_docs,
        tester.test_cors,
        tester.test_csv_upload,
        tester.test_analysis,
    ]

    for test in tests:
        test()
        time.sleep(0.5)

    # Print summary
    success = tester.print_summary()

    # Additional information
    print("\n" + "="*60)
    print("📚 USEFUL LINKS")
    print("="*60)
    print(f"✨ Frontend:    {FRONTEND_URL}")
    print(f"🔌 API:         {BACKEND_URL}")
    print(f"📖 API Docs:    {BACKEND_URL}/docs")
    print(f"📄 Sample CSV:  {SAMPLE_CSV}")

    print("\n" + "="*60)
    print("🎯 NEXT STEPS")
    print("="*60)
    print("1. Open http://localhost:3000 in browser")
    print("2. Navigate to Data Management")
    print("3. Upload sample_data.csv")
    print("4. View KPIs and insights")

    return 0 if success else 1

if __name__ == "__main__":
    sys.exit(main())
