from Crypto.PublicKey import ECC
from Crypto.PublicKey import RSA

private_key = None
public_key = None

def messageCipher(message, recipient_pub_key):
  pass

def generateUserKeys():
  global private_key
  global public_key
  private_key = ECC.generate(curve="p256")
  public_key = private_key.public_key()
  passphrase = b"secret"
  with open("clientprivatekey.pem", "wt") as f:
    data = private_key.export_key(format="PEM",
                          passphrase=passphrase,
                          protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                          prot_params={'iteration_count':131072})
    f.write(data)
  with open("clientpublickey.pem", "wt") as f:
    data = private_key.public_key().export_key(format="PEM")
    f.write(data)

def showUserKeys():
  print(private_key.export_key(format="PEM"))
  print(public_key.export_key(format="PEM"))

def main():
  generateUserKeys()
  

if __name__ == '__main__':
  main()