from objects import encrypt_data, decrypt_data, encrypt_object, decrypt_object, find_in_object


# 1. Тест на шифрование массива большого размера
def test_encrypt_large_array():
    large_data = ["abcdefghijklmnopqrstuvwxyz1234567890" * 3 for _ in range(1000)]  # создаем большой список с данными
    encrypted_data = encrypt_data(large_data)  # шифруем данные
    # Добавьте здесь проверки производительности и корректности

# 2. Тест на дешифрование большого объема данных
def test_decrypt_large_data():
    large_data = "large_data_to_encrypt" * 1000  # создаем большой объем данных
    encrypted_data = encrypt_data(large_data)  # шифруем данные
    decrypted_data = decrypt_data(encrypted_data)  # дешифруем данные
    # Добавьте здесь проверки производительности и корректности

# 3. Тест на рекурсивное шифрование объектов
def test_recursive_encrypt_object():
    recursive_obj = {"key": "value"}
    recursive_obj["self"] = recursive_obj  # создаем рекурсивный объект
    encrypted_obj = encrypt_object(recursive_obj)  # шифруем объект
    # Добавьте здесь проверки производительности и корректности

# 4. Тест на обработку большого количества данных
def test_process_large_data():
    large_obj = {"key1": ["value1" * 100, "value2" * 100], "key2": {"subkey": 12345}}  # создаем большой объект
    encrypted_obj = encrypt_object(large_obj)  # шифруем объект
    decrypted_obj = decrypt_object(encrypted_obj)  # дешифруем объект
    # Добавьте здесь проверки производительности и корректности

# 5. Тест на поиск в большом объекте
def test_find_in_large_object():
    large_obj = {"key1": {"subkey1": "value1", "subkey2": {"nested": "value2"}}}  # создаем объект
    search_result = find_in_object(large_obj, "value2")  # ищем значение в объекте
    # Добавьте здесь проверки производности и корректности

# Запуск тестов
if __name__ == "__main__":
    test_encrypt_large_array()
    test_decrypt_large_data()
    test_recursive_encrypt_object()
    test_process_large_data()
    test_find_in_large_object()