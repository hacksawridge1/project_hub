import socket
import netifaces
import ipaddress
from Crypto.PublicKey import RSA

class User:

  # initial  
  def __init__(self, name: str, passphrase: str):
    self.__name = name
    self.__ip = self.__get_local_ip()
    # self.__id = self.__generate_user_id()
    self.__generate_keys(passphrase)
    self.__sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

  # methods
  def __generate_keys(self, passphrase: str):
    key = RSA.generate(1024)
    self.__private_key = key.export_key(format='PEM',
                                      passphrase=passphrase,
                                      pkcs=8,
                                      protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                      prot_params={'iteration_count': 21000})

    self.__public_key = key.public_key().export_key(format='PEM')          

  def send_message(self, addr, data):
    self.__sock.connect((f'{addr}', 9091))
    self.__sock.send(data)                        

  def __generate_user_id():
    id = 101 # in progress
    return id
  
  def __get_local_ip(self): 
    for interface in netifaces.interfaces():
        if netifaces.AF_INET in netifaces.ifaddresses(interface):
            for address_info in netifaces.ifaddresses(interface)[netifaces.AF_INET]:
                address_object = ipaddress.IPv4Address(address_info['addr'])
                if not address_object.is_loopback:
                    yield address_info['addr']
  
  # getters
  @property
  def name(self):
    return self.__name

  @property
  def id(self):
    return self.__id

  @property
  def local_ip(self):
    return self.__ip

  @property
  def public_key(self):
    return self.__public_key.decode('utf-8')

  @property
  def private_key(self):
    return self.__private_key.decode('utf-8')