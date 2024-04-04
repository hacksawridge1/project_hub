from Crypto.Cipher import PKCS1_OAEP
import security.modules.generate_keys as gk
from dotenv import load_dotenv

load_dotenv()

def encrypt_data(data, public_key):
  key = gk.import_public_key(public_key)
  cipher = PKCS1_OAEP.new(key)
  encrypted_data = cipher.encrypt(f'{data}'.encode('utf-8'))
  return encrypted_data

def decrypt_data(data, private_key, passphrase = None):
  key = gk.import_private_key(private_key, passphrase)
  cipher = PKCS1_OAEP.new(key)
  decrypted_data = cipher.decrypt(data)
  return decrypted_data.decode('utf-8')