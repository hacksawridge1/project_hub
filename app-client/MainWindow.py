from PySide6.QtWidgets import QApplication, QMainWindow
from ui_mainwindow import Ui_MainWindow

messages = []

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.ui = Ui_MainWindow()
        self.ui.setupUi(self)
        
        self.ui.send.clicked.connect(self.hello) # Надо добавить кнопку
        
        #self.ui.notifications_active.connect(self.notifications_active) # Уведомления
        #self.ui.settings.connect(self.settings) # Настройки
        #self.ui.theme.connect(self.theme) # Темы
        #self.ui.user.connect(self.user) # Пользователь
        #self.ui.find.connect(self.find) # Поиск
        #self.ui.profile.connect(self.profile) # Профиль
        #self.ui.menu.connect(self.menu) # Меню
        
        
        
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




    #self.ui.notifications_active.connect(self.notifications_active) # Уведомления
    #self.ui.settings.connect(self.settings) # Настройки
    #self.ui.theme.connect(self.theme) # Темы
    #self.ui.user.connect(self.user) # Пользователь
    #self.ui.find.connect(self.find) # Поиск
    #self.ui.profile.connect(self.profile) # Профиль
    #self.ui.menu.connect(self.menu) # Меню