from Crypto.PublicKey import RSA
from dotenv import load_dotenv
import os

load_dotenv()

def generateAppKeys():
  privateKey = RSA.generate(1024)
  
  with open('../../.env', 'w') as env:
    data = privateKey.export_key(format='PEM',
                                 passphrase=None,
                                 pkcs=8,
                                 protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                 prot_params={'iteration_count': 21000})
    env.write(f'APP_PRIVATE_KEY=\"{data.decode("utf-8")}\"')

  with open('../../app.pub', 'wb') as f:
    data = privateKey.public_key().export_key(format='PEM')
    f.write(data)

def getAppKey():
  return os.getenv('APP_PRIVATE_KEY')[2:-1]

def generateUserKeys(passphrase = "secret"):
  privateKey = RSA.generate(1024)

  with open("../../client.pem", "wb") as f:
    data = privateKey.export_key(format='PEM',
                                  passphrase=passphrase,
                                  pkcs=8,
                                  protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                  prot_params={'iteration_count':21000})
    f.write(data)
    
  with open("../../client.pub", "wb") as f:
    data = privateKey.public_key().export_key(format="PEM")
    f.write(data)

def getPrivateKey(privateKey, passphrase):
  try:
    return RSA.import_key(open(privateKey).read(), passphrase)
  except:
    return RSA.import_key(privateKey, passphrase)
    

def getPublicKey(publicKey):
  return RSA.import_key(open(f'{publicKey}').read())