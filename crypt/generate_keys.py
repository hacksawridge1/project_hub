from Crypto.PublicKey import RSA
class Crypt:

  def generateUserKeys(passphrase = "secret"):
    privateKey = RSA.generate(1024)

    with open("../client.pem", "wb") as f:
      data = privateKey.export_key(format='PEM',
                                   passphrase=passphrase,
                                   pkcs=8,
                                   protection='PBKDF2WithHMAC-SHA512AndAES256-CBC',
                                   prot_params={'iteration_count':131072})
      f.write(data)
      
    with open("../client.pub", "wb") as f:
      data = privateKey.public_key().export_key(format="PEM")
      f.write(data)

  def getUserPrivateKey(encryptedPrivateKey, passphrase):
    key = RSA.importKey(open(encryptedPrivateKey).read(), passphrase)
    return key
  
  def getUserPublicKey(userPublicKey):
    return RSA.importKey(open(userPublicKey).read())
  
Crypt.generateUserKeys()