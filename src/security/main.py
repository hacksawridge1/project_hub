import generate_keys
import os
from dotenv import load_dotenv
import objects

load_dotenv()

generate_keys.generateAppKeys()
generate_keys.generateUserKeys(passphrase = 'secret')
message = objects.encryptData('Somemessage', '../../apppub.pem')
print(message)
print(objects.decryptData(message, os.getenv('APP_PRIVATE_KEY')))
open('../../app.pem').read()