# --------------------------------------------------
# conftest.py — pytest configuration for Appium tests
# Fixtures shared across all test files
# --------------------------------------------------

import pytest

@pytest.fixture
def app_config():
    """Returns test configuration for Device Farm."""
    return {
        "platform": "Android",
        "app_path": "../apps/app-debug.apk",
        "device_pool": "project6-device-farm-android-pool",
        "region": "us-west-2"
    }