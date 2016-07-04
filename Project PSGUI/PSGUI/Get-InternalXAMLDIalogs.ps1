<#	
    .NOTES
    ===========================================================================
        Created on:   	04.07.2016
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Get-InternalXAMLDIalogs.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Get-InternalXAMLDialogs
{
    <#
        .Synopsis
        Renames a dialog and its containing functions.        
        .EXAMPLE
        Get-InternalXAMLDIalogs
    #>

    Begin
    {
    }
    Process
    {
        Set-Variable -Name Internal_DialogFolder -Value "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\Internal" -Scope Global
        return (Get-ChildItem $Internal_DialogFolder -Directory).Name
    }
    End
    {
    }
}
