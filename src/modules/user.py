import netifaces
import ipaddress
from Crypto.PublicKey import RSA
from .objects import encrypt_object, decrypt_object, encrypt_data, decrypt_data, find_in_object
import requests
from dataclasses import dataclass
from random import randint
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
    self.__users_online_list = list()
    # used_id = list()

    while i < 255:
      print(f'{net_ip}{i}')
      try:
        if f'{net_ip}{i}' != self.__ip:
          if len(users_to_ping) < 4:
            resp = requests.get(f'http://{net_ip}{i}:{9091}/', timeout=0.1)
            if resp.ok:
              # if len(users_to_ping) <= 4:
              users_to_ping.append(f'{net_ip}' + str(i))
              resp = requests.get(f'http://{net_ip}{i}:{9091}/user')
              self.__users_online_list.append(eval(resp.text))
              # used_id.append(resp['user_id'])
              requests.post(f'http://{net_ip}{i}:{9091}/user', data = { 'data' : str(encrypt_object(self.user_info, find_in_object(self.__users_online_list, f'{net_ip}{i}')['user_pub_key']))})
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
      self.__users_online_list.remove(find_in_object(self.__users_online_list, removed_user))
    except ValueError:
      print('Пользователь не найден...')

  def call_to_remove_user(self):
    try:
      for i in self.__users_online_list:
        to_send = {
          "data" : str(encrypt_object(self.__user_info, i['user_pub_key']))
        }
        requests.post('http://{:s}:{:s}/remove-user'.format(i['user_ip'], 9091), data = to_send)
    except:
      print("Connection error")
      self.call_to_remove_user()

  def __add_user(self, data: dict):
    if find_in_object(self.__users_online_list, data) == None:
      self.__users_online_list.append(data)
    else:
      print('Пользователь уже существует')

  
  # getters
  @property
  def user_info(self):
    return self.__user_info
  
  @property
  def users_online(self):
    return self.__users_online_list

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