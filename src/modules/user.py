import socket
import netifaces
import ipaddress
from Crypto.PublicKey import RSA
from .objects import encrypt_object, decrypt_object, encrypt_data, decrypt_data, find_in_object
from .server import start_server
import requests
import json
import threading
from dataclasses import dataclass
@dataclass
class User:

  # initial  
  def __init__(self, name: str):
    self.__name = name
    self.__ip = self.__get_local_ip()
    self.__id = 101
    self.__generate_keys()
    # self.__sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.__user_info = {
      "user_name": str(self.__name),
      "user_ip": str(self.__ip),
      "user_id": str(self.__id),
      "user_pub_key": str(self.__public_key.decode('utf-8'))
    }

  # methods
  def __generate_keys(self):
    key = RSA.generate(2048)
    self.__private_key = key.export_key(format='PEM',
                                        passphrase=None,
                                        pkcs=8,
                                        protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                        prot_params={'iteration_count': 21000})

    self.__public_key = key.public_key().export_key(format='PEM')   


  def send_message(self, addr: str, user_name: str, data):
    message = {
      'data' : str(encrypt_data(data, find_in_object(self.__users_online_list, f'{addr}')['user_pub_key']))
    }
    requests.post(f'http://{addr}:9091/{user_name}/message', data = message) #in progress


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
                

  def __initial(self):
    net_ip = '.'.join(self.__ip.split('.')[:3]) + '.'
    i = 2
    users_online = list()
    self.__users_online_list = list()
    black_list = list()

    print("START INIT...")

    while i < 255:
      try:
        if f'{net_ip}' + str(i) not in black_list and f'{net_ip}' + str(i) != self.__ip:
          if len(users_online) < 4:
            resp = requests.get(f'http://{net_ip}{i}:{9091}/', timeout=0.1)
            if resp.ok:
              # if len(users_online) <= 4:
              #   users_online.append(f'{net_ip}' + str(i))
              resp = requests.get(f'http://{net_ip}{i}:{9091}/init')
              self.__users_online_list.append(eval(resp.text))
              requests.post(
                f'http://{net_ip}{i}:{9091}/new-user', 
                data = { 'data' : str(encrypt_object(self.__user_info, find_in_object(self.__users_online_list, f'{net_ip}{i}')['user_pub_key']))})
              i += 1
              continue
          else:
            break
        else:
          i += 1
          continue
      except requests.exceptions.ConnectionError:
        i += 1
        continue
    
    print("END INIT...")

  def __user_leave(self):
    requests.post()
  
  # getters
  @property
  def user_info(self):
    return self.__user_info
  
  @property
  def users_online(self):
    return self.__users_online_list
  
  @users_online.setter
  def users_online(self, data: object):
    if find_in_object(self.__users_online_list, data) == None:
      self.__users_online_list.append(data)
    else:
      return 

  @property
  def ip(self):
    return self.__ip
  
  @property
  def initial(self):
    self.__initial()
  
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
    return self.__public_key.decode()

  @property
  def private_key(self):
    return self.__private_key.decode()