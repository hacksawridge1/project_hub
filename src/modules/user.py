import sys
import socket
import json
import os
from zlib import compress
from shutil import rmtree
from dataclasses import dataclass
from typing import Union
import requests
from Crypto.PublicKey import RSA
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import modules.settings as set
from app.control import Controller
from .objects import decrypt_data, encrypt_object, decrypt_object, find_in_object
#import netifaces
#import ipaddress
#import asyncio

@dataclass
class User:

  # initial
  def __init__(self, name: str, control: Controller):
    if name is None:
      name = "User"
    self.__name: str = str(name)
    self.__ip: str = str(self.__get_local_ip())
    self.__generate_keys()
    self.__user_info: dict = set.user_info(self.name, self.ip, self.public_key)
    self.control = control

    if not set.path_to_self().exists():
      set.path_to_self().mkdir(parents=True)

    if not set.path_to_upload().exists():
      set.path_to_upload().mkdir(parents=True)

    if not set.path_to_download().exists():
      set.path_to_download().mkdir(parents=True)

    with set.path_to_self("user-info.json").open("w") as f:
      f.write(json.dumps(encrypt_object(self.__user_info, self.public_key), sort_keys=True))

    with set.path_to_self("users-online.json").open("w") as f:
      f.write(json.dumps(encrypt_object(set.users_online(), self.private_key), sort_keys=True))

  # methods
  def __generate_keys(self):
    key = RSA.generate(2048)
    self.__private_key = key.export_key(format='PEM',
                                        passphrase=None, #type: ignore
                                        pkcs=8,
                                        protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                        prot_params={'iteration_count': 21000})

    self.__public_key = key.public_key().export_key(format='PEM')

  def __get_local_ip(self):
    #for interface in netifaces.interfaces():
    #  if netifaces.AF_INET in netifaces.ifaddresses(interface):
    #    for address_info in netifaces.ifaddresses(interface)[netifaces.AF_INET]:
    #       address_object = ipaddress.IPv4Address(address_info['addr'])
    #       if not address_object.is_loopback:
    #         yield address_info['addr']
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.settimeout(0)
    try:
      # doesn't even have to be reachable
      s.connect(('10.254.254.254', 1))
      IP = s.getsockname()[0]
    except Exception:
      IP = '127.0.0.1'
    finally:
      s.close()
    return IP


  def __initial(self):
    net_ip: str = '.'.join(self.ip.split('.')[:3]) + '.'
    i: int = 2

    while i < 255:
      try:
        if f'{net_ip}{i}' != self.ip:
          resp = requests.get(f'http://{net_ip}{i}:{9091}/', timeout=0.1)

          if resp.ok:
            resp = requests.get(f'http://{net_ip}{i}:{9091}/user')
            data: dict = eval(resp.text)


            with set.path_to_self("users-online.json").open() as f:
              file_data: dict = decrypt_object(json.load(f), self.private_key)

            if find_in_object(file_data, data) == None:
              file_data['users_online'].append(encrypt_object(data, self.public_key))

              with set.path_to_self("users-online.json").open("w") as f:
                f.write(json.dumps(file_data))

              self.control.add_user.emit(data["user_name"], data["user_ip"])

            with set.path_to_self("user-info.json").open() as f:
              user_info: dict = decrypt_object(json.load(f), self.private_key)

              requests.post(
                f'http://{net_ip}{i}:{9091}/user',
                json = encrypt_object(user_info, data['user_pub_key']))
            i += 1
            continue
        else:
          i += 1
          continue
      except requests.exceptions.ConnectionError:
        i += 1
        continue

  # Send message (user.send_message(...))
  def send_message(self, reciever_ip: str, reciever_name: str, message: str) -> None | str:
    chat: dict = set.chat()
    chat_object: dict = set.chat_object(self.name, self.ip, message)

    if not set.path_to_chat(reciever_name, reciever_ip).exists():
      set.path_to_chat(reciever_name, reciever_ip).mkdir(parents=True)
      (set.path_to_chat(reciever_name, reciever_ip) / "chat.json").touch()

      with set.path_to_chat(reciever_name, reciever_ip, "chat.json").open("w") as f:
        chat["chat"].append(encrypt_object(chat_object, self.public_key))
        f.write(json.dumps(chat, sort_keys=True))

    else:

      with set.path_to_chat(reciever_name, reciever_ip, "chat.json").open() as f:
        chat = json.load(f)
        chat["chat"].append(encrypt_object(chat_object, self.private_key))

    with set.path_to_self("users-online.json").open() as f, set.path_to_chat(reciever_name, reciever_ip, "chat.json").open("w") as f1:
      f1.write(json.dumps(chat, sort_keys=True))
      users_online: dict = decrypt_object(json.load(f), self.private_key)
      reciever: dict = find_in_object(users_online, reciever_ip) #type: ignore
      if reciever != None:
        requests.post("http://" + reciever_ip + ":9091/message", json = encrypt_object(chat_object, reciever["user_pub_key"])) #in progress
      else:
        return "Пользователь не найден"

  # Call to remove user on exit (user.call_to_remove_user())
  def call_to_remove_user(self):
    try:
      with set.path_to_self("users-online.json").open() as f1, set.path_to_self("user-info.json").open() as f2:
        users_online: dict = decrypt_object(json.load(f1), self.private_key)
        user_info: dict = decrypt_object(json.load(f2), self.private_key)
        for i in users_online['users_online']:
          user_ip: str = i['user_ip']
          requests.post(f'http://{user_ip}:{9091}/remove-user', json = str(encrypt_object(user_info, i['user_pub_key'])))
    except :
      print("Error")
    
    if set.path_to_self().exists():
      rmtree(set.path_to_self())
    if set.path_to_chat().exists():
      rmtree(set.path_to_chat())
    if set.path_to_upload().exists():
      rmtree(set.path_to_upload())
    if set.path_to_download().exists():
      rmtree(set.path_to_download())

  # Get chat inform with {user_name, user_ip}(user.chat_info(...))
  def chat_info(self, user_name, user_ip) -> Union[list, str]:
    if os.path.exists(f'/objects/chat/{user_name}_{user_ip}/chat.json'):
      with open(f'objects/chat/{user_name}_{user_ip}/chat.json', 'r') as f:
        chat: dict = decrypt_object(json.load(f), self.private_key)
        return chat["chat"]
    else:
      raise FileNotFoundError

  def upload_file(self, reciever_name: str, reciever_ip: str, file: str):

    file_name: str = file.split("/")[-1]

    if not set.path_to_upload(reciever_name, reciever_ip).exists():
      set.path_to_upload(reciever_name, reciever_ip).mkdir()

    with open(file, 'rb') as f:
      data: bytes = f.read()

    zip_data: bytes = compress(data)

    with set.path_to_upload(reciever_name, reciever_ip, file_name + ".zip").open('wb') as f:
      f.write(zip_data)
# TODO:
  def download_file(self, sender_name:str, sender_ip: str, file_name: str):
    try:
      resp = requests.get(f"http://{sender_ip}:9091/download/{file_name}").json()
      if resp.ok:

        if not set.path_to_download(sender_name, sender_ip).exists():
          set.path_to_download(sender_name, sender_ip).mkdir(parents=True)

        with set.path_to_download(sender_name, sender_ip, file_name).open('wb') as f:
          file_data: bytes = decrypt_data(resp['file_data'], self.private_key) #type: ignore
          f.write(file_data)
      else:
        raise requests.exceptions.HTTPError
    except requests.exceptions.HTTPError as err:
      return f"Status Code:\t {err.response.status_code}"

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

  @property
  def initial(self):
    self.__initial()
