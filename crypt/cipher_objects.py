from Crypto.Cipher import PKCS1_OAEP
from generate_keys import Crypt

def messageEncrypt(publicKey):
  message = b'You can attack now!'
  key = Crypt.getUserPublicKey(publicKey)
  cipher = PKCS1_OAEP.new(key)
  ciphertext = cipher.encrypt(message)
  return ciphertext

def decryptMessage(privateKey, passphrase, message):
  key = Crypt.getUserPrivateKey(privateKey, passphrase)
  cipher = PKCS1_OAEP.new(key)
  ciphertext = cipher.decrypt(message)
  print(ciphertext)

message = messageEncrypt('../clientpublickey.pem')
decryptMessage('../clientprivatekey.pem', 'secret', message)