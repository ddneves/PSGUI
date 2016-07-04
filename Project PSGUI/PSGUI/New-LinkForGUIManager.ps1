function New-LinkForGUIManager
{
    <#
        .SYNOPSIS
        Creates the link for the GUIManager
        .EXAMPLE
        New-LinkForGUIManager
    #>
    Write-Host -Object 'Creating Hyperlink'
    $TargetFile = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe" 
    $GUIManagerPath = "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\GUI_Manager\"
    $ShortcutFile = "$env:UserProfile\Desktop\GUI-Manager.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.WorkingDirectory = $GUIManagerPath
    # WindowStyle 1= normal, 3= maximized, 7=minimized
    $Shortcut.WindowStyle = 7
    # Powershell window is hidden.
    #$Shortcut.Arguments=' -windowstyle hidden "' + $GUIManagerPath + 'ExecByShortcut.ps1"'
    $Shortcut.Arguments = ' -windowstyle hidden "Start-GUIManager"'
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.IconLocation = $GUIManagerPath + 'Resources\GUI_Manager.ico'
    $Shortcut.Save()
    Write-Host -Object 'Hyperlink created.' -ForegroundColor Green
}