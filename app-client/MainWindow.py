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
        chat.append(text)
        self.ui.message.setText("")
        self.upMessages()

    def upMessages(self):
        msg = "start\n"
        for i in chat:
            t = datetime.now().strftime("%H:%M:%S")
            msg += (t + ": " + i + "\n")
        self.ui.messages.setText(msg)

    # Открыть список друзей
    def friends(self):
        chat.append("Friends")
        self.upMessages()
        
    # Посмореть уведомления
    def notifications_active(self):
        chat.append("notifications_active")
        self.upMessages()
        
    # Настройки
    def settings(self):
        chat.append("settings")
        self.upMessages()
    
    # Темы
    def theme(self):
        chat.append("theme")
        self.upMessages()

    # Пользователь
    def user(self):
        chat.append("user")
        self.upMessages()
        
    # Профиль
    def profile(self):
        chat.append("profile")
        self.upMessages()
        
    # Меню
    def menu(self):
        chat.append("menu")
        self.upMessages()