__author__ = "Maxim"

import socket

class User():
    def __init__(self, name = "undefined"):
        self.name = name
        self.ip = self.getIP()
        
    # Перенести в подкласс socket, или это вообще брать у Вани
    def getIP(self):
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        return local_ip