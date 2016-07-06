#requires -Version 2 
<#	
        .NOTES
        ===========================================================================
        Created on:   	06.07.2016
        Created by:   	David das Neves
        Version:        0.2
        Project:        PSGUI
        Filename:       ExecByShortcut.ps1
        ===========================================================================
        .DESCRIPTION
        Starts the GUI_Manager. Used for starting with a shortcut.
#> 

function Start-GUIManager
{
    <#
            .SYNOPSIS
            Starts the GUI-Manager, which is included in the module PSGUI

            .EXAMPLE
            Start-GUIManager
    #>
    Open-XAMLDialog -DialogName ('Internal_Start')
    Open-XAMLDialog -DialogName 'GUI_Manager' -DialogPath "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\GUI_Manager"
}

