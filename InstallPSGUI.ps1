#requires -Version 2 
<#	
        .NOTES
        ===========================================================================
        Created on:   	04.07.2016
        Created by:   	David das Neves
        Version:        0.2
        Project:        PSGUI
        Filename:       InstallPSGUI.ps1
        ===========================================================================
        .DESCRIPTION
        Installs PSGUI-Module and PSGUI-Manager.
#> 



Write-Host -Object '==========================================================================='
Write-Host -Object 'Starting installation.'

$Location = (Get-Location).Path

$moduleFile = "$Location\Project PSGUI\PSGUI\Install-PSGUIModule.ps1"


#region install module

Write-Host -Object 'Loading Module File.'
.  $moduleFile    
Write-Host -Object 'Re-/Installing PSGUI Module'
Install-PSGUIModule -CleanUpPreviousData -Verbose

#endregion

#region create shortcut on user-desktop

New-LinkForGUIManager

#endregion

Write-Host -Object ' '
Write-Host -Object '==========================================================================='
Write-Host -Object '                        Installation complete.' -ForegroundColor Green
Write-Host -Object '==========================================================================='


