import socket
import json

def start_server(addr: str, port: int):
  server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  server_sock.bind((addr, port))
  server_sock.listen(10)

  while True:
    client_sock, client_addr = server_sock.accept()
    data = client_sock.recv(1024)
    data = data.decode()
    if type(json.loads(data)) is dict:
        data = json.loads(data)
        try:
          with open('../objects/general/usersonline.json', 'r') as f:
              file_data = f.read()
              file_data = json.loads(file_data)
              file_data['usersonline'].append(data)
              file_data = json.dumps(file_data)
              client_sock.send(file_data.encode())
              client_sock.close()
        except:
           client_sock.close()

start_server('', 9090)