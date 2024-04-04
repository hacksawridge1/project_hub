from Crypto.Cipher import PKCS1_OAEP
import security.modules.generate_keys as gk
from dotenv import load_dotenv

load_dotenv()

def encrypt_data(data: str, public_key: str):
  key = gk.import_public_key(public_key)
  cipher = PKCS1_OAEP.new(key)
  encrypted_data = cipher.encrypt(f'{data}'.encode('utf-8'))
  return encrypted_data

def decrypt_data(data: str, private_key: str, passphrase: str = None):
  key = gk.import_private_key(private_key, passphrase)
  cipher = PKCS1_OAEP.new(key)
  decrypted_data = cipher.decrypt(data)
  return decrypted_data.decode('utf-8')

def encrypt_object(object, public_key: str):
  for i in object:
    k = 0
    if i != 'userpublickey':
      if type(object[i]) is list:
        while k < len(object[i]):
          object[i][k] = encrypt_data(object[i][k], gk.get_public_key(public_key))
          k += 1
      elif type(object) is set:
        encrypt_object(object, public_key)
      else:
        object[i] = encrypt_data(object[i], gk.get_public_key(public_key))

def decrypt_object(object, private_key: str, passphrase: str = None):
  for i in object:
    k = 0
    if i != 'userpublickey':
      if type(object[i]) is list:
        while k < len(object[i]):
          object[i][k] = decrypt_data(object[i][k], gk.get_private_key(private_key, passphrase))
          k += 1
      else:
        object[i] = decrypt_data(object[i], gk.get_private_key(private_key, passphrase))