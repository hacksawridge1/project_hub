import socket
import json
from modules.objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object

# TEEEEEEEEESTS

def start_server(addr: str, port: int, user: object):
  server_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  server_sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
  server_sock.bind((addr, port))
  server_sock.listen(5)

  while True:
    client_sock, client_addr = server_sock.accept()
    data = client_sock.recv(4096).decode()
    method = data.split(' ')[0]
    request = data.split(' ')[1]

    if method == "GET":
      
      HEADERS = 'HTTP/1.1 200 OK\r\n\Content-Type: application/json; charset=utf-8\r\n\r\n'

      if request == '/usersonline':
        with open('../objects/general/usersonline.json', 'r') as f:
          ans = json.load(f)
          ans = json.dumps(ans)
          client_sock.send(
            HEADERS.encode() + 
            ans.encode()
          )
          client_sock.close()

      if request == '/user_info':
        pass

      # in progress
      if request == '/groups':
        pass
      #in progress
      if request == '/group_info':
        pass

      if request == '/hi':
        client_sock.send(
          HEADERS.encode() +
          "Hi".encode()
        )
        client_sock.close()

      if request == '/init':
          data = user.users_online
          client_sock.send(
            HEADERS.encode() + 
            json.dumps(data).encode()
          ) 
          client_sock.close()
          
    if method == "POST":
      
      if request == f'{user.name}/message':
        pass

      if request == '/init': 
        print(data)
        print(type(data))
        user.users_online['usersonline'].append(decrypt_object(data, user.private_key))
        client_sock.send(HEADERS.encode())
        print(user.users_online)
