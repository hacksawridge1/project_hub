__author__ = "Maxim"

from PySide6.QtWidgets import QApplication, QMainWindow
from datetime import datetime

class Control(QMainWindow):
    def __init__(self, model, view, parent=None):
        super(Control, self).__init__(parent)
        self.model = model
        self.view = view
        self.view.setupUi(self)
        self.upMessages()
        
        self.view.send.clicked.connect(self.send) # Надо добавить кнопку
        self.view.friends.clicked.connect(self.friends)
        self.view.notifications_active.clicked.connect(self.notifications_active)
        self.view.settings.clicked.connect(self.settings) # Настройки +
        self.view.theme.clicked.connect(self.theme) # Темы +
        self.view.user.clicked.connect(self.user) # Пользователь +
        self.view.profile.clicked.connect(self.profile) # Профиль +
        self.view.menu.clicked.connect(self.menu) # Меню +

    # Отправить сообщение
    def send(self):
        text = self.view.message.text()
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": " + text)
        self.view.message.setText("")
        self.upMessages()

    def upMessages(self):
        msg = "НАБРОСОК\n"
        for i in self.model.chat:
            msg += (i + "\n")
        self.view.messages.setText(msg)

    # Открыть список друзей
    def friends(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": Friends")
        self.upMessages()
        
    # Посмореть уведомления
    def notifications_active(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": notifications_active")
        self.upMessages()
        
    # Настройки
    def settings(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": settings")
        self.upMessages()
    
    # Темы
    def theme(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": theme")
        self.upMessages()

    # Пользователь
    def user(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": user")
        self.upMessages()
        
    # Профиль
    def profile(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": profile")
        self.upMessages()
        
    # Меню
    def menu(self):
        t = datetime.now().strftime("%H:%M:%S")
        self.model.chat.append(t + ": menu")
        self.upMessages()