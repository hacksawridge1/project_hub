import json

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
            json.dump(data, file)
    
    # Редактирование JSON
    def edit_json(self, new_data):
        existing_data = x.read_json(self)
        existing_data.update(new_data)
        with open('settings.json', 'w') as file:
            json.dump(existing_data, file)
    
    # Удаление JSON
    def delete_json_item(self, key):
        existing_data = x.read_json(self)
        if key in existing_data:
            del existing_data[key]
            with open('settings.json', 'w') as file:
                json.dump(existing_data, file)
        else:
            print(f"Key '{key}' not found in the JSON data.")    

#x = Json()
#y = x.read_json()
#print(y)
#x.create_json(y)
#x.edit_json(y)
#x.delete_json_item(y)
