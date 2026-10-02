from http.server import HTTPServer, SimpleHTTPRequestHandler

class Handler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b'<h1>Project 9 - EKS App by Sagar Yadav</h1><p>Running on Kubernetes</p>')

server = HTTPServer(('0.0.0.0', 3000), Handler)
print('Server running on port 3000')
server.serve_forever()
