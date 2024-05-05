import socket

class Model():
    def __init__(self):
        self.username = ""
        self.ip = self.getIP()
    
    # Перенести в подкласс socket, или это вообще брать у Вани
    def getIP(self):
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        return local_ip