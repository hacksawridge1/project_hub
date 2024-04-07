# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'viewdaMETt.ui'
##
## Created by: Qt User Interface Compiler version 6.6.2
##
## WARNING! All changes made in this file will be lost when recompiling UI file!
################################################################################

from PySide6.QtCore import (QCoreApplication, QDate, QDateTime, QLocale,
    QMetaObject, QObject, QPoint, QRect,
    QSize, QTime, QUrl, Qt)
from PySide6.QtGui import (QBrush, QColor, QConicalGradient, QCursor,
    QFont, QFontDatabase, QGradient, QIcon,
    QImage, QKeySequence, QLinearGradient, QPainter,
    QPalette, QPixmap, QRadialGradient, QTransform)
from PySide6.QtWidgets import (QApplication, QHeaderView, QLabel, QLineEdit,
    QListWidget, QListWidgetItem, QPushButton, QSizePolicy,
    QTableView, QTextBrowser, QWidget)

class Ui_view(object):
    def setupUi(self, view):
        if not view.objectName():
            view.setObjectName(u"view")
        view.resize(719, 643)
        self.users = QListWidget(view)
        self.users.setObjectName(u"users")
        self.users.setGeometry(QRect(80, 50, 191, 571))
        self.send = QPushButton(view)
        self.send.setObjectName(u"send")
        self.send.setGeometry(QRect(660, 590, 51, 31))
        self.notifications_active = QPushButton(view)
        self.notifications_active.setObjectName(u"notifications_active")
        self.notifications_active.setGeometry(QRect(10, 50, 61, 31))
        self.theme = QPushButton(view)
        self.theme.setObjectName(u"theme")
        self.theme.setGeometry(QRect(10, 130, 61, 31))
        self.friends = QPushButton(view)
        self.friends.setObjectName(u"friends")
        self.friends.setGeometry(QRect(10, 90, 61, 31))
        self.settings = QPushButton(view)
        self.settings.setObjectName(u"settings")
        self.settings.setGeometry(QRect(10, 170, 61, 31))
        self.user = QTableView(view)
        self.user.setObjectName(u"user")
        self.user.setGeometry(QRect(90, 70, 171, 51))
        self.profile = QPushButton(view)
        self.profile.setObjectName(u"profile")
        self.profile.setGeometry(QRect(10, 600, 61, 24))
        self.menu = QPushButton(view)
        self.menu.setObjectName(u"menu")
        self.menu.setGeometry(QRect(660, 10, 51, 31))
        self.Name = QLabel(view)
        self.Name.setObjectName(u"Name")
        self.Name.setGeometry(QRect(10, 10, 631, 21))
        self.messages = QTextBrowser(view)
        self.messages.setObjectName(u"messages")
        self.messages.setGeometry(QRect(280, 50, 431, 531))
        self.message = QLineEdit(view)
        self.message.setObjectName(u"message")
        self.message.setGeometry(QRect(280, 590, 371, 31))

        self.retranslateUi(view)

        QMetaObject.connectSlotsByName(view)
    # setupUi

    def retranslateUi(self, view):
        view.setWindowTitle(QCoreApplication.translate("view", u"Form", None))
        self.send.setText(QCoreApplication.translate("view", u"send", None))
        self.notifications_active.setText(QCoreApplication.translate("view", u"notifications", None))
        self.theme.setText(QCoreApplication.translate("view", u"theme", None))
        self.friends.setText(QCoreApplication.translate("view", u"friends", None))
        self.settings.setText(QCoreApplication.translate("view", u"settings", None))
        self.profile.setText(QCoreApplication.translate("view", u"profile", None))
        self.menu.setText(QCoreApplication.translate("view", u"menu", None))
        self.Name.setText(QCoreApplication.translate("view", u"Name", None))
    # retranslateUi

