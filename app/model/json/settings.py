import json

# Нужно детализировать

class Json():
    data = {}
    def __init__(self):
        self.data = {
            "name": "undefined",
            "icon": "undefined",
            "last": "undefined"
        }

    # Прочитать JSON
    def read_json(self):
        with open('settings.json', 'r') as file:
            data = json.load(file)
        return data
    
    # Создать JSON
    def create_json(self, data):
        with open('settings.json', 'w') as file:
            # Валидация data
            json.dump(self.data, file)
    
    # Редактирование JSON
    def edit_json(self, new_data):
        existing_data = self.read_json(self)
        existing_data.update(new_data)
        with open('settings.json', 'w') as file:
            json.dump(existing_data, file)
    
    # Удаление JSON
    def delete_json_item(self):
        existing_data = self.read_json(self)
        existing_data.update(self.data)
        with open('settings.json', 'w') as file:
            json.dump(existing_data, file)

# Для локального тестирования (удалить)
#x = Json()
#y = x.read_json()
#print(y)
#x.create_json({"maxim", "avatar", "2024"})
#print(y)
#x.edit_json({"maxim2", "avatar2", "2025"})
#print(y)
#x.delete_json_item(y)
#print(y)
