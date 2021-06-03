import SimpleHTTPServer
import SocketServer
import os
os.chdir("web")
PORT = 8081

class ServerHandler(SimpleHTTPServer.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_len = int(self.headers.getheader('content-length', 0))
        post_body = self.rfile.read(content_len)
        if post_body == "0":
            os.remove("run.txt")
        else:
            file1 = open("config.json","w")
            file1.write(post_body)
            file1.close()

            file1 = open("run.txt","w")
            file1.write("1")
            file1.close()


Handler = ServerHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT
httpd.serve_forever()
