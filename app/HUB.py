__author__ = "Maxim"

import sys

from PySide6.QtWidgets import QApplication, QMainWindow
from control.control import MainWindow

if __name__ == '__main__':
    app = QApplication()
    window = MainWindow()
    window.show()
    sys.exit(app.exec())