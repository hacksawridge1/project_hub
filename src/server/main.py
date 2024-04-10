import socket
# from modules.objects import decrypt_data
import json
# from modules.app import App

class Server:

  def __init__(self, addr: str, port: int):
    self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.sock.bind((addr, port))
    self.sock.listen()
    while True:
      self.conn, self.addr = self.sock.accept()
      self.data = self.conn.recv(1024)

  def __send_data(self, data: str):
    self.conn.send(data.encode('utf-8'))

  @property
  def send_data(self, data: str):
    self.__send_data(data)


def main():
  pass

if __name__ == '__main__':
  main()