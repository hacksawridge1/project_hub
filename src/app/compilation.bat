@echo off
chcp 1251
title ����������
mode con cols=80 lines=20
color 0a

echo ���� ����� ����������� ������� ����� ��������

echo:
pyinstaller --onefile --icon="icons\icon.ico" -w main.py
echo:

copy /Y "dist\main.exe" HUB.exe >nul
RD /S /Q "dist"
RD /S /Q "build"
del /Q "main.spec"

echo ���������� ���������

echo ���� ������� �� ������� ����� data ����� JSON � SQL
echo � ���������� ���� �������� ��� ������ �����, ������

pause >nul