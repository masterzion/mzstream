import SimpleHTTPServer
import SocketServer
import os
import sys

if len(sys.argv) > 1:
    PORT = int(sys.argv[1])
else:
    PORT = 8082

os.chdir("web")

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_len = int(self.headers.getheader('content-length', 0))
        post_body = self.rfile.read(content_len)
        if post_body == "0":
            os.remove("run.txt")
            self.send_response(200)
        else:
            file1 = open("config.json","w")
            post_body = post_body.replace("{", "\n{\n")
            post_body = post_body.replace("}", "\n}\n")
            post_body = post_body.replace(",", ",\n")

            file1.write(post_body)
            file1.close()

            file1 = open("run.txt","w")
            file1.write("1")
            file1.close()
            self.send_response(200)


Handler = ServerHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print ("serving at port", PORT)

try:
	httpd.serve_forever()
except KeyboardInterrupt:
	pass
