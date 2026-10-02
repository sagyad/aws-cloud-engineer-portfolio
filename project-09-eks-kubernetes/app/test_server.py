# -----------------------------------------------
# Tests for Flask app — Project 9
# -----------------------------------------------
import pytest

def test_app_file_exists():
    import os
    assert os.path.exists("server.py"), "server.py not found"

def test_dockerfile_exsits():
    import os
    assert os.path.exists("Dockerfile"), "Dockerfile not found"

def test_flask_import():
    from flask import Flask
    assert Flask is not None

def test_app_creates():
    from server import app
    assert app is not None

def test_health_endpoint():
    from server import app
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200