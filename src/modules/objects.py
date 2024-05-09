from Crypto.Cipher import PKCS1_OAEP
from Crypto.PublicKey import RSA
from textwrap import wrap
from pprint import pprint
from copy import deepcopy
import base64 as b64

arr_types = [list, tuple, set]

def encrypt_data(input_data: str, public_key: str) -> list:
  input_data_splited = str(input_data).split()
  output_data = list()
  n = 0
  key = RSA.import_key(public_key)
  cipher = PKCS1_OAEP.new(key)

  for i in input_data_splited:

    if len(i) > 50:
      output_data.append(wrap(i, 50))
    else:
      output_data.append(i)

  while n < len(output_data):

    k = 0
    if type(output_data[n]) in arr_types:
      while k < len(output_data[n]):
        b64_data = b64.b64encode(cipher.encrypt(f'{output_data[n][k]}'.encode()))
        output_data[n][k] = b64_data.decode()
        k += 1
    else:
      b64_data = b64.b64encode(cipher.encrypt(f'{output_data[n]}'.encode()))
      output_data[n] = b64_data.decode()
    n += 1

  return output_data

def decrypt_data(input_data: str, private_key: str, passphrase = None) -> str:
  n = 0
  output_data = str()
  key = RSA.import_key(private_key, passphrase)
  cipher = PKCS1_OAEP.new(key)

  while n < len(input_data):

    if type(input_data[n]) in arr_types:
      for i in input_data[n]:
        output_data += cipher.decrypt(b64.b64decode(i)).decode()
      if n < len(input_data) - 1:
        output_data += ' '
    else:
      output_data += cipher.decrypt(b64.b64decode(input_data[n])).decode()
      if n < len(input_data) - 1:
        output_data += ' '

    n += 1

  return output_data

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

      if type(object[i]) is dict:
        object[i] = decrypt_object(object[i], private_key, passphrase)
      else:
        object[i] = decrypt_data(object[i], private_key, passphrase)
      i += 1
  elif type(object) is dict:
    for i in object:
      k = 0

      if i != 'user_pub_key':

        if type(object[i]) in arr_types:
          while k < len(object[i]):

            if type(object[i][k]) is dict:
              object[i][k] = decrypt_object(object[i][k], private_key, passphrase)
            else:
              object[i] = decrypt_data(object[i], private_key)
              break
            k += 1
        else: 
          object[i] = decrypt_data(object[i], private_key)

  return object

def find_in_object(object, match):
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
