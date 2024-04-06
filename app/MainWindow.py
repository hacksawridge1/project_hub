from PySide6.QtWidgets import QApplication, QMainWindow
from ui_mainwindow import Ui_Form
from chat import chat
from datetime import datetime

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.ui = Ui_Form()
        self.ui.setupUi(self)
        self.upMessages()
        
        self.ui.send.clicked.connect(self.send) # Надо добавить кнопку
        self.ui.friends.clicked.connect(self.friends)
        self.ui.notifications_active.clicked.connect(self.notifications_active)
        self.ui.settings.clicked.connect(self.settings) # Настройки +
        self.ui.theme.clicked.connect(self.theme) # Темы +
        self.ui.user.clicked.connect(self.user) # Пользователь +
        self.ui.profile.clicked.connect(self.profile) # Профиль +
        self.ui.menu.clicked.connect(self.menu) # Меню +

    # Отправить сообщение
    def send(self):
        text = self.ui.message.text()
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": " + text)
        self.ui.message.setText("")
        self.upMessages()

    def upMessages(self):
        msg = "НАБРОСОК\n"
        for i in chat:
            msg += (i + "\n")
        self.ui.messages.setText(msg)

    # Открыть список друзей
    def friends(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": Friends")
        self.upMessages()
        
    # Посмореть уведомления
    def notifications_active(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": notifications_active")
        self.upMessages()
        
    # Настройки
    def settings(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": settings")
        self.upMessages()
    
    # Темы
    def theme(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": theme")
        self.upMessages()

    # Пользователь
    def user(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": user")
        self.upMessages()
        
    # Профиль
    def profile(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": profile")
        self.upMessages()
        
    # Меню
    def menu(self):
        t = datetime.now().strftime("%H:%M:%S")
        chat.append(t + ": menu")
        self.upMessages()