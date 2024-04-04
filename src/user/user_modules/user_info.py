import socket
import security.modules.generate_keys as gk

class User:
  def __init__(self, name: str, ip, id, public_key: str, private_key: str, passphrase: str):
    self.name = name
    self.ip = self.get_local_ip()
    self.id = self.generate_user_id()
    self.private_key = gk.generate_user_keys(passphrase)
    self.passphrase = passphrase
  
  @property
  def public_key(self):
    pass

  @public_key.setter
  def public_key(self):
    pass

  def generate_user_id():
    id = 101
    return id

  def get_local_ip():
    hostname = socket.gethostname()
    userIp = socket.gethostbyname(hostname)
    return userIp