::        .NOTES
::        ===========================================================================
::        Created on:   	06.07.2016
::        Created by:   	David das Neves
::        Version:        	0.2
::        Project:        	PSGUI
::        Filename:       	install.bat
::        ===========================================================================
::        .DESCRIPTION
::        Function from the PSGUI module.

@echo off
:: Installation of PSGUI
powershell -ExecutionPolicy ByPass -File "%cd%\InstallPSGUI.ps1"
:: notepad README.md
:: notepad LICENSE
pause