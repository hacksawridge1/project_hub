from pathlib import Path
from time import localtime
from typing import Union

def users_online() -> dict:
  USERS_ONLINE: dict = {}
  USERS_ONLINE['users_online'] = []
  return USERS_ONLINE

def user_info(name: str, ip: str, pub_key: str) -> dict:
  USER_INFO: dict = {}
  USER_INFO['user_name'] = name
  USER_INFO['user_ip'] = ip
  USER_INFO['user_pub_key'] = pub_key
  return USER_INFO

def chat() -> dict:
  CHAT: dict = {}
  CHAT['chat'] = []
  return CHAT

def chat_object(name: str, ip: str, message: str) -> dict:
  CHAT_OBJECT: dict = {}
  CHAT_OBJECT['user_name'] = name
  CHAT_OBJECT['user_ip'] = ip
  CHAT_OBJECT['time'] = f"{localtime().tm_hour}:{localtime().tm_min}"
  CHAT_OBJECT['message'] = message
  return CHAT_OBJECT

def groups(groups_list: list) -> dict:
  GROUPS: dict = {}
  GROUPS['groups'] = groups_list
  return GROUPS

def group_info(name: str, id: str, owner: str, members: list = [], chat: list = []) -> dict:
  GROUP_INFO: dict = {} 
  GROUP_INFO['group_name'] = name
  GROUP_INFO['group_id'] = id
  GROUP_INFO['group_owner'] = owner
  GROUP_INFO['group_members'] = members
  GROUP_INFO['chat'] = chat
  return GROUP_INFO

def path_to_chat(name: Union[str, None] = None, ip: Union[str, None] = None, file: Union[str, None] = None): 
  if name != None and ip != None and file == None:
    PATH_TO_CHAT=Path(f"objects/chat/{name}_{ip}")
  elif name != None and ip != None and file != None:
    PATH_TO_CHAT = Path(f"objects/chat/{name}_{ip}/{file}")
  else: 
    PATH_TO_CHAT = Path(f"objects/chat/")
  return PATH_TO_CHAT

def path_to_self(file: Union[str, None] = None):
  if file != None:
    PATH_TO_SELF = Path(f'objects/self/{file}')
  else:
    PATH_TO_SELF = Path(f"objects/self/")
  return PATH_TO_SELF

def path_to_upload(name: Union[str, None] = None, ip: Union[str, None] = None, file: Union[str, None] = None):
  if name != None and ip != None and file == None:
    PATH_TO_UPLOAD = Path(f"upload/{name}_{ip}")
  elif name != None and ip != None and file != None:
    PATH_TO_UPLOAD = Path(f"upload/{name}_{ip}/{file}")
  else:
    PATH_TO_UPLOAD = Path(f"upload/")
  return PATH_TO_UPLOAD

def path_to_download(name: Union[str, None] = None, ip: Union[str, None] = None):
  if name != None and ip != None:
    PATH_TO_DOWNLOAD = Path(f"download/{name}_{ip}")
  else: 
    PATH_TO_DOWNLOAD = Path(f"download/")
  return PATH_TO_DOWNLOAD
