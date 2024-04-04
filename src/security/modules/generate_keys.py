from Crypto.PublicKey import RSA
from dotenv import load_dotenv

load_dotenv()

APP_PRIVATE_KEY = None
APP_PUBLIC_KEY = None

def generate_app_keys():
  private_key = RSA.generate(1024)

  global APP_PRIVATE_KEY
  global APP_PUBLIC_KEY
  privateKeyInBytes = private_key.export_key(format='PEM',
                                    passphrase=None,
                                    pkcs=8,
                                    protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                    prot_params={'iteration_count': 21000})
  APP_PRIVATE_KEY =  f"{privateKeyInBytes.decode('utf-8')}"
  public_key_in_bytes = private_key.public_key().export_key(format='PEM')
  APP_PUBLIC_KEY = f"{public_key_in_bytes.decode('utf-8')}"

  # with open('../../.env', 'w') as env:
  #   data = private_key.export_key(format='PEM',
  #                                passphrase=None,
  #                                pkcs=8,
  #                                protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
  #                                prot_params={'iteration_count': 21000})
  #   env.write(f'APP_PRIVATE_KEY=\"{data.decode("utf-8")}\"')

  with open('../../app.pub', 'wb') as f:
    data = private_key.public_key().export_key(format='PEM')
    f.write(data)


def generate_user_keys(passphrase = "secret"):
  private_key = RSA.generate(1024)

  with open("../../client.pem", "wb") as f:
    data = private_key.export_key(format='PEM',
                                  passphrase=passphrase,
                                  pkcs=8,
                                  protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                  prot_params={'iteration_count':21000})
    f.write(data)
    
  with open("../../client.pub", "wb") as f:
    data = private_key.public_key().export_key(format="PEM")
    f.write(data)

def get_private_key(private_key, passphrase = None):
  try:
    key = RSA.import_key(open(private_key).read(), passphrase)
  except:
    key = RSA.import_key(private_key, passphrase)
  return key.export_key(format='PEM')

def get_public_key(public_key):
  try:
    key = RSA.import_key(open(public_key).read())
  except:
    key = RSA.import_key(public_key)
  return key.public_key().export_key(format="PEM").decode('utf-8')

def import_private_key(private_key, passphrase):
  try:
    return RSA.import_key(open(private_key).read(), passphrase)
  except:
    return RSA.import_key(private_key, passphrase)
  
def import_public_key(public_key):
  try:
    return RSA.import_key(open(public_key).read())
  except:
    return RSA.import_key(public_key)