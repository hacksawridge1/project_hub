from Crypto.Cipher import PKCS1_OAEP
from Crypto.IO import PEM
from Crypto.PublicKey import RSA
import generate_keys
import os
from dotenv import load_dotenv

load_dotenv()

def encryptData(data, recipientPublicKey):
  key = generate_keys.getPublicKey(recipientPublicKey)
  cipher = PKCS1_OAEP.new(key)
  encryptedData = cipher.encrypt(f'{data}'.encode('utf-8'))
  return encryptedData

def decryptData(data, userPrivateKey, passphrase = None):
  key = generate_keys.getPrivateKey(userPrivateKey, passphrase)
  cipher = PKCS1_OAEP.new(key)
  decryptedData = cipher.decrypt(data)
  return decryptedData