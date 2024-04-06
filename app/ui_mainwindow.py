# -*- coding: utf-8 -*-

################################################################################
## Form generated from reading UI file 'ui_mainwindowywYyIR.ui'
##
## Created by: Qt User Interface Compiler version 6.6.3
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

class Ui_Form(object):
    def setupUi(self, Form):
        if not Form.objectName():
            Form.setObjectName(u"Form")
        Form.resize(734, 643)
        self.users = QListWidget(Form)
        self.users.setObjectName(u"users")
        self.users.setGeometry(QRect(80, 50, 191, 571))
        self.send = QPushButton(Form)
        self.send.setObjectName(u"send")
        self.send.setGeometry(QRect(670, 590, 51, 31))
        self.notifications_active = QPushButton(Form)
        self.notifications_active.setObjectName(u"notifications_active")
        self.notifications_active.setGeometry(QRect(10, 50, 61, 31))
        self.theme = QPushButton(Form)
        self.theme.setObjectName(u"theme")
        self.theme.setGeometry(QRect(10, 130, 61, 31))
        self.friends = QPushButton(Form)
        self.friends.setObjectName(u"friends")
        self.friends.setGeometry(QRect(10, 90, 61, 31))
        self.settings = QPushButton(Form)
        self.settings.setObjectName(u"settings")
        self.settings.setGeometry(QRect(10, 170, 61, 31))
        self.user = QTableView(Form)
        self.user.setObjectName(u"user")
        self.user.setGeometry(QRect(90, 70, 171, 51))
        self.profile = QPushButton(Form)
        self.profile.setObjectName(u"profile")
        self.profile.setGeometry(QRect(10, 600, 61, 24))
        self.menu = QPushButton(Form)
        self.menu.setObjectName(u"menu")
        self.menu.setGeometry(QRect(670, 10, 51, 31))
        self.Name = QLabel(Form)
        self.Name.setObjectName(u"Name")
        self.Name.setGeometry(QRect(10, 10, 631, 21))
        self.messages = QTextBrowser(Form)
        self.messages.setObjectName(u"messages")
        self.messages.setGeometry(QRect(280, 50, 431, 531))
        self.message = QLineEdit(Form)
        self.message.setObjectName(u"message")
        self.message.setGeometry(QRect(280, 590, 381, 31))

        self.retranslateUi(Form)

        QMetaObject.connectSlotsByName(Form)
    # setupUi

    def retranslateUi(self, Form):
        Form.setWindowTitle(QCoreApplication.translate("Form", u"Form", None))
        self.send.setText(QCoreApplication.translate("Form", u"send", None))
        self.notifications_active.setText(QCoreApplication.translate("Form", u"notifications", None))
        self.theme.setText(QCoreApplication.translate("Form", u"theme", None))
        self.friends.setText(QCoreApplication.translate("Form", u"friends", None))
        self.settings.setText(QCoreApplication.translate("Form", u"settings", None))
        self.profile.setText(QCoreApplication.translate("Form", u"profile", None))
        self.menu.setText(QCoreApplication.translate("Form", u"menu", None))
        self.Name.setText(QCoreApplication.translate("Form", u"Name", None))
    # retranslateUi

