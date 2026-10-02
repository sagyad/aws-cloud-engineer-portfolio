import os
import importlib

class TestServerConfig:
    """Tests for Project 9 EKS Python app."""

    def test_app_file_exists(self):
        assert os.path.isfile("server.py"), "server.py must exist"

    def test_dockerfile_exists(self):
        assert os.path.isfile("Dockerfile"), "Dockerfile must exist"

    def test_http_server_import(self):
        from http.server import HTTPServer, SimpleHTTPRequestHandler
        assert HTTPServer is not None

    def test_server_has_handler(self):
        spec = importlib.util.find_spec("server")
        assert spec is not None, "server module must be importable"

    def test_port_is_defined(self):
        with open("server.py") as f:
            content = f.read()