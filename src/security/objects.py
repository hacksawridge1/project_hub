from Crypto.Cipher import PKCS1_OAEP
from Crypto.IO import PEM
from Crypto.PublicKey import RSA
import generate_keys
import os
from dotenv import load_dotenv

load_dotenv()

def encryptData(data, recipientPublicKey):
  message = b'asadasds'
  key = RSA.import_key(open(f'{recipientPublicKey}').read())
  cipher = PKCS1_OAEP.new(key)
  encryptedData = cipher.encrypt(message)
  return encryptedData

def decryptData(data, userPrivateKey, passphrase = None):
  key = RSA.import_key(userPrivateKey, passphrase)
  cipher = PKCS1_OAEP.new(key)
  decryptedData = cipher.decrypt(data)
  return decryptedData