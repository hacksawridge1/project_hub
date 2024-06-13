from Crypto.Cipher import PKCS1_OAEP
from Crypto.PublicKey import RSA
from textwrap import wrap
from typing import Union
from copy import deepcopy
import base64 as b64

arr_types = [list, tuple, set]

#TODO: add bytes support
def encrypt_data(input_data: Union[str, bytes], public_key: str) -> Union[list,str]:
  try:
    input_data_splited: Union[list,None] = None
    output_data: Union[list,bytearray] = list()
    n: int = 0
    key = RSA.import_key(public_key)
    cipher = PKCS1_OAEP.new(key)

    if isinstance(input_data, str):
      input_data_splited = str(input_data).split()
    elif not isinstance(input_data, str) and not isinstance(input_data, bytes):
      raise TypeError

    if input_data_splited != None:
      for i in input_data_splited:
        if len(i) > 50:
          output_data.append(wrap(i, 50))
        else:
          output_data.append(i)
    elif isinstance(input_data, bytes):
      if len(input_data) > 50:
        output_data = split_line(input_data, 50)
      else:
        output_data.append(input_data)
    else:
      raise TypeError

    while n < len(output_data):
      k: int = 0
      if type(output_data[n]) in arr_types:
        while k < len(output_data[n]):
          if isinstance(output_data[n][k], str):
            b64_data = b64.b64encode(cipher.encrypt(f'{output_data[n][k]}'.encode()))
            output_data[n][k] = b64_data.decode()
          elif isinstance(output_data[n][k], bytes):
            b64_data = b64.b64encode(cipher.encrypt(output_data[n][k]))
            output_data[n][k] = b64_data
          k += 1
      else:
        if isinstance(output_data[n], str):
          b64_data = b64.b64encode(cipher.encrypt(f'{output_data[n]}'.encode()))
          output_data[n] = b64_data.decode()
        elif isinstance(output_data[n], bytes):
          b64_data = b64.b64encode(cipher.encrypt(output_data[n]))
          output_data[n] = b64_data
      n += 1

    return output_data
  except TypeError:
    return "(Encrypt) Incorrect Type: Input data must be string or bytes"

def decrypt_data(input_data: list, private_key: str, passphrase = None) -> Union[str, bytes, None]:
  try:
    if not isinstance(input_data, list):
      raise TypeError
    output_data: Union[str, bytes, None] = None
    n: int = 0
    key = RSA.import_key(private_key, passphrase)
    cipher = PKCS1_OAEP.new(key)

    while n < len(input_data):
      print(input_data[n])

      if type(input_data[n]) in arr_types:
        for i in input_data[n]: #type: ignore
          if isinstance(i, bytes):
            if output_data == None:
              output_data = cipher.decrypt(b64.b64decode(i)) #type: ignore
            else:
              output_data += cipher.decrypt(b64.b64decode(i)) #type: ignore
          elif isinstance(i, str):
            if output_data == None:
              output_data = cipher.decrypt(b64.b64decode(i)).decode() #type: ignore
            else:
              output_data += cipher.decrypt(b64.b64decode(i)).decode() #type: ignore
        if n < len(input_data) - 1 and not isinstance(input_data[n], bytes):
          output_data += ' ' #type: ignore
      else:
        if isinstance(input_data[n], bytes):
          if output_data == None:
            output_data = cipher.decrypt(b64.b64decode(input_data[n])) #type: ignore
          else:
            output_data += cipher.decrypt(b64.b64decode(input_data[n])) #type: ignore
        elif isinstance(input_data[n], str):
          if output_data == None:
            output_data = cipher.decrypt(b64.b64decode(input_data[n])).decode() #type: ignore
          else:
            output_data += cipher.decrypt(b64.b64decode(input_data[n])).decode() #type: ignore
        if n < len(input_data) - 1 and not isinstance(input_data[n], bytes):
          output_data += ' ' #type: ignore

      n += 1

    return output_data #type: ignore
  except TypeError as err:
    return err#"Incorrect Type: Input data must be string"

def encrypt_object(object, public_key: str) -> dict:
  object_copy = deepcopy(object)
  public_key = RSA.import_key(public_key).public_key().export_key(format='PEM').decode('utf-8')
  if type(object_copy) in arr_types:
    i = 0
    while i < len(object_copy):
      if (type(object_copy[i]) is dict
          or type(object_copy[i]) in arr_types):
        object_copy[i] = encrypt_object(object_copy[i], public_key)
      else:
        object_copy[i] = encrypt_data(object_copy[i], public_key)
      i += 1
  elif type(object_copy) is dict:
    for i in object_copy:
      k = 0
      
      if i != 'user_pub_key':

        if type(object_copy[i]) in arr_types:
          while k < len(object_copy[i]):

            if (type(object_copy[i][k]) is dict 
              or type(object_copy[i][k]) in arr_types):
              object_copy[i][k] = encrypt_object(object_copy[i][k], public_key)
            else:
              object_copy[i][k] = encrypt_data(object_copy[i][k], public_key)
            k += 1
        else:
          object_copy[i] = encrypt_data(object_copy[i], public_key)
          
  return object_copy

def decrypt_object(object, private_key: str, passphrase = None) -> dict:
  private_key = RSA.import_key(private_key, passphrase).export_key(format='PEM').decode('utf-8')

  if type(object) in arr_types:
    i = 0
    while i < len(object):

      if isinstance(object[i], dict):
        object[i] = decrypt_object(object[i], private_key, passphrase)
      else:
        object[i] = decrypt_data(object[i], private_key, passphrase)
      i += 1
  elif isinstance(object, dict):
    for i in object:
      k = 0

      if i != 'user_pub_key':

        if type(object[i]) in arr_types:
          while k < len(object[i]):

            if isinstance(object[i][k], dict):
              object[i][k] = decrypt_object(object[i][k], private_key, passphrase)
            else:
              object[i] = decrypt_data(object[i], private_key)
              break
            k += 1
        else: 
          object[i] = decrypt_data(object[i], private_key)

  return object

def split_line(input_data: Union[str, bytes], count: int) -> list:
  output_data: list = list()

  for i in range(0, len(input_data), count):
    output_data.append(input_data[i:i+count])

  return output_data

def find_in_object(object, match) -> Union[dict, None]:
  if object == match:
    return object
  k = 0
  if type(object) in arr_types:
    while k < len(object):

      if object[k] == match:
        return object[k]
      if find_in_object(object[k], match) != None:
        return object[k]
      k += 1
  else:
    for i in object:
      if object[i] == match:
        return object
      else:
        if type(object[i]) in arr_types:
          while k < len(object[i]):

            if type(object[i][k]) is dict:
              if find_in_object(object[i][k], match) != None:
                return object[i][k]
            else:
              if object[i][k] == match:
                return object[i]
            k += 1
