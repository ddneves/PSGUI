#requires -Version 2 
<#	
        .NOTES
        ===========================================================================
        Created on:   	06.07.2016
        Created by:   	David das Neves
        Version:        0.3
        Project:        PSGUI
        Filename:       ExecByShortcut.ps1
        ===========================================================================
        .DESCRIPTION
        Starts the PSGUI_Manager. Used for starting with a shortcut.
#> 

function Start-PSGUIManager
{
    <#
            .SYNOPSIS
            Starts the PSGUI-Manager, which is included in the module PSGUI

            .EXAMPLE
            Start-PSGUIManager
    #>
    $PSGUIPath =''
    $DirectoriesToSearch = [Environment]::GetEnvironmentVariable('PSModulePath').Split(';')
    foreach ($dir in $DirectoriesToSearch )
    {
        $PSGUIPath = Get-ChildItem -Path $dir -Filter 'PSGUI' -Recurse
        if ($PSGUIPath)
        {
            break
        }
    }

    Open-XAMLDialog -DialogName ('Internal_Start')
    Open-XAMLDialog -DialogName 'PSGUI_Manager' -DialogPath "$($PSGUIPath.FullName)\PSGUI_Manager\"
}

