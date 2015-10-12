<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       ExecByShortcut.ps1
    ===========================================================================
    .DESCRIPTION
	Starts the GUI_Manager. Used for starting with a shortcut.
#> 

Set-Location $PSScriptRoot
Import-Module 'PSGUI'
Set-Variable -Name GUI_Manager_DialogFolder -Value "$PSScriptRoot\Dialogs" -Scope Global
Set-Variable -Name Internal_DialogFolder -Value "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs" -Scope Global

Open-XAMLDialog -DialogName ('Internal_Start')
Open-XAMLDialog -DialogName 'GUI_Manager' -DialogPath "$PSScriptRoot\"