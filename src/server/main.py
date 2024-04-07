import socket
# from modules.objects import decrypt_data
import json
# from modules.app import App

def main():
  # app = App()
  sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  sock.bind(('', 9090))
  sock.listen(1)

  # sock.close()

  # print('connect:', addr)

  # while True:
  #   conn, addr = sock.accept()
  #   data = conn.recv(1024)
  #   if not data:
  #     break
  #   if data == 'close conn':
  #     conn.close()
  #   conn.send(decrypt_data(data, App.private_key))

if __name__ == '__main__':
  main()