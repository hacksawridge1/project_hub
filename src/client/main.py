import socket
from modules.app import App
import json
from modules.objects import encrypt_data

app = App()
sock = socket.socket()
sock.connect(('localhost', 9090))
sock.send(encrypt_data('Test message', app.public_key))

def main():
  pass

if __name__ == '__main__':
  main()