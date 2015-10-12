<#	
    .NOTES
    ===========================================================================
        Created on:   	08.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI - GUI_Manager
        Filename:       DEV_ExecMyForm.ps1
    ===========================================================================
    .DESCRIPTION
        DEV purpose - reloads and reinstalls project and restarts it afterwards.
#> 

#===========================================================================
#region global variables for later use
Set-Location "$PSScriptRoot\Project PSGUI\"
Set-Variable -Name GUI_Manager_DialogFolder -Value "$PSScriptRoot\Project PSGUI\GUI_Manager\Dialogs" -Scope Global
Set-Variable -Name Internal_DialogFolder -Value "$env:UserProfile\Documents\WindowsPowerShell\Modules\PSGUI\Dialogs" -Scope Global

#endregion
#===========================================================================
    

#===========================================================================
#region LoadingFunctions
$cleanup=$true
if ($cleanup)
{
    . .\PSGUI\Install-PSGUIModule.ps1
    Install-PSGUIModule
}

#endregion
#===========================================================================

#===========================================================================
#Loading XamlDialog
#Open-XAMLDialog -DialogName ('Internal_Start') 
#create- 
Open-XAMLDialog -DialogName 'GUI_Manager' -DialogPath "$PSScriptRoot\Project PSGUI\GUI_Manager" 

#This function would only create the objects
#It will be very helpful to generate the functions in the events.
#Open-XAMLDialog -DialogName "PSGUI" # -OnlyCreateVariables

#===========================================================================

#Get-Item "C:\Users\pSyKo\OneDrive\_Projekte\PS\ExtLog\ExtLog.ps1" | Import-Module
#$WriteLogFilePath = "c:\Temp\test2.log"



