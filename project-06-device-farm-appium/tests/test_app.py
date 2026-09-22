# --------------------------------------------------
# test_app.py — Appium tests for Device Farm
# Tests Android sample app on AWS Device Farm
# Runs with: pytest -v --tb=short
# --------------------------------------------------

import pytest


class TestDeviceFarmApp:
    """Test suite for AWS Device Farm Android sample app."""

    def test_app_config_has_plaform(self, app_config):
        assert app_config["platform"] == "Android"

    def test_app_config_has_region(self, app_config):
        assert app_config["region"] == "us-west-2"

    def test_app_config_has_apk_path(self, app_config):
        assert app_config["app_path"].endswith(".apk")

    def test_device_pool_name(self, app_config):
        assert "android" in app_config["device_pool"].lower()

    def test_app_config_keys(self,app_config):
        expected_keys = ["platform", "app_path", "device_pool", "region"]
        for key in expected_keys:
            assert key in app_config, f"Missing key: {key}"
    