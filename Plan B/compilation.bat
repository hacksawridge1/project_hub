@echo off
chcp 1251
title Компилятор
mode con cols=80 lines=20
color 0a

echo Надо перед компиляцией удалять файлы настроек

echo:
pyinstaller --icon="view\img\icon.ico" -w HUB.py
echo:

echo Компиляция завершена

echo Надо вынести во внешнюю папку data файлы JSON и SQL
echo и подключить файл ресурсов для иконок формы, кнопок

pause >nul