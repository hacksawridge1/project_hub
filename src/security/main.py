import generate_keys
import os
import objects
from dotenv import load_dotenv

load_dotenv()

# generate_keys.generateAppKeys()
generate_keys.generateUserKeys(passphrase = 'secret')
message = objects.encryptData('Somemessage', '../../app.pub')
print(message)
print(objects.decryptData(message, os.getenv('APP_PRIVATE_KEY')))
print(os.getenv("APP_PRIVATE_KEY"))