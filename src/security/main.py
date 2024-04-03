import generate_keys
import objects
from dotenv import load_dotenv

load_dotenv()

generate_keys.generateAppKeys()
generate_keys.generateUserKeys(passphrase = 'secret')
message = input('Введите сообщение, которое хотите зашифровать:\t')
encryptedMessage = objects.encryptData(str(message), '../../app.pub')
print(objects.decryptData(encryptedMessage, generate_keys.APP_PRIVATE_KEY))