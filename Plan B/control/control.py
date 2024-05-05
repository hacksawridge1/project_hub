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
    setName =           Signal(str)
    setIP =             Signal(str)
    
    searchUsers =       Signal(str) # Поиск по пользователям
    settings =          Signal(str) # Настройки
    notifications =     Signal(str) # Уведомления
    chats =             Signal(str) # Чаты
    friends =           Signal(str) # Друзья
    folders =           Signal(str) # Папки
    theme =             Signal(str) # Тема
    listUsers =         Signal(str) # Список пользователей (По отдельности)
    profile =           Signal(str) # Профиль пользователя
    titleChat =         Signal(str) # Заголовок чата
    call =              Signal(str) # Набрать
    searchChat =        Signal(str) # Искать по чату
    menu =              Signal(str) # Меню
    entryField =        Signal(str) # Поле ввода
    attachFile =        Signal(str) # Прикрепить файл
    send =              Signal(str) # Кнопка отправить

    # Слоты
    @Slot(str)
    def loadWindow(self, username):
        self.model.username = username
        self.engine.load(self.view.mainWindow)
        self.setName.emit(self.model.username)
        self.setIP.emit(self.model.ip)
    
    
    
    @Slot(str)
    def searchUsersButton(self):
        print("searchUsersButton")
    
    @Slot(str)
    def settingsButton(self):
        print("settingsButton")
    
    @Slot(str)
    def notificationsButton(self):
        print("notificationsButton")
    
    @Slot(str)
    def chatsButton(self):
        print("chatsButton")
    
    @Slot(str)
    def friendsButton(self):
        print("friendsButton")
    
    @Slot(str)
    def folders(self):
        print("folders")
    
    @Slot(str)
    def themeButton(self):
        print("themeButton")
    
    @Slot(str)
    def listUsersButton(self):
        print("listUsersButton")
    
    @Slot(str)
    def profileButton(self):
        print("profileButton")
    
    @Slot(str)
    def titleChatButton(self):
        print("titleChatButton")
    
    @Slot(str)
    def callButton(self):
        print("callButton")
    
    @Slot(str)
    def searchChatButton(self):
        print("searchChatButton")
    
    @Slot(str)
    def menuButton(self):
        print("menuButton")
    
    @Slot(str)
    def entryFieldButton(self):
        print("entryFieldButton")
    
    @Slot(str)
    def attachFileButton(self):
        print("attachFileButton")
    
    @Slot(str)
    def sendButton(self):
        print("sendButton")