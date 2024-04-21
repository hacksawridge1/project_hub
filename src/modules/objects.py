from Crypto.Cipher import PKCS1_OAEP
from Crypto.PublicKey import RSA
from textwrap import wrap
from pprint import pprint

def encrypt_data(input_data: str, public_key: str):
  input_data_splited = input_data.split()
  output_data = list()
  n = 0
  key = RSA.import_key(public_key)
  cipher = PKCS1_OAEP.new(key)
  for i in input_data_splited:
    output_data.append(wrap(i, 50))
  while n < len(output_data):
    k = 0
    while k < len(output_data[n]):
      output_data[n][k] = cipher.encrypt(f'{output_data[n][k]}'.encode())
      k += 1
    n += 1
  return output_data

def decrypt_data(input_data: str, private_key: str, passphrase = None):
  def decrypt_data_in_data(input_data, private_key, passphrase):
    n = 0
    output_data = str()
    key = RSA.import_key(private_key, passphrase)
    cipher = PKCS1_OAEP.new(key)
    while n < len(input_data):
      if type(input_data[n]) is list or type(object[n]) is set:
        output_data = decrypt_data_in_data(input_data[n], private_key, passphrase)
      else:
        output_data += cipher.decrypt(input_data[n]).decode()
      n += 1
    return output_data
  
  n = 0
  output_data = str()
  key = RSA.import_key(private_key, passphrase)
  cipher = PKCS1_OAEP.new(key)
  while n < len(input_data):
    if type(input_data[n]) is list or type(object[n]) is set:
      output_data += decrypt_data_in_data(input_data[n], private_key, passphrase)
    else:
      output_data += cipher.decrypt(input_data[n]).decode()
    if n < len(input_data) - 1:
      output_data += ' '
    n += 1
  return output_data

def encrypt_object(object, public_key: str):
  public_key = RSA.import_key(public_key).public_key().export_key(format='PEM').decode('utf-8')
  if type(object) is list or type(object) is set:
    object = encrypt_data(object, public_key)
  for i in object:
    k = 0
    if i != 'user_pub_key':
      if type(object[i]) is list:
        while k < len(object[i]):
          if type(object[i][k]) is dict:
            object[i][k] = encrypt_object(object[i][k], public_key)
          else:
            object[i][k] = encrypt_data(object[i][k], public_key)
          k += 1
      else:
        object[i] = encrypt_data(object[i], public_key)
  return object

def decrypt_object(object, private_key: str, passphrase: str = None):
  private_key = RSA.import_key(private_key, passphrase).export_key(format='PEM').decode('utf-8')
  if type(object) is list or type(object) is set:
    object = decrypt_data(object, private_key, passphrase)
  for i in object:
    k = 0
    if i != 'user_pub_key':
      if type(object[i]) is list:
        while k < len(object[i]):
          if type(object[i][k]) is dict:
            object[i][k] = decrypt_object(object[i][k], private_key, passphrase)
          else:
            object[i][k] = decrypt_data(object[i][k], private_key)
          k += 1
      else:
        object[i] = decrypt_data(object[i], private_key)
  return object

def find_in_object(object: object, match: str):
  for i in object:
    k = 0
    if object[i] == match:
      return object
    else:
      if type(object[i]) is list:
        while k < len(object[i]):
          if type(object[i][k]) is dict:
            if find_in_object(object[i][k], match) != None:
              return object[i][k]
          else:
            if object[i][k] == match:
              return object[i]
          k += 1