# Функции клиентской части месседжера
# Отправка логина пароля
# Принять список комнат
# Обновить чат
# Отправить сообщение
def hello(self):
    text = self.ui.text.text()
    messages.append(text)
    temp = ""
    for i in messages:
        temp = temp + i + "\n"
    self.ui.chat.setText(temp)
# Сохранить чат
# Создать комнату
# Добавить/удалить участников
# ? - отправить сообщение с вложением
# ? - Скачать файл
