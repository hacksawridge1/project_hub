import netifaces
import ipaddress
from Crypto.PublicKey import RSA
import requests
from dataclasses import dataclass
import json
import os
from typing import Union
from .objects import encrypt_object, decrypt_object, find_in_object
import modules.settings as set

@dataclass
class User:

  # initial
  def __init__(self, name: str):
    self.__name: str = name
    self.__ip: str = str(self.__get_local_ip())
    self.__generate_keys()
    self.__user_info: dict = set.user_info(self.name, self.ip, self.public_key) 

    if not set.path_to_self().exists():
      set.path_to_self().mkdir()

    if not set.path_to_upload().exists():
      set.path_to_upload().mkdir()

    if not set.path_to_download().exists():
      set.path_to_download().mkdir()

    with set.path_to_self("user-info.json").open("w") as f:
      f.write(json.dumps(encrypt_object(self.__user_info, self.public_key), sort_keys=True))
      f.close()

    with set.path_to_self("users-online.json").open("w") as f:
      f.write(json.dumps(encrypt_object(set.users_online(), self.private_key), sort_keys=True))
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

  def __get_local_ip(self) -> Union[str, None]:
    for interface in netifaces.interfaces():
      if netifaces.AF_INET in netifaces.ifaddresses(interface):
        for address_info in netifaces.ifaddresses(interface)[netifaces.AF_INET]:
           address_object = ipaddress.IPv4Address(address_info['addr'])
           if not address_object.is_loopback:
             return address_info['addr']

  def __initial(self):
    net_ip: str = '.'.join(self.ip.split('.')[:3]) + '.'
    i: int = 2

    while i < 255:
      try:
        print(i)
        if f'{net_ip}{i}' != self.ip:
          resp = requests.get(f'http://{net_ip}{i}:{9091}/', timeout=0.1)
          print(f'http://{net_ip}{i}:{9091}/')

          if resp.ok:
            resp = requests.get(f'http://{net_ip}{i}:{9091}/user')
            data: dict = eval(resp.text)
            print(data)

            with set.path_to_self("users-online.json").open() as f:
              file_data: dict = decrypt_object(json.load(f), self.private_key) 
              file_data['users_online'].append(encrypt_object(data, self.public_key))
              f.close()

            with set.path_to_self("users-online.json").open("w") as f:
              f.write(json.dumps(file_data))

            with set.path_to_self("user-info.json").open() as f:
              user_info: dict = decrypt_object(json.load(f), self.private_key)

              requests.post(
                f'http://{net_ip}{i}:{9091}/user',
                json = encrypt_object(user_info, data['user_pub_key']))
              f.close()
            i += 1
            continue
        else:
          i += 1
          continue
      except requests.exceptions.ConnectionError:
        print("Err")
        i += 1
        continue

  # Send message (user.send_message(...))

  def send_message(self, reciever_ip: str, reciever_name: str, message: str) -> None:
    chat: dict = set.chat()
    chat_object: dict = set.chat_object(self.name, self.ip, message)

    if not set.path_to_chat(reciever_name, reciever_ip).exists():
      set.path_to_chat(reciever_name, reciever_ip).mkdir(parents=True)
      (set.path_to_chat(reciever_name, reciever_ip) / "chat.json").touch()
      
      with set.path_to_chat(reciever_name, reciever_ip, "chat.json").open("w") as f:
        chat["chat"].append(encrypt_object(chat_object, self.public_key))
        f.write(json.dumps(encrypt_object(chat, self.public_key), sort_keys=True))
        f.close()
        
    else:

      with set.path_to_chat(reciever_name, reciever_ip).open() as f:
        chat = json.load(f)
        chat["chat"].append(encrypt_object(chat_object, self.private_key))
        f.close()

    with set.path_to_self("users-online.json").open() as f, set.path_to_chat(reciever_name, reciever_ip, "chat.json").open("w") as f1:
      f1.write(json.dumps(chat, sort_keys=True))
      users_online: dict = decrypt_object(json.load(f), self.private_key)
      reciever: dict = find_in_object(users_online, reciever_ip)
      requests.post(f'http://' + reciever_ip + ':9091/message', json = encrypt_object(chat_object, reciever["user_pub_key"])) #in progress
      f1.close()
      f.close()

  # Call to remove user on exit (user.call_to_remove_user())
  def call_to_remove_user(self):
    try:
      with set.path_to_self("users-online.json").open() as f1, set.path_to_self("user-info.json").open() as f2:
        
        users_online: dict = decrypt_object(json.load(f1), self.private_key)
        user_info: dict = decrypt_object(json.load(f2), self.private_key)
        for i in users_online['users_online']:
          user_ip: str = i['user_ip'] 
          requests.post(f'http://{user_ip}:{9091}/remove-user', json = str(encrypt_object(user_info, i['user_pub_key'])))

        f1.close()
        f2.close()

    except :
      print("Error")
      
    set.path_to_self().rmdir()
    set.path_to_chat().rmdir()
    set.path_to_upload().rmdir()
    set.path_to_download().rmdir()

  # Get chat inform with {user_name, user_ip}(user.chat_info(...))
  def chat_info(self, user_name, user_ip) -> Union[list, str]:
    if os.path.exists(f'/objects/chat/{user_name}_{user_ip}/chat.json'):
      with open(f'objects/chat/{user_name}_{user_ip}/chat.json', 'r') as f:
        chat: dict = decrypt_object(json.load(f), self.private_key)
        return chat["chat"]
    else:
      return "С данным пользователем нет переписок"

  def send_file(self, reciever_name: str, reciever_ip: str, file: bytes):
    if not os.path.exists(f'/upload/{reciever_name}_{reciever_ip}'):
      os.mkdir(f'/upload/{reciever_name}_{reciever_ip}')

  
  # Info about user
  @property
  def user_info(self):
    with open('objects/self/user-info.json', 'r') as f:
      return decrypt_object(json.load(f), self.private_key)
  
  # Return users_online
  @property
  def users_online(self):
    try:
      with open('objects/self/users-online.json', 'r') as f:
        data = json.load(f)
        return decrypt_object(data, self.private_key)
    except FileNotFoundError:
      return None
  
  # Return ip
  @property
  def ip(self):
    return self.__ip
  
  # Return name
  @property
  def name(self):
    return self.__name

  # Return pub_key
  @property
  def public_key(self):
    return self.__public_key.decode()

  # Return priv_key
  @property
  def private_key(self):
    return self.__private_key.decode()

  # Initial on setup
  @property
  def initial(self):
    self.__initial()

