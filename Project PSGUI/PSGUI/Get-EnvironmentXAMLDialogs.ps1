<#	
    .NOTES
    ===========================================================================
        Created on:   	04.07.2016
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Get-EnvironmentXAMLDialogs.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Get-EnvironmentXAMLDialogs
{
    <#
        .Synopsis
        Renames a dialog and its containing functions.        
        .EXAMPLE
        Get-EnvironmentXAMLDialogs
    #>

    Begin
    {
    }
    Process
    {
        Set-Variable -Name Environment_DialogFolder -Value "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\Environment" -Scope Global
        return (Get-ChildItem $Environment_DialogFolder -Directory).Name
    }
    End
    {
    }
}
