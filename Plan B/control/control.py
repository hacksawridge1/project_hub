import sys
from PySide6.QtCore import QObject, Slot, Signal
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

class Control(QObject):
    def __init__(self, model, view):
        QObject.__init__(self)
        self.model = model
        self.view = view

        self.app = QGuiApplication(sys.argv)
        self.engine = QQmlApplicationEngine()
        self.engine.rootContext().setContextProperty("control", self)
        self.engine.load(self.view.authorization)

        sys.exit(self.app.exec())

    # Сигналы
    setName = Signal(str)
    setIP = Signal(str)

    searchUsers = Signal(str) # Поиск по пользователям
    settings = Signal(str) # Настройки
    notifications = Signal(str) # Уведомления
    chats = Signal(str) # Чаты
    friends = Signal(str) # Друзья
    folders = Signal(str) # Папки
    theme = Signal(str) # Тема
    listUsers = Signal(str) # Список пользователей (По отдельности)
    profile = Signal(str) # Профиль пользователя
    titleChat = Signal(str) # Заголовок чата
    call = Signal(str) # Набрать
    searchChat = Signal(str) # Искать по чату
    menu = Signal(str) # Меню
    entryField = Signal(str) # Поле ввода
    attachFile = Signal(str) # Прикрепить файл
    send = Signal(str) # Кнопка отправить

    # Слоты
    @Slot(str)
    def loadWindow(self, username):
        self.model.user.name = username
        self.engine.load(self.view.mainWindow)
        self.setName.emit(self.model.user.name)
        self.setIP.emit(self.model.user.ip)
    
    @Slot(str)
    def searchUsersButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def settingsButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def notificationsButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def chatsButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def friendsButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def folders(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def themeButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def listUsersButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def profileButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def titleChatButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def callButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def searchChatButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def menuButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def entryFieldButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def attachFileButton(self, message):
        print("Python: " + message)
    
    @Slot(str)
    def sendButton(self, message):
        print("Python: " + message)
        