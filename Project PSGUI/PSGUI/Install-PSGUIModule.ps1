<#	
    .NOTES
    ===========================================================================
        Created on:   	11.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Install-PSGUIModule.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Install-PSGUIModule
{
    <#
        .SYNOPSIS
        Re/Installs the Module PSGUI
        .EXAMPLE
        Install-PSGUIModule
    #>
    [CmdletBinding()]
    Param
    (
        #Flag to cleanup previous data
        [switch]
        $CleanUpPreviousData = $false
    )
    $DestinationPath = ""
    if ((Test-Path -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI") -and $CleanUpPreviousData)
    {
        Remove-Item -Path "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI" -Recurse -Verbose
        $DestinationPath = "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI"
    } 
    else
    {
        $DestinationPath = "$env:UserProfile\Documents\WindowsPowerShell\Modules"
    }
    if (Get-Module PSGUI)
    {
        Remove-Module PSGUI -Verbose
    }
    Copy-Item '.\PSGUI'  -Destination $DestinationPath -Recurse -Force
    
    Import-Module PSGUI -Verbose
}
