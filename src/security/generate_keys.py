from Crypto.PublicKey import RSA
from dotenv import load_dotenv
import os

load_dotenv()

#Сначала в env считывается старый файл .pem а потом добавляется новый?????????

def generateAppKeys():
  privateKey = RSA.generate(1024)

  with open('../../app.pem', 'wb') as f:
    data = privateKey.export_key(format='PEM',
                                 passphrase=None,
                                 protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                 prot_params={'iteration_count': 21000})
    f.write(data)
  
  with open('../../.env', 'w') as env:
    env.write("APP_PRIVATE_KEY="+f"\"{open('../../app.pem').read()}\"")

  # os.remove('../../app.pem')
    
    key1 = RSA.import_key(open('../../app.pem').read())
    key2 = RSA.import_key(os.getenv('APP_PRIVATE_KEY'))
    print(key1.export_key(), '\n\n', key2.export_key())

    if key1 == key2:
      print('00000')

  with open('../../apppub.pem', 'wb') as f:
    data = privateKey.public_key().export_key(format='PEM')
    f.write(data)

def getAppPrivateKey():
  return RSA.importKey(os.getenv('APP_PRIVATE_KEY'))

def getAppPublicKey(publicKey):
  return RSA.importKey(open(publicKey).read())

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

def getUserPrivateKey(privateKey, passphrase):
  return RSA.importKey(open(privateKey).read(), passphrase)

def getUserPublicKey(publicKey):
  return RSA.importKey(open(publicKey).read())