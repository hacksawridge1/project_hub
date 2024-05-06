__author__ = "Maxim"

from model.user import User

class Model():
    def __init__(self):
        self.user = User()
        self.listUsers = []
        self.listMessages = ["Первый тест", "Второй тест"]

    ## ПОЛЬЗОВАТЕЛИ
    # Добавить пользователя
    def addUser(self, user):
        self.listUsers.append(user)
        # Совпадение имен не проверяем, т. к. с сервера будут разные id
    
    # Удалить пользователя (в сообщениях останется unknown)
    def delUser(self, user):
        self.listUsers.remove(user)

    # Смена имени или других данных
    def editUser(self, user):
        # Дописать редактирование
        return user
    
    # Активность пользователя (онлайн/оффлайн)
    def statusUser(self, user, status):
        user.status = status
        return user
    
    # Вывод онлайн-пользователей
    def usersOnline(self):
        online = []
        for user in self.listUsers:
            if user.status:
                online.append(user)
        return online
    
    ## СООБЩЕНИЯ
    # Добавить сообщение
    def addMessage(self, message):
        self.listMessages.append(message)
    
    # Редактировать сообщение (Включает удаление)
    def editMessage(self, message):
        # Дописать редактирование
        return message
    
    # История сообщений
    def actualMessage(self):
        actual = self.listMessages
        # Выборка последних сообщений (20, 50, 100, ..., ?)
        return actual