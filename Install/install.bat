@echo off
setlocal
rd /s /q c:\Temp\PSGUI\ 
cd %~dp0
Call :UnZipFile "C:\Temp\"  "%~dp0PSGUI.zip"
mkdir c:\Temp\PSGUI\
copy InstallPSGUI.ps1 c:\Temp\PSGUI\
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%Unzip.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%