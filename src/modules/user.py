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
      'data' : str(encrypt_data(data, find_in_object(self.users_online, f'{addr}')['user_pub_key']))
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
    k = 0
    users_online = list()
    users_online_list = dict()
    initial_data = list()
    data_check = None
    black_list = list()

    print("START INIT...")

    while i < 255:
      print(f'{net_ip}' + str(i))
      try:
        if f'{net_ip}' + str(i) not in black_list and f'{net_ip}' + str(i) != self.__ip:
          if len(users_online) < 4:
            resp = requests.get(f'http://{net_ip}' + str(i) + ':' + str(9091) + '/hi', timeout=0.1)
            if resp.ok:
              if len(users_online) <= 4:
                users_online.append(f'{net_ip}' + str(i))
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

    if len(users_online) > 0:
      for i in users_online:
        resp = requests.get('http://' + i + ':9091' + '/init')
        initial_data.append(resp.text)

      if len(initial_data) > 1:
        while k < len(initial_data) - 1:
          if initial_data[k] == initial_data[k + 1]:
            data_check = True
          else:
            data_check = False
            black_list = users_online.copy()
            self.__initial()
          k += 1
      elif len(initial_data) == 1:
        data_check = True
      else:
        print("NO DATA")

      if data_check:
        initial_data = initial_data[0]
        users_online_list = json.loads(initial_data)
    
      for i in users_online:
        send_data = {
          'data' : str(encrypt_object(self.__user_info, find_in_object(users_online_list, f'{i}')['user_pub_key']))
        }
        requests.post(f'http://{i}:9091/init', data = send_data)

    else:
      users_online_list['usersonline'] = [
        self.__user_info
      ]
    
    print("END INIT...")

    self.__users_online = users_online_list
  
  # getters
  @property
  def user_info(self):
    return self.__user_info
  
  @property
  def users_online(self):
    return self.__users_online
  
  @users_online.setter
  def users_online(self, data: object):
    self.__users_online = data

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