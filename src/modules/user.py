import netifaces
import ipaddress
from Crypto.PublicKey import RSA
from .objects import encrypt_object, decrypt_object, encrypt_data, decrypt_data, find_in_object
import requests
from dataclasses import dataclass
from random import randint
import json
import os
@dataclass
class User:

  # initial  
  def __init__(self, name: str):
    self.__name = name
    self.__ip = self.__get_local_ip()
    self.__generate_keys()
    # self.__sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    self.__user_info = {
      "user_name": str(self.__name),
      "user_ip": str(self.__ip),
      "user_pub_key": str(self.__public_key.decode())
    }
    with open('objects/self/user-info.json', 'w') as f:
      f.write(json.dumps(encrypt_object(self.__user_info, self.__private_key)))
      f.close()
    with open('objects/self/users-online.json', 'w') as f:
      data = {
        'users_online' : []
      }
      f.write(json.dumps(data))
      f.close()

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
    with open('objects/self/users-online.json', 'r') as f:
      users_online = json.load(f)

      message = {
        'data' : str(encrypt_data(data, find_in_object(users_online['users_online'], f'{addr}')['user_pub_key']))
      }
      requests.post(f'http://{addr}:9091/message', data = message) #in progress

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
    users_to_ping = list()
    # used_id = list()

    while i < 255:
      try:
        if f'{net_ip}{i}' != self.__ip:
          if len(users_to_ping) < 4:
            resp = requests.get(f'http://{net_ip}{i}:{9091}/', timeout=0.1)
            if resp.ok:
              # if len(users_to_ping) <= 4:
              users_to_ping.append(f'{net_ip}' + str(i))
              resp = requests.get(f'http://{net_ip}{i}:{9091}/user')
              self.__add_user(eval(resp.text))
              # used_id.append(resp['user_id'])
              with open('objects/self/user-info.json', 'r') as f1, open('objects/self/users-online.json', 'r') as f2:
                user_info = decrypt_object(json.load(f1), self.__private_key)
                users_online = decrypt_object(json.load(f2), self.__private_key)
                requests.post(
                  f'http://{net_ip}{i}:{9091}/user',
                  data = { 'data' : str(encrypt_object(user_info, find_in_object(users_online['users_online'], f'{net_ip}{i}')['user_pub_key']))})
                f1.close()
                f2.close()
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
    
  # TODO
  # def __generate_user_id(self, data: tuple[list, set, tuple]):
  #   id = str(randint(1, 10000))
  #   if id in data:
  #     self.__generate_user_id(data)
  #   else:
  #     self.__user_info['user_id'] = str(id)

  def __remove_user(self, removed_user: dict):
    try:
      with open('objects/self/users-online.json', 'w') as f:
        users_online = decrypt_object(json.load(f), self.__private_key)
        f.write(json.dumps(encrypt_object(users_online['users_online'].remove(find_in_object(users_online, removed_user)), self.__public_key)))
        f.close()
    except ValueError:
      print('Пользователь не найден...')

  def call_to_remove_user(self):
    try:
      with open('objects/self/users-online.json', 'r') as f1, open('objects/self/user-info.json', 'r') as f2:
        users_online = decrypt_object(json.load(f1), self.__private_key)
        user_info = decrypt_object(json.load(f2), self.__private_key)
        for i in users_online['users_online']:
          user_ip = i['user_ip'] 
          requests.post(f'http://{user_ip}:{9091}/remove-user', data = {"data" : str(encrypt_object(user_info, i['user_pub_key']))})
        f1.close()
        f2.close()
        os.remove('objects/self/user-info.json')
        os.remove('objects/self/users-online.json')
    except:
      print("Connection error")
      self.call_to_remove_user()

  def __add_user(self, data: dict):
    try:
      with open('objects/self/users-online.json', 'r') as f:
        file_data = decrypt_object(json.load(f), self.__private_key)
        if find_in_object(file_data, data) == None:
          with open('objects/self/users-online.json', 'w') as f:
            f.write(json.dumps(encrypt_object(file_data['users_online'].append(data), self.__public_key)))
            f.close()
        else:
          print('Пользователь уже существует')
        f.close()
    except FileNotFoundError:
      with open('objects/self/users-online.json', 'w') as f:
        file_data = {
          'users_online': []
        }
        f.write(json.dumps(encrypt_object(file_data['users_online'].append(data), self.__public_key)))
        f.close()
  
  # getters
  @property
  def user_info(self):
    with open('objects/self/user-info.json', 'r') as f:
      return decrypt_object(json.load(f), self.__private_key)
  
  @property
  def users_online(self):
    try:
      with open('objects/self/users-online.json', 'r') as f:
        data = json.load(f)
        return decrypt_object(data, self.__private_key)
    except FileNotFoundError:
      return None

  @property
  def remove_user(self, data: dict):
    self.__remove_user(data)

  @remove_user.setter
  def remove_user(self, data: dict):
    self.__remove_user(data)


  @property
  def add_user(self, data: dict):
    pass
  
  @add_user.setter
  def add_user(self, data: dict):
    self.__add_user(data)

  @property
  def ip(self):
    return self.__ip
  
  @property
  def initial(self):
    self.__initial()
  
  @property
  def name(self):
    return self.__name

  # @property
  # def id(self):
  #   return self.__id

  @property
  def public_key(self):
    return self.__public_key.decode()

  @property
  def private_key(self):
    return self.__private_key.decode()
