from Crypto.Cipher import PKCS1_OAEP
import generate_keys
from dotenv import load_dotenv

load_dotenv()

def encryptData(data, publicKey):
  key = generate_keys.importPublicKey(publicKey)
  cipher = PKCS1_OAEP.new(key)
  encryptedData = cipher.encrypt(f'{data}'.encode('utf-8'))
  return encryptedData

def decryptData(data, privateKey, passphrase = None):
  key = generate_keys.importPrivateKey(privateKey, passphrase)
  cipher = PKCS1_OAEP.new(key)
  decryptedData = cipher.decrypt(data)
  return decryptedData.decode('utf-8')