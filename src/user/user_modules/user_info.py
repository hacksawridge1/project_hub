import socket

def generate_user_id():
  id = 101
  return id

def get_local_ip():
  hostname = socket.gethostname()
  userIp = socket.gethostbyname(hostname)
  return userIp