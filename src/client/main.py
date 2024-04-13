import socket
import json
import requests

# TEEEEEEEEEEESTS


rcv = requests.get("http://localhost:9090/usersonline")
rcv = rcv.text
print(rcv)

# client_sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
# client_sock.connect(('localhost', 9090))
# with open('../objects/personal/user_info.json', 'r') as f:
#   data = f.read()
#   data = json.loads(data)
#   data = json.dumps(data)
#   client_sock.send(data.encode())

# rcv_data = client_sock.recv(1024)

# with open('usersonline.json', 'w') as f:
#   rcv_data = rcv_data.decode()
#   rcv_data = json.loads(rcv_data)
#   f.write(json.dumps(rcv_data))