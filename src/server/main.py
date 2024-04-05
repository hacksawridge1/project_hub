import socket
from modules.objects import decrypt_data
import json
from modules.app import App

def main():
  app = App()
  sock = socket.socket()
  sock.bind(('', 9090))
  sock.listen(1)
  conn, addr = sock.accept()


  print('connect:', addr)

  while True:
    data = conn.recv(1024)
    if not data:
      break
    if data == 'close conn':
      conn.close()
    conn.send(decrypt_data(data, App.private_key))

if __name__ == '__main__':
  main()