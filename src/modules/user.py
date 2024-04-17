import socket
import netifaces
import ipaddress
from Crypto.PublicKey import RSA
from modules.objects import encrypt_object, decrypt_object, encrypt_data, decrypt_data
import requests
import json

class User:

  # initial  
  def __init__(self, name: str, passphrase: str):
    self.__name = name
    self.__ip = self.__get_local_ip()
    # self.__id = self.__generate_user_id()
    self.__id = 101
    self.__generate_keys(passphrase)
    self.__sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.__user_info = {
      "user_name": str(self.__name),
      # "user_ip": self.__ip,
      "user_id": str(self.__id),
      "user_public_key": str(self.__public_key.decode('utf-8'))
    }
    self.__users_online = self.initial()
    print(self.__users_online)
    print(type(self.__users_online))

  # methods
  def __generate_keys(self, passphrase: str):
    key = RSA.generate(1024)
    self.__private_key = key.export_key(format='PEM',
                                        passphrase=passphrase,
                                        pkcs=8,
                                        protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                        prot_params={'iteration_count': 21000})

    self.__public_key = key.public_key().export_key(format='PEM')          

  def send_message(self, addr: str, data):
    # self.__sock.connect((addr, 9091))
    self.__sock.sendto(f"{data}".encode(), (addr, 9091))     
    self.__sock.close()                   

  def __generate_user_id():
    id = 101 # in progress
    return id
  
  def __get_local_ip(self): 
    for interface in netifaces.interfaces():
        if netifaces.AF_INET in netifaces.ifaddresses(interface):
            for address_info in netifaces.ifaddresses(interface)[netifaces.AF_INET]:
                address_object = ipaddress.IPv4Address(address_info['addr'])
                if not address_object.is_loopback:
                   return address_info['addr']
                
  def initial(self):
    net_ip = '.'.join(self.__ip.split('.')[:3]) + '.'
    i = 2
    k = 0
    users_online = list()
    initial_data = list()
    data_check = None
    black_list = list()

    print("START INIT...")

    while i < 255:
      try:
        if f'{net_ip}' + str(i) not in black_list:
          resp = requests.get(f'http://{net_ip}' + str(i) + ':' + str(9091) + '/hi', timeout=0.2)
          if resp.ok:
            if len(users_online) <= 4:
              users_online.append(f'{net_ip}' + str(i))
            continue
      except requests.exceptions.ConnectionError:
        continue
      i += 1

    for i in users_online:
      resp = requests.get('http://' + i + ':9091' + '/init')
      initial_data.append(resp.text)

    while k < len(initial_data) - 1:
      if initial_data[k] == initial_data[k + 1]:
        data_check = True
      else:
        data_check = False
        black_list = initial_data.copy()
        self.initial()
      k += 1

    print("END INIT...")

    if data_check:
      initial_data = initial_data[0]
      users_online_list = json.loads(initial_data)

    return users_online_list
  
  # getters
  @property
  def user_info(self):
    return self.__user_info
  
  @property
  def users_online(self):
    return self.__users_online
  
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