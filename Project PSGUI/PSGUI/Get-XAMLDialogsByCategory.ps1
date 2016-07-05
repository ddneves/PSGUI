<#	
    .NOTES
    ===========================================================================
        Created on:   	04.07.2016
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Get-XAMLDialogsByCategory.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Get-XAMLDialogsByCategory
{
    <#
        .Synopsis
        Renames a dialog and its containing functions.        
        .EXAMPLE
        Get-XAMLDialogsByCategory
    #>
    [CmdletBinding()]
    Param
    (
        #Name of the dialog
        [Parameter(Mandatory=$true, Position=1)]
        [Alias('Cat')] 
        $Category
    )
    Begin
    {
    }
    Process
    {
        $dialogFolderToSearch = "$($Category)_DialogFolder"
        Set-Variable -Name $dialogFolderToSearch -Value "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs\$Category" -Scope Global
        
        return (Get-ChildItem (Get-Variable -Name $dialogFolderToSearch).Value -Directory).Name
    }
    End
    {
    }
}