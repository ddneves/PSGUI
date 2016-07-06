@echo off
powershell -ExecutionPolicy ByPass -File "%cd%\InstallPSGUI.ps1"
notepad README.md
notepad LICENSE
pause