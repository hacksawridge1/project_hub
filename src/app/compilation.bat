@echo off
chcp 1251
title Компилятор
mode con cols=80 lines=20
color 0a

echo Надо перед компиляцией удалять файлы настроек

echo:
pyinstaller --onefile --icon="icons\icon.ico" -w main.py
echo:

copy /Y "dist\main.exe" HUB.exe >nul
RD /S /Q "dist"
RD /S /Q "build"
del /Q "main.spec"

echo Компиляция завершена

echo Надо вынести во внешнюю папку data файлы JSON и SQL
echo и подключить файл ресурсов для иконок формы, кнопок

pause >nul