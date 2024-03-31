from PySide6.QtWidgets import QApplication, QMainWindow
from ui_mainwindow import Ui_Form

messages = []

class MainWindow(QMainWindow):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)
        self.ui = Ui_Form()
        self.ui.setupUi(self)
        
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
        text = self.ui.text.text()
        messages.append(text)
        temp = ""
        for i in messages:
            temp = temp + i + "\n"
        self.ui.chat.setText(temp)

    # Открыть список друзей
    def friends(self):
        print("Friends")
        
    # Посмореть уведомления
    def notifications_active(self):
        print("notifications_active")
        
    # Настройки
    def settings(self):
        print("settings")
    
    # Темы
    def theme(self):
        print("theme")

    # Пользователь
    def user(self):
        print("user")
        
    # Профиль
    def profile(self):
        print("profile")
        
    # Меню
    def menu(self):
        print("menu")