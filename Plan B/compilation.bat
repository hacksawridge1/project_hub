@echo off
chcp 1251
title ����������
mode con cols=80 lines=20
color 0a

echo ���� ����� ����������� ������� ����� ��������

echo:
pyinstaller --icon="view\img\icon.ico" -w HUB.py
echo:

echo ���������� ���������

echo ���� ������� �� ������� ����� data ����� JSON � SQL
echo � ���������� ���� �������� ��� ������ �����, ������

pause >nul