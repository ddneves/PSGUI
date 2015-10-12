<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       InstallPSGUIManager.ps1
    ===========================================================================
    .DESCRIPTION
	Installs PSGUI-Module and PSGUI-Manager.
#> 

Write-Host '==========================================================================='
Write-Host 'Starting installation.'

Set-Location "$PSScriptRoot\..\Project PSGUI\"

#region install module
    . .\PSGUI\Install-PSGUIModule.ps1
    Install-PSGUIModule
#endregion

#region install GUI-Manager
    if (Test-Path -Path "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager")
    {
        Remove-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager" -Recurse    
    } 

    Copy-Item '.\GUI_Manager'  -Destination "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager" -Recurse -Force
#endregion

#region create shortcut on user-desktop
    $TargetFile = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" 
    $GUIManagerPath = "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\"
    $ShortcutFile = "$env:UserProfile\Desktop\GUI-Manager.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.WorkingDirectory = $GUIManagerPath
    # WindowStyle 1= normal, 3= maximized, 7=minimized
    $Shortcut.WindowStyle = 7
    # Powershell window is hidden.
    $Shortcut.Arguments=' -windowstyle hidden "' + $GUIManagerPath + 'ExecByShortcut.ps1"'
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.IconLocation = $GUIManagerPath + 'Resources\GUI_Manager.ico'
    $Shortcut.Save()
#endregion

Write-Host 'Installation complete.'
Write-Host '==========================================================================='

