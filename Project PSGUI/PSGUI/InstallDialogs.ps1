<#	
    .NOTES
    ===========================================================================
        Created on:   	11.10.2015
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

$DialogPath = "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\"

Set-Location $PSScriptRoot\..\

#region install module
    . .\PSGUI\Install-PSGUIModule.ps1
    Install-PSGUIModule
#endregion

#region create shortcut on user-desktop
    $newDialogNames = Get-ChildItem -Path $DialogPath | Select-Object -ExpandProperty Name | Where-Object { ($_ -notlike 'Example_*') -and ($_ -notlike 'Internal_*')}
    foreach ($dialogName in $newDialogNames)
    {
        $TargetFile = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" 
        $GUIManagerPath = "$env:UserProfile\Documents\WindowsPowerShell\GUI_Manager\"
        $ShortcutFile = "$env:UserProfile\Desktop\$dialogName.lnk"
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
        $Shortcut.WorkingDirectory = $GUIManagerPath
        # WindowStyle 1= normal, 3= maximized, 7=minimized
        $Shortcut.WindowStyle = 7
        # Powershell window is hidden.
		"Import-Module PSGUI;Open-XAMLDialog -DialogName $dialogName -DialogPath $DialogPath$dialogName';"
        $Shortcut.Arguments=' -windowstyle hidden "' + "Import-Module PSGUI;Open-XAMLDialog -DialogName $dialogName -DialogPath $DialogPath$dialogName" + '"'
        $Shortcut.TargetPath = $TargetFile
        if (Test-Path -Path "$DialogPath\$dialogName\Resources\$dialogName.ico'")
        {
            $Shortcut.IconLocation = $dialogName + 'Resources\$dialogName.ico'    
        }        
        $Shortcut.Save()
    }
#endregion

Write-Host 'Installation complete.'
Write-Host '==========================================================================='

