import socket
import json
# from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object

# TEEEEEEEEESTS

def start_server(addr: str, port: int):
  server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  server_sock.bind((addr, port))
  server_sock.listen()

  while True:
    client_sock, client_addr = server_sock.accept()
    data = client_sock.recv(1024).decode()
    print(data)
    method = data.split(' ')[0]
    request = data.split(' ')[1]
    if method == "GET":
      HEADERS = 'HTTP/1.1 200 OK\r\n\Content-Type: application/json; charset=utf-8\r\n\r\n'
      # if request == '/usersonline':
      #   with open('../objects/general/usersonline.json', 'r') as f:
      #     ans = encrypt_object(json.load(f))
      #     ans = json.dumps(ans)
      #     client_sock.send(HEADERS.encode() + ans.encode())
      #     client_sock.close()
      # if request == 'user_info':
      #   pass
      if request == '/hi':
        client_sock.send(HEADERS.encode()+"Hi".encode())

start_server('', 9091)